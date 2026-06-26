# SETUP_BACKUP.md
> Gerado automaticamente em 2026-06-26. NÃO contém valores de segredos/chaves de API.

---

## 1. Sistema Base

### Distribuição WSL

```
PRETTY_NAME="Ubuntu 26.04 LTS"
NAME="Ubuntu"
VERSION_ID="26.04"
VERSION="26.04 (Resolute Raccoon)"
VERSION_CODENAME=resolute
ID=ubuntu
ID_LIKE=debian
```

- **WSL Version:** WSL2
- **Hostname:** Gusta-PC
- **Usuário:** otald

### Versão do Kernel

```
Linux Gusta-PC 6.6.114.1-microsoft-standard-WSL2 #1 SMP PREEMPT_DYNAMIC Mon Dec  1 20:46:23 UTC 2025 x86_64 GNU/Linux
```

---

## 2. Node.js e Ferramentas JS

### Versão ativa

```
v22.22.3
```

### Versões instaladas via nvm

```
v20.20.2   (lts/iron)
v22.22.3   (default, lts/jod)  ← ATIVA
```

### NVM_DIR

```
/home/otald/.nvm
```

### Pacotes globais npm

```
/home/otald/.nvm/versions/node/v22.22.3/lib
├── corepack@0.34.6
├── n8n@2.27.4
├── npm@10.9.8
├── openclaw@2026.6.8
└── pnpm@11.7.0
```

---

## 3. Python

### Versão

```
Python 3.14.4
pip 25.1.1 (from /usr/lib/python3/dist-packages/pip)
```

### Gerenciador de pacotes

- **pip3** (sistema) — poetry não instalado

### Pacotes globais relevantes (pip3 list)

```
groq==1.4.0
```

### Virtualenvs encontrados

#### `/mnt/c/Dev/Decodificando/Workspace/LifeOS/backend/venv_linux` ← virtualenv Linux ativo

```
alembic==1.18.4
annotated-doc==0.0.4
annotated-types==0.7.0
anyio==4.12.1
argon2-cffi==25.1.0
argon2-cffi-bindings==25.1.0
bcrypt==5.0.0
certifi==2026.6.17
cffi==2.0.0
click==8.3.1
colorama==0.4.6
cryptography==48.0.0
Deprecated==1.3.1
ecdsa==0.19.2
fastapi==0.135.1
greenlet==3.3.2
h11==0.16.0
httpcore==1.0.9
httpx==0.28.1
idna==3.11
limits==5.8.0
Mako==1.3.12
MarkupSafe==3.0.3
packaging==26.2
passlib==1.7.4
pyasn1==0.6.3
pycparser==3.0
pydantic==2.12.5
pydantic_core==2.41.5
python-dotenv==1.2.2
python-jose==3.5.0
python-multipart==0.0.27
rsa==4.9.1
six==1.17.0
slowapi==0.1.9
SQLAlchemy==2.0.48
starlette==0.52.1
typing-inspection==0.4.2
typing_extensions==4.15.0
uvicorn==0.42.0
websockets==15.0.1
```

> Nota: também existe `/mnt/c/Dev/Decodificando/Workspace/LifeOS/backend/venv` (Windows-compat), mas o `venv_linux` é o usado no WSL. O `requirements.txt` canônico está em `backend/requirements.txt`.

---

## 4. Rust / Cargo

### Versões

```
rustc 1.96.0 (ac68faa20 2026-05-25)
cargo 1.96.0 (30a34c682 2026-05-25)
```

### Crates instaladas via `cargo install`

Nenhuma crate extra instalada globalmente. O `~/.cargo/bin/` contém apenas os binários do próprio toolchain Rust (rustc, cargo, rustfmt, clippy, rust-analyzer, etc.).

### Toolchain

Instalado via `rustup` (padrão). Arquivo de configuração: `~/.cargo/env`

---

## 5. Claude Code

### Versão

```
2.1.193 (Claude Code)
```

### `~/.claude/settings.json`

```json
{
  "model": "sonnet",
  "enabledPlugins": {
    "rust-analyzer-lsp@claude-plugins-official": true
  },
  "skipDangerousModePermissionPrompt": true,
  "skipWorkflowUsageWarning": true,
  "theme": "dark"
}
```

### `~/.claude/settings.local.json`

```json
{
  "permissions": {
    "allow": [
      "Bash(pip3 --version)",
      "Bash(pip --version)",
      "Bash(poetry --version)",
      "Bash(rustc --version)",
      "Bash(cargo --version)"
    ]
  }
}
```

