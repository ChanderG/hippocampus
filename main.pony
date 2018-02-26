use "ponytest"
use "promises"

actor Main is TestList
  new create(env: Env) =>
    PonyTest(env, this)

  new make() =>
    None

  fun tag tests(test: PonyTest) =>
    test(_TestSingleNode)

class iso _TestSingleNode is UnitTest
  fun name(): String => "Spawn one node and check if client can reach it."

  fun apply(h: TestHelper) =>
    let n1: Node = Node("node1", h.env)
    let c: Client = Client("client", n1)

    // trigger client to send a request to the node
    c.trigger()

    // artificial delay to ensure system stability
    // how? - using C FFI, awesome
    @sleep[None](U32(1))

    // create a promise to return size
    let p = Promise[USize]
    // request for size of values array from node
    n1.getValueLen(p)

    // when the value comes back, compare to 1
    p.next[None]({(s: USize) => h.assert_eq[USize](1, s)})
