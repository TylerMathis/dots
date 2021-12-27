# Bare config
bare: make_nvm make_neovim make_zsh make_git done

# Full install
full: bare lang

make_nvm:
	@echo ""; echo ""
	@echo "> Configuring nvm..."
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

make_neovim:
	@echo ""; echo ""
	@echo "> Configuring neovim..."
	./neovim/install-vim-plug.sh
	mkdir -p ${HOME}/.config/nvim
	cp ./neovim/init.vim ${HOME}/.config/nvim
	nvim +PlugInstall +qa

make_zsh:
	@echo ""; echo ""
	@echo "> Configuring zsh..."
	cp ./zsh/zshrc ${HOME}/.zshrc
	mkdir -p ${HOME}/.oh-my-zsh/custom
	cp ./zsh/custom.zsh ${HOME}/.oh-my-zsh/custom

make_git:
	@echo ""; echo ""
	@echo "> Configuring git identity..."
	git config --global user.name "Tyler Hostler-Mathis"
	git config --global user.email "tylerhm.dev@gmail.com"



# Language support
lang: cpp python typescript

cpp:
	@echo ""; echo ""
	@echo "> Configuring C++ language support for neovim..."
	nvim +"CocInstall coc-clangd"

python:
	@echo ""; echo ""
	@echo "> Configuring python language support for neovim..."
	nvim +"CocInstall coc-pyright"

typescript:
	@echo ""; echo ""
	@echo "> Configuring typescript language support for neovim..."
	nvim +"CocInstall coc-tsserver"



# Remove config
clean: clean_neovim clean_ohmyzsh

clean_neovim:
	rm -rf ${HOME}/.config/nvim

clean_ohmyzsh:
	chmod +x ${ZSH}/tools/uninstall.sh
	${ZSH}/tools/uninstall.sh



done:
	@echo ""; echo ""; echo ">"
	@echo "> Done! Restart your shell to apply changes"
	@echo ">"
