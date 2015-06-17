-- module script

return {
	"removeforcefield",
	function(player)
		for _,player in next, _G.findplayer(player) do
			for i,v in next, player.Character:GetChildren() do
				if v:IsA("ForceField") then
					v:destroy()
				end
			end
		end
	end,
	"Removes said ForceField from player"
}
