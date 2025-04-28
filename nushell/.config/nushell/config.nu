# config.nu
#
# Installed by:
# version = "0.103.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# You can open this file in your default editor using:
# config nu
#
# See `help config nu` for more options
#
# You can remove these comments if you want or leave
# them for future reference.

$env.config = {
    buffer_editor: "nvim",
    edit_mode: "vi",
    keybindings: [
        {
            name: accept-autosuggestion,
            modifier : control,
            keycode: char_y,
            mode: vi_insert,
            event: {
                send: HistoryHintComplete
            }
        }
    ],
    hooks: {
        pre_prompt: [{ ||
            if (which direnv | is-empty) {
                return
            }

            direnv export json | from json | default {} | load-env
            if 'ENV_CONVERSIONS' in $env and 'PATH' in $env.ENV_CONVERSIONS {
                $env.PATH = do $env.ENV_CONVERSIONS.PATH.from_string $env.PATH
            }
        }]
    }
}

$env.PATH = ($env.PATH | prepend [
    $"($env.HOME)/dotfiles/bin"
])

$env.FZF_DEFAULT_OPTS = [
"--pointer=' '"
"--prompt='   '"
"--color=fg:8,bg:-1,hl:2"
"--color=fg+:-1,bg+:-1,hl+:4"
"--color=info:8,prompt:2,pointer:2"
"--color=marker:#87ff00,spinner:#af5fff,header:8"
] | str join " "

alias cp = cp -i
alias mv = mv -i

alias vim = nvim

def ll [] {
    ls -la | filter {|x| $x.name != ".DS_Store"} | sort-by type
}

# Enable the starship prompt
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

# Load Zoxide
source ~/.zoxide.nu

# Load Carapace for autocompletions
source ~/.cache/carapace/init.nu
