#!/bin/zsh

export ZDOTDIR="${XDG_CONFIG_HOME:-${HOME}/.config}/zsh"

git clone --recursive https://github.com/mkofinas/prezto.git "${ZDOTDIR}/.zprezto"

setopt EXTENDED_GLOB
ln -s "${ZDOTDIR}/.zprezto/bootstrap/zshenv" "${HOME}/.zshenv"
for rcfile in "${ZDOTDIR}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR}/.${rcfile:t}"
done

chsh -s /bin/zsh
