---
layout: post
title: "Python: Recursive defaultdict"
categories: thoughts
comments: true
published: true 
---

# Recursive defaultdict

In python, it's often the case I find myself wanting the ability to very quickly construct dictionaries with nested structures. 
Unfortunately, the following use case is not easy to accomplish with standard python dictionaries:

```python3
dct = {}
dct['a'] = 1
dct['deep']['nested']['auto']['inferred']['structure'] = 2

print(dct)

"""
Prints: 
{
    'a': 1,
    'deep': {
        'nested': {
            'auto': {
                'inferred': {
                    'structure': 2,
                }
            }
        }
    },
}
"""

```


After a little bit of exploration with the python `defaultdict` collection, I found that this easy enough to accomplish with some fun recursive trickery.

```

from collections import defaultdict
def reflect():
    return defaultdict(reflect)

dct = defaultdict(reflect)
```

