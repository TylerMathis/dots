# Bare config
bare: make_neovim

# Full install
full: bare full_lang


make_neovim:
	@echo ""; echo ""
	@echo "> Configuring neovim..."
	./neovim/install-vim-plug.sh
	mkdir -p ${HOME}/.config/nvim
	cp ./neovim/init.vim ${HOME}/.config/nvim
	nvim +PlugInstall +qa



# Language support
full_lang: cpp python typescript

cpp:
	@echo ""; echo ""
	@echo "> Configuring C++ language support for neovim..."
	nvim +"CocInstall coc-clangd" +qa

python:
	@echo ""; echo ""
	@echo "> Configuring python language support for neovim..."
	nvim +"CocInstall coc-pyright" +qa

typescript:
	@echo ""; echo ""
	@echo "> Configuring typescript language support for neovim..."
	nvim +"CocInstall coc-tss" +qa



# Remove config
clean: clean_neovim

clean_neovim:
	rm -rf ${HOME}/.config/nvim

