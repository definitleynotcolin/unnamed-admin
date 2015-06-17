-- module script

_G.shout = function(player, text, time)
	local tm
	local gui = Instance.new("ScreenGui", player.PlayerGui)
	local lbl = Instance.new("TextLabel", gui)
	lbl.Size = UDim2.new(0, 300, 0, 200)
	lbl.Position = UDim2.new(0.5, -150, 0.5, -100)
	lbl.BorderSizePixel = 0
	lbl.BackgroundTransparency = 0.3
	lbl.TextColor3 = Color3.new(255, 255, 255)
	lbl.BackgroundColor3 = Color3.new(0, 0, 0)
	lbl.TextScaled = true
	lbl.TextWrapped = true
	lbl.Text = text
	if not tm then
		tm = 3
	else
		tm = time
	end
	wait(time)
	gui:destroy()
end

return {"shout",
	function(text, time)
		for i,v in next, game.Players:GetPlayers() do
			_G.shout(v, text, time)
		end
	end,
	"Shouts specific text"
}
