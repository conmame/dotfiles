"vi互換をoff
set nocompatible

"起動メッセージを消す
set shortmess+=I

"文字コード設定
set enc=utf-8
set fenc=utf-8
set fencs=utf-8,iso-2021-jp,euc-jp,cp932
set fileformats=unix,mac,dos

"タブ幅
set st=4 ts=4 sw=4
set expandtab

" insertモードを抜けるとIMEオフ
set noimdisable
set iminsert=0 imsearch=0
set noimcmdline
inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>

"Escの2回押しでハイライト消去
nmap <ESC><ESC>; nohlsearch<CR><ESC>

" 前回終了したカーソル行に移動
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

"検索関係
set ignorecase
set smartcase
set hlsearch
set incsearch

"zshぽい補完に
set wildmode=longest,list

"ポップアップメニューをいい感じに
set completeopt=menu,preview,longest,menuone

"補完候補の設定
set complete=.,w,b,u,k

"バックアップを無効に
set nobackup
set noswapfile

"行頭・行末間移動を可能に
set whichwrap=b,s,h,l,<,>,[,]

"いろいろ
set showmatch
set wrapscan
set autoread
filetype on
filetype indent on
filetype plugin on
set virtualedit=all
set ruler

"カラースキーマ
colorscheme darkblue

"カーソル行のカラーを設定
set cursorline

"ステータスラインを常に表示
set laststatus=2

"ステータスライン文字コード表示
set statusline=[%L]\ %t\ %y%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%r%m%{fugitive#statusline()}%=%c:%l/%L 

"シンタックスハイライト
syntax on

"入力中のコマンドをステータスに表示する
set showcmd

"行番号表示
set number

"バックスペースでインデントや改行を削除できるようにする
set backspace=2

"高度なインデント
set smartindent

"インサートモードでカーソル移動
imap <C-j> <Down>
imap <C-k> <Up>
imap <C-h> <Left>
imap <C-l> <Right>

"改行時のコメントアウト自動継続を無効化
autocmd FileType * set formatoptions-=ro

"AS3用シンタックス
au! BufNewFile,BufRead *.as :set filetype=actionscript

" neocomplcache
let g:neocomplcache_enable_at_startup = 1
let g:NeoComplCache_SmartCase=1
let g:NeoComplCache_TagsAutoUpdate=1
let g:NeoComplCache_EnableInfo=1
let g:NeoComplCache_MinSyntaxLength=3
let g:NeoComplCache_SkipInputTime='0.1'

"ユーザ定義の辞書を指定
let g:neocomplcache_dictionary_filetype_lists = {
  \ 'default' : '',
  \ 'scala' : $HOME . '/.vim/dict/scala.dict',
  \ }

if !exists('g:neocomplcache_omni_patterns')                                                                                               
      let g:neocomplcache_omni_patterns = {}
  endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'

" 引数なしで実行したとき、NERDTreeを実行する
let file_name = expand("%:p")
if has('vim_starting') &&  file_name == ""
    autocmd VimEnter * call ExecuteNERDTree()
endif
 
" カーソルが外れているときは自動的にnerdtreeを隠す
function! ExecuteNERDTree()
    "b:nerdstatus = 1 : NERDTree 表示中
    "b:nerdstatus = 2 : NERDTree 非表示中
 
    if !exists('g:nerdstatus')
        execute 'NERDTree ./'
        let g:windowWidth = winwidth(winnr())
        let g:nerdtreebuf = bufnr('')
        let g:nerdstatus = 1 
 
    elseif g:nerdstatus == 1 
        execute 'wincmd t'
        execute 'vertical resize' 0 
        execute 'wincmd p'
        let g:nerdstatus = 2 
    elseif g:nerdstatus == 2 
        execute 'wincmd t'
        execute 'vertical resize' g:windowWidth
        let g:nerdstatus = 1 
 
    endif
endfunction
" 隠しファイルを表示
let NERDTreeShowHidden = 1
noremap <c-e> :<c-u>:call ExecuteNERDTree()<cr>
