---
title: {{ title }}
date: {{ format-date now "%Y-%m-%d %H:%M:%S" }}
keywords: []
---

#{{extra.main_tag}}

# {{title}}

{{#if extra.source}}**Source:** {{extra.source}}{{/if}}
{{#if extra.author}}**Author:** {{extra.author}}{{/if}}

## Essence

{{content}}

## {{#if extra.is_literature}}

## Up

- []()

## Down

- []()
  {{/if}}

## {{#unless extra.is_literature}}

## Related Ideas

- []()
  {{/if}}
