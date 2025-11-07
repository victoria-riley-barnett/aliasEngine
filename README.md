# aliasEngine
Super simple 1 script alias manager

## Usage
Source the script in your Zsh shell:

```zsh
source /path/to/aliasEngine.zsh
```

Create an alias file, you might want to migrate existing aliases there:

```zsh
touch <your home or config dir>/zsh/alias.zsh
```
You might need to run eae to edit the script path depending on your structure.

Then use the following commands:
- Show help: `ae`
- Create alias: `newae <name> <command>`
- Remove alias: `rmae <name>`
- List aliases: `lsae`
- Search aliases: `fae <pattern>`
- Edit engine: `eae`
