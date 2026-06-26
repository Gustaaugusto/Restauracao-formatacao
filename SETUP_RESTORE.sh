#!/usr/bin/env bash
# =============================================================================
# SETUP_RESTORE.sh — Script de restauração do ambiente de desenvolvimento
# Gerado em: 2026-06-26
# Executar em uma instalação limpa de Ubuntu 26.04 WSL2
#
# USO: bash SETUP_RESTORE.sh
# NÃO execute como root. Execute como o usuário normal (otald).
#
# ANTES DE RODAR:
#   1. Coloque suas chaves de API nos placeholders marcados com [INSERIR_AQUI]
#   2. Leia cada seção antes de executar — há etapas manuais (Windows) no início
# =============================================================================

set -euo pipefail

echo ""
echo "======================================================"
echo "  SETUP_RESTORE.sh — Restauração do ambiente"
echo "======================================================"
echo ""

# =============================================================================
# ETAPAS MANUAIS (Windows — fazer ANTES de rodar este script no WSL)
# =============================================================================
# 1. Instalar WSL2 com Ubuntu 26.04:
#      wsl --install -d Ubuntu-26.04
#
# 2. Instalar VS Code:
#      winget install Microsoft.VisualStudioCode
#
# 3. Instalar AutoHotkey v2:
#      winget install AutoHotkey.AutoHotkey
#
# 4. Instalar ffmpeg (Windows, para VoiceOS):
#      winget install Gyan.FFmpeg
#    → Anote o caminho exato do ffmpeg.exe instalado e atualize voice.ahk
#
# 5. Criar pasta C:\temp\ (usada pelo VoiceOS):
#      mkdir C:\temp
#
# 6. Restaurar C:\Dev\VoiceOS\voice.ahk (backup manual ou do repositório)
#    Atualizar FFMPEG_EXE e MIC_NAME no arquivo se necessário.
# =============================================================================

# =============================================================================
# PASSO 1 — Atualizar apt e instalar pacotes do sistema
# =============================================================================
echo "[1/11] Atualizando apt e instalando pacotes do sistema..."

sudo apt update && sudo apt upgrade -y

sudo apt install -y \
  tmux \
  ffmpeg \
  portaudio19-dev \
  pulseaudio-utils \
  alsa-utils \
  python3-pip \
  curl \
  git \
  unzip \
  build-essential \
  pkg-config \
  libssl-dev

echo "  ✓ Pacotes do sistema instalados"

# =============================================================================
# PASSO 2 — Instalar gh CLI (GitHub CLI)
# =============================================================================
echo "[2/11] Instalando gh CLI..."

# Método oficial para Ubuntu
(type -p wget >/dev/null || (sudo apt update && sudo apt install wget -y)) \
  && sudo mkdir -p -m 755 /etc/apt/keyrings \
  && out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
  && cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
  && sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
  && sudo apt update \
  && sudo apt install gh -y

mkdir -p ~/bin
# Criar symlink para ~/bin/gh (necessário para .gitconfig)
ln -sf "$(which gh)" ~/bin/gh

echo "  ✓ gh CLI instalado. Execute 'gh auth login' manualmente após o script."

# =============================================================================
# PASSO 3 — Instalar nvm e Node.js
# =============================================================================
echo "[3/11] Instalando nvm e Node.js..."

export NVM_DIR="$HOME/.nvm"

if [ ! -d "$NVM_DIR" ]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
fi

# Carregar nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Instalar versões usadas
nvm install 20    # lts/iron
nvm install 22    # lts/jod (padrão)
nvm alias default 22

echo "  ✓ Node.js instalado: $(node -v)"

# =============================================================================
# PASSO 4 — Instalar pacotes npm globais
# =============================================================================
echo "[4/11] Instalando pacotes npm globais..."

npm install -g pnpm@11.7.0
npm install -g n8n@2.27.4

# openclaw — instalado globalmente
npm install -g openclaw@2026.6.8

echo "  ✓ Pacotes npm globais instalados"

# =============================================================================
# PASSO 5 — Instalar Rust via rustup
# =============================================================================
echo "[5/11] Instalando Rust via rustup..."

if ! command -v rustc &>/dev/null; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
fi

. "$HOME/.cargo/env"

echo "  ✓ Rust instalado: $(rustc --version)"

# =============================================================================
# PASSO 6 — Instalar Claude Code
# =============================================================================
echo "[6/11] Instalando Claude Code..."

npm install -g @anthropic-ai/claude-code

echo "  ✓ Claude Code instalado: $(claude --version 2>/dev/null || echo 'reinicie o terminal')"

