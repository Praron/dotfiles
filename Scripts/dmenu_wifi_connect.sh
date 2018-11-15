netctl list | cut -b 3- | dmenu -i | ifne xargs sudo -A netctl switch-to