### Plugins habilitados

- `rust-analyzer-lsp@claude-plugins-official` — ativo

### Agents (`~/.claude/agents/`)

Diretório não existe (`~/.claude/` não contém pasta `agents/`).

### Agents por projeto

| Projeto | Caminho `.claude/agents/` |
|---|---|
| ALFRED | `/mnt/c/Dev/ALFRED/.claude/` — pasta `.claude` presente, agents não inspecionados |
| LifeOS | `/mnt/c/Dev/Decodificando/Workspace/LifeOS/.claude/` — pasta presente |
| Alfred (Decodificando) | `/mnt/c/Dev/Decodificando/Workspace/Alfred/.claude/` — pasta presente |

---

## 6. Estrutura de Projetos

### `/mnt/c/Dev/` — visão geral

```
/mnt/c/Dev/
├── ALFRED/                         ← Node.js/Electron (openclaw-based)
│   ├── .claude/
│   ├── .git/
│   ├── config/
│   ├── desktop/
│   ├── dist/
│   ├── docs/
│   ├── src/
│   └── workspace/
├── Decodificando/
│   ├── Estudos/
│   └── Workspace/
│       ├── Agentes/
│       ├── Alfred/                 ← Node.js/Electron (clone de ALFRED)
│       │   ├── .claude/
│       │   ├── .git/
│       │   ├── config/
│       │   ├── desktop/
│       │   ├── docs/
│       │   └── src/
│       ├── LifeOS/                 ← Full-stack: FastAPI (backend) + Next.js (frontend)
│       │   ├── .claude/
│       │   ├── .git/
│       │   ├── backend/            ← FastAPI + SQLAlchemy + Alembic
│       │   ├── frontend/           ← Next.js + React + TanStack Query
│       │   ├── tests/
│       │   └── tools/
│       └── piper_tts/              ← TTS local (Piper)
│           ├── espeak-ng-data/
│           └── models/
├── Decodificando (Programação)/
│   └── Workspace/
│       └── LifeOS/                 ← Clone/backup do LifeOS
│           └── .git/
├── VoiceOS/                        ← Pipeline de transcrição por voz
│   ├── voice.ahk
│   ├── voice.py
│   ├── transcribe.sh
│   └── voice_server.py
├── openclaw/                       ← Node.js monorepo (framework)
│   ├── CLAUDE.md
│   ├── apps/
│   ├── packages/
│   ├── src/
│   └── skills/
└── tts-rs-fork/                    ← Rust (fork de tts-rs)
    ├── .git/
    ├── src/
    └── examples/
```

### Detalhes por projeto

| Projeto | Stack Principal | `.claude/` | `CLAUDE.md` | `.env.example` | Git Remote |
|---|---|---|---|---|---|
| ALFRED | Node.js, openclaw, WS | Sim | Não | Sim | `github.com/Gustaaugusto/alfred.git` |
| LifeOS (Decodificando/Workspace) | FastAPI + Next.js + SQLite | Sim | Sim | Sim | `github.com/Gustaaugusto/LifeOS.git` |
| Alfred (Decodificando/Workspace) | Node.js, openclaw | Sim | Não | Sim | `github.com/Gustaaugusto/alfred.git` |
| openclaw | Node.js monorepo, TypeScript | Não | Sim | Sim | `github.com/openclaw/openclaw.git` (upstream) |
| tts-rs-fork | Rust | Não | Não | Não | `github.com/ndarilek/tts-rs.git` (upstream) |
| VoiceOS | Python + AutoHotkey + Bash | Não | Não | Não | local only |

---

## 7. tmux

### Versão

```
tmux 3.6
```

### `~/.tmux.conf`

```bash
set-hook -g pane-focus-in "run-shell 'tmux display-message -p \"#{session_name}:#{window_index}.#{pane_index}\" > /tmp/voiceos_active_pane'"
```

> Este hook rastreia o pane ativo do tmux para o VoiceOS saber onde injetar o texto transcrito.

### `~/lifeos.sh` — conteúdo completo