# =============================================================================
# PASSO 7 — Instalar dependência Python do VoiceOS (groq)
# =============================================================================
echo "[7/11] Instalando dependências Python (VoiceOS)..."

pip3 install groq==1.4.0

echo "  ✓ groq instalado"

# =============================================================================
# PASSO 8 — Configurar dotfiles
# =============================================================================
echo "[8/11] Configurando dotfiles..."

# --- ~/.tmux.conf ---
cat > ~/.tmux.conf << 'EOF'
set-hook -g pane-focus-in "run-shell 'tmux display-message -p \"#{session_name}:#{window_index}.#{pane_index}\" > /tmp/voiceos_active_pane'"
EOF

echo "  ✓ ~/.tmux.conf criado"

# --- ~/.gitconfig ---
cat > ~/.gitconfig << 'EOF'
[credential "https://github.com"]
	helper =
	helper = !/home/otald/bin/gh auth git-credential
[credential "https://gist.github.com"]
	helper =
	helper = !/home/otald/bin/gh auth git-credential
EOF

echo "  ✓ ~/.gitconfig criado"

# --- ~/.bashrc — adicionar exports customizados ---
# (Não sobrescreve o .bashrc padrão gerado pelo Ubuntu — apenas adiciona ao final)

if ! grep -q "NVM_DIR" ~/.bashrc 2>/dev/null; then
  cat >> ~/.bashrc << 'BASHRC'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
BASHRC
fi

if ! grep -q "cargo/env" ~/.bashrc 2>/dev/null; then
  echo '. "$HOME/.cargo/env"' >> ~/.bashrc
fi

if ! grep -q "HOME/.local/bin" ~/.bashrc 2>/dev/null; then
  echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
fi

if ! grep -q "HOME/bin" ~/.bashrc 2>/dev/null; then
  echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc
fi

# --- GROQ_API_KEY — NÃO colocar no .bashrc, usar ~/.env ---
# Crie ~/.env e coloque a chave lá:
cat > ~/.env << 'ENVFILE'
# Variáveis de ambiente sensíveis — NÃO commitar este arquivo
GROQ_API_KEY=[INSERIR_AQUI]   # console.groq.com/keys
ENVFILE

echo "  ✓ ~/.env criado (preencha GROQ_API_KEY)"
echo "  IMPORTANTE: adicione 'export \$(grep -s GROQ_API_KEY ~/.env | xargs)' ao ~/.bashrc"
echo "  em vez de expor a chave diretamente no .bashrc"

# --- Adicionar carregamento do ~/.env ao .bashrc ---
if ! grep -q "~/.env" ~/.bashrc 2>/dev/null; then
  cat >> ~/.bashrc << 'BASHRC'

# Carrega variáveis de ambiente sensíveis
if [ -f "$HOME/.env" ]; then
    set -a
    . "$HOME/.env"
    set +a
fi
BASHRC
fi

echo "  ✓ ~/.bashrc atualizado"

# =============================================================================
# PASSO 9 — Configurar Claude Code
# =============================================================================
echo "[9/11] Configurando Claude Code..."

mkdir -p ~/.claude

cat > ~/.claude/settings.json << 'EOF'
{
  "model": "sonnet",
  "enabledPlugins": {
    "rust-analyzer-lsp@claude-plugins-official": true
  },
  "skipDangerousModePermissionPrompt": true,
  "skipWorkflowUsageWarning": true,
  "theme": "dark"
}
EOF

echo "  ✓ ~/.claude/settings.json criado"

# =============================================================================
# PASSO 10 — Clonar projetos do GitHub
# =============================================================================
echo "[10/11] Clonando projetos do GitHub..."

# ATENÇÃO: execute 'gh auth login' antes desta etapa

mkdir -p /mnt/c/Dev

# LifeOS
if [ ! -d "/mnt/c/Dev/Decodificando/Workspace/LifeOS" ]; then
  mkdir -p "/mnt/c/Dev/Decodificando/Workspace"
  git clone https://github.com/Gustaaugusto/LifeOS.git \
    "/mnt/c/Dev/Decodificando/Workspace/LifeOS"
  echo "  ✓ LifeOS clonado"
else
  echo "  ✓ LifeOS já existe"
fi

# ALFRED
if [ ! -d "/mnt/c/Dev/ALFRED" ]; then
  git clone https://github.com/Gustaaugusto/alfred.git \
    "/mnt/c/Dev/ALFRED"
  echo "  ✓ ALFRED clonado"
