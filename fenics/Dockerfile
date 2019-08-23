FROM quay.io/fenicsproject/dev

RUN apt-get update
RUN apt-get -y install vim zsh neovim python3-neovim

RUN git clone https://github.com/ttitscher/dotfiles.git



# install plugged stuff via vim
USER fenics
RUN ln -s ~/dotfiles/zshrc ~/.zshrc
RUN ln -s /home/fenics/dotfiles/vimrc_test /home/fenics/.vimrc
#RUN vim +'PlugInstall --sync' +qa

RUN mkdir /home/fenics/.config/nvim
RUN ln -s /home/fenics/dotfiles/init.vim /home/fenics/.config/nvim/init.vim
#
#

#RUN pip3 install black
USER root
CMD ["/bin/zsh"]