```bash
#!/bin/bash
# LifeOS — Multi-squad launcher
# Uso: bash lifeos.sh [gerencia|claude1|claude2|n8n|all]
# Sem argumento: sobe todos os squads

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
  echo "    0:gerente  1:security  2:agente-bash  3:consultor"
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
  echo "    0:orch-1  1:backend-core  2:backend-infra  3:frontend-arch"
  echo "    4:frontend-ui  5:tester  6:security"
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
  echo "    0:orch-2  1:frontend-arch  2:frontend-ui  3:tester"
  echo "    4:backend-core  5:backend-infra  6:security"
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
  echo "    0:orch-n8n  1:agente-n8n  2:frontend-ui  3:frontend-arch"
  echo "    4:backend-core  5:backend-infra"
}

ARG="${1:-all}"

echo ""
echo "  LifeOS — Multi-squad launcher"
echo ""

case $ARG in
  gerencia) launch_gerencia; tmux attach-session -t gerencia ;;
  claude1)  launch_claude1;  tmux attach-session -t claude1  ;;
  claude2)  launch_claude2;  tmux attach-session -t claude2  ;;
  n8n)      launch_n8n;      tmux attach-session -t n8n      ;;
  all)
    launch_gerencia
    launch_claude1
    launch_claude2
    echo ""
    echo "  Squads ativos (N8N não sobe por padrão):"
    echo "  tmux attach-session -t gerencia"
    echo "  tmux attach-session -t claude1"
    echo "  tmux attach-session -t claude2"
    echo ""
    echo "  Para subir o N8N quando precisar:"
    echo "  bash ~/lifeos.sh n8n"
    echo ""
    tmux attach-session -t gerencia
    ;;
  *)
    echo "  Uso: bash lifeos.sh [gerencia|claude1|claude2|n8n|all]"
    ;;
esac
```

---

## 8. VoiceOS (Pipeline de Transcrição por Voz)

### Localização dos arquivos

```
Windows:  C:\Dev\VoiceOS\voice.ahk
WSL:      ~/voiceos/voice.py
WSL:      ~/voiceos/transcribe.sh
```

### Fluxo completo

```
[Usuário pressiona CapsLock]
        ↓
AutoHotkey (voice.ahk — Windows)
  - Inicia ffmpeg.exe com -f dshow capturando microfone Logitech G432
  - Limita gravação a 60s (-t 60)
  - Salva em C:\temp\voice.wav
  - CapsLock novamente: mata ffmpeg via taskkill
        ↓
wsl.exe chama ~/voiceos/transcribe.sh
  - Carrega GROQ_API_KEY de ~/.env (se existir)
  - Reconverte WAV via ffmpeg (WSL): voice.wav → voice_fixed.wav
        ↓
Python: ~/voiceos/voice.py
  - Lê GROQ_API_KEY do ambiente
  - Chama Groq API (whisper-large-v3-turbo) para transcrever em PT-BR
  - Se Groq falhar → fallback Whisper local
  - Traduz PT-BR → EN via Groq (llama-3.1-8b-instant)
        ↓
tmux send-keys
  - Lê pane ativo de /tmp/voiceos_active_pane (escrito pelo hook ~/.tmux.conf)
  - Injeta texto traduzido no pane Claude ativo
```

### Microfone configurado

```
Logitech G432 Gaming Headset
Identificador dshow: "Microphone (Logitech G432 Gaming Headset)"
```

### ffmpeg no Windows (via AutoHotkey)

```
C:\Users\OTalD\AppData\Local\Microsoft\WinGet\Packages\
  Gyan.FFmpeg_Microsoft.Winget.Source_8wekyb3d8bbwe\
  ffmpeg-8.1.1-full_build\bin\ffmpeg.exe
```

> Instalado via WinGet: `winget install Gyan.FFmpeg`

### ffmpeg no WSL

```
ffmpeg version 8.0.1-3ubuntu2
/usr/bin/ffmpeg
Instalado via apt
```

### Dependências Python (VoiceOS)

```
groq==1.4.0   (pip3, sistema — não em venv)
```

### Script AutoHotkey (`voice.ahk`) — conteúdo completo

