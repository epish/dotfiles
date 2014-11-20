no <down> ddp
no <left> <Nop>
no <right> <Nop>
no <up> ddkP
ino <down> <Nop>
ino <left> <Nop>
ino <right> <Nop>
ino <up> <Nop>
vno <down> <Nop>
vno <left> <Nop>
vno <right> <Nop>
vno <up> <Nop>

no Q <Nop>
"NERDTree toggle
nmap <leader>N :NERDTreeToggle<CR>
nmap <Tab> <C-W>l
nmap <S-Tab> <C-W>h

"============== Custom Mappings ===============
" general mapping
nmap <C-S-T> <ESC>:tabprevious<CR>
nmap <C-T> <ESC>:tabnext<CR>
imap <C-S-T> <ESC>:tabprevious<CR>
imap <C-T> <ESC>:tabnext<CR>
"noremap <F7> :set expandtab!<CR>
nmap <Leader>h :tabnew %:h<CR>
nmap <Leader>ff :e ++ff=dos<CR>

"custom comma motion mapping
"nmap di, f,dT,
"nmap ci, f,cT,
"nmap da, f,ld2F,i,<ESC>l "delete argument 
"nmap ca, f,ld2F,i,<ESC>a "delete arg and insert

" delete/insert surrounding characters
noremap ds{ F{xf}x
noremap cs{ F{xf}xi
noremap is{ Bi{<Esc>ea}<Esc>
noremap ds" F"x,x
noremap cs" F"x,xi
noremap is" Bi"<Esc>ea"<Esc>
noremap ds' F'x,x
noremap cs' F'x,xi
noremap is' Bi'<Esc>ea'<Esc>
noremap ds( F(xf)x
noremap cs( F(xf)xi
noremap ds) F(xf)x
noremap cs) F(xf)xi
noremap is( Bi(<Esc>ea)<Esc>

"nmap cu ct_
"nmap cU cf_

" upper or lowercase the current word
"nmap g^ gUiW
"nmap gv guiW

" diff
nmap ]c ]czz
nmap [c [czz

"copy all to X-buffer
"nmap ya gg"+yG
"copy string to X-buffer
nmap yc "+yy
" Copy current buffer path relative to root of VIM session to system clipboard
nnoremap <Leader>yp :let @+=expand("%")<cr>:echo "Copied file path to clipboard"<cr>
" Copy current filename to system clipboard
nnoremap <Leader>yf :let @+=expand("%:t")<cr>:echo "Copied file name to clipboard"<cr>
" Copy current buffer path without filename to system clipboard
nnoremap <Leader>yd :let @+=expand("%:h")<cr>:echo "Copied file directory to clipboard"<cr>

" default to very magic
"no / /\v

" gO to create a new line below cursor in normal mode
nmap g<C-O> o<ESC>k
" g<Ctrl+o> to create a new line above cursor (Ctrl to prevent collision with 'go' command)
nmap gO O<ESC>j

"I really hate that things don't auto-center
nmap G Gzz
nmap n nzz
nmap N Nzz
nmap } }zz
nmap { {zz

"open tag in new tab
"map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

"quick pairs
imap '' ''<ESC>i
imap "" ""<ESC>i
imap () ()<ESC>i
imap [] []<ESC>i
imap {} {}<ESC>i
imap <> <><ESC>i
imap <Leader>; <ESC>$a;<CR>


"============== Filetype based executuion ===============
"python script execution
autocmd FileType python  nnoremap <Leader>r :exec '!python %'<CR>
nmap =j :%!python -m json.tool<CR>
"============== Filetype based commenting ===============
"" perl style # commenting
autocmd FileType python,sh,php,yaml  noremap <Leader>c :s/\v^(\s*)/\1#/ <CR>
autocmd FileType python,sh,php,yaml  noremap <Leader>c :s/\v^(\s*)#/\1/ <CR>
" C style // commenting
autocmd FileType c,cpp,php noremap <F5> :s+\v^(\s*)+\1//+ <CR>
autocmd FileType c,cpp,php noremap <F6> :s+\v^(\s*)//+\1+ <CR>
" vim commenting
autocmd FileType vim noremap <F5> :s/\v^(\s*)/\1"/ <CR>
autocmd FileType vim noremap <F6> :s/\v^(\s*)"/\1/ <CR>