else
  echo "  ✓ ALFRED já existe"
fi

# openclaw (upstream)
if [ ! -d "/mnt/c/Dev/openclaw" ]; then
  git clone https://github.com/openclaw/openclaw.git \
    "/mnt/c/Dev/openclaw"
  echo "  ✓ openclaw clonado"
else
  echo "  ✓ openclaw já existe"
fi

# tts-rs-fork (upstream)
if [ ! -d "/mnt/c/Dev/tts-rs-fork" ]; then
  git clone https://github.com/ndarilek/tts-rs.git \
    "/mnt/c/Dev/tts-rs-fork"
  echo "  ✓ tts-rs-fork clonado"
else
  echo "  ✓ tts-rs-fork já existe"
fi

# VoiceOS — sem repositório git, restaurar arquivos manualmente
mkdir -p /mnt/c/Dev/VoiceOS
echo ""
echo "  AVISO: VoiceOS não tem repositório Git."
echo "  Restaure manualmente os arquivos:"
echo "    ~/voiceos/voice.py"
echo "    ~/voiceos/transcribe.sh"
echo "    C:\\Dev\\VoiceOS\\voice.ahk"
echo ""

# =============================================================================
# PASSO 11 — Configurar projetos (dependências + .env)
# =============================================================================
echo "[11/11] Configurando projetos..."

# --- LifeOS backend ---
LIFEOS_BACK="/mnt/c/Dev/Decodificando/Workspace/LifeOS/backend"

if [ -d "$LIFEOS_BACK" ]; then
  python3 -m venv "$LIFEOS_BACK/venv_linux"
  "$LIFEOS_BACK/venv_linux/bin/pip" install -r "$LIFEOS_BACK/requirements.txt"
  echo "  ✓ LifeOS backend venv criado e dependências instaladas"

  # Criar .env do backend (preencher manualmente)
  if [ ! -f "$LIFEOS_BACK/.env" ]; then
    cp "$LIFEOS_BACK/.env.example" "$LIFEOS_BACK/.env"
    # Gerar SECRET_KEY automaticamente
    SECRET=$(openssl rand -hex 32)
    sed -i "s/your_secret_key_here_32_byte_hex/$SECRET/" "$LIFEOS_BACK/.env"
    echo "  ✓ LifeOS backend .env criado (SECRET_KEY gerada automaticamente)"
    echo ""
    echo "  AÇÃO MANUAL: preencher em $LIFEOS_BACK/.env:"
    echo "    GOOGLE_CLIENT_ID   → console.developers.google.com"
    echo "    SPOTIFY_CLIENT_ID  → developer.spotify.com"
    echo "    SPOTIFY_CLIENT_SECRET"
  fi
fi

# --- LifeOS frontend ---
LIFEOS_FRONT="/mnt/c/Dev/Decodificando/Workspace/LifeOS/frontend"

if [ -d "$LIFEOS_FRONT" ]; then
  (cd "$LIFEOS_FRONT" && npm install)
  echo "  ✓ LifeOS frontend: npm install concluído"

  if [ ! -f "$LIFEOS_FRONT/.env.local" ]; then
    cp "$LIFEOS_FRONT/.env.example" "$LIFEOS_FRONT/.env.local"
    echo "  ✓ LifeOS frontend .env.local criado"
    echo ""
    echo "  AÇÃO MANUAL: preencher em $LIFEOS_FRONT/.env.local:"
    echo "    NEXT_PUBLIC_GOOGLE_CLIENT_ID"
  fi
fi

# --- ALFRED ---
if [ -d "/mnt/c/Dev/ALFRED" ]; then
  (cd "/mnt/c/Dev/ALFRED" && npm install)
  echo "  ✓ ALFRED: npm install concluído"

  if [ ! -f "/mnt/c/Dev/ALFRED/.env" ]; then
    cp "/mnt/c/Dev/ALFRED/.env.example" "/mnt/c/Dev/ALFRED/.env"
    echo "  ✓ ALFRED .env criado"
    echo ""
    echo "  AÇÃO MANUAL: preencher em /mnt/c/Dev/ALFRED/.env:"
    echo "    ANTHROPIC_API_KEY  → console.anthropic.com"
    echo "    MIMO_API_KEY       → painel MIMO/Xiaomi"
    echo "    TELEGRAM_BOT_TOKEN → @BotFather no Telegram"
    echo "    LIFEOS_JWT_TOKEN   → gerar após subir LifeOS"
    echo "    SPOTIFY_CLIENT_ID / SPOTIFY_CLIENT_SECRET"
  fi
fi