```ahk
; VoiceOS — Atalho global para transcrição por voz
; CapsLock: toggle (pressiona para gravar, pressiona de novo para parar)
; Chama ffmpeg diretamente, sem PowerShell intermediário

#Requires AutoHotkey v2.0
#SingleInstance Force

FFMPEG_EXE := "C:\Users\OTalD\AppData\Local\Microsoft\WinGet\Packages\Gyan.FFmpeg_Microsoft.Winget.Source_8wekyb3d8bbwe\ffmpeg-8.1.1-full_build\bin\ffmpeg.exe"
MIC_NAME := "Microphone (Logitech G432 Gaming Headset)"
WIN_WAV := "C:\temp\voice.wav"
WSL_WAV := "/mnt/c/temp/voice.wav"
VOICE_PY := "/home/otald/voiceos/voice.py"

isRecording := false
ffmpegPid := 0

TranscribeAndInject() {
    if (!FileExist(WIN_WAV)) {
        ToolTip "❌ Arquivo de áudio não foi criado"
        SetTimer () => ToolTip(""), -2000
        return
    }
    ToolTip "⏳ Corrigindo WAV e transcrevendo..."
    try {
        RunWait 'wsl.exe -d Ubuntu /usr/bin/bash /home/otald/voiceos/transcribe.sh', , "Hide"
        ToolTip "✅ Injetado!"
    } catch {
        ToolTip "❌ Erro na transcrição"
    }
    SetTimer () => ToolTip(""), -2000
}

CapsLock:: {
    global isRecording, ffmpegPid
    if (!isRecording) {
        isRecording := true
        try FileDelete WIN_WAV
        Run '"' . FFMPEG_EXE . '" -y -f dshow -i audio="' . MIC_NAME . '" -ar 16000 -ac 1 -t 60 -flush_packets 1 "' . WIN_WAV . '"', , "Hide", &ffmpegPid
        Sleep 500
        ToolTip "🎙️ Gravando... (máx 60s, pressione para parar)"
        SetTimer WatchFfmpeg, 1000
    } else {
        isRecording := false
        SetTimer WatchFfmpeg, 0
        ToolTip "⏳ Finalizando gravação..."
        if (ffmpegPid > 0) {
            try Run "taskkill /PID " . ffmpegPid . " /F", , "Hide"
            ffmpegPid := 0
        }
        Sleep 800
        TranscribeAndInject()
    }
}

WatchFfmpeg() {
    global isRecording, ffmpegPid
    if (!isRecording || ffmpegPid = 0)
        return
    if (!ProcessExist(ffmpegPid)) {
        isRecording := false
        ffmpegPid := 0
        SetTimer WatchFfmpeg, 0
        Sleep 500
        TranscribeAndInject()
    }
}
```

---

## 9. Variáveis de Ambiente

### Tabela consolidada

| Nome da Variável | Onde é Usada | Onde é Definida | Valor |
|---|---|---|---|
| `GROQ_API_KEY` | VoiceOS (voice.py + transcribe.sh) | `~/.bashrc`, `~/.env` (opcional) | [REDACTED] — recuperar em console.groq.com/keys |
| `ANTHROPIC_API_KEY` | ALFRED (fallback AI), openclaw | `ALFRED/.env` | [REDACTED] — recuperar em console.anthropic.com |
| `OPENCLAW_GATEWAY_TOKEN` | openclaw gateway | `openclaw/.env` ou `~/.openclaw/.env` | [REDACTED] — gerar com `openssl rand -hex 32` |
| `LIFEOS_JWT_TOKEN` | ALFRED (API auth) | `ALFRED/.env` | [REDACTED] — gerar após subir LifeOS |
| `LIFEOS_API_URL` | ALFRED | `ALFRED/.env` | `http://127.0.0.1:8000` (local) |
| `TELEGRAM_BOT_TOKEN` | ALFRED | `ALFRED/.env` | [REDACTED] — recuperar em @BotFather |
| `MIMO_API_KEY` | ALFRED (AI primário) | `ALFRED/.env` | [REDACTED] — recuperar no painel MIMO |
| `SPOTIFY_CLIENT_ID` | ALFRED, LifeOS | `ALFRED/.env`, `LifeOS/backend/.env` | [REDACTED] — recuperar em developer.spotify.com |
| `SPOTIFY_CLIENT_SECRET` | ALFRED, LifeOS backend | `ALFRED/.env`, `LifeOS/backend/.env` | [REDACTED] — recuperar em developer.spotify.com |
| `SECRET_KEY` | LifeOS backend | `LifeOS/backend/.env` | [REDACTED] — gerar com `openssl rand -hex 32` |
| `DATABASE_URL` | LifeOS backend | `LifeOS/backend/.env` | `sqlite:///./lifeos.db` (local) |
| `GOOGLE_CLIENT_ID` | LifeOS backend + frontend | `LifeOS/backend/.env`, `LifeOS/frontend/.env.local` | [REDACTED] — recuperar em console.developers.google.com |
| `NEXT_PUBLIC_API_URL` | LifeOS frontend | `LifeOS/frontend/.env.local` | `http://127.0.0.1:8000` |
| `VITE_OPENCLAW_URL` | ALFRED desktop | `ALFRED/desktop/.env` | `http://127.0.0.1:18789` |
| `OPENCLAW_HOME` | openclaw | `ALFRED/.env` | `~/.openclaw` |
| `ASC_KEY_ID` / `ASC_ISSUER_ID` | openclaw iOS (fastlane) | `openclaw/apps/ios/fastlane/.env` | [REDACTED] — App Store Connect |
| `NVM_DIR` | shell | `~/.bashrc` | `/home/otald/.nvm` |
| `PATH` (extensões) | shell | `~/.bashrc` | `$HOME/.local/bin`, `$HOME/bin`, `$HOME/.cargo/env` |

