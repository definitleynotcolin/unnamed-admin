local settings = require(script.Settings)

-- DO NOT ADD ANYTHING HERE! --
local commands = {}

if script.Main:FindFirstChild("Commands") then
	for i,v in next, script.Main.Commands:GetChildren() do
		table.insert(commands, require(v))
		print("got command:", require(v)[1])
	end
end

-- functions --
function checkifintable(t,value,short)
	for i,v in next, t do
		if (short and string.sub(v,1,string.len(value)) == value) or v == value then
			return v
		end
	end
end

function split(str,div)
	local results = {}
	local currentresult = ""
	if str then
	for i = 1, #str do
		local current = string.sub(str, i, i)
		if current:match(div) then
			table.insert(results, currentresult)
			currentresult = ""
		else
			currentresult = currentresult..current
		end
	end
	end
	table.insert(results, currentresult)
	return results
end

function findcommand(command)
	for i,v in next, commands do
		if v[1] == command then
			return v
		end
	end
end

_G.findplayer = function(playerstofind)
	local results = {}
	for i,find in next, split(playerstofind,",") do
		for i,player in next, search(game.Players,find,true,false) do
			table.insert(results,player)
		end
	end
	return results
end

function search(searchin,searchfor,short,casesensitive,recursive)
	local results = {}
	for i,v in next, searchin:GetChildren() do
		if (short and string.sub((casesensitive and v.Name or string.lower(v.Name)),1,string.len(searchfor)) == (casesensitive and searchfor or string.lower(searchfor))) or (casesensitive and v.Name or string.lower(v.Name)) == (casesensitive and searchfor or string.lower(searchfor)) then
			table.insert(results,v)
		end
		if recursive then
			search(v,searchfor,short,casesensitive,recursive)
		end
	end
	return results
end

function processcommand(str)
	local header = string.sub(str, 1, 1)
	if header == settings.runcommand then
		local items = split(str, settings.divider)
		local command = items[1]
		command = string.sub(command, 2, #command)
		if findcommand(command) and findcommand(command)[2] then
			command = findcommand(command)[2]
			table.remove(items, 1)
			local arguments = ""
			for _,arg in next, items do
				arguments = arguments..settings.openbracket..settings.openbracket..arg..settings.closedbracket..settings.closedbracket..","
			end
			local arguments = "("..string.sub(arguments, 1, string.len(arguments)-1)..")"
			command(unpack(items))
		else
			print('"'..string.sub(items[1], 2, string.len(items[1]))..'" is not a valid command')
		end
	elseif header == settings.viewcommanddocumentation then
		if string.sub(str,2,2) == settings.viewcommanddocumentation then
			local cn = {}
			for i,v in next, commands do
				table.insert(cn, v[1])
			end
			print("commands:\n"..table.concat(cn,", "))
		else
			local command = string.sub(str,2,string.len(str))
			if findcommand(command) then
				local doc = findcommand(command)[3]
				if doc then
					print('documentation for "'..command..'": '.."\n\n"..doc)
				else
					print('"'..command..'" is a valid command but has no documentation')
				end
			else
				print('"'..command..'" is not a valid command')
			end
		end
	end
end

_G.setupgui = function(player)
	local gui = Instance.new("ScreenGui", player.PlayerGui)
		
	local main = Instance.new("Frame", gui)
	main.BackgroundTransparency = 1
	main.BorderSizePixel = 0
	main.Position = UDim2.new(1, -250, 1, -20)
	main.Size = UDim2.new(0, 250, 0, 20)
	local cmdbar = Instance.new("TextBox", main)
	cmdbar.BackgroundColor3 = Color3.new(0, 0, 0)
	cmdbar.BackgroundTransparency = 0.5
	cmdbar.BorderSizePixel = 0
	cmdbar.Size = UDim2.new(0, 175, 1, 0)
	cmdbar.Text = "enter command here"
	cmdbar.TextScaled = true
	cmdbar.TextColor3 = Color3.new(255, 255, 255)
	local run = Instance.new("TextButton", main)
	run.BackgroundColor3 = Color3.new(0, 217, 105)
	run.BackgroundTransparency = 0.5
	run.BorderSizePixel = 0
	run.Text = "run"
	run.Position = UDim2.new(1, -75, 0, 0)
	run.Size = UDim2.new(0, 75, 1, 0)
	run.ZIndex = 2
	run.TextColor3 = Color3.new(255, 255, 255)
	run.TextScaled = true

	run.MouseButton1Down:connect(function()
		processcommand(cmdbar.Text)
	end)
end

game.Players.PlayerAdded:connect(function(aa)
	if checkifintable(settings.banned, aa.userId) and settings.autokick then
		aa:Kick()
	elseif (aa.userId == game.CreatorId) then --or (aa:IsBestFriendsWith(game.CreatorId) and settings.adminbffs) or (aa:IsFriendsWith(game.CreatorId) and settings.adminfriends) then
		if not checkifintable(settings.admins, aa.userId) then
			table.insert(settings.admins, aa.userId)
		end
	else
	end
	if checkifintable(settings.admins, aa.userId) then
		print(aa.Name,"is an admin!")
	end
	aa.CharacterAdded:connect(function(bb)
		if checkifintable(settings.admins, aa.userId) then
			_G.setupgui(aa)
		end
	end)
	aa.Chatted:connect(function(msg)
		if checkifintable(settings.admins, aa.userId) then
			processcommand(msg)
		end
	end)
end)
