# supertab
http://www.vim.org/scripts/script.php?script_id=1643

```
wget https://www.vim.org/scripts/download_script.php?src_id=21752
1. Download supertab.vmb to any directory.
2. Open the file in vim ($ vim supertab.vmb).
3. Source the file (:so %).
```

# syntastic
https://github.com/vim-syntastic/syntastic

```
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

echo 'execute pathogen#infect()' >> ~/.vimrc

cd ~/.vim/bundle && \
git clone --depth=1 https://github.com/vim-syntastic/syntastic.git
```

# vim-autopep8
https://github.com/tell-k/vim-autopep8
