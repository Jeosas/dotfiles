set updatetime=100

"Plugin manager: Plug"
call plug#begin('~/.vim/plugged')

"Git integration"
Plug 'airblade/vim-gitgutter'

"File finder"
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

"Status line"
Plug 'itchyny/lightline.vim'

"Multiple cursors Ctrl+N"
Plug 'terryma/vim-multiple-cursors'

"Surround () [] {}"
Plug 'tpope/vim-surround'

"HTML/CSS/JS Snippets"
Plug 'mattn/emmet-vim'

"Folder Tree"
Plug 'preservim/nerdtree'

"text linting"
Plug 'sheerun/vim-polyglot'

"Close plugin manager"
call plug#end()



""" Key Mapping

"fzf to Ctrl+x"
map <C-x> :Files<CR>

"Map NerdTree to Ctrl+o"
map <C-o> :NERDTreeToggle<CR>



""" Appearance


"Status line config"
set laststatus=2
let g:lightline = {
  \ 'colorscheme': 'powerline',
  \ 'active': {
  \   'left': [['mode', 'paste'], ['gitbranch', 'readonly', 'filename', 'modified']]
  \},
	\}
set noshowmode
set noruler

"hybrid line numbers"
set number relativenumber

"set tabs to have 4 spaces"
set ts=2

"set autoindent"
set autoindent

"show matchong () [] {}"
set showmatch

"enable python highlighting"
let python_highlight_all = 1

