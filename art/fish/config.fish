## LOW LEVEL STUFF

# Make UTF-8
set -g -x LC_ALL en_GB.utf8
set -g -x LC_LANG en_GB.utf8
set -g -x LANG en_GB.utf8

# Disable greeting
set fish_greeting

# Set path
set -g -x PATH $HOME/bin /usr/bin /bin /usr/sbin /sbin /usr/share/perl5/site_perl/auto/share/dist/Cope

# Set default programs
set -g -x BROWSER firefox
set -g -x EDITOR vim
set -g -x TERMINAL urxvtc

# source bindings
source $HOME/.config/fish/bindings


## COLORS

set fish_color_normal normal

set fish_color_command green
set fish_color_error red
set fish_color_autosuggestion black --bold

set fish_color_param normal
set fish_color_quote yellow
set fish_color_end normal

set fish_color_comment black --bold

set fish_pager_color_prefix normal
set fish_pager_color_description black --bold

set fish_color_cwd magenta --bold

#fish_color_redirection
#fish_color_match
#fish_color_search_match
#fish_color_operator
#fish_color_escape
