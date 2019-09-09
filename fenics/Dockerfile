FROM quay.io/fenicsproject/dev

RUN apt-get update
RUN apt-get -y install zsh neovim silversearcher-ag python3-venv trash-cli



# install plugged stuff via vim
USER fenics

RUN pip3 install --no-cache --user black jedi neovim==0.3.1

RUN git clone https://github.com/ttitscher/dotfiles.git

ADD rm_whitelist.py .
ADD whitelist.txt .

RUN mkdir ~/.config/nvim
RUN ln -s ~/dotfiles/init.vim ~/.config/nvim/init.vim
#ADD init.vim .config/nvim/init.vim

RUN ln -s ~/dotfiles/zshrc ~/.zshrc
RUN curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

RUN nvim +PlugInstall +qall

RUN ./rm_whitelist.py ~/.fzf



USER root
CMD ["/bin/zsh"]


