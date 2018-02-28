---
title: "Sleep"
date: 2018-02-27T12:56:10+05:30
weight: 1
---

**Wanted to insert a sleep call to let the system stabilize for my test asserts to run correctly.**

From what I can see, there is no system library function sleep as is in other languages.

But thanks to the C FFI, getting this working was as simple as:

```
@sleep[None](U32(5))
```

Ya, ya I know, the first learning is to use the C FFI to **introduce possibly unsafe behaviour**. In my case, it is OK (maybe), but I am not sure of the impact of such FFI calls in the long run and I think the official line would be towards avoiding this. This is not the best of advices.
