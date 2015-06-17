-- module script

return {"setupgui",
	function(player)
		for i,v in next, _G.findplayer(player) do
			_G.setupgui(v)
		end
	end,
	"Gives silent command bar to player."
}
