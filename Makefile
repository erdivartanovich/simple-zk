.PHONY: help lady note list edit build rebuild clean

# Default target
help:
	@echo "Available commands:"
	@echo "  lady     - Open opencode agent named 'lady'"
	@echo "  note     - Create a new note (interactive)"
	@echo "  list     - List all notes"
	@echo "  edit     - Edit last modified note"
	@echo "  build    - Build cached PDFs for all notes (fresh-system warm-up)"
	@echo "  rebuild  - Force-rebuild every PDF and prune orphans"
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

# Build cached PDFs for all notes (skips ones already up to date)
build:
	@./scripts/build-note --all

# Force-rebuild every PDF and drop PDFs for deleted notes
rebuild:
	@./scripts/build-note --force --all --prune

# Clean temporary files
clean:
	@echo "Cleaning temporary files..."
	@find . -name "*.tmp" -delete 2>/dev/null || true
	@find . -name ".DS_Store" -delete 2>/dev/null || true
	@echo "Done."
