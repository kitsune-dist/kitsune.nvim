 ```
 ____
 \  /\  |\/|
  \/  \_/ ..__.  ▂ ▂ ▂ ▂▂▂ ▂▂▂ ▂ ▂ ▂ ▂ ▂▂▂
   \__ _\____/   █▄▀ █ ▔█▔ █▂▂ █ █ █▖█ █▂▂   █▖█ █ █ █ █▖▟▌
      \_\_\      █ █ █  █  ▂▂█ █▂█ █▝█ █▂▂ ▄ █▝█ ▀▄▀ █ █▝▐▌
 ```

Kitsune OS's very own neo-bloat distribution.

*By the way, Kitsune OS does not exist yet, lol.*


## Usage

Unlike most nvim dists, the prefix key is `;`, this can be changed of course... along with every other line of code.

Other than that, everything should be documented within the dist itself. Use `<a command that does not yet exist!>` for help


## Installation

One day I hope to let this be installable via lazy like [NvChad](https://github.com/NvChad/NvChad) is, however this day, it is not.

First, clone this repository into whatever your nvim config directory is.
```
git clone https://github.com/kitsune-dist/kitsune.nvim
```

Second, run neovim.

It's not hard.


## Contributors

Just [me](https://github.com/cwillsey06) for now :)


## Thanks

 * [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) - Provider of [initial commit](https://github.com/kitsune-dist/kitsune.nvim/commit/e188d68e5a90491a5a12c9eacdcec80d38f5475a), continues to live in some plugin configs.
 * [Effective Neovim: Instant IDE](https://youtu.be/stqUbv-5u2s) - Showed me kickstart.nvim. Joint credit goes to both as each one saved my sanity in innumerable ways.
 * [NvChad](https://github.com/NvChad/NvChad) - Great reference for directory structure, modularizing, etc.
 * [The perfect Neovim setup for Go](https://youtu.be/i04sSQjd-qo) - Why I decided to focus on creating my own neovim dist in the first place... kinda... it's a long story.
 * [msvl](https://github.com/cwillsey06/msvl) - Got tired of no completion, linting... *any* advanced features... so I sought to replace it.


## License

Code **strictly associated** with kitsune.nvim is under terms of the MIT software license.

[Simple](https://choosealicense.com/licenses/mit) and [Standard](https://spdx.org/licenses/MIT.html)
license definitions have been linked inline, and reinstated within core files.

This obviously does not apply to the plugins and third-party software that may be installed.
Feel free to review the [`lua/kitsune/plugin.lua`](github.com/kitsune-dist/kitsune.nvim/blob/main/lua/kitsune/plugin.lua)
file for information about each plugin provided in stock Kitsune.nvim.

