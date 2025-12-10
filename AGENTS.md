# AGENTS.md

Overview and more detail please read the [Concept](/README.md)

## Build/Test Commands

- Note creation: `./scripts/note` (interactive script with gum)
- zk CLI commands: `zk list`, `zk new`, `zk edit`
- No build/test system - this is a personal knowledge management system

## Code Style Guidelines

### File Organization

- Use unique IDs for filenames (zk automatically assign ID on creation)
- Store all notes in `/zettels/` directory
- Separate fleeting notes (`/inbox/`) from permanent notes

### Markdown Formatting

- 2-space indentation for lists
- Max line length: 100 characters
- UTF-8 encoding, LF line endings
- Preserve trailing whitespace in markdown files

### Note Structure

- One concept per note (atomicity principle)
- Permanent notes: ~100 words
- Use YAML frontmatter for metadata
- Tags: #hashtags, :colon:tags:, or Bear's #multi-word tags#

### Linking Conventions

- Literature notes: hierarchical (parent → child)
- Idea notes: networked (cross-link/bidirectional connections)
- No sideways links in literature notes
- Use markdown link format

### Content Guidelines

- Linux-focused unless stated otherwise
- Plain text first approach
- Tool-agnostic (works with zk, Obsidian, Vim, etc.)
- Separate external knowledge (#literature) from internal thinking (#idea)
