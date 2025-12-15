#source
2025-12-16 05:44

# Bash Substring Expansion (${parameter:offset:length})

Source: https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html#Shell-Parameter-Expansion-1

Expands a substring of parameter starting at offset for up to length characters. If :length is omitted, expansion continues to the end. If offset is omitted, it defaults to 0. offset and length are arithmetic expressions.

Negative offset counts from the end of the value. Negative length is treated as an end position (from the end), expanding characters between offset and that position. A negative offset must be separated from the colon by a space to avoid confusion with :-.

```bash
# Examples:
${string:7} → from index 7 to end
${string:7:2} → two characters from index 7
${string:7:-2} → from index 7 up to two characters before the end
${string: -7} → last 7 characters
```
