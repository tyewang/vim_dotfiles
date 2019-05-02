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

Install Python requirements:
```
sudo pip install pyflakes
sudo pip install jedi
```

## Configuration

After this, most plugins (e.g. NerdTree) will automatically work. A couple
plugins still need to be configured.

### FZF
FZF is the fuzzy search tool I use. To set it up:
`brew install fzf`
