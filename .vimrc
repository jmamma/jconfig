"Vim Configuration: Justin Mamamrella 14/03/2012
"
" Movement:
"CTRL a             Move to start of Line
"CTRL e             Move to end of line
"CTRL u             Page up
"CTRL v             Page down
"ESC [[             Start of file
"ESC ]]             EOF
"
" Visual:
"
"Shift Arrow        Enter Visual Mode
"CTRL e             Select next block
"
" Editing:
"CTRL z             Undo
"CTRL r             Redo             
"
" Cutting:
"
"CTRL k             Cut Line(s) or Highlited Text
"CTRL c             Copy Line(s) or Highlited Text
"CTRL u             Uncut (Either Cut or Copy)
"
" Saving Exiting:
"
"CTRL o             Write file
"CTRL x             Exit without writing
"
" Windows:
"CTRL l             Split Horizontally
"CTRL p             Cycle through Windows
"CTRL b             Cycle through Buffers in current Window
"CTRL f             Open File
"
" Search:
"CTRL w             Search
"n                  Next Match

start
colorscheme murphy
highlight Comment ctermbg=White ctermfg=Black

"Turn on Colour Syntax Highlighting
syntax on

"TAB is visually shown as 4 spaces
set tabstop=4
"Number of SPACES inserted when expand tab is on
set softtabstop=4
set expandtab

set showcmd
"Set cursorLine
"set cursorline

" highlight matching brackets
set showmatch

filetype indent on

"AutoComplete
set wildmenu

"search as characters are entered
set incsearch
"highlight search matchs
set hlsearch
"Clear highlited searchs on space
noremap <BS> :nohlsearch<CR>


" Define a Register for Cutting Operations, clear it.

let @q=''

" Define a Temporary Register for Copy Operations

let @t=''

let CursorColumnI = 0 "the cursor column position in INSERT

" Define a Flag for cutting operations 0=cut 1 =copy

let copy=0

autocmd InsertEnter * let CursorColumnI = col('.')
autocmd CursorMovedI * let CursorColumnI = col('.')
autocmd InsertLeave * if col('.') != CursorColumnI | call cursor(0, col('.')+1) | endif

" backspace and cursor keys wrap to previous/next line

"turn off warning sounds.

set noerrorbells
set visualbell

" turn on line count
:set number

" CTRL-i page down CTRL-u page up

noremap <C-v> <PageDown>
inoremap <C-v> <PageDown>

noremap <C-y> <PageUp>
inoremap <C-y> <PageUp>
" backspace in Visual mode deletes selection

vnoremap <BS> d

" enter creates word
"noremap <CR> O<ESC>j<ESC>i
"noremap <BS> d
" Write OUT Save to file

noremap <C-o> :w<CR>
vnoremap <C-o> <ESC>:w<CR>
inoremap <C-o> <ESC>:w<CR>

"delete character on ctrl d

noremap <C-d> x<ESC>i
inoremap <C-d> <ESC>x<ESC>i

" CTRL-x QUIT No Save


noremap <C-x> :q!<CR>
vnoremap <C-x> <ESC>:q!<CR>
inoremap <C-x> <ESC>:q!<CR>

" UNCUT
"noremap <C-u> <ESC>:let @q=@q[1:]<CR>h"qp:let @q=""<CR>i

noremap <C-u> :call SwitchReg(copy)<CR><ESC>"n[p<CR>:let @n=""<CR>i
inoremap <C-u> <ESC>:call SwitchReg(copy)<CR><ESC>"n[p<CR>:let @n=""<CR>i
vnoremap <C-u> <ESC>:call SwitchReg(copy)<CR><ESC>"n[p<CR>:let @n=""<CR>i

"inoremap <C-u> <ESC>:call SwitchReg(copy)<CR>"n[p<CR>i

"inoremap <C-u> <ESC>:call CutFunc2()<CR><ESC>:let @q=@q[1:]<CR>"q[p:let @q=''<CR>i


function SwitchReg(copy)
if a:copy==0
:let @n=@q
:let @q =''
:let @t =''
else 
:let @n=@t
endif

endfunction

function CutFunc2()
"if virtcol('.') > 1
":normal h
"endif
endfunction

"inoremap <C-u> <ESC>h"qpi

"vnoremap <C-u> <ESC>:let @q=@q[1:]<CR>k$"qp:let @q=""<CR>i

" CTRL-C Copy

noremap <C-c> "myy:let @t=@t . @m<CR>:let copy=1<CR>i
vnoremap <C-c> "ty<ESC>:let copy=1<CR>i
inoremap <C-c> <ESC>"myy<ESC>:let @t=@t . @m<CR>:let copy=1<CR>i

" CTRL-k CUT

noremap <C-k> "mdd:let @q = @q . @m<CR>:let copy=0<CR>i
vnoremap <C-k> "qd<ESC>:let copy=0<CR>i
inoremap <C-k> <ESC>"mdd<ESC>:let @q = @q . @m<CR>:let copy=0<CR>i
"inoremap <C-k> <ESC>"Qdd<ESC>i

"Register Store:

vnoremap 1 "Add
"<ESC>: let @a= "n\" . @a<CR>
noremap 1 <ESC>:let @a=@a[1:]<CR>"a[p:let @a=''<CR>i



" Shift + Down enters visual

noremap <S-Up> v<Up>
noremap <S-Down> v<Down>
noremap <S-Left> v<Left>
noremap <S-Right> v<Right>
vnoremap <S-Up> <Up>
vnoremap <S-Down> <Down>
vnoremap <S-Left> <Left>
vnoremap <S-Right> <Right>
inoremap <S-Up> <ESC>v<Up>
inoremap <S-Down> <ESC>v<Down>
inoremap <S-Left> <ESC>v<Left>
inoremap <S-Right> <ESC>v<Right>


:" Map Ctrl-A -> Start of line, Ctrl-E -> End of line
noremap <C-a> 0
noremap <C-e> $
vnoremap <C-a> ggVG 
vnoremap <C-e> $
inoremap <C-a> <ESC>0i
inoremap <C-e> <ESC>$i

" Use CTRL-Q to do what CTRL-V used to do
noremap <C-Q>		<C-V>

" CTRL-F for FILE Explore 
noremap <C-F> :Explore<CR>
inoremap <C-F> <ESC>:Explore<CR> 

" CTRL-Z is Undo; not in cmdline though
noremap <C-Z> u
inoremap <C-Z> <C-O>u
noremap <C-R> :red<CR>i
inoremap <C-R> <ESC>:red<CR>i

" CTRL-l is New Window
noremap <C-l> :vsplit<CR>:bnext<CR>
inoremap <C-l> <ESC>:vsplit<CR>:bnext<CR> 

" Switch Buffers

noremap <C-b>  :bnext<CR>
inoremap <C-b> <ESC>:bnext<CR>

inoremap <C-p> <ESC>:wincmd w<CR>
noremap <C-p> <ESC>:wincmd w<CR>

" CTRL-w where is

noremap <C-w> :/
vnoremap <C-w> <ESC>:/
inoremap <C-w> <ESC>:/

inoremap <C-;> <ESC>:q<CR>

"EOF
