These are the dotfiles I use.

## Setup
After cloning this repository:

Initialize the submodules for the vim plugins:
```
git submodule init
git submodule update
```

Create symbolic links:
```
ln -s "$(pwd)/vimrc" ~/.vimrc
ln -s "$(pwd)/vim" ~/.vim
````

## Configuration

After this, most plugins (e.g. NerdTree) will automatically work. A couple
plugins still need to be configured.

### Command-T
Command-T is the fuzzy search tool I use. To set it up:
```
cd ~/.vim/bundle/command-t/ruby/command-t
ruby extconf.rb
make
```

This usually works fine on a new MacbookPro. However, there are a lot of
nuances, and this may fail if you have a weird version of ruby, a weird
version of vim, etc. See the (official
docs)[https://github.com/wincent/command-t/blob/master/doc/command-t.txt] for more info
