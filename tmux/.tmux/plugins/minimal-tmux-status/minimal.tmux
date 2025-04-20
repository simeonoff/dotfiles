#!/usr/bin/env bash
PLUGIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

get_tmux_option() {
	local option=$1
	local default_value="$2"
	# shellcheck disable=SC2155
	local option_value=$(tmux show-options -gqv "$option")
	if [ -n "$option_value" ]; then
		echo "$option_value"
		return
	fi
	echo "$default_value"
}

main() {
    local theme
    theme=$(get_tmux_option "@minimal-tmux-theme" "rose-pine")

    # NOTE: Pulling in the selected theme by the theme that's being set as local variables.
    # https://github.com/dylanaraps/pure-sh-bible#parsing-a-keyval-file
    while IFS='=' read -r key val; do
      # Skip over lines containing comments.
      # (Lines starting with '#').
      [ "${key##\#*}" ] || continue

      # '$key' stores the key.
      # '$val' stores the value.
      eval "local $key"="$val"
    done < "${PLUGIN_DIR}/themes/${theme}.tmuxtheme"

    bg=$(get_tmux_option "@minimal-tmux-bg" ${thm_rose})
    inactive_bg=$(get_tmux_option "@minimal-tmux-inactive-bg" ${thm_overlay})

    status=$(get_tmux_option "@minimal-tmux-status" "bottom")
    justify=$(get_tmux_option "@minimal-tmux-justify" "centre")

    indicator_state=$(get_tmux_option "@minimal-tmux-indicator" true)
    right_state=$(get_tmux_option "@minimal-tmux-right" true)
    left_state=$(get_tmux_option "@minimal-tmux-left" true)

    if [ "$indicator_state" = true ]; then
        indicator=$(get_tmux_option "@minimal-tmux-indicator-str" " TMUX ")
    else
        indicator=""
    fi

    window_status_format=$(get_tmux_option "@minimal-tmux-window-status-format" ' #I:#W ')
    status_right=$(get_tmux_option "@minimal-tmux-status-right" "#S")
    status_left=$(get_tmux_option "@minimal-tmux-status-left" " #[bg=default,fg=${thm_muted},none]#{?client_prefix,,${indicator}}#[bg=default,fg=${thm_gold},bold]#{?client_prefix,${indicator},}#[bg=default,fg=default,bold] ")
    expanded_icon=$(get_tmux_option "@minimal-tmux-expanded-icon" ' 󰆟 ')
    show_expanded_icon_for_all_tabs=$(get_tmux_option "@minimal-tmux-show-expanded-icon-for-all-tabs" false)

    status_right_extra="$status_right$(get_tmux_option "@minimal-tmux-status-right-extra" '')"
    status_left_extra="$status_left$(get_tmux_option "@minimal-tmux-status-left-extra" '')"

    if [ "$right_state" = false ]; then
        status_right_extra=""
    fi

    if [ "$left_state" = false ]; then
        status_left_extra=""
    fi

# TODO: The foreground colors should come from the theme
# Set pane border colors 
    tmux set-option -g pane-border-style "fg=${thm_hl_med},bg=default"
    tmux set-option -g pane-active-border-style "fg=${thm_hl_med},bg=default"
    tmux set-option -g status-position "${status}"
    tmux set-option -g status-style bg=default,fg=default
    tmux set-option -g status-justify "${justify}"
    tmux set-option -g status-left "${status_left_extra}"
    tmux set-option -g status-right "${status_right_extra}"
    tmux set-option -g window-status-format "${window_status_format}"
    tmux set-option -g window-status-current-format "#[fg=${bg}]#[bg=${bg},fg=${thm_base},bold]${window_status_format}#{?window_zoomed_flag,${expanded_icon},}#[fg=${bg},bg=default]"

    if [ "$show_expanded_icon_for_all_tabs" = true ]; then
        tmux set-option -g window-status-format "#[fg=${inactive_bg}]#[bg=${inactive_bg},fg=${thm_rose}]${window_status_format}#{?window_zoomed_flag,${expanded_icon},}#[fg=${inactive_bg},bg=default]"
    fi
}

main "$@"