# --- openclaw ---
if [ -d "/mnt/c/Dev/openclaw" ]; then
  (cd "/mnt/c/Dev/openclaw" && npm install)
  echo "  ✓ openclaw: npm install concluído"
fi

# --- lifeos.sh ---
cp ~/SETUP_BACKUP.md /tmp/_backup_ref.md  # só para referência
cat > ~/lifeos.sh << 'LIFEOS'
#!/bin/bash
# LifeOS — Multi-squad launcher
# Uso: bash lifeos.sh [gerencia|claude1|claude2|n8n|all]

PROJECT="/mnt/c/Dev/Decodificando (Programação)/Workspace/LifeOS"

launch_gerencia() {
  local S="gerencia"
  tmux kill-session -t $S 2>/dev/null
  tmux new-session -d -s $S -n "gerente" -x 220 -y 50
  tmux send-keys -t $S:0 "cd \"$PROJECT\" && claude --dangerously-skip-permissions" Enter
  tmux new-window -t $S -n "security"
  tmux send-keys -t $S:1 "cd \"$PROJECT\" && claude --dangerously-skip-permissions" Enter
  tmux new-window -t $S -n "agente-bash"
  tmux send-keys -t $S:2 "cd \"$PROJECT\" && claude --dangerously-skip-permissions" Enter
  tmux new-window -t $S -n "consultor"
  tmux send-keys -t $S:3 "cd \"$PROJECT\" && claude --dangerously-skip-permissions" Enter
  tmux select-window -t $S:0
  echo "  ✓ Squad Gerência — 4 panes"
}

launch_claude1() {
  local S="claude1"
  tmux kill-session -t $S 2>/dev/null
  tmux new-session -d -s $S -n "orch-1" -x 220 -y 50
  tmux send-keys -t $S:0 "cd \"$PROJECT\" && claude --dangerously-skip-permissions" Enter
  local builders=(backend-core backend-infra frontend-architecture frontend-ui tester security)
  for i in "${!builders[@]}"; do
    tmux new-window -t $S -n "${builders[$i]}"
    tmux send-keys -t $S:$((i+1)) "cd \"$PROJECT\" && claude --dangerously-skip-permissions" Enter
  done
  tmux select-window -t $S:0
  echo "  ✓ Squad Claude 1 — 7 panes"
}

launch_claude2() {
  local S="claude2"
  tmux kill-session -t $S 2>/dev/null
  tmux new-session -d -s $S -n "orch-2" -x 220 -y 50
  tmux send-keys -t $S:0 "cd \"$PROJECT\" && claude --dangerously-skip-permissions" Enter
  local builders=(frontend-architecture frontend-ui tester backend-core backend-infra security)
  for i in "${!builders[@]}"; do
    tmux new-window -t $S -n "${builders[$i]}"
    tmux send-keys -t $S:$((i+1)) "cd \"$PROJECT\" && claude --dangerously-skip-permissions" Enter
  done
  tmux select-window -t $S:0
  echo "  ✓ Squad Claude 2 — 7 panes"
}

launch_n8n() {
  local S="n8n"
  tmux kill-session -t $S 2>/dev/null
  tmux new-session -d -s $S -n "orch-n8n" -x 220 -y 50
  tmux send-keys -t $S:0 "cd \"$PROJECT\" && claude --dangerously-skip-permissions" Enter
  local agents=(agente-n8n frontend-ui frontend-architecture backend-core backend-infra)
  for i in "${!agents[@]}"; do
    tmux new-window -t $S -n "${agents[$i]}"
    tmux send-keys -t $S:$((i+1)) "cd \"$PROJECT\" && claude --dangerously-skip-permissions" Enter
  done
  tmux select-window -t $S:0
  echo "  ✓ Squad N8N — 6 panes"
}

ARG="${1:-all}"
echo "  LifeOS — Multi-squad launcher"
case $ARG in
  gerencia) launch_gerencia; tmux attach-session -t gerencia ;;
  claude1)  launch_claude1;  tmux attach-session -t claude1  ;;
  claude2)  launch_claude2;  tmux attach-session -t claude2  ;;
  n8n)      launch_n8n;      tmux attach-session -t n8n      ;;
  all)
    launch_gerencia
    launch_claude1
    launch_claude2
    tmux attach-session -t gerencia
    ;;
  *) echo "  Uso: bash lifeos.sh [gerencia|claude1|claude2|n8n|all]" ;;
esac
LIFEOS

chmod +x ~/lifeos.sh
echo "  ✓ ~/lifeos.sh criado"

