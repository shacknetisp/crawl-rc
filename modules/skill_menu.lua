-- Display skill menu on game start.
nrc.register_ready_start(function()
	if you.race() ~= "Gnoll" then
		crawl.sendkeys("m")
	end
end)
