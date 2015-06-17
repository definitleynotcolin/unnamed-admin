-- module script

return {"kill",
	function(player)
		for i,v in next, _G.findplayer(player) do
			v.Character.Humanoid.Health = 0
		end
	end,
	"Kills listed players."
}
