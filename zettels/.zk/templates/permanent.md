---
title: {{title}}
type: permanent
created: {{format-date now "%Y-%m-%d %H:%M:%S"}}
modified: {{format-date now "%Y-%m-%d %H:%M:%S"}}
keywords: {{#if extra.keywords}}{{extra.keywords}}{{else}}[]{{/if}}
aliases: []
# Zettelkasten metadata
related: []
links: []
backlinks: []
# Source information (for literature notes only)
{{#if extra.source}}source: {{extra.source}}{{/if}}
{{#if extra.author}}author: {{extra.author}}{{/if}}
# Note metadata
wordcount: 0
status: draft
---

#{{extra.main_tag}} #{{extra.main_tag}}
# {{title}}

{{#if extra.source}}**Source:** {{extra.source}}{{/if}}
{{#if extra.author}}**Author:** {{extra.author}}{{/if}}

## Essence
{{content}}

{{#if extra.is_literature}}
---

## Parent
- []()

## Children
- []()
{{/if}}

{{#if extra.is_idea}}
---

## Related Ideas
- []()
{{/if}}
