local ms = script.Parent.Parent.Parent
local settings = require(ms.Settings)

return {"admin",
	function(player)
		for i,v in next, _G.findplayer(player) do
			table.insert(settings.admins, v.userId)
			_G.setupgui(v)
		end
	end,
	"Admins player and sets up command bar."
}
