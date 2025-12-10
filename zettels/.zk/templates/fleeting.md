{{#if extra.is_literature}}
#source
{{else}}
#idea
{{/if}}
{{format-date now "%Y-%m-%d %H:%M"}}

# {{title}}

{{#if extra.source}}Source: {{extra.source}}{{/if}}
{{#if extra.author}}Author: {{extra.author}}{{/if}}
{{content}}
