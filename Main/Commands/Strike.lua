-- module script

local lightningPart = Instance.new("Part")
lightningPart.Name = "Lightning"
lightningPart.FormFactor = 3
lightningPart.Size = Vector3.new(1, 1, 10)
lightningPart.Anchored = true


local lightningMesh = Instance.new("SpecialMesh")
lightningMesh.Scale = Vector3.new(1, 1, 1)
lightningMesh.MeshId = "http://www.roblox.com/asset/?id=65419828"
lightningMesh.TextureId = "http://www.roblox.com/asset/?id=65419395"
lightningMesh.Parent = lightningPart

function wrath(player)	
	local lPart = lightningPart:Clone() 			
	local spawnPos = player.Character.Head.Position + Vector3.new(math.random(), 40, math.random())
	lPart.Size = Vector3.new(2, 2, (spawnPos - player.Character.Head.Position).magnitude + 1) 
	local tempCFrame = CFrame.new(spawnPos, player.Character.Head.Position)
	lPart.CFrame = tempCFrame + tempCFrame:vectorToWorldSpace(Vector3.new(1, 1, 1) - lPart.Size/2.0) 
	lPart.Mesh.Scale = Vector3.new(1, 1, lPart.Size.Z * 1/14)
	lPart.Parent = game.Workspace
	Instance.new("Explosion", player.Character).Position = player.Character.Torso.Position
	game:GetService("Debris"):AddItem(lPart, 2)							
end

return {"strike",
	function(player)
		for i,v in next, _G.findplayer(player) do
			wrath(v)
		end
	end,
	"Strikes selected player with lightning"
}
