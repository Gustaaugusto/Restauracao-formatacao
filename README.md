# Restauracao-formatacao

Backup do ambiente de desenvolvimento para restauração após formatação da máquina.

---

## Arquivos

### `SETUP_BACKUP.md`

Inventário completo do ambiente gerado em **2026-06-26**, antes da formatação. Documenta:

- Sistema base (WSL2, Ubuntu 26.04 LTS, kernel)
- Node.js, nvm e pacotes npm globais
- Python, virtualenvs e dependências
- Rust / Cargo
- Claude Code (versão, settings, plugins)
- Estrutura de todos os projetos em `/mnt/c/Dev/`
- tmux (versão, config, `lifeos.sh`)
- VoiceOS — pipeline completo de transcrição por voz (AutoHotkey → ffmpeg → Groq API → tmux)
- Variáveis de ambiente (apenas nomes — sem valores)
- Pacotes apt instalados manualmente
- Extensões do VS Code
- Dotfiles (`.bashrc`, `.gitconfig`)

> Nenhuma chave de API está exposta neste arquivo. Todos os valores sensíveis aparecem como `[REDACTED]`.

---

### `SETUP_RESTORE.sh`

Script de shell comentado que, executado em uma máquina limpa, reinstala tudo na ordem correta:

1. `apt` — pacotes do sistema (tmux, ffmpeg, portaudio, python3-pip...)
2. `gh` CLI — autenticação com GitHub
3. `nvm` + Node.js v20 e v22
4. Pacotes npm globais (pnpm, n8n, openclaw)
5. Rust via rustup
6. Claude Code
7. Dependências Python do VoiceOS (groq)
8. Dotfiles (`.tmux.conf`, `.gitconfig`, `.bashrc`, `.env`)
9. Settings do Claude Code
10. Clone dos repositórios do GitHub
11. Instalação de dependências por projeto (venv, npm install)
12. Extensões do VS Code

**Antes de rodar:** preencha os placeholders `[INSERIR_AQUI]` com suas chaves de API. O script não executa nenhuma ação destrutiva — pode ser revisado livremente antes de usar.

---

## Projetos documentados

| Projeto | Stack | Repositório |
|---|---|---|
| LifeOS | FastAPI + Next.js + SQLite | github.com/Gustaaugusto/LifeOS |
| ALFRED | Node.js + openclaw + Electron | github.com/Gustaaugusto/alfred |
| openclaw | Node.js monorepo (TypeScript) | github.com/openclaw/openclaw (upstream) |
| tts-rs-fork | Rust | github.com/ndarilek/tts-rs (upstream) |
| VoiceOS | Python + AutoHotkey + Bash | sem repositório — backup manual necessário |

---

## Como usar após formatar

```bash
# 1. No Windows: instalar WSL2, VS Code, AutoHotkey, ffmpeg
# 2. No WSL, clonar este repo:
git clone https://github.com/Gustaaugusto/Restauracao-formatacao
cd Restauracao-formatacao

# 3. Revisar o script e preencher as chaves de API
nano SETUP_RESTORE.sh   # substituir [INSERIR_AQUI]

# 4. Executar
bash SETUP_RESTORE.sh
```

Consulte `SETUP_BACKUP.md` como referência durante a restauração.
