# 🚀 TS-IDE.nvim (Neovim 0.11 Starter) 

A high-performance, developer-focused Neovim configuration built for **Node.js**, **TypeScript**, and **Decentralized Systems** development. This setup leverages the native APIs of **Neovim 0.11** to provide a lightning-fast IDE experience without the bloat.

---

## ✨ Key Features

* **Native LSP (Neovim 0.11):** Uses the latest `vim.lsp.config` for zero-lag intelligence.
* **AI Pair Programming:** Full GitHub Copilot integration (Ghost text + Interactive Chat Agent).
* **Safe-Mode Toggles:** Terminal and File Explorer shortcuts are strictly bound to **Normal Mode** to prevent accidental triggers while typing.
* **Fuzzy Search:** Powered by Telescope for instant file and text discovery.
* **Modern UI:** Beautifully themed with **TokyoNight**, including Git status signs and Treesitter syntax highlighting.
* **Integrated Terminal:** Toggleable horizontal terminal for `npm` scripts and `git` commands.

---

## 📋 Prerequisites

Before installing, ensure you have the following on your system (Optimized for Linux/Ubuntu/Mint):

* **Neovim v0.11.0+** (Required for native LSP config)
* **Ripgrep:** For Telescope's live grep (`sudo apt install ripgrep`)
* **Build-essential:** For Treesitter parsers (`sudo apt install build-essential`)
* **Node.js & npm:** For Language Servers

---

## 📥 Installation

1.  **Backup your current config:**
    ```bash
    mv ~/.config/nvim ~/.config/nvim.backup
    mv ~/.local/share/nvim ~/.local/share/nvim.backup
    ```

2.  **Clone this repository:**
    ```bash
    git clone [https://github.com/YOUR_USERNAME/ts-ide.nvim](https://github.com/YOUR_USERNAME/ts-ide.nvim) ~/.config/nvim
    ```

3.  **Launch Neovim:**
    ```bash
    nvim
    ```
    *Lazy.nvim will automatically download and install all plugins.*

4.  **Install Language Servers:**
    Inside Neovim, type `:Mason` and install:
    * `ts-ls` (TypeScript/JS)
    * `eslint-lsp`
    * `html-lsp`
    * `css-lsp`

5.  **Authenticate Copilot:**
    Type `:Copilot auth` and follow the browser instructions.

---

## ⌨️ Master Keybindings

The **Leader Key** is set to `Space`.

### 📂 Navigation & UI
| Key | Action |
| :--- | :--- |
| `<leader>e` | Toggle File Explorer (Nvim-Tree) |
| `<leader>t` | Toggle Integrated Terminal |
| `<leader>ff` | Find Files (Fuzzy Search) |
| `<leader>fg` | Live Grep (Search text in project) |
| `Ctrl + s` | **Save File** (Works in all modes) |

### 🤖 AI Agent (Copilot)
| Key | Action |
| :--- | :--- |
| `Ctrl + l` | **Accept** AI Suggestion (Ghost text) |
| `<leader>cc` | Toggle Copilot **Chat Agent** |
| `<leader>ce` | **Explain** selected code (Visual Mode) |

### 🧠 Code Intelligence (LSP)
| Key | Action |
| :--- | :--- |
| `gd` | Go to Definition |
| `K` | Show Documentation (Hover) |
| `<leader>ca` | Code Actions / Quick Fix |
| `<leader>rn` | Smart Rename (Project-wide) |

---

## 🛠️ Technical Philosophy

This configuration uses a `timeoutlen` of `300ms` and strict mode-separation. Unlike standard configurations that can be "noisy," this setup ensures that your typing flow is never interrupted by accidental window toggles. It is designed by a researcher for developers who need a "calm" environment for complex logic.

---

## 🤝 Contributing
Feel free to open issues or PRs if you want to add support for more languages or improve the LSP integration!
