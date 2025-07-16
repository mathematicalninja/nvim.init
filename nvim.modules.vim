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
badd +4 lua/Quirk/init.lua
badd +4 lua/Quirk/settings/init.lua
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
badd +7 lua/Quirk/settings/sidebar.lua
badd +1 lua/Quirk/settings/saving.lua
badd +25 lua/Quirk/keymaps/new.lua
badd +1 lua/Quirk/keymaps/basic.lua
badd +10 lua/Quirk/keymaps/move.lua
badd +696 lua/Quirk/lazy/plugin.lua
badd +1 lua/Quirk/settings/new
badd +3 lua/Quirk/settings/new.lua
badd +1 option-window
argglobal
%argdel
$argadd ~/.config/nvim
edit lua/Quirk/init.lua
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd _ | wincmd |
split
wincmd _ | wincmd |
split
2wincmd k
wincmd w
wincmd w
wincmd w
wincmd _ | wincmd |
split
1wincmd k
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe '1resize ' . ((&lines * 1 + 13) / 27)
exe 'vert 1resize ' . ((&columns * 51 + 56) / 112)
exe '2resize ' . ((&lines * 2 + 13) / 27)
exe 'vert 2resize ' . ((&columns * 51 + 56) / 112)
exe '3resize ' . ((&lines * 20 + 13) / 27)
exe 'vert 3resize ' . ((&columns * 51 + 56) / 112)
exe '4resize ' . ((&lines * 12 + 13) / 27)
exe 'vert 4resize ' . ((&columns * 60 + 56) / 112)
exe '5resize ' . ((&lines * 12 + 13) / 27)
exe 'vert 5resize ' . ((&columns * 60 + 56) / 112)
argglobal
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
let s:l = 5 - ((0 * winheight(0) + 0) / 1)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 5
normal! 0
lcd ~/.config/nvim
wincmd w
argglobal
if bufexists(fnamemodify("~/.config/nvim/lua/Quirk/settings/init.lua", ":p")) | buffer ~/.config/nvim/lua/Quirk/settings/init.lua | else | edit ~/.config/nvim/lua/Quirk/settings/init.lua | endif
if &buftype ==# 'terminal'
  silent file ~/.config/nvim/lua/Quirk/settings/init.lua
endif
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
let s:l = 3 - ((0 * winheight(0) + 1) / 2)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 3
normal! 0
lcd ~/.config/nvim
wincmd w
argglobal
if bufexists(fnamemodify("~/.config/nvim/lua/Quirk/settings/mouse.lua", ":p")) | buffer ~/.config/nvim/lua/Quirk/settings/mouse.lua | else | edit ~/.config/nvim/lua/Quirk/settings/mouse.lua | endif
if &buftype ==# 'terminal'
  silent file ~/.config/nvim/lua/Quirk/settings/mouse.lua
endif
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
let s:l = 1 - ((0 * winheight(0) + 10) / 20)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
lcd ~/.config/nvim
wincmd w
argglobal
if bufexists(fnamemodify("~/.config/nvim/lua/Quirk/settings/new.lua", ":p")) | buffer ~/.config/nvim/lua/Quirk/settings/new.lua | else | edit ~/.config/nvim/lua/Quirk/settings/new.lua | endif
if &buftype ==# 'terminal'
  silent file ~/.config/nvim/lua/Quirk/settings/new.lua
endif
balt ~/.config/nvim/option-window
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
let s:l = 3 - ((2 * winheight(0) + 6) / 12)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 3
normal! 020|
lcd ~/.config/nvim
wincmd w
argglobal
enew
file ~/.config/nvim/option-window
balt ~/.config/nvim/lua/Quirk/settings/new.lua
setlocal foldmethod=manual
setlocal foldexpr=0
setlocal foldmarker={{{,}}}
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldenable
lcd ~/.config/nvim
wincmd w
5wincmd w
exe '1resize ' . ((&lines * 1 + 13) / 27)
exe 'vert 1resize ' . ((&columns * 51 + 56) / 112)
exe '2resize ' . ((&lines * 2 + 13) / 27)
exe 'vert 2resize ' . ((&columns * 51 + 56) / 112)
exe '3resize ' . ((&lines * 20 + 13) / 27)
exe 'vert 3resize ' . ((&columns * 51 + 56) / 112)
exe '4resize ' . ((&lines * 12 + 13) / 27)
exe 'vert 4resize ' . ((&columns * 60 + 56) / 112)
exe '5resize ' . ((&lines * 12 + 13) / 27)
exe 'vert 5resize ' . ((&columns * 60 + 56) / 112)
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let &winminheight = s:save_winminheight
let &winminwidth = s:save_winminwidth
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
