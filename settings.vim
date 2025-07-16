let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/.config/nvim
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +1 ~/.config/nvim
badd +1 ideas.txt
badd +2 init.lua
badd +1 lua/settings.lua
badd +5 lua/Quirk/init.lua
badd +10 lua/Quirk/settings/init.lua
badd +4 lua/Quirk/keymaps/init.lua
badd +2 lua/Quirk/autocommands/init.lua
badd +1 lua/Quirk/lazy/init.lua
badd +2 lua/Quirk/pluginInstall/init.lua
badd +4 lua/Quirk/lsp/init.lua
badd +1 lua/keymaps.lua
badd +1 lua/autocommands.lua
badd +1 lua/lazyInstall.lua
badd +1 lua/pluginInstall.lua
badd +1 lua/lspInstall.lua
badd +1 lua/Quirk/settings/mouse.lua
badd +5 test
badd +2 lua/Quirk/settings/leader.lua
badd +1 lua/Quirk/lazy_init.lua
badd +1 lua/Quirk/settings/sidebar.lua
badd +1 lua/Quirk/settings/saving.lua
badd +25 lua/Quirk/keymaps/new.lua
badd +1 lua/Quirk/keymaps/basic.lua
badd +10 lua/Quirk/keymaps/move.lua
badd +696 lua/Quirk/lazy/plugin.lua
badd +1 lua/Quirk/settings/new
badd +18 lua/Quirk/settings/new.lua
badd +1 lua/Quirk/settings/quick
badd +1 lua/Quirk/settings/quick.lua
badd +0 option-window
argglobal
%argdel
$argadd ~/.config/nvim
edit lua/Quirk/settings/quick.lua
argglobal
balt lua/Quirk/settings/init.lua
setlocal foldmethod=manual
setlocal foldexpr=v:lua.vim.treesitter.foldexpr()
setlocal foldmarker={{{,}}}
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldenable
silent! normal! zE
let &fdl = &fdl
let s:l = 1 - ((0 * winheight(0) + 12) / 25)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
lcd ~/.config/nvim
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
nohlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