# --- VoiceOS scripts ---
mkdir -p ~/voiceos
echo "  AVISO: restaure manualmente ~/voiceos/voice.py e ~/voiceos/transcribe.sh"
echo "         (não há repositório git — fazer backup manual antes do formato)"

# =============================================================================
# Instalar extensões VSCode
# =============================================================================
echo ""
echo "Instalando extensões VS Code..."
echo "(Requer 'code' no PATH — abra o VS Code e tente Remote-WSL primeiro se falhar)"

VS_EXTENSIONS=(
  "anthropic.claude-code"
  "bradlc.vscode-tailwindcss"
  "christian-kohler.path-intellisense"
  "ckolkman.vscode-postgres"
  "cvs0.prismasnippets"
  "cweijan.dbclient-jdbc"
  "cweijan.vscode-postgresql-client2"
  "dbaeumer.vscode-eslint"
  "dsznajder.es7-react-js-snippets"
  "eamodio.gitlens"
  "editorconfig.editorconfig"
  "esbenp.prettier-vscode"
  "formulahendry.auto-rename-tag"
  "formulahendry.code-runner"
  "inferrinizzard.prettier-sql-vscode"
  "leizongmin.node-module-intellisense"
  "ms-ossdata.vscode-pgsql"
  "ms-python.black-formatter"
  "ms-python.debugpy"
  "ms-python.flake8"
  "ms-python.python"
  "ms-python.vscode-pylance"
  "ms-python.vscode-python-envs"
  "ms-toolsai.jupyter"
  "ms-toolsai.jupyter-keymap"
  "ms-toolsai.jupyter-renderers"
  "ms-toolsai.vscode-jupyter-cell-tags"
  "ms-toolsai.vscode-jupyter-slideshow"
  "ms-vscode.vscode-typescript-next"
  "mtxr.sqltools"
  "oderwat.indent-rainbow"
  "pkief.material-icon-theme"
  "prisma.prisma"
  "qwtel.sqlite-viewer"
  "rangav.vscode-thunder-client"
  "rvest.vs-code-prettier-eslint"
  "usernamehw.errorlens"
  "xabikos.javascriptsnippets"
)

for ext in "${VS_EXTENSIONS[@]}"; do
  code --install-extension "$ext" --force 2>/dev/null || echo "  (skipped: $ext — instale manualmente)"
done

# =============================================================================
# SUMÁRIO FINAL — Ações manuais necessárias
# =============================================================================
echo ""
echo "======================================================"
echo "  INSTALAÇÃO CONCLUÍDA"
echo "  Ações manuais ainda necessárias:"
echo "======================================================"
echo ""
echo "  WINDOWS (antes de tudo):"
echo "  [ ] winget install Gyan.FFmpeg"
echo "  [ ] winget install AutoHotkey.AutoHotkey"
echo "  [ ] Criar C:\\temp\\"
echo "  [ ] Restaurar C:\\Dev\\VoiceOS\\voice.ahk e atualizar FFMPEG_EXE"
echo ""
echo "  WSL:"
echo "  [ ] gh auth login  (autenticar GitHub)"
echo "  [ ] Preencher ~/.env com GROQ_API_KEY"
echo "  [ ] Preencher /mnt/c/Dev/ALFRED/.env"
echo "      → ANTHROPIC_API_KEY, MIMO_API_KEY, TELEGRAM_BOT_TOKEN"
echo "      → SPOTIFY_CLIENT_ID, SPOTIFY_CLIENT_SECRET"
echo "      → LIFEOS_JWT_TOKEN (após subir o backend)"
echo "  [ ] Preencher LifeOS/backend/.env"
echo "      → GOOGLE_CLIENT_ID, SPOTIFY_CLIENT_ID, SPOTIFY_CLIENT_SECRET"
echo "  [ ] Preencher LifeOS/frontend/.env.local"
echo "      → NEXT_PUBLIC_GOOGLE_CLIENT_ID"
echo "  [ ] Restaurar ~/voiceos/voice.py e ~/voiceos/transcribe.sh"
echo "  [ ] source ~/.bashrc"
echo ""
echo "  VERIFICAÇÃO:"
echo "  [ ] node -v           → v22.x"
echo "  [ ] claude --version  → 2.x"
echo "  [ ] rustc --version   → 1.96+"
echo "  [ ] tmux -V           → 3.x"
echo "  [ ] python3 --version → 3.14"
echo "  [ ] bash ~/lifeos.sh  → sobe squads"
echo ""
echo "  Referência: ~/SETUP_BACKUP.md"
echo ""
