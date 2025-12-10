.PHONY: help lady note list edit clean

# Default target
help:
	@echo "Available commands:"
	@echo "  lady     - Open opencode agent named 'lady'"
	@echo "  note     - Create a new note (interactive)"
	@echo "  list     - List all notes"
	@echo "  edit     - Edit last modified note"
	@echo "  clean    - Clean temporary files"
	@echo "  help     - Show this help message"

# Open opencode agent named "lady"
lady:
	@echo "Opening opencode agent 'lady'..."
	@opencode --agent lady

# Create a new note (interactive)
note:
	@./scripts/note

# List all notes
list:
	@zk list

# Edit last modified note
edit:
	@zk edit --limit 1 --sort modified-

# Clean temporary files
clean:
	@echo "Cleaning temporary files..."
	@find . -name "*.tmp" -delete 2>/dev/null || true
	@find . -name ".DS_Store" -delete 2>/dev/null || true
	@echo "Done."
