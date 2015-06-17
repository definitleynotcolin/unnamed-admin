-- module script

return {"fire",
	function(player)
		for i,v in next, _G.findplayer(player) do
			for i,v in next, v.Character:GetChildren() do
				if v:IsA("Part") then
					Instance.new("Fire", v)
				end
			end
		end
	end,
	"Instances fire in character"
}
