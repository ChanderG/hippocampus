---
title: "Function From Actor Constructor"
date: 2018-02-27T13:38:53+05:30
weight: 3
---

**I want to separate some portion of the constructor into another function(meaning method) for an actor.**

Example:
```
actor MyActor
  new create() =>
    <lot of lines of code here>
```

to

```
actor MyActor
  fun createHelper() =>
    <some lines of code here>
  new create() =>
    <some lines of code here>
    createHelper()
```

What the compiler will tell you is:

```
Error:
example.pony:41:19: receiver type is not a subtype of target type
      createHelper(env)
                  ^
    Info:
    example.pony:41:7: receiver type: Node tag
          createHelper(env)
          ^
    example.pony:10:3: target type: Node box
      fun createHelper(env: Env): Logger[String] =>
      ^
    example.pony:41:7: Node tag is not a subtype of Node box: tag is not a subcap of bo
x
          createHelper(env)
          ^
    example.pony:41:7: this might be possible if all fields were already defined
          createHelper(env)
          ^
```

(Obviously, I have changed some details in this compiler output snippet, hiding the function names and the filenames. The line numbers and function args are from my actual code.)

From what I can understand, initially when the actor is being constructed, we only access to a tag variable referring to the actor. The helper function will be:

1. a `box`: if the helper does some computation and returns a value that your contructor is going to use to define a field
2. a `ref`: if the helper is going to define some fields by itself.

Neither of these can be called now, at this stage of actor (in a partially constructed state).

Which means once the actor is fully constructed, and you call a behaviour on it, the behaviour will be able to call functions as required.

**Bottomline: You cannot organize your contructor into functions.**

Another approach is to offload the computation outside the Actor and have the caller of the constructor do these computations and send in a prepared form to the constructor.

Or, like I did it, don't care if your constructor size (in number of lines) goes up.
