#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

sudo chsh -s $(which zsh) $(whoami)

git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting

git clone https://github.com/spaceship-prompt/spaceship-prompt.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/spaceship-prompt" --depth=1
ln -s "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/spaceship-prompt/spaceship.zsh-theme" "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/spaceship.zsh-theme"

git clone https://github.com/agkozak/zsh-z "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-z"

# Install SSH private key
if [ ! -z "$SSH_PRIVATE_KEY" ]
then
    echo "$SSH_PRIVATE_KEY" > "$HOME/.ssh/id_rsa"
    chmod 600 "$HOME/.ssh/id_rsa"
fi

(cd $SCRIPT_DIR && git submodule init && git submodule update)
bash $SCRIPT_DIR/dotbot-install
