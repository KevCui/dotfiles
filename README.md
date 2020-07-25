# dotfiles

The sweet sweet home of my lovely dotfiles :honey_pot:

## How to configure

You may or may not notice that there are some variables `%variable%` in some dotfiles. For example, in `zshrc`:

```bash
export GITREPO="%gitrepo%"
```

Because some settings can be different on different machines (directories, shortcuts, term colors...). To make it more flexible, the value of variable can be defined in a `yaml` file, the format looks like:

```yaml
<filename1>:
  <variable1>: <value1>
  <variable2>: <value2>

<filename2>:
  <variable1>: <value1>
  <variable2>: <value2>
```

For example, in `dotfile-config.yaml`:

```yaml
zshrc:
  gitrepo: \/home\/kevinthebest\/git
  comment: ''
  othersource: ~\/.czshrc

i3wm/config:
  comment: ''
```

## How to build

- Build all files in `<yaml_config_file>`:

```bash
./build.sh <yaml_config_file>; source ~/.zshrc
```

The final files will be generated in `output` folder. Pay attention to create symbol links to the target files in `output` folder.

- Build only certain files in `<yaml_config_file>`:

```bash
./build.sh <yaml_config_file> 'Xresources i3wm/config'; source ~/.zshrc
```

:heart:
