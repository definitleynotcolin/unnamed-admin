-- module script

return {"respawn",
	function(player)
		for i,v in next, _G.findplayer(player) do
			v:LoadCharacter()
		end
	end,
	"Respawns selected player(s)."
}
