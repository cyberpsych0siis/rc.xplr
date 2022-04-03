
local function parse_args(args)
  if args == nil then
    args = {}
  end

  if args.fifo_path == nil then
    args.fifo_path = "/tmp/xplr.fifo"
  end

  if args.fn_name == nil then
    args.fn_name = "rc"
  end

  if args.onentry == nil then
    args.onentry = "true"
  end

  if args.onexit == nil then
    args.onexit = "true"
  end

  return args
end

local function setup(args)
  args = parse_args(args)
  local xplr = xplr
  local messages = {}
  local rcCmd = "'" .. os.getenv("HOME") .. "/.config/xplr/plugins/rc/bin/rc' &"

  xplr.fn.custom[args.fn_name] = function(app)
    os.execute("[ ! -p '" .. args.fifo_path .."' ] && mkfifo '" .. args.fifo_path .. "'")
    local fullCmd = ("NNN_FIFO='" .. args.fifo_path .. "' RC_ONENTRY='" .. args.onentry  .. "' RC_ONEXIT='" .. args.onexit  .. "' " .. rcCmd)

    return {
      { Call = { command = "bash", args = {"-c", fullCmd} } },
      { StartFifo = args.fifo_path },
    }
  end
end

return { setup = setup }
