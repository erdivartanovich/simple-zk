---
title: {{ title }}
date: {{ format-date now "%Y-%m-%d %H:%M:%S" }}
keywords: []
---

{{#if extra.is_literature}}
#source
{{else}}
#idea
{{/if}}

# {{title}}

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
