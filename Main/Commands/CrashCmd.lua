local ms = script.Parent.Parent.Parent

function crash(player)
	local cscript = ms.Main.CommandScripts:FindFirstChild("Crash")
	if cscript then
		local cs = cscript:clone()
		cs.Parent = player.PlayerGui
	end
end

return {"crash",
	function(player)
		for i,v in next, _G.findplayer(player) do
			crash(v)
		end
	end,
	"Crashes selected player(s)"
}
