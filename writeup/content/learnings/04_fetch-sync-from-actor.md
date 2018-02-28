---
title: "Synchronous call on actor"
date: 2018-02-27T13:38:53+05:30
weight: 4
---

**I want to call a method on an actor. Meaning, I want to sycnhronously obtain a values from an actor.**

You cannot really call actor methods from outside, actor variables are all `tag`.

You use promises.

```
actor MyActor
  val number: U64
  be getNumber(p: Promise[U64]) =>
    p(number)
```

```
// assuming actor variable a
let p = Promise[U64]
a.getNumber(p)
p.next[None]({(n: U64) => /* do something with n */})
```
