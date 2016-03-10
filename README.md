vim-themostdangerouswritingapp
==============================

[The Most Dangerous Writing App](http://www.themostdangerouswritingapp.com/) in Vim.


## Usage

Execute following command!

```vim
:TheMostDangerousWritingAppEnable
```


## Installation

With [NeoBundle](https://github.com/Shougo/neobundle.vim).

```VimL
NeoBundle 'koturn/vim-themostdangerouswritingapp'
if neobundle#tap('vim-themostdangerouswritingapp')
  call neobundle#config({
        \ 'on_cmd': ['TheMostDangerousWritingAppEnable', 'TheMostDangerousWritingAppDisable']
        \})
  call neobundle#untap()
endif
```

With [Vundle](https://github.com/VundleVim/Vundle.vim).

```VimL
Plugin 'koturn/vim-themostdangerouswritingapp'
```

With [vim-plug](https://github.com/junegunn/vim-plug).

```VimL
Plug 'koturn/vim-themostdangerouswritingapp'
```

If you don't want to use plugin manager, put files and directories on
```~/.vim/```, or ```%HOME%/vimfiles/``` on Windows.


## LICENSE

This software is released under the MIT License, see [LICENSE](LICENSE).
