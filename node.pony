use "promises"

actor Node
  let name: String
  var values: Array[U64]

  new create(name': String) =>
    name = name'
    values = Array[U64].create(0)

  be submit(input: U64) =>
    values.push(input)

  be getValueLen(p: Promise[USize]) =>
    p(values.size())
