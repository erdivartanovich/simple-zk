---
date_created: 2026-07-29 19:05
title: Pandoc - Markdown to HTML Guide
---

#source

## Pandoc Markdown to HTML Compilation Guide

### 1. Single File Conversion with Custom Template
To convert a Markdown file to HTML using a custom template, run the command **`pandoc input.md -o output.html --template=template.html`**. You must include the `--template` flag to merge your file with a skeleton layout.

#### Build the HTML Template File
Create a text file named `template.html`. Use Pandoc variables wrapped in dollar signs (`$variable$`) to dictate where your markdown content and metadata will be placed:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>title</title>
    <!-- Optional: link an external stylesheet -->
    for(css)
    <link rel="stylesheet" href="css">
    endfor
</head>
<body>
    <header>
        <h1>title</h1>
        <p>By author on date</p>
    </header>

    <main>
        <!-- This is where your Markdown content is inserted -->
        body 
    </main>
</body>
</html>
```

#### Set Up Your Markdown File
Create your Markdown file (e.g., `input.md`). You can define variables like `$title$`, `$author$`, and `$date$` dynamically using a YAML metadata block at the top of the file:

```markdown
---
title: "My Document Title"
author: "Jane Doe"
date: "2026-07-29"
css: "styles.css"
---

### Introduction
This content will replace the `$body$` variable in the template.

* Fast execution.
* Clean structure.
```

#### Run the Conversion Command
Open your terminal and run the compile command:

```bash
pandoc input.md -o output.html --template=template.html
```

#### Pro-Tips
* **See Defaults**: Run `pandoc -D html` to view or copy Pandoc's built-in default HTML template.
* **Embed Images/CSS**: Add the `--embed-resources --standalone` flags if you want Pandoc to bake all external assets (like stylesheets and images) directly into a single, highly portable HTML file.

---

### 2. Combining Multiple Templates
Pandoc does not allow you to pass multiple files into a single `--template` argument. Instead, you can combine multiple templates using **partials**, **inclusion flags**, or **nested variables**.

#### Method A: The Partials Approach (Best for Modular Templates)
Pandoc allows templates to reference external "partial" templates. 
1. Create a main template file named `main.html`.
2. Create sub-templates in the same directory (or inside a folder named `templates`). For example, create `_header.html` and `_footer.html`.
3. Reference them in `main.html` using the `${partials()}` syntax:

```html
<!DOCTYPE html>
<html>
<head>
    <title>title</title>
</head>
<body>
    \${ _header() }
    <main>
        \$body\(</main>\){ _footer() }
</body>
</html>
```
**Command:** `pandoc input.md -o output.html --template=main.html`

#### Method B: The Include Flags Approach (Best for Injecting Code Blocks)
If you just want to inject separate files (like a navigation bar, a tracking script, or a specific CSS block) without rewriting your main template, use Pandoc's built-in inclusion flags:

* `--include-in-header=meta.html` (Inserts content just before `</head>`)
* `--include-before-body=nav.html` (Inserts content just after `<body>`)
* `--include-after-body=footer.html` (Inserts content just before `</body>`)

**Command:**
```bash
pandoc input.md -o output.html \
  --template=base.html \
  --include-before-body=nav.html \
  --include-after-body=footer.html
```

#### Method C: The YAML Metadata Approach (Best for Dynamic Layouts)
You can treat template snippets as strings or files passed directly through your Markdown file's YAML header.

**In your Markdown file:**
```markdown
---
title: "My Page"
sidebar_layout: "left-sidebar.html"
---
```

**In your main template:**
```html
<div class="container">
    \(if(sidebar_layout)\)
        <!-- Pandoc will insert the value or file specified here -->
        \(include(sidebar_layout)\) 
    endif
    <div class="content">body</div>
</div>
```

---

### 3. Batch Compiling All Markdown Files in a Directory
To compile all `.md` files in a directory into separate HTML files, you cannot just use a wildcard like `pandoc *.md`, because Pandoc will combine all those Markdown files into a single HTML document. Instead, use a loop or script.

#### For macOS / Linux (Bash or Zsh)
Run this single-line loop directly in your terminal where your files are located:

```bash
for f in *.md; do pandoc "f" -o "{f%.md}.html" --template=template.html; done
```

#### For Windows (PowerShell)
Open PowerShell in your project folder and run:

```powershell
Get-ChildItem *.md | ForEach-Object { pandoc \(_.FullName -o (\)_.BaseName + ".html") --template=template.html }
```

#### Using a Makefile (Best for Repeat Projects)
If you build these files frequently, create a file named `Makefile` in your directory with the following content:

```makefile
# Find all markdown files
MARKDOWN_FILES := \$(wildcard *.md)
# Define the expected html outputs
HTML_FILES := \$(MARKDOWN_FILES:.md=.html)

# Default target builds everything
all: \$(HTML_FILES)

# Rule to convert .md to .html
%.html: %.md template.html
	pandoc < -o @ --template=template.html

# Clean up generated html files
clean:
	rm -f \$(HTML_FILES)
```

Now, whenever you update your Markdown files, you just type **`make`** in your terminal, and it will only rebuild the files that have changed.

---

### 4. Automatically Generating an Index / Homepage
If you are generating dozens of HTML files, manually maintaining a homepage (`index.html`) with links to all your pages becomes tedious. You can automate this process via scripting.

#### Automated Indexing via Bash (macOS / Linux)
Add this script snippet to your build process to generate a dynamic markdown index file before rendering it via Pandoc:

```bash
# Clear out or create index.md
echo -e "---\ntitle: \"Site Index\"\n---\n\n# All Pages\n" > index.md

# Loop through files and append markdown links (excluding index itself)
for f in *.md; do
  if [ "\$f" != "index.md" ]; then
    filename="\${f%.md}.html"
    echo "* [\(f](\)filename)" >> index.md
  fi
done

# Compile the final index page
pandoc index.md -o index.html --template=template.html
```

---

### 5. Handling Relative File Paths for Static Assets
When your project scales and your Markdown files get sorted into subdirectories (e.g., `blog/post1.md`), referencing common assets like CSS files or images requires careful root mapping or template logic.

#### Problem
If your CSS file is located in the root directory (`/styles.css`) and you use a hardcoded relative path like `<link rel="stylesheet" href="styles.css">`, it will break on pages inside a subfolder (like `/blog/post1.html`) because that folder expects the CSS to be in `/blog/styles.css`.

#### Solutions

##### Solution A: Relative Variable Mapping
Pass a base path variable inside the YAML front-matter of your subfolder files.

**In `/blog/post1.md`:**
```markdown
---
title: "Blog Post"
root_path: "../"
---
```

**In your HTML template:**
```html
<link rel="stylesheet" href="\(if(root_path)\)\(root_path\)endifstyles.css">
<img src="\(if(root_path)\)\(root_path\)endifimages/logo.png" alt="Logo">
```

##### Solution B: Absolute Paths (Recommended for Local Servers / Domains)
If you plan to run a local web server (`npx serve`, Python `http.server`) or host online, always use root-relative absolute paths starting with a forward slash `/`.

```html
<!-- This will always search the absolute root folder, regardless of subfolder deepness -->
<link rel="stylesheet" href="/styles.css">
<script src="/js/app.js"></script>
```

##### Solution C: Pandoc Resource Path Flag
If your images are spread across different directories but you want Pandoc to locate them successfully during compilation, tell Pandoc where to look using the `--resource-path` flag:

```bash
pandoc input.md -o output.html --template=template.html --resource-path=.:images:assets/img
```
*(This tells Pandoc to search for image references in the current directory, the `images` directory, and the `assets/img` directory sequentially).*
