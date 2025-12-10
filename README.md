# Hybrid Zettelkasten–Pyramid Note System

This system mixes two ideas: a Pyramid structure for organizing information from books, articles,
and videos, and a Zettelkasten network for connecting original thoughts and insights. Software
development involves learning from many fast-changing sources, and no single method handles both
structured learning and creative thinking well on its own.

To keep things simple:

- Fleeting notes capture anything quickly during reading or watching.
- Permanent–Literature notes store information from external sources in a clear hierarchy (a
  deliberate change from the original ZK, where literature notes are temporary).
- Permanent–Idea notes hold original thoughts and connect freely, forming a small knowledge graph.

This creates two layers that work together: a stable, organized base for everything learned from
outside sources, and a flexible network for ideas, decisions, problem-solving, and insights that
grow over time.

The result is a straightforward system that supports daily learning in software development: fast
capture, organized understanding, and a place for deeper thinking.

## Core Philosophy

This system balances two complementary approaches:

- **External knowledge** (literature notes): structured, hierarchical organization of sourced information
- **Internal understanding** (idea notes): networked, associative connections between original thoughts

Together, they form a bridge between information I consumed and what I think.

## Note Types

### 1. Fleeting Notes

Fleeting notes serve as my cognitive inbox—a temporary holding space for raw thoughts and captures.

**Characteristics:**

- Raw, unprocessed capture
- Tagged with `#source` or `#idea` to signal processing intent
- No linking requirements
- Temporary by design, convert or delete within days
- Low friction: capture first, refine later

**Purpose:** Reduce cognitive load by externalizing thoughts immediately without worrying about structure or permanence.

### 2. Permanent Notes

Permanent notes are my refined knowledge base. While stored together, they follow two distinct conceptual models based on their main tags.

#### Literature Notes (`#source`)

**Model:** Pyramid/Tree Structure

Literature notes capture and organize external knowledge using strict hierarchical relationships.

**Structure:**

- **Parent → Child relationships** (top-down organization)
- Each note sits at one level of abstraction
- Derived from books, articles, videos, documentation
- Supports source references
- External-facing: information-first

**Atomicity:**
Each literature note is small and focused on a single unit of information:

- "What this paragraph means"
- "Definition of X"
- "Example of Y"
- "Why Z works"
- "How to do W"

**Goal:** Build a queryable knowledge tree where each node represents one clear concept, definition, or explanation.

#### Idea Notes (`#idea`)

**Model:** Zettelkasten Graph

Idea notes represent my original thinking—insights, connections, and arguments derived from my own mental work.

**Structure:**

- **No hierarchy**—ideas connect organically
- Links flow in any direction (bidirectional, multi-directional)
- Self-contained thoughts and arguments
- Insight-facing: thinking-first
- May reference literature notes as supporting evidence

**Atomicity:**
Each idea note contains a single thought, strictly around **100 words**:

- One argument
- One connection between concepts
- One question worth exploring
- One insight or realization

**Goal:** Create a web of thought where ideas naturally cluster and reveal patterns in my understanding.

## Folder Structure

```
zettels/
│
├── inbox/                    # Fleeting notes awaiting processing
│   └── *.md
│
├── permanent/                # All permanent notes (ideas + literature)
│   └── *.md
│
├── sources/                  # Raw highlights and source captures
│   ├── books/
│   ├── articles/
│   └── videos/
│
├── assets/                   # Supporting files (PDFs, screenshots, diagrams)
│
├── .zk/                  # ZK cli notebook configuration folder
│   └── templates/

```

**Design rationale:** Fleeting and permanent notes separated by maturity, not by type. Literature and idea notes coexist in the same folder because they're both refined, permanent knowledge—only their linking models differ.

## General Rules

### Environment

- All code snippets and commands assume a **Linux system** unless explicitly stated otherwise
- Compatible with plain-text note applications (`zk`, `Obsidian`, `Vim`, etc.)

### Atomicity

- **One note, one unit**: Each permanent note contains exactly one idea, concept, or piece of information
- **No mixing**: Don't combine literatures and ideas in the same note
- **Length constraint**: Permanent notes should be approximately **100 words**
  - Literature notes may vary slightly based on the complexity of the concept
  - Idea notes strictly adhere to ~100 words to enforce clarity

### File Management

- **Unique IDs for filenames**: Use timestamp-based or random alphanumeric IDs (e.g., `202312101534.md` or `abc123.md`)
- **Descriptive titles**: Include human-readable titles in the YAML frontmatter or first heading
- **Plain-text first**: Markdown format ensures longevity and tool independence

### Tags

Other than the main tag #idea / #source, a note can have additional tags in the following
syntaxes:

- #hashtags
- :colon:separated:tags:
- Bear’s #multi-word tags#
- YAML frontmatter (tags and keywords keys).

The goal is to easily perform query like this:

```sh
  # find my own idea about geek stuff
  zk list --tag "linux OR programming, NOT literature"
```

## Linking Architecture

### A. Literature Notes (Pyramid Model)

Literature notes form a hierarchical knowledge tree with strict linking rules.

**Required Links:**

1. **Up Link** (⬆): Every note must link to exactly ONE parent (except root-level notes)
   - Points to a broader, more general concept
   - Establishes position in the hierarchy

2. **Down Links** (⬇): A note may link to MULTIPLE children
   - Point to more specific or detailed concepts
   - Build out the knowledge tree

**Forbidden Links:**

- ❌ **No sideways links**: No "related topic," "see also," or same-level connections
- ❌ **No links to idea notes**: Literature notes don't link to ideas (though they may reference them indirectly in prose)

