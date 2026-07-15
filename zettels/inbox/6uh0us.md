---
date_created: 2026-01-28 09:53
---

# Linux - Get CPU and Memory specs
#source

**Source**:
**Author**:

## USING free

```sh
free -h
```

## meminfo

```sh
grep MemTotal /proc/meminfo
```

## Show cpu info using lscpu

```sh
lscpu
```

## Show numbers of cpu cores

```sh
nproc
```

## Detailed cpu info fro /proc/cpuinfo

```sh
cat /proc/cpuinfo | grep -E 'model name|core id' | uniq
```

## Summary using lshw

```sh
lshw -short | grep -E 'processor|memory'
```
