FROM quay.io/fenicsproject/stable

RUN pwd
RUN apt-get update
RUN apt-get -y install vim zsh neovim python3-neovim
RUN pip3 install black
RUN curl -fLo /home/fenics/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
RUN git clone https://github.com/ttitscher/dotfiles.git
RUN ln -s /home/fenics/dotfiles/zshrc /home/fenics/.zshrc
RUN mkdir /home/fenics/.config/nvim
RUN ln -s /home/fenics/dotfiles/init.vim /home/fenics/.config/nvim/init.vim

RUN nvim +PlugInstall +qall

CMD ["/bin/zsh"]
