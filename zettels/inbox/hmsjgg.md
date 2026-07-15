#source
2026-03-14 20:57

---

# Vim GQ Command - Format hard-wrapping lines of text

gq operates in three main ways:

1. With a motion: You provide a movement command after gq.

---

gqip formats the inner paragraph where the cursor is located.
gqap formats a paragraph (which includes surrounding whitespace).
gq} formats from the cursor to the end of the current paragraph.
gqG formats from the current line to the end of the file.
gqj formats the current and the next line.

---

2. As a standalone command:

---

## gqq is a special case that formats the current line only.

---

3. In Visual mode: You visually select text (using v, V, or Ctrl-v) and then press gq to format the selection.
