---
name: 'tryhackme-room'
description: 'Create a new TryHackMe room directory structure'
message: 'Create a new room: {{ inputs.name }}'
root: '.'
output: '.'
ignore: []
questions:
  name: 'Please enter the room directory name (e.g., 09_example_room)'
  roomUrl: 'Please enter the TryHackMe room URL'
---

# `{{ inputs.name }}/README.md`

```
# Room Title

## Room Information

- **Room URL:** {{ inputs.roomUrl }}
- **Date Completed:** YYYY-MM-DD

## Overview

## Reconnaissance
### Scan ports

### Access the website
http://<target-ip>

## Exploitation

## Get user flag

## Completed

## Used Tools

- rustscan

## References
- [Reference URL](https://example.com)
```

# `{{ inputs.name }}/images/.gitkeep`

```
```

# `{{ inputs.name }}/src/.gitkeep`
```
```