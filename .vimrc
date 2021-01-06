"========================================================
" INSTALL PLUGINS
"========================================================
filetype off
call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'easymotion/vim-easymotion'
Plug 'airblade/vim-gitgutter'
Plug 'terryma/vim-multiple-cursors'
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-rails'
Plug 'flazz/vim-colorschemes'
Plug 'jiangmiao/auto-pairs'
Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-surround'
Plug 'neomake/neomake'
Plug 'tpope/vim-endwise'
Plug 'mbbill/undotree'
Plug 'ryanoasis/vim-devicons'
Plug 'elixir-lang/vim-elixir'
Plug 'janko-m/vim-test'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-fugitive'
Plug 'mxw/vim-jsx'
Plug 'matze/vim-move'
Plug 'carlitux/deoplete-ternjs'
Plug 'KabbAmine/vCoolor.vim'
Plug 'alvan/vim-closetag'
Plug 'kchmck/vim-coffee-script'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'vim-scripts/git-time-lapse'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
if has('nvim')
  Plug 'awetzel/elixir.nvim', { 'do': 'yes \| ./install.sh' }
  Plug 'slashmili/alchemist.vim'
  function! DoRemote(arg)
    UpdateRemotePlugins
  endfunction
  Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
endif
call plug#end()
syntax on
filetype on
filetype indent on
filetype plugin on
set hlsearch
set bs=2
set ai
set ruler
set linespace=1
set gfn=DejaVu\ Sans\ Mono\ for\ Powerline:h13
let g:auto_ctags = 1
set wrap linebreak nolist
set breakindent
set nofoldenable
set tags=./tags;,tags;
set ruler
set number
set wrap linebreak nolist
set expandtab
set tabstop=2 shiftwidth=2 softtabstop=2
set autoindent
set clipboard=unnamed
set splitright
set splitbelow
set ttyfast
set lazyredraw
set laststatus=2
set encoding=utf8
set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types:h11
set background=dark
set textwidth=80
colorscheme bubblegum
" Fix left bar display
hi CursorLineNr guifg=#66afce ctermfg=74 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi CursorLine guifg=NONE ctermfg=NONE guibg=#323232 ctermbg=236 gui=NONE cterm=NONE
hi LineNr guifg=#444444 ctermfg=238 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
" Fix iterm display
if has("nvim")
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
endif
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
"========================================================
" CONFIG CTRLP
"========================================================
if exists("g:ctrlp_user_command")
unlet g:ctrlp_user_command
endif
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\.git$\|\.sass-cache$|\.hg$\|\.svn$\|\.yardoc\|public$\|log$\|tmp$\|node_modules$\|vendor$',
    \ 'file': '\.so$\|\.dat$|\.DS_Store$'
    \ }
"========================================================
" CONFIG AIRLINE
"========================================================
let g:Powerline_symbols = 'fancy'
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
let s:spc = g:airline_symbols.space
function! AirlineInit()
  let g:airline_section_a = airline#section#create(['%{toupper(mode())}'])
  let g:airline_section_b = airline#section#create([''])
  let g:airline_section_z = airline#section#create(['%p%%'])
