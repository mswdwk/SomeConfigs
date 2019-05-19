" Configuration file for vim
set modelines=0		" CVE-2007-2438

" Normally we use vim-extensions. If you want true vi-compatibility
" remove change the following statements
set nocompatible	" Use Vim defaults instead of 100% vi compatibility
set backspace=2		" more powerful backspacing

" Don't write backup file if vim is being called by "crontab -e"
au BufWrite /private/tmp/crontab.* set nowritebackup nobackup
" Don't write backup file if vim is being called by "chpass"
au BufWrite /private/etc/pw.* set nowritebackup nobackup

let skip_defaults_vim=1
set nu
set ts=4

set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'racer-rust/vim-racer'
Plugin 'rust-lang/rust.vim' " a directory
Plugin 'prabirshrestha/async.vim'
Plugin 'prabirshrestha/vim-lsp'
Plugin 'prabirshrestha/asyncomplete.vim'
Plugin 'prabirshrestha/asyncomplete-lsp.vim'
Plugin 'nerdtree/NERD_tree.vim'
Bundle 'Valloric/YouCompleteMe'
"Bundle 'taglist.vim'
Plugin 'zivyangll/git-blame.vim'
call vundle#end()

if executable('rls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'nightly', 'rls']},
        \ 'whitelist': ['rust'],
        \ })
endif 

filetype on

"" 开启rust的自动reformat的功能
let g:rustfmt_autosave = 1
"" 手动补全和定义跳转
set hidden
"" 这一行指的是你编译出来的racer所在的路径
let g:racer_cmd = "/Users/lijianying/.cargo/bin/racer"
"" 这里填写的就是我们在1.2.1中让你记住的目录
let $RUST_SRC_PATH="/Users/lijianying/rust-lang/rust/src"
let g:racer_experimental_completer = 1
" a basic set up for LanguageClient-Neovim

" << LSP >> {{{

let g:LanguageClient_autoStart = 1
noremap <leader>lcs :LanguageClientStart<CR>

" if you want it to turn on automatically
" let g:LanguageClient_autoStart = 1

let g:LanguageClient_serverCommands = {
    \ 'python': ['pyls'],
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'go': ['go-langserver'] }

noremap <silent> H :call LanguageClient_textDocument_hover()<CR>
noremap <silent> Z :call LanguageClient_textDocument_definition()<CR>
noremap <silent> R :call LanguageClient_textDocument_rename()<CR>
noremap <silent> S :call LanugageClient_textDocument_documentSymbol()<CR>
nnoremap <Leader>s :<C-u>call gitblame#echo()<CR>
" }}}

"let g:ycm_rust_src_path="/Users/lijianying/repo/lark/rust-sdk"
"inoremap <leader>; <C-x><C-o>
let mapleader=";"
nnoremap <leader>d :YcmCompleter GoToDefinitionElseDeclaration<CR>
syntax on
set list
set autoindent
"set expandtab
"set smartindent
set shiftwidth=4
"set tags=tags
set cursorline
set cursorcolumn
"set incsearch
set hlsearch
"set ignorecase
"set ruler
autocmd vimenter * NERDTree
let g:NERDTreeWinSize=23
nmap <F2> :NERDTreeToggle<CR> 
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd VimEnter * wincmd w " default to the right edit area
"set rtp+=~/repo/rust/skim 