**Optional References:**

- ✓ May reference source files in `/sources/` for attribution
- ✓ May mention idea notes in text (e.g., "This concept inspired idea note X"), but without creating a formal link

**Hierarchy Example:**

```
Root: Programming Paradigms
├── Object-Oriented Programming
│   ├── Encapsulation
│   ├── Inheritance
│   └── Polymorphism
│       ├── Compile-time Polymorphism
│       └── Runtime Polymorphism
└── Functional Programming
    ├── Pure Functions
    └── Immutability
```

**Benefits:**

- Clear navigation path (always know where I am)
- Prevents link clutter
- Enforces conceptual clarity
- Easy to expand downward (add detail) or upward (add abstraction)

### B. Idea Notes (Graph Model)

Idea notes form an organic network with flexible linking rules.

**Flexible Links:**

- ✓ Link to **any related ideas** (forward, backward, sideways, multi-directional)
- ✓ May reference **literature notes** as supporting evidence or source material
- ✓ Create emergent clusters and connection patterns

**Restrictions:**

- ❌ Should NOT be linked FROM literature notes (one-way reference only)
- ❌ No forced hierarchy (ideas don't have parents/children)

**Graph Example:**

```
"Writing improves thinking" ↔ "Clarity requires revision"
            ↓                           ↓
    "External cognition"         "First drafts are discovery"
            ↓                           ↑
    "Tools shape thought" ←→ "Constraints enable creativity"
            ↓
    📚 Reference: "Cognitive Load Theory" (literature note)
```

**Benefits:**

- Reveals unexpected connections
- Supports non-linear thinking
- Mirrors how insights actually emerge
- Scales naturally (more notes = richer network)

## System Architecture

The complete system creates a natural separation of concerns:

```
┌─────────────────────────────────────────┐
│         Idea Network (Graph)            │
│    /          |           \             │
│   /           |            \            │
│ insights   concepts    arguments        │
└─────────────┬───────────────────────────┘
              │
              │ (references for support)
              ↓
┌─────────────────────────────────────────┐
│     Literature Tree (Pyramid)           │
│              |                          │
│         (organized knowledge)           │
└─────────────┬───────────────────────────┘
              │
              │ (attribution)
              ↓
┌─────────────────────────────────────────┐
│   Sources (books, articles, videos)     │
└─────────────────────────────────────────┘
```

## Example Workflow

### Reading a Book

1. Capture fleeting notes in `/inbox/` while reading
2. Process into literature notes (`#source`)
3. Organize hierarchically under existing concepts or create new branches
4. Link parent (up) and children (down)

### Having an Insight

1. Write fleeting note in `/inbox/` with `#idea` tag
2. Develop into a ~100-word idea note
3. Link to related idea notes
4. Reference supporting literature notes if applicable

### Making Connections

- When an idea emerges from literature: Write an idea note that references (but doesn't link to) the literature note
- When literature supports an idea: Add the literature note as a reference in the idea note
- When ideas relate: Create bidirectional links between idea notes

## Maintenance Practices

### Daily

- Process inbox notes (convert or delete)
- Aim for inbox zero at least once per week

### Weekly

- Review orphaned notes (no incoming or outgoing links)
- Verify literature note hierarchy integrity
- Explore idea note clusters for emerging themes

### Monthly

- Audit atomicity (split notes that grew too large)
- Consolidate duplicate concepts
- Refactor hierarchy as understanding deepens

## Tooling

The system is tool-agnostic but optimized for these utilities:

1. **zk CLI**: Command-line note management and searching
2. **Neovim**: Primary editing environment with markdown support
3. **Custom bash scripts**: Automation for note creation, link checking, orphan detection
4. **Pandoc**: Document conversion (markdown ↔ PDF, HTML, etc.)
5. **ImageMagick/magick**: Image processing (resize, optimize for web)
6. **Opencode**: Local Agentic AI, can help as Personal Note Taking Assistant:
   - Capture helper: A local AI quickly turns copied text, transcripts, or thoughts into clean fleeting notes.
   - Structured learning: It automatically creates and organizes Permanent–Literature notes into the Pyramid hierarchy with correct parent/child links.
   - Idea development: It helps turn insights into Permanent–Idea notes and suggests meaningful connections to existing ideas.
   - Consistency enforcement: It checks that linking rules, tags, and file structure stay clean and consistent across the whole system.
   - Automation layer: It runs CLI actions, generates templates, and maintains notes over time, becoming a private, offline knowledge assistant built on top of the note folder.

### Recommended Script Ideas

- `note.sh`: Template-based note creation with auto-generated IDs
- `check-links.sh`: Verify no broken internal links
- `find-orphans.sh`: Identify unlinked notes
- `hierarchy-check.sh`: Ensure every literature note has exactly one parent

## Benefits of This System

1. **Separation of concerns**: External knowledge vs. internal thinking
2. **Flexible yet structured**: Hierarchy for facts, network for ideas
3. **Future-proof**: Plain text, standard markdown
4. **Tool-independent**: Works with any note-taking app
5. **Scalable**: Grows naturally without requiring reorganization
6. **Low friction**: Simple rules, easy to maintain
7. **Thinking-first**: Forces clarity through atomic notes and constrained length

## Getting Started

1. Create the folder structure
2. Start with fleeting notes—don't worry about perfection
3. Convert one fleeting note to a permanent note to learn the process
4. Build gradually—quality over quantity
5. Let the system evolve with the needs while maintaining core principles