endfunction
"========================================================
" CONFIG NEOMAKE
"========================================================
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_ruby_enabled_makers = ['rubocop']
"let g:neomake_error_sign = {'text': '💧 ', 'texthl': 'NeomakeWarningMsg'}
"let g:neomake_warning_sign = {'text': '💧 ', 'texthl': 'NeomakeErrorMsg'}
"========================================================
" CONFIG DEOPLETE
"========================================================
if !exists('g:deoplete#omni#input_patterns')
let g:deoplete#omni#input_patterns = {}
endif
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 'ignorecase'
let g:deoplete#sources = {}
let g:deoplete#sources_ = ['buffer','tag']
" <Tab> completion:
" 1. If popup menu is visible, select and insert next item
" 2. Otherwise, if within a snippet, jump to next input
" 3. Otherwise, if preceding chars are whitespace, insert tab char
" 4. Otherwise, start manual autocomplete
imap <silent><expr><Tab> pumvisible() ? "\<C-n>"
\ : (neosnippet#jumpable() ? "\<Plug>(neosnippet_jump)"
\ : (<SID>is_whitespace() ? "\<Tab>"
\ : deoplete#mappings#manual_complete()))
smap <silent><expr><Tab> pumvisible() ? "\<C-n>"
\ : (neosnippet#jumpable() ? "\<Plug>(neosnippet_jump)"
\ : (<SID>is_whitespace() ? "\<Tab>"
\ : deoplete#mappings#manual_complete()))
inoremap <expr><S-Tab>  pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:is_whitespace() "{{{
let col = col('.') - 1
return ! col || getline('.')[col - 1] =~? '\s'
endfunction "}}}
"========================================================
" CONFIG GITGUTTER
"========================================================
"let g:gitgutter_sign_added = '🌱'
"let g:gitgutter_sign_modified = '✨'
"let g:gitgutter_sign_removed = '🐾'
"let g:gitgutter_sign_removed_first_line = '🐾'
"let g:gitgutter_sign_modified_removed = '🐾'
"========================================================
" CONFIG MARKDOWN
"========================================================
let vim_markdown_preview_hotkey='<C-m>'
let vim_markdown_preview_github=1
"========================================================
" CONFIG MISC
"========================================================
let g:indentLine_enabled = 0
" Tmux navigation
let g:tmux_navigator_no_mappings = 1
" Rpsec config
let test#strategy = "neovim"
" Solve vim ESC delay
set timeoutlen=1000 ttimeoutlen=0
if has("autocmd")
  autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
  autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
  autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
  autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
  autocmd VimEnter * call AirlineInit()
  autocmd VimEnter * AirlineTheme bubblegum
  autocmd BufWritePre * StripWhitespace
  autocmd BufWritePost * Neomake
  autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
endif
let g:webdevicons_enable_ctrlp = 1
let g:move_key_modifier = 'C'
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.html.eex,*.html.erb"
"========================================================
" FUNCTIONS
"========================================================
" Update ruby ctags
function! URT()
  return system('ctags -R --languages=ruby --exclude=.git --exclude=log . $(bundle list --paths)')
endfunction
function! UET()
  return system('ctags -R --languages=elixir --exclude=.git --exclude=log .')
endfunction
" Toogle indents
function! IndentGuideToggle()
  let g:indent_guide_displayed = get(g:, 'indent_guide_displayed', '0')
  if g:indent_guide_displayed=='0'
    let g:indent_guide_displayed = '1'
    execute 'IndentLinesEnable'
    set colorcolumn=+1
  else
    let g:indent_guide_displayed = '0'
    execute 'IndentLinesDisable'
    set colorcolumn=0
  endif
endfunction
function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc
"========================================================
" MAPPING VIM-RAILS
"========================================================
map <silent> rj <ESC>:R<CR>
map <silent> rjv <ESC>:RV<CR>
map <silent> rjx <ESC>:RS<CR>
"========================================================
" MAPPING FZF
"========================================================
map <c-p> <ESC>:Files<CR>
map <c-o> <ESC>:Tags<CR>
map <c-h> <ESC>:History<CR>
map <silent> <leader>/ <ESC>:BLines<CR>
map <leader>ag <ESC>:Ag<space>
map <silent> <leader>aa <ESC>:call fzf#vim#ag(expand("<cword>"), fzf#vim#layout(expand("<bang>0")))<cr>
map <c-]> <ESC>:call fzf#vim#tags(expand("<cword>"), fzf#vim#layout(expand("<bang>0")))<cr>
map <silent> <leader>mm <ESC>:Commands<CR>
map rm <ESC>:call fzf#vim#files("app/models/", fzf#vim#layout(expand("<bang>0")))<cr>
map rc <ESC>:call fzf#vim#files("app/controllers/", fzf#vim#layout(expand("<bang>0")))<cr>
map rv <ESC>:call fzf#vim#files("app/views/", fzf#vim#layout(expand("<bang>0")))<cr>
map rs <ESC>:call fzf#vim#files("spec/", fzf#vim#layout(expand("<bang>0")))<cr>
map rf <ESC>:call fzf#vim#files("features/", fzf#vim#layout(expand("<bang>0")))<cr>
"========================================================
" MAPPING NERDTree
"========================================================
map <silent> <leader>ls <ESC>:NERDTreeToggle<CR>
map <silent> <leader>rev :NERDTreeFind<CR>
let NERDTreeMapOpenSplit = 'x'
let NERDTreeMapOpenVSplit = 'v'
"========================================================
" MAPPING RSPEC
"========================================================
map <Leader>tt :TestFile<CR>
map <Leader>ts :TestNearest<CR>
map <Leader>tl :TestLast<CR>
map <Leader>ta :TestSuite<CR>
"========================================================
" MAPPING EASYMOTION
"========================================================
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
map / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
nmap <silent> <tab> <Plug>(easymotion-w)
"========================================================
" MAPPING EASYALIGN
"========================================================
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
"========================================================
" MAPPING GIT
"========================================================
map <silent> gs :Gstatus<CR>
map <silent> gd :Gdiff<CR>
map <silent> gb :Gblame<CR>
map <silent> ghub :Gbrowse<CR>
map <silent> gc! :Gread<CR>
map <silent> gt :call TimeLapse() <cr>
"========================================================
" MAPPING MISC
"========================================================
map <silent> q :q<CR>
map <silent> <leader>urt <ESC>:call URT()<CR>
map <silent> <leader>uet <ESC>:call UET()<CR>
nnoremap <silent> <CR> <ESC>:noh<CR>
map <silent> <leader>q <ESC>:q<CR>
map <silent> <leader>i <ESC>:call IndentGuideToggle()<CR>
map <silent> <leader>' cs'"
map <silent> <leader>" cs"'
map <silent> <leader><leader> <C-^><CR>
map <silent> <leader>u :UndotreeToggle<CR>
map <silent> <space>h <C-W><C-H>
map <silent> <space>j <C-W><C-J>
map <silent> <space>k <C-W><C-K>
map <silent> <space>l <C-W><C-L>
map <space><space> <ESC>:w<CR>
map <silent> <leader>path :let @+=expand("%:p")<CR>
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
noremap <silent> <expr> ^ (v:count == 0 ? 'g^' : '^')
noremap <silent> <expr> $ (v:count == 0 ? 'g$' : '^')
noremap <silent> <leader>n :call NumberToggle()<cr>
map <silent> <leader>cp :VCoolor<cr>
if has("nvim")
  tnoremap <c-e> <C-\><C-n>
end
