FROM kasmweb/kali-rolling-desktop:1.15.0
USER root

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
WORKDIR $HOME

######### Customize Container Here ###########

# Install OpenVPN, dirsearch ...
RUN apt-get update && \
    apt-get install -y openvpn dirsearch unzip iputils-ping zsh

# Make zsh the default shell
RUN chsh -s $(which zsh)

# Install Starship
RUN wget https://starship.rs/install.sh
RUN chmod +x install.sh
RUN ./install.sh -y

# Add Starship to zshrc
RUN echo 'eval "$(starship init zsh)"' >> .zshrc

# Add Starship Theme
COPY config/starship.toml .config/starship.toml


# Install Hack Nerd Font
RUN wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip
RUN unzip Hack.zip -d /usr/local/share/fonts

# Install ZSH Auto Suggestions
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
# Add the invoke script to ZSH config
RUN echo "source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" >> .zshrc

# Install ZSH Syntax Highlighting
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
# Add the invoke script to ZSH config
RUN echo "source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> .zshrc




######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000~
