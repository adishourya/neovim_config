set gfn=SpaceMono\ Nerd\ Font:h12

" clear cache so this reloads changes.
" useful for development
lua package.loaded['nordnight'] = nil
lua package.loaded['nordnight.theme'] = nil
lua package.loaded['nordnight.colors'] = nil
lua package.loaded['nordnight.util'] = nil
lua package.loaded['nordnight.config'] = nil

lua require('colorschemes/nordnight').colorscheme()

augroup TokyoNight
  autocmd!
  autocmd BufWritePost */lua/colorschemes/nordnight/** nested colorscheme nordnight
augroup end

" autocmd BufWinEnter quickfix setlocal winhighlight=Normal:NormalSB,SignColumn:SignColumnSB
