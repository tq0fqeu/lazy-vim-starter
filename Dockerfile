FROM fedora:41

ARG NODEJS_VERION=lts

WORKDIR /root

RUN <<EOF
  # Install dependencies
  dnf update -y
  dnf copr enable atim/lazygit -y
  dnf install git lazygit fd fzf ripgrep gcc g++ lua5.1 luarocks curl wget procps neovim -y --setopt=install_weak_deps=False

  # Install Node.js
  export NVS_HOME="$HOME/.nvs"
  export NVS_SHELL_PROFILE="$HOME/.bashrc"
  git clone https://github.com/jasongin/nvs "$NVS_HOME"
  . "$NVS_HOME/nvs.sh" install
  nvs add $NODEJS_VERION
  nvs link $NODEJS_VERION

  npm install -g neovim prettier eslint typescript typescript-language-server diagnostic-languageserver eslint_d

  git clone https://github.com/tq0fqeu/lazy-vim-starter ~/.config/nvim
EOF

ENTRYPOINT [ "bash" ]
