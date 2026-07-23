---
date_created: {{format-date now "%Y-%m-%d %H:%M"}}
---
{{! is_idea (any non-empty value) overrides the notebook's is_literature default }}

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

{{#unless extra.is_idea}}
{{#if extra.is_literature}}
**Source**:
**Author**:
{{/if}}
{{/unless}}

{{content}}
