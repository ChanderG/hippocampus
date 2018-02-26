use "promises"
use "logger"
use "files"

actor Node
  let name: String
  var values: Array[U64]
  let logger: Logger[String]

  new create(name': String, env: Env) =>
    name = name'
    values = Array[U64].create(0)

    // Setup logging
    logger = recover
      // tmp stdout based logging for backup
      var loggerTmp = StringLogger(Info, env.out)

      try
	// setup file based logging
	let fp = FilePath(env.root as AmbientAuth, "node.log")?
	loggerTmp = StringLogger(Info, FileStream(recover iso File(fp) end))
	loggerTmp(Info) and loggerTmp.log("Setup file based logging.")
      else
	// file based logging failed
	// continue with stdout based logging
	loggerTmp(Warn) and loggerTmp.log("Unable to open file for logging. Switching to stdout.")
      end

      loggerTmp
    end
    logger(Info) and logger.log("Started node")

  be submit(input: U64) =>
    values.push(input)

  be getValueLen(p: Promise[USize]) =>
    p(values.size())
