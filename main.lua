local skynet = require "skynet"
local snax = require "skynet.snax"
local upgrade_fix = require 'upgrade_fix'

local is_windows = package.config:sub(1,1) == '\\'

skynet.start(function()
	skynet.error("FreeIOE@Skynet Starting")
	--skynet.newservice("exec_sal")
	if not is_windows and not os.getenv("IOE_RUN_AS_DAEMON") then
		local console = skynet.newservice("console")
	end
	--- Upgrade fix
	upgrade_fix()

	skynet.newservice("cfg")
	skynet.newservice("upgrader")
	skynet.newservice("ioe_ext")

	pcall(skynet.newservice, "debug_console", 6606)
	pcall(skynet.newservice, "lwf", 8808)

	local logger = snax.uniqueservice("logger")
	local cloud = snax.uniqueservice("cloud")
	local appmgr = snax.uniqueservice("appmgr")
	-- This is one comm data buffer service for get one snapshot
	local commlog = snax.uniqueservice("buffer")
	local ws = snax.uniqueservice("ws")

	skynet.exit()
end)
