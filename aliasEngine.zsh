#!/bin/zsh

ae() {
    echo "🔧 Alias Engine Commands:"
    echo ""
    echo "  ae                    Show this help"
    echo "  newae <name> <cmd>    Create new alias"
    echo "  rmae <name>           Remove alias"
    echo "  lsae                  List all aliases"
    echo "  fae <pattern>         Search aliases"
    echo "  eae                   Edit Alias Engine"
    echo ""
}

# Alias management engine
ALIAS_FILE="$HOME/.config/zsh/alias.zsh"
ALIAS_ENGINE="$HOME/.config/zsh/aliasEngine.zsh"

# Add new alias with smart parsing
newae() {
    if [ $# -lt 2 ]; then
        echo "Usage: newalias <name> <command>"
        echo "Example: newalias ll 'ls -la'"
        return 1
    fi

    local name="$1"
    shift
    local command="$*"

    # Expand ~ to $HOME
    command="${command//\~/$HOME}"

    # Remove existing alias
    sed -i '' "/^alias $name=/d" "$ALIAS_FILE" 2>/dev/null

    # Add new alias
    echo "alias $name='$command'" >> "$ALIAS_FILE"

    # Load it immediately
    alias "$name=$command"

    echo "✅ Added: $name='$command'"
}

# Remove alias
rmae() {
    if [ $# -ne 1 ]; then
        echo "Usage: rmalias <name>"
        return 1
    fi

    local name="$1"

    # Remove from file
    sed -i '' "/^alias $name=/d" "$ALIAS_FILE" 2>/dev/null

    # Remove from current session
    unalias "$name" 2>/dev/null

    echo "✅ Removed: $name"
}

# List all aliases
lsae() {
    echo "📁 Current aliases:"
    grep "^alias " "$ALIAS_FILE" | sed 's/alias //' | column -t -s "="
}

# Search aliases
fae() {
    if [ $# -eq 0 ]; then
        echo "Usage: falias <pattern>"
        return 1
    fi

    grep -i "alias.*$1" "$ALIAS_FILE" | sed 's/alias //'
}

# Edit aliases file
eae() {
    nvim "$ALIAS_ENGINE"
    source "$ALIAS_ENGINE"
}
