#/usr/bin/env bash

FAT_PARTITION='/boot'
CONFIG_FILE='config.txt'

# run <command> <error_message>
run() {
    if ! $1 >/dev/null 2>&1; then
        echo $2
        exit 1
    fi
}

# replace <file> <string_to_find> [replace_with]
replace_line() {
    if [ -n "$3" ]; then
        if grep -q "$2" "$1"; then
            sudo sed -i "/$2/ c\\$3" "$1"
        else
            echo "$3" | sudo tee -a "$1" >/dev/null
        fi
    else
        sudo sed -i "/$2/d" "$1"
    fi
}

# check access rights
run "sudo -n uptime" "You need to be root to perform this command!"

# cd to FAT partition
run "cd $FAT_PARTITION" "Can't find FAT partition!"

# save EDID data to file
run "sudo tvservice -d edid.dat" "Can't find tvservice utility!"

# check if config.txt file exists
if ! [ -f "$CONFIG_FILE" ]; then
    echo "Cant find config.txt file!"
    exit 1
fi

while getopts ":lu" opt; do
    case "$opt" in
        l)
            # add hdmi params to configuration file
            replace_line "$CONFIG_FILE" 'hdmi_edid_file' 'hdmi_edid_file=1'
            replace_line "$CONFIG_FILE" 'hdmi_force_hotplug' 'hdmi_force_hotplug=1'
            exit 0
            ;;
        u)
            # remove hdmi params from configuration file
            replace_line "$CONFIG_FILE" 'hdmi_edid_file'
            replace_line "$CONFIG_FILE" 'hdmi_force_hotplug'
            exit 0
            ;;
    esac
done

echo "usage: $0 [-l|-u]"
exit 1
