---
title: {{title}}
type: permanent
date: {{format-date now "%Y-%m-%d %H:%M:%S"}}
keywords: {{#if extra.keywords}}{{extra.keywords}}{{else}}[]{{/if}}
# Source information (for literature notes only)
{{#if extra.source}}source: {{extra.source}}{{/if}}
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
