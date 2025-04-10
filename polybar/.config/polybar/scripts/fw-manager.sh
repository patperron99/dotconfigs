#!/bin/bash
# fwupd-check.sh - Save this in ~/.config/polybar/scripts/

# Function to check for updates
check_updates() {
    # Update the database first
    fwupdmgr refresh >/dev/null 2>&1
    
    # Check for updates and count them
    updates=$(fwupdmgr get-updates 2>/dev/null | grep -c "New version")
    
    if [ "$updates" -gt 0 ]; then
        # Red icon if updates available
        echo "%{F#f38ba8}%{F-}"
    else
        # Gray icon if no updates
        echo "%{F#666666}%{F-}"
    fi
}

# Function to handle clicks
handle_click() {
    case "$1" in
        "right")
            # Show available updates and prompt for confirmation
            alacritty -e bash -c '
                echo "Available firmware updates:"
                echo "------------------------"
                fwupdmgr get-updates
                echo "------------------------"
                read -p "Do you want to proceed with the update? (y/N) " -n 1 -r
                echo
                if [[ $REPLY =~ ^[Yy]$ ]]; then
                    echo "Proceeding with update..."
                    fwupdmgr update
                    echo "------------------------"
                    echo "Update complete. Press any key to close"
                    read -n 1
                else
                    echo "Update cancelled. Press any key to close"
                    read -n 1
                fi
            '
            ;;
    esac
}

# Handle script arguments
case "$1" in
    "check")
        check_updates
        ;;
    "click")
        handle_click "$2"
        ;;
esac
