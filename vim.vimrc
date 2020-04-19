" General
filetype plugin indent on " Enable filetype plugins

" User Interface
set foldcolumn=1 " Add left margin
set ignorecase " Ignore case when searching
set incsearch " Configure search
set number " Enable line numbers
set ruler " Show current position
set smartcase " Enable smart case searching
set so=7 " Scroll when 7 lines from the cursor
set wildmenu " Enable Wild menu

" Colours
highlight LineNr ctermfg=DarkGrey
syntax enable " Enable syntax highlighting

" Fonts
set encoding=utf-8 " Set encoding as UTF-8
set ffs=unix,dos,mac

" Lines, indents and tabs
set ai " Enable auto indent
set backspace=eol,start,indent " Configure backspace
set expandtab " Uses spaces instead of tabs
set shiftwidth=4 " Set auto indent width
set si " Enable smart indent
set smarttab " Enable smart tab
set tabstop=4 " Set tab to 4 spaces
set whichwrap+=<,>,h,l " Automatically wrap left and right

" Status line
set laststatus=2 " Show status line
