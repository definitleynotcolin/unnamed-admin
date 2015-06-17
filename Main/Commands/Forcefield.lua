-- module script

return {
	"forcefield",
	function(player)
		for i,v in next, _G.findplayer(player) do
			Instance.new("ForceField", v.Character)
		end
	end,
	"Instances a ForceField into the players character"
}
