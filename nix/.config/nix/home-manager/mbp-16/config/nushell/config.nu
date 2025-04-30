$env.config = {
    show_banner: false,
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
    ]
}

$env.PATH = ($env.PATH | prepend [
    $"($env.HOME)/dotfiles/bin"
    $"($env.HOME)/.npm-global/bin"
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
