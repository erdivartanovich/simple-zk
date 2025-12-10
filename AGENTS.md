# My Personal Note System

Personal note taking system managed using custom zettelkasten methodology, mainly contains knowledge
about linux system, programming, but can have other topics as well.

## Note Types

1. Fleeting Notes

- Raw capture
- Can be mark using #literature or #idea tag, to give insight for processing later to a permanent
  note.
- Temporary inbox
- No linking rules
- Deleted or converted later

2. Permanent Notes

Single format, but with two conceptual categories via tags:

- #literature
  - Pyramid model
  - Parent → Child hierarchical links
  - Derived from external sources
  - Acts like structured knowledge tree
  - Supports references to sources
  - External-facing (information first)
  - Each literature note is small, atomic:
    - “What this paragraph means”
    - “Definition of X”
    - “Example of Y”
    - “Reason why Z works”

- #idea
  - Zettelkasten graph
  - No hierarchy
  - Link to related idea notes
  - Represents internal understanding
  - Self-contained thoughts
  - Insight-facing (thinking first)
  - Each idea note is small, atomic, strictly around 100 words

## General Rules

- Every code, snippet or program that mentioned in any note, are meant to be running in Linux
  system, unless otherwise mentioned specifically.
- Every Permanent Note is atomic, meaning it is strictly for one
  idea/source per-file. That include not mixing source and idea.
- A note should be around 100 words,
- A note should work in most plain-text note application like `zk` or `Obsidian`.
- File naming is done with unique ids.

## The Pyramid Model of Literature Note Links

Every literature note has ONLY these link types:

1. Up Link (one only)
   ⬆ A single link to its parent or broader concept.
2. Down Links (one or more)
   ⬇ Links to child notes that are more specific or detailed.
3. ❌ No Sideways Links
   No “related topic,” “see also,” or “same-level” links.

They form hierarchical pyramid of literature note, like this:

```css
Top-level Concept
        │
        ├─ Mid-level Concept A
        │      ├─ Specific concept A1
        │      └─ Specific concept A2
        │
        └─ Mid-level Concept B
               └─ Specific concept B1
```

## Folder structure

The root folder for all notes is `rdi`

```css
rdi/
│
├── inbox/                    # Fleeting notes
│   └── *.md
│
├── permanent/               # All permanent notes (ideas + literature)
│   └── *.md
│
├── sources/                 # Optional: raw highlights or source captures
│   ├── books/
│   ├── articles/
│   └── videos/
│
└── assets/             # PDFs, screenshots, etc
```

## Utilities

1. ZK cli
2. Neovim editor
3. Custom bash scripting
4. Pandoc for document convertion
5. Magick for image transform / scale down
