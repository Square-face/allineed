#!/usr/bin/env zsh

cd ~

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    sudo apt-get install ninja-build gettext cmake unzip curl
elif [[ "$OSTYPE" == "darwin"* ]]; then
    xcode-select --install
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    brew install ninja cmake gettext curl
else
    echo "Unknown operating system"
    echo "Please install dependencies by hand"
fi

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
 
# Speed up further compilation
cargo install sccache

RUST_WRAPPER=sccache cargo install cargo-info ripgrep ncspot du-dust exa bat irust nu starship zellij bacon cargo-watch porsmo speedtest-rs gitui wiki-tui mise mprocs bob-nvim

echo "eval \"$(starship init zsh)\"" >> ~/.zshrc
echo "eval \"$(starship init bash)\"" >> ~/.bashrc

# Install nvim
bob install stable
bob use stable

# Install nvim config dependencies
mise use -g node@lts
npm install --global yarn


# Nvim Config
cd .config
git clone https://github.com/Square-face/nvim

# Install plugins
nvim --headless "+Lazy! sync" +qa
