---
date_created: {{ format-date now "%Y-%m-%d %H:%M" }}
---

# {{title}}
{{#if extra.is_literature}}
#source
{{else}}
#idea
{{/if}}

{{#if extra.source}}**Source:** {{extra.source}}{{/if}}
{{#if extra.author}}**Author:** {{extra.author}}{{/if}}

## Essence

{{content}}

{{#if extra.is_literature}}

## Up

- []()

## Down

- []()
{{/if}}

{{#if extra.is_idea}}

## Related Ideas

- []()
{{/if}}
