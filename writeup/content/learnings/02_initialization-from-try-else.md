---
title: "Initialization From Try Else"
date: 2018-02-27T13:39:24+05:30
weight: 2
---

**Wanted to initialize the logger val variable from either the try block or the else block.**

The context is this:
```
actor MyActor
  let logtype: String

  new create() =>
    try
      // somepotentially unsafe operation here like File creation/opening
      logtype = "file"
    else
      logtype = "stdout"
    end
    // use logtype somehow here
```

Problem is, this does not compile. The compiler says something along the lines of :
```
field left undefined in constructor
...
constructor with undefined fields
```

Well we *have* taken care of the field in both the try and the else block, but the compiler is the boss.

Mind you, the same thing happens even with a `ref` variable.

### Solution 1: Let's set the else clause portion before the try-else block.

Not happening, logtype is a `val`, meaning it can only be defined once. If the try succeeds, you know what will happen. This does work using a `ref`.

### Solution 2: Can we use the `then` clause?

Yes, you can. The compiler does not complain then. But same as above, does not suit us right here.

### Solution 3: Use `recover end` with solution 1 for `ref`.

This works. So basically:
```
logtype = recover val
  var logtypeTmp = "initial value"
  try
    <as before>
  else
    <as before>
  end

  logtypeTmp
end
```

Mind you, you need a unique name for the inner variable, it cannot also be logtype in this example.

**Bottomline: You cannot hope to define a variable (of any type) only in a try-else block. There needs to be a definition outside, before the try-else block, or inside the then clause.**