---

## 10. Pacotes do Sistema (apt)

### Pacotes instalados manualmente (`apt-mark showmanual`)

```
alsa-utils
bash
coreutils
coreutils-from-uutils
dash
diffutils
dpkg
ffmpeg
findutils
gnu-coreutils
grep
gzip
hostname
init
libattr1
ncurses-base
ncurses-bin
portaudio19-dev
pulseaudio-utils
python3-pip
rust-coreutils
tar
tmux
ubuntu-minimal
ubuntu-wsl
util-linux
```

> Nota: `portaudio19-dev` é incomum — provavelmente instalado para gravação de áudio Python (VoiceOS).

---

## 11. Extensões VSCode

### VS Code localizado em

```
/mnt/c/Users/OTalD/AppData/Local/Programs/Microsoft VS Code/bin/code
```

### Extensões instaladas

```
anthropic.claude-code
bradlc.vscode-tailwindcss
christian-kohler.path-intellisense
ckolkman.vscode-postgres
cvs0.prismasnippets
cweijan.dbclient-jdbc
cweijan.vscode-postgresql-client2
dbaeumer.vscode-eslint
dsznajder.es7-react-js-snippets
eamodio.gitlens
editorconfig.editorconfig
esbenp.prettier-vscode
formulahendry.auto-rename-tag
formulahendry.code-runner
inferrinizzard.prettier-sql-vscode
leizongmin.node-module-intellisense
ms-ossdata.vscode-pgsql
ms-python.black-formatter
ms-python.debugpy
ms-python.flake8
ms-python.python
ms-python.vscode-pylance
ms-python.vscode-python-envs
ms-toolsai.jupyter
ms-toolsai.jupyter-keymap
ms-toolsai.jupyter-renderers
ms-toolsai.vscode-jupyter-cell-tags
ms-toolsai.vscode-jupyter-slideshow
ms-vscode.vscode-chat-customizations-evaluations
ms-vscode.vscode-typescript-next
mtxr.sqltools
oderwat.indent-rainbow
pkief.material-icon-theme
prisma.prisma
qwtel.sqlite-viewer
rangav.vscode-thunder-client
rvest.vs-code-prettier-eslint
typescriptteam.native-preview
usernamehw.errorlens
xabikos.javascriptsnippets
```

---

## 12. Dotfiles

### `~/.bashrc`

```bash
# ~/.bashrc: executed by bash(1) for non-login shells.

case $- in
    *i*) ;;
      *) return;;
esac

HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s checkwinsize

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
esac

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export PATH="$HOME/.local/bin:$PATH"

# Groq API Key para VoiceOS
export GROQ_API_KEY="[REDACTED]"   # Recuperar em: console.groq.com/keys

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

export PATH="$HOME/bin:$PATH"
. "$HOME/.cargo/env"

# OpenClaw Completion
[ -f "/home/otald/.openclaw/completions/openclaw.bash" ] && source "/home/otald/.openclaw/completions/openclaw.bash"
```

### `~/.bash_aliases`

Arquivo não encontrado (sem aliases customizados separados).

### `~/.gitconfig`

```ini
[credential "https://github.com"]
    helper =
    helper = !/home/otald/bin/gh auth git-credential

[credential "https://gist.github.com"]
    helper =
    helper = !/home/otald/bin/gh auth git-credential
```

> Autenticação GitHub via `gh` CLI. Binário em `~/bin/gh`.

---

## Observações Finais

- **GROQ_API_KEY** estava exposta em texto claro no `~/.bashrc`. Após o formato, adicione ela apenas em `~/.env` (não no .bashrc) e deixe o `transcribe.sh` carregá-la de lá.
- O projeto **VoiceOS** não tem repositório Git — os scripts em `~/voiceos/` e `C:\Dev\VoiceOS\` precisam de backup manual ou criação de repo.
- O caminho do ffmpeg no `voice.ahk` é específico para a versão WinGet instalada — verificar após reinstalar.
- `portaudio19-dev` foi instalado manualmente — provavelmente necessário para algum binding Python de áudio.
