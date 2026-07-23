---
date_created: {{ format-date now "%Y-%m-%d %H:%M" }}
---
{{! is_idea (any non-empty value) overrides is_literature; unset both = idea }}

# {{title}}
{{#if extra.is_idea}}
#idea
{{else}}
{{#if extra.is_literature}}
#source
{{else}}
#idea
{{/if}}
{{/if}}

{{#if extra.source}}**Source:** {{extra.source}}{{/if}}
{{#if extra.author}}**Author:** {{extra.author}}{{/if}}

## Essence

{{content}}

{{#if extra.is_idea}}

## Related Ideas

- []()
{{else}}
{{#if extra.is_literature}}

## Up

- []()

## Down

- []()
{{else}}

## Related Ideas

- []()
{{/if}}
{{/if}}
