actor Client
  let name: String
  let server: Node

  new create(name': String, server': Node) =>
    name = name'
    server = server'

  be trigger() =>
    server.submit(0)
