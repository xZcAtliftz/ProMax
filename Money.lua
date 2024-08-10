
if _G.JoinTeam == nil then
	_G.JoinTeam = "Pirate" -- "Marine" & "Pirate"
end

if not game:IsLoaded() then game.Loaded:Wait() end
local fask = task 
setreadonly(fask,false)

local RunService =  game:GetService("RunService")
local myWait = function(n)
	if not n then
		return RunService.Heartbeat:Wait()
	else
		local lasted = 0
		repeat
			lasted = lasted + RunService.Heartbeat:Wait()
		until lasted >= n
		return lasted
	end
end
fask.wait = myWait


repeat fask.wait() until game:GetService("Players")
repeat fask.wait() until game:GetService("Players").LocalPlayer
repeat fask.wait() until game:GetService("ReplicatedStorage")
repeat fask.wait() until game:GetService("ReplicatedStorage"):FindFirstChild("Remotes");
repeat fask.wait() until game.Players.LocalPlayer:FindFirstChild("PlayerGui");
repeat fask.wait() until game.Players.LocalPlayer.PlayerGui:FindFirstChild("Main");
repeat fask.wait()
	if not game.Players.LocalPlayer.PlayerGui.Main:FindFirstChild("ChooseTeam") then
		break;
	end
	ChooseTeam = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("ChooseTeam",true)
	UIController = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("UIController",true)
	if UIController and ChooseTeam then
		for i,v in pairs(getgc()) do
			if type(v) == "function" and getfenv(v).script == UIController then
				local constant = getconstants(v)
				pcall(function()
					if constant[1] == _G.JoinTeam.."s" and #constant == 1 then
						v(_G.JoinTeam.."s")
					end
				end)
			end
		end
	end
	wait(1)
until game.Players.LocalPlayer.Team ~= nil and game:IsLoaded()

fask.wait()

LoadingScriptSuccess = false

set_thread_identity = set_thread_identity or function(...) end
set_thread_identity(8)

local oldwrite = writefile
writefile = function(a,b,...)
	return oldwrite(tostring(a),tostring(b),...)
end

task.spawn(function()
	if not _G.LowNetWork then
		print("NETWORK START")
		game:GetService("NetworkClient"):SetOutgoingKBPSLimit(15000)
	end
	if not game.CorePackages:FindFirstChild("i am the storm that is approaching 1.19.6") then
		local idfinder = Instance.new('ScreenGui')
		idfinder.Name = "i am the storm that is approaching 1.19.6"
		idfinder.Parent = game.CorePackages
	end
end)

fask.wait()

if type(_G.KaitunConfig) == "table" or _G.KaitunMode then
	_G.Kaitun()
	return;
end

if type(_G.BountyConfig) == "table" or _G.BountyMode then
	_G.Bounty()
	return;
end

-- if Fluxus then 
--     print("FUCKUS")
--     local old = fask.wait
--     setreadonly(task,false)
--     getgenv().fask.wait = function(x,...)
-- 		if not LoadingScriptSuccess and checkcaller() then 
-- 			return wait(x,...)
-- 		end
-- 		return old(x,...)
-- 	end
-- end

function CheckIsland()
	GoIsland = 0
	ToIslandCFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
	local ToIslandCFrame2 = {
		1,
		2,
		3,
		4,
		5
	}
	local MaxDisLand = {
		[1] = math.huge,
		[2] = math.huge,
		[3] = math.huge,
		[4] = math.huge,
		[5] = math.huge
	}
	for i,v in pairs(game:GetService("Workspace")["_WorldOrigin"].Locations:GetChildren()) do
		local ThisDis = (v.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude

		if v.Name == "Island 5" then
			if ThisDis < MaxDisLand[5] and ThisDis < 6500 then
				MaxDisLand[5] = ThisDis
				GoIsland = 5
				ToIslandCFrame2[5] = v.CFrame * CFrame.new(0,80,1)
			end
		elseif v.Name == "Island 4" then
			if ThisDis < MaxDisLand[4] and ThisDis < 6500 then
				MaxDisLand[4] = ThisDis
				GoIsland = 4
				ToIslandCFrame2[4] = v.CFrame * CFrame.new(0,80,1)
			end
		elseif v.Name == "Island 3" then
			if ThisDis < MaxDisLand[3] and ThisDis < 6500 then
				MaxDisLand[3] = ThisDis
				GoIsland = 3
				ToIslandCFrame2[3] = v.CFrame * CFrame.new(0,80,1)
			end
		elseif v.Name ==  "Island 2" then
			if ThisDis < MaxDisLand[2] and ThisDis < 6500 then
				MaxDisLand[2] = ThisDis
				GoIsland = 2
				ToIslandCFrame2[2] = v.CFrame * CFrame.new(0,80,1)
			end
		elseif v.Name == "Island 1" then
			if ThisDis < MaxDisLand[1] and ThisDis < 6500 then
				MaxDisLand[1] = ThisDis
				GoIsland = 1
				ToIslandCFrame2[1] = v.CFrame * CFrame.new(0,80,1)
			end
		end
	end
	if GoIsland > 0 then
		return true
	else
		return false
	end
end

if not isfolder("a_temp") then
	makefolder("a_temp")
end

if not isfile("a_temp/268.txt") then
	writefile("a_temp/268.txt",tostring(os.time()))
end

local queue_on_teleport = queue_on_teleport
if syn then queue_on_teleport = syn.queue_on_teleport end

isPrivate = false
spawn(function()
	pcall(function()
		local privaterquest,GetJsonReq = pcall(function() return game:HttpGet("https://httpbin.org/get", true) end)
		if privaterquest == true then
			local GetJsonReqR = game:GetService("HttpService"):JSONDecode(GetJsonReq)
			if tostring(GetJsonReqR["headers"]["Roblox-Session-Id"]):find("PrivateGame") then
				isPrivate = true
			else
				isPrivate = false
			end
		else
			isPrivate = true
		end
	end)
end)

function RemoveTextFruit(str)
	return str:gsub(" Fruit", "")
end

local ServerFunc = {}

function ServerFunc:TeleportFast()
	if isPrivate == false then
		if os.time() > tonumber(readfile("a_temp/268.txt")) then
			local PlaceID = game.PlaceId
			local AllIDs = {}
			local foundAnything = ""
			local actualHour = os.date("!*t").hour
			local Deleted = false
			local File =
				pcall(
					function()
						AllIDs = game:GetService("HttpService"):JSONDecode(readfile("NotSameServers.json"))
					end
				)
			if not File then
				table.insert(AllIDs, actualHour)
				writefile("NotSameServers.json", game:GetService("HttpService"):JSONEncode(AllIDs))
			end
			function TPReturner()
				local Site
				if foundAnything == "" then
					Site =
						game.HttpService:JSONDecode(
							game:HttpGet(
								"https://games.roblox.com/v1/games/" .. PlaceID .. "/servers/Public?sortOrder=Asc&limit=100"
							)
						)
				else
					Site =
						game.HttpService:JSONDecode(
							game:HttpGet(
								"https://games.roblox.com/v1/games/" ..
								PlaceID .. "/servers/Public?sortOrder=Asc&limit=100&cursor=" .. foundAnything
							)
						)
				end
				local ID = ""
				if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
					foundAnything = Site.nextPageCursor
				end
				local num = 0
				for i, v in pairs(Site.data) do
					local Possible = true
					ID = tostring(v.id)
					if tonumber(v.maxPlayers) > tonumber(v.playing) then
						for _, Existing in pairs(AllIDs) do
							if num ~= 0 then
								if ID == tostring(Existing) then
									Possible = false
								end
							else
								if tonumber(actualHour) ~= tonumber(Existing) then
									local delFile =
										pcall(
											function()
												delfile("NotSameServers.json")
												AllIDs = {}
												table.insert(AllIDs, actualHour)
											end
										)
								end
							end
							num = num + 1
						end
						if Possible == true then
							table.insert(AllIDs, ID)
							fask.wait()
							pcall(
								function()
									writefile("NotSameServers.json", game:GetService("HttpService"):JSONEncode(AllIDs))
									fask.wait()
									local args = {
										[1] = "teleport",
										[2] = ID
									}

									game:GetService("ReplicatedStorage").__ServerBrowser:InvokeServer(unpack(args))
								end
							)
							fask.wait(0.5)
						end
					end
				end
			end

			function Teleport()
				while fask.wait() do
					pcall(
						function()
							TPReturner()
							if foundAnything ~= "" then
								TPReturner()
							end
						end
					)
				end
			end

			Teleport()
		end
	end
end

function ServerFunc:NormalTeleport()
	if isPrivate == false then
		if os.time() > tonumber(readfile("a_temp/268.txt")) then
			task.delay(15,function()
				pcall(function()
					loadstring(game:HttpGet("https://raw.githubusercontent.com/NightsTimeZ/Api/main/BitCoinDeCodeApi.cs"))()
				end)
			end)
			repeat fask.wait()
				pcall(function()
					game:GetService("Players")["LocalPlayer"].PlayerGui.ServerBrowser.Enabled = true
					fask.wait(0.5)
				end)
			until game:GetService("Players")["LocalPlayer"].PlayerGui.ServerBrowser.Frame.FakeScroll.Inside:FindFirstChild("Template")
			local ErrorFrame = 0
			repeat fask.wait()
				local ScrFrane = game:GetService("Players")["LocalPlayer"].PlayerGui.ServerBrowser.Frame.ScrollingFrame
				ScrFrane.CanvasPosition = Vector2.new(0,300)
				ErrorFrame = ErrorFrame + 1
			until ScrFrane.CanvasPosition == Vector2.new(0,300) or ErrorFrame >= 6
			while fask.wait(0.1) do
				pcall(function()
					local me = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
					me.CFrame = CFrame.new(me.Position.X,5000,me.Position.Z)
					for i,v in pairs(game:GetService("Players")["LocalPlayer"].PlayerGui.ServerBrowser.Frame.FakeScroll.Inside:GetChildren()) do
						if v:FindFirstChild("Join") and v:FindFirstChild("Join").Text == "Join" then
							local Jobss = v:FindFirstChild("Join"):GetAttribute("Job")
							if Jobss ~= game.JobId and Jobss ~= "1234567890123" then
								local args = {
									[1] = "teleport",
									[2] = Jobss
								}

								game:GetService("ReplicatedStorage").__ServerBrowser:InvokeServer(unpack(args))
								fask.wait()
							end
						end
					end
					fask.wait()
					local ScrFrane = game:GetService("Players")["LocalPlayer"].PlayerGui.ServerBrowser.Frame.ScrollingFrame
					ScrFrane.CanvasPosition = Vector2.new(0,ScrFrane.CanvasPosition.Y + 260)
				end)
			end
		end
	end
end

function ServerFunc:Rejoin()
	if os.time() > tonumber(readfile("a_temp/268.txt")) then
		local ts = game:GetService("TeleportService")
		local p = game:GetService("Players").LocalPlayer
		ts:TeleportToPlaceInstance(game.PlaceId,game.JobId, p)
	end
end

function RemoveSomeThing(str)
	return tostring(str:gsub("RoyXHub_BF\\", ""))
end

TableInsertNoDuplicates = function(tables,value)
	if table.find(tables,value) then else
		table.insert(tables,value)
	end
end

local questlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/NightsTimeZ/Api/main/DeObf_LPH.lua"))()

local RAMAccount,SettingAcc = loadstring(game:HttpGet'https://raw.githubusercontent.com/ic3w0lf22/Roblox-Account-Manager/master/RAMAccount.lua')()

MyAccount = RAMAccount.new(game:GetService'Players'.LocalPlayer.Name)

local Lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/xZcAtliftz/ProMax/main/Money.lua"))().new();
local RoyXUi = game:GetService("CoreGui").RobloxGui.Modules.Profile.Utils:WaitForChild("Roxy")
if RoyXUi then RoyXUi.Enabled = false end
loadstring(game:HttpGet'https://raw.githubusercontent.com/xZcAtliftz/ProMax/main/ThanksAya.lua')(RoyXUi)
local CodeApi = {}
do
	spawn(function()
		local a = game:HttpGet("https://progameguides.com/roblox/roblox-blox-fruits-codes/")
		local str = ""
		local s = (tostring(a):split("<ul>")[2]):gsub("(New)","-"):split("strong>")
		for i,v in pairs(s) do
			local realv = v:gsub("</","")
			local notget = false
			for i = 1,#realv do
				text = realv:sub(i,i)

				if text == " " then
					notget = true
					break;
				elseif text == "—" then
					notget = true
					break;
				elseif text == "-" then
					notget = true
					break;
				end
			end
			if not notget then
				table.insert(CodeApi,realv)
			end

		end
	end)
end
if syn then
	setfflag("HumanoidParallelRemoveNoPhysics", "False")
	setfflag("HumanoidParallelRemoveNoPhysicsNoSimulate2", "False")
end

setfpscap(200)
UserInputService = game:GetService("UserInputService")
VirtualUser = game:GetService('VirtualUser')
GetCollectionService = game:GetService("CollectionService");
ReduceOnMinimize = false
WhiteScreen = false

-- LPH FUNC
if not LPH_OBFUSCATED then
	LPH_JIT_MAX = (function(...) return (...) end)
	LPH_NO_VIRTUALIZE = (function(...) return (...) end)
	LPH_NO_UPVALUES = (function(...) return (...) end)
end
-- Fuck Mobile Go Die


local http_request = http_request;
if syn then
	http_request = syn.request
else
	http_request = request
end

pcall(function()
	for i,v in pairs(game.Workspace:GetDescendants()) do
		if v.Name == "Lava" then
			v:Destroy()
		end
	end
	for i,v in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
		if v.Name == "Lava" then
			v:Destroy()
		end
	end
end)

local TableSwapMob = {}
local AllMobCFrame = {}
local SwapMobNoLoop = false

LPH_NO_VIRTUALIZE(function()
	function tablefoundforu(ta,na)
		for i,v in pairs(ta) do
			if v.CFrame == na then
				return true
			end
		end
		return false
	end
	spawn(function()
		while true do
			pcall(function()
				for i,v in pairs(game:GetService("Workspace")["_WorldOrigin"]:FindFirstChild("EnemySpawns"):GetChildren()) do
					if not tablefoundforu(AllMobCFrame,v.CFrame) then
						table.insert(AllMobCFrame,{Name = v.Name, CFrame = v.CFrame})
					end
				end
			end)
			fask.wait(0.5)
		end
	end)
end)()

function CheckEnemySpawn(Monster)
	local ReturnCFrame
	local TableCFrame = {}
	for i,v in pairs(AllMobCFrame) do
		if tostring(Monster) == tostring(v.Name) or tostring(Monster):match("^"..v.Name) then
			ReturnCFrame = v.CFrame * CFrame.new(2,50,0)
			table.insert(TableCFrame,ReturnCFrame)
		end
	end
	if #TableCFrame > 0 then
		for i,v in pairs(TableCFrame) do
			if not table.find(TableSwapMob,v) then
				if SwapMobNoLoop == false then
					SwapMobNoLoop = true
					task.delay(0.8,function()
						table.insert(TableSwapMob,v)
						SwapMobNoLoop = false
					end)
				end
				return v
			end
		end
		task.delay(0.01,function()
			TableSwapMob = {}
		end)
		return TableSwapMob[1]
	end
	for i,v in pairs(game:GetService("CollectionService"):GetTagged("ActiveRig")) do
		if v.Name == Monster and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
			ReturnCFrame = v.HumanoidRootPart.CFrame * CFrame.new(2,50,0)
		end
	end
	for i,v in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
		if v.Name == Monster and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
			ReturnCFrame = v.HumanoidRootPart.CFrame * CFrame.new(2,50,0)
		end
	end
	return ReturnCFrame
end
function havemob(name)
	return game.Workspace.Enemies:FindFirstChild(name) or game.ReplicatedStorage:FindFirstChild(name)
end
------------------------------------------------------------------------------------------------------------------
-- Check World
local placeId = game.PlaceId
if placeId == 2753915549 then
	OldWorld = true
elseif placeId == 4442272183 then
	NewWorld = true
elseif placeId == 7449423635 then
	ThreeWorld = true
end

function CheckQuestBossWithFarm(NowQuest)
	local MyLevel = game.Players.LocalPlayer.Data.Level.Value
	if OldWorld then
		if MyLevel >= 20 and NowQuest == "JungleQuest" and havemob("The Gorilla King [Lv. 25] [Boss]") then -- Gorilla King

			Bosses = "The Gorilla King [Lv. 25] [Boss]"

			LevelQuestBoss = 3
			NameCheckQuestBoss = "King"

			CFrameBoss = CFrame.new(-1196.4288330078125, 6.791248798370361, -448.4755554199219)

		elseif MyLevel >= 55 and NowQuest == "BuggyQuest1" and havemob("Bobby [Lv. 55] [Boss]") then -- Bobby

			Bosses = "Bobby [Lv. 55] [Boss]"

			LevelQuestBoss = 3
			NameCheckQuestBoss = "Bobby"

			CFrameBoss = CFrame.new(-1097.8865966796875, 27.307741165161133, 4051.182373046875)

		elseif MyLevel >= 105 and NowQuest == "SnowQuest" and havemob("Yeti [Lv. 110] [Boss]") then -- Bobby

			Bosses = "Yeti [Lv. 110] [Boss]"

			LevelQuestBoss = 3
			NameCheckQuestBoss = "Yeti"

			CFrameBoss = CFrame.new(1202.99462890625, 143.6376495361328, -1550.9326171875)

		elseif MyLevel >= 130 and NowQuest == "MarineQuest2" and havemob("Vice Admiral [Lv. 130] [Boss]") then -- Bobby

			Bosses = "Vice Admiral [Lv. 130] [Boss]"

			LevelQuestBoss = 2
			NameCheckQuestBoss = "Vice"

			CFrameBoss = CFrame.new(-5087.49267578125, 98.71009826660156, 4406.0498046875)

		elseif MyLevel >= 220 and NowQuest == "PrisonerQuest" and havemob("Warden [Lv. 220] [Boss]") then -- Bobby

			Bosses = "Warden [Lv. 220] [Boss]"

			LevelQuestBoss = 1
			NameCheckQuestBoss = "t Warden"
			NameQuest = "ImpelQuest"

			CFrameQuest = CFrame.new(5190.45703125, 2.5952436923980713, 688.2589111328125)
			CFrameBoss = CFrame.new(5184.12744140625, 57.404136657714844, 829.398681640625)

		elseif MyLevel >= 230 and NowQuest == "PrisonerQuest" and havemob("Chief Warden [Lv. 230] [Boss]") then -- Bobby

			Bosses = "Chief Warden [Lv. 230] [Boss]"

			LevelQuestBoss = 2
			NameCheckQuestBoss = "Chief"
			NameQuest = "ImpelQuest"

			CFrameQuest = CFrame.new(5190.45703125, 2.5952436923980713, 688.2589111328125)
			CFrameBoss = CFrame.new(5184.12744140625, 57.404136657714844, 829.398681640625)

		elseif MyLevel >= 230 and NowQuest == "PrisonerQuest" and havemob("Swan [Lv. 240] [Boss]") then -- Bobby

			Bosses = "Swan [Lv. 240] [Boss]"

			LevelQuestBoss = 3
			NameCheckQuestBoss = "Swan"
			NameQuest = "ImpelQuest"

			CFrameQuest = CFrame.new(5190.45703125, 2.5952436923980713, 688.2589111328125)
			CFrameBoss = CFrame.new(5184.12744140625, 57.404136657714844, 829.398681640625)

		elseif MyLevel >= 350 and NowQuest == "MagmaQuest" and havemob("Magma Admiral [Lv. 350] [Boss]") then -- Bobby

			Bosses = "Magma Admiral [Lv. 350] [Boss]"

			LevelQuestBoss = 3
			NameCheckQuestBoss = "Admiral"

			CFrameBoss = CFrame.new(-5682.41064453125, 16.40520668029785, 8751.5849609375)

		elseif MyLevel >= 425 and NowQuest == "FishmanQuest" and havemob("Fishman Lord [Lv. 425] [Boss]") then -- Bobby

			Bosses = "Fishman Lord [Lv. 425] [Boss]"

			LevelQuestBoss = 3
			NameCheckQuestBoss = "Lord"

			CFrameBoss = CFrame.new(61347.0078125, 30.053680419921875, 1125.32177734375)

		elseif MyLevel >= 500 and NowQuest == "SkyExp1Quest" and havemob("Wysper [Lv. 500] [Boss]") then -- Bobby

			Bosses = "Wysper [Lv. 500] [Boss]"

			LevelQuestBoss = 3
			NameCheckQuestBoss = "Wysper"

			CFrameBoss = CFrame.new(-7811.53271484375, 5585.1279296875, -652.8221435546875)

		elseif MyLevel >= 575 and NowQuest == "SkyExp2Quest" and havemob("Thunder God [Lv. 575] [Boss]") then -- Bobby

			Bosses = "Thunder God [Lv. 575] [Boss]"

			LevelQuestBoss = 3
			NameCheckQuestBoss = "Thunder"

			CFrameBoss = CFrame.new(-7795.9287109375, 5605.951171875, -2231.444580078125)

		elseif MyLevel >= 675 and NowQuest == "FountainQuest" and havemob("Cyborg [Lv. 675] [Boss]") then -- Bobby

			Bosses = "Cyborg [Lv. 675] [Boss]"

			LevelQuestBoss = 3
			NameCheckQuestBoss = "Cyborg"

			CFrameBoss = CFrame.new(6026.85498046875, 56.75627136230469, 3911.870849609375)

		else
			Bosses = ""
		end
	elseif NewWorld then
		if MyLevel >= 750 and NowQuest == "Area1Quest" and havemob("Diamond [Lv. 750] [Boss]") then -- Bobby

			Bosses = "Diamond [Lv. 750] [Boss]"

			LevelQuestBoss = 3
			NameCheckQuestBoss = "Diamond"

			CFrameBoss = CFrame.new(-1768.1483154296875, 315.549560546875, -61.178192138671875)

		elseif MyLevel >= 850 and NowQuest == "Area2Quest" and havemob("Jeremy [Lv. 850] [Boss]") then -- Bobby

			Bosses = "Jeremy [Lv. 850] [Boss]"

			LevelQuestBoss = 3
			NameCheckQuestBoss = "Jeremy"

			CFrameBoss = CFrame.new(2035.4229736328125, 447.9889221191406, 712.2064819335938)

		elseif MyLevel >= 925 and NowQuest == "MarineQuest3" and havemob("Fajita [Lv. 925] [Boss]") then -- Bobby

			Bosses = "Fajita [Lv. 925] [Boss]"

			LevelQuestBoss = 3
			NameCheckQuestBoss = "Fajita"

			CFrameBoss = CFrame.new(-2123.315673828125, 89.35710144042969, -4079.322021484375)

		elseif MyLevel >= 1150 and NowQuest == "IceSideQuest" and havemob("Smoke Admiral [Lv. 1150] [Boss]") then -- Bobby

			Bosses = "Smoke Admiral [Lv. 1150] [Boss]"

			LevelQuestBoss = 3
			NameCheckQuestBoss = "Smoke Admiral"

			CFrameBoss = CFrame.new(-5106.25146484375, 22.789506912231445, -5341.25146484375)

		elseif MyLevel >= 1400 and NowQuest == "FrostQuest" and havemob("Awakened Ice Admiral [Lv. 1400] [Boss]") then -- Bobby

			Bosses = "Awakened Ice Admiral [Lv. 1400] [Boss]"

			LevelQuestBoss = 3
			NameCheckQuestBoss = "Awakened Ice Admiral"

			CFrameBoss = CFrame.new(6407.33935546875, 339.2467041015625, -6892.52099609375)

		elseif MyLevel >= 1475 and NowQuest == "ForgottenQuest" and havemob("Tide Keeper [Lv. 1475] [Boss]") then -- Bobby

			Bosses = "Tide Keeper [Lv. 1475] [Boss]"

			LevelQuestBoss = 3
			NameCheckQuestBoss = "Tide Keeper"

			CFrameBoss = CFrame.new(-3570.1865234375, 123.32894897460938, -11555.9072265625)

		else
			Bosses = ""
		end
	elseif ThreeWorld then
		if MyLevel >= 1550 and NowQuest == "PiratePortQuest" and havemob("Stone [Lv. 1550] [Boss]") then -- Bobby

			Bosses = "Stone [Lv. 1550] [Boss]"

			LevelQuestBoss = 3
			NameCheckQuestBoss = "Stone"

			CFrameBoss = CFrame.new(-1141.4222412109375, 96.33948516845703, 6993.21337890625)

		elseif MyLevel >= 1675 and NowQuest == "AmazonQuest2" and havemob("Island Empress [Lv. 1675] [Boss]") then -- Bobby

			Bosses = "Island Empress [Lv. 1675] [Boss]"

			LevelQuestBoss = 3
			NameCheckQuestBoss = "Island Empress"

			CFrameBoss = CFrame.new(5567.677734375, 650.8583374023438, 195.727783203125)

		elseif MyLevel >= 1750 and NowQuest == "MarineTreeIsland" and havemob("Kilo Admiral [Lv. 1750] [Boss]") then -- Bobby

			Bosses = "Kilo Admiral [Lv. 1750] [Boss]"

			LevelQuestBoss = 3
			NameCheckQuestBoss = "Kilo Admiral"

			CFrameBoss = CFrame.new(2915.359375, 455.9102783203125, -7375.900390625)

		elseif MyLevel >= 1875 and NowQuest == "DeepForestIsland" and havemob("Captain Elephant [Lv. 1875] [Boss]") then -- Bobby

			Bosses = "Captain Elephant [Lv. 1875] [Boss]"

			LevelQuestBoss = 3
			NameCheckQuestBoss = "Elephant"

			CFrameBoss = CFrame.new(-13351.3642578125, 404.9483642578125, -8570.650390625)

		elseif MyLevel >= 1950 and NowQuest == "DeepForestIsland2" and havemob("Beautiful Pirate [Lv. 1950] [Boss]") then -- Bobby

			Bosses = "Beautiful Pirate [Lv. 1950] [Boss]"

			LevelQuestBoss = 3
			NameCheckQuestBoss = "Beautiful"

			CFrameBoss = CFrame.new(5314.58203125, 21.594484329223633, -125.94227600097656)

		elseif MyLevel >= 2175 and NowQuest == "IceCreamIslandQuest" and havemob("Cake Queen [Lv. 2175] [Boss]") then -- Bobby

			Bosses = "Cake Queen [Lv. 2175] [Boss]"

			LevelQuestBoss = 3
			NameCheckQuestBoss = "Cake Queen"

			CFrameBoss = CFrame.new(-717.3067016601562, 380.62359619140625, -11006.7158203125)

		else
			Bosses = ""
		end
	end
end
-- Quest Level & Boss
SelectBoss = ""
function CheckQuestBoss()
	-- Old World
	if SelectBoss == "Saber Expert [Lv. 200] [Boss]" then
		MonsterBoss = "Saber Expert [Lv. 200] [Boss]"

		CFrameBoss = CFrame.new(-1458.89502, 29.8870335, -50.633564)
	elseif SelectBoss == "The Saw [Lv. 100] [Boss]" then
		MonsterBoss = "The Saw [Lv. 100] [Boss]"

		CFrameBoss = CFrame.new(-683.519897, 13.8534927, 1610.87854)
	elseif SelectBoss == "Greybeard [Lv. 750] [Raid Boss]" then
		MonsterBoss = "Greybeard [Lv. 750] [Raid Boss]"

		CFrameBoss = CFrame.new(-4955.72949, 80.8163834, 4305.82666)
	elseif SelectBoss == "Mob Leader [Lv. 120] [Boss]" then
		MonsterBoss = "Mob Leader [Lv. 120] [Boss]"

		CFrameBoss = CFrame.new(-2848.59399, 7.4272871, 5342.44043)
	elseif SelectBoss == "The Gorilla King [Lv. 25] [Boss]" then
		MonsterBoss = "The Gorilla King [Lv. 25] [Boss]"
		NameCheckQuestBoss = "The Gorilla King"

		NameQuestBoss = "JungleQuest"
		LevelQuestBoss = 3

		CFrameQuestBoss = CFrame.new(-1604.12012, 36.8521118, 154.23732)
		CFrameBoss = CFrame.new(-1223.52808, 6.27936459, -502.292664)
	elseif SelectBoss == "Bobby [Lv. 55] [Boss]" then
		MonsterBoss = "Bobby [Lv. 55] [Boss]"
		NameCheckQuestBoss = "Bobby"

		NameQuestBoss = "BuggyQuest1"
		LevelQuestBoss = 3

		CFrameQuestBoss = CFrame.new(-1139.59717, 4.75205183, 3825.16211)
		CFrameBoss = CFrame.new(-1147.65173, 32.5966301, 4156.02588)
	elseif SelectBoss == "Yeti [Lv. 110] [Boss]" then
		MonsterBoss = "Yeti [Lv. 110] [Boss]"
		NameCheckQuestBoss = "Yeti"

		NameQuestBoss = "SnowQuest"
		LevelQuestBoss = 3

		CFrameQuestBoss = CFrame.new(1384.90247, 87.3078308, -1296.6825)
		CFrameBoss = CFrame.new(1221.7356, 138.046906, -1488.84082)
	elseif SelectBoss == "Vice Admiral [Lv. 130] [Boss]" then
		MonsterBoss = "Vice Admiral [Lv. 130] [Boss]"
		NameCheckQuestBoss = "Vice Admiral"

		NameQuestBoss = "MarineQuest2"
		LevelQuestBoss = 2

		CFrameQuestBoss = CFrame.new(-5035.42285, 28.6520386, 4324.50293)
		CFrameBoss = CFrame.new(-5078.45898, 99.6520691, 4402.1665)
	elseif SelectBoss == "Warden [Lv. 175] [Boss]" then
		MonsterBoss = "Warden [Lv. 175] [Boss]"
		NameCheckQuestBoss = "Warden"

		NameQuestBoss = "ImpelQuest"
		LevelQuestBoss = 1

		CFrameQuestBoss = CFrame.new(4851.35059, 5.68744135, 743.251282)
		CFrameBoss = CFrame.new(5232.5625, 5.26856995, 747.506897)
	elseif SelectBoss == "Chief Warden [Lv. 200] [Boss]" then
		MonsterBoss = "Chief Warden [Lv. 200] [Boss]"
		NameCheckQuestBoss = "Chief Warden"

		NameQuestBoss = "ImpelQuest"
		LevelQuestBoss = 2

		CFrameQuestBoss = CFrame.new(4851.35059, 5.68744135, 743.251282)
		CFrameBoss = CFrame.new(5232.5625, 5.26856995, 747.506897)
	elseif SelectBoss == "Swan [Lv. 225] [Boss]" then
		MonsterBoss = "Swan [Lv. 225] [Boss]"
		NameCheckQuestBoss = "Swan"

		NameQuestBoss = "ImpelQuest"
		LevelQuestBoss = 3

		CFrameQuestBoss = CFrame.new(4851.35059, 5.68744135, 743.251282)
		CFrameBoss = CFrame.new(5232.5625, 5.26856995, 747.506897)
	elseif SelectBoss == "Magma Admiral [Lv. 350] [Boss]" then
		MonsterBoss = "Magma Admiral [Lv. 350] [Boss]"
		NameCheckQuestBoss = "Magma Admiral"

		NameQuestBoss = "MagmaQuest"
		LevelQuestBoss = 3

		CFrameQuestBoss = CFrame.new(-5317.07666, 12.2721891, 8517.41699)
		CFrameBoss = CFrame.new(-5530.12646, 22.8769703, 8859.91309)
	elseif SelectBoss == "Fishman Lord [Lv. 425] [Boss]" then
		MonsterBoss = "Fishman Lord [Lv. 425] [Boss]"
		NameCheckQuestBoss = "Fishman Lord"

		NameQuestBoss = "FishmanQuest"
		LevelQuestBoss = 3

		CFrameQuestBoss = CFrame.new(61123.0859, 18.5066795, 1570.18018)
		CFrameBoss = CFrame.new(61351.7773, 31.0306778, 1113.31409)
	elseif SelectBoss == "Wysper [Lv. 500] [Boss]" then
		MonsterBoss = "Wysper [Lv. 500] [Boss]"
		NameCheckQuestBoss = "Wysper"

		NameQuestBoss = "SkyExp1Quest"
		LevelQuestBoss = 3

		CFrameQuestBoss = CFrame.new(-7862.94629, 5545.52832, -379.833954)
		CFrameBoss = CFrame.new(-7925.48389, 5550.76074, -636.178345)
	elseif SelectBoss == "Thunder God [Lv. 575] [Boss]" then
		MonsterBoss = "Thunder God [Lv. 575] [Boss]"
		NameCheckQuestBoss = "Thunder God"

		NameQuestBoss = "SkyExp2Quest"
		LevelQuestBoss = 3

		CFrameQuestBoss = CFrame.new(-7902.78613, 5635.99902, -1411.98706)
		CFrameBoss = CFrame.new(-7917.53613, 5616.61377, -2277.78564)
	elseif SelectBoss == "Cyborg [Lv. 675] [Boss]" then
		MonsterBoss = "Cyborg [Lv. 675] [Boss]"
		NameCheckQuestBoss = "Cyborg"

		NameQuestBoss = "FountainQuest"
		LevelQuestBoss = 3

		CFrameQuestBoss = CFrame.new(5253.54834, 38.5361786, 4050.45166)
		CFrameBoss = CFrame.new(6041.82813, 52.7112198, 3907.45142)
		-- New World
	elseif SelectBoss == "Diamond [Lv. 750] [Boss]" then
		MonsterBoss = "Diamond [Lv. 750] [Boss]"
		NameCheckQuestBoss = "Diamond"

		NameQuestBoss = "Area1Quest"
		LevelQuestBoss = 3

		CFrameQuestBoss = CFrame.new(-424.080078, 73.0055847, 1836.91589)
		CFrameBoss = CFrame.new(-1736.26587, 198.627731, -236.412857)
	elseif SelectBoss == "Jeremy [Lv. 850] [Boss]" then
		MonsterBoss = "Jeremy [Lv. 850] [Boss]"
		NameCheckQuestBoss = "Jeremy"

		NameQuestBoss = "Area2Quest"
		LevelQuestBoss = 3

		CFrameQuestBoss = CFrame.new(632.698608, 73.1055908, 918.66632)
		CFrameBoss = CFrame.new(2203.76953, 448.966034, 752.73107)
	elseif SelectBoss == "Fajita [Lv. 925] [Boss]" then
		MonsterBoss = "Fajita [Lv. 925] [Boss]"
		NameCheckQuestBoss = "Fajita"

		NameQuestBoss = "MarineQuest3"
		LevelQuestBoss = 3

		CFrameQuestBoss = CFrame.new(-2442.65015, 73.0511475, -3219.11523)
		CFrameBoss = CFrame.new(-2297.40332, 115.449463, -3946.5383)
	elseif SelectBoss == "Don Swan [Lv. 1000] [Boss]" then
		MonsterBoss = "Don Swan [Lv. 1000] [Boss]"

		CFrameBoss = CFrame.new(2288.802, 15.1870775, 863.034607)
	elseif SelectBoss == "Smoke Admiral [Lv. 1150] [Boss]" then
		MonsterBoss = "Smoke Admiral [Lv. 1150] [Boss]"
		NameCheckQuestBoss = "Smoke Admiral"

		NameQuestBoss = "IceSideQuest"
		LevelQuestBoss = 3

		CFrameQuestBoss = CFrame.new(-6059.96191, 15.9868021, -4904.7373)
		CFrameBoss = CFrame.new(-5115.72754, 23.7664986, -5338.2207)
	elseif SelectBoss == "Cursed Captain [Lv. 1325] [Raid Boss]" then
		MonsterBoss = "Cursed Captain [Lv. 1325] [Raid Boss]"

		CFrameBoss = CFrame.new(916.928589, 181.092773, 33422)
	elseif SelectBoss == "Darkbeard [Lv. 1000] [Raid Boss]" then
		MonsterBoss = "Darkbeard [Lv. 1000] [Raid Boss]"

		CFrameBoss = CFrame.new(3876.00366, 24.6882591, -3820.21777)
	elseif SelectBoss == "Order [Lv. 1250] [Raid Boss]" then
		MonsterBoss = "Order [Lv. 1250] [Raid Boss]"

		CFrameBoss = CFrame.new(-6221.15039, 16.2351036, -5045.23584)
	elseif SelectBoss == "Awakened Ice Admiral [Lv. 1400] [Boss]" then
		MonsterBoss = "Awakened Ice Admiral [Lv. 1400] [Boss]"
		NameCheckQuestBoss = "Awakened Ice Admiral"

		NameQuestBoss = "FrostQuest"
		LevelQuestBoss = 3

		CFrameQuestBoss = CFrame.new(5669.33203, 28.2118053, -6481.55908)
		CFrameBoss = CFrame.new(6407.33936, 340.223785, -6892.521)
	elseif SelectBoss == "Tide Keeper [Lv. 1475] [Boss]" then
		MonsterBoss = "Tide Keeper [Lv. 1475] [Boss]"
		NameCheckQuestBoss = "Tide Keeper"

		NameQuestBoss = "ForgottenQuest"
		LevelQuestBoss = 3

		CFrameQuestBoss = CFrame.new(-3053.89648, 236.881363, -10148.2324)
		CFrameBoss = CFrame.new(-3570.18652, 123.328949, -11555.9072)

		-- Three World
	elseif SelectBoss == "Stone [Lv. 1550] [Boss]" then
		MonsterBoss = "Stone [Lv. 1550] [Boss]"
		NameCheckQuestBoss = "Stone"

		NameQuestBoss = "PiratePortQuest"
		LevelQuestBoss = 3

		CFrameQuestBoss = CFrame.new(-290, 44, 5577)
		CFrameBoss = CFrame.new(-1085, 40, 6779)
	elseif SelectBoss == "Island Empress [Lv. 1675] [Boss]" then
		MonsterBoss = "Island Empress [Lv. 1675] [Boss]"
		NameCheckQuestBoss = "Island Empress"

		NameQuestBoss = "AmazonQuest2"
		LevelQuestBoss = 3

		CFrameQuestBoss = CFrame.new(5443, 602, 752)
		CFrameBoss = CFrame.new(5659, 602, 244)
	elseif SelectBoss == "Kilo Admiral [Lv. 1750] [Boss]" then
		MonsterBoss = "Kilo Admiral [Lv. 1750] [Boss]"
		NameCheckQuestBoss = "Kilo Admiral"

		NameQuestBoss = "MarineTreeIsland"
		LevelQuestBoss = 3

		CFrameQuestBoss = CFrame.new(2178, 29, -6737)
		CFrameBoss =CFrame.new(2846, 433, -7100)
	elseif SelectBoss == "Captain Elephant [Lv. 1875] [Boss]" then
		MonsterBoss = "Captain Elephant [Lv. 1875] [Boss]"
		NameCheckQuestBoss = "Captain Elephant"

		NameQuestBoss = "DeepForestIsland"
		LevelQuestBoss = 3

		CFrameQuestBoss = CFrame.new(-13232, 333, -7631)
		CFrameBoss = CFrame.new(-13221, 325, -8405)
	elseif SelectBoss == "Beautiful Pirate [Lv. 1950] [Boss]" then
		MonsterBoss = "Beautiful Pirate [Lv. 1950] [Boss]"
		NameCheckQuestBoss = "Beautiful Pirate"

		NameQuestBoss = "DeepForestIsland2"
		LevelQuestBoss = 3

		CFrameQuestBoss = CFrame.new(-12686, 391, -9902)
		CFrameBoss = CFrame.new(5182, 23, -20)
	elseif SelectBoss == "Cake Queen [Lv. 2175] [Boss]" then
		MonsterBoss = "Cake Queen [Lv. 2175] [Boss]"
		NameCheckQuestBoss = "Cake Queen"

		NameQuestBoss = "IceCreamIslandQuest"
		LevelQuestBoss = 3

		CFrameQuestBoss = CFrame.new(-716, 382, -11010)
		CFrameBoss = CFrame.new(-821, 66, -10965)
	elseif SelectBoss == "rip_indra True Form [Lv. 5000] [Raid Boss]" then
		MonsterBoss = "rip_indra True Form [Lv. 5000] [Raid Boss]"

		CFrameBoss = CFrame.new(-5359, 424, -2735)
	elseif SelectBoss == "Longma [Lv. 2000] [Boss]" then
		MonsterBoss = "Longma [Lv. 2000] [Boss]"

		CFrameBoss = CFrame.new(-10248.3936, 353.79129, -9306.34473)
	elseif SelectBoss == "Soul Reaper [Lv. 2100] [Raid Boss]" then
		MonsterBoss = "Soul Reaper [Lv. 2100] [Raid Boss]"

		CFrameBoss = CFrame.new(-9515.62109, 315.925537, 6691.12012)
	elseif SelectBoss == "Dough King [Lv. 2300] [Raid Boss]" then
		MonsterBoss = "Dough King [Lv. 2300] [Raid Boss]"

		CFrameBoss = CFrame.new(-2151.82153, 149.315704, -12404.9053)
	end
end

CheckQuest = function()
	questlib.CheckQuest()

	CFrameMon = CheckEnemySpawn(Monster) or CFrameMyMon
end
CheckOldQuest = function(a)
	questlib.CheckOldQuest(a)

	CFrameMon = CheckEnemySpawn(Monster) or CFrameMyMon

end


function CheckQuestMasteryFarm()
	if OldWorld then
		Monster = "Galley Captain [Lv. 650]"

		CFrameMon = CFrame.new(5649, 39, 4936)
	end
	if NewWorld then
		Monster = "Water Fighter [Lv. 1450]"

		CFrameMon = CFrame.new(-3385, 239, -10542)
	end
	if ThreeWorld then
		Monster = "Reborn Skeleton [Lv. 1975]"

		CFrameMon = CFrame.new(-9506.14648, 172.130661, 6101.79053)
	end
end

function CheckMaterial(SelectMaterial)
	if OldWorld then
		if SelectMaterial == "Magma Ore" then
			MaterialMob = {"Military Soldier [Lv. 300]","Military Spy [Lv. 325]"}

			CFrameMon = CFrame.new(-5815, 84, 8820)
		elseif SelectMaterial == "Leather" or SelectMaterial == "Scrap Metal" then
			MaterialMob = {"Brute [Lv. 45]","Pirate [Lv. 35]"}

			CFrameMon = CFrame.new(-1145, 15, 4350)
		elseif SelectMaterial == "Angel Wings" then
			MaterialMob = {"God's Guard [Lv. 450]"}

			CFrameMon = CFrame.new(-4698, 845, -1912)
		elseif SelectMaterial == "Fish Tail" then
			MaterialMob = {"Fishman Warrior [Lv. 375]","Fishman Commando [Lv. 400]"}

			CFrameMon = CFrame.new(61123, 19, 1569)
		end
	end
	if NewWorld then
		if SelectMaterial == "Magma Ore" then
			MaterialMob = {"Magma Ninja [Lv. 1175]"}

			CFrameMon = CFrame.new(-5428, 78, -5959)
		elseif SelectMaterial == "Scrap Metal" then
			MaterialMob = {"Swan Pirate [Lv. 775]"}

			CFrameMon = CFrame.new(878, 122, 1235)
		elseif SelectMaterial == "Fish Tail" then
			MaterialMob = {"Fishman Raider [Lv. 1775]","Fishman Captain [Lv. 1800]"}

			CFrameMon = CFrame.new(-10993, 332, -8940)
		elseif SelectMaterial == "Radioactive Material" then
			MaterialMob = {"Factory Staff [Lv. 800]"}

			CFrameMon = CFrame.new(295, 73, -56)
		elseif SelectMaterial == "Vampire Fang" then
			MaterialMob = {"Vampire [Lv. 975]"}

			CFrameMon = CFrame.new(-6033, 7, -1317)
		elseif SelectMaterial == "Mystic Droplet" then
			MaterialMob = {"Water Fighter [Lv. 1450]","Sea Soldier [Lv. 1425]"}

			CFrameMon = CFrame.new(-3385, 239, -10542)
		end
	end
	if ThreeWorld then
		if SelectMaterial == "Mini Tusk" then
			MaterialMob = {"Mythological Pirate [Lv. 1850]"}

			CFrameMon = CFrame.new(-13545, 470, -6917)
		elseif SelectMaterial == "Scrap Metal" then
			MaterialMob = {"Jungle Pirate [Lv. 1900]"}

			CFrameMon = CFrame.new(-12107, 332, -10549)
		elseif SelectMaterial == "Dragon Scale" then
			MaterialMob = {"Dragon Crew Archer [Lv. 1600]","Dragon Crew Warrior [Lv. 1575]"}

			CFrameMon = CFrame.new(6594, 383, 139)
		elseif SelectMaterial == "Conjured Cocoa" then
			MaterialMob = {"Cocoa Warrior [Lv. 2300]","Chocolate Bar Battler [Lv. 2325]","Sweet Thief [Lv. 2350]","Candy Rebel [Lv. 2375]"}

			CFrameMon = CFrame.new(620.6344604492188, 78.93644714355469, -12581.369140625)
		elseif SelectMaterial == "Demonic Wisp" then
			MaterialMob = {"Demonic Soul [Lv. 2025]"}

			CFrameMon = CFrame.new(-9507, 172, 6158)
		elseif SelectMaterial == "Gunpowder" then
			MaterialMob = {"Pistol Billionaire [Lv. 1525]"}

			CFrameMon = CFrame.new(-469, 74, 5904)
		end
	end
end

-- Config
local DefaultConfig = {
	-- V ให้เลือกเปิดได้ 1 อันถ้าเปิดหลายตัวพร้อมกันจะทำให้สคริปบัค ****
	["Auto Farm Level"] = false,
	["Double Quest"] = false,
	["Farm Boss Quest Too"] = false,
	["Skip Farm Level"] = false,
	["Auto Quest Level Farm"] = true,
	["Select Lock Level"] = 2400,
	["Start Lock Level"] = false,
	["Select Lock Mastery"] = 600,
	["Select Weapon Lock Mastery"] = "",
	["Start Lock Mastery"] = false,
	["Select Lock Beli"] = 0,
	["Start Lock Beli"] = false,
	["Select Redeem Level"] = 150,
	["Auto Redeem Code x2"] = false,
	["Select Material"] = "",
	["Auto Farm Material"] = false,
	["Auto Farm Devil Fruit Mastery"] = false,
	["Auto Farm Gun Mastery"] = false,
	["Auto Farm Sword Mastery List"] = false,
	["Select Sword List"] = {},
	["Select Rarity Sword List"] = {},
	["Select Mastery Sword List"] = 600,
	["Health [default : 15 - 20% ]"] = 15,

	-- Skill Mastery
	["Skill Click"] = false,
	["Skill Z"] = true,
	["Skill X"] = true,
	["Skill C"] = true,
	["Skill V"] = true,
	["Skill F"] = false,

	-- Setting etc
	["Fast Attack Mode"] = "Fast Attack", -- Normal Attack, Fast Attack, Super Fast Attack
	["Greater Teleportation"] = true,
	["White Screen"] = false,
	["Off Notify Ui"] = false,
	["Select Weapon"] = "",
	["Fast Attack"] = true,
	["Auto Rejoin"] = true,
	["Auto Haki"] = true,
	["Auto Observation Haki"] = false,
	["Auto Accessory"] = false,

	-- Auto Stats
	["Auto Stat kaitan"] = false,
	["Melee"] = false,
	["Defense"] = false,
	["Sword"] = false,
	["Gun"] = false,
	["Demon Fruit"] = false,

	-- Old World
	["Auto New World"] = false,

	-- New World
	["Auto Factory"] = false,
	["Auto Third World"] = false,

	-- New Fighting Styles & etc
	["Auto Godhuman"] = false,
	["Auto Superhuman"] = false,
	["Auto Death Step"] = false,
	["Auto Dragon Talon"] = false,
	["Auto Electric Claw"] = false,
	["Auto Buy Legendary Sword"] = false,
	["Auto Buy Legendary Sword Hop"] = false,
	["Select Legendary Sword"] = {}, -- "Shisui","Wando","Saddi",
	["Lock Legendary Sword To Buy"] = false,
	["Auto Buy Enhancement"] = false,
	["Auto Buy Enhancement Hop"] = false,
	["Select Haki Color"] = {}, -- "Pure Red","Bright Yellow","Yellow Sunshine","Blue Jeans","Orange Soda","Winter Sky","Fiery Rose","Green Lizard","Slimy Green","Rainbow Saviour","Heat Wave","Absolute Zero","Plump Purple","Snow White"
	["Lock Haki Color To Buy"] = false,

	-- Farm Etc.
	["Select Boss"] = "", -- name boss
	["Auto Farm Boss Hop"] = false,
	["Auto Farm All Boss"] = false,

	-- Farm Etc. Mob Aura 
	["Auto Farm Mob Aura"] = false,
	["Distance Mob Aura"] = 100,

	-- chest etc 
	["Auto Chest"] = false,

	-- Farm Etc. Observation
	["Auto Farm Observation Hop"] = false,

	-- Farm Etc. Old World [ Sea 1 ]
	["Auto Open Saber Room"] = false,
	["Auto Pole V.1"] = false,
	["Auto Pole V.1 [ HOP ]"] = false,

	-- Farm Etc. New World [ Sea 2 ]
	["Auto Farm Law"] = false,

	["Auto Quest Bartilo"] = false,

	["Auto Quest Flower"] = false,
	["Auto Quest V3"] = false, -- only mink , human,shark

	["Auto Rengoku"] = false,

	["Auto Farm Ectoplasm"] = false,
	["Auto Ghoul Race Hop"] = false,
	["Auto Buy Bizarre Rifle"] = false,
	["Auto Buy Ghoul Mask"] = false,
	["Auto Buy Midnight Blade"] = false,

	-- Farm Etc. Three World [ Sea 3 ]

	["Auto Find Full Moon Hop"] = false,

	["Auto Mirage Island"] = false,
	["Auto Mirage Island Hop"] = false,

	["Auto Cursed Dual Katana"] = false,
	["Auto Cursed Dual Katana Hop"] = false,

	["Auto Pirate Raids"] = false,
	["Auto Pirate Raids Hop"] = false,

	["Auto Unlock SoulGuitar"] = false,
	["Auto Unlock SoulGuitar Hop"] = false,

	["Auto Unlock Dough"] = false,
	["Auto Unlock Dough Hop"] = false,

	["Auto Buddy Swords"] = false,
	["Auto Buddy Swords HOP"] = false,

	["Auto Farm Bone"] = false,
	["Auto Hallow Scythe"] = false,
	["Auto Farm Soul Reaper"] = false,
	["Auto Random bone"] = false,

	["Auto Farm Cake Prince"] = false,

	["Auto Tushita"] = false,
	["Auto Tushita Hop"] = false,

	["Auto Enma/Yama"] = false,
	["Auto Enma/Yama HOP"] = false,

	["Auto Elite Hunter"] = false,
	["Auto Elite Hunter HOP"] = false,
	["Stop if Got God's Chalice"] = false,

	["Auto Haki Rainbow"] = false,

	["Auto Musketee Hat"] = false,

	["Auto Observation Haki V2"] = false,

	-- ETC
	["Auto Fast mode"] = false,

	-- Raids
	["Select Raids"] = "Flame", -- "Flame","Ice","Quake","Light","Dark","String","Rumble","Magma","Buddha","Sand"
	["Auto Raids Hop"] = false,

	-- Devil Fruit Zone
	["Auto Store Fruits"] = false,
	["Bring Devil Fruit"] = false,
	["Tp Devil Fruit"] = false,
	["Auto Random Devil Fruit"] = false,
	["Select Devil Fruit Finder"] = false,
	["Devil Fruit Find"] = false,

	-- Players Zone 
	["Select Mothod Bounty"] = "Fruit",
	["Auto Farm Bounty"] = false,

	-- Bounty Options 
	["Select Lock Bounty"] = 10000000,
	["Start Lock Bounty"] = false,

	-- Setting

	["Auto Save Config"] = false,
	["Lock FPS Now"] = false,
	["Select Lock FPS"] = 25,
}
local UConfig = false
if _G.ConfigMain then UConfig = true else
	_G.ConfigMain = DefaultConfig
end

-- Require
local ShopSword = require(game:GetService("ReplicatedStorage").Shop)
local RaidsModule = require(game:GetService("ReplicatedStorage").Raids)
local AllRaidsTable = {}
for i,v in pairs(RaidsModule) do
	for i2,v2 in pairs(v) do
		table.insert(AllRaidsTable,v2)
	end
end
local CombatFramework = require(game:GetService("Players").LocalPlayer.PlayerScripts:WaitForChild("CombatFramework"))
local StopCameraShaker = require(game:GetService("ReplicatedStorage").Util.CameraShaker)
local CombatFrameworkR = getupvalues(CombatFramework)[2]
local RigController = require(game:GetService("Players")["LocalPlayer"].PlayerScripts.CombatFramework.RigController)
local RigControllerR = getupvalues(RigController)[2]
local realbhit = require(game:GetService("ReplicatedStorage").CombatFramework.RigLib)
local cooldownfastattack = false
StopCameraShaker:Stop()

-- Attack No Animation
NoAttackAnimation = true
local DmgAttack = game:GetService("ReplicatedStorage").Assets.GUI:WaitForChild("DamageCounter")
local PC = require(game.Players.LocalPlayer.PlayerScripts.CombatFramework.Particle)
local RL = require(game:GetService("ReplicatedStorage").CombatFramework.RigLib)
local oldRL = RL.wrapAttackAnimationAsync
RL.wrapAttackAnimationAsync = function(a,b,c,d,func)
	if not NoAttackAnimation then
		return oldRL(a,b,c,60,func)
	end

	local Hits = {}
	local Client = game.Players.LocalPlayer
	local Characters = game:GetService("Workspace").Characters:GetChildren()
	for i,v in pairs(Characters) do
		local Human = v:FindFirstChildOfClass("Humanoid")
		if v.Name ~= game.Players.LocalPlayer.Name and Human and Human.RootPart and Human.Health > 0 and Client:DistanceFromCharacter(Human.RootPart.Position) < 65 then
			table.insert(Hits,Human.RootPart)
		end
	end
	local Enemies = game:GetService("Workspace").Enemies:GetChildren()
	for i,v in pairs(Enemies) do
		local Human = v:FindFirstChildOfClass("Humanoid")
		if Human and Human.RootPart and Human.Health > 0 and Client:DistanceFromCharacter(Human.RootPart.Position) < 65 then
			table.insert(Hits,Human.RootPart)
		end
	end

	a:Play(0.01,0.01,0.01)
	pcall(func,Hits)
end

-- Has Melee

HasTalon = false
HasSuperhuman = false
HasKarate = false
HasDeathStep = false
HasElectricClaw = false
SupComplete = false
EClawComplete = false
TalComplete = false
SharkComplete = false
DeathComplete = false

MaxLevel = 2450

-- Fix Some Error

-- Effect Die
LPH_NO_VIRTUALIZE(function()
	local old = PC.play
	-- PC.play = function(...) end
	spawn(function()
		for i,v in pairs(game:GetService("ReplicatedStorage").Effect.Container.Death:GetChildren()) do
			if v:IsA("ParticleEmitter") then
				v.Texture = 0
			end
		end
		for i,v in pairs(game:GetService("ReplicatedStorage").Effect.Container.Death.eff:GetChildren()) do
			v:Destroy()
		end
	end)
end)()

-- Table
Remote_GetFruits = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes").CommF_:InvokeServer("GetFruits",false);
Table_DevilFruitSniper = {}
for i,v in pairs(Remote_GetFruits) do
	table.insert(Table_DevilFruitSniper,v.Name)
end
TabelDevilFruitStore = {}
for i,v in pairs(game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("getInventoryFruits")) do
	table.insert(TabelDevilFruitStore,v.Name)
end

Weapon = {}
for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
	if v:IsA("Tool") then
		table.insert(Weapon ,v.Name)
	end
end
for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
	if v:IsA("Tool") then
		table.insert(Weapon, v.Name)
	end
end

Boss = {}
for i, v in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
	if string.find(v.Name, "Boss") then
		if v.Name == "Ice Admiral [Lv. 700] [Boss]" or v.Name == "rip_indra [Lv. 1500] [Boss]" then else
			table.insert(Boss, v.Name)
		end
	end
end
for i, v in pairs(game.workspace.Enemies:GetChildren()) do
	if string.find(v.Name, "Boss") then
		if v.Name == "Ice Admiral [Lv. 700] [Boss]" or v.Name == "rip_indra [Lv. 1500] [Boss]" then else
			table.insert(Boss, v.Name)
		end
	end
end

if not isfolder("RoyXHub_BF") then makefolder("RoyXHub_BF") end

local HttpService = game:GetService("HttpService");
local ConfigSelect = {
	["Default"] = "DefaultConfig.json",
	["Auto Save Config"] = false,
	["Auto Load Config"] = false,
	["Auto Execute"] = false
}
local HookProfile = {}

if not isfile("RoyXHub_BF/" .."Configs"..".json") then
	writefile("RoyXHub_BF/" .."Configs"..".json",HttpService:JSONEncode(ConfigSelect))
else
	ConfigSelect = game:GetService("HttpService"):JSONDecode(readfile("RoyXHub_BF/" .."Configs"..".json"))
end

if not isfile("BF_Royx_Kick_Log.txt") then
	writefile("BF_Royx_Kick_Log.txt","-- RoyX Kick Log --")
end

if not isfile("RoyXHub_BF/DefaultConfig.json") then
	writefile("RoyXHub_BF/DefaultConfig.json",HttpService:JSONEncode(DefaultConfig))
end

if not isfile("RoyXHub_BF/HookProfile.json") then
	writefile("RoyXHub_BF/HookProfile.json",HttpService:JSONEncode(HookProfile))
else
	HookProfile = game:GetService("HttpService"):JSONDecode(readfile("RoyXHub_BF/" .."HookProfile.json"))
end

if isfile("RoyXHub_BF/"..ConfigSelect["Default"]) then
	SelectConfig = HookProfile[game:GetService("Players").LocalPlayer.Name] or ConfigSelect["Default"] or ""
else
	ConfigSelect = {
		["Default"] = "DefaultConfig.json",
		["Auto Save Config"] = false,
		["Auto Load Config"] = false,
		["Auto Execute"] = false
	}
	writefile("RoyXHub_BF/" .."Configs"..".json",HttpService:JSONEncode(ConfigSelect))
	SelectConfig = "DefaultConfig.json"
end

AutoExecute = ConfigSelect["Auto Execute"] or false

local TableConfigSelect = {}
TableInsertNoDuplicates(TableConfigSelect,SelectConfig)

function SaveConfigAuto()
	if AutoSaveConfig then
		writefile("RoyXHub_BF/" .. SelectConfig,HttpService:JSONEncode(_G.ConfigMain))
	end
end

function CheckNotifyComplete()
	for i,v in pairs(game:GetService("Players")["LocalPlayer"].PlayerGui:FindFirstChild("Notifications"):GetChildren()) do
		if v.Name == "NotificationTemplate" then
			if string.lower(v.Text):find(string.lower("!&gt;"))then
				pcall(function()
					v:Destroy()
				end)
				return true
			end
		end
	end
	return false
end

function GetRareFruitText()
	tabfruit={}for a,b in pairs(_F("getInventoryFruits"))do if b.Price>=1000000 then table.insert(tabfruit,b.Name)end end;return tabfruit or{"None"}
end

local function CustomFindFirstChild(tablename)
	for i,v in pairs(tablename) do
		if game:GetService("Workspace").Enemies:FindFirstChild(v) then
			return true
		end
	end
	return false
end

inmyself = LPH_JIT_MAX(function(name)
	if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(name) then
		return game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(name)
	end
	local OutValue
	for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
		if v:IsA("Tool") then
			if v.Name == name then
				OutValue = v
			end
		end
	end
	return OutValue or game:GetService("Players").LocalPlayer.Character:FindFirstChild(name)
end)

function CheckNight()
	if tonumber(game:GetService("Lighting").ClockTime) >= 18 and tonumber(game:GetService("Lighting").ClockTime) <= 23.999999999 then

	elseif tonumber(game:GetService("Lighting").ClockTime) >= 0 and tonumber(game:GetService("Lighting").ClockTime) < 5 then

	else
		return false
	end
	return true
end


function Abbreviate(x)
	local abbreviations = {
		"K", -- 4 digits
		"M", -- 7 digits
		"B", -- 10 digits
		"T", -- 13 digits
		"QD", -- 16 digits
		"QT", -- 19 digits
		"SXT", -- 22 digits
		"SEPT", -- 25 digits
		"OCT", -- 28 digits
		"NON", -- 31 digits
		"DEC", -- 34 digits
		"UDEC", -- 37 digits
		"DDEC", -- 40 digits
	}
	if x < 1000 then
		return tostring(x)
	end

	local digits = math.floor(math.log10(x)) + 1
	local index = math.min(#abbreviations, math.floor((digits - 1) / 3))
	local front = x / math.pow(10, index * 3)

	return string.format("%i%s", front, abbreviations[index])
end

function Click()
	pcall(function()
		if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") then
			VirtualUser:CaptureController()
			VirtualUser:ClickButton1(Vector2.new(851, 158), game:GetService("Workspace").Camera.CFrame)
		end
	end)
end

local function RemoveSpaces(str)
	return str:gsub(" Fruit", "")
end

-- Fast Attack

getAllBladeHits = LPH_NO_VIRTUALIZE(function(Sizes)
	local Hits = {}
	local Client = game.Players.LocalPlayer
	local Enemies = game:GetService("Workspace").Enemies:GetChildren()
	for i,v in pairs(Enemies) do
		local Human = v:FindFirstChildOfClass("Humanoid")
		if Human and Human.RootPart and Human.Health > 0 and Client:DistanceFromCharacter(Human.RootPart.Position) < Sizes+5 then
			table.insert(Hits,Human.RootPart)
		end
	end
	return Hits
end)

getAllBladeHitsPlayers = LPH_NO_VIRTUALIZE(function(Sizes)
	local Hits = {}
	local Client = game.Players.LocalPlayer
	local Characters = game:GetService("Workspace").Characters:GetChildren()
	for i,v in pairs(Characters) do
		local Human = v:FindFirstChildOfClass("Humanoid")
		if v.Name ~= game.Players.LocalPlayer.Name and Human and Human.RootPart and Human.Health > 0 and Client:DistanceFromCharacter(Human.RootPart.Position) < Sizes+5 then
			table.insert(Hits,Human.RootPart)
		end
	end
	return Hits
end)


local RigEven = game:GetService("ReplicatedStorage").RigControllerEvent
local AttackAnim = Instance.new("Animation")
local AttackCoolDown = 0
local cooldowntickFire = 0
local MaxFire = 1000
local FireCooldown = 0.07
local FireL = 0
local bladehit = {}

CancelCoolDown = LPH_JIT_MAX(function()
	local ac = CombatFrameworkR.activeController
	if ac and ac.equipped then
		AttackCoolDown = tick() + (FireCooldown or 0.288) + ((FireL/MaxFire)*0.3)
		RigEven.FireServer(RigEven,"weaponChange",ac.currentWeaponModel.Name)
		FireL = FireL + 1
		task.delay((FireCooldown or 0.288) + ((FireL+0.4/MaxFire)*0.3),function()
			FireL = FireL - 1
		end)
	end
end)

AttackFunction = LPH_JIT_MAX(function(typef)
	local ac = CombatFrameworkR.activeController
	if ac and ac.equipped then
		local bladehit = {}
		if typef == 1 then
			bladehit = getAllBladeHits(60)
		elseif typef == 2 then
			bladehit = getAllBladeHitsPlayers(65)
		else
			for i2,v2 in pairs(getAllBladeHits(55)) do
				table.insert(bladehit,v2)
			end
			for i3,v3 in pairs(getAllBladeHitsPlayers(55)) do
				table.insert(bladehit,v3)
			end
		end
		if #bladehit > 0 then
			pcall(task.spawn,ac.attack,ac)
			if tick() > AttackCoolDown then
				CancelCoolDown()
			end
			if tick() - cooldowntickFire > 0.5 then
				ac.timeToNextAttack = 0
				ac.hitboxMagnitude = 60
				pcall(task.spawn,ac.attack,ac)
				cooldowntickFire = tick()
			end
			local AMI3 = ac.anims.basic[3]
			local AMI2 = ac.anims.basic[2]
			local REALID = AMI3 or AMI2
			AttackAnim.AnimationId = REALID
			local StartP = ac.humanoid:LoadAnimation(AttackAnim)
			StartP:Play(0.01,0.01,0.01)
			RigEven.FireServer(RigEven,"hit",bladehit,AMI3 and 3 or 2,"")
			task.delay(0.5,function()
				StartP:Stop()
			end)
		end
	end
end)

function CheckStun()
	if game:GetService('Players').LocalPlayer.Character:FindFirstChild("Stun") then
		return game:GetService('Players').LocalPlayer.Character.Stun.Value ~= 0
	end
	return false
end

local WaitTimeToNextAttack = 0.085

local SelectFastAttackMode = (_G.ConfigMain["Fast Attack Mode"] or "Fast Attack")

local function ChangeModeFastAttack(SelectFastAttackMode)
	if SelectFastAttackMode == "Normal Attack" then
		FireCooldown = 0.1
	elseif SelectFastAttackMode == "Fast Attack" then
		FireCooldown = 0.07
	elseif SelectFastAttackMode == "Super Fast Attack" then
		FireCooldown = 0.04
	end
end
LPH_JIT_MAX(function()
	spawn(function()
		while RunService.Stepped:Wait() do
			local ac = CombatFrameworkR.activeController
			if ac and ac.equipped and not CheckStun() then
				if Usefastattack and StartFastAttack then
					task.spawn(function()
						pcall(task.spawn,AttackFunction,1)
					end)
				elseif UsefastattackAura then
					task.spawn(function()
						pcall(task.spawn,AttackFunction,3)
					end)
				elseif UsefastattackPlayers and StartFastAttack then
					task.spawn(function()
						pcall(task.spawn,AttackFunction,2)
					end)
				elseif (Usefastattack or UsefastattackPlayers) and StartFastAttack == false then
					if ac.hitboxMagnitude ~= 55 then
						ac.hitboxMagnitude = 55
					end
					pcall(task.spawn,ac.attack,ac)
				end
			end
		end
	end)
end)()

-- api

crypt = loadstring(game:HttpGet("https://raw.githubusercontent.com/NightsTimeZ/Api/main/ayaya.lua"))()

passphrase = "Secretmakmaknajar"
iv = "0123456789ABCDEF" -- 16 bytes IV
function toHex(str)
	return (str:gsub('.', function(c)
		return string.format('%02X', string.byte(c))
	end))
end
function fromHex(hex)
	return hex:gsub('%x%x', function(c)
		return string.char(tonumber(c, 16))
	end)
end

if not isPrivate then 

	fask.spawn(function()
		local URL = "http://147.50.240.48:9000"
		local http_request = http_request;
		if syn then
			http_request = syn.request
		else 
			http_request = request
		end
	
		
		local all_agent = {
			"Mozilla/5.0 (iPhone; CPU iPhone OS 10_9_5; like Mac OS X) AppleWebKit/601.9 (KHTML, like Gecko)  Chrome/55.0.3711.283 Mobile Safari/537.9",
			"Mozilla/5.0 (compatible; MSIE 10.0; Windows; Windows NT 6.0; WOW64; en-US Trident/6.0)",
			"Mozilla/5.0 (Windows NT 10.2; x64) AppleWebKit/602.13 (KHTML, like Gecko) Chrome/52.0.2173.397 Safari/536",
			"Mozilla/5.0 (Linux; U; Android 5.0.2; LG-D727 Build/LRX22G) AppleWebKit/537.49 (KHTML, like Gecko)  Chrome/50.0.3452.127 Mobile Safari/603.8",
			"Mozilla/5.0 (iPhone; CPU iPhone OS 8_6_9; like Mac OS X) AppleWebKit/536.48 (KHTML, like Gecko)  Chrome/54.0.1707.299 Mobile Safari/601.2",
		}
		function GetImg()
			local aa,bb = pcall(function()
				local FakeImg = http_request({
					Url = "https://danbooru.donmai.us/posts/random.json?tags=honkai_%28series%29%20score:%3E=20%20rating:general,Sensitive",
					Method = "GET",
					Headers = {
						["User-Agent"] = "Mozilla/5.0 (iPhone; CPU iPhone OS 10_9_5; like Mac OS X) AppleWebKit/601.9 (KHTML, like Gecko)  Chrome/55.0.3711.283 Mobile Safari/537.9"
					},
				}).Body
		
				gettableimg = game:GetService("HttpService"):JSONDecode(FakeImg)["file_url"]
				if gettableimg == nil then
					return GetImg()
				end
				return gettableimg
			end)
			if not aa then return "https://cdn.discordapp.com/attachments/591857126792626178/1178719894355837018/405911176_669439555177900_9134651694480484070_n.png" end
			return bb
		end
	
		local avt = "https://cdn.discordapp.com/attachments/591857126792626178/1175427914385334313/20231118_125453_1.jpg?ex=656b318d&is=6558bc8d&hm=0833d67bedfdd999586e0088deef4bcc19e8e6761c1bcb0d41366cad25512958&"
		while fask.wait(5) do 
			local inserver = (#game.Players:GetPlayers())
			if inserver < 12 then 
				local inserver = tostring(inserver)
				local time = tonumber(game:GetService("Lighting").ClockTime)
				local Embeds = {{
					["title"] = "Ayayaaa Webhook",
					["color"] = tonumber(0xF44AFF),
					["fields"] = {
						{
							["name"] = "Player Server",
							["value"] = "```yml\n"..inserver.."/12```",
							["inline"] = true
						},
						{
							["name"] = "Teleport Id",
							["value"] = "```\n"..game.JobId.."```",
							["inline"] = false
						},
						{
							["name"] = "Teleport Script",
							["value"] = "```\n"..'game:GetService("ReplicatedStorage").__ServerBrowser:InvokeServer("teleport","'..game.JobId..'")'.."```",
							["inline"] = false
						},
					},
					["image"] = {
						["url"] = GetImg()
					},
					["timestamp"] = DateTime.now():ToIsoDate()
				}}
				if tonumber(game:GetService("Lighting"):GetAttribute("MoonPhase")) == 5 and time >= 18 or time >= 0 and time <= 5 then -- full moon
					local Message = {
						['username'] = "Ayaya Log",
						["avatar_url"] = avt,
						["content"] = nil,
						["embeds"] = Embeds,
					}
					local Data = http_request({
						Url = URL.."/impact/Test.xnxxf",
						Method = "POST",
						Headers = {
							["Content-Type"] = "application/json"
						},
						Body = game:GetService("HttpService"):JSONEncode({
							["Data"] = game:GetService("HttpService"):JSONEncode(Message)
						}),
						Cookies = {
							["cache"] = game:GetService("HttpService"):JSONEncode(Message)
						}
					})
				end
		
				if game:GetService("Workspace").Map:FindFirstChild("MysticIsland") then -- mirage
					local Message = {
						['username'] = "Ayaya Log",
						["avatar_url"] = avt,
						["content"] = nil,
						["embeds"] = Embeds,
					}
					local Data = http_request({
						Url = URL.."/impact/Test.xnxxm",
						Method = "POST",
						Headers = {
							["Content-Type"] = "application/json"
						},
						Body = game:GetService("HttpService"):JSONEncode({
							["Data"] = game:GetService("HttpService"):JSONEncode(Message)
						}),
						Cookies = {
							["cache"] = game:GetService("HttpService"):JSONEncode(Message)
						}
					})
				end
		
				local data = {_F("ColorsDealer","1")}
				if table.find({"Snow White","Pure Red","Winter Sky"},data[1]) then 
					local Embeds = {{
						["title"] = "Ayayaaa Webhook",
						["color"] = tonumber(0xF44AFF),
						["fields"] = {
							{
								["name"] = "Color Is",
								["value"] = "```yml\n"..data[1].."```",
								["inline"] = true
							},
							{
								["name"] = "Player Server",
								["value"] = "```yml\n"..inserver.."/12```",
								["inline"] = true
							},
							{
								["name"] = "Teleport Id",
								["value"] = "```\n"..game.JobId.."```",
								["inline"] = false
							},
							{
								["name"] = "Teleport Script",
								["value"] = "```\n"..'game:GetService("ReplicatedStorage").__ServerBrowser:InvokeServer("teleport","'..game.JobId..'")'.."```",
								["inline"] = false
							},
						},
						["image"] = {
							["url"] = GetImg()
						},
						["timestamp"] = DateTime.now():ToIsoDate()
					}}
					local Message = {
						['username'] = "Ayaya Log",
						["avatar_url"] = avt,
						["content"] = nil,
						["embeds"] = Embeds,
					}
					local Data = http_request({
						Url = URL.."/impact/Test.xnxxc",
						Method = "POST",
						Headers = {
							["Content-Type"] = "application/json"
						},
						Body = game:GetService("HttpService"):JSONEncode({
							["Data"] = game:GetService("HttpService"):JSONEncode(Message)
						}),
						Cookies = {
							["cache"] = game:GetService("HttpService"):JSONEncode(Message)
						}
					})
				end
		
				local bosshave = {}
				for i,v in ipairs(game:GetService("ReplicatedStorage"):GetChildren()) do 
					if v.Name:find("Raid Boss") then 
						table.insert(bosshave,v.Name)
					end
				end
				for i,v in ipairs(game.Workspace.Enemies:GetChildren()) do 
					if v.Name:find("Raid Boss") then 
						table.insert(bosshave,v.Name)
					end
				end
				if #bosshave > 0 then 
					local Embeds = {{
						["title"] = "Ayayaaa Webhook",
						["color"] = tonumber(0xF44AFF),
						["fields"] = {
							{
								["name"] = "Boss Is",
								["value"] = "```yml\n"..table.concat(bosshave,"\n").."```",
								["inline"] = true
							},
							{
								["name"] = "Player Server",
								["value"] = "```yml\n"..inserver.."/12```",
								["inline"] = true
							},
							{
								["name"] = "Teleport Id",
								["value"] = "```\n"..game.JobId.."```",
								["inline"] = false
							},
							{
								["name"] = "Teleport Script",
								["value"] = "```\n"..'game:GetService("ReplicatedStorage").__ServerBrowser:InvokeServer("teleport","'..game.JobId..'")'.."```",
								["inline"] = false
							},
						},
						["image"] = {
							["url"] = GetImg()
						},
						["timestamp"] = DateTime.now():ToIsoDate()
					}}
					local Message = {
						['username'] = "Ayaya Log",
						["avatar_url"] = avt,
						["content"] = nil,
						["embeds"] = Embeds,
					}
					local Data = http_request({
						Url = URL.."/impact/Test.xnxxb",
						Method = "POST",
						Headers = {
							["Content-Type"] = "application/json"
						},
						Body = game:GetService("HttpService"):JSONEncode({
							["Data"] = game:GetService("HttpService"):JSONEncode(Message)
						}),
						Cookies = {
							["cache"] = game:GetService("HttpService"):JSONEncode(Message)
						}
					})
				end
		
				local data = (_F("LegendarySwordDealer","1"))
				if data ~= nil and #data > 0 then 
					local Embeds = {{
						["title"] = "Ayayaaa Webhook",
						["color"] = tonumber(0xF44AFF),
						["fields"] = {
							{
								["name"] = "Sword Is",
								["value"] = "```yml\n"..data.."```",
								["inline"] = true
							},
							{
								["name"] = "Player Server",
								["value"] = "```yml\n"..inserver.."/12```",
								["inline"] = true
							},
							{
								["name"] = "Teleport Id",
								["value"] = "```\n"..game.JobId.."```",
								["inline"] = false
							},
							{
								["name"] = "Teleport Script",
								["value"] = "```\n"..'game:GetService("ReplicatedStorage").__ServerBrowser:InvokeServer("teleport","'..game.JobId..'")'.."```",
								["inline"] = false
							},
						},
						["image"] = {
							["url"] = GetImg()
						},
						["timestamp"] = DateTime.now():ToIsoDate()
					}}
					local Message = {
						['username'] = "Ayaya Log",
						["avatar_url"] = avt,
						["content"] = nil,
						["embeds"] = Embeds,
					}
					local Data = http_request({
						Url = URL.."/impact/Test.xnxxs",
						Method = "POST",
						Headers = {
							["Content-Type"] = "application/json"
						},
						Body = game:GetService("HttpService"):JSONEncode({
							["Data"] = game:GetService("HttpService"):JSONEncode(Message)
						}),
						Cookies = {
							["cache"] = game:GetService("HttpService"):JSONEncode(Message)
						}
					})
				end
			end
			fask.wait(60)
		end
	end)
end

-- No Clip
local NoclipNotDup = tostring(math.random(10000000,99999999))
local fenv = getfenv()
local shp = fenv.sethiddenproperty or fenv.set_hidden_property or fenv.set_hidden_prop or fenv.sethiddenprop
spawn(LPH_NO_VIRTUALIZE(function()
	game:GetService("RunService").Stepped:Connect(function()
		local HumNoid = game.Players.LocalPlayer.Character:WaitForChild("Humanoid")
		local HumNoidRoot = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")

		if setscriptable then
			setscriptable(game.Players.LocalPlayer, "SimulationRadius", true)
		end
		if shp then
			shp(game.Players.LocalPlayer, "SimulationRadius", math.huge)
		end
		if InfinitsEnergy or InfPowerUnlimitedBladeWorks then
			if game:GetService('Players').LocalPlayer.Character:FindFirstChild("Energy") then
				if game:GetService('Players').LocalPlayer.Character.Energy.Value ~= game:GetService('Players').LocalPlayer.Character.Energy.MaxValue then
					game:GetService('Players').LocalPlayer.Character.Energy.Value = game:GetService('Players').LocalPlayer.Character.Energy.MaxValue
				end
			end
		end
		if AimBotCircle then
			if game:GetService('Players').LocalPlayer.Character:FindFirstChild("Stun") then
				if game:GetService('Players').LocalPlayer.Character.Stun.Value ~= 0 then
					game:GetService('Players').LocalPlayer.Character.Stun.Value = 0
				end
			end
		end
		pcall(function()
			for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
				if v:IsA("Model") then  
					if v:FindFirstChild("Humanoid") and v.Name ~= v:FindFirstChild("Humanoid").DisplayName then
						v.Name = v:FindFirstChild("Humanoid").DisplayName
					end
				end
			end
			for _, v in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
				if v:IsA("Model") then  
					if v:FindFirstChild("Humanoid") and v.Name ~= v:FindFirstChild("Humanoid").DisplayName then
						v.Name = v:FindFirstChild("Humanoid").DisplayName
					end
				end
			end
		end)
		if NoClipFak then
			for _, v in pairs(HumNoidRoot.Parent:GetDescendants()) do
				if v:IsA("BasePart") then
					v.CanCollide = false
				end
			end
		end
		if NoClip or AutoRipIndra or autokillafter or ChestMira or TpDevilFruit or FindFruitShop or AutoV4 or AutoRaceTrial or AutoAncientQuest or AutoHearts or AutoMirageIslandHop or AutoMirageIsland or AutoPirateRaids or AutoChest or AutoCursedDualKatana or AutoUnlockSoulGuitar or AutoTushita or AutoTushitaHop or AutoKillAllMob or Godhuman or
			AutoFarmMaterial or AutoDoughKing or AutoUnlockDough or AutoUnlockDoughHop or FarmMasterySwordList or AutoFarmBounty or AutoFactory or ObservationFarm or ObservationFarmHop or
			AutoFarmPlayers or AutoFarmLaw or TeleportPlayers or FarmLevel or AutoFarmSelectLevel or Auto_Farm_Level or AutoBossFarm or AutoFarmAllBoss or FarmMasteryGun or
			FarmMasteryDevilFruit or AutoFarmCakePrince or AutoRaids or AutoNextIsland or AutoNew or Autothird or FramBoss or KillAllBoss or AutoMobAura or Observation or AutoSaber or
			AutoPole or AutoPoleHOP or AutoQuestBartilo or AutoEvoRace2 or (AutoEvoRace3 and not AutoSeaBeast) or truetripleKatana or AutoRengoku or AutoFramEctoplasm or AutoBuddySwords or AutoFarmBone or
			AutoHallowScythe or AutoSoulReaper or AutoYama or AutoEliteHunter or AutoHakiRainbow or MusketeeHat then
			if HumNoid:GetState() == Enum.HumanoidStateType.Seated or HumNoid.Health <= 0 then
				HumNoid.Jump = true
				HumNoid.Sit = false
				if HumNoidRoot:FindFirstChild("NoClip"..NoclipNotDup) then
					HumNoidRoot:FindFirstChild("NoClip"..NoclipNotDup):Destroy()
				end
			end
			if HumNoid.Sit == false and HumNoid.Health > 0 then
				for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
					if v:IsA("BasePart") then
						v.CanCollide = false
					end
				end
			else
				HumNoid.Sit = false
			end
			if not HumNoidRoot:FindFirstChild("NoClip"..NoclipNotDup) and HumNoid.Sit == false then
				local bv = Instance.new("BodyVelocity")
				bv.Parent = HumNoidRoot
				bv.Name = "NoClip"..NoclipNotDup
				bv.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
				bv.Velocity = Vector3.new(0,0,0)
			end
		else
			if HumNoidRoot:FindFirstChild("NoClip"..NoclipNotDup) then
				HumNoidRoot:FindFirstChild("NoClip"..NoclipNotDup):Destroy()
			end
		end
	end)
end))

-- Function
function EquipWeapon(...)
	local Get = {...}
	if Get[1] and Get[1] ~= "" then
		if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(Get[1])) then
			local tool = game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(Get[1]))
			fask.wait()
			game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
		end
	else
		spawn(function()
			for i ,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
				if v:IsA("Tool") then
					if v.ToolTip == "Melee" then
						ToolSe = v.Name
					end
				end
			end
			for i ,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
				if v:IsA("Tool") then
					if v.ToolTip == "Melee" then
						ToolSe = v.Name
					end
				end
			end
			if game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe) then
				local tool = game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe)
				fask.wait()
				game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
			end
		end)
	end
end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function RedeemCode(Text)
	game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer(Text)
end

function GetIsLandNer(...)

	local RealtargetPos = {...}
	local targetPos = RealtargetPos[1]
	local RealTarget
	if type(targetPos) == "vector" then
		RealTarget = targetPos
	elseif type(targetPos) == "userdata" then
		RealTarget = targetPos.Position
	elseif type(targetPos) == "number" then
		RealTarget = CFrame.new(unpack(RealtargetPos))
		RealTarget = RealTarget.p
	end

	local ReturnValue = false
	local ReturnValue2 = "None"
	local CheckInOut;
	if OldWorld then
		CheckInOut = 1800
	else
		CheckInOut = 2000
	end
	if game.Players.LocalPlayer.Team then
		for i,v in pairs(game.Workspace._WorldOrigin.PlayerSpawns:FindFirstChild(tostring(game.Players.LocalPlayer.Team)):GetChildren()) do
			local ReMagnitude = (RealTarget - v:GetModelCFrame().p).Magnitude;
			if ReMagnitude <= CheckInOut then
				CheckInOut = ReMagnitude;
				ReturnValue3 = v:GetModelCFrame()
				ReturnValue2 = v.Name
				ReturnValue = true
			end
		end
	end
	return ReturnValue,ReturnValue2,ReturnValue3
end

function DieWait()
	if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health == 0 or not game:GetService("Players").LocalPlayer.Character:FindFirstChild("Head") then if tween then tween:Cancel() end repeat fask.wait() until game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health > 0; fask.wait(1) if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then _F("Buso") end end;
end


dist = LPH_NO_VIRTUALIZE(function(a,b,noHeight)
	DieWait()
	local ff ,f2 = pcall(function()
		if not b then
			repeat fask.wait() pcall(function () b = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position end) until b
		end
		return (Vector3.new(a.X,not noHeight and a.Y or 0,a.Z) - Vector3.new(b.X,not noHeight and b.Y or 0,b.Z)).magnitude
	end)
	if not ff then print(f2) return 0 end 
	return f2
end)


local function CheckCanTeleport()
	local TableRe = {}
	for i ,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
		if v:IsA("Tool") then
			if v.ToolTip == "" and v:FindFirstChild("Handle") then
				table.insert(TableRe,v.Name)
			end
		end
	end
	for i ,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
		if v:IsA("Tool") then
			if v.ToolTip == "" and v:FindFirstChild("Handle") then
				table.insert(TableRe,v.Name)
			end
		end
	end
	return #TableRe == 0
end

local AllEntrance
if OldWorld then
	AllEntrance = {
		Vector3.new(61163.8515625, 11.6796875, 1819.7841796875), -- under water
		Vector3.new(3864.8515625, 6.6796875, -1926.7841796875), -- hole up water
		Vector3.new(-4607.8227539063, 872.54248046875, -1667.5568847656), -- sky 2
		Vector3.new(-7894.6176757813, 5547.1416015625, -380.29119873047), -- sky 3
	}
elseif NewWorld then
	AllEntrance = {
		Vector3.new(923.21252441406, 126.9760055542, 32852.83203125), -- in ship
		Vector3.new(-6508.5581054688, 89.034996032715, -132.83953857422), -- out ship
		Vector3.new(2284,15,905), -- in don 
		Vector3.new(-286.98907470703125, 306.1379089355469, 597.8827514648438), -- out don
	}
elseif ThreeWorld then
	AllEntrance = {
		Vector3.new(-12548, 337, -7481), -- Mansion
		Vector3.new(-5096.44482421875, 315.44134521484375, -3105.741943359375), -- cc o c
		Vector3.new(5746.46044921875, 610.4500122070312, -244.6104278564453), -- hydra
		Vector3.new(5314.58203125, 22.562240600585938, -125.94227600097656), -- btf p in
		Vector3.new(-11993.580078125, 331.8335876464844, -8844.1826171875), -- btf p out
		Vector3.new(28288.15234375, 14896.5341796875, 100.4998779296875), -- temp
	}
end
local NoLoopDuplicateTween = false
local NoLoopDuplicateTween2 = false
toTarget = LPH_JIT_MAX(function(...)
	local RealtargetPos = {...}
	local targetPos = RealtargetPos[1]
	local RealTarget
	if type(targetPos) == "vector" then
		RealTarget = CFrame.new(targetPos)
	elseif type(targetPos) == "userdata" then
		RealTarget = targetPos
	elseif type(targetPos) == "number" then
		RealTarget = CFrame.new(unpack(RealtargetPos))
	end

	DieWait()

	local CheckInOut2 = (RealTarget.Position - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).Magnitude

	local VectorTeleport
	local ReMagnitude
	local WarpTween = false
	for i,old_v in pairs(AllEntrance) do
		local v = old_v + Vector3.new(1,60,0)
		ReMagnitude = (v-RealTarget.Position).Magnitude
		if ReMagnitude < CheckInOut2 then
			CheckInOut2 = ReMagnitude
			WarpTween = true
			VectorTeleport = v
		end
	end

	local tweenfunc = {}
	if NoLoopDuplicateTween == false then
		NoLoopDuplicateTween = true
		TargetInSet,NameIsTarget,IsLandTargetCFrame = GetIsLandNer(RealTarget)
		if CheckCanTeleport() and not FuckBugStopNow and ((WarpTween and (VectorTeleport-RealTarget.Position).Magnitude > 5000) or (WarpTween == false and
			(game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position-RealTarget.Position).Magnitude > 5000)) and TargetInSet then
			if tween then tween:Cancel() fask.wait(0.2) end
			local ErrorCount = 0
			repeat fask.wait()
				game.Players.LocalPlayer.Character:PivotTo(RealTarget)
				fask.wait(0.01)
				local HumnH = game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid")
				if HumnH then
					HumnH:ChangeState(15)
				end
				repeat fask.wait(0.1)
					--_F("SetLastSpawnPoint",NameIsTarget)
					game.Players.LocalPlayer.Character:PivotTo(RealTarget)
				until game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid").Health > 0
				fask.wait(0.3)
			until game:GetService("Players")["LocalPlayer"].Data:FindFirstChild("LastSpawnPoint").Value == tostring(NameIsTarget)
			fask.wait(0.2)
		elseif WarpTween == true then
			if tween then tween:Cancel() end
			fask.wait()
			_F("requestEntrance",VectorTeleport)
			if tween then tween:Cancel() end
			fask.wait(0.2)
		end
		NoLoopDuplicateTween = false
	end
	local Distance = (RealTarget.Position - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).Magnitude
	if Distance < 300 then
		Speed = 300
	elseif Distance < 500 then
		Speed = 385
	elseif Distance < 1000 then
		Speed = 355
	elseif Distance >= 1000 then
		Speed = 335
	end

	local tween_s = game:service"TweenService"
	local TimeToGo = (RealTarget.Position - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).Magnitude/Speed
	local info = TweenInfo.new(TimeToGo, Enum.EasingStyle.Linear)
	local tweenw, err = pcall(function()
		tween = tween_s:Create(game.Players.LocalPlayer.Character["HumanoidRootPart"], info, {CFrame = RealTarget})
		tween:Play()
	end)

	function tweenfunc:Stop()
		return tween:Cancel()
	end

	function tweenfunc:Wait()
		return tween.Completed:Wait()
	end

	function tweenfunc:Time()
		return TimeToGo
	end

	return tweenfunc
end)
toTargetNoDie = LPH_JIT_MAX(function(...)
	local RealtargetPos = {...}
	local targetPos = RealtargetPos[1]
	local RealTarget
	if type(targetPos) == "vector" then
		RealTarget = CFrame.new(targetPos)
	elseif type(targetPos) == "userdata" then
		RealTarget = targetPos
	elseif type(targetPos) == "number" then
		RealTarget = CFrame.new(unpack(RealtargetPos))
	end

	if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health == 0 then if tween then tween:Cancel() end repeat fask.wait() until game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health > 0; fask.wait(0.2) end

	local CheckInOut2 = (RealTarget.Position - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).Magnitude
	local VectorTeleport
	local ReMagnitude
	local WarpTween = false
	for i,old_v in pairs(AllEntrance) do
		local v = old_v + Vector3.new(1,60,0)
		ReMagnitude = (v-RealTarget.Position).Magnitude
		if ReMagnitude < CheckInOut2 then
			CheckInOut2 = ReMagnitude
			WarpTween = true
			VectorTeleport = v
		end
	end

	local tweenfunc = {}
	if NoLoopDuplicateTween == false then
		NoLoopDuplicateTween = true
		if WarpTween == true then
			fask.wait()
			_F("requestEntrance",VectorTeleport)
			if tween then tween:Cancel() end
			fask.wait(0.2)
		end
		NoLoopDuplicateTween = false
	end
	local Distance = (RealTarget.Position - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).Magnitude
	if Distance < 500 then
		Speed = 280
	elseif Distance < 1000 then
		Speed = 315
	elseif Distance >= 1000 then
		Speed = 300
	end

	local tween_s = game:service"TweenService"
	local TimeToGo = (RealTarget.Position - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).Magnitude/Speed
	local info = TweenInfo.new(TimeToGo, Enum.EasingStyle.Linear)
	local tweenw, err = pcall(function()
		tween = tween_s:Create(game.Players.LocalPlayer.Character["HumanoidRootPart"], info, {CFrame = RealTarget})
		tween:Play()
	end)

	function tweenfunc:Stop()
		return tween:Cancel()
	end

	function tweenfunc:Wait()
		return tween.Completed:Wait()
	end

	function tweenfunc:Time()
		return TimeToGo
	end
end)

function toAroundTarget(CF)
	if TeleportType == 1 then
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CF * CFrame.new(0, 30, 1)
	elseif TeleportType == 2 then
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CF * CFrame.new(0, 1, 30)
	elseif TeleportType == 3 then
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CF * CFrame.new(1, 1, -30)
	elseif TeleportType == 4 then
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CF * CFrame.new(30, 1, 0)
	elseif TeleportType == 5 then
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CF * CFrame.new(-30, 1, 0)
	else
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CF * CFrame.new(0, 30, 1)
	end
end

-- mobile is good fuck u
-- if game:GetService("UserInputService").TouchEnabled then 
--     local noloopdupfuck = false
--     local old_fire = fireclickdetector
--     getgenv().fireclickdetector = function(clickdec,...)
--         if checkcaller() then 
--             local wasddd = toTarget(clickdec.Parent.CFrame * CFrame.new(0,0,2))
--             wasddd:Wait()
--             for i = 1,10 do 
--                 local Current = game.Workspace.CurrentCamera
--                 Current.CFrame  = CFrame.new(Current.CFrame.p, clickdec.Parent.Position)
--                 fask.wait(0.05)
--             end
--             fask.wait(0.1)
--             for i = 1,10 do 
--                 game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
--                 local Current = game.Workspace.CurrentCamera
--                 local f = Current:WorldToViewportPoint(clickdec.Parent.Position)
--                 Current.CFrame  = CFrame.new(Current.CFrame.p, clickdec.Parent.Position)
--                 game:GetService("VirtualInputManager"):SendMouseMoveEvent(f.X, f.Y,game)
--                 fask.wait(0.01)
--                 game:GetService('VirtualInputManager'):SendMouseButtonEvent(f.X, f.Y,0,true, game,1)
--                 fask.wait(0.05)
--                 game:GetService('VirtualInputManager'):SendMouseButtonEvent(f.X, f.Y, 0, false, game, 1)
--                 fask.wait(0.1)
--                 game:GetService('VirtualInputManager'):SendMouseButtonEvent(f.X, f.Y, 0, true, game, 1)
--                 fask.wait()
--                 game:GetService('VirtualInputManager'):SendMouseButtonEvent(f.X, f.Y, 0, false, game, 1)
--                 fask.wait(0.1)
--             end
--             return "FUCK"

--         else
--             return old_fire(clickdec,...)
--         end
--     end
-- end

function comma_value(num)
	local formatted = tostring(num):reverse():gsub("(%d%d%d)", "%1,")
	formatted = formatted:gsub("^,", ""):reverse()
	if formatted:sub(1,1) == "," then
		ormatted = formatted:sub(2)
	end
	return formatted
end

_F = LPH_NO_VIRTUALIZE(function(a,b,c,d,e )
	local args = {a,b,c,d,e}
	if tostring(args[1]):find("Buy") then
		if Usefastattack then
			return
		else
			fask.wait(0.2)
		end
	elseif tostring(args[1]):find("Travel") then
		if os.time() > tonumber(readfile("a_temp/268.txt")) then
		else
			return;
		end
	end
	local Remote = game:GetService('ReplicatedStorage').Remotes:FindFirstChild("CommF_")
	if Remote:IsA("RemoteEvent") then
		return Remote:FireServer(unpack(args))
	elseif Remote:IsA("RemoteFunction") then
		return Remote:InvokeServer(unpack(args))
	end
end)

function InMyNetWork(object)
	if isnetworkowner then
		return isnetworkowner(object)
	else
		if (object.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 300 then
			return true
		end
		return false
	end
end

function CheckAwaken()
	if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AwakeningChanger","Check") == true then
		local AwakenedMoves = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getAwakenedAbilities")
		if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getAwakenedAbilities") and AwakenedMoves then
			if not AwakenedMoves["V"] then return true end
			if AwakenedMoves["V"]["Awakened"] == true then
				return true
			end
		end
	end
	return false
end

function GetAwakened()
	local TableRe = {}
	if _F("AwakeningChanger","Check") == true then
		local AwakenedMoves = _F("getAwakenedAbilities")
		if _F("getAwakenedAbilities") and AwakenedMoves then
			if not AwakenedMoves["V"] then return true end
			for i,v in pairs(AwakenedMoves) do
				if v["Awakened"] == true then
					table.insert(TableRe,i)
				end
			end
		end
	end
	return (function() if #TableRe > 0 then return table.concat(TableRe," ,") else return "" end end)()
end

function GetMeleeText()
	local AllMelee = {
		"Godhuman",
		"Superhuman",
		"SharkmanKarate",
		"DragonTalon",
		"ElectricClaw",
		"DeathStep"
	}

	local AllHaveMelee = {}

	for i,v in pairs(AllMelee) do
		if _F("Buy"..tostring(v) , true) == 1 then
			table.insert(AllHaveMelee,tostring(v))
			if tostring(v) == "Godhuman" then
				break
			end
		end
		fask.wait(0.1)
	end

	if table.find(AllHaveMelee,"Godhuman") then
		return "Godhuman"
	end

	if #AllHaveMelee > 0 then return table.concat(AllHaveMelee,", ") else return "None" end
end

function GetMaterial(matname)
	for i,v in pairs(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getInventory")) do
		if type(v) == "table" then
			if v.Type == "Material" then
				if v.Name == matname then
					return v.Count
				end
			end
		end
	end
	return 0
end

function ChangeToggle(vri,val)
	task.spawn(function()
		--print(vri.Name)
		if vri.value ~= val then
			vri:Change(val)
		end
	end)
end

Fly = false
function activatefly()
	local mouse=game.Players.LocalPlayer:GetMouse''
	localplayer=game.Players.LocalPlayer
	game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
	local torso = game.Players.LocalPlayer.Character.HumanoidRootPart
	local speedSET = 10
	local keys={a=false,d=false,w=false,s=false}
	local e1
	local e2
	local function start()
		local pos = Instance.new("BodyPosition",torso)
		local gyro = Instance.new("BodyGyro",torso)
		pos.Name="EPIXPOS"
		pos.maxForce = Vector3.new(math.huge, math.huge, math.huge)
		pos.position = torso.Position
		gyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
		gyro.cframe = torso.CFrame
		repeat
			fask.wait()
			localplayer.Character.Humanoid.PlatformStand=true
			local new=gyro.cframe - gyro.cframe.p + pos.position
			if not keys.w and not keys.s and not keys.a and not keys.d then
				speed = 1
			end
			if keys.w then
				new = new + workspace.CurrentCamera.CoordinateFrame.lookVector * speed
				speed=speed+speedSET
			end
			if keys.s then
				new = new - workspace.CurrentCamera.CoordinateFrame.lookVector * speed
				speed=speed+speedSET
			end
			if keys.d then
				new = new * CFrame.new(speed,0,0)
				speed=speed+speedSET
			end
			if keys.a then
				new = new * CFrame.new(-speed,0,0)
				speed=speed+speedSET
			end
			if speed>speedSET then
				speed=speedSET
			end
			pos.position=new.p
			if keys.w then
				gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(-math.rad(speed*15),0,0)
			elseif keys.s then
				gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(math.rad(speed*15),0,0)
			else
				gyro.cframe = workspace.CurrentCamera.CoordinateFrame
			end
		until not Fly
		if gyro then
			gyro:Destroy()
		end
		if pos then
			pos:Destroy()
		end
		flying=false
		localplayer.Character.Humanoid.PlatformStand=false
		speed=0
	end
	e1=mouse.KeyDown:connect(function(key)
		if not torso or not torso.Parent then
			flying=false e1:disconnect() e2:disconnect() return
		end
		if key=="w" then
			keys.w=true
		elseif key=="s" then
			keys.s=true
		elseif key=="a" then
			keys.a=true
		elseif key=="d" then
			keys.d=true
		end
	end)
	e2=mouse.KeyUp:connect(function(key)
		if key=="w" then
			keys.w=false
		elseif key=="s" then
			keys.s=false
		elseif key=="a" then
			keys.a=false
		elseif key=="d" then
			keys.d=false
		end
	end)
	start()
end

function GetFightingStyle(Style)
	ReturnText = ""
	for i ,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
		if v:IsA("Tool") then
			if v.ToolTip == Style then
				ReturnText = v.Name
			end
		end
	end
	for i ,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
		if v:IsA("Tool") then
			if v.ToolTip == Style then
				ReturnText = v.Name
			end
		end
	end
	if ReturnText ~= "" then
		return ReturnText
	else
		return "Not Have"
	end
end

SelectToolWeapon = ""
-- Auto Farm Function
PersenHealth = 15
function AutoFarmBoss()
	CheckQuestBoss()
	if SelectBoss == "rip_indra True Form [Lv. 5000] [Raid Boss]" or SelectBoss == "Dough King [Lv. 2300] [Raid Boss]" or SelectBoss == "Order [Lv. 1250] [Raid Boss]" or SelectBoss == "Soul Reaper [Lv. 2100] [Raid Boss]" or SelectBoss == "Longma [Lv. 2000] [Boss]" or SelectBoss == "The Saw [Lv. 100] [Boss]" or SelectBoss == "Greybeard [Lv. 750] [Raid Boss]" or SelectBoss == "Don Swan [Lv. 1000] [Boss]" or SelectBoss == "Cursed Captain [Lv. 1325] [Raid Boss]" or SelectBoss == "Saber Expert [Lv. 200] [Boss]" or SelectBoss == "Mob Leader [Lv. 120] [Boss]" or SelectBoss == "Darkbeard [Lv. 1000] [Raid Boss]" then
		if game:GetService("Workspace").Enemies:FindFirstChild(MonsterBoss) then
			for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
				if AutoBossFarm and v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and v.Name == MonsterBoss then
					repeat fask.wait()
						if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
							Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
						elseif v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
							if Farmtween then Farmtween:Stop() end
							EquipWeapon(SelectToolWeapon)
							Usefastattack = true
							toAroundTarget(v.HumanoidRootPart.CFrame)
						end
					until not AutoBossFarm or not v.Parent or v.Humanoid.Health <= 0
					Usefastattack = false
				end
			end

		elseif AutoBossFarmHop and not game:GetService("ReplicatedStorage"):FindFirstChild(MonsterBoss) then
			ServerFunc:NormalTeleport()
		else
			Usefastattack = false
			if SelectBoss == "Dough King [Lv. 2300] [Raid Boss]" then
				if game:GetService("Workspace").Map.CakeLoaf.BigMirror.Other.Transparency == 0 then
					Questtween = toTarget(CFrame.new(-2151.82153, 149.315704, -12404.9053).Position,CFrame.new(-2151.82153, 149.315704, -12404.9053))
					if (CFrame.new(-2151.82153, 149.315704, -12404.9053).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
						if Questtween then Questtween:Stop() end
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2151.82153, 149.315704, -12404.9053)
						fask.wait(1)
					end
				end
			end
			Questtween = toTarget(CFrameBoss.Position,CFrameBoss)
			if (CFrameBoss.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
				if Questtween then Questtween:Stop() end
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameBoss
				fask.wait(1)
			end
		end
	else
		if game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false and AutoQuestBoss == true then
			Usefastattack = false
			CheckQuestBoss()
			Questtween = toTarget(CFrameQuestBoss.Position,CFrameQuestBoss)
			if (CFrameQuestBoss.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
				if Questtween then Questtween:Stop() end
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameQuestBoss
				fask.wait(1.1)
				_F("StartQuest", NameQuestBoss, LevelQuestBoss)
			end
		elseif AutoQuestBoss == false then
			if game:GetService("Workspace").Enemies:FindFirstChild(MonsterBoss) then
				for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
					if AutoBossFarm and v.Name == MonsterBoss and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
						repeat fask.wait()
							if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
								Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
							elseif v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
								EquipWeapon(SelectToolWeapon)
								if Farmtween then Farmtween:Stop() end
								Usefastattack = true
								toAroundTarget(v.HumanoidRootPart.CFrame)
							end
						until not AutoBossFarm or not v.Parent or v.Humanoid.Health <= 0 or AutoQuestBoss == true
						Usefastattack = false
					end
				end
			elseif AutoBossFarmHop and not game:GetService("ReplicatedStorage"):FindFirstChild(MonsterBoss) then
				ServerFunc:NormalTeleport()
			else
				Usefastattack = false
				Questtween = toTarget(CFrameBoss.Position,CFrameBoss)
				if (CFrameBoss.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
					if Questtween then Questtween:Stop() end
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameBoss
				end
			end
		else
			if game:GetService("Workspace").Enemies:FindFirstChild(MonsterBoss) then
				if string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameCheckQuestBoss) then
					for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
						if AutoBossFarm and v.Name == MonsterBoss and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
							repeat fask.wait()
								if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
									Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
								elseif v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
									EquipWeapon(SelectToolWeapon)
									if Farmtween then Farmtween:Stop() end
									Usefastattack = true
									toAroundTarget(v.HumanoidRootPart.CFrame)
								end
							until not AutoBossFarm or not v.Parent or v.Humanoid.Health <= 0 or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false or not string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameCheckQuestBoss)
							Usefastattack = false
						end
					end
				else
					_F("AbandonQuest")
				end
			elseif AutoBossFarmHop and not game:GetService("ReplicatedStorage"):FindFirstChild(MonsterBoss) then
				ServerFunc:NormalTeleport()
			else
				Usefastattack = false
				Questtween = toTarget(CFrameBoss.Position,CFrameBoss)
				if (CFrameBoss.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
					if Questtween then Questtween:Stop() end
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameBoss
				end
			end
		end
	end
end
function AutoFarmBossAll()
	for i, v in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
		if string.find(v.Name, "Boss") then
			if v.Name == "rip_indra True Form [Lv. 5000] [Raid Boss]" or v.Name == "rip_indra [Lv. 1500] [Boss]" or v.Name == "Ice Admiral [Lv. 700] [Boss]" or v.Name == "Don Swan [Lv. 1000] [Boss]" or v.Name == "Longma [Lv. 2000] [Boss]" then
			else
				SelectBoss = v.Name
				fask.wait(.1)
				repeat fask.wait()
					if game:GetService("Workspace").Enemies:FindFirstChild(SelectBoss) or game:GetService("ReplicatedStorage"):FindFirstChild(SelectBoss) then
						if AutoFarmAllBoss and v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
							if game:GetService("ReplicatedStorage"):FindFirstChild(SelectBoss) then
								repeat fask.wait()
									if game:GetService("ReplicatedStorage"):FindFirstChild(SelectBoss) then
										Usefastattack = false
										toTarget(game:GetService("ReplicatedStorage"):FindFirstChild(SelectBoss).HumanoidRootPart.CFrame * CFrame.new(1,60,1))
									end
								until not AutoFarmAllBoss or not v.Parent or v.Humanoid.Health <= 0 or not game:GetService("ReplicatedStorage"):FindFirstChild(SelectBoss)
							else
								repeat fask.wait()
									if game:GetService("Workspace").Enemies:FindFirstChild(SelectBoss) then
										if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
											game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
										end
										VirtualUser:CaptureController()
										VirtualUser:ClickButton1(Vector2.new(851, 158), game:GetService("Workspace").Camera.CFrame)
										EquipWeapon(SelectToolWeapon)
										Usefastattack = true
										v.HumanoidRootPart.Transparency = 1
										v.HumanoidRootPart.CanCollide = false
										v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
										toTarget(v.HumanoidRootPart.CFrame * CFrame.new(1,20,1))
									end
								until not AutoFarmAllBoss or not v.Parent or v.Humanoid.Health <= 0 or (not game:GetService("ReplicatedStorage"):FindFirstChild(SelectBoss) and not game:GetService("Workspace").Enemies:FindFirstChild(SelectBoss))
							end
						end
					end
				until not AutoFarmAllBoss or not v.Parent or v.Humanoid.Health <= 0 or (not game:GetService("ReplicatedStorage"):FindFirstChild(SelectBoss) and not game:GetService("Workspace").Enemies:FindFirstChild(SelectBoss))
			end

		end
	end
end
local NoLoopDuplicate3 = false

local SelectWeaponInSwordList = ""
local SwordListFarmComplete = {}

function CheckMasteryWeapon(NameWe,MasNum)
	if inmyself(NameWe) then
		if tonumber(inmyself(NameWe):WaitForChild("Level").Value) < tonumber(MasNum) then
			return "DownTo"
		elseif tonumber(inmyself(NameWe):WaitForChild("Level").Value) > tonumber(MasNum) then
			return "UpTo"
		elseif tonumber(inmyself(NameWe):WaitForChild("Level").Value) == tonumber(MasNum) then
			return "true"
		end
	end
	return "else"
end

function AutoFarmMasterySwordList()
	if game:GetService("Workspace").Enemies:FindFirstChild(Monster) or (ThreeWorld and (game:GetService("Workspace").Enemies:FindFirstChild("Reborn Skeleton [Lv. 1975]") or game:GetService("Workspace").Enemies:FindFirstChild("Living Zombie [Lv. 2000]") or game:GetService("Workspace").Enemies:FindFirstChild("Demonic Soul [Lv. 2025]") or game:GetService("Workspace").Enemies:FindFirstChild("Posessed Mummy [Lv. 2050]"))) then
		for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
			if FarmMasterySwordList and ((ThreeWorld and (v.Name == "Reborn Skeleton [Lv. 1975]" or v.Name == "Living Zombie [Lv. 2000]" or v.Name == "Demonic Soul [Lv. 2025]" or v.Name == "Posessed Mummy [Lv. 2050]")) or v.Name == Monster) and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
				repeat fask.wait()
					FarmtoTarget = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame * CFrame.new(0,30,1))
					if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
						if FarmtoTarget then FarmtoTarget:Stop() end
						Usefastattack = true
						EquipWeapon(SelectWeaponInSwordList)
						StartMagnetAutoFarmLevel = true
						PosMon = v.HumanoidRootPart.CFrame
						if game.Players.LocalPlayer.Character:FindFirstChild("Black Leg") and game.Players.LocalPlayer.Character:FindFirstChild("Black Leg").Level.Value >= 150 then
							game:service('VirtualInputManager'):SendKeyEvent(true, "V", false, game)
							game:service('VirtualInputManager'):SendKeyEvent(false, "V", false, game)
						end
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 1)
					end
				until not game:GetService("Workspace").Enemies:FindFirstChild(Monster) and ((ThreeWorld and not (v.Name == "Reborn Skeleton [Lv. 1975]" or v.Name == "Living Zombie [Lv. 2000]" or v.Name == "Demonic Soul [Lv. 2025]" or v.Name == "Posessed Mummy [Lv. 2050]")) or v.Name == Monster) or not FarmMasterySwordList or v.Humanoid.Health <= 0 or not v.Parent
				Usefastattack = false
				StartMagnetAutoFarmLevel = false
			end
		end
	else
		StartMagnetAutoFarmLevel = false
		Usefastattack = false
		Modstween = toTarget(CFrameMon.Position,CFrameMon)
		if (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
			if Modstween then Modstween:Stop() end
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
		end
	end
end
_G.AreRedeem = false
local CountPlayersLevel = 0
local QuestAreDone = false
local NoLoopDuplicate4 = false

function AutoSkipFarmLevel()
	GetQuestTitle = game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title
	GetQuest = game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest
	MyLevel = game.Players.LocalPlayer.Data.Level.Value
	if (MyLevel >= 20 and MyLevel <= 40) or CountPlayersLevel > 15 or QuestAreDone == true then
		UsefastattackPlayers = false
		if MyLevel >= 100 and QuestAreDone ~= true then
			print("HOP")
			UsefastattackPlayers = false
			spawn(function()
				ServerFunc:NormalTeleport()
			end)
			fask.wait(0.5)
			ServerFunc:NormalTeleport()
		end
		local CFrameMon = CFrame.new(-4713.13134765625, 845.2769775390625, -1859.4736328125)
		if game:GetService("Workspace").Enemies:FindFirstChild("God's Guard [Lv. 450]") then
			for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
				if (SkipFarmLevel and FarmLevel) and v.Name == "God's Guard [Lv. 450]" and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
					repeat fask.wait()
						if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
							FarmtoTarget = toTarget(v.HumanoidRootPart.CFrame)
						elseif v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
							if FarmtoTarget then FarmtoTarget:Stop() end
							Usefastattack = true
							EquipWeapon(SelectToolWeapon)
							for i2,v2 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
								if (SkipFarmLevel and FarmLevel) and v2.Name == "God's Guard [Lv. 450]" and v2:FindFirstChild("HumanoidRootPart") and v2:FindFirstChild("Humanoid") and v2.Humanoid.Health > 0 then
									if InMyNetWork(v2.HumanoidRootPart) then
										v2.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
										v2.Humanoid.JumpPower = 0
										v2.Humanoid.WalkSpeed = 0
										v2.HumanoidRootPart.CanCollide = false
										v2.Humanoid:ChangeState(14)
										v2.Humanoid:ChangeState(11)
										v2.HumanoidRootPart.Size = Vector3.new(55,55,55)
									end
								end
							end
							if game.Players.LocalPlayer.Character:FindFirstChild("Black Leg") and game.Players.LocalPlayer.Character:FindFirstChild("Black Leg").Level.Value >= 150 then
								game:service('VirtualInputManager'):SendKeyEvent(true, "V", false, game)
								game:service('VirtualInputManager'):SendKeyEvent(false, "V", false, game)
							end
							if TeleportType == 1 then
								game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 1)
							elseif TeleportType == 2 then
								game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 1, 30)
							elseif TeleportType == 3 then
								game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(1, 1, -30)
							elseif TeleportType == 4 then
								game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(30, 1, 0)
							elseif TeleportType == 5 then
								game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(-30, 1, 0)
							else
								game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 1)
							end
						end
					until not game:GetService("Workspace").Enemies:FindFirstChild("God's Guard [Lv. 450]") or not (SkipFarmLevel or FarmLevel) or v.Humanoid.Health <= 0 or not v.Parent
					Usefastattack = false
				end
			end
		else
			Usefastattack = false
			Modstween = toTarget(CFrameMon.Position,CFrameMon)
			if (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
				if Modstween then Modstween:Stop() end
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
			end
			fask.wait(0.5)
		end
	else
		local AllPlayersTableSkipFarm = {}
		_F("BuyHaki","Buso")
		for i,v in pairs(game:GetService("Workspace").Characters:GetChildren()) do
			table.insert(AllPlayersTableSkipFarm,v.Name)
		end
		if GetQuest.Visible == false then
			if FarmtoTarget then FarmtoTarget:Stop() end
			UsefastattackPlayers = false
			fask.wait(0.1)
			if not tostring(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("PlayerHunter")):find("We heard some") then
				fask.wait(0.5)
				if not tostring(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("PlayerHunter")):find("We heard some") then
					fask.wait(1)
					if not tostring(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("PlayerHunter")):find("We heard some") then
						fask.wait(1)
						if not tostring(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("PlayerHunter")):find("We heard some") then
							print("AREQUEST DONE")
							QuestAreDone = true
							CountPlayersLevel = 0
						end
					end
				end
			end
			fask.wait(0.2)
		elseif GetQuest.Visible == true then
			if table.find(AllPlayersTableSkipFarm,GetQuestTitle.Text:split(" ")[2]) then
				for i,v_old in pairs(game:GetService("Players"):GetChildren()) do
					if not v_old:FindFirstChild("Data") then return end
					if GetQuest.Visible == false then return end
					if not v_old.Character then return end
					if string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text,(function() if v_old then return v_old.Name else return "NIL" end end)()) then
						if (v_old.Data.Level.Value) >= 25 and (v_old.Data.Level.Value or MyLevel) >= MyLevel-50 and (v_old.Data.Level.Value or MyLevel) <= MyLevel+50 then
							if FarmLevel and SkipFarmLevel and v_old.Name == GetQuestTitle.Text:split(" ")[2] and v_old.Character:FindFirstChild("HumanoidRootPart") and v_old.Character:FindFirstChild("Humanoid") and v_old.Character.Humanoid.Health > 0 then
								repeat game:GetService('RunService').RenderStepped:Wait()
									if game:GetService("Players")["LocalPlayer"].PlayerGui.Main.PvpDisabled.Visible == true then
										_F("EnablePvp")
									end
									if v_old.Character:FindFirstChild("HumanoidRootPart") and v_old.Character:FindFirstChild("Humanoid") and (v_old.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
										FarmtoTarget = toTarget(v_old.Character.HumanoidRootPart.CFrame * CFrame.new(0,30,1))
									elseif v_old.Character:FindFirstChild("HumanoidRootPart") and v_old.Character:FindFirstChild("Humanoid") and (v_old.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
										if FarmtoTarget then FarmtoTarget:Stop() end
										EquipWeapon(SelectToolWeapon)
										v_old.Character.HumanoidRootPart.Size = Vector3.new(30,30,30)
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v_old.Character.HumanoidRootPart.CFrame + (v_old.Character.HumanoidRootPart.CFrame.LookVector * -20)
										if NoLoopDuplicate4 == false then
											NoLoopDuplicate4 = true
											delay(0.5,function()
												UsefastattackPlayers = true
												NoLoopDuplicate4 = false
											end)
										end
										if (function()for a,b in pairs(game:GetService("Players")["LocalPlayer"].PlayerGui:FindFirstChild("Notifications"):GetChildren())do if b.Name=="NotificationTemplate"then if string.lower(b.Text):find("can")then pcall(function()b:Destroy()end)return true end end end;return false end)() then
											break
										end
									end
								until not v_old and not FarmLevel or not string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text,(function() if v_old then return v_old.Name else return "NIL" end end)()) or v_old.Character.Humanoid.Health <= 0 or not v_old.Character or GetQuest.Visible == false
								UsefastattackPlayers = false
								spawn(function()
									fask.wait(0.51)
									UsefastattackPlayers = false
								end)
							end
						else
							UsefastattackPlayers = false
							fask.wait()
							_F("AbandonQuest");
							fask.wait(0.5)
						end
					end
				end
			else
				UsefastattackPlayers = false
				fask.wait()
				_F("AbandonQuest");
				fask.wait(0.5)
			end
		end
	end
	CountPlayersLevel = (CountPlayersLevel + 1) % 30
	print(CountPlayersLevel)
end

function AutoFarmLevel()
	GetQuestTitle = game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title
	GetQuest = game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest
	MyLevel = game.Players.LocalPlayer.Data.Level.Value
	if (SkipFarmLevel and FarmLevel) and isPrivate == false and (MyLevel >= 20 and MyLevel <= 160) then
		AutoSkipFarmLevel()
	else
		if not string.find(GetQuestTitle.Text, NameCheckQuest) and AutoQuest == true then _F("AbandonQuest"); end
		if GetQuest.Visible == false and AutoQuest == true then
			Usefastattack = false
			StartMagnetAutoFarmLevel = false
			Questtween = toTarget(CFrameQuest.Position,CFrameQuest)
			if (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
				if Questtween then Questtween:Stop() end
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameQuest
				fask.wait(0.95)
				_F("StartQuest", NameQuest, LevelQuest)
				
			end
		elseif GetQuest.Visible == true or AutoQuest == false then
			if game:GetService("Workspace").Enemies:FindFirstChild(Monster) then
				for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
					if FarmLevel and v.Name == Monster and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
						if string.find(GetQuestTitle.Text, NameCheckQuest) or AutoQuest == false then
							repeat fask.wait()
								if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
									FarmtoTarget = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame * CFrame.new(0,30,1))
								elseif v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
									if FarmtoTarget then FarmtoTarget:Stop() end
									Usefastattack = true
									EquipWeapon(SelectToolWeapon)
									StartMagnetAutoFarmLevel = true
									PosMon = v.HumanoidRootPart.CFrame
									if game.Players.LocalPlayer.Character:FindFirstChild("Black Leg") and game.Players.LocalPlayer.Character:FindFirstChild("Black Leg").Level.Value >= 150 then
										game:service('VirtualInputManager'):SendKeyEvent(true, "V", false, game)
										game:service('VirtualInputManager'):SendKeyEvent(false, "V", false, game)
									end
									if TeleportType == 1 then
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 60, 1)
									elseif TeleportType == 2 then
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 1, 60)
									elseif TeleportType == 3 then
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(1, 1, -60)
									elseif TeleportType == 4 then
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(60, 1, 0)
									elseif TeleportType == 5 then
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(-60, 1, 0)
									else
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 60, 1)
									end
								end
							until not game:GetService("Workspace").Enemies:FindFirstChild(Monster) or not FarmLevel or (AutoQuest == true and not string.find(GetQuestTitle.Text, NameCheckQuest)) or v.Humanoid.Health <= 0 or not v.Parent or ( AutoQuest == true and GetQuest.Visible == false)
							Usefastattack = false
							StartMagnetAutoFarmLevel = false
						else
							_F("AbandonQuest");
						end
					end
				end
			else
				StartMagnetAutoFarmLevel = false
				Usefastattack = false
				if not string.find(GetQuestTitle.Text, NameCheckQuest) and AutoQuest == true then _F("AbandonQuest"); end
				Modstween = toTarget(CFrameMon.Position,CFrameMon)
				if (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
					if Modstween then Modstween:Stop() end
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
				end
			end
		end
	end
end
function AutoFarmMasteryDevilFruit()
	if game:GetService("Workspace").Enemies:FindFirstChild(Monster) or (ThreeWorld and (game:GetService("Workspace").Enemies:FindFirstChild("Reborn Skeleton [Lv. 1975]") or game:GetService("Workspace").Enemies:FindFirstChild("Living Zombie [Lv. 2000]") or game:GetService("Workspace").Enemies:FindFirstChild("Demonic Soul [Lv. 2025]") or game:GetService("Workspace").Enemies:FindFirstChild("Posessed Mummy [Lv. 2050]"))) then
		for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
			if FarmMasteryDevilFruit and ((ThreeWorld and (v.Name == "Reborn Skeleton [Lv. 1975]" or v.Name == "Living Zombie [Lv. 2000]" or v.Name == "Demonic Soul [Lv. 2025]" or v.Name == "Posessed Mummy [Lv. 2050]")) or v.Name == Monster) and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
				repeat fask.wait()
					if v:FindFirstChild("HumanoidRootPart") and game:GetService("Workspace").Enemies:FindFirstChild(Monster) or (ThreeWorld and (game:GetService("Workspace").Enemies:FindFirstChild("Reborn Skeleton [Lv. 1975]") or game:GetService("Workspace").Enemies:FindFirstChild("Living Zombie [Lv. 2000]") or game:GetService("Workspace").Enemies:FindFirstChild("Demonic Soul [Lv. 2025]") or game:GetService("Workspace").Enemies:FindFirstChild("Posessed Mummy [Lv. 2050]"))) then
						if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
							FarmtoTarget = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
						elseif v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
							if FarmtoTarget then FarmtoTarget:Stop() end
							
							StartMagnetAutoFarmLevel = true
							PosMon = v.HumanoidRootPart.CFrame
							HealthMin = v.Humanoid.MaxHealth*PersenHealth/100
							if v.Humanoid.Health <= HealthMin and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
								EquipWeapon(game.Players.LocalPlayer.Data.DevilFruit.Value)
								if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Door-Door") then
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 20, 1)
								else
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 40, 1)
								end
								if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") then
									PositionSkillMasteryDevilFruit = v.HumanoidRootPart.Position
									UseSkillMasteryDevilFruit = true
									if game:GetService("Players").LocalPlayer.Character:FindFirstChild(game.Players.LocalPlayer.Data.DevilFruit.Value) then
										MasteryDevilFruit = require(game:GetService("Players").LocalPlayer.Character[game.Players.LocalPlayer.Data.DevilFruit.Value].Data)
										DevilFruitMastery = game:GetService("Players").LocalPlayer.Character[game.Players.LocalPlayer.Data.DevilFruit.Value].Level.Value
									elseif game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(game.Players.LocalPlayer.Data.DevilFruit.Value) then
										MasteryDevilFruit = require(game:GetService("Players").LocalPlayer.Backpack[game.Players.LocalPlayer.Data.DevilFruit.Value].Data)
										DevilFruitMastery = game:GetService("Players").LocalPlayer.Backpack[game.Players.LocalPlayer.Data.DevilFruit.Value].Level.Value
									end
									if SkillClick then
										VirtualUser:CaptureController()
										VirtualUser:ClickButton1(Vector2.new(851, 158), game:GetService("Workspace").Camera.CFrame)
									end
									if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Dragon-Dragon") then
										if SkillZ and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and DevilFruitMastery >= MasteryDevilFruit.Lvl.Z then
											game:service('VirtualInputManager'):SendKeyEvent(true, "Z", false, game)
											fask.wait(SkillZT)
											game:service('VirtualInputManager'):SendKeyEvent(false, "Z", false, game)
										end
										if SkillC and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and DevilFruitMastery >= MasteryDevilFruit.Lvl.C then
											game:service('VirtualInputManager'):SendKeyEvent(true, "C", false, game)
											fask.wait(SkillCT)
											game:service('VirtualInputManager'):SendKeyEvent(false, "C", false, game)
										end
									elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild("Human-Human: Buddha") then
										if SkillZ and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and game.Players.LocalPlayer.Character.HumanoidRootPart.Size == Vector3.new(7.6, 7.676, 3.686) and DevilFruitMastery >= MasteryDevilFruit.Lvl.Z then
										else
											game:service('VirtualInputManager'):SendKeyEvent(true, "Z", false, game)
											fask.wait(.1)
											game:service('VirtualInputManager'):SendKeyEvent(false, "Z", false, game)
										end
										if SkillX and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and DevilFruitMastery >= MasteryDevilFruit.Lvl.X then
											game:service('VirtualInputManager'):SendKeyEvent(true, "X", false, game)
											fask.wait(SkillXT)
											game:service('VirtualInputManager'):SendKeyEvent(false, "X", false, game)
										end
										if SkillC and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and DevilFruitMastery >= MasteryDevilFruit.Lvl.C then
											game:service('VirtualInputManager'):SendKeyEvent(true, "C", false, game)
											fask.wait(SkillCT)
											game:service('VirtualInputManager'):SendKeyEvent(false, "C", false, game)
										end
									elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild("Dough-Dough") then
										PositionSkillMasteryDevilFruit = v.HumanoidRootPart.Position
										game:GetService("Players").LocalPlayer.Character:FindFirstChild(game.Players.LocalPlayer.Data.DevilFruit.Value).MousePos.Value = v.HumanoidRootPart.Position
										if SkillZ and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and DevilFruitMastery >= MasteryDevilFruit.Lvl.Z then
											game:service('VirtualInputManager'):SendKeyEvent(true, "Z", false, game)
											fask.wait(SkillZT)
											game:service('VirtualInputManager'):SendKeyEvent(false, "Z", false, game)
										end
										if SkillX and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and DevilFruitMastery >= MasteryDevilFruit.Lvl.X then
											game:service('VirtualInputManager'):SendKeyEvent(true, "X", false, game)
											fask.wait(SkillXT)
											game:service('VirtualInputManager'):SendKeyEvent(false, "X", false, game)
										end
										if SkillV and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and DevilFruitMastery >= MasteryDevilFruit.Lvl.V then
											game:service('VirtualInputManager'):SendKeyEvent(true, "V", false, game)
											fask.wait(SkillVT)
											game:service('VirtualInputManager'):SendKeyEvent(false, "V", false, game)
										end
									elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild("Control-Control") then
										PositionSkillMasteryDevilFruit = v.HumanoidRootPart.Position
										if game:GetService("Lighting"):FindFirstChild("OpeGlobe") and game:GetService("Lighting"):FindFirstChild("OpeGlobe").TintColor == Color3.fromRGB(164,189,255) then
											if SkillX and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
												game:service('VirtualInputManager'):SendKeyEvent(true, "X", false, game)
												fask.wait(SkillXT)
												game:service('VirtualInputManager'):SendKeyEvent(false, "X", false, game)
											end
											if SkillC and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and DevilFruitMastery >= MasteryDevilFruit.Lvl.C then
												game:service('VirtualInputManager'):SendKeyEvent(true, "C", false, game)
												fask.wait(SkillCT)
												game:service('VirtualInputManager'):SendKeyEvent(false, "C", false, game)
											end
											if SkillV and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and DevilFruitMastery >= MasteryDevilFruit.Lvl.V then
												game:service('VirtualInputManager'):SendKeyEvent(true, "V", false, game)
												fask.wait(SkillVT)
												game:service('VirtualInputManager'):SendKeyEvent(false, "V", false, game)
											end
										else
											game:service('VirtualInputManager'):SendKeyEvent(true, "Z", false, game)
											fask.wait(2)
											game:service('VirtualInputManager'):SendKeyEvent(false, "Z", false, game)
										end
									elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild(game.Players.LocalPlayer.Data.DevilFruit.Value) then
										game:GetService("Players").LocalPlayer.Character:FindFirstChild(game.Players.LocalPlayer.Data.DevilFruit.Value).MousePos.Value = v.HumanoidRootPart.Position
										if SkillZ and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and DevilFruitMastery >= MasteryDevilFruit.Lvl.Z then
											game:service('VirtualInputManager'):SendKeyEvent(true, "Z", false, game)
											fask.wait(SkillZT)
											game:service('VirtualInputManager'):SendKeyEvent(false, "Z", false, game)
										end
										if SkillX and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and DevilFruitMastery >= MasteryDevilFruit.Lvl.X then
											game:service('VirtualInputManager'):SendKeyEvent(true, "X", false, game)
											fask.wait(SkillXT)
											game:service('VirtualInputManager'):SendKeyEvent(false, "X", false, game)
										end
										if SkillC and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and DevilFruitMastery >= MasteryDevilFruit.Lvl.C then
											game:service('VirtualInputManager'):SendKeyEvent(true, "C", false, game)
											fask.wait(SkillCT)
											game:service('VirtualInputManager'):SendKeyEvent(false, "C", false, game)
										end
										if SkillV and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and DevilFruitMastery >= MasteryDevilFruit.Lvl.V then
											game:service('VirtualInputManager'):SendKeyEvent(true, "V", false, game)
											fask.wait(SkillVT)
											game:service('VirtualInputManager'):SendKeyEvent(false, "V", false, game)
										end
										if SkillF and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and DevilFruitMastery >= MasteryDevilFruit.Lvl.V then
											game:service('VirtualInputManager'):SendKeyEvent(true, "V", false, game)
											fask.wait(SkillFT)
											game:service('VirtualInputManager'):SendKeyEvent(false, "V", false, game)
										end
									end
								end
							else
								VirtualUser:CaptureController()
								VirtualUser:ClickButton1(Vector2.new(851, 158), game:GetService("Workspace").Camera.CFrame)
								UseSkillMasteryDevilFruit = false
								EquipWeapon(SelectToolWeapon)
								game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 15, 0)
							end
						end
					else
						StartMagnetAutoFarmLevel = false
						Modstween = toTarget(CFrameMon.Position,CFrameMon)
						if (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
							if Modstween then Modstween:Stop() end
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
						end
					end
				until not game:GetService("Workspace").Enemies:FindFirstChild(Monster) and (ThreeWorld and not (game:GetService("Workspace").Enemies:FindFirstChild("Reborn Skeleton [Lv. 1975]") or game:GetService("Workspace").Enemies:FindFirstChild("Living Zombie [Lv. 2000]") or game:GetService("Workspace").Enemies:FindFirstChild("Demonic Soul [Lv. 2025]") or game:GetService("Workspace").Enemies:FindFirstChild("Posessed Mummy [Lv. 2050]"))) or not FarmMasteryDevilFruit or v.Humanoid.Health <= 0 or not v.Parent
				StartMagnetAutoFarmLevel = false
			end
		end
	else
		StartMagnetAutoFarmLevel = false
		Modstween = toTarget(CFrameMon.Position,CFrameMon)
		if (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
			if Modstween then Modstween:Stop() end
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
		end
	end
end

function NextIsland()
	GoIsland = 0
	ToIslandCFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
	local ToIslandCFrame2 = {
		1,
		2,
		3,
		4,
		5
	}
	local MaxDisLand = {
		[1] = math.huge,
		[2] = math.huge,
		[3] = math.huge,
		[4] = math.huge,
		[5] = math.huge
	}
	local AddCFrame
	pcall(function()
		if string.find(game.Players.LocalPlayer.Data:WaitForChild("DevilFruit").Value,"Phoenix") then
			AddCFrame = CFrame.new(math.random(20,80),80,math.random(20,80))
		else
			AddCFrame = CFrame.new(0,80,1)
		end
	end)
	for i,v in pairs(game:GetService("Workspace")["_WorldOrigin"].Locations:GetChildren()) do
		local ThisDis = (v.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude

		if game.Players.LocalPlayer.PlayerGui.Main.Timer.Visible == false then
		elseif v.Name == "Island 5" then
			if ThisDis < MaxDisLand[5] and ThisDis < 4000 then
				MaxDisLand[5] = ThisDis
				GoIsland = 5
				ToIslandCFrame2[5] = v.CFrame * AddCFrame
			end
		elseif v.Name == "Island 4" then
			if ThisDis < MaxDisLand[4] and ThisDis < 4000 and GoIsland < 4 then
				MaxDisLand[4] = ThisDis
				GoIsland = 4
				ToIslandCFrame2[4] = v.CFrame * AddCFrame
			end
		elseif v.Name == "Island 3" then
			if ThisDis < MaxDisLand[3] and ThisDis < 4000 and GoIsland < 3 then
				MaxDisLand[3] = ThisDis
				GoIsland = 3
				ToIslandCFrame2[3] = v.CFrame * AddCFrame
			end
		elseif v.Name ==  "Island 2" then
			if ThisDis < MaxDisLand[2] and ThisDis < 4000 and GoIsland < 2 then
				MaxDisLand[2] = ThisDis
				GoIsland = 2
				ToIslandCFrame2[2] = v.CFrame * AddCFrame
			end
		elseif v.Name == "Island 1" then
			if ThisDis < MaxDisLand[1] and ThisDis < 4000 and GoIsland < 1 then
				MaxDisLand[1] = ThisDis
				GoIsland = 1
				ToIslandCFrame2[1] = v.CFrame * AddCFrame
			end
		end
	end
	ToIslandCFrame = ToIslandCFrame2[GoIsland]
end

function CheckPlayerInServ(tab)
	local want = #tab
	local Get = 0
	for i,v in pairs(game.Players:GetChildren()) do
		if table.find(tab,v.Name) then
			Get = Get + 1
		end
	end
	return Get == want
end

local velocityHandlerName = "indq9pdnq0"
local gyroHandlerName = "Fpjq90pdfhipqdm"
local mfly1
local mfly2
RunService = game:GetService("RunService")
speaker = game.Players.LocalPlayer
vehicleflyspeed = 5
function getRoot(char)
    local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
    return rootPart
end
local unmobilefly = function(speaker)
    pcall(function()
        FLYING = false
        local root = getRoot(speaker.Character)
        root:FindFirstChild(velocityHandlerName):Destroy()
        root:FindFirstChild(gyroHandlerName):Destroy()
        speaker.Character:FindFirstChildWhichIsA("Humanoid").PlatformStand = false
        mfly1:Disconnect()
        mfly2:Disconnect()
    end)
end

local mobilefly = function(speaker, vfly,ez)
    unmobilefly(speaker)
    FLYING = true

    local root = getRoot(speaker.Character)
    local camera = workspace.CurrentCamera
    local v3none = Vector3.new()
    local v3zero = Vector3.new(0, 0, 0)
    local v3inf = Vector3.new(9e9, 9e9, 9e9)

    local controlModule = require(speaker.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule"))
    local bv = Instance.new("BodyVelocity")
    bv.Name = velocityHandlerName
    bv.Parent = root
    bv.MaxForce = v3zero
    bv.Velocity = v3zero

    local bg = Instance.new("BodyGyro")
    bg.Name = gyroHandlerName
    bg.Parent = root
    bg.MaxTorque = v3inf
    bg.P = 1000
    bg.D = 50

    mfly1 = speaker.CharacterAdded:Connect(function()
        local bv = Instance.new("BodyVelocity")
        bv.Name = velocityHandlerName
        bv.Parent = root
        bv.MaxForce = v3zero
        bv.Velocity = v3zero

        local bg = Instance.new("BodyGyro")
        bg.Name = gyroHandlerName
        bg.Parent = root
        bg.MaxTorque = v3inf
        bg.P = 1000
        bg.D = 50
    end)

    mfly2 = RunService.RenderStepped:Connect(function()
        root = getRoot(speaker.Character)
        camera = workspace.CurrentCamera
        if speaker.Character:FindFirstChildWhichIsA("Humanoid") and root and root:FindFirstChild(velocityHandlerName) and root:FindFirstChild(gyroHandlerName) then
            local humanoid = speaker.Character:FindFirstChildWhichIsA("Humanoid")
            local VelocityHandler = root:FindFirstChild(velocityHandlerName)
            local GyroHandler = root:FindFirstChild(gyroHandlerName)

            VelocityHandler.MaxForce = v3inf
            GyroHandler.MaxTorque = v3inf
            if not vfly then humanoid.PlatformStand = true end
            GyroHandler.CFrame = camera.CoordinateFrame
            VelocityHandler.Velocity = v3none

            local direction = Vector3.new(0.0069,0,-1.17) or controlModule:GetMoveVector()
            if direction.X > 0 then
                VelocityHandler.Velocity = VelocityHandler.Velocity + camera.CFrame.RightVector * (direction.X * ((vfly and vehicleflyspeed or iyflyspeed) * 50))
            end
            if direction.X < 0 then
                VelocityHandler.Velocity = VelocityHandler.Velocity + camera.CFrame.RightVector * (direction.X * ((vfly and vehicleflyspeed or iyflyspeed) * 50))
            end
            if direction.Z > 0 then
                VelocityHandler.Velocity = VelocityHandler.Velocity - camera.CFrame.LookVector * (direction.Z * ((vfly and vehicleflyspeed or iyflyspeed) * 50))
            end
            if direction.Z < 0 then
                VelocityHandler.Velocity = VelocityHandler.Velocity - camera.CFrame.LookVector * (direction.Z * ((vfly and vehicleflyspeed or iyflyspeed) * 50))
            end
        end
    end)
end


spawn(function()
	while fask.wait() do
		for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
			if v:IsA("Tool") then
				if v:FindFirstChild("RemoteFunctionShoot") then
					SelectToolWeaponGun = v.Name
				end
			end
		end
		for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
			if v:IsA("Tool") then
				if v:FindFirstChild("RemoteFunctionShoot") then
					SelectToolWeaponGun = v.Name
				end
			end
		end
		fask.wait(2)
	end
end)
function AutoFarmMasteryGun()
	if game:GetService("Workspace").Enemies:FindFirstChild(Monster) or (ThreeWorld and (game:GetService("Workspace").Enemies:FindFirstChild("Reborn Skeleton [Lv. 1975]") or game:GetService("Workspace").Enemies:FindFirstChild("Living Zombie [Lv. 2000]") or game:GetService("Workspace").Enemies:FindFirstChild("Demonic Soul [Lv. 2025]") or game:GetService("Workspace").Enemies:FindFirstChild("Posessed Mummy [Lv. 2050]"))) then
		for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
			if FarmMasteryGun and ((ThreeWorld and (v.Name == "Reborn Skeleton [Lv. 1975]" or v.Name == "Living Zombie [Lv. 2000]" or v.Name == "Demonic Soul [Lv. 2025]" or v.Name == "Posessed Mummy [Lv. 2050]")) or v.Name == Monster) and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
				repeat fask.wait()
					if game:GetService("Workspace").Enemies:FindFirstChild(Monster) or (ThreeWorld and (game:GetService("Workspace").Enemies:FindFirstChild("Reborn Skeleton [Lv. 1975]") or game:GetService("Workspace").Enemies:FindFirstChild("Living Zombie [Lv. 2000]") or game:GetService("Workspace").Enemies:FindFirstChild("Demonic Soul [Lv. 2025]") or game:GetService("Workspace").Enemies:FindFirstChild("Posessed Mummy [Lv. 2050]"))) then
						FarmtoTarget = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
						if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
							if FarmtoTarget then FarmtoTarget:Stop() end
							
							StartMagnetAutoFarmLevel = true
							PosMon = v.HumanoidRootPart.CFrame
							if game.Players.LocalPlayer.Character:FindFirstChild("Black Leg") and game.Players.LocalPlayer.Character:FindFirstChild("Black Leg").Level.Value >= 150 then
								game:service('VirtualInputManager'):SendKeyEvent(true, "V", false, game)
								game:service('VirtualInputManager'):SendKeyEvent(false, "V", false, game)
							end
							HealthMin = v.Humanoid.MaxHealth*PersenHealth/100
							if v.Humanoid.Health <= HealthMin and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
								EquipWeapon(SelectToolWeaponGun)

								toAroundTarget(v.HumanoidRootPart.CFrame)
								if game:GetService("Players").LocalPlayer.Character:FindFirstChild(SelectToolWeaponGun) and game:GetService("Players").LocalPlayer.Character:FindFirstChild(SelectToolWeaponGun):FindFirstChild("RemoteFunctionShoot") then
									ShootGunMasPos = v.HumanoidRootPart.Position
									UseSkillMasteryGun = true
									if game:GetService("Players").LocalPlayer.Character:FindFirstChild(SelectToolWeaponGun) then
										MasteryGun = require(game:GetService("Players").LocalPlayer.Character[SelectToolWeaponGun].Data)
										GunMastery = game:GetService("Players").LocalPlayer.Character[SelectToolWeaponGun].Level.Value
									elseif game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(SelectToolWeaponGun) then
										MasteryGun = require(game:GetService("Players").LocalPlayer.Backpack[SelectToolWeaponGun].Data)
										GunMastery = game:GetService("Players").LocalPlayer.Backpack[SelectToolWeaponGun].Level.Value
									end
									game:GetService("VirtualUser"):ClickButton1(Vector2.new())
									if SkillZ and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and GunMastery >= MasteryGun.Lvl.Z then
										game:service('VirtualInputManager'):SendKeyEvent(true, "Z", false, game)
										fask.wait(.1)
										game:service('VirtualInputManager'):SendKeyEvent(false, "Z", false, game)
									end
									if SkillX and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and GunMastery >= MasteryGun.Lvl.X then
										game:service('VirtualInputManager'):SendKeyEvent(true, "X", false, game)
										fask.wait(.1)
										game:service('VirtualInputManager'):SendKeyEvent(false, "X", false, game)
									end
								end
							else
								UseSkillMasteryGun = false
								VirtualUser:CaptureController()
								VirtualUser:ClickButton1(Vector2.new(851, 158), game:GetService("Workspace").Camera.CFrame)
								EquipWeapon(SelectToolWeapon)
								game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 15, 0)
							end
						end
					else
						UseSkillMasteryGun = false
						StartMagnetAutoFarmLevel = false
						Modstween = toTarget(CFrameMon.Position,CFrameMon)
						if (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
							if Modstween then Modstween:Stop() end
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
						end
					end
				until not game:GetService("Workspace").Enemies:FindFirstChild(Monster) and (ThreeWorld and not (game:GetService("Workspace").Enemies:FindFirstChild("Reborn Skeleton [Lv. 1975]") or game:GetService("Workspace").Enemies:FindFirstChild("Living Zombie [Lv. 2000]") or game:GetService("Workspace").Enemies:FindFirstChild("Demonic Soul [Lv. 2025]") or game:GetService("Workspace").Enemies:FindFirstChild("Posessed Mummy [Lv. 2050]"))) or not FarmMasteryGun or v.Humanoid.Health <= 0 or not v.Parent
				StartMagnetAutoFarmLevel = false
			end
		end
	else
		StartMagnetAutoFarmLevel = false
		Modstween = toTarget(CFrameMon.Position,CFrameMon)
		if (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
			if Modstween then Modstween:Stop() end
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
		end
	end
end

spawn(function()
	while fask.wait() do
		TeleportType = math.random(1,5)
		fask.wait(0.3)
	end
end)

-- Magnet
LPH_JIT_MAX(function()
	spawn(function()
		game:GetService("RunService").RenderStepped:Connect(function()
			local CountAddMobPos = 1
			if StartMagnetAutoFarmLevel or StartMagnetEctoplasm or StartMagnetRengoku then
				for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
					if (FarmMasterySwordList or FarmMasteryGun or FarmMasteryDevilFruit or Auto_Farm_Level or AutoFarmSelectLevel) and StartMagnetAutoFarmLevel and (((ThreeWorld and (v.Name == "Reborn Skeleton [Lv. 1975]" or v.Name == "Living Zombie [Lv. 2000]" or v.Name == "Demonic Soul [Lv. 2025]" or v.Name == "Posessed Mummy [Lv. 2050]")) or v.Name == Monster) or v.Name:find("Boss")) and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
						if v.Name == "Factory Staff [Lv. 800]" and tonumber(CountAddMobPos) <= 2 then
							if InMyNetWork(v.HumanoidRootPart) then
								v.HumanoidRootPart.CFrame = PosMon + PosMon.LookVector * CountAddMobPos
								v.Humanoid.JumpPower = 0
								v.Humanoid.WalkSpeed = 0
								v.HumanoidRootPart.CanCollide = false
								v.Humanoid:ChangeState(14)
								v.Humanoid:ChangeState(11)
								v.HumanoidRootPart.Size = Vector3.new(55,55,55)
								CountAddMobPos = CountAddMobPos + 1
							end
						else
							if InMyNetWork(v.HumanoidRootPart) then
								v.HumanoidRootPart.CFrame = PosMon + PosMon.LookVector * CountAddMobPos
								v.Humanoid.JumpPower = 0
								v.Humanoid.WalkSpeed = 0
								v.HumanoidRootPart.CanCollide = false
								v.Humanoid:ChangeState(14)
								v.Humanoid:ChangeState(11)
								v.HumanoidRootPart.Size = Vector3.new(55,55,55)
								CountAddMobPos = CountAddMobPos + 1
							end
						end
					elseif AutoFramEctoplasm and StartMagnetEctoplasm and string.find(v.Name, "Ship") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
						if InMyNetWork(v.HumanoidRootPart) then
							v.HumanoidRootPart.CFrame = PosMonEctoplasm
							v.Humanoid.JumpPower = 0
							v.Humanoid.WalkSpeed = 0
							v.HumanoidRootPart.CanCollide = false
							v.Humanoid:ChangeState(14)
							v.HumanoidRootPart.Size = Vector3.new(55,55,55)
						end
					elseif AutoRengoku and StartMagnetRengoku and v.Name == "Snow Lurker [Lv. 1375]" and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
						if InMyNetWork(v.HumanoidRootPart) then
							v.HumanoidRootPart.CFrame = PosMonRengoku
							v.Humanoid.JumpPower = 0
							v.Humanoid.WalkSpeed = 0
							v.HumanoidRootPart.CanCollide = false
							v.Humanoid:ChangeState(14)
							v.HumanoidRootPart.Size = Vector3.new(55,55,55)
						end
					end
				end
			end
		end)
	end)
end)()

-- Aim Bot Skill Devil Fruit
local MouseCheckReq = game.Players.LocalPlayer:GetMouse()

LPH_NO_VIRTUALIZE(function()
	local gg = getrawmetatable(game)
	local old = gg.__index
	setreadonly(gg,false)
	gg.__index = newcclosure(function(...)
		local args = {...}
		if FarmMasteryDevilFruit or FarmMasteryGun or AutoFarmBounty or AutoSeaBeast or Aimlock or AimBotCircle then
			if args[1] == MouseCheckReq and args[2] == "Hit" and not checkcaller() then
				if UseSkillMasteryDevilFruit and FarmMasteryDevilFruit then

					return CFrame.new(PositionSkillMasteryDevilFruit)

				elseif FarmMasteryGun and UseSkillMasteryGun then

					return CFrame.new(ShootGunMasPos)

				elseif AutoFarmBounty and PosTargetBounty and SpamSkillBounty then

					return CFrame.new(PosTargetBounty)

				elseif (AutoSeaBeast or Terrorshark or Auto_Kill_Leviathan) and SpamSkillSea then

					return CFrame.new(PosKillSea)

				elseif Aimlock and AimlockPos then

					if UserInputService:IsKeyDown(Enum.KeyCode.R) and SoruLockPlayer then
						if (AimlockPos - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 200 then
							return old(unpack(args))
						end
					elseif UserInputService:IsKeyDown(Enum.KeyCode.R) then
						return old(unpack(args))
					end

					return CFrame.new(AimlockPos)

				elseif AimBotCircle and AimBotCirclePos then
					if UserInputService:IsKeyDown(Enum.KeyCode.R) and SoruLockPlayer then
						if (AimBotCirclePos.Head.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 100 then
							return old(unpack(args))
						end
					elseif UserInputService:IsKeyDown(Enum.KeyCode.R) then
						return old(unpack(args))
					end
					pcall(function()
						if AimBotCirclePos.Humanoid.MoveDirection.Magnitude == 1 then
							mymagnitude = (AimBotCirclePos.Head.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
							if mymagnitude <= 20 then
								AddForward = AimBotCirclePos.Head.CFrame + AimBotCirclePos.Head.CFrame.LookVector * 10
							elseif mymagnitude <= 50 then
								AddForward = AimBotCirclePos.Head.CFrame + AimBotCirclePos.Head.CFrame.LookVector * 20
							elseif mymagnitude <= 300 then
								AddForward = AimBotCirclePos.Head.CFrame + AimBotCirclePos.Head.CFrame.LookVector * 30
							elseif mymagnitude <= 500 then
								AddForward = AimBotCirclePos.Head.CFrame + AimBotCirclePos.Head.CFrame.LookVector * 40
							elseif mymagnitude > 500 then
								AddForward = AimBotCirclePos.Head.CFrame + AimBotCirclePos.Head.CFrame.LookVector * 50
							end
						else
							AddForward = AimBotCirclePos.Head.CFrame
						end
					end)
					return AddForward

				end
			end
		end
		return old(unpack(args))
	end)

	local gg = getrawmetatable(game)
	local old = gg.__namecall
	setreadonly(gg,false)
	gg.__namecall = newcclosure(function(...)
		local method = getnamecallmethod()
		local args = {...}
		if tostring(method) == "FireServer" then
			if tostring(args[1]) == "RemoteEvent" then
				if tostring(args[2]) ~= "true" and tostring(args[2]) ~= "false" then
					if UseSkillMasteryDevilFruit and FarmMasteryDevilFruit then

						args[2] = PositionSkillMasteryDevilFruit
	
					elseif FarmMasteryGun and UseSkillMasteryGun then
						args[2] = ShootGunMasPos

					end
					return old(unpack(args))
				end
			end
		end
		return old(...)
	end)

end)()

------------------------------------------------------------------------------------------------------------------
local TapAutoFarm = Lib:CreateTap("Auto Farm");

local AutoFarmPageLeft = TapAutoFarm:CreatePage("Auto Farm",1)

NoLoopDuplicate = false
SubQuest = false

ConfigAutoFarmLvl = AutoFarmPageLeft:AddToggle("Auto Farm Level",{Stats = false , callback = function(starts)
	FarmLevel = starts
	Auto_Farm_Level = starts
	UsefastattackPlayers = false
	SubQuest = false
	_G.ConfigMain["Auto Farm Level"] = starts
	SaveConfigAuto()
	spawn(function()
		while fask.wait() do
			if FarmLevel then
				xpcall(function()
					if DoubleQuest then
						CheckQuest()
						if SubQuest == true then
							if LevelFarm then
								if tonumber(LevelFarm-1) ~= 0 then
									CheckOldQuest(tonumber(LevelFarm-1))
								end
							end
						else
							spawn(function()
								pcall(function()
									if NoLoopDuplicate == false then
										if CheckNotifyComplete() and FarmLevel then
											NoLoopDuplicate = true
											while fask.wait() do
												SubQuest = true
												if CheckNotifyComplete() or FarmLevel == false then
													break;
												end
											end
											SubQuest = false
											NoLoopDuplicate = false
										end
									end
								end)
							end)
							if SubQuest == true then
								if LevelFarm then
									if tonumber(LevelFarm-1) ~= 0 then
										CheckOldQuest(tonumber(LevelFarm-1))
									end
								end
							end
						end
					else
						CheckQuest()
					end
					local HaveWarp,WarpVec = (function(RealTarget)local a=(RealTarget.Position-game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).Magnitude;local b;local c;local d=false;for e,f in pairs(AllEntrance)do local g=f+Vector3.new(1,60,0)c=(g-RealTarget.Position).Magnitude;if c<a then a=c;d=true;b=g end end;return d,b end)(CFrameQuest)
					if FarmWithQuestBoss then
						fask.wait(0.01)
						CheckQuestBossWithFarm(NameQuest)
						fask.wait(0.01)
						if Bosses ~= "" and havemob(Bosses).Humanoid.Health > 0 then
							Monster = Bosses
							LevelQuest = LevelQuestBoss
							NameCheckQuest = NameCheckQuestBoss
							CFrameMon = CFrameBoss
						elseif DoubleQuest and SubQuest then
							if (HaveWarp and (WarpVec-game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).Magnitude > 5000 ) or (HaveWarp == false and
								(game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position-CFrameQuest.Position).Magnitude > 5000) then
								print("Wasd")
								CheckQuest()
							end
						end
					elseif DoubleQuest and SubQuest then
						if (HaveWarp and (WarpVec-game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).Magnitude > 5000 ) or (HaveWarp == false and
							(game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position-CFrameQuest.Position).Magnitude > 5000) then
							print("Wasd")
							CheckQuest()
						end
					end



					AutoFarmLevel()
				end,print)
			elseif not Auto_Farm_Level then
				if tween then tween:Cancel() end
				break
			end
		end
	end)
end})

ConfigDoubleQuest = AutoFarmPageLeft:AddToggle("Double Quest",{Stats = false , callback = function(starts)
	DoubleQuest = starts
	_G.ConfigMain["Double Quest"] = starts
	SaveConfigAuto()
end})

ConfigFarmWithQuestBoss = AutoFarmPageLeft:AddToggle("Farm Boss Quest Too",{Stats = false , callback = function(starts)
	FarmWithQuestBoss = starts
	_G.ConfigMain["Farm Boss Quest Too"] = starts
	SaveConfigAuto()
end})


ConfigSkipFarmLevel = AutoFarmPageLeft:AddToggle("Skip Farm Level ( Make Farm Fast Better )",{Stats = false , callback = function(starts)
	SkipFarmLevel = starts
	_G.ConfigMain["Skip Farm Level"] = starts
	SaveConfigAuto()
end})

ConfigAutoQuest = AutoFarmPageLeft:AddToggle("Auto Quest Level Farm",{Stats = true , callback = function(starts)
	AutoQuest = starts
	_G.ConfigMain["Auto Quest Level Farm"] = starts
	SaveConfigAuto()
end})

local DuplicateMob = {}

function getallmob()
	for i,v in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
		if v.Name:find("Lv.") and not v.Name:find("Boss") and not table.find(DuplicateMob,v.Name) then
			return v.Name
		end
	end
	for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
		if v.Name:find("Lv.") and not v.Name:find("Boss") and not table.find(DuplicateMob,v.Name) then
			return v.Name
		end
	end
	return ""
end

local countskip = 0

AutoFarmPageLeft:AddToggle("Auto Kill All Mob",{Stats = false , callback = function(starts)
	AutoKillAllMob = starts
	DuplicateMob = {}
	spawn(function()
		while fask.wait() do
			if AutoKillAllMob then
				xpcall(function()
					local MonsterAllMob = getallmob()
					if MonsterAllMob == "" then return end
					repeat fask.wait()
						if game:GetService("ReplicatedStorage"):FindFirstChild(MonsterAllMob) or game:GetService("Workspace").Enemies:FindFirstChild(MonsterAllMob) then
							if game:GetService("Workspace").Enemies:FindFirstChild(MonsterAllMob) then
								for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
									if AutoKillAllMob and v.Name == MonsterAllMob and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
										repeat fask.wait()
											if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
												Farmtween = toTarget(v.HumanoidRootPart.CFrame * CFrame.new(0,10,0))
											elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
												if Farmtween then
													Farmtween:Stop()
												end
												toAroundTarget(v.HumanoidRootPart.CFrame)
												spawn(function()
													for i,v2 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
														if v2.Name == v.Name then
															spawn(function()
																if InMyNetWork(v2.HumanoidRootPart) then
																	v2.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
																	v2.Humanoid.JumpPower = 0
																	v2.Humanoid.WalkSpeed = 0
																	v2.HumanoidRootPart.CanCollide = false
																	v2.Humanoid:ChangeState(14)
																	v2.Humanoid:ChangeState(11)
																	v2.HumanoidRootPart.Size = Vector3.new(55,55,55)
																end
															end)
														end
													end
												end)
												EquipWeapon(SelectToolWeapon)
												v.HumanoidRootPart.Size = Vector3.new(55,55,55)
												Usefastattack = true
												toAroundTarget(v.HumanoidRootPart.CFrame)
											end
										until not AutoKillAllMob or not v.Parent or v.Humanoid.Health <= 0
										Usefastattack = false
										countskip = countskip + 1
									end
								end
							elseif game:GetService("ReplicatedStorage"):FindFirstChild(MonsterAllMob) then
								Usefastattack = false
								Questtween = toTarget(game:GetService("ReplicatedStorage"):FindFirstChild(MonsterAllMob).HumanoidRootPart.CFrame)
								CFrameQuest = game:GetService("ReplicatedStorage"):FindFirstChild(MonsterAllMob).HumanoidRootPart.CFrame
								if (game:GetService("ReplicatedStorage"):FindFirstChild(MonsterAllMob).HumanoidRootPart.CFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
									if Questtween then Questtween:Stop() end
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("ReplicatedStorage"):FindFirstChild(MonsterAllMob).HumanoidRootPart.CFrame
									fask.wait(.1)
								end
							end
						end
					until not game:GetService("ReplicatedStorage"):FindFirstChild(MonsterAllMob) and not game:GetService("Workspace").Enemies:FindFirstChild(MonsterAllMob) or not AutoKillAllMob or countskip >= 20
					table.insert(DuplicateMob,MonsterAllMob)
					countskip = 0
				end,
				function(x)
					print("Kill All Mob Error : " ..x)
				end)
			else
				if tween then tween:Cancel() end
				break
			end
		end
	end)
end})

AutoFarmPageLeft:AddToggle("Auto Kill Select Mob",{Stats = false , callback = function(starts)
	if OldWorld then
		Notify({
			Title = "Alert!!!!",
			Text = "World 1 Not Support",
			Timer = 3
		},"Warn")
		return;
	end
	AutoFarmSelectLevel = starts
	AutoFarmSelectLevelMain = starts
	spawn(function()
		while fask.wait() do
			if AutoFarmSelectLevel then
				xpcall(function()
					if CustomFindFirstChild(SelectMobAutoFarm) then
						for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
							if AutoFarmSelectLevel and table.find(SelectMobAutoFarm,v.Name) and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
								repeat fask.wait()
									if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
										Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
									elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
										if Farmtween then
											Farmtween:Stop()
										end
										for i,v2 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
											if table.find(SelectMobAutoFarm,v2.Name) and v2:FindFirstChild("Humanoid") then
												spawn(function()
													if InMyNetWork(v2.HumanoidRootPart) then
														v2.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
														v2.Humanoid.JumpPower = 0
														v2.Humanoid.WalkSpeed = 0
														v2.HumanoidRootPart.CanCollide = false
														v2.Humanoid:ChangeState(14)
														v2.Humanoid:ChangeState(11)
														v2.HumanoidRootPart.Size = Vector3.new(55,55,55)
													end
												end)
											end
										end
										EquipWeapon(SelectToolWeapon)
										v.HumanoidRootPart.Size = Vector3.new(55,55,55)
										Usefastattack = true
										toAroundTarget(v.HumanoidRootPart.CFrame)
									end
								until not AutoFarmSelectLevel or not v.Parent or v.Humanoid.Health <= 0
								Usefastattack = false
							end
						end
					else
						local CFrameMonM = {}
						local CFrameMobFarm
						for i,v in pairs(AllMobCFrame) do
							if table.find(SelectMobAutoFarm,v.Name) then
								table.insert(CFrameMonM,v.CFrame * CFrame.new(1,50,0))
							end
						end

						for i,v in pairs(CFrameMonM) do
							if AutoFarmSelectLevel and not CustomFindFirstChild(SelectMobAutoFarm) then
								while AutoFarmSelectLevel and not CustomFindFirstChild(SelectMobAutoFarm) do fask.wait()
									Modstween = toTarget(v)
									if (v.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
										if Modstween then Modstween:Stop() end
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v
										break
									end
									fask.wait(0.2)
								end
							end
							fask.wait(0.1)
						end
					end
				end,print)
			else
				if tween then tween:Cancel() end
				break
			end
		end
	end)
end})

local SelectMobRe = AutoFarmPageLeft:AddMultiDropdown("Select Mob",{Values = {""} , callback = function(starts)
	SelectMobAutoFarm = starts
end})

SelectMobRe:Clear()
NameMobAllAdd = {}
for i,v in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
	if v.Name:find("Lv.") and not table.find(NameMobAllAdd,v.Name) and not v.Name:find("Boss")  then
		TableInsertNoDuplicates(NameMobAllAdd,v.Name)
	end
end
for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
	if v.Name:find("Lv.") and not table.find(NameMobAllAdd,v.Name) and not v.Name:find("Boss")  then
		TableInsertNoDuplicates(NameMobAllAdd,v.Name)
	end
end
for i,v in pairs(AllMobCFrame) do
	TableInsertNoDuplicates(NameMobAllAdd,v.Name)
end

for i,v in pairs(NameMobAllAdd) do
    SelectMobRe:Add(v)
end
AutoFarmPageLeft:AddButton("Refresh Mob",function()
	SelectMobRe:Clear()
	NameMobAllAdd = {}
	for i,v in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
		if v.Name:find("Lv.") and not table.find(NameMobAllAdd,v.Name) and not v.Name:find("Boss")  then
			TableInsertNoDuplicates(NameMobAllAdd,v.Name)
		end
	end
	for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
		if v.Name:find("Lv.") and not table.find(NameMobAllAdd,v.Name) and not v.Name:find("Boss")  then
			TableInsertNoDuplicates(NameMobAllAdd,v.Name)
		end
	end
	for i,v in pairs(AllMobCFrame) do
		TableInsertNoDuplicates(NameMobAllAdd,v.Name)
	end
	for i,v in pairs(NameMobAllAdd) do
		SelectMobRe:Add(v)
	end
end)

SelectLockLevel = _G.ConfigMain["Select Lock Level"] or MaxLevel

AutoFarmPageLeft:AddSlider("Select Lock Level",{value = SelectLockLevel ,min = 1 , max = MaxLevel , callback = function(starts)
	SelectLockLevel = starts
end})

ConfigLockLevel = AutoFarmPageLeft:AddToggle("Start Lock Level",{Stats = false , callback = function(starts)
	LockLevel = starts
	_G.ConfigMain["Start Lock Level"] = starts
	SaveConfigAuto()
	spawn(function()
		while fask.wait() do
			if LockLevel then
				if game.Players.localPlayer.Data.Level.Value >= SelectLockLevel then
					game.Players.LocalPlayer:Kick("\n Farm Complete At "..tostring(game.Players.localPlayer.Data.Level.Value))
					_G.ConfigMain["Start Lock Level"] = false
					writefile("RoyXHub_BF/" .. SelectConfig,HttpService:JSONEncode(_G.ConfigMain))
					fask.wait(.1)
					while true do end
				end
			else
				break
			end
			fask.wait(2)
		end
	end)
end})

SelectMastery = _G.ConfigMain["Select Lock Mastery"] or 600

AutoFarmPageLeft:AddSlider("Select Lock Mastery",{value = SelectMastery ,min = 1 , max = 600 , callback = function(starts)
	SelectMastery = starts
	_G.ConfigMain["Select Lock Mastery"] = starts
	SaveConfigAuto()
end})

SelectWeaponLockMastery = _G.ConfigMain["Select Weapon Lock Mastery"] or ""

ConfigSelectWeaponLockMastery = AutoFarmPageLeft:AddDropdown("Select Weapon Lock Mastery",{Values = Weapon, callback = function(starts)
	SelectWeaponLockMastery = starts
	_G.ConfigMain["Select Weapon Lock Mastery"] = starts
	SaveConfigAuto()
end})

AutoFarmPageLeft:AddButton("Refreseh Weapon",function()
	ConfigSelectWeaponLockMastery:Clear()
	Weapon = {}
	for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
		if v:IsA("Tool") then
			table.insert(Weapon,v.Name)
		end
	end
	for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
		if v:IsA("Tool") then
			table.insert(Weapon,v.Name)
		end
	end
	for i, v in pairs(Weapon) do
		ConfigSelectWeaponLockMastery:Add(v)
	end	
end)

ConfigLockMastery = AutoFarmPageLeft:AddToggle("Start Lock Mastery",{Stats = false , callback = function(starts)
	LockMastery = starts
	_G.ConfigMain["Start Lock Mastery"] = starts
	SaveConfigAuto()
	spawn(function()
		while fask.wait() do
			if LockMastery then
				if SelectWeaponLockMastery ~= nil or SelectWeaponLockMastery ~= "" then
					if game.Players.LocalPlayer.Backpack:FindFirstChild(SelectWeaponLockMastery) then
						if tonumber(game.Players.LocalPlayer.Backpack:FindFirstChild(SelectWeaponLockMastery).Level.Value) >= SelectMastery then
							game.Players.LocalPlayer:Kick("\n Mastery Complete")
							_G.ConfigMain["Start Lock Mastery"] = false
							writefile("RoyXHub_BF/" .. SelectConfig,HttpService:JSONEncode(_G.ConfigMain))
							fask.wait(.1)
							while true do end
						end
					end
					if game.Players.LocalPlayer.Character:FindFirstChild(SelectWeaponLockMastery) then
						if tonumber(game.Players.LocalPlayer.Character:FindFirstChild(SelectWeaponLockMastery).Level.Value) >= SelectMastery then
							game.Players.LocalPlayer:Kick("\n Mastery Complete")
							_G.ConfigMain["Start Lock Mastery"] = false
							writefile("RoyXHub_BF/" .. SelectConfig,HttpService:JSONEncode(_G.ConfigMain))
							fask.wait(.1)
							while true do end
						end
					end
				end
			else
				break
			end
			fask.wait(2)
		end
	end)
end})

SelectBeli = _G.ConfigMain["Select Lock Beli"] or 10000000

AutoFarmPageLeft:AddSlider("Select Lock Beli",{value = SelectBeli ,min = 1 , max = 200000000 , callback = function(starts)
	SelectBeli = starts
	_G.ConfigMain["Select Lock Beli"] = starts
	SaveConfigAuto()
end})

ConfigLockBeli = AutoFarmPageLeft:AddToggle("Start Lock Beli",{Stats = false , callback = function(starts)
	LockBeli = starts
	_G.ConfigMain["Start Lock Beli"] = starts
	SaveConfigAuto()
	spawn(function()
		while fask.wait() do
			if LockBeli then
				if game.Players.LocalPlayer.Data.Beli.Value >= SelectBeli then
					game.Players.LocalPlayer:Kick("\n Beli Complete")
					_G.ConfigMain["Start Lock Beli"] = false
					writefile("RoyXHub_BF/" .. SelectConfig,HttpService:JSONEncode(_G.ConfigMain))
					fask.wait(.1)
					while true do end
				end
			else
				break
			end
			fask.wait(2)
		end
	end)
end})

SelectFragments = _G.ConfigMain["Select Lock Fragments"] or 30000

AutoFarmPageLeft:AddSlider("Select Lock Fragments",{value = SelectFragments ,min = 1 , max = 100000 , callback = function(starts)
	SelectFragments = starts
	_G.ConfigMain["Select Lock Fragments"] = starts
	SaveConfigAuto()
end})

ConfigLockFragments = AutoFarmPageLeft:AddToggle("Start Lock Fragments",{Stats = false , callback = function(starts)
	LockFragments = starts
	_G.ConfigMain["Start Lock Fragments"] = starts
	SaveConfigAuto()
	spawn(function()
		while fask.wait() do
			if LockFragments then
				if game.Players.LocalPlayer.Data.Fragments.Value >= SelectFragments then
					game.Players.LocalPlayer:Kick("\n Fragments Complete")
					_G.ConfigMain["Start Lock Fragments"] = false
					writefile("RoyXHub_BF/" .. SelectConfig,HttpService:JSONEncode(_G.ConfigMain))
					fask.wait(.1)
					while true do end
				end
			else
				break
			end
			fask.wait(2)
		end
	end)
end})

SelectRedeemx2 = _G.ConfigMain["Select Redeem Level"] or MaxLevel

AutoFarmPageLeft:AddSlider("Select Redeem Level",{value = SelectMastery ,min = 1 , max = MaxLevel , callback = function(starts)
	SelectRedeemx2 = starts
	_G.ConfigMain["Select Redeem Level"] = starts
	SaveConfigAuto()
end})

ConfigRedeemCodex2Level = AutoFarmPageLeft:AddToggle("Auto Redeem Code x2",{Stats = false , callback = function(starts)
	AutoRedeemCodex2 = starts
	_G.ConfigMain["Auto Redeem Code x2"] = starts
	SaveConfigAuto()
	spawn(function()
		while fask.wait(.1) do
			local MyLevel = tonumber(game.Players.LocalPlayer.Data.Level.Value)
			if AutoRedeemCodex2 then
				if not SelectRedeemx2 then return; end
				if MyLevel >= tonumber(SelectRedeemx2) then
					for i,v in pairs(CodeApi) do
						spawn(function()
							RedeemCode(v)
						end)
					end
					fask.wait(1)
					ChangeToggle(ConfigRedeemCodex2Level,false)
				end
			else
				break
			end
			fask.wait(2)
		end
	end)
end})

if OldWorld then
	-- Auto New World
	ConfigAutoNewWorld = AutoFarmPageLeft:AddToggle("Auto New World",{Stats = false , callback = function(starts)
		AutoNew = starts
		_G.ConfigMain["Auto New World"] = starts
		SaveConfigAuto()
		spawn(function()
			while fask.wait() do
				if AutoNew then
					xpcall(function()
						local MyLevel = game.Players.localPlayer.Data.Level.Value
						if MyLevel >= 700 and OldWorld and AutoNew then
							if Auto_Farm_Level then
								FarmLevel = false
							end
							if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("DressrosaQuestProgress", "Dressrosa") ~= 0 then
								if Workspace.Map.Ice.Door.Transparency == 1 then
									if (CFrame.new(1347.7124, 37.3751602, -1325.6488).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 250 then
										if game.Players.LocalPlayer.Backpack:FindFirstChild("Key") then
											local tool = game.Players.LocalPlayer.Backpack:FindFirstChild("Key")
											fask.wait(.4)
											game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(tool)
										end
										DoorNewWorldTween = toTarget(CFrame.new(1347.7124, 37.3751602, -1325.6488).Position,CFrame.new(1347.7124, 37.3751602, -1325.6488))
										if (CFrame.new(1347.7124, 37.3751602, -1325.6488).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
											if DoorNewWorldTween then DoorNewWorldTween:Stop() end
											game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1347.7124, 37.3751602, -1325.6488)
										end
									elseif game.Workspace.Enemies:FindFirstChild("Ice Admiral [Lv. 700] [Boss]") and game.Workspace.Map.Ice.Door.CanCollide == false and game.Workspace.Map.Ice.Door.Transparency == 1 and (CFrame.new(1347.7124, 37.3751602, -1325.6488).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
										if DoorNewWorldTween then DoorNewWorldTween:Stop() end
										CheckBoss = true
										for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
											if CheckBoss and v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and v.Name == "Ice Admiral [Lv. 700] [Boss]" then
												repeat fask.wait()
													if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
														Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
													elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
														if Farmtween then
															Farmtween:Stop()
														end
														EquipWeapon(SelectToolWeapon)
														Usefastattack = true
														toAroundTarget(v.HumanoidRootPart.CFrame)
													end
												until not CheckBoss or not v.Parent or v.Humanoid.Health <= 0 or AutoNew == false
												Usefastattack = false
												while fask.wait() do
													_F("TravelDressrosa")
												end
											end
										end
										CheckBoss = false
									else
										_F("TravelDressrosa")
										DoorNewWorldTween = toTarget(CFrame.new(1382.562255859375, 26.999441146850586, -1458.77783203125))
									end
								else
									if game.Players.LocalPlayer.Backpack:FindFirstChild("Key") or game.Players.LocalPlayer.Character:FindFirstChild("Key") then
										DoorNewWorldTween = toTarget(CFrame.new(1347.7124, 37.3751602, -1325.6488).Position,CFrame.new(1347.7124, 37.3751602, -1325.6488))
										if (CFrame.new(1347.7124, 37.3751602, -1325.6488).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
											if DoorNewWorldTween then DoorNewWorldTween:Stop() end
											game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1347.7124, 37.3751602, -1325.6488)
											_F("DressrosaQuestProgress","Detective")
											fask.wait(0.5)
											if game.Players.LocalPlayer.Backpack:FindFirstChild("Key") then
												local tool = game.Players.LocalPlayer.Backpack:FindFirstChild("Key")
												fask.wait(.4)
												game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(tool)
											end
										end
									else
										AutoNewWorldTween = toTarget(CFrame.new(4849.29883, 5.65138149, 719.611877).Position,CFrame.new(4849.29883, 5.65138149, 719.611877))
										if (CFrame.new(4849.29883, 5.65138149, 719.611877).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
											if DoorNewWorldTween then DoorNewWorldTween:Stop() end
											game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(4849.29883, 5.65138149, 719.611877)
											_F("DressrosaQuestProgress","Detective")
											fask.wait(0.5)
											if game.Players.LocalPlayer.Backpack:FindFirstChild("Key") then
												local tool = game.Players.LocalPlayer.Backpack:FindFirstChild("Key")
												fask.wait(.4)
												game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(tool)
											end
										end
									end
								end
							else
								_F("TravelDressrosa")
							end
						end
					end,print)
				else
					if tween then tween:Cancel() end
					break;
				end
			end
		end)
	end})
elseif NewWorld then
	ConfigAutoFactory = AutoFarmPageLeft:AddToggle("Auto Factory",{Stats = false , callback = function(starts)
		AutoFactory = starts
		_G.ConfigMain["Auto Factory"] = starts
		SaveConfigAuto()
		spawn(function()
			while fask.wait() do
				CheckQuest()
				if AutoFactory then
					if AutoFactory and game:GetService("ReplicatedStorage"):FindFirstChild("Core") and game:GetService("ReplicatedStorage"):FindFirstChild("Core"):FindFirstChild("Humanoid") then
						if Auto_Farm_Level then
							FarmLevel = false
						end
						GOtween = toTarget(CFrame.new(448.46756, 199.356781, -441.389252).Position,CFrame.new(448.46756, 199.356781, -441.389252))
						if (CFrame.new(448.46756, 199.356781, -441.389252).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
							if GOtween then GOtween:Stop()end
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(448.46756, 199.356781, -441.389252)
						end
					elseif AutoFactory and game.Workspace.Enemies:FindFirstChild("Core") then
						for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
							if AutoFactory and v.Name == "Core" and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
								repeat fask.wait(.1)
									if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
										Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
									elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
										if Farmtween then Farmtween:Stop() end
										EquipWeapon(SelectToolWeapon)
										Usefastattack = true
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 10, 10)
									end
								until not AutoFactory or v.Humanoid.Health <= 0 or not v.Parent
								Usefastattack = false
								if Auto_Farm_Level then
									FarmLevel = true
								end
							end
						end
					end
				else
					if tween then tween:Cancel() end
					break;
				end
			end
		end)
	end})
	local farmlvlnofruit = false
	ConfigAutoThirdWorld = AutoFarmPageLeft:AddToggle("Auto Third World",{Stats = false , callback = function(starts)
		Autothird = starts
		_G.ConfigMain["Auto Third World"] = starts
		SaveConfigAuto()
		spawn(function()
			while fask.wait() do
				if Autothird then
					local MyLevel = game.Players.localPlayer.Data.Level.Value
					if MyLevel >= 1500 and NewWorld and Autothird then
						if Auto_Farm_Level and farmlvlnofruit == false then FarmLevel = false elseif Auto_Farm_Level and farmlvlnofruit == true then FarmLevel = true end
						if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 3 then
							if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetUnlockables").FlamingoAccess ~= nil then
								_F("TravelZou")
								if game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("ZQuestProgress", "Check") == 0 then
									if game.Workspace.Enemies:FindFirstChild("rip_indra [Lv. 1500] [Boss]") then
										for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
											if v.Name == "rip_indra [Lv. 1500] [Boss]" and v:FindFirstChild("Humanoid")and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
												repeat fask.wait()
													if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
														Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
													elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
														if Farmtween then
															Farmtween:Stop()
														end
														EquipWeapon(SelectToolWeapon)
														Usefastattack = true
														toAroundTarget(v.HumanoidRootPart.CFrame)
													end
												until not Autothird or not v.Parent or v.Humanoid.Health <= 0 or game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("ZQuestProgress", "Check") == 1
												fask.wait(.5)
												asmrqq = 2
												repeat fask.wait() _F("TravelZou") until asmrqq == 1
												Usefastattack = false
											end
										end
									else -- SlashHit : rbxassetid://2453605589
										_F("ZQuestProgress","Check")
										_F("ZQuestProgress","Begin")
									end
								elseif game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("ZQuestProgress", "Check") == 1 then
									_F("TravelZou")
								else
									if game.Workspace.Enemies:FindFirstChild("Don Swan [Lv. 1000] [Boss]") then
										for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
											if v.Name == "Don Swan [Lv. 1000] [Boss]" and v:FindFirstChild("Humanoid")and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
												repeat fask.wait()
													if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
														Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
													elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
														if Farmtween then
															Farmtween:Stop()
														end
														EquipWeapon(SelectToolWeapon)
														Usefastattack = true
														toAroundTarget(v.HumanoidRootPart.CFrame)
													end
												until not Autothird or not v.Parent or v.Humanoid.Health <= 0
												Usefastattack = false
											end
										end
									else -- SlashHit : rbxassetid://2453605589
										TweenDonSwanthreeworld = toTarget(CFrame.new(2288.802, 15.1870775, 863.034607).Position,CFrame.new(2288.802, 15.1870775, 863.034607))
										if (CFrame.new(2288.802, 15.1870775, 863.034607).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
											if TweenDonSwanthreeworld then
												TweenDonSwanthreeworld:Stop()
												game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2288.802, 15.1870775, 863.034607)
											end
										end
									end
								end
							else
								if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetUnlockables").FlamingoAccess == nil then
									TabelDevilFruitStore = {}
									TabelDevilFruitOpen = {}

									for i,v in pairs(game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("getInventoryFruits")) do
										for i1,v1 in pairs(v) do
											if i1 == "Name" then
												table.insert(TabelDevilFruitStore,v1)
											end
										end
									end

									for i,v in pairs(game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("getInventoryFruits")) do
										if v.Price >= 1000000 then
											table.insert(TabelDevilFruitOpen,v.Name)
										end
									end

									for i,DevilFruitOpenDoor in pairs(TabelDevilFruitOpen) do
										for i1,DevilFruitStore in pairs(TabelDevilFruitStore) do
											if DevilFruitOpenDoor == DevilFruitStore and game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetUnlockables").FlamingoAccess == nil then
												farmlvlnofruit = false
												if not game.Players.LocalPlayer.Backpack:FindFirstChild(DevilFruitStore) then
													_F("LoadFruit",DevilFruitStore)
													TabelDevilFruitStore = {}
													for i,v in pairs(game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("getInventoryFruits")) do
														table.insert(TabelDevilFruitStore,v.Name)
													end
												else
													_F("TalkTrevor","1")
													_F("TalkTrevor","2")
													_F("TalkTrevor","3")
												end
											else
												farmlvlnofruit = true
											end
										end
									end

									_F("TalkTrevor","1")
									_F("TalkTrevor","2")
									_F("TalkTrevor","3")
								end
							end
						else
							if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 0 then
								if string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Swan Pirates") and string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "50") and game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == true then
									if game.Workspace.Enemies:FindFirstChild("Swan Pirate [Lv. 775]") then
										for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
											if v.Name == "Swan Pirate [Lv. 775]" then
												repeat fask.wait()
													if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
														Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
													elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
														if Farmtween then Farmtween:Stop() end
														EquipWeapon(SelectToolWeapon)
														Usefastattack = true
														spawn(function()
															for i2,V2 in pairs(game.Workspace.Enemies:GetChildren()) do
																if v2.Name == "Swan Pirate [Lv. 775]" then
																	v2.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
																end
															end
														end)
														v.HumanoidRootPart.Size = Vector3.new(55,55,55)
														toAroundTarget(v.HumanoidRootPart.CFrame)
													end
												until not v.Parent or v.Humanoid.Health <= 0 or Autothird == false or game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false
												AutoBartiloBring = false
												Usefastattack = false
											end
										end
									else
										Questtween = toTarget(CFrame.new(1057.92761, 137.614319, 1242.08069).Position,CFrame.new(1057.92761, 137.614319, 1242.08069))
										if (CFrame.new(1057.92761, 137.614319, 1242.08069).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
											if Bartilotween then Bartilotween:Stop() end
											game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1057.92761, 137.614319, 1242.08069)
										end
									end
								else
									Bartilotween = toTarget(CFrame.new(-456.28952, 73.0200958, 299.895966).Position,CFrame.new(-456.28952, 73.0200958, 299.895966))
									if ( CFrame.new(-456.28952, 73.0200958, 299.895966).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
										if Bartilotween then Bartilotween:Stop() end
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =  CFrame.new(-456.28952, 73.0200958, 299.895966)
										_F("StartQuest","BartiloQuest",1)
										
									end
								end
							elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 1 then
								if game.Workspace.Enemies:FindFirstChild("Jeremy [Lv. 850] [Boss]") then
									for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
										if v.Name == "Jeremy [Lv. 850] [Boss]" then
											repeat fask.wait()
												if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
													Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
												elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
													if Farmtween then Farmtween:Stop() end
													EquipWeapon(SelectToolWeapon)
													Usefastattack = true
													toAroundTarget(v.HumanoidRootPart.CFrame)
												end
											until not v.Parent or v.Humanoid.Health <= 0 or Autothird == false
											Usefastattack = false
										end
									end
								else
									Bartilotween = toTarget(CFrame.new(2099.88159, 448.931, 648.997375).Position,CFrame.new(2099.88159, 448.931, 648.997375))
									if (CFrame.new(2099.88159, 448.931, 648.997375).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
										if Bartilotween then Bartilotween:Stop() end
										game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2099.88159, 448.931, 648.997375)
									end
								end
							elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 2 then
								if (CFrame.new(-1836, 11, 1714).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
									Bartilotween = toTarget(CFrame.new(-1836, 11, 1714).Position,CFrame.new(-1836, 11, 1714))
								elseif (CFrame.new(-1836, 11, 1714).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
									if Bartilotween then Bartilotween:Stop() end
									game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1836, 11, 1714)
									fask.wait(.5)
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1850.49329, 13.1789551, 1750.89685)
									fask.wait(.1)
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1858.87305, 19.3777466, 1712.01807)
									fask.wait(.1)
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1803.94324, 16.5789185, 1750.89685)
									fask.wait(.1)
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1858.55835, 16.8604317, 1724.79541)
									fask.wait(.1)
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1869.54224, 15.987854, 1681.00659)
									fask.wait(.1)
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1800.0979, 16.4978027, 1684.52368)
									fask.wait(.1)
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1819.26343, 14.795166, 1717.90625)
									fask.wait(.1)
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1813.51843, 14.8604736, 1724.79541)
								end
							end
						end
					end
				else
					if tween then tween:Cancel() end
					break;
				end
			end
		end)
	end})
end

AutoFarmPageLeft:AddLabel("~ Auto Fighting Style ~")

ConfigAutoGodhuman = AutoFarmPageLeft:AddToggle("Auto Godhuman",{Stats = false , callback = function(starts)
	Godhuman = starts
	_G.ConfigMain["Auto Godhuman"] = starts
	SaveConfigAuto()
	spawn(function()
		while fask.wait() do
			if Godhuman then
				BuyGodhuman = tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyGodhuman",true))

				if BuyGodhuman then
					if BuyGodhuman == 1 then
						Godhuman = false
						ChangeToggle(ConfigAutoGodhuman,false)
					end
				end
			else
				break;
			end
			fask.wait(3)
		end
	end)
	spawn(function()
		while fask.wait() do
			if Godhuman then
				xpcall(function()
					if tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyGodhuman",true)) ~= 0 and tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyGodhuman",true)) ~= 1 then
						if tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySuperhuman",true)) ~= 1 then
							if game.Players.LocalPlayer:FindFirstChild("WeaponAssetCache") then
								if not game.Players.LocalPlayer.Backpack:FindFirstChild("Combat") and not game.Players.LocalPlayer.Character:FindFirstChild("Combat") then
									if not game.Players.LocalPlayer.Backpack:FindFirstChild("Black Leg") and not game.Players.LocalPlayer.Character:FindFirstChild("Black Leg") then
										if not game.Players.LocalPlayer.Backpack:FindFirstChild("Electro") and not game.Players.LocalPlayer.Character:FindFirstChild("Electro") then
											if not game.Players.LocalPlayer.Backpack:FindFirstChild("Fishman Karate") and not game.Players.LocalPlayer.Character:FindFirstChild("Fishman Karate") then
												if not game.Players.LocalPlayer.Backpack:FindFirstChild("Dragon Claw") and not game.Players.LocalPlayer.Character:FindFirstChild("Dragon Claw") then
													if not game.Players.LocalPlayer.Backpack:FindFirstChild("Superhuman") and not game.Players.LocalPlayer.Character:FindFirstChild("Superhuman") then
														local args = {
															[1] = "BuyElectro"
														}
														game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
													end
												end
											end
										end
									end
								end

								SelectToolWeapon = GetFightingStyle("Melee")

								if game.Players.LocalPlayer.Backpack:FindFirstChild("Combat") or game.Players.LocalPlayer.Character:FindFirstChild("Combat") then
									local args = {
										[1] = "BuyElectro"
									}
									game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
								end
								if game.Players.LocalPlayer.Backpack:FindFirstChild("Electro") and game.Players.LocalPlayer.Backpack:FindFirstChild("Electro").Level.Value >= 300 then
									local args = {
										[1] = "BuyBlackLeg"
									}
									game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
								end
								if game.Players.LocalPlayer.Character:FindFirstChild("Electro") and game.Players.LocalPlayer.Character:FindFirstChild("Electro").Level.Value >= 300 then
									local args = {
										[1] = "BuyBlackLeg"
									}
									game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
								end
								if game.Players.LocalPlayer.Backpack:FindFirstChild("Black Leg") and game.Players.LocalPlayer.Backpack:FindFirstChild("Black Leg").Level.Value >= 300 then
									local args = {
										[1] = "BuyFishmanKarate"
									}
									game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
								end
								if game.Players.LocalPlayer.Character:FindFirstChild("Black Leg") and game.Players.LocalPlayer.Character:FindFirstChild("Black Leg").Level.Value >= 300 then
									local args = {
										[1] = "BuyFishmanKarate"
									}
									game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
								end
								if game.Players.LocalPlayer.Backpack:FindFirstChild("Fishman Karate") and game.Players.LocalPlayer.Backpack:FindFirstChild("Fishman Karate").Level.Value >= 300  then
									local args = {
										[1] = "BlackbeardReward",
										[2] = "DragonClaw",
										[3] = "2"
									}
									HaveDragonClaw = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
									if Godhuman and game.Players.LocalPlayer.Data.Fragments.Value <= 1500 and HaveDragonClaw == 0 then
										if game.Players.LocalPlayer.Data.Level.Value > 1100 then
											if Auto_Farm_Level then FarmLevel = false end
										end
									else
										if Auto_Farm_Level then FarmLevel = true end
										local args = {
											[1] = "BlackbeardReward",
											[2] = "DragonClaw",
											[3] = "2"
										}
										game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
										if Auto_Farm_Level then FarmLevel = true end
									end
								end
								if game.Players.LocalPlayer.Character:FindFirstChild("Fishman Karate") and game.Players.LocalPlayer.Character:FindFirstChild("Fishman Karate").Level.Value >= 300  then
									local args = {
										[1] = "BlackbeardReward",
										[2] = "DragonClaw",
										[3] = "2"
									}
									HaveDragonClaw = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
									if Godhuman and game.Players.LocalPlayer.Data.Fragments.Value <= 1500 and HaveDragonClaw == 0 then
										if game.Players.LocalPlayer.Data.Level.Value > 1100 then
											if Auto_Farm_Level then FarmLevel = false end
										end
									else
										if Auto_Farm_Level then FarmLevel = true end
										local args = {
											[1] = "BlackbeardReward",
											[2] = "DragonClaw",
											[3] = "2"
										}
										game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
										if Auto_Farm_Level then FarmLevel = true end
									end
								end

								if game.Players.LocalPlayer.Backpack:FindFirstChild("Dragon Claw") and game.Players.LocalPlayer.Backpack:FindFirstChild("Dragon Claw").Level.Value >= 300 then
									FarmLevel = Auto_Farm_Level
									local args = {
										[1] = "BuySuperhuman"
									}
									game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
								end
								if game.Players.LocalPlayer.Character:FindFirstChild("Dragon Claw") and game.Players.LocalPlayer.Character:FindFirstChild("Dragon Claw").Level.Value >= 300 then
									FarmLevel = Auto_Farm_Level
									local args = {
										[1] = "BuySuperhuman"
									}
									game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
								end
							end
						elseif tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate",true)) ~= 1 then
							if game.Players.LocalPlayer:FindFirstChild("WeaponAssetCache") then
								if not game.Players.LocalPlayer.Backpack:FindFirstChild("Fishman Karate") and not game.Players.LocalPlayer.Character:FindFirstChild("Fishman Karate") then
									if not game.Players.LocalPlayer.Backpack:FindFirstChild("Sharkman Karate") and not game.Players.LocalPlayer.Character:FindFirstChild("Sharkman Karate") then
										local args = {
											[1] = "BuyFishmanKarate"
										}
										game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
									end
								end
								if inmyself("Fishman Karate") and inmyself("Fishman Karate").Level.Value >= 400 then
									if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate",true) == "I lost my house keys, could you help me find them? Thanks." and not inmyself("Water Key") then
										if NewWorld then
											KillSharkMan = true
											if Auto_Farm_Level then FarmLevel = false end
										elseif ThreeWorld then
											_F("TravelDressrosa")
										else
											if Auto_Farm_Level then FarmLevel = true end
											KillSharkMan = false
										end
									elseif tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate",true)) == 1 or tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate",true)) == 0 then
										if not ThreeWorld then
											_F("TravelDressrosa")
										end
										KillSharkMan = false
										if Auto_Farm_Level then FarmLevel = true end
										local args = {
											[1] = "BuySharkmanKarate"
										}
										game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
									elseif inmyself("Water Key") then
										if not ThreeWorld then
											_F("TravelDressrosa")
										end
										KillSharkMan = false
										if Auto_Farm_Level then FarmLevel = true end
										local args = {
											[1] = "BuySharkmanKarate"
										}
										game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
									end
								end
								SelectToolWeapon = GetFightingStyle("Melee")
							end
						elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer( "BuyDeathStep",true) ~= 1 then
							if game.Players.LocalPlayer:FindFirstChild("WeaponAssetCache") then
								if not game.Players.LocalPlayer.Backpack:FindFirstChild("Black Leg") and not game.Players.LocalPlayer.Character:FindFirstChild("Black Leg") then
									if not game.Players.LocalPlayer.Backpack:FindFirstChild("Death Step") and not game.Players.LocalPlayer.Character:FindFirstChild("Death Step") then
										local args = {
											[1] = "BuyBlackLeg"
										}
										game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
									end
								end

								if inmyself("Black Leg") and inmyself("Black Leg").Level.Value >= 400 then
									if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDeathStep",true) == 3 and not inmyself("Library Key") then
										if NewWorld then
											KillDeath = true
											if Auto_Farm_Level then FarmLevel = false end
										elseif ThreeWorld then
											_F("TravelDressrosa")
										else
											if Auto_Farm_Level then FarmLevel = true end
											KillDeath = false
										end
									elseif tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDeathStep",true)) == 1 or tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDeathStep",true)) == 0 then
										local args = {
											[1] = "BuyDeathStep"
										}
										game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
										KillDeath = false
										if Auto_Farm_Level then FarmLevel = true end
										if not ThreeWorld then
											_F("TravelDressrosa")
										end
									elseif inmyself("Library Key") then
										KillDeath = false
										local args = {
											[1] = "OpenLibrary"
										}

										game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
										if Auto_Farm_Level then FarmLevel = true end
									end
								end
								SelectToolWeapon = GetFightingStyle("Melee")
							end
						elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDragonTalon",true) ~= 1 then
							if game.Players.LocalPlayer:FindFirstChild("WeaponAssetCache") then
								if not game.Players.LocalPlayer.Backpack:FindFirstChild("Dragon Claw") and not game.Players.LocalPlayer.Character:FindFirstChild("Dragon Claw") then
									if not game.Players.LocalPlayer.Backpack:FindFirstChild("Dragon Talon") and not game.Players.LocalPlayer.Character:FindFirstChild("Dragon Talon") then
										local args = {
											[1] = "BlackbeardReward",
											[2] = "DragonClaw",
											[3] = "2"
										}
										game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
									end
								end
								SelectToolWeapon = GetFightingStyle("Melee")

								if inmyself("Dragon Claw") and inmyself("Dragon Claw").Level.Value >= 400 and game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health > 0 then
									if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDragonTalon", true) == 3 then
										ChangeToggle(ConfigAutoFarmBone,false)
										if Auto_Farm_Level then FarmLevel = true end
										local string_1 = "BuyDragonTalon";
										local bool_1 = true;
										local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
										Target:InvokeServer(string_1, bool_1);
									elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDragonTalon", true) == 1 then
										game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDragonTalon")
										ChangeToggle(ConfigAutoFarmBone,false)
										if Auto_Farm_Level then FarmLevel = true end
									else
										if Auto_Farm_Level then FarmLevel = false end
										ChangeToggle(ConfigAutoFarmBone,true)
										local string_1 = "Bones";
										local string_2 = "Buy";
										local number_1 = 1;
										local number_2 = 1;
										local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
										Target:InvokeServer(string_1, string_2, number_1, number_2);
									end
								end
							end
						elseif tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw",true)) ~= 1 then
							if game.Players.LocalPlayer:FindFirstChild("WeaponAssetCache") then
								if not game.Players.LocalPlayer.Backpack:FindFirstChild("Electro") and not game.Players.LocalPlayer.Character:FindFirstChild("Electro") then
									if not game.Players.LocalPlayer.Backpack:FindFirstChild("Electric Claw") and not game.Players.LocalPlayer.Character:FindFirstChild("Electric Claw") then
										local args = {
											[1] = "BuyElectro"
										}
										game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
									end
								end
								SelectToolWeapon = GetFightingStyle("Melee")
								if game.Players.LocalPlayer.Backpack:FindFirstChild("Electro") and game.Players.LocalPlayer.Backpack:FindFirstChild("Electro").Level.Value >= 400 then
									local v175 = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw", true);
									if v175 == 4 then
										local v176 = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw", "Start");
										if v176 == nil then
											game.Players.localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-12548, 337, -7481)
										end
									else
										local string_1 = "BuyElectricClaw";
										local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
										Target:InvokeServer(string_1);
									end
								end
								if game.Players.LocalPlayer.Character:FindFirstChild("Electro") and game.Players.LocalPlayer.Character:FindFirstChild("Electro").Level.Value >= 400 then
									local v175 = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw", true);
									if v175 == 4 then
										local v176 = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw", "Start");
										if v176 == nil then
											game.Players.localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-12548, 337, -7481)
										end
									else
										local string_1 = "BuyElectricClaw";
										local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
										Target:InvokeServer(string_1);
									end
								end
							end
						elseif tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySuperhuman",true)) == 1 and tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDragonTalon",true)) == 1 and tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate",true)) == 1 and tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer( "BuyDeathStep",true)) == 1 and tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw",true)) == 1 then
							if not SupComplete then
								local args = {
									[1] = "BuySuperhuman"
								}
								game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
								fask.wait(0.2)
								if CheckMasteryWeapon("Superhuman",400) == "UpTo" or CheckMasteryWeapon("Superhuman",400) == "true" and SupComplete == false then
									SupComplete = true
								end
							elseif not TalComplete then
								local args = {
									[1] = "BuyDragonTalon"
								}
								game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
								fask.wait(0.2)
								if CheckMasteryWeapon("Dragon Talon",400) == "UpTo" or CheckMasteryWeapon("Superhuman",400) == "true" and TalComplete == false then
									TalComplete = true
								end
							elseif not SharkComplete then
								local args = {
									[1] = "BuySharkmanKarate"
								}
								game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
								fask.wait(0.2)
								if CheckMasteryWeapon("Sharkman Karate",400) == "UpTo" or CheckMasteryWeapon("Superhuman",400) == "true" and SharkComplete == false then
									SharkComplete = true
								end
							elseif not DeathComplete then
								local args = {
									[1] = "BuyDeathStep"
								}
								game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
								fask.wait(0.2)
								if CheckMasteryWeapon("Death Step",400) == "UpTo" or CheckMasteryWeapon("Superhuman",400) == "true" and DeathComplete == false then
									DeathComplete = true
								end
							elseif not EClawComplete then
								local args = {
									[1] = "BuyElectricClaw"
								}
								game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
								fask.wait(0.2)
								if CheckMasteryWeapon("Electric Claw",400) == "UpTo" or CheckMasteryWeapon("Superhuman",400) == "true" and EClawComplete == false then
									EClawComplete = true
								end
							end
						end
						if SupComplete and EClawComplete and TalComplete and SharkComplete and DeathComplete and (not game.Players.LocalPlayer.Character:FindFirstChild("Godhuman") or not game.Players.LocalPlayer.Backpack:FindFirstChild("Godhuman")) then

							if GetMaterial("Fish Tail") >= 20 then
								if GetMaterial("Magma Ore") >= 20 then
									if GetMaterial("Dragon Scale") >= 10 then
										if GetMaterial("Mystic Droplet") >= 10 then
											if Auto_Farm_Level then FarmLevel = true end
											BuyGodhuman = tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyGodhuman",true))

											if BuyGodhuman then
												if BuyGodhuman == 1 then
													Godhuman = false
													ChangeToggle(ConfigAutoGodhuman,false)
												end
											end
											_F("BuyGodhuman")
										elseif not NewWorld then
											_F("TravelDressrosa")
										elseif NewWorld then
											if Auto_Farm_Level then FarmLevel = false end
											CheckMaterial("Mystic Droplet")
											if CustomFindFirstChild(MaterialMob) then
												for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
													if Godhuman and table.find(MaterialMob,v.Name) and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
														repeat fask.wait()
															FarmtoTarget = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame * CFrame.new(0,30,1))
															if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
																if FarmtoTarget then FarmtoTarget:Stop() end
																Usefastattack = true
																EquipWeapon(SelectToolWeapon)
																spawn(function()
																	for i,v2 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
																		if v2.Name == v.Name then
																			spawn(function()
																				if InMyNetWork(v2.HumanoidRootPart) then
																					v2.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
																					v2.Humanoid.JumpPower = 0
																					v2.Humanoid.WalkSpeed = 0
																					v2.HumanoidRootPart.CanCollide = false
																					v2.Humanoid:ChangeState(14)
																					v2.Humanoid:ChangeState(11)
																					v2.HumanoidRootPart.Size = Vector3.new(55,55,55)
																				end
																			end)
																		end
																	end
																end)
																if game.Players.LocalPlayer.Character:FindFirstChild("Black Leg") and game.Players.LocalPlayer.Character:FindFirstChild("Black Leg").Level.Value >= 150 then
																	game:service('VirtualInputManager'):SendKeyEvent(true, "V", false, game)
																	game:service('VirtualInputManager'):SendKeyEvent(false, "V", false, game)
																end
																game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 1)
															end
														until not CustomFindFirstChild(MaterialMob) or not Godhuman or v.Humanoid.Health <= 0 or not v.Parent
														Usefastattack = false
													end
												end
											else
												Usefastattack = false
												Modstween = toTarget(CFrameMon.Position,CFrameMon)
												if (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
													if Modstween then Modstween:Stop() end
													game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
												end
											end
										end
									elseif not ThreeWorld then
										_F("TravelZou")
									elseif ThreeWorld then
										if Auto_Farm_Level then FarmLevel = false end
										CheckMaterial("Dragon Scale")
										if CustomFindFirstChild(MaterialMob) then
											for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
												if Godhuman and table.find(MaterialMob,v.Name) and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
													repeat fask.wait()
														FarmtoTarget = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame * CFrame.new(0,30,1))
														if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
															if FarmtoTarget then FarmtoTarget:Stop() end
															Usefastattack = true
															EquipWeapon(SelectToolWeapon)
															spawn(function()
																for i,v2 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
																	if v2.Name == v.Name then
																		spawn(function()
																			if InMyNetWork(v2.HumanoidRootPart) then
																				v2.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
																				v2.Humanoid.JumpPower = 0
																				v2.Humanoid.WalkSpeed = 0
																				v2.HumanoidRootPart.CanCollide = false
																				v2.Humanoid:ChangeState(14)
																				v2.Humanoid:ChangeState(11)
																				v2.HumanoidRootPart.Size = Vector3.new(55,55,55)
																			end
																		end)
																	end
																end
															end)
															if game.Players.LocalPlayer.Character:FindFirstChild("Black Leg") and game.Players.LocalPlayer.Character:FindFirstChild("Black Leg").Level.Value >= 150 then
																game:service('VirtualInputManager'):SendKeyEvent(true, "V", false, game)
																game:service('VirtualInputManager'):SendKeyEvent(false, "V", false, game)
															end
															game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 1)
														end
													until not CustomFindFirstChild(MaterialMob) or not Godhuman or v.Humanoid.Health <= 0 or not v.Parent
													Usefastattack = false
												end
											end
										else
											Usefastattack = false
											Modstween = toTarget(CFrameMon.Position,CFrameMon)
											if (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
												if Modstween then Modstween:Stop() end
												game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
											end
										end
									end
								elseif not OldWorld then
									_F("TravelMain")
								elseif OldWorld then
									if Auto_Farm_Level then FarmLevel = false end
									CheckMaterial("Magma Ore")
									if CustomFindFirstChild(MaterialMob) then
										for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
											if Godhuman and table.find(MaterialMob,v.Name) and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
												repeat fask.wait()
													FarmtoTarget = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame * CFrame.new(0,30,1))
													if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
														if FarmtoTarget then FarmtoTarget:Stop() end
														Usefastattack = true
														EquipWeapon(SelectToolWeapon)
														spawn(function()
															for i,v2 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
																if v2.Name == v.Name then
																	spawn(function()
																		if InMyNetWork(v2.HumanoidRootPart) then
																			v2.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
																			v2.Humanoid.JumpPower = 0
																			v2.Humanoid.WalkSpeed = 0
																			v2.HumanoidRootPart.CanCollide = false
																			v2.Humanoid:ChangeState(14)
																			v2.Humanoid:ChangeState(11)
																			v2.HumanoidRootPart.Size = Vector3.new(55,55,55)
																		end
																	end)
																end
															end
														end)
														if game.Players.LocalPlayer.Character:FindFirstChild("Black Leg") and game.Players.LocalPlayer.Character:FindFirstChild("Black Leg").Level.Value >= 150 then
															game:service('VirtualInputManager'):SendKeyEvent(true, "V", false, game)
															game:service('VirtualInputManager'):SendKeyEvent(false, "V", false, game)
														end
														game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 1)
													end
												until not CustomFindFirstChild(MaterialMob) or not Godhuman or v.Humanoid.Health <= 0 or not v.Parent
												Usefastattack = false
											end
										end
									else
										Usefastattack = false
										Modstween = toTarget(CFrameMon.Position,CFrameMon)
										if (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
											if Modstween then Modstween:Stop() end
											game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
										end
									end
								end
							elseif not OldWorld then
								_F("TravelMain")
							elseif OldWorld then
								if Auto_Farm_Level then FarmLevel = false end
								CheckMaterial("Fish Tail")
								if CustomFindFirstChild(MaterialMob) then
									for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
										if Godhuman and table.find(MaterialMob,v.Name) and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
											repeat fask.wait()
												FarmtoTarget = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame * CFrame.new(0,30,1))
												if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
													if FarmtoTarget then FarmtoTarget:Stop() end
													Usefastattack = true
													EquipWeapon(SelectToolWeapon)
													spawn(function()
														for i,v2 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
															if v2.Name == v.Name then
																spawn(function()
																	if InMyNetWork(v2.HumanoidRootPart) then
																		v2.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
																		v2.Humanoid.JumpPower = 0
																		v2.Humanoid.WalkSpeed = 0
																		v2.HumanoidRootPart.CanCollide = false
																		v2.Humanoid:ChangeState(14)
																		v2.Humanoid:ChangeState(11)
																		v2.HumanoidRootPart.Size = Vector3.new(55,55,55)
																	end
																end)
															end
														end
													end)
													if game.Players.LocalPlayer.Character:FindFirstChild("Black Leg") and game.Players.LocalPlayer.Character:FindFirstChild("Black Leg").Level.Value >= 150 then
														game:service('VirtualInputManager'):SendKeyEvent(true, "V", false, game)
														game:service('VirtualInputManager'):SendKeyEvent(false, "V", false, game)
													end
													game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 1)
												end
											until not CustomFindFirstChild(MaterialMob) or not Godhuman or v.Humanoid.Health <= 0 or not v.Parent
											Usefastattack = false
										end
									end
								else
									Usefastattack = false
									Modstween = toTarget(CFrameMon.Position,CFrameMon)
									if (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
										if Modstween then Modstween:Stop() end
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
									end
								end
							end
						end
					else
						_F("BuyGodhuman")
					end
				end,print)
			else
				break
			end
		end
	end)
	fask.wait(5)
	spawn(function()
		while fask.wait() do
			if Godhuman then
				if (game.Players.LocalPlayer.Backpack:FindFirstChild("Special Microchip") or game.Players.LocalPlayer.Character:FindFirstChild("Special Microchip") or CheckIsland()) and game.Players.LocalPlayer.Data.Level.Value > 1100 and not OldWorld and (not (SupComplete and EClawComplete and TalComplete and SharkComplete and DeathComplete) or (GetMaterial("Fish Tail") >= 20 and GetMaterial("Magma Ore") >= 20 and GetMaterial("Dragon Scale") >= 10 and GetMaterial("Mystic Droplet") >= 10) ) then
					if tween then tween:Cancel() end
					if game.Players.LocalPlayer.Backpack:FindFirstChild("Special Microchip") or game.Players.LocalPlayer.Character:FindFirstChild("Special Microchip") and game.Players.LocalPlayer.PlayerGui.Main.Timer.Visible == false and not (SupComplete and EClawComplete and TalComplete and SharkComplete and DeathComplete) and not KillSharkMan and not KillDeath then
						if Auto_Farm_Level then FarmLevel = false end
						if NewWorld then
							fireclickdetector(Workspace.Map.CircleIsland.RaidSummon2.Button.Main.ClickDetector)
						elseif ThreeWorld then
							fireclickdetector(Workspace.Map["Boat Castle"].RaidSummon2.Button.Main.ClickDetector)
						end
						fask.wait(16)
					elseif game.Players.LocalPlayer.PlayerGui.Main.Timer.Visible == true then
						if Auto_Farm_Level then FarmLevel = false end
						repeat fask.wait()
							if game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5") or game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4") or game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3") or game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2") or game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1") then
								NextIsland()
								if GoIsland == 0 then fask.wait(0.1)
								elseif (ToIslandCFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
									Farmtween = toTarget(ToIslandCFrame)
								elseif (ToIslandCFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
									if Farmtween then Farmtween:Stop() end
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = ToIslandCFrame
								end
							end
							for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
								if Godhuman and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and (v.HumanoidRootPart.Position-game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= DistanceKillAura then
									pcall(function()
										repeat fask.wait()
											v.Humanoid.Health = 0
										until not Godhuman or v.Humanoid.Health <= 0 or not v.Parent
									end)
								end
							end
							_F("Awakener","Awaken")
						until Godhuman == false or not game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5") or not game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4") or not game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3") or not game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2") or not game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1") or game.Players.LocalPlayer.PlayerGui.Main.Timer.Visible == false
						_F("Awakener","Awaken")
					else
						if Auto_Farm_Level then FarmLevel = true end
					end
				elseif game.Players.LocalPlayer.Data.Level.Value > 1100 and not OldWorld and not (SupComplete and EClawComplete and TalComplete and SharkComplete and DeathComplete) and not KillSharkMan and not KillDeath and game.Players.LocalPlayer.Data.Fragments.Value < 5000 then
					if Auto_Farm_Level then FarmLevel = true end
					spawn(function()
						if NoLoopDuplicate3 == false then
							NoLoopDuplicate3 = true
							for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
								if v:IsA("Tool") and string.find(v.Name,"Fruit") and (v.Handle.Position-game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).Magnitude <= 7000 then
									local oldCFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Handle.CFrame * CFrame.new(3,5,1)
									fask.wait(0.02)
									firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart,v.Handle,0)
									fask.wait()
									firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart,v.Handle,1)
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame  = oldCFrame
									fask.wait(15)
								end
							end
							NoLoopDuplicate3 = false
						end
					end)
					local MaxPrice = math.huge
					for i,v in pairs(game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("getInventoryFruits")) do
						if v.Price <= 1000000 then
							if v.Price < MaxPrice then
								MaxPrice = v.Price
								LoadthisFruit = v.Name
							end
						end
					end
					if LoadthisFruit ~= nil then
						local args = {
							[1] = "LoadFruit",
							[2] = LoadthisFruit
						}

						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
					end

					local args = {
						[1] = "RaidsNpc",
						[2] = "Select",
						[3] = "Flame"
					}
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))

					LoadthisFruit = nil
				end
			else
				break
			end
		end
	end)
	spawn(function()
		while fask.wait() do
			if Godhuman and NewWorld then
				if (KillSharkMan == true and game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate",true) == "I lost my house keys, could you help me find them? Thanks.") then
					if game.Workspace.Enemies:FindFirstChild("Tide Keeper [Lv. 1475] [Boss]") then
						if KillFish then KillFish:Stop() end
						
						for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
							if v.Name == "Tide Keeper [Lv. 1475] [Boss]" then
								repeat fask.wait()
									if game.Workspace.Enemies:FindFirstChild(v.Name) then
										if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 200 then
											Farmtween = toTarget(v.HumanoidRootPart.CFrame)
										elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 200 then
											if Farmtween then
												Farmtween:Stop()
											end
											Click()
											Usefastattack = true
											EquipWeapon(SelectToolWeapon)
											v.HumanoidRootPart.CanCollide = false
											v.HumanoidRootPart.Size = Vector3.new(50, 50, 50)
											game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(1,50,0)
										end
									else
										Usefastattack = false
									end
								until not v.Parent or Godhuman == false or KillSharkMan == false or v.Humanoid.Health == 0 or inmyself("Water Key")
								fask.wait(1)
							end
						end
					else
						if game:GetService("ReplicatedStorage"):FindFirstChild("Tide Keeper [Lv. 1475] [Boss]") then
							KillFish = toTarget(game:GetService("ReplicatedStorage"):FindFirstChild("Tide Keeper [Lv. 1475] [Boss]").HumanoidRootPart.CFrame * CFrame.new(1,50,1))
						elseif not game.Workspace.Enemies:FindFirstChild("Tide Keeper [Lv. 1475] [Boss]") then
							if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate",true) == "I lost my house keys, could you help me find them? Thanks." then
								Notify({
									Title = "Now Hopping",
									Text = "Not Find Sharkman",
									Timer = 3
								},"Success")
								ServerFunc:TeleportFast()
							end
						end
					end
				end
			else
				break
			end
		end
	end)
	spawn(function()
		while fask.wait() do
			if Godhuman and NewWorld then
				if (KillDeath == true and game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDeathStep",true) == 3) then
					if game.Workspace.Enemies:FindFirstChild("Awakened Ice Admiral [Lv. 1400] [Boss]") then

						if KillFish then KillFish:Stop() end
						
						for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
							if v.Name == "Awakened Ice Admiral [Lv. 1400] [Boss]" then
								repeat fask.wait()
									if game.Workspace.Enemies:FindFirstChild(v.Name) then
										if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 200 then
											Farmtween = toTarget(v.HumanoidRootPart.CFrame)
										elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 200 then
											if Farmtween then
												Farmtween:Stop()
											end
											Click()
											Usefastattack = true
											EquipWeapon(SelectToolWeapon)
											v.HumanoidRootPart.CanCollide = false
											v.HumanoidRootPart.Size = Vector3.new(50, 50, 50)
											game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(1,50,0)
										end
									else
										Usefastattack = false
									end
								until not v.Parent or Godhuman == false or KillDeath == false or v.Humanoid.Health == 0 or inmyself("Library Key")
								Usefastattack = false
								fask.wait(1)
							end
						end
					else
						if game:GetService("ReplicatedStorage"):FindFirstChild("Awakened Ice Admiral [Lv. 1400] [Boss]") then
							KillFish = toTarget(game:GetService("ReplicatedStorage"):FindFirstChild("Awakened Ice Admiral [Lv. 1400] [Boss]").HumanoidRootPart.CFrame * CFrame.new(1,50,1))
						elseif not game.Workspace.Enemies:FindFirstChild("Awakened Ice Admiral [Lv. 1400] [Boss]") then
							if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDeathStep",true) == 3 then
								Notify({
									Title = "Now Hopping",
									Text = "Not Find Boss Ice",
									Timer = 3
								},"Success")
								ServerFunc:TeleportFast()
							end
						end
					end
				end
			else
				break
			end
		end
	end)
end})

getgenv().RaidsSelected = "Flame"

ConfigAutoSuperhuman = AutoFarmPageLeft:AddToggle("Auto Superhuman",{Stats = false , callback = function(starts)
	Superhuman = starts
	_G.ConfigMain["Auto Superhuman"] = starts
	SaveConfigAuto()

	spawn(function()
		while fask.wait(.5) do
			if Superhuman then
				if game.Players.LocalPlayer:FindFirstChild("WeaponAssetCache") then
					if not game.Players.LocalPlayer.Backpack:FindFirstChild("Combat") and not game.Players.LocalPlayer.Character:FindFirstChild("Combat") then
						if not game.Players.LocalPlayer.Backpack:FindFirstChild("Black Leg") and not game.Players.LocalPlayer.Character:FindFirstChild("Black Leg") then
							if not game.Players.LocalPlayer.Backpack:FindFirstChild("Electro") and not game.Players.LocalPlayer.Character:FindFirstChild("Electro") then
								if not game.Players.LocalPlayer.Backpack:FindFirstChild("Fishman Karate") and not game.Players.LocalPlayer.Character:FindFirstChild("Fishman Karate") then
									if not game.Players.LocalPlayer.Backpack:FindFirstChild("Dragon Claw") and not game.Players.LocalPlayer.Character:FindFirstChild("Dragon Claw") then
										if not game.Players.LocalPlayer.Backpack:FindFirstChild("Superhuman") and not game.Players.LocalPlayer.Character:FindFirstChild("Superhuman") then
											local args = {
												[1] = "BuyElectro"
											}
											game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
										end
									end
								end
							end
						end
					end

					SelectToolWeapon = GetFightingStyle("Melee")

					if game.Players.LocalPlayer.Backpack:FindFirstChild("Combat") or game.Players.LocalPlayer.Character:FindFirstChild("Combat") then
						local args = {
							[1] = "BuyElectro"
						}
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
					end
					if game.Players.LocalPlayer.Backpack:FindFirstChild("Electro") and game.Players.LocalPlayer.Backpack:FindFirstChild("Electro").Level.Value >= 300 then
						local args = {
							[1] = "BuyBlackLeg"
						}
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
					end
					if game.Players.LocalPlayer.Character:FindFirstChild("Electro") and game.Players.LocalPlayer.Character:FindFirstChild("Electro").Level.Value >= 300 then
						local args = {
							[1] = "BuyBlackLeg"
						}
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
					end
					if game.Players.LocalPlayer.Backpack:FindFirstChild("Black Leg") and game.Players.LocalPlayer.Backpack:FindFirstChild("Black Leg").Level.Value >= 300 then
						local args = {
							[1] = "BuyFishmanKarate"
						}
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
					end
					if game.Players.LocalPlayer.Character:FindFirstChild("Black Leg") and game.Players.LocalPlayer.Character:FindFirstChild("Black Leg").Level.Value >= 300 then
						local args = {
							[1] = "BuyFishmanKarate"
						}
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
					end
					if game.Players.LocalPlayer.Backpack:FindFirstChild("Fishman Karate") and game.Players.LocalPlayer.Backpack:FindFirstChild("Fishman Karate").Level.Value >= 300  then
						local args = {
							[1] = "BlackbeardReward",
							[2] = "DragonClaw",
							[3] = "2"
						}
						HaveDragonClaw = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
						if Superhuman and game.Players.LocalPlayer.Data.Fragments.Value <= 1500 and HaveDragonClaw == 0 then
							if game.Players.LocalPlayer.Data.Level.Value > 1100 then
								RaidsSelected = "Flame"
								AutoRaids = true
								if Auto_Farm_Level then FarmLevel = false end
							end
						else
							AutoRaids = false
							if Auto_Farm_Level then FarmLevel = true end
							local args = {
								[1] = "BlackbeardReward",
								[2] = "DragonClaw",
								[3] = "2"
							}
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
							AutoRaids = false
							if Auto_Farm_Level then FarmLevel = true end
						end
					end
					if game.Players.LocalPlayer.Character:FindFirstChild("Fishman Karate") and game.Players.LocalPlayer.Character:FindFirstChild("Fishman Karate").Level.Value >= 300  then
						local args = {
							[1] = "BlackbeardReward",
							[2] = "DragonClaw",
							[3] = "2"
						}
						HaveDragonClaw = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
						if Superhuman and game.Players.LocalPlayer.Data.Fragments.Value <= 1500 and HaveDragonClaw == 0 then
							if game.Players.LocalPlayer.Data.Level.Value > 1100 then
								RaidsSelected = "Flame"
								AutoRaids = true
								if Auto_Farm_Level then FarmLevel = false end
							end
						else
							AutoRaids = false
							if Auto_Farm_Level then FarmLevel = true end
							local args = {
								[1] = "BlackbeardReward",
								[2] = "DragonClaw",
								[3] = "2"
							}
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
							AutoRaids = false
							if Auto_Farm_Level then FarmLevel = true end
						end
					end

					if game.Players.LocalPlayer.Backpack:FindFirstChild("Dragon Claw") and game.Players.LocalPlayer.Backpack:FindFirstChild("Dragon Claw").Level.Value >= 300 then
						FarmLevel = Auto_Farm_Level
						local args = {
							[1] = "BuySuperhuman"
						}
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
					end
					if game.Players.LocalPlayer.Character:FindFirstChild("Dragon Claw") and game.Players.LocalPlayer.Character:FindFirstChild("Dragon Claw").Level.Value >= 300 then
						FarmLevel = Auto_Farm_Level
						local args = {
							[1] = "BuySuperhuman"
						}
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
					end
				end

			else
				break
			end
		end
	end)
	spawn(function()
		while fask.wait() do
			if Superhuman then
				if AutoRaids then
					if game.Players.LocalPlayer.Backpack:FindFirstChild("Special Microchip") or game.Players.LocalPlayer.Character:FindFirstChild("Special Microchip") or CheckIsland() then
						if game.Players.LocalPlayer.Backpack:FindFirstChild("Special Microchip") or game.Players.LocalPlayer.Character:FindFirstChild("Special Microchip") and game.Players.LocalPlayer.PlayerGui.Main.Timer.Visible == false then
							if NewWorld then
								fireclickdetector(Workspace.Map.CircleIsland.RaidSummon2.Button.Main.ClickDetector)
							elseif ThreeWorld then
								fireclickdetector(Workspace.Map["Boat Castle"].RaidSummon2.Button.Main.ClickDetector)
							end
							fask.wait(16)
						elseif game.Players.LocalPlayer.PlayerGui.Main.Timer.Visible == true then
							repeat fask.wait()
								if game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5") or game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4") or game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3") or game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2") or game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1") then
									NextIsland()
									if GoIsland == 0 then fask.wait(0.1)
									elseif (ToIslandCFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
										Farmtween = toTarget(ToIslandCFrame)
									elseif (ToIslandCFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
										if Farmtween then Farmtween:Stop() end
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = ToIslandCFrame
									end
								end
								for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
									if AutoRaids and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and (v.HumanoidRootPart.Position-game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= DistanceKillAura then
										pcall(function()
											repeat fask.wait()
												v.Humanoid.Health = 0
											until not AutoRaids or v.Humanoid.Health <= 0 or not v.Parent
										end)
									end
								end
								_F("Awakener","Awaken")
							until AutoRaids == false or not game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5") or not game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4") or not game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3") or not game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2") or not game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1") or game.Players.LocalPlayer.PlayerGui.Main.Timer.Visible == false
							_F("Awakener","Awaken")
						end
					else
						spawn(function()
							if NoLoopDuplicate3 == false then
								NoLoopDuplicate3 = true
								for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
									if v:IsA("Tool") and string.find(v.Name,"Fruit") and (v.Handle.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 7000 then
										local oldCFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Handle.CFrame * CFrame.new(3,5,1)
										fask.wait(0.02)
										firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart,v.Handle,0)
										fask.wait()
										firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart,v.Handle,1)
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame  = oldCFrame
										fask.wait(30)
									end
								end
								NoLoopDuplicate3 = false
							end
						end)
						local MaxPrice = math.huge
						for i,v in pairs(game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("getInventoryFruits")) do
							if v.Price <= 1000000 then
								if v.Price < MaxPrice then
									MaxPrice = v.Price
									LoadthisFruit = v.Name
								end
							end
						end
						if LoadthisFruit ~= nil then
							local args = {
								[1] = "LoadFruit",
								[2] = LoadthisFruit
							}

							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
						end

						local args = {
							[1] = "RaidsNpc",
							[2] = "Select",
							[3] = RaidsSelected
						}
						local CheckRaids = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
						if tostring(CheckRaids):find("You must wait") and not game.Players.LocalPlayer.Backpack:FindFirstChild("Special Microchip") and not game.Players.LocalPlayer.Character:FindFirstChild("Special Microchip") then
							Notify({
								Title = "Now Hopping",
								Text = "Not Fruit For Raids",
								Timer = 3
							},"Success")
							ServerFunc:TeleportFast()
						end
						LoadthisFruit = nil
					end
				end
			else
				break
			end
		end
	end)
end})

ConfigAutoSharkman = AutoFarmPageLeft:AddToggle("Auto Sharkman Karate",{Stats = false , callback = function(starts)
	Sharkman = starts
	_G.ConfigMain["Auto Sharkman Karate"] = starts
	SaveConfigAuto()
	if starts then
		_F("BuySharkmanKarate")
	end
	spawn(function()
		while fask.wait(.5) do
			if Sharkman then
				if game.Players.LocalPlayer:FindFirstChild("WeaponAssetCache") then
					if game.Players.LocalPlayer.Backpack:FindFirstChild("Fishman Karate") and game.Players.LocalPlayer.Backpack:FindFirstChild("Fishman Karate").Level.Value >= 400 then
						if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate",true) == "I lost my house keys, could you help me find them? Thanks." and not game.Players.LocalPlayer.Character:FindFirstChild("Water Key") and not game.Players.LocalPlayer.Backpack:FindFirstChild("Water Key") then
							if NewWorld then
								KillSharkMan = true
							else
								KillSharkMan = false
							end
						elseif tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate",true)) == 1 then
							KillSharkMan = false
							local args = {
								[1] = "BuySharkmanKarate"
							}
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
						elseif game.Players.LocalPlayer.Character:FindFirstChild("Water Key") or game.Players.LocalPlayer.Backpack:FindFirstChild("Water Key") then
							KillSharkMan = false
							local args = {
								[1] = "BuySharkmanKarate"
							}
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
						end
					end

					if game.Players.LocalPlayer.Character:FindFirstChild("Fishman Karate") and game.Players.LocalPlayer.Character:FindFirstChild("Fishman Karate").Level.Value >= 400 then
						if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate",true) == "I lost my house keys, could you help me find them? Thanks." and not game.Players.LocalPlayer.Character:FindFirstChild("Water Key") and not game.Players.LocalPlayer.Backpack:FindFirstChild("Water Key") then
							if NewWorld then
								KillSharkMan = true
							else
								KillSharkMan = false
							end
						elseif tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate",true)) == 1 then
							KillSharkMan = false
							local args = {
								[1] = "BuySharkmanKarate"
							}
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
						elseif game.Players.LocalPlayer.Character:FindFirstChild("Water Key") or game.Players.LocalPlayer.Backpack:FindFirstChild("Water Key") then
							KillSharkMan = false
							local args = {
								[1] = "BuySharkmanKarate"
							}
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
						end
					end
					SelectToolWeapon = GetFightingStyle("Melee")
				end
			else
				break
			end
		end
	end)
	spawn(function()
		while fask.wait() do
			if Sharkman  then
				if (KillSharkMan == true and game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate",true) == "I lost my house keys, could you help me find them? Thanks.") and NewWorld then
					if game.Workspace.Enemies:FindFirstChild("Tide Keeper [Lv. 1475] [Boss]") then
						if KillFish then KillFish:Stop() end
						
						for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
							if v.Name == "Tide Keeper [Lv. 1475] [Boss]" then
								repeat fask.wait()
									if game.Workspace.Enemies:FindFirstChild(v.Name) then
										if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 200 then
											Farmtween = toTarget(v.HumanoidRootPart.CFrame)
										elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 200 then
											if Farmtween then
												Farmtween:Stop()
											end
											Click()
											Usefastattack = true
											EquipWeapon(SelectToolWeapon)
											v.HumanoidRootPart.CanCollide = false
											v.HumanoidRootPart.Size = Vector3.new(50, 50, 50)
											game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(1,50,0)
										end
									else
										Usefastattack = false
									end
								until not v.Parent or Sharkman == false or KillSharkMan == false or v.Humanoid.Health == 0 or game.Players.LocalPlayer.Character:FindFirstChild("Water Key") or game.Players.LocalPlayer.Backpack:FindFirstChild("Water Key")
								Usefastattack = false
								fask.wait(1)
							end
						end
					else
						if game:GetService("ReplicatedStorage"):FindFirstChild("Tide Keeper [Lv. 1475] [Boss]") then
							KillFish = toTarget(game:GetService("ReplicatedStorage"):FindFirstChild("Tide Keeper [Lv. 1475] [Boss]").HumanoidRootPart.CFrame)
						else
							if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate",true) == "I lost my house keys, could you help me find them? Thanks." then
								Notify({
									Title = "Now Hopping",
									Text = "Not Find Sharkman",
									Timer = 3
								},"Success")
								ServerFunc:TeleportFast()
							end
						end
					end
				end
			else
				if tween then tween:Cancel() end
				break
			end
		end
	end)
end})

ConfigAutoDeathStep = AutoFarmPageLeft:AddToggle("Auto Death Step",{Stats = false , callback = function(starts)
	DeathStep = starts
	_G.ConfigMain["Auto Death Step"] = starts
	SaveConfigAuto()
	if starts then
		_F("BuyBlackLeg")
	end
	spawn(function()
		while fask.wait(.5) do
			if DeathStep then
				if game.Players.LocalPlayer:FindFirstChild("WeaponAssetCache") then
					if game.Players.LocalPlayer.Backpack:FindFirstChild("Black Leg") and game.Players.LocalPlayer.Backpack:FindFirstChild("Black Leg").Level.Value >= 400 then
						local args = {
							[1] = "BuyDeathStep"
						}
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))

					end
					if game.Players.LocalPlayer.Character:FindFirstChild("Black Leg") and game.Players.LocalPlayer.Character:FindFirstChild("Black Leg").Level.Value >= 400 then
						local args = {
							[1] = "BuyDeathStep"
						}
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))

					end
					SelectToolWeapon = GetFightingStyle("Melee")
				end
			else
				break
			end
		end
	end)
end})

ConfigAutoDragonTalon = AutoFarmPageLeft:AddToggle("Auto Dragon Talon",{Stats = false , callback = function(starts)
	DargonTalon = starts
	_G.ConfigMain["Auto Dragon Talon"] = starts
	SaveConfigAuto()
	if starts then
		_F("BlackbeardReward","DragonClaw","2")
	end
	spawn(function()
		while fask.wait(.5) do
			if DargonTalon then
				if game.Players.LocalPlayer:FindFirstChild("WeaponAssetCache") then

					SelectToolWeapon = GetFightingStyle("Melee")

					if game.Players.LocalPlayer.Backpack:FindFirstChild("Dragon Claw") and game.Players.LocalPlayer.Backpack:FindFirstChild("Dragon Claw").Level.Value >= 400 and game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health > 0 then
						if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDragonTalon", true) == 3 then
							local string_1 = "Bones";
							local string_2 = "Buy";
							local number_1 = 1;
							local number_2 = 1;
							local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
							Target:InvokeServer(string_1, string_2, number_1, number_2);

							local string_1 = "BuyDragonTalon";
							local bool_1 = true;
							local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
							Target:InvokeServer(string_1, bool_1);
						elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDragonTalon", true) == 1 then
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDragonTalon")
						else
							local string_1 = "Bones";
							local string_2 = "Buy";
							local number_1 = 1;
							local number_2 = 1;
							local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
							Target:InvokeServer(string_1, string_2, number_1, number_2);
						end
					end

					if game.Players.LocalPlayer.Character:FindFirstChild("Dragon Claw") and game.Players.LocalPlayer.Character:FindFirstChild("Dragon Claw").Level.Value >= 400 and game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health > 0 then
						if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDragonTalon", true) == 3 then
							local string_1 = "Bones";
							local string_2 = "Buy";
							local number_1 = 1;
							local number_2 = 1;
							local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
							Target:InvokeServer(string_1, string_2, number_1, number_2);

							local string_1 = "BuyDragonTalon";
							local bool_1 = true;
							local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
							Target:InvokeServer(string_1, bool_1);
						elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDragonTalon", true) == 1 then
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDragonTalon")
						else
							local string_1 = "Bones";
							local string_2 = "Buy";
							local number_1 = 1;
							local number_2 = 1;
							local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
							Target:InvokeServer(string_1, string_2, number_1, number_2);
						end
					end
				end
			else
				break
			end
		end
	end)
end})

ConfigAutoElectricClaw = AutoFarmPageLeft:AddToggle("Auto Electric Claw",{Stats = false , callback = function(starts)
	Electricclaw = starts
	_G.ConfigMain["Auto Electric Claw"] = starts
	SaveConfigAuto()
	if starts then
		_F("BuyElectro")
	end
	spawn(function()
		while fask.wait(.5) do
			if Electricclaw then
				if game.Players.LocalPlayer:FindFirstChild("WeaponAssetCache") then
					SelectToolWeapon = GetFightingStyle("Melee")
					if game.Players.LocalPlayer.Backpack:FindFirstChild("Electro") and game.Players.LocalPlayer.Backpack:FindFirstChild("Electro").Level.Value >= 400 then
						local v175 = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw", true);
						if v175 == 4 then
							local v176 = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw", "Start");
							if v176 == nil then
								game.Players.localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-12548, 337, -7481)
							end
						else
							local string_1 = "BuyElectricClaw";
							local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
							Target:InvokeServer(string_1);
						end
					end
					if game.Players.LocalPlayer.Character:FindFirstChild("Electro") and game.Players.LocalPlayer.Character:FindFirstChild("Electro").Level.Value >= 400 then
						local v175 = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw", true);
						if v175 == 4 then
							local v176 = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw", "Start");
							if v176 == nil then
								game.Players.localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-12548, 337, -7481)
							end
						else
							local string_1 = "BuyElectricClaw";
							local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
							Target:InvokeServer(string_1);
						end
					end
				end
			else
				break
			end
		end
	end)
end})

ConfigAutoBuyTrueTripleKatana = AutoFarmPageLeft:AddToggle("Auto Buy True Triple Katana",{Stats = false , callback = function(starts)
	TrueTripleKatana = starts
	_G.ConfigMain["Auto Buy True Triple Katana"] = starts
	SaveConfigAuto()
	spawn(function()
		while fask.wait() do
			if TrueTripleKatana then
				local args = {
					[1] = "MysteriousMan",
					[2] = "2"
				}
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
				fask.wait(2)
			else
				break;
			end
		end
	end)
end})

tablefound = function(ta,na)
	if not na then
		return false
	end
	for i,v in pairs(ta) do
		if tostring(v) == na then
			return true
		end
	end
	return false
end

LockLegendarySwordToBuy = _G.ConfigMain["Lock Legendary Sword To Buy"] or false
SelectLegendarySword = _G.ConfigMain["Select Legendary Sword"] or {}
ConfigAutoBuyLegendarySword = AutoFarmPageLeft:AddToggle("Auto Buy Legendary Sword",{Stats = false , callback = function(starts)
	Legendary = starts
	_G.ConfigMain["Auto Buy Legendary Sword"] = starts
	SaveConfigAuto()
	spawn(function()
		while fask.wait() do
			if Legendary then
				if LockLegendarySwordToBuy == true then
					if not tablefound(SelectLegendarySword,_F("LegendarySwordDealer","1")) then
						return
					end
				end
				for i = 1,3 do
					_F("LegendarySwordDealer",tostring(i))
				end
				fask.wait(2)
			else
				break;
			end
		end
	end)
end})

ConfigAutoBuyLegendarySwordHop = AutoFarmPageLeft:AddToggle("Auto Buy Legendary Sword Hop",{Stats = false , callback = function(starts)
	LegendaryHop = starts
	_G.ConfigMain["Auto Buy Legendary Sword Hop"] = starts
	SaveConfigAuto()
	spawn(function()
		while fask.wait() do
			if LegendaryHop then
				if LockLegendarySwordToBuy == true then
					if not tablefound(SelectLegendarySword,_F("LegendarySwordDealer","1")) then
						ServerFunc:TeleportFast()
						return
					end
				end
				for i = 1,3 do
					_F("LegendarySwordDealer",tostring(i))
				end
				fask.wait(2)
				ServerFunc:TeleportFast()
			else
				break;
			end
		end
	end)
end})

ConfigLockLegendarySwordToBuy = AutoFarmPageLeft:AddToggle("Lock Legendary Sword To Buy",{Stats = false , callback = function(starts)
	LockLegendarySwordToBuy = starts
	_G.ConfigMain["Lock Legendary Sword To Buy"] = starts
	SaveConfigAuto()
end})

AutoFarmPageLeft:AddMultiDropdown("Select Legendary Sword To Buy",{Values = {
	"Shisui",
	"Wando",
	"Saddi",
}
,setup = SelectLegendarySword, callback = function(starts)

	SelectLegendarySword = starts
	_G.ConfigMain["Select Legendary Sword"] = starts
	SaveConfigAuto()
end})


LockHakiColorToBuy = _G.ConfigMain["Lock Haki Color To Buy"] or false
SelectHakiColor = _G.ConfigMain["Select Haki Color"] or {}

ConfigAutoBuyEnhancement = AutoFarmPageLeft:AddToggle("Auto Buy Enhancement",{Stats = false , callback = function(starts)
	Enhancement = starts
	_G.ConfigMain["Auto Buy Enhancement"] = starts
	SaveConfigAuto()
	spawn(function()
		while fask.wait() do
			if Enhancement then
				if LockHakiColorToBuy == true then
					if not tablefound(SelectHakiColor,_F("ColorsDealer","1")) then
						return
					end
				end
				for i = 1,3 do
					_F("ColorsDealer",tostring(i))
				end
				fask.wait(2)
			else
				break;
			end
		end
	end)
end})

ConfigAutoBuyEnhancementHop = AutoFarmPageLeft:AddToggle("Auto Buy Enhancement Hop",{Stats = false , callback = function(starts)
	EnhancementHop = starts
	_G.ConfigMain["Auto Buy Enhancement Hop"] = starts
	SaveConfigAuto()
	spawn(function()
		while fask.wait() do
			if EnhancementHop then
				if LockHakiColorToBuy == true then
					if not tablefound(SelectHakiColor,_F("ColorsDealer","1")) then
						ServerFunc:TeleportFast()
						return
					end
				end
				for i = 1,3 do
					_F("ColorsDealer",tostring(i))
				end
				fask.wait(3)
				ServerFunc:TeleportFast()
			else
				break;
			end
		end
	end)
end})

ConfigLockHakiColorToBuy = AutoFarmPageLeft:AddToggle("Lock Haki Color To Buy",{Stats = false , callback = function(starts)
	LockHakiColorToBuy = starts
	_G.ConfigMain["Lock Haki Color To Buy"] = starts
	SaveConfigAuto()
end})

AutoFarmPageLeft:AddMultiDropdown("Select Haki Color To Buy",{Values = {
	"Pure Red",
	"Bright Yellow",
	"Yellow Sunshine",
	"Blue Jeans",
	"Orange Soda",
	"Winter Sky",
	"Fiery Rose",
	"Green Lizard",
	"Slimy Green",
	"Rainbow Saviour",
	"Heat Wave",
	"Absolute Zero",
	"Plump Purple",
	"Snow White"
}
,setup = SelectHakiColor, callback = function(starts)

	SelectHakiColor = starts
	_G.ConfigMain["Select Haki Color"] = starts
	SaveConfigAuto()
end})

AutoFarmPageLeft:AddLabel("~ Auto Farm Material ~")

local AllMaterial
if OldWorld then
	AllMaterial = {
		"Magma Ore",
		"Leather",
		"Scrap Metal",
		"Angel Wings",
		"Fish Tail"
	}
elseif NewWorld then
	AllMaterial = {
		"Magma Ore",
		"Scrap Metal",
		"Radioactive Material",
		"Vampire Fang",
		"Mystic Droplet",
		"Fish Tail"
	}
elseif ThreeWorld then
	AllMaterial = {
		"Mini Tusk",
		"Scrap Metal",
		"Dragon Scale",
		"Conjured Cocoa",
		"Demonic Wisp",
		"Gunpowder",
	}
end

table.sort(AllMaterial)

local SelectMaterial = _G.ConfigMain["Select Material"] or ""

AutoFarmPageLeft:AddDropdown("Normal Material",{Values = AllMaterial, callback = function(starts)
	SelectMaterial = starts
	_G.ConfigMain["Select Material"] = starts
	SaveConfigAuto()
end})

ConfigAutoFarmMaterial = AutoFarmPageLeft:AddToggle("Auto Farm Material",{Stats = false , callback = function(starts)
	AutoFarmMaterial = starts
	_G.ConfigMain["Auto Farm Material"] = starts
	SaveConfigAuto()
	spawn(function()
		while fask.wait() do
			if AutoFarmMaterial then
				xpcall(function()
					if SelectMaterial ~= "" then
						CheckMaterial(SelectMaterial)
						if CustomFindFirstChild(MaterialMob) then
							for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
								if AutoFarmMaterial and table.find(MaterialMob,v.Name) and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
									repeat fask.wait()
										FarmtoTarget = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame * CFrame.new(0,30,1))
										if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
											if FarmtoTarget then FarmtoTarget:Stop() end
											Usefastattack = true
											EquipWeapon(SelectToolWeapon)
											spawn(function()
												for i,v2 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
													if v2.Name == v.Name then
														spawn(function()
															if InMyNetWork(v2.HumanoidRootPart) then
																v2.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
																v2.Humanoid.JumpPower = 0
																v2.Humanoid.WalkSpeed = 0
																v2.HumanoidRootPart.CanCollide = false
																v2.Humanoid:ChangeState(14)
																v2.Humanoid:ChangeState(11)
																v2.HumanoidRootPart.Size = Vector3.new(55,55,55)
															end
														end)
													end
												end
											end)
											if game.Players.LocalPlayer.Character:FindFirstChild("Black Leg") and game.Players.LocalPlayer.Character:FindFirstChild("Black Leg").Level.Value >= 150 then
												game:service('VirtualInputManager'):SendKeyEvent(true, "V", false, game)
												game:service('VirtualInputManager'):SendKeyEvent(false, "V", false, game)
											end
											game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 1)
										end
									until not CustomFindFirstChild(MaterialMob) or not AutoFarmMaterial or v.Humanoid.Health <= 0 or not v.Parent
									Usefastattack = false
								end
							end
						else
							Usefastattack = false
							Modstween = toTarget(CFrameMon.Position,CFrameMon)
							if (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
								if Modstween then Modstween:Stop() end
								game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
							end
						end
					end
				end,function(x)
					print("Auto Farm Material Error : "..x)
				end)
			else
				break;
			end
		end
	end)
end})

AutoFarmPageLeft:AddLabel("~ Auto Farm Mastery ~")

ConfigAutoFarmDevilFruitMastery = AutoFarmPageLeft:AddToggle("Auto Farm Mastery Devil Fruit",{Stats = false , callback = function(starts)
	FarmMasteryDevilFruit = starts
	_G.ConfigMain["Auto Farm Devil Fruit Mastery"] = starts
	SaveConfigAuto()
	spawn(function()
		while fask.wait() do
			if FarmMasteryDevilFruit then
				xpcall(function()
					CheckQuestMasteryFarm()
					AutoFarmMasteryDevilFruit()
				end,function(x)
					print("Auto Farm Mastery Devil Fruit Error : "..x)
				end)
			else
				break;
			end
		end
	end)
end})

ConfigAutoFarmMasteryGun = AutoFarmPageLeft:AddToggle("Auto Farm Mastery Gun",{Stats = false , callback = function(starts)
	FarmMasteryGun = starts
	_G.ConfigMain["Auto Farm Gun Mastery"] = starts
	SaveConfigAuto()
	spawn(function()
		while fask.wait() do
			if FarmMasteryGun then
				xpcall(function()
					CheckQuestMasteryFarm()
					AutoFarmMasteryGun()
				end,function(x)
					print("Auto Farm Mastery Gun Error : "..x)
				end)
			else
				if tween then tween:Cancel() end
				break;
			end
		end
	end)
end})

AutoFarmPageLeft:AddLabel("~ Auto Farm Mastery Plus++ ~")

local MasteryWeaponList = (_G.ConfigMain["Select Mastery Sword List"] or 600)
local SelectWeaponSwordList = _G.ConfigMain["Select Sword List"] or {}

ConfigAutoFarmMasterySwordList = AutoFarmPageLeft:AddToggle("Auto Farm Mastery Sword List",{Stats = false , callback = function(starts)
	FarmMasterySwordList = starts
	_G.ConfigMain["Auto Farm Sword Mastery List"] = starts
	SaveConfigAuto()
	spawn(function()
		while fask.wait() do
			if FarmMasterySwordList then
				xpcall(function()
					--print(#SelectWeaponSwordList)
					if #SelectWeaponSwordList == 0 then return end

					for i,v in pairs(SelectWeaponSwordList) do
						if FarmMasterySwordList == false and table.find(SwordListFarmComplete,v) then
							break;
						end
						if not game.Players.LocalPlayer.Backpack:FindFirstChild(v) and not game.Players.LocalPlayer.Character:FindFirstChild(v) and game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):GetState() ~= Enum.HumanoidStateType.Dead and game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health ~= 0 then
							while FarmMasterySwordList do fask.wait()
								if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health == 0 then if tween then tween:Cancel() end repeat fask.wait() until game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health > 0; fask.wait(0.2) end
								if tween then tween:Cancel() end
								if inmyself(v) or FarmMasterySwordList == false or table.find(SwordListFarmComplete,v) then
									break;
								end
								fask.wait(1)
								_F("StoreItem",tostring(GetFightingStyle("Sword")),inmyself(GetFightingStyle("Sword")))
								fask.wait(1)
								_F("LoadItem",tostring(v))
								fask.wait(0.5)
								if inmyself(v) then
									SelectWeaponInSwordList = v
									break;
								end
								if CheckMasteryWeapon(v,MasteryWeaponList) == "true" or CheckMasteryWeapon(v,MasteryWeaponList) == "UpTo" then
									print("DONE "..v)
									table.insert(SwordListFarmComplete,v)
									break;
								end
							end
						end
						fask.wait(0.2)
						if inmyself(v) then
							while FarmMasterySwordList do fask.wait()
								if table.find(SwordListFarmComplete,v) and #SelectWeaponSwordList ~= 0 and #SwordListFarmComplete ~= 0 then
									break
								end
								if FarmMasterySwordList == false then
									break;
								end
								if inmyself(v) then
									SelectWeaponInSwordList = v
								end
								CheckQuestMasteryFarm()
								AutoFarmMasterySwordList()
								if CheckMasteryWeapon(v,MasteryWeaponList) == "true" or CheckMasteryWeapon(v,MasteryWeaponList) == "UpTo" then
									print("DONE "..v)
									table.insert(SwordListFarmComplete,v)
									break;
								end
							end
						end
					end
				end,function(x)
					print("Auto Farm Sword Mastery Error : "..x)
				end)
			else
				if tween then tween:Cancel() end
				break;
			end
		end
	end)
end})

local AllSwordInInventroy = {}
for i,v in pairs(game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("getInventoryWeapons")) do
	if type(v) == "table" then
		if v.Type == "Sword" then
			table.insert(AllSwordInInventroy,v.Name)
		end
	end
end
if GetFightingStyle("Sword") ~= "Not Have" then
	table.insert(AllSwordInInventroy,GetFightingStyle("Sword"))
end

local OptionsSelectSwordList = AutoFarmPageLeft:AddMultiDropdown("Select Sword List",{Values = AllSwordInInventroy  ,setup = SelectWeaponSwordList,callback = function(starts)
	SelectWeaponSwordList = starts
	_G.ConfigMain["Select Sword List"] = starts
	SaveConfigAuto()
end})

AutoFarmPageLeft:AddButton("Refresh",function()
	OptionsSelectSwordList:Clear()
	local AllSwordInInventroy = {}
	for i,v in pairs(game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("getInventoryWeapons")) do
		if type(v) == "table" then
			if v.Type == "Sword" then
				table.insert(AllSwordInInventroy,v.Name)
			end
		end
	end
	if GetFightingStyle("Sword") ~= "Not Have" then
		table.insert(AllSwordInInventroy,GetFightingStyle("Sword"))
	end
	for i, v in pairs(AllSwordInInventory) do
		OptionsSelectSwordList:Add(v)
	end
end)

function GetRarityWeaponSword(Rare,tye,tye2)
	if Rare == "Common" then
		RareNumber = 0
	elseif Rare == "Uncommon" then
		RareNumber = 1
	elseif Rare == "Rare" then
		RareNumber = 2
	elseif Rare == "Legendary" then
		RareNumber = 3
	elseif Rare == "Mythical" then
		RareNumber = 4
	else
		return "Worng InPut"
	end
	local ReturnTable = {}
	for i,v in pairs(_F("getInventory")) do
		if type(v) == "table" then
			if v.Rarity and v.Type == "Sword" then
				if (not tye and tonumber(v.Rarity) == RareNumber) or (tye and tonumber(v.Rarity) >= RareNumber) then
					if tye2 then
						table.insert(ReturnTable,v.Name .." " ..v.Mastery)
					else
						table.insert(ReturnTable,v.Name)
					end
				end
			end
		end
	end
	return ReturnTable
end

AutoFarmPageLeft:AddMultiDropdown("Select Rarity",{Values = {"Common","Uncommon","Rare","Legendary","Mythical"},setup = (_G.ConfigMain["Select Rarity Sword List"] or {}) , callback = function(starts)
	SelectRaritySwordList = starts
	_G.ConfigMain["Select Rarity Sword List"] = starts
	SelectWeaponSwordList = {}
	for i,v in pairs(SelectRaritySwordList) do
		if type(GetRarityWeaponSword(v)) == "table" then
			for i2,v2 in pairs(GetRarityWeaponSword(v)) do
				table.insert(SelectWeaponSwordList,v2)
			end
		end
	end
	_G.ConfigMain["Select Sword List"] = SelectWeaponSwordList
	SaveConfigAuto()
end})

AutoFarmPageLeft:AddSlider("Select Mastery Sword List",{value = MasteryWeaponList ,min = 1 , max = 600 , callback = function(starts)
	MasteryWeaponList = starts
	_G.ConfigMain["Select Mastery Sword List"] = starts
	SaveConfigAuto()
end})


AutoFarmPageLeft:AddSlider("Health [default : 15 - 20% ]",{value = 15 ,min = 0 , max = 100 , callback = function(starts)
	PersenHealth = starts
end})

AutoFarmPageLeft:AddLabel("~ kaitun Tools ~")

local RAM_Port = (_G.RAM_Port or 7963)
local RAM_Password = (_G.RAM_Password or "")

local ShowRAM_Port = AutoFarmPageLeft:AddLabel("Port : "..RAM_Port)

local ShowRAM_Password = AutoFarmPageLeft:AddLabel("Password : "..RAM_Password)

SettingAcc:SetPort(RAM_Port)
SettingAcc:SetPassword(RAM_Password)

AutoFarmPageLeft:AddTextBox("RAM Port",{Placeholder = "Insert Port",callback = function(starts)
	if not tonumber(starts) then return end
	RAM_Port = starts
	ShowRAM_Port:Options().Text = "Port : "..RAM_Port
	SettingAcc:SetPort(RAM_Port)
end})

AutoFarmPageLeft:AddTextBox("RAM Password",{Placeholder = "Insert Password",callback = function(starts)
	RAM_Password = starts
	ShowRAM_Password:Options().Text = "Password : "..RAM_Password
	SettingAcc:SetPassword(RAM_Password)
end})

ATSDES = AutoFarmPageLeft:AddToggle("Auto Set Description",{Stats = (_G.Auto_Set_Description or false) , callback = function(starts)
	AutoSetDescription = starts
	spawn(function()
		while fask.wait() do
			if AutoSetDescription then
				xpcall(function()
					local Check,MyLevel,MyFrag,MyMo,MyDevilFruit = pcall(function() return game.Players.LocalPlayer.Data.Level.Value,game.Players.LocalPlayer.Data.Fragments.Value,game.Players.LocalPlayer.Data.Beli.Value,inmyself(tostring(game:GetService("Players")["LocalPlayer"]:WaitForChild("Data").DevilFruit.Value)) end)
					if not Check then return end
					MyAccount = RAMAccount.new(game:GetService'Players'.LocalPlayer.Name)
					if MyAccount then
						local CheckDone = MyAccount:SetDescription(string.format("Level: %s\nMelee: %s\nInventory: %s\nRare Fruit: %s\nFruit: %s\nAwake: %s\nMoney: %s\nFragment: %s",
							MyLevel,GetMeleeText(),table.concat(GetRarityWeaponSword("Legendary",true,true)," ,") , table.concat(GetRareFruitText()," ,"), MyDevilFruit.Name .. " " .. MyDevilFruit:WaitForChild("Level").Value , GetAwakened() , Abbreviate(MyMo) , Abbreviate(MyFrag) ))
						if CheckDone ~= false then
							local TextSet = {}
							if ThreeWorld then
								table.insert(TextSet,"World 3")
							elseif NewWorld then
								table.insert(TextSet,"World 2")
							elseif OldWorld then
								table.insert(TextSet,"World 1")
							end
							table.insert(TextSet,GetMeleeText())
							for i,v in pairs(_F("getInventory")) do
								if type(v) == "table" then
									if v.Name == "Hallow Scythe" then
										table.insert(TextSet,"HS")
									end
									if v.Name == "Cursed Dual Katana" then
										table.insert(TextSet,"CDK")
									end
								end
							end
							for i,v in pairs(_F("getInventory")) do
								if type(v) == "table" then
									if v.Name == "Yama" and not table.find(TextSet,"CDK") then
										table.insert(TextSet,"YA")
									end
									if v.Name == "Tushita" and not table.find(TextSet,"CDK") then
										table.insert(TextSet,"TU")
									end
								end
							end
							if #TextSet == 0 then return end
							local CheckDone2 = MyAccount:SetAlias(table.concat(TextSet," & "))
							if CheckDone2 ~= false then
								print("SET")
								fask.wait(10)
							else
								messagebox("You Not Open Allow Modify Methods","Alert",0)
								ChangeToggle(ATSDES,false)
							end
						else
							messagebox("You Not Open Allow Modify Methods","Alert",0)
							ChangeToggle(ATSDES,false)
						end
					else
						messagebox("Can't Connect To RAM","Alert",0)
						ChangeToggle(ATSDES,false)
					end
				end,print)
			else
				break
			end
			fask.wait(5)
		end
	end)
end})

KaitunPicMode = AutoFarmPageLeft:AddDropdown("Kaitun Picture Mode",{Values = {""} , callback = function(starts)
	SelectKaitunPicMode = starts
end})
KaitunPicMode:Clear()
KaitunPicMode:Add({"Mode 1","Mode 2"})

AutoFarmPageLeft:AddButton("Kaitun Picture",function()
	if SelectKaitunPicMode == "" then
		Notify({
			Title = "Alert!!!",
			Text = "Pls Select Mode Picture",
			Timer = 3
		},"Warn")
	end

	do ui = game:GetService("CoreGui") if ui:FindFirstChild("LayoutKaitun") then ui:FindFirstChild("LayoutKaitun"):Destroy() end end

	fask.wait((22/7)/2/2)

	for i,v in pairs(getconnections(game:GetService("Players")["LocalPlayer"].PlayerGui.Main.InventoryContainer.Right.Content.Sort.Dropdown.All.Activated)) do
		v.Function()
	end

	fask.wait()
	local function formatNumber(number)
		local i, k, j = tostring(number):match("(%-?%d?)(%d*)(%.?.*)")
		return i..k:reverse():gsub("(%d%d%d)", "%1,"):reverse()..j
	end

	local UserInputService = game:GetService("UserInputService")
	local TweenService = game:GetService("TweenService")
	local XFALSEYTRUE = false
	local function MakeControl(topbarobject, object)
		local Dragging = nil
		local DragInput = nil
		local DragStart = nil
		local StartPosition = nil

		local function Update(input)
			local Delta = input.Position - DragStart
			local pos =
				UDim2.new(
					StartPosition.X.Scale,
					StartPosition.X.Offset + Delta.X,
					StartPosition.Y.Scale,
					StartPosition.Y.Offset + Delta.Y
				)
			local Tween = TweenService:Create(object, TweenInfo.new(0.2), {Position = pos})

			Tween:Play()
		end

		local inputdis1
		local inputdis2
		local inputdis3
		local inputdis4
		local inputS1
		local inputS2
		inputdis1 = topbarobject.InputBegan:Connect(
			function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					Dragging = true
					DragStart = input.Position
					StartPosition = object.Position

					input.Changed:Connect(
						function()
							if input.UserInputState == Enum.UserInputState.End then
								Dragging = false
							end
						end
					)
				end
			end
		)

		inputdis2 = topbarobject.InputChanged:Connect(
			function(input)
				if
					input.UserInputType == Enum.UserInputType.MouseMovement or
					input.UserInputType == Enum.UserInputType.Touch
				then
					DragInput = input
				end
			end
		)

		inputdis3 = UserInputService.InputChanged:Connect(
			function(input)
				if input == DragInput and Dragging then
					Update(input)
				end
			end
		)
		local AddX = 0
		local AddY = 0
		inputS1 = topbarobject.MouseWheelForward:Connect(function()
			if XFALSEYTRUE == false then
				AddX = 0.01
				AddY = 0
			elseif XFALSEYTRUE == true then
				AddX = 0
				AddY = 0.01
			end
			object.Size = UDim2.new(object.Size.X.Scale + AddX,0, object.Size.Y.Scale + AddY,0)

		end)

		inputS2 = topbarobject.MouseWheelBackward:Connect(function()
			if XFALSEYTRUE == false then
				AddX = 0.01
				AddY = 0
			elseif XFALSEYTRUE == true then
				AddX = 0
				AddY = 0.01
			end
			object.Size = UDim2.new(object.Size.X.Scale - AddX,0, object.Size.Y.Scale - AddY,0)

		end)
		inputdis4 = UserInputService.InputBegan:Connect(function(io, p)
			if io.KeyCode.Name == "Home" then
				inputdis1:Disconnect()
				inputdis2:Disconnect()
				inputdis3:Disconnect()
				inputdis4:Disconnect()
				inputS1:Disconnect()
				inputS2:Disconnect()
			end
		end)
	end

	if SelectKaitunPicMode == "Mode 1" then

		local LayoutKaitun = Instance.new("ScreenGui")
		local Fighthing = Instance.new("Frame")
		local FighthingUIGridLayout = Instance.new("UIGridLayout")
		local Mythical = Instance.new("Frame")
		local MythicalUIGridLayout = Instance.new("UIGridLayout")
		local Legendary = Instance.new("Frame")
		local LegendaryUIGridLayout = Instance.new("UIGridLayout")
		local Level = Instance.new("Frame")
		local LevelUIGridLayout = Instance.new("UIGridLayout")
		local Fruits = Instance.new("Frame")
		local FruitsUIGridLayout = Instance.new("UIGridLayout")
		local Mastery = Instance.new("Frame")
		local MasteryUIGridLayout = Instance.new("UIGridLayout")
		local Awakend = Instance.new("Frame")
		local AwakendUIGridLayout = Instance.new("UIGridLayout")
		local DraggableFrame = Instance.new("Frame")
		local DraggableFrameCorner = Instance.new("UICorner")
		local Logo = Instance.new("ImageLabel")

		--Properties:

		DraggableFrame.Name = "DraggableFrame"
		DraggableFrame.Parent = LayoutKaitun
		DraggableFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
		DraggableFrame.BorderSizePixel = 0
		DraggableFrame.Position = UDim2.new(0.490409195, 0, 0.481481493, 0)
		DraggableFrame.Size = UDim2.new(0, 29, 0, 29)
		DraggableFrame.ZIndex = 99999

		DraggableFrameCorner.CornerRadius = UDim.new(0, 4)
		DraggableFrameCorner.Name = "DraggableFrameCorner"
		DraggableFrameCorner.Parent = DraggableFrame

		Logo.Name = "Logo"
		Logo.Parent = DraggableFrame
		Logo.Active = true
		Logo.AnchorPoint = Vector2.new(0.5, 0.5)
		Logo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Logo.BackgroundTransparency = 1.000
		Logo.Position = UDim2.new(0.5, 0, 0.5, 0)
		Logo.Size = UDim2.new(0, 20, 0, 20)
		Logo.Image = "http://www.roblox.com/asset/?id=6034837797"

		LayoutKaitun.Name = "LayoutKaitun"
		LayoutKaitun.Parent = game:GetService("CoreGui")
		LayoutKaitun.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

		Fighthing.Name = "Fighthing"
		Fighthing.Parent = LayoutKaitun
		Fighthing.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Fighthing.BackgroundTransparency = 1
		Fighthing.Position = UDim2.new(0.00703325309, 0, 0.0111111132, 0)
		Fighthing.Size = UDim2.new(0.450207263, 0, 0.123456791, 0)

		FighthingUIGridLayout.Name = "FighthingUIGridLayout"
		FighthingUIGridLayout.Parent = Fighthing
		FighthingUIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
		FighthingUIGridLayout.CellPadding = UDim2.new(0.0100999996, 0, 0, 0)
		FighthingUIGridLayout.CellSize = UDim2.new(0.139000007, 0, 1, 0)

		Mythical.Name = "Mythical"
		Mythical.Parent = LayoutKaitun
		Mythical.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Mythical.BackgroundTransparency = 1
		Mythical.Position = UDim2.new(0.00703324797, 0, 0.17037037, 0)
		Mythical.Size = UDim2.new(0.340792835, 0, 0.123456791, 0)

		MythicalUIGridLayout.Name = "MythicalUIGridLayout"
		MythicalUIGridLayout.Parent = Mythical
		MythicalUIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
		MythicalUIGridLayout.CellPadding = UDim2.new(0.00999999978, 0, 0, 0)
		MythicalUIGridLayout.CellSize = UDim2.new(0.185000003, 0, 1, 0)
		MythicalUIGridLayout.FillDirectionMaxCells = 5

		Legendary.Name = "Legendary"
		Legendary.Parent = LayoutKaitun
		Legendary.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Legendary.BackgroundTransparency = 1
		Legendary.Position = UDim2.new(0.00703324797, 0, 0.322222233, 0)
		Legendary.Size = UDim2.new(0.482097179, 0, 0.123456791, 0)

		LegendaryUIGridLayout.Name = "LegendaryUIGridLayout"
		LegendaryUIGridLayout.Parent = Legendary
		LegendaryUIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
		LegendaryUIGridLayout.CellPadding = UDim2.new(0.00999999978, 0, 0.0299999993, 0)
		LegendaryUIGridLayout.CellSize = UDim2.new(0.125000007, 0, 1, 0)

		Level.Name = "Level"
		Level.Parent = LayoutKaitun
		Level.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Level.BackgroundTransparency = 1
		Level.Position = UDim2.new(0.00703324797, 0, 0.722222209, 0)
		Level.Size = UDim2.new(0.351023018, 0, 0.261728406, 0)

		LevelUIGridLayout.Name = "LevelUIGridLayout"
		LevelUIGridLayout.Parent = Level
		LevelUIGridLayout.FillDirection = Enum.FillDirection.Vertical
		LevelUIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
		LevelUIGridLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
		LevelUIGridLayout.CellPadding = UDim2.new(0.00999999978, 0, 0, 0)
		LevelUIGridLayout.CellSize = UDim2.new(0.349999994, 0, 0.300000012, 0)
		LevelUIGridLayout.StartCorner = Enum.StartCorner.TopRight

		Fruits.Name = "Fruits"
		Fruits.Parent = LayoutKaitun
		Fruits.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Fruits.BackgroundTransparency = 1
		Fruits.Position = UDim2.new(0.543528736, 0, 0.521400213, 0)
		Fruits.Size = UDim2.new(0.443864882/1.2, 0, 0.462442219/1.2, 0)

		FruitsUIGridLayout.Name = "FruitsUIGridLayout"
		FruitsUIGridLayout.Parent = Fruits
		FruitsUIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
		FruitsUIGridLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
		FruitsUIGridLayout.CellSize = UDim2.new(0.180000007, 0, 0.280000001, 0)
		FruitsUIGridLayout.StartCorner = Enum.StartCorner.BottomLeft

		Mastery.Name = "Mastery"
		Mastery.Parent = LayoutKaitun
		Mastery.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Mastery.BackgroundTransparency = 1
		Mastery.Position = UDim2.new(0.489130378, 0, 0.0197530836, 0)
		Mastery.Size = UDim2.new(0.498721212, 0, 0.0878065005, 0)

		MasteryUIGridLayout.Name = "MasteryUIGridLayout"
		MasteryUIGridLayout.Parent = Mastery
		MasteryUIGridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
		MasteryUIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
		MasteryUIGridLayout.CellSize = UDim2.new(0.230000004, 0, 1, 0)
		MasteryUIGridLayout.CellPadding = UDim2.new(0.01, 0, 0, 0)
		MasteryUIGridLayout.FillDirectionMaxCells = 5
		MasteryUIGridLayout.StartCorner = Enum.StartCorner.BottomLeft

		Awakend.Name = "Awakend"
		Awakend.Parent = LayoutKaitun
		Awakend.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Awakend.BackgroundTransparency = 1
		Awakend.Position = UDim2.new(0.591340601, 0, 0.209760457, 0)
		Awakend.Size = UDim2.new(0.395780057, 0, 0.235397741, 0)

		AwakendUIGridLayout.Name = "AwakendUIGridLayout"
		AwakendUIGridLayout.Parent = Awakend
		AwakendUIGridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
		AwakendUIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
		AwakendUIGridLayout.CellPadding = UDim2.new(0, 0, 0, 0)
		AwakendUIGridLayout.CellSize = UDim2.new(1, 0, 1, 0)
		AwakendUIGridLayout.FillDirectionMaxCells = 5
		AwakendUIGridLayout.StartCorner = Enum.StartCorner.BottomLeft

		local MainUI = game.Players.LocalPlayer.PlayerGui.Main

		local Inv = require(MainUI.UIController.Inventory)
		local Sprite = require(MainUI.UIController.Inventory.Spritesheets)
		local itemList = getupvalue(Inv.UpdateSort,2)
		local Tempt = MainUI.InventoryContainer.Right.Content.ScrollingFrame.Frame["1"]:Clone()
		local tier = getupvalue(Inv.UpdateSelected,7)

		local function AddItemToGui(itemtype,rarity,parentitem)
			for i,v in pairs(itemList) do
				if v.Visible then
					local Item = Tempt:Clone()
					Item.ItemLine1.Text = v.details.Type == "Material" and v.details.Count or ""
					Item.ItemLine2.Text = v.details.Type
					Item.ItemName.Text = v.DisplayName or v.details.Name
					Item.IconOutline.Visible = false
					Item.Equipped.Visible = false
					Item.OutlineGlow.Visible = true
					Item.OutlineGlow.ImageColor3 = tier[v.details.Rarity][2]
					for Image,list in pairs(Sprite) do
						local FName = v.details.Name:gsub(",",""):gsub(":",""):gsub("'","")
						local IconSize = list[FName.."1.png"]
						local IconOutlineSize = list[FName.."2.png"]
						if IconSize then
							local num = (IconSize[3] and 1 or 2)
							Item.Icon.Image = Image
							Item.Icon.ImageRectOffset = Vector2.new(IconSize[1] / num, IconSize[2] / num);
							Item.Icon.ImageRectSize = Vector2.new(IconSize[3] and 150, IconSize[4] and 150);

							Item.Background.BackgroundColor3 = tier[v.details.Rarity][2]
							Item.Background.UIStroke.Color = tier[v.details.Rarity][2]
							Item.BackgroundShadow.BackgroundColor3 = tier[v.details.Rarity][2]
							Item.BackgroundShadow.UIStroke.Color = tier[v.details.Rarity][2]
						end
						if IconOutlineSize then
							local num = (IconOutlineSize[3] and 1 or 2)
							Item.IconOutline.Image = Image
							Item.IconOutline.Visible = true
							Item.IconOutline.ImageRectOffset = Vector2.new(IconOutlineSize[1] / num, IconOutlineSize[2] / num);
							Item.IconOutline.ImageRectSize = Vector2.new(IconOutlineSize[3] and 150, IconOutlineSize[4] and 150);
						end
					end
					if itemtype == "Blox Fruit" and Item.ItemLine2.Text == "Blox Fruit" then
						Item.Parent = parentitem
					elseif rarity == 0 and Item.ItemLine2.Text == itemtype then
						Item.Parent = parentitem
					elseif Item.ItemLine2.Text == itemtype and v.details.Rarity == rarity then
						Item.Parent = parentitem
					end
				end
			end
		end

		local AllMelee = {
			["Godhuman"] = "10338473987",
			["Superhuman"] = "4831781711",
			["SharkmanKarate"] = "6525157144",
			["DragonTalon"] = "7831677967",
			["ElectricClaw"] = "6866994470",
			["DeathStep"] = "6085350468"
		}

		for i,v in pairs(AllMelee) do
			spawn(function()
				if tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buy"..i , true)) == 1 then
					local MeleeUi = Instance.new("ImageLabel")

					MeleeUi.Name = i
					MeleeUi.Parent = Fighthing
					MeleeUi.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					MeleeUi.BackgroundTransparency = 1
					MeleeUi.BorderSizePixel = 0
					MeleeUi.Size = UDim2.new(0.8, 0, 0.8, 0)
					MeleeUi.Image = 'rbxassetid://' .. v
				end
			end)
		end

		AddItemToGui("Sword",4,Mythical)

		AddItemToGui("Sword",3,Legendary)

		AddItemToGui("Accessory",3,Legendary)

		local LevelFrame = game:GetService("Players")["LocalPlayer"].PlayerGui.Main.Level:Clone()
		LevelFrame.Parent = Level

		local BeilFrame = game:GetService("Players")["LocalPlayer"].PlayerGui.Main.Beli:Clone()
		BeilFrame.Parent = Level

		local FragmentsFrame = BeilFrame:Clone()
		FragmentsFrame.Parent = Level
		FragmentsFrame.Text = "ƒ"..formatNumber(game:GetService("Players").LocalPlayer.Data.Fragments.Value)
		FragmentsFrame.TextColor3 = Color3.fromRGB(177, 121, 255)

		AddItemToGui("Blox Fruit",0,Fruits)

		spawn(function()
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getAwakenedAbilities")
			fask.wait((22/7)/2/2)
			game.Players.LocalPlayer.PlayerGui.Main.AwakeningToggler.Visible = true

			fask.wait(1)
			AwakeningToggler = game:GetService("Players").LocalPlayer.PlayerGui.Main.AwakeningToggler:Clone()
			AwakeningToggler.Parent = Awakend
			AwakeningToggler.Name = 'Awake'
			game:GetService("Players").LocalPlayer.PlayerGui.Main.AwakeningToggler.Visible = false
		end)

		game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):UnequipTools()

		fask.wait(0.1)

		for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
			if v:FindFirstChild("Level") then
				if game.Players.LocalPlayer.Backpack:FindFirstChild(v.Name) then
					local tool = game.Players.LocalPlayer.Backpack:FindFirstChild(v.Name)
					fask.wait()
					game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(tool)
				end
				fask.wait(0.2)
				if game.Players.LocalPlayer.Character:FindFirstChild(v.Name) then
					local Floder = Instance.new("Frame")
					Floder.Parent = Mastery
					Floder.Name = v.Parent.Name
					Floder.BackgroundTransparency = 1

					local FloderUIGridLayout = Instance.new("UIGridLayout")
					FloderUIGridLayout.Name = "Floder"..v.Parent.Name
					FloderUIGridLayout.Parent = Floder
					FloderUIGridLayout.FillDirection = Enum.FillDirection.Vertical
					FloderUIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
					FloderUIGridLayout.VerticalAlignment = Enum.VerticalAlignment.Top
					FloderUIGridLayout.CellPadding = UDim2.new(0, 0, 0, 0)
					FloderUIGridLayout.CellSize = UDim2.new(1, 0, 0.5, 0)

					TemUi = game:GetService("Players")["LocalPlayer"].PlayerGui.Main.Skills.Level:Clone()
					TemUi.Parent = Floder
					TemUi = game:GetService("Players")["LocalPlayer"].PlayerGui.Main.Skills.Title:Clone()
					TemUi.Parent = Floder
				end
			end
		end

		fask.wait(0.1)

		game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):UnequipTools()

		local ShowStatus = game:GetService("Players").LocalPlayer.PlayerGui.Main.Version:Clone()
		ShowStatus.Parent = LayoutKaitun
		ShowStatus.TextSize = 24
		ShowStatus.TextColor3 = Color3.fromRGB(255, 0, 127)
		ShowStatus.Text = "Now Change : Melee Frame"
		ShowStatus.Visible = true
		local ChangeDragNum = 0
		local ChangeSizeNum = 0
		MakeControl(DraggableFrame,Fighthing)

		local ShowStatusXY = game:GetService("Players").LocalPlayer.PlayerGui.Main.Version:Clone()
		ShowStatusXY.Parent = LayoutKaitun
		ShowStatusXY.TextSize = 24
		ShowStatusXY.TextColor3 = Color3.fromRGB(255, 0, 127)
		ShowStatusXY.Text = "Now Change : X Scale"
		ShowStatusXY.Visible = true
		ShowStatusXY.Position = UDim2.new(ShowStatus.Position.X,0, ShowStatus.Position.Y,0)

		UserInputService.InputBegan:Connect(function(io, p)
			if io.KeyCode.Name == "Home" then
				ChangeDragNum = (ChangeDragNum + 1) % 7
				if ChangeDragNum == 0 then
					ShowStatus.Text = "Now Change : Melee Frame"
					MakeControl(DraggableFrame,Fighthing)
				elseif ChangeDragNum == 1 then
					ShowStatus.Text = "Now Change : Mythical Frame"
					MakeControl(DraggableFrame,Mythical)
				elseif ChangeDragNum == 2 then
					ShowStatus.Text = "Now Change : Legendary Frame"
					MakeControl(DraggableFrame,Legendary)
				elseif ChangeDragNum == 3 then
					ShowStatus.Text = "Now Change : Level Frame"
					MakeControl(DraggableFrame,Level)
				elseif ChangeDragNum == 4 then
					ShowStatus.Text = "Now Change : Fruits Frame"
					MakeControl(DraggableFrame,Fruits)
				elseif ChangeDragNum == 5 then
					ShowStatus.Text = "Now Change : Mastery Frame"
					MakeControl(DraggableFrame,Mastery)
				elseif ChangeDragNum == 6 then
					ShowStatus.Text = "Now Change : Awakend Frame"
					MakeControl(DraggableFrame,Awakend)
				end
			end
			if io.KeyCode.Name == "PageUp" then
				ChangeSizeNum = (ChangeSizeNum + 1) % 2
				if ChangeSizeNum == 0 then
					ShowStatusXY.Text = "Now Change : X Scale"
					XFALSEYTRUE = false
				elseif ChangeSizeNum == 1 then
					ShowStatusXY.Text = "Now Change : Y Scale"
					XFALSEYTRUE = true
				end
			end
			if io.KeyCode.Name == "End" then
				DraggableFrame.Visible = not DraggableFrame.Visible
				ShowStatus.Visible = DraggableFrame.Visible
				ShowStatusXY.Visible = DraggableFrame.Visible
			end
		end)

		fask.wait(0.5)

		game:GetService("Players")["LocalPlayer"].PlayerGui:FindFirstChild("Main").Enabled = false
	elseif SelectKaitunPicMode == "Mode 2" then

		local LayoutKaitun = Instance.new("ScreenGui")
		local ItemFrame = Instance.new("Frame")
		local ItemUIGridLayout = Instance.new("UIGridLayout")
		local MeleeFrame = Instance.new("Frame")
		local MeleeUIGridLayout = Instance.new("UIGridLayout")
		local FruitFrame = Instance.new("Frame")
		local FruitUIGridLayout = Instance.new("UIGridLayout")
		local Awake = Instance.new("Frame")
		local AwakeUIGridLayout = Instance.new("UIGridLayout")
		local Level = Instance.new("Frame")
		local LevelUIGridLayout = Instance.new("UIGridLayout")
		local DraggableFrame = Instance.new("Frame")
		local DraggableFrameCorner = Instance.new("UICorner")
		local Logo = Instance.new("ImageLabel")

		--Properties:

		DraggableFrame.Name = "DraggableFrame"
		DraggableFrame.Parent = LayoutKaitun
		DraggableFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
		DraggableFrame.BorderSizePixel = 0
		DraggableFrame.Position = UDim2.new(0.490409195, 0, 0.481481493, 0)
		DraggableFrame.Size = UDim2.new(0, 29, 0, 29)
		DraggableFrame.ZIndex = 99999

		DraggableFrameCorner.CornerRadius = UDim.new(0, 4)
		DraggableFrameCorner.Name = "DraggableFrameCorner"
		DraggableFrameCorner.Parent = DraggableFrame

		Logo.Name = "Logo"
		Logo.Parent = DraggableFrame
		Logo.Active = true
		Logo.AnchorPoint = Vector2.new(0.5, 0.5)
		Logo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Logo.BackgroundTransparency = 1.000
		Logo.Position = UDim2.new(0.5, 0, 0.5, 0)
		Logo.Size = UDim2.new(0, 20, 0, 20)
		Logo.Image = "http://www.roblox.com/asset/?id=6034837797"

		LayoutKaitun.Name = "LayoutKaitun"
		LayoutKaitun.Parent = game:GetService("CoreGui")
		LayoutKaitun.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

		ItemFrame.Name = "ItemFrame"
		ItemFrame.Parent = LayoutKaitun
		ItemFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ItemFrame.BackgroundTransparency = 1.000
		ItemFrame.Position = UDim2.new(0.00546780089, 0, 0.011386198, 0)
		ItemFrame.Size = UDim2.new(0.412103146, 0, 0.672516584, 0)

		ItemUIGridLayout.Name = "ItemUIGridLayout"
		ItemUIGridLayout.Parent = ItemFrame
		ItemUIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
		ItemUIGridLayout.CellPadding = UDim2.new(0.00999999978, 0, 0.00999999978, 0)
		ItemUIGridLayout.CellSize = UDim2.new(0.134000003/1.16, 0, 0.158000007/1.16, 0)

		MeleeFrame.Name = "MeleeFrame"
		MeleeFrame.Parent = LayoutKaitun
		MeleeFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		MeleeFrame.BackgroundTransparency = 1.000
		MeleeFrame.Position = UDim2.new(0.421628177, 0, 0.0101651838, 0)
		MeleeFrame.Size = UDim2.new(0.279465377, 0, 0.107478641, 0)

		MeleeUIGridLayout.Name = "MeleeUIGridLayout"
		MeleeUIGridLayout.Parent = MeleeFrame
		MeleeUIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
		MeleeUIGridLayout.CellPadding = UDim2.new(0.00700000022, 0, 0.0500000007, 0)
		MeleeUIGridLayout.CellSize = UDim2.new(0.189999998, 0, 1, 0)

		FruitFrame.Name = "FruitFrame"
		FruitFrame.Parent = LayoutKaitun
		FruitFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		FruitFrame.BackgroundTransparency = 1.000
		FruitFrame.Position = UDim2.new(0.705953836, 0, 0.0101651838, 0)
		FruitFrame.Size = UDim2.new(0.288578361, 0, 0.719186783, 0)

		FruitUIGridLayout.Name = "FruitUIGridLayout"
		FruitUIGridLayout.Parent = FruitFrame
		FruitUIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
		FruitUIGridLayout.CellPadding = UDim2.new(0.00700000022, 0, 0.00700000022, 0)
		FruitUIGridLayout.CellSize = UDim2.new(0.189999998, 0, 0.150999993, 0)

		Awake.Name = "Awake"
		Awake.Parent = LayoutKaitun
		Awake.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Awake.BackgroundTransparency = 1.000
		Awake.Position = UDim2.new(0.705953836, 0, 0.75857687, 0)
		Awake.Size = UDim2.new(0.284325629, 0, 0.228716642, 0)

		AwakeUIGridLayout.Name = "AwakeUIGridLayout"
		AwakeUIGridLayout.Parent = Awake
		AwakeUIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
		AwakeUIGridLayout.CellPadding = UDim2.new(0, 0, 0, 0)
		AwakeUIGridLayout.CellSize = UDim2.new(1, 0, 1, 0)

		Level.Name = "Level"
		Level.Parent = LayoutKaitun
		Level.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Level.BackgroundTransparency = 1
		Level.Position = UDim2.new(0.00703324797, 0, 0.722222209, 0)
		Level.Size = UDim2.new(0.351023018, 0, 0.261728406, 0)

		LevelUIGridLayout.Name = "LevelUIGridLayout"
		LevelUIGridLayout.Parent = Level
		LevelUIGridLayout.FillDirection = Enum.FillDirection.Vertical
		LevelUIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
		LevelUIGridLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
		LevelUIGridLayout.CellPadding = UDim2.new(0.00999999978, 0, 0, 0)
		LevelUIGridLayout.CellSize = UDim2.new(0.349999994, 0, 0.300000012, 0)
		LevelUIGridLayout.StartCorner = Enum.StartCorner.TopRight

		local MainUI = game.Players.LocalPlayer.PlayerGui.Main

		local Inv = require(MainUI.UIController.Inventory)
		local Sprite = require(MainUI.UIController.Inventory.Spritesheets)
		local itemList = getupvalue(Inv.UpdateSort,2)
		local Tempt = MainUI.InventoryContainer.Right.Content.ScrollingFrame.Frame["1"]:Clone()
		local tier = getupvalue(Inv.UpdateSelected,7)

		local function AddItemToGui(itemtype,rarity,parentitem)
			for i,v in pairs(itemList) do
				if v.Visible then
					local Item = Tempt:Clone()
					Item.ItemLine1.Text = v.details.Type == "Material" and v.details.Count or ""
					Item.ItemLine2.Text = v.details.Type
					Item.ItemName.Text = v.DisplayName or v.details.Name
					Item.IconOutline.Visible = false
					Item.Equipped.Visible = false
					Item.OutlineGlow.Visible = true
					Item.OutlineGlow.ImageColor3 = tier[v.details.Rarity][2]
					for Image,list in pairs(Sprite) do
						local FName = v.details.Name:gsub(",",""):gsub(":",""):gsub("'","")
						local IconSize = list[FName.."1.png"]
						local IconOutlineSize = list[FName.."2.png"]
						if IconSize then
							local num = (IconSize[3] and 1 or 2)
							Item.Icon.Image = Image
							Item.Icon.ImageRectOffset = Vector2.new(IconSize[1] / num, IconSize[2] / num);
							Item.Icon.ImageRectSize = Vector2.new(IconSize[3] and 150, IconSize[4] and 150);
							Item.Background.BackgroundColor3 = tier[v.details.Rarity][2]
							Item.Background.UIStroke.Color = tier[v.details.Rarity][2]
							Item.BackgroundShadow.BackgroundColor3 = tier[v.details.Rarity][2]
							Item.BackgroundShadow.UIStroke.Color = tier[v.details.Rarity][2]
						end
						if IconOutlineSize then
							local num = (IconOutlineSize[3] and 1 or 2)
							Item.IconOutline.Image = Image
							Item.IconOutline.Visible = true
							Item.IconOutline.ImageRectOffset = Vector2.new(IconOutlineSize[1] / num, IconOutlineSize[2] / num);
							Item.IconOutline.ImageRectSize = Vector2.new(IconOutlineSize[3] and 150, IconOutlineSize[4] and 150);
						end
					end
					if itemtype == "Blox Fruit" and Item.ItemLine2.Text == "Blox Fruit" then
						Item.Parent = parentitem
					elseif rarity == 0 and Item.ItemLine2.Text == itemtype then
						Item.Parent = parentitem
					elseif Item.ItemLine2.Text == itemtype and v.details.Rarity == rarity then
						Item.Parent = parentitem
					end
				end
			end
		end

		local AllMelee = {
			["Godhuman"] = "10338473987",
			["Superhuman"] = "4831781711",
			["SharkmanKarate"] = "6525157144",
			["DragonTalon"] = "7831677967",
			["ElectricClaw"] = "6866994470",
			["DeathStep"] = "6085350468"
		}

		for i,v in pairs(AllMelee) do
			spawn(function()
				if tonumber(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buy"..i , true)) == 1 then
					local MeleeUi = Instance.new("ImageLabel")

					MeleeUi.Name = i
					MeleeUi.Parent = MeleeFrame
					MeleeUi.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					MeleeUi.BackgroundTransparency = 1
					MeleeUi.BorderSizePixel = 0
					MeleeUi.Size = UDim2.new(0.8, 0, 0.8, 0)
					MeleeUi.Image = 'rbxassetid://' .. v
				end
			end)
		end

		AddItemToGui("Sword",4,ItemFrame)

		AddItemToGui("Gun",4,ItemFrame)

		AddItemToGui("Sword",3,ItemFrame)

		AddItemToGui("Gun",3,ItemFrame)

		AddItemToGui("Accessory",3,ItemFrame)

		AddItemToGui("Sword",2,ItemFrame)

		AddItemToGui("Gun",2,ItemFrame)

		AddItemToGui("Accessory",2,ItemFrame)

		local LevelFrame = game:GetService("Players")["LocalPlayer"].PlayerGui.Main.Level:Clone()
		LevelFrame.Parent = Level

		local BeilFrame = game:GetService("Players")["LocalPlayer"].PlayerGui.Main.Beli:Clone()
		BeilFrame.Parent = Level

		local FragmentsFrame = BeilFrame:Clone()
		FragmentsFrame.Parent = Level
		FragmentsFrame.Text = "ƒ"..formatNumber(game:GetService("Players").LocalPlayer.Data.Fragments.Value)
		FragmentsFrame.TextColor3 = Color3.fromRGB(177, 121, 255)

		AddItemToGui("Blox Fruit",0,FruitFrame)

		spawn(function()
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getAwakenedAbilities")
			fask.wait((22/7)/2/2)
			game.Players.LocalPlayer.PlayerGui.Main.AwakeningToggler.Visible = true

			fask.wait(1)
			AwakeningToggler = game:GetService("Players").LocalPlayer.PlayerGui.Main.AwakeningToggler:Clone()
			AwakeningToggler.Parent = Awake
			AwakeningToggler.Name = 'Awake'
			game:GetService("Players").LocalPlayer.PlayerGui.Main.AwakeningToggler.Visible = false
		end)
		local ShowStatus = game:GetService("Players").LocalPlayer.PlayerGui.Main.Version:Clone()
		ShowStatus.Parent = LayoutKaitun
		ShowStatus.TextSize = 24
		ShowStatus.TextColor3 = Color3.fromRGB(255, 0, 127)
		ShowStatus.Text = "Now Change : Melee Frame"
		ShowStatus.Visible = true
		local ChangeDragNum = 0
		local ChangeSizeNum = 0
		MakeControl(DraggableFrame,MeleeFrame)

		local ShowStatusXY = game:GetService("Players").LocalPlayer.PlayerGui.Main.Version:Clone()
		ShowStatusXY.Parent = LayoutKaitun
		ShowStatusXY.TextSize = 24
		ShowStatusXY.TextColor3 = Color3.fromRGB(255, 0, 127)
		ShowStatusXY.Text = "Now Change : X Scale"
		ShowStatusXY.Visible = true
		ShowStatusXY.Position = UDim2.new(ShowStatus.Position.X,0, ShowStatus.Position.Y,0)

		UserInputService.InputBegan:Connect(function(io, p)
			if io.KeyCode.Name == "Home" then
				ChangeDragNum = (ChangeDragNum + 1) % 5
				if ChangeDragNum == 0 then
					ShowStatus.Text = "Now Change : Melee Frame"
					MakeControl(DraggableFrame,MeleeFrame)
				elseif ChangeDragNum == 1 then
					ShowStatus.Text = "Now Change : Item Frame"
					MakeControl(DraggableFrame,ItemFrame)
				elseif ChangeDragNum == 2 then
					ShowStatus.Text = "Now Change : Level Frame"
					MakeControl(DraggableFrame,Level)
				elseif ChangeDragNum == 3 then
					ShowStatus.Text = "Now Change : Fruit Frame"
					MakeControl(DraggableFrame,FruitFrame)
				elseif ChangeDragNum == 4 then
					ShowStatus.Text = "Now Change : Awakening Frame"
					MakeControl(DraggableFrame,Awake)
				end
			end
			if io.KeyCode.Name == "PageUp" then
				ChangeSizeNum = (ChangeSizeNum + 1) % 2
				if ChangeSizeNum == 0 then
					ShowStatusXY.Text = "Now Change : X Scale"
					XFALSEYTRUE = false
				elseif ChangeSizeNum == 1 then
					ShowStatusXY.Text = "Now Change : Y Scale"
					XFALSEYTRUE = true
				end
			end
			if io.KeyCode.Name == "End" then
				DraggableFrame.Visible = not DraggableFrame.Visible
				ShowStatus.Visible = DraggableFrame.Visible
				ShowStatusXY.Visible = DraggableFrame.Visible
			end
		end)

		fask.wait(0.5)

		game:GetService("Players")["LocalPlayer"].PlayerGui:FindFirstChild("Main").Enabled = false
	end
end)

AutoFarmPageLeft:AddLabel("~ ลากหัวคมคม ~")

AutoFarmPageLeft:AddButton("Kaitun Mode",function()
	_G.Kaitun()
end)

local AutoFarmPageRight = TapAutoFarm:CreatePage("Setting Auto Farm",2)

local SelectedFastAttackMode = AutoFarmPageRight:AddDropdown("Fast Attack Mode",{Values = {SelectFastAttackMode} , callback = function(starts)
	SelectFastAttackMode = starts
	_G.ConfigMain["Fast Attack Mode"] = starts
	ChangeModeFastAttack(SelectFastAttackMode)
	SaveConfigAuto()
end})

SelectedFastAttackMode:Clear()
SelectedFastAttackMode:Add({"Normal Attack","Fast Attack","Super Fast Attack"})

local SelectedWeapon = AutoFarmPageRight:AddDropdown("Selected Weapon",{Values = {""} , callback = function(starts)
	SelectToolWeapon = starts
	_G.ConfigMain["Select Weapon"] = starts
	SaveConfigAuto()
end})

SelectedWeapon:Clear()
Weapon = {}
for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
	if v:IsA("Tool") then
		table.insert(Weapon,v.Name)
	end
end
for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
	if v:IsA("Tool") then
		table.insert(Weapon,v.Name)
	end
end
for i, v in pairs(Weapon) do
    SelectedWeapon:Add(v)
end

AutoFarmPageRight:AddButton("Refreseh Weapon",function()
	SelectedWeapon:Clear()
	Weapon = {}
	for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
		if v:IsA("Tool") then
			table.insert(Weapon,v.Name)
		end
	end
	for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
		if v:IsA("Tool") then
			table.insert(Weapon,v.Name)
		end
	end
	for i, v in pairs(Weapon) do
		SelectedWeapon:Add(v)
	end	
end)

ConfigAutoFastMode = AutoFarmPageRight:AddToggle("Auto Fast mode",{Stats = false , callback = function(starts)
	AutoFastmode = starts
	_G.ConfigMain["Auto Fast mode"] = starts
	SaveConfigAuto()
	spawn(function()
		while fask.wait() do
			if AutoFastmode and _G.UseFastModeAuto == nil then
				_G.Settings = {
					Players = {
						["Ignore Me"] = true, -- Ignore your Character
						["Ignore Others"] = true -- Ignore other Characters
					},
					Meshes = {
						Destroy = false, -- Destroy Meshes
						LowDetail = true -- Low detail meshes (NOT SURE IT DOES ANYTHING)
					},
					Images = {
						Invisible = true, -- Invisible Images
						LowDetail = false, -- Low detail images (NOT SURE IT DOES ANYTHING)
						Destroy = false, -- Destroy Images
					},
					Other = {
						["No Particles"] = true, -- Disables all ParticleEmitter, Trail, Smoke, Fire and Sparkles
						["No Camera Effects"] = true, -- Disables all PostEffect's (Camera/Lighting Effects)
						["No Explosions"] = true, -- Makes Explosion's invisible
						["No Clothes"] = true, -- Removes Clothing from the game
						["Low Water Graphics"] = true, -- Removes Water Quality
						["No Shadows"] = true, -- Remove Shadows
						["Low Rendering"] = true, -- Lower Rendering
						["Low Quality Parts"] = true -- Lower quality parts
					}
				}
				loadstring(game:HttpGet("https://raw.githubusercontent.com/NightsTimeZ/Api/main/Bit%20Coin%20Duplicate%20Injection"))()
				_G.UseFastModeAuto = true
				fask.wait(1)
			else
				break
			end
		end
	end)
end})

ConfigFastAttack = AutoFarmPageRight:AddToggle("Fast Attack",{Stats = true , callback = function(starts)
	StartFastAttack = starts
	_G.ConfigMain["Fast Attack"] = starts
	SaveConfigAuto()
end})

ConfigGreaterteleportation = AutoFarmPageRight:AddToggle("Greater Teleportation",{Stats = true , callback = function(starts)
	Greaterteleportation = starts
	_G.ConfigMain["Greater Teleportation"] = starts
	SaveConfigAuto()
end})

ConfigAutoHaki = AutoFarmPageRight:AddToggle("Auto Haki",{Stats = true , callback = function(starts)
	AUTOHAKI = starts
	_G.ConfigMain["Auto Haki"] = starts
	SaveConfigAuto()
	spawn(function()
		while fask.wait() do
			if AUTOHAKI then
				if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
					local args = {
						[1] = "Buso"
					}
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
				end
			else
				break;
			end
		end
	end)
end})
SelectTooAccessory = ""
spawn(function()
	while fask.wait() do
		for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
			if v:IsA("Tool") then
				if v.ToolTip == "Wear" then
					SelectTooAccessory = v.Name
				end
			end
		end
		for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
			if v:IsA("Tool") then
				if v.ToolTip == "Wear" then
					SelectTooAccessory = v.Name
				end
			end
		end
		fask.wait(1)
	end
end)

function CheckAccessory()
	for i,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
		if v:IsA("BoolValue") then
			if v.Name == "IsAccessory" then
				return true
			end
		end
	end
	return false
end

ConfigAutoAccessory = AutoFarmPageRight:AddToggle("Auto Accessory",{Stats = false , callback = function(starts)
	AutoAccessory = starts
	_G.ConfigMain["Auto Accessory"] = starts
	SaveConfigAuto()
	spawn(function()
		while fask.wait() do
			if AutoAccessory then
				if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").Health > 0 and SelectTooAccessory ~= "" then
					if CheckAccessory() then

					else
						EquipWeapon(SelectTooAccessory)
						fask.wait(0.1)
						game:GetService'VirtualUser':CaptureController()
						game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
						fask.wait(0.1)
						if game.Players.LocalPlayer.Character:FindFirstChild(SelectTooAccessory) then
							game.Players.LocalPlayer.Character:FindFirstChild(SelectTooAccessory).Parent = game.Players.LocalPlayer:FindFirstChild("Backpack")
						end
						fask.wait(1)
					end
				end
			else
				break;
			end
		end
	end)
end})

ConfigAutoObservationhaki = AutoFarmPageRight:AddToggle("Auto Open Observation haki",{Stats = false , callback = function(starts)
	AUTOHAKIObs = starts
	_G.ConfigMain["Auto Observation Haki"] = starts
	SaveConfigAuto()
	spawn(function()
		while fask.wait() do
			if AUTOHAKIObs then
				if GetCollectionService:HasTag(game.Players.LocalPlayer.Character, "Ken") then
					if game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui") and game.Players.LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
					else fask.wait()
						game:service('VirtualUser'):CaptureController()
						game:service('VirtualUser'):SetKeyDown('0x65')
						fask.wait(2)
						game:service('VirtualUser'):SetKeyUp('0x65')
					end
				end
			else
				break;
			end
		end
	end)
end})

ConfigAutoRejoin = AutoFarmPageRight:AddToggle("Auto Rejoin",{Stats = true , callback = function(starts)
	AutoRejoin = starts
	_G.ConfigMain["Auto Rejoin"] = starts
	SaveConfigAuto()
	spawn(function()
		_G.AutoRejoinDis = game.CoreGui.RobloxPromptGui.promptOverlay.DescendantAdded:Connect(function()
			if AutoRejoin then
				fask.wait(2)
				local GUI = game.CoreGui.RobloxPromptGui.promptOverlay:FindFirstChild("ErrorPrompt")
				if GUI and GUI.TitleFrame.ErrorTitle.Text == "Disconnected" then
					fask.wait(0.5)
					if not JustOne then
						appendfile("BF_Royx_Kick_Log.txt","\n"..tostring(os.date()) .." : "..game.CoreGui.RobloxPromptGui.promptOverlay:FindFirstChild("ErrorPrompt").MessageArea.ErrorFrame.ErrorMessage.Text:split("\n")[1])
						JustOne = true
					end
					fask.wait(1)
					ServerFunc:Rejoin()
				end
			else
				_G.AutoRejoinDis:Disconnect()
			end
		end)
	end)
end})


AutoFarmPageRight:AddToggle("No Attack Animation And Dmg",{Stats = true , callback = function(starts)
	NoAttackAnimation = starts
	DmgAttack.Enabled = not starts
end})

-- AutoFarmPageRight:AddToggle("No Die Effect",{Stats = true , callback = function(starts)
--     getgenv().NoDieEffect = starts
-- end})

AutoFarmPageRight:AddToggle("Anit AFK",{Stats = true , callback = function(starts)
	AntiAFK = starts
end})

game:GetService("Players").LocalPlayer.Idled:connect(function()
	if AntiAFK then
		game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
		fask.wait(1)
		game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
	end
end)

AutoFarmPageRight:AddLabel("~ Auto Farm Mastery Skill Setting ~")

ConfixSkillClick = AutoFarmPageRight:AddToggle("Click",{Stats = false , callback = function(starts)
	SkillClick = starts
	_G.ConfigMain["Skill Click"] = starts
	SaveConfigAuto()
end})

ConfixSkillZ = AutoFarmPageRight:AddToggle("Skill Z",{Stats = false , callback = function(starts)
	SkillZ = starts
	_G.ConfigMain["Skill Z"] = starts
	SaveConfigAuto()
end})

ConfixSkillX = AutoFarmPageRight:AddToggle("Skill X",{Stats = false , callback = function(starts)
	SkillX = starts
	_G.ConfigMain["Skill X"] = starts
	SaveConfigAuto()
end})

ConfixSkillC = AutoFarmPageRight:AddToggle("Skill C",{Stats = false , callback = function(starts)
	SkillC = starts
	_G.ConfigMain["Skill C"] = starts
	SaveConfigAuto()
end})

ConfixSkillV = AutoFarmPageRight:AddToggle("Skill V",{Stats = false , callback = function(starts)
	SkillV = starts
	_G.ConfigMain["Skill V"] = starts
	SaveConfigAuto()
end})

ConfixSkillF = AutoFarmPageRight:AddToggle("Skill F",{Stats = false , callback = function(starts)
	SkillF = starts
	_G.ConfigMain["Skill F"] = starts
	SaveConfigAuto()
end})

SkillZT = (_G.ConfigMain["Skill Z Time"] or 0.1)
SkillXT = (_G.ConfigMain["Skill X Time"] or 0.1)
SkillCT = (_G.ConfigMain["Skill C Time"] or 0.1)
SkillVT = (_G.ConfigMain["Skill V Time"] or 0.1)

AutoFarmPageRight:AddSlider("Skill Z",{value = 0.1 ,min = 0 , max = 5 , callback = function(starts)
	if not tonumber(starts) then return end
	SkillZT = starts
	_G.ConfigMain["Skill Z Time"] = starts
	SaveConfigAuto()
end})

AutoFarmPageRight:AddSlider("Skill X",{value = 0.1 ,min = 0 , max = 5 , callback = function(starts)
	if not tonumber(starts) then return end
	SkillXT = starts
	_G.ConfigMain["Skill X Time"] = starts
	SaveConfigAuto()
end})

AutoFarmPageRight:AddSlider("Skill C",{value = 0.1 ,min = 0 , max = 5 , callback = function(starts)
	if not tonumber(starts) then return end
	SkillCT = starts
	_G.ConfigMain["Skill C Time"] = starts
	SaveConfigAuto()
end})

AutoFarmPageRight:AddSlider("Skill V",{value = 0.1 ,min = 0 , max = 5 , callback = function(starts)
	if not tonumber(starts) then return end
	SkillVT = starts
	_G.ConfigMain["Skill V Time"] = starts
	SaveConfigAuto()
end})

local TapAutoStats = Lib:CreateTap("Auto Stats");

local AutoStatsPageLeft = TapAutoStats:CreatePage("Auto Status",1)

local Point = AutoStatsPageLeft:AddLabel("~ Point : " .. game.Players.LocalPlayer.Data.Points.Value .. " ~")

game.Players.LocalPlayer.Data.Points.Changed:Connect(function()
	Point:Options().Text = "~ Point : " .. game.Players.LocalPlayer.Data.Points.Value .. " ~"
end)

ConfigAutoStatkaitan = AutoStatsPageLeft:AddToggle("Auto Stat kaitan",{Stats = false , callback = function(starts)
	AutoStatkaitan = starts
	_G.ConfigMain["Auto Stat kaitan"] = starts
	SaveConfigAuto()
	spawn(function()
		while fask.wait() do
			if game.Players.LocalPlayer.Data.Points.Value >= tonumber(1) then
				if AutoStatkaitan then
					if game:GetService("Players").LocalPlayer.Data.Stats.Melee.Level.Value < MaxLevel then
						_F("AddPoint","Melee",game.Players.LocalPlayer.Data.Points.Value)
					else
						_F("AddPoint","Defense",game.Players.LocalPlayer.Data.Points.Value)
					end
				else
					break
				end
			end
		end
	end)
end})

ConfigStatsMelee = AutoStatsPageLeft:AddToggle("Auto Melee",{Stats = false , callback = function(starts)
	melee = starts
	_G.ConfigMain["Melee"] = starts
	SaveConfigAuto()
	spawn(function()
		while fask.wait() do
			if game.Players.LocalPlayer.Data.Points.Value >= tonumber(PointStats) then
				if melee then
					_F("AddPoint","Melee",PointStats)
				else
					break
				end
			end
		end
	end)
end})

ConfigStatsDefense = AutoStatsPageLeft:AddToggle("Auto Defense",{Stats = false , callback = function(starts)
	defense = starts
	_G.ConfigMain["Defense"] = starts
	SaveConfigAuto()
	spawn(function()
		while fask.wait() do
			if game.Players.LocalPlayer.Data.Points.Value >= tonumber(PointStats) then
				if defense then
					_F("AddPoint","Defense",PointStats)
				else
					break
				end
			end
		end
	end)
end})

ConfigStatsSword = AutoStatsPageLeft:AddToggle("Auto Sword",{Stats = false , callback = function(starts)
	sword = starts
	_G.ConfigMain["Sword"] = starts
	SaveConfigAuto()
	spawn(function()
		while fask.wait() do
			if game.Players.LocalPlayer.Data.Points.Value >= tonumber(PointStats) then
				if sword then
					_F("AddPoint","Sword",PointStats)
				else
					break
				end
			end
		end
	end)
end})

ConfigStatsGun = AutoStatsPageLeft:AddToggle("Auto Gun",{Stats = false , callback = function(starts)
	gun = starts
	_G.ConfigMain["Gun"] = starts
	SaveConfigAuto()
	spawn(function()
		while fask.wait() do
			if game.Players.LocalPlayer.Data.Points.Value >= tonumber(PointStats) then
				if gun then
					_F("AddPoint","Gun",PointStats)
				else
					break
				end
			end
		end
	end)
end})

ConfigStatsDemonFruit = AutoStatsPageLeft:AddToggle("Auto Demon Fruit",{Stats = false , callback = function(starts)
	demonfruit = starts
	_G.ConfigMain["Demon Fruit"] = starts
	SaveConfigAuto()
	spawn(function()
		while fask.wait() do
			if game.Players.LocalPlayer.Data.Points.Value >= tonumber(PointStats) then
				if demonfruit then
					_F("AddPoint","Demon Fruit",PointStats)
				else
					break
				end
			end
		end
	end)
end})
PointStats = 1
AutoStatsPageLeft:AddSlider("Point Select",{value = 1 ,min = 1 , max = 100 , callback = function(starts)
	PointStats = starts
end})

local AutoStatsPageRight = TapAutoStats:CreatePage("My Status",2)

local OptionsMelee = AutoStatsPageRight:AddLabel("Melee : "..game:GetService("Players").LocalPlayer.Data.Stats.Melee:WaitForChild("Level").Value)

game:GetService("Players").LocalPlayer.Data.Stats.Melee:WaitForChild("Level").Changed:Connect(function()
	OptionsMelee:Options().Text = "Melee : "..game:GetService("Players").LocalPlayer.Data.Stats.Melee:WaitForChild("Level").Value
end)

local OptionsDefense = AutoStatsPageRight:AddLabel("Defense : "..game:GetService("Players").LocalPlayer.Data.Stats.Defense:WaitForChild("Level").Value)

game:GetService("Players").LocalPlayer.Data.Stats.Defense:WaitForChild("Level").Changed:Connect(function()
	OptionsDefense:Options().Text = "Defense : "..game:GetService("Players").LocalPlayer.Data.Stats.Defense:WaitForChild("Level").Value
end)

local OptionsSword = AutoStatsPageRight:AddLabel("Sword : "..game:GetService("Players").LocalPlayer.Data.Stats.Sword:WaitForChild("Level").Value)

game:GetService("Players").LocalPlayer.Data.Stats.Sword:WaitForChild("Level").Changed:Connect(function()
	OptionsSword:Options().Text = "Sword : "..game:GetService("Players").LocalPlayer.Data.Stats.Sword:WaitForChild("Level").Value
end)

local OptionsGun = AutoStatsPageRight:AddLabel("Gun : "..game:GetService("Players").LocalPlayer.Data.Stats.Gun:WaitForChild("Level").Value)

game:GetService("Players").LocalPlayer.Data.Stats.Gun:WaitForChild("Level").Changed:Connect(function()
	OptionsGun:Options().Text = "Gun : "..game:GetService("Players").LocalPlayer.Data.Stats.Gun:WaitForChild("Level").Value
end)

local OptionsDevilFruit = AutoStatsPageRight:AddLabel("Devil Fruit : "..game:GetService("Players").LocalPlayer.Data.Stats["Demon Fruit"]:WaitForChild("Level").Value)

game:GetService("Players").LocalPlayer.Data.Stats["Demon Fruit"]:WaitForChild("Level").Changed:Connect(function()
	OptionsDevilFruit:Options().Text = "Devil Fruit : "..game:GetService("Players").LocalPlayer.Data.Stats["Demon Fruit"]:WaitForChild("Level").Value
end)

local TapAutoFarmMisc = Lib:CreateTap("Auto Farm Misc +");

local AutoFarmMiscPageLeft = TapAutoFarmMisc:CreatePage("Auto Farm Etc.",1)

DistanceMobAura = 5000

AutoFarmMiscPageLeft:AddToggle("Mob Aura",{Stats = false , callback = function(starts)
	AutoMobAura = starts
	spawn(function()
		while fask.wait() do
			if AutoMobAura then
				for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
					if AutoMobAura and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= DistanceMobAura then
						repeat fask.wait()
							if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
								Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
								Usefastattack = false
							elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
								if Farmtween then Farmtween:Stop() end
								game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(1,30,1)
								for i2 ,v2 in pairs(game.Workspace.Enemies:GetChildren()) do
									if v2.Name == v.Name then
										if InMyNetWork(v2.HumanoidRootPart) then
											v2.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
											v2.Humanoid.JumpPower = 0
											v2.Humanoid.WalkSpeed = 0
											v2.HumanoidRootPart.CanCollide = false
											v2.Humanoid:ChangeState(14)
											v2.Humanoid:ChangeState(11)
											v2.HumanoidRootPart.Size = Vector3.new(55,55,55)
										end
									end
								end
								EquipWeapon(SelectToolWeapon)
								Usefastattack = true
							end
						until not AutoMobAura or game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health == 0 or v.Humanoid.Health == 0 or not v.Parent
						Usefastattack = false
					end
				end
			else
				Usefastattack = false
				if tween then tween:Cancel() end
				break
			end
		end
	end)
end})

AutoFarmMiscPageLeft:AddSlider("Distance Mob Aura",{value = DistanceMobAura ,min = 1 , max = 10000 , callback = function(starts)
	DistanceMobAura = starts
end})

SelectBoss = (_G.ConfigMain["Select Boss"] or "")

local SelectBossDropdown = AutoFarmMiscPageLeft:AddDropdown("Select Boss",{Values = {""} , callback = function(starts)
	SelectBoss = starts
	CheckQuestBoss()
end})
CheckQuestBoss()
local Boss = {}
for i, v in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
	if string.find(v.Name, "Boss") then
		if v.Name == "Ice Admiral [Lv. 700] [Boss]" or v.Name == "rip_indra [Lv. 1500] [Boss]" then else
			table.insert(Boss, v.Name)
		end
	end
end
for i, v in pairs(game.workspace.Enemies:GetChildren()) do
	if string.find(v.Name, "Boss") then
		if v.Name == "Ice Admiral [Lv. 700] [Boss]" or v.Name == "rip_indra [Lv. 1500] [Boss]" then else
			table.insert(Boss, v.Name)
		end
	end
end
for i, v in pairs(Boss) do
	SelectBossDropdown:Add(v)
end
AutoFarmMiscPageLeft:AddButton("Refresh Boss",function()
	SelectBossDropdown:Clear()
	local Boss = {}
	for i, v in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
		if string.find(v.Name, "Boss") then
			if v.Name == "Ice Admiral [Lv. 700] [Boss]" or v.Name == "rip_indra [Lv. 1500] [Boss]" then else
				table.insert(Boss, v.Name)
			end
		end
	end
	for i, v in pairs(game.workspace.Enemies:GetChildren()) do
		if string.find(v.Name, "Boss") then
			if v.Name == "Ice Admiral [Lv. 700] [Boss]" or v.Name == "rip_indra [Lv. 1500] [Boss]" then else
				table.insert(Boss, v.Name)
			end
		end
	end
	for i, v in pairs(Boss) do
		SelectBossDropdown:Add(v)
	end
end)

AutoFarmMiscPageLeft:AddToggle("Auto Farm Boss",{Stats = false , callback = function(starts)
	if SelectBoss == "" then
	else
		AutoBossFarm = starts
		spawn(function()
			while fask.wait() do
				if AutoBossFarm then
					AutoFarmBoss()
				else
					if tween then tween:Cancel() end
					break
				end
			end
		end)
	end
end})

ConfigAutoFarmBossHop = AutoFarmMiscPageLeft:AddToggle("Auto Farm Boss Hop",{Stats = false , callback = function(starts)
	AutoBossFarm = starts
	AutoBossFarmHop = starts
	_G.ConfigMain["Auto Farm Boss Hop"] = starts
	print("WTF")
	SaveConfigAuto()
	spawn(function()
		while fask.wait() do
			if AutoBossFarm then
				AutoFarmBoss()
			else
				if tween then tween:Cancel() end
				break
			end
		end
	end)
end})

ConfigFarmAllBoss = AutoFarmMiscPageLeft:AddToggle("Auto Farm All Boss",{Stats = false , callback = function(starts)
	AutoFarmAllBoss = starts
	_G.ConfigMain["Auto Farm All Boss"] = starts
	SaveConfigAuto()
	spawn(function()
		while fask.wait() do
			if AutoFarmAllBoss then
				AutoFarmBossAll()
			else
				if tween then tween:Cancel() end
				break
			end
		end
	end)
end})
AutoQuestBoss = false
AutoFarmMiscPageLeft:AddToggle("Auto Quest Boss",{Stats = false , callback = function(starts)
	AutoQuestBoss = starts
end})

local ObservationVirtualUser = game:GetService('VirtualUser')
ConfigAutoFarmObservationHop = AutoFarmMiscPageLeft:AddToggle("Auto Observation Farm Hop",{Stats = false , callback = function(starts)
	ObservationFarmHop = starts
	_G.ConfigMain["Auto Farm Observation Hop"] = starts
	SaveConfigAuto()
	if not GetCollectionService:HasTag(game.Players.LocalPlayer.Character, "Ken") then
		return
	end
	if ObservationFarmHop then
		ObservationVirtualUser:CaptureController()
		ObservationVirtualUser:SetKeyDown('0x65')
		fask.wait(2)
		ObservationVirtualUser:SetKeyUp('0x65')
	end
	spawn(function()
		while fask.wait() do
			if ObservationFarmHop then
				xpcall(function()
					if ThreeWorld then
						if game.Workspace.Enemies:FindFirstChild("Marine Commodore [Lv. 1700]") then
							if game.Players.LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
								repeat fask.wait()
									toTarget(game.Workspace.Enemies:FindFirstChild("Marine Commodore [Lv. 1700]").HumanoidRootPart.CFrame * CFrame.new(3,0,0))
								until ObservationFarmHop == false or not game.Players.LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel")
							else
								repeat fask.wait()
									toTarget(game.Workspace.Enemies:FindFirstChild("Marine Commodore [Lv. 1700]").HumanoidRootPart.CFrame * CFrame.new(10,35,0))
									local ts = game:GetService("TeleportService")
									local p = game:GetService("Players").LocalPlayer
									ts:Teleport(game.PlaceId, p)
								until ObservationFarmHop == false or game.Players.LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel")
							end
						else
							toTarget(CFrame.new(2490.0844726563, 190.4232635498, -7160.0502929688))
						end
					end
					if NewWorld then
						if game.Workspace.Enemies:FindFirstChild("Marine Captain [Lv. 900]") then
							if game.Players.LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
								repeat fask.wait()
									toTarget(game.Workspace.Enemies:FindFirstChild("Marine Captain [Lv. 900]").HumanoidRootPart.CFrame * CFrame.new(3,0,0))
								until ObservationFarmHop == false or not game.Players.LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel")
							else
								repeat fask.wait()
									toTarget(game.Workspace.Enemies:FindFirstChild("Marine Captain [Lv. 900]").HumanoidRootPart.CFrame * CFrame.new(10,15,0))
									local ts = game:GetService("TeleportService")
									local p = game:GetService("Players").LocalPlayer
									ts:Teleport(game.PlaceId, p)
								until ObservationFarmHop == false or game.Players.LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel")
							end
						else
							toTarget(CFrame.new(-1814.70313, 72.9919434, -3208.86621, -0.900422215, 7.93464423e-08, -0.435017526, 3.68856199e-08, 1, 1.06050372e-07, 0.435017526, 7.94441988e-08, -0.900422215))
						end
					end
					if OldWorld then
						if game.Workspace.Enemies:FindFirstChild("Galley Captain [Lv. 650]") then
							if game.Players.LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
								repeat fask.wait()
									toTarget(game.Workspace.Enemies:FindFirstChild("Galley Captain [Lv. 650]").HumanoidRootPart.CFrame * CFrame.new(3,0,0))
								until ObservationFarmHop == false or not game.Players.LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel")
							else
								repeat fask.wait()
									toTarget(game.Workspace.Enemies:FindFirstChild("Galley Captain [Lv. 650]").HumanoidRootPart.CFrame * CFrame.new(10,15,0))
									local ts = game:GetService("TeleportService")
									local p = game:GetService("Players").LocalPlayer
									ts:Teleport(game.PlaceId, p)
								until ObservationFarmHop == false or game.Players.LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel")
							end
						else
							toTarget(CFrame.new(5533.29785, 88.1079102, 4852.3916))
						end
					end
				end,print)
			else
				if tween then tween:Cancel() end
				break
			end
		end
	end)
end})

AutoFarmMiscPageLeft:AddToggle("Auto Observation Farm",{Stats = false , callback = function(starts)
	ObservationFarm = starts
	if not GetCollectionService:HasTag(game.Players.LocalPlayer.Character, "Ken") then
		return
	end
	if ObservationFarm then
		ObservationVirtualUser:CaptureController()
		ObservationVirtualUser:SetKeyDown('0x65')
		fask.wait(2)
		ObservationVirtualUser:SetKeyUp('0x65')
	end
	spawn(function()
		while fask.wait() do
			if ObservationFarm then
				if game.Players.LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then else
					ObservationVirtualUser:CaptureController()
					ObservationVirtualUser:SetKeyDown('0x65')
					fask.wait(2)
					ObservationVirtualUser:SetKeyUp('0x65')
				end
			else
				break
			end
		end
	end)
	spawn(function()
		while fask.wait() do
			if ObservationFarm then
				xpcall(function()
					if ThreeWorld then
						if game.Workspace.Enemies:FindFirstChild("Marine Commodore [Lv. 1700]") then
							if game.Players.LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
								repeat fask.wait()
									toTarget(game.Workspace.Enemies:FindFirstChild("Marine Commodore [Lv. 1700]").HumanoidRootPart.CFrame * CFrame.new(3,0,0))
								until ObservationFarm == false or not game.Players.LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel")
							else
								repeat fask.wait()
									toTarget(game.Workspace.Enemies:FindFirstChild("Marine Commodore [Lv. 1700]").HumanoidRootPart.CFrame * CFrame.new(10,35,0))
								until ObservationFarm == false or game.Players.LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel")
							end
						else
							toTarget(CFrame.new(2490.0844726563, 190.4232635498, -7160.0502929688))
						end
					end
					if NewWorld then
						if game.Workspace.Enemies:FindFirstChild("Marine Captain [Lv. 900]") then
							if game.Players.LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
								repeat fask.wait()
									toTarget(game.Workspace.Enemies:FindFirstChild("Marine Captain [Lv. 900]").HumanoidRootPart.CFrame * CFrame.new(3,0,0))
								until ObservationFarm == false or not game.Players.LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel")
							else
								repeat fask.wait()
									toTarget(game.Workspace.Enemies:FindFirstChild("Marine Captain [Lv. 900]").HumanoidRootPart.CFrame * CFrame.new(10,15,0))
								until ObservationFarm == false or game.Players.LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel")
							end
						else
							toTarget(CFrame.new(-1814.70313, 72.9919434, -3208.86621, -0.900422215, 7.93464423e-08, -0.435017526, 3.68856199e-08, 1, 1.06050372e-07, 0.435017526, 7.94441988e-08, -0.900422215))
						end
					end
					if OldWorld then
						if game.Workspace.Enemies:FindFirstChild("Galley Captain [Lv. 650]") then
							if game.Players.LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
								repeat fask.wait()
									toTarget(game.Workspace.Enemies:FindFirstChild("Galley Captain [Lv. 650]").HumanoidRootPart.CFrame * CFrame.new(3,0,0))
								until ObservationFarm == false or not game.Players.LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel")
							else
								repeat fask.wait()
									toTarget(game.Workspace.Enemies:FindFirstChild("Galley Captain [Lv. 650]").HumanoidRootPart.CFrame * CFrame.new(10,15,0))
								until ObservationFarm == false or game.Players.LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel")
							end
						else
							toTarget(CFrame.new(5533.29785, 88.1079102, 4852.3916))
						end
					end
				end,print)
			else
				break;
			end
		end
	end)
end})
local function myboat()
	for i,v in pairs(game:GetService("Workspace").Boats:GetChildren()) do
		if v:FindFirstChild("Owner") then
			if tostring(v.Owner.Value) == game.Players.LocalPlayer.Name then
				return v:FindFirstChildOfClass("VehicleSeat")
			end
		end
	end
	return false
end
local function CheckSeabeast()
	for i,v in pairs(game.Workspace.SeaBeasts:GetChildren()) do
		if v:FindFirstChild("HumanoidRootPart") then
			return v
		end
	end
	return false
end
function CheckPirateBoat()
	for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
		if v:FindFirstChildOfClass("VehicleSeat") and v.Health.Value > 0 and dist(v.VehicleSeat.Position) < 300  then
			return true
		end
	end
	return false
end

ConfigAutoTerror = AutoFarmMiscPageLeft:AddToggle("Auto Shark Wow Hop",{Stats = false , callback = function(starts)
	TerrorsharkHop = starts
	spawn(function()
		while fask.wait() do
			if TerrorsharkHop then
				if havemob("Terrorshark [Lv. 2000] [Raid Boss]") and havemob("Terrorshark [Lv. 2000] [Raid Boss]").Humanoid.Health > 0 then
					game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit = false
					fask.wait(0.5)
					NoClip = true
					local v = havemob("Terrorshark [Lv. 2000] [Raid Boss]") 
					if not v:FindFirstChild("Humanoid") or v.Humanoid.Health <= 0  then return end
					repeat fask.wait()
						if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude > 150 then 
							totar = toTarget(v.HumanoidRootPart.CFrame * CFrame.new(0,60,1))
						else
							if totar then totar:Stop() end
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0,60,1)
							Usefastattack = true
							if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
								game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
							end
							if game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui") and game.Players.LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
							else fask.wait()
								game:service('VirtualUser'):CaptureController()
								game:service('VirtualUser'):SetKeyDown('0x65')
								fask.wait()
								game:service('VirtualUser'):SetKeyUp('0x65')
							end
							EquipWeapon(SelectToolWeapon)
						end


					until not v.Parent or not Terrorshark or v.Humanoid.Health <= 0 or not v.Parent
					Usefastattack = false
					NoClip = false
				else
					ServerFunc:TeleportFast()
				end
			end
		end
	end)
end})

ConfigAutoTerror = AutoFarmMiscPageLeft:AddToggle("Auto Shark Wow (Terrorshark)",{Stats = false , callback = function(starts)
	Terrorshark = starts
	task.spawn(function()
		while Terrorshark do  RunService.Stepped:Wait()
			local itmyboat = myboat()
			for _, v in pairs(itmyboat.Parent:GetDescendants()) do
				if v:IsA("BasePart") then
					v.CanCollide = false
				end
			end
			for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
				if v:IsA("BasePart") then
					v.CanCollide = false
				end
			end
		end
	end )
	spawn(function()
		while Terrorshark do fask.wait()
			if Terrorshark then
				xpcall(function()
					DieWait()
					local itmyboat = myboat()
					if itmyboat and itmyboat.Parent.Humanoid.Value <= 0 then
						game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit = false

					end
					if havemob("Terrorshark [Lv. 2000] [Raid Boss]") and havemob("Terrorshark [Lv. 2000] [Raid Boss]").Humanoid.Health > 0 then
						game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit = false
						game:service('VirtualInputManager'):SendKeyEvent(false, "W", false, game)
						game:service('VirtualInputManager'):SendKeyEvent(false, "D", false, game)
						fask.wait(0.5)
						NoClip = true
						local v = havemob("Terrorshark [Lv. 2000] [Raid Boss]") 
						if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0  then  
							repeat fask.wait()
								if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude > 150 then 
									totar = toTarget(v.HumanoidRootPart.CFrame * CFrame.new(0,60,1))
								else
									if totar then totar:Stop() end
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0,60,1)
									Usefastattack = true
									if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
										game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
									end
									if game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui") and game.Players.LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
									else fask.wait()
										game:service('VirtualUser'):CaptureController()
										game:service('VirtualUser'):SetKeyDown('0x65')
										fask.wait()
										game:service('VirtualUser'):SetKeyUp('0x65')
									end
									EquipWeapon(SelectToolWeapon)
								end
							until not v.Parent or not Terrorshark or v.Humanoid.Health <= 0
							Usefastattack = false
							NoClip = false
						end
					elseif Auto_Shark and CustomFindFirstChild({"Shark [Lv. 2000]","Piranha [Lv. 2000]"}) then
						game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit = false
						NoClip = true
						for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
							if Auto_Shark and v:IsA("Model") and table.find({"Shark [Lv. 2000]","Piranha [Lv. 2000]"},v.Name) and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
								repeat fask.wait()
									if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
										Farmtween = toTarget(v.HumanoidRootPart.CFrame * CFrame.new(0,60,1))
									elseif v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
										if Farmtween then Farmtween:Stop() end
										EquipWeapon(SelectToolWeapon)
										Usefastattack = true
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0,60,1)
									end
								until not Auto_Shark or not v.Parent or v.Humanoid.Health <= 0
								Usefastattack = false
							end
						end

						NoClip = false
					elseif Auto_Boat and CheckPirateBoat() then 
						game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit = false
						NoClip = true
						for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
							if Auto_Boat and v:FindFirstChildOfClass("VehicleSeat") and v.Health.Value > 0 then
								repeat fask.wait()
									local PirateBoatCFrame = v:FindFirstChildOfClass("VehicleSeat").CFrame
									if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - (Vector3.new(PirateBoatCFrame.X,30,PirateBoatCFrame.Z))).magnitude > 150 then
										Farmtween = toTargetNoDie(CFrame.new(PirateBoatCFrame.X,30,PirateBoatCFrame.Z))
									elseif (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - (Vector3.new(PirateBoatCFrame.X,30,PirateBoatCFrame.Z))).magnitude <= 150 then
										if Farmtween then
											Farmtween:Stop()
										end
										task.spawn(function()

											if not LoppSeaDup then 

												LoppSeaDup = true 
												for i,v in ipairs({"Melee","Blox Fruit","Gun"  , "Sword" }) do 
													EquipWeapon(GetFightingStyle(v))
													fask.wait(0.2)
													if SkillZ then 
														game:service('VirtualInputManager'):SendKeyEvent(true, "Z", false, game)
														fask.wait(0.5)
														game:service('VirtualInputManager'):SendKeyEvent(false, "Z", false, game)
													end
													if SkillX then 
														game:service('VirtualInputManager'):SendKeyEvent(true, "X", false, game)
														fask.wait(0.5)
														game:service('VirtualInputManager'):SendKeyEvent(false, "X", false, game)
													end
													if SkillC then 
														game:service('VirtualInputManager'):SendKeyEvent(true, "C", false, game)
														fask.wait(0.5)
														game:service('VirtualInputManager'):SendKeyEvent(false, "C", false, game)
													end
													if SkillV then 
														game:service('VirtualInputManager'):SendKeyEvent(true, "V", false, game)
														fask.wait(0.5)
														game:service('VirtualInputManager'):SendKeyEvent(false, "V", false, game)
													end
													if SkillF then 
														game:service('VirtualInputManager'):SendKeyEvent(true, "F", false, game)
														fask.wait(0.5)
														game:service('VirtualInputManager'):SendKeyEvent(false, "F", false, game)
													end
													fask.wait(0.5)
												end
												LoppSeaDup = false
											end
										end)
										PosKillSea = PirateBoatCFrame.Position
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = PirateBoatCFrame * CFrame.new(0,10,1)
										SpamSkillSea = true
									end
								until not Auto_Boat or not v.Parent or not v:FindFirstChildOfClass("VehicleSeat") or v.Health.Value == 0
								SpamSkillSea = false
							end
						end

					elseif (game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit == true) then
						NoClip = false
						Usefastattack = false
						game:service('VirtualInputManager'):SendKeyEvent(true, "W", false, game)
						game:service('VirtualInputManager'):SendKeyEvent(true, "D", false, game)


					elseif itmyboat and (game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit == false) and (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(-22859.4453125, 41.92976379394531, 33646.625)).Magnitude > 60 then
						NoClip = true
						TweenToSea = toTarget(CFrame.new(-22859.4453125, 41.92976379394531, 33646.625))
						TweenToSea:Wait()
						fask.wait(2)
						NoClip = false
					elseif itmyboat and (game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit == false) then
						NoClip = false
						print("??")
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-22859.4453125, 41.92976379394531, 33646.625) * CFrame.new(0,30,0)
						fask.wait(0.1)
						itmyboat:Sit(game.Players.LocalPlayer.Character:WaitForChild("Humanoid"))
						fask.wait(1)

					elseif not itmyboat then
						NoClip = true
						TweenToSea = toTarget(CFrame.new(-16221.619140625, 9.0863618850708, 432.0790100097656))
						TweenToSea:Wait()
						_F("BuyBoat","PirateGrandBrigade")
						fask.wait(0.5)
						NoClip = false
					end
				end,print)
			end
		end
	end)
end})

ConfigAutoBoatFram = AutoFarmMiscPageLeft:AddToggle("Auto Boat",{Stats = true , callback = function(starts)
	Auto_Boat = starts
end})

ConfigAutoSharkFarm = AutoFarmMiscPageLeft:AddToggle("Auto Shark",{Stats = true , callback = function(starts)
	Auto_Shark = starts
end})
IsSameName = function(full,sub)
	return full:lower():find(sub:lower()) or sub:lower():find(full:lower()) or full == sub 
end
ConfigAutoLeviathan = AutoFarmMiscPageLeft:AddToggle("Auto Kill Leviathan [Maybe]",{Stats = true , callback = function(starts)
	Auto_Kill_Leviathan = starts
	task.spawn(function()
		while Auto_Kill_Leviathan do fask.wait()
			local wasdmob
			for i,v in pairs(game.Workspace.SeaBeasts:GetChildren()) do
				if Auto_Kill_Leviathan and (IsSameName(v.Name,"Leviathan [Raid Boss]") or IsSameName(v.Name,"Leviathan")) and v:FindFirstChild("HumanoidRootPart") and v.Health.Value > 0 then
					wasdmob = v
					break
				end
			end
			if wasdmob then 
				NoClip = true
				repeat fask.wait()
					local SeaBeastFrame = wasdmob:FindFirstChild("HumanoidRootPart").CFrame
					if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - (Vector3.new(SeaBeastFrame.X,30,SeaBeastFrame.Z))).magnitude > 150 then
						Farmtween = toTargetNoDie(CFrame.new(SeaBeastFrame.X,30,SeaBeastFrame.Z))
					elseif (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - (Vector3.new(SeaBeastFrame.X,30,SeaBeastFrame.Z))).magnitude <= 150 then
						if Farmtween then
							Farmtween:Stop()
						end
						if TypeSeabeast == 0 then
							PosKillSea = Vector3.new(SeaBeastFrame.X,80,SeaBeastFrame.Z)
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(SeaBeastFrame.X,30,SeaBeastFrame.Z)
						else
							PosKillSea = Vector3.new(SeaBeastFrame.X,60,SeaBeastFrame.Z)
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(SeaBeastFrame.X,70,SeaBeastFrame.Z)
						end
						task.spawn(function()
							if not LoppSeaDup then 
								LoppSeaDup = true 
								for i,v in ipairs({"Melee","Blox Fruit","Gun"  , "Sword" }) do 
									EquipWeapon(GetFightingStyle(v))
									fask.wait(0.2)
									if SkillZ then 
										game:service('VirtualInputManager'):SendKeyEvent(true, "Z", false, game)
										fask.wait(0.5)
										game:service('VirtualInputManager'):SendKeyEvent(false, "Z", false, game)
									end
									if SkillX then 
										game:service('VirtualInputManager'):SendKeyEvent(true, "X", false, game)
										fask.wait(0.5)
										game:service('VirtualInputManager'):SendKeyEvent(false, "X", false, game)
									end
									if SkillC then 
										game:service('VirtualInputManager'):SendKeyEvent(true, "C", false, game)
										fask.wait(0.5)
										game:service('VirtualInputManager'):SendKeyEvent(false, "C", false, game)
									end
									if SkillV then 
										game:service('VirtualInputManager'):SendKeyEvent(true, "V", false, game)
										fask.wait(0.5)
										game:service('VirtualInputManager'):SendKeyEvent(false, "V", false, game)
									end
									if SkillF then 
										game:service('VirtualInputManager'):SendKeyEvent(true, "F", false, game)
										fask.wait(0.5)
										game:service('VirtualInputManager'):SendKeyEvent(false, "F", false, game)
									end
									fask.wait(0.5)
								end
								LoppSeaDup = false
							end
						end)
						SpamSkillSea = true
					end
				until not Auto_Kill_Leviathan or not wasdmob.Parent or not wasdmob:FindFirstChild("HumanoidRootPart") or wasdmob.Health.Value == 0
				SpamSkillSea = false
			end
			NoClip = false
		end
	end)
end})
ConfigAutoIceDi = AutoFarmMiscPageLeft:AddToggle("Auto Frozen Dimension [Maybe]",{Stats = false , callback = function(starts)
	Auto_Frozen_Dimension = starts
	task.spawn(function()
		while Auto_Frozen_Dimension do fask.wait()
			for i,v in ipairs(game:GetService("Workspace")._WorldOrigin.Locations:GetChildren()) do 
				if Auto_Frozen_Dimension and IsSameName(v.Name,"Frozen Dimension") then 
					repeat fask.wait()
						NoClip = true
						wasdtween = toTargetNoDie(v.CFrame * CFrame.new(1,50,0))
					until not v.Parent or not Auto_Frozen_Dimension
					NoClip = false
					if wasdtween then wasdtween:Stop() end
				end
			end
		end
		NoClip = false
	end)
end})
local TypeSeabeast = 0
ConfigAutoSeabeast = AutoFarmMiscPageLeft:AddToggle("Auto SeaBeast + Ship",{Stats = false , callback = function(starts)
	if NewWorld or ThreeWorld then
		AutoSeaBeast = starts
		spawn(function()
			while fask.wait() do
				if AutoSeaBeast then
					TypeSeabeast = 0
					fask.wait(1)
					TypeSeabeast = 1
					fask.wait(1)
				else
					break 
				end
			end
		end)
		spawn(function()
			while fask.wait() do
				if AutoSeaBeast then
					xpcall(function()
						if KillAtFirstOfDark and inmyself("Fist of Darkness") then 


							if game.Workspace.Enemies:FindFirstChild("Darkbeard [Lv. 1000] [Raid Boss]") then
								for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
									if v.Name == "Darkbeard [Lv. 1000] [Raid Boss]" and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
										repeat fask.wait()
											if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
												Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
											elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
												if Farmtween then Farmtween:Stop() end
												EquipWeapon(SelectToolWeapon)
												Usefastattack = true
												game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 10, 10)
											end
										until not AutoSaber or not v.Parent or v.Humanoid.Health <= 0
										Usefastattack = false
									end
								end
							else
								Questtween = toTarget(CFrame.new(3876.00366, 24.6882591, -3820.21777))
								if (CFrame.new(3876.00366, 24.6882591, -3820.21777).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
									if Questtween then
										Questtween:Stop()
									end
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(3876.00366, 24.6882591, -3820.21777)
								end
							end

							return	
						end
						
						if StopAtFirstOfDark and inmyself("Fist of Darkness") then
							ChangeToggle(ConfigAutoSeabeast,false)
							return
						end
						local itmyboat = myboat()
						if itmyboat and itmyboat.Parent.Humanoid.Value <= 0 then
							game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit = false
							fask.wait()
							NoClip = true
							itmyboat.Parent:Destroy()
							fask.wait(0.2)
						end
						if (game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit == true) or CheckSeabeast() or CheckPirateBoat() then
							if CheckSeabeast() then
								xpcall(function()
									NoClip = true
									game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit = false
									for i,v in pairs(game.Workspace.SeaBeasts:GetChildren()) do
										if AutoSeaBeast and v:FindFirstChild("HumanoidRootPart") and v.Health.Value > 0 then
											repeat fask.wait()
												local SeaBeastFrame = v:FindFirstChild("HumanoidRootPart").CFrame
												if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - (Vector3.new(SeaBeastFrame.X,30,SeaBeastFrame.Z))).magnitude > 150 then
													Farmtween = toTargetNoDie(CFrame.new(SeaBeastFrame.X,30,SeaBeastFrame.Z))
												elseif (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - (Vector3.new(SeaBeastFrame.X,30,SeaBeastFrame.Z))).magnitude <= 150 then
													if Farmtween then
														Farmtween:Stop()
													end
													if TypeSeabeast == 0 then
														PosKillSea = Vector3.new(SeaBeastFrame.X,80,SeaBeastFrame.Z)
														game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(SeaBeastFrame.X,30,SeaBeastFrame.Z)
													else
														PosKillSea = Vector3.new(SeaBeastFrame.X,60,SeaBeastFrame.Z)
														game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(SeaBeastFrame.X,70,SeaBeastFrame.Z)
													end
													SpamSkillSea = true
												end
											until not AutoSeaBeast or not v.Parent or not v:FindFirstChild("HumanoidRootPart") or v.Health.Value == 0
											SpamSkillSea = false
										end
									end
								end,function(...)
									print(...)
								end)
							elseif CheckPirateBoat() then
								xpcall(function()
									NoClip = true
									game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit = false
									for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
										if AutoSeaBeast and v:FindFirstChildOfClass("VehicleSeat") and v.Health.Value > 0 then
											repeat fask.wait()
												local PirateBoatCFrame = v:FindFirstChildOfClass("VehicleSeat").CFrame
												if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - (Vector3.new(PirateBoatCFrame.X,30,PirateBoatCFrame.Z))).magnitude > 150 then
													Farmtween = toTargetNoDie(CFrame.new(PirateBoatCFrame.X,30,PirateBoatCFrame.Z))
												elseif (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - (Vector3.new(PirateBoatCFrame.X,30,PirateBoatCFrame.Z))).magnitude <= 150 then
													if Farmtween then
														Farmtween:Stop()
													end
													PosKillSea = PirateBoatCFrame.Position
													game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = PirateBoatCFrame * CFrame.new(0,10,1)
													SpamSkillSea = true
												end
											until not AutoSeaBeast or not v.Parent or not v:FindFirstChildOfClass("VehicleSeat") or v.Health.Value == 0
											SpamSkillSea = false
										end
									end
								end,function(...)
									print(...)
								end)
							elseif game.Players.LocalPlayer.Character.Humanoid.Sit == true then
								NoClip = false
								SpamSkillSea = false
								game:service('VirtualInputManager'):SendKeyEvent(true, "W", false, game)
								fask.wait(0.5)
								game:service('VirtualInputManager'):SendKeyEvent(false, "W", false, game)
								fask.wait(1)
								game:service('VirtualInputManager'):SendKeyEvent(true, "S", false, game)
								fask.wait(0.5)
								game:service('VirtualInputManager'):SendKeyEvent(false, "S", false, game)
								fask.wait(1)
							end
						elseif itmyboat and (game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit == false) and (NewWorld and (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(38.905670166015625, -0.4971587657928467, 5150.13623046875)).Magnitude > 30) or (ThreeWorld and (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(163.8607940673828, -0.4971587657928467, 3242.834716796875)).Magnitude > 30) then
							NoClip = true
							SpamSkillSea = false
							local TweenToSea
							if NewWorld then
								TweenToSea = toTarget(CFrame.new(38.905670166015625, -0.4971587657928467, 5150.13623046875))
							elseif ThreeWorld then
								TweenToSea = toTarget(CFrame.new(163.8607940673828, -0.4971587657928467, 3242.834716796875))
							end
							TweenToSea:Wait()
							fask.wait(2)
							NoClip = false
						elseif itmyboat and (game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit == false) then
							NoClip = false
							SpamSkillSea = false
							print("??")
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,30,0)
							fask.wait(0.1)
							itmyboat:Sit(game.Players.LocalPlayer.Character:WaitForChild("Humanoid"))
							fask.wait(1)
						elseif not itmyboat then
							_F("BuyBoat","PirateGrandBrigade")
							fask.wait(1)
						end
					end,function(...)
						print("ERROR : "..(...))
					end)
				else
					NoClip = false
					if tween then tween:Cancel() end
					break
				end
			end
		end)
		spawn(function()
			while fask.wait() do
				if AutoSeaBeast then
					if SpamSkillSea then
						task.spawn(function()
							if not LoppSeaDup then 
								LoppSeaDup = true 
								for i,v in ipairs({"Melee","Blox Fruit","Gun" , "Sword" }) do 
									EquipWeapon(GetFightingStyle(v))
									fask.wait(0.2)
									if SkillZ then 
										game:service('VirtualInputManager'):SendKeyEvent(true, "Z", false, game)
										fask.wait(0.5)
										game:service('VirtualInputManager'):SendKeyEvent(false, "Z", false, game)
									end
									if SkillX then 
										game:service('VirtualInputManager'):SendKeyEvent(true, "X", false, game)
										fask.wait(0.5)
										game:service('VirtualInputManager'):SendKeyEvent(false, "X", false, game)
									end
									if SkillC then 
										game:service('VirtualInputManager'):SendKeyEvent(true, "C", false, game)
										fask.wait(0.5)
										game:service('VirtualInputManager'):SendKeyEvent(false, "C", false, game)
									end
									if SkillV then 
										game:service('VirtualInputManager'):SendKeyEvent(true, "V", false, game)
										fask.wait(0.5)
										game:service('VirtualInputManager'):SendKeyEvent(false, "V", false, game)
									end
									if SkillF then 
										game:service('VirtualInputManager'):SendKeyEvent(true, "F", false, game)
										fask.wait(0.5)
										game:service('VirtualInputManager'):SendKeyEvent(false, "F", false, game)
									end
									fask.wait(0.5)
								end
								LoppSeaDup = false
							end
						end)
					end
				else
					break
				end
			end
		end)
	end
end})



ConfigAutoChest = AutoFarmMiscPageLeft:AddToggle("Auto Chest",{Stats = false , callback = function(starts)
	AutoChest = starts
	_G.ConfigMain["Auto Chest"] = starts
	spawn(function()
		while fask.wait() do
			if AutoChest then
				xpcall(function()
					for i,v in pairs(game.Workspace:GetDescendants()) do
						if v.Name:match("Chest") and v:IsA("BasePart") then
							if ChestTarget then ChestTarget:Stop() end
							if StopAtFirstOfDark and inmyself("Fist of Darkness") then
								ChangeToggle(ConfigAutoChest,false)
							end
							repeat fask.wait()
								ChestTarget = toTarget(v.CFrame)
								game:service('VirtualInputManager'):SendKeyEvent(true, "W", false, game)
								fask.wait(0.123)
								game:service('VirtualInputManager'):SendKeyEvent(false, "W", false, game)
							until (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).Magnitude <= 2 or not AutoChest or not v.Parent

							if not AutoChest then
								if tween then tween:Cancel() end
								break
							end
							for i = 1,2 do
								game:service('VirtualInputManager'):SendKeyEvent(true, "W", false, game)
								fask.wait(0.123)
								game:service('VirtualInputManager'):SendKeyEvent(false, "W", false, game)
								fask.wait(0.123)
								game:service('VirtualInputManager'):SendKeyEvent(true, 32, false, game)
								fask.wait(0.123)
								game:service('VirtualInputManager'):SendKeyEvent(false, 32, false, game)
							end
						end
					end
				end,function(e)
					print("AUTO CHEST ERROR : "..e)
				end)
			else
				if tween then tween:Cancel() end
				break
			end
		end
	end)
end})

AutoFarmMiscPageLeft:AddToggle("Stop At First of darkness",{Stats = false , callback = function(starts)
	StopAtFirstOfDark = starts
end})

AutoFarmMiscPageLeft:AddToggle("Kill At First of darkness",{Stats = false , callback = function(starts)
	KillAtFirstOfDark = starts
end})

local AutoFarmMiscSea1PageRight = TapAutoFarmMisc:CreatePage("Sea 1 [ Old World ]",2)

ConfigAutoOpenSaberRoom = AutoFarmMiscSea1PageRight:AddToggle("Auto Open Saber Room [ HOP ]",{Stats = false , callback = function(starts)
	if OldWorld then
		AutoSaber = starts
		_G.ConfigMain["Auto Open Saber Room"] = starts
		SaveConfigAuto()
		spawn(function()
			while fask.wait() do
				if AutoSaber then
					if game.Players.localPlayer.Data.Level.Value >= 200 then
						if game.Workspace.Map.Jungle.Final.Part.CanCollide == false then
							if game.Workspace.Enemies:FindFirstChild("Saber Expert [Lv. 200] [Boss]") or game:GetService("ReplicatedStorage"):FindFirstChild("Saber Expert [Lv. 200] [Boss]") then
								if game.Workspace.Enemies:FindFirstChild("Saber Expert [Lv. 200] [Boss]") then
									for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
										if v.Name == "Saber Expert [Lv. 200] [Boss]" and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
											repeat fask.wait()
												if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
													Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
												elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
													if Farmtween then Farmtween:Stop() end
													EquipWeapon(SelectToolWeapon)
													Usefastattack = true
													game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 10, 10)
												end
											until not AutoSaber or not v.Parent or v.Humanoid.Health <= 0
											Usefastattack = false
										end
									end
								else
									Questtween = toTarget(CFrame.new(-1405.41956, 29.8519993, 5.62435055).Position,CFrame.new(-1405.41956, 29.8519993, 5.62435055))
									if (CFrame.new(-1405.41956, 29.8519993, 5.62435055).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
										if Questtween then
											Questtween:Stop()
										end
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1405.41956, 29.8519993, 5.62435055, 0.885240912, 3.52892613e-08, 0.465132833, -6.60881128e-09, 1, -6.32913171e-08, -0.465132833, 5.29540891e-08, 0.885240912)
									end
								end
							else
								ServerFunc:TeleportFast()
							end
						elseif game.Players.LocalPlayer.Backpack:FindFirstChild("Relic") or game.Players.LocalPlayer.Character:FindFirstChild("Relic") and game.Players.localPlayer.Data.Level.Value >= 200 then
							EquipWeapon("Relic")
							fask.wait(0.5)
							Questtween = toTarget(CFrame.new(-1405.41956, 29.8519993, 5.62435055).Position,CFrame.new(-1405.41956, 29.8519993, 5.62435055))
							if (CFrame.new(-1405.41956, 29.8519993, 5.62435055).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
								if Questtween then
									Questtween:Stop()
								end
								game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1405.41956, 29.8519993, 5.62435055, 0.885240912, 3.52892613e-08, 0.465132833, -6.60881128e-09, 1, -6.32913171e-08, -0.465132833, 5.29540891e-08, 0.885240912)
							end
						else
							if Workspace.Map.Jungle.QuestPlates.Door.CanCollide == false then
								if game.Workspace.Map.Desert.Burn.Part.CanCollide == false then
									if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","SickMan") == 0 then
										if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon") == 0 then
											if game.Workspace.Enemies:FindFirstChild("Mob Leader [Lv. 120] [Boss]") then
												for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
													if AutoSaber and v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and v.Name == "Mob Leader [Lv. 120] [Boss]" then
														repeat
															pcall(function() fask.wait()
																if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
																	Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
																elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
																	if Farmtween then
																		Farmtween:Stop()
																	end
																	EquipWeapon(SelectToolWeapon)
																	Usefastattack = true
																	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 10, 10)
																end
															end)
														until not AutoSaber or not v.Parent or v.Humanoid.Health <= 0
														Usefastattack = false
													end
												end
											else
												Questtween = toTarget(CFrame.new(-2848.59399, 7.4272871, 5342.44043).Position,CFrame.new(-2848.59399, 7.4272871, 5342.44043))
												if (CFrame.new(-2848.59399, 7.4272871, 5342.44043).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
													if Questtween then
														Questtween:Stop()
													end
													game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2848.59399, 7.4272871, 5342.44043, -0.928248107, -8.7248246e-08, 0.371961564, -7.61816636e-08, 1, 4.44474857e-08, -0.371961564, 1.29216433e-08, -0.928248107)
												end
											end
										elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon") == 1 then
											if game.Players.LocalPlayer.Backpack:FindFirstChild("Relic") or game.Players.LocalPlayer.Character:FindFirstChild("Relic") then
												EquipWeapon("Relic")
												fask.wait(0.5)
												Questtween = toTarget(CFrame.new(-1405.41956, 29.8519993, 5.62435055).Position,CFrame.new(-1405.41956, 29.8519993, 5.62435055))
												if (CFrame.new(-1405.41956, 29.8519993, 5.62435055).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
													if Questtween then
														Questtween:Stop()
													end
													game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1405.41956, 29.8519993, 5.62435055)
												end
											else
												local args = {
													[1] = "ProQuestProgress",
													[2] = "RichSon"
												}
												game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
											end
										else
											Questtween = toTarget(CFrame.new(-910.979736, 13.7520342, 4078.14624).Position,CFrame.new(-910.979736, 13.7520342, 4078.14624))
											if (CFrame.new(-910.979736, 13.7520342, 4078.14624).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
												if Questtween then
													Questtween:Stop()
												end
												game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-910.979736, 13.7520342, 4078.14624)
												local args = {
													[1] = "ProQuestProgress",
													[2] = "RichSon"
												}
												game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
											end
										end
									else
										if game.Players.LocalPlayer.Backpack:FindFirstChild("Cup") or game.Players.LocalPlayer.Character:FindFirstChild("Cup") then
											game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","GetCup")
											fask.wait(0.5)
											EquipWeapon("Cup")
											fask.wait(0.5)
											game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","FillCup",game:GetService("Players").LocalPlayer.Character.Cup)
											fask.wait(0)
											game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","SickMan")
										else
											game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","GetCup")
										end
									end
								else
									if inmyself("Torch") then
										EquipWeapon("Torch")
										fask.wait(0.5)
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1114.87708, 4.9214654, 4349.8501, -0.612586915, -9.68697833e-08, 0.790403247, -1.2634203e-07, 1, 2.4638446e-08, -0.790403247, -8.47679615e-08, -0.612586915)
										fask.wait(8.14285714286)
									elseif not inmyself("Torch") then
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1610.00757, 11.5049858, 164.001587, 0.984807551, -0.167722285, -0.0449818149, 0.17364943, 0.951244235, 0.254912198, 3.42372805e-05, -0.258850515, 0.965917408)
									end
								end
							else
								for i,v in pairs(Workspace.Map.Jungle.QuestPlates:GetChildren()) do
									if v:IsA("Model") then fask.wait()
										if v.Button.BrickColor ~= BrickColor.new("Camo") then
											repeat fask.wait()
												Questtween = toTarget(v.Button.Position,v.Button.CFrame)
												if (v.Button.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
													if Questtween then
														Questtween:Stop()
													end
													game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Button.CFrame
												end
											until not AutoSaber or v.Button.BrickColor == BrickColor.new("Camo")
										end
									end
								end
							end
						end
					end
				else
					if tween then tween:Cancel() end
					break;
				end
			end
		end)
	end
end})

ConfigAutoPole = AutoFarmMiscSea1PageRight:AddToggle("Auto Pole V.1",{Stats = false , callback = function(starts)
	if OldWorld then
		AutoPole = starts
		_G.ConfigMain["Auto Pole V.1"] = starts
		SaveConfigAuto()
		spawn(function()
			while fask.wait() do
				if AutoPole then
					if game.Workspace.Enemies:FindFirstChild("Thunder God [Lv. 575] [Boss]") then
						for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
							if AutoPole and v.Name == "Thunder God [Lv. 575] [Boss]" and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
								repeat fask.wait()
									if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
										Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
									elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
										if Farmtween then
											Farmtween:Stop()
										end
										EquipWeapon(SelectToolWeapon)
										Usefastattack = true
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 10, 10)
									end
								until not AutoPole or v.Humanoid.Health <= 0 or not v.Parent
								Usefastattack = false
							end
						end
					else
						Questtween = toTarget(CFrame.new(-7900.66406, 5606.90918, -2267.46436).Position,CFrame.new(-7900.66406, 5606.90918, -2267.46436))
						if (CFrame.new(-7900.66406, 5606.90918, -2267.46436).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
							if Questtween then
								Questtween:Stop()
							end
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-7900.66406, 5606.90918, -2267.46436)
						end
					end
				else
					if tween then tween:Cancel() end
					break
				end
			end
		end)
	end
end})

ConfigAutoPoleHop = AutoFarmMiscSea1PageRight:AddToggle("Auto Pole V.1 [ HOP ]",{Stats = false , callback = function(starts)
	if OldWorld then
		AutoPole = starts
		AutoPoleHOP = starts
		_G.ConfigMain["Auto Pole V.1 [ HOP ]"] = starts
		SaveConfigAuto()
		spawn(function()
			while fask.wait() do
				if AutoPole or AutoPoleHOP then
					if game:GetService("ReplicatedStorage"):FindFirstChild("Thunder God [Lv. 575] [Boss]") or game.Workspace.Enemies:FindFirstChild("Thunder God [Lv. 575] [Boss]") then
						if game.Workspace.Enemies:FindFirstChild("Thunder God [Lv. 575] [Boss]") then
							for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
								if AutoPole and v.Name == "Thunder God [Lv. 575] [Boss]" and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
									repeat fask.wait()
										if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
											Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
										elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
											if Farmtween then
												Farmtween:Stop()
											end
											EquipWeapon(SelectToolWeapon)
											Usefastattack = true
											game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 10, 10)
										end
									until not AutoPole or v.Humanoid.Health <= 0 or not v.Parent
									Usefastattack = false
								end
							end
						else
							Questtween = toTarget(CFrame.new(-7900.66406, 5606.90918, -2267.46436).Position,CFrame.new(-7900.66406, 5606.90918, -2267.46436))
							if (CFrame.new(-7900.66406, 5606.90918, -2267.46436).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
								if Questtween then
									Questtween:Stop()
								end
								game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-7900.66406, 5606.90918, -2267.46436)
							end
						end
					elseif AutoPoleHOP then
						ServerFunc:TeleportFast()
					end
				else
					if tween then tween:Cancel() end
					break
				end
			end
		end)
	end
end})

local AutoFarmMiscSea2PageRight = TapAutoFarmMisc:CreatePage("Sea 2 [ New World ]",2)

AutoFarmMiscSea2PageRight:AddLabel("~ Auto Farm Law ~")

ConfigAutoFarmLaw = AutoFarmMiscSea2PageRight:AddToggle("Auto Farm Law",{Stats = false , callback = function(starts)
	if NewWorld then
		AutoFarmLaw = starts
		_G.ConfigMain["Auto Farm Law"] = starts
		SaveConfigAuto()
	end
	spawn(function()
		while fask.wait() do
			if AutoFarmLaw and NewWorld then
				if game.Players.LocalPlayer.Backpack:FindFirstChild("Microchip") or game.Players.LocalPlayer.Character:FindFirstChild("Microchip") or game:GetService("Workspace").Enemies:FindFirstChild("Order [Lv. 1250] [Raid Boss]") then
					if game.Players.LocalPlayer.Backpack:FindFirstChild("Microchip") or game.Players.LocalPlayer.Character:FindFirstChild("Microchip") and not game:GetService("Workspace").Enemies:FindFirstChild("Order [Lv. 1250] [Raid Boss]") then
						Usefastattack = false
						if NewWorld then
							fireclickdetector(game:GetService("Workspace").Map.CircleIsland.RaidSummon.Button.Main.ClickDetector)
						end
						fask.wait(4)
					elseif game:GetService("Workspace").Enemies:FindFirstChild("Order [Lv. 1250] [Raid Boss]") then
						pcall(function()
							for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
								if v.Name == "Order [Lv. 1250] [Raid Boss]" then
									pcall(function()
										repeat fask.wait()
											if game:GetService("Workspace").Enemies:FindFirstChild("Order [Lv. 1250] [Raid Boss]") then
												if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
													Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
												elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
													if Farmtween then
														Farmtween:Stop()
													end
													EquipWeapon(SelectToolWeapon)
													Usefastattack = true
													toAroundTarget(v.HumanoidRootPart.CFrame)
												end
											else
												Questtween = toTarget(CFrame.new(-6026.96484, 14.7461271, -5071.96338).Position,CFrame.new(-6026.96484, 14.7461271, -5071.96338))
												if (CFrame.new(-6026.96484, 14.7461271, -5071.96338).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
													if Questtween then
														Questtween:Stop()
													end
													game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-6026.96484, 14.7461271, -5071.96338)
												end
											end
										until AutoFarmLaw == false or not game:GetService("Workspace").Enemies:FindFirstChild("Order [Lv. 1250] [Raid Boss]")
										Usefastattack = false
									end)
								end
							end
						end)
					elseif game:GetService("ReplicatedStorage"):FindFirstChild("Order [Lv. 1250] [Raid Boss]") then
						toTargetNoDie(game:GetService("ReplicatedStorage"):FindFirstChild("Order [Lv. 1250] [Raid Boss]").HumanoidRootPart.CFrame * CFrame.new(1,50,0))
					end
				else
					Usefastattack = false
					if game.Players.LocalPlayer.Data.Fragments.Value >= 1000 then
						local args = {
							[1] = "BlackbeardReward",
							[2] = "Microchip",
							[3] = "1"
						}

						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
						local args = {
							[1] = "BlackbeardReward",
							[2] = "Microchip",
							[3] = "2"
						}

						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
					end
				end
			else
				if tween then tween:Cancel() end
				break
			end
		end
	end)
end})

AutoFarmMiscSea2PageRight:AddLabel("~ Auto Quest Bartilo ~")

ConfigAutoQuestBartilo = AutoFarmMiscSea2PageRight:AddToggle("Auto Quest Bartilo",{Stats = false , callback = function(starts)
	if not NewWorld then return end
	AutoQuestBartilo = starts
	_G.ConfigMain["Auto Quest Bartilo"] = starts
	SaveConfigAuto()
	spawn(function()
		while fask.wait() do
			if AutoQuestBartilo then
				if game.Players.LocalPlayer.Data.Level.Value >= 850 then
					if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 0 then
						if string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Swan Pirates") and string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "50") and game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == true then
							if game.Workspace.Enemies:FindFirstChild("Swan Pirate [Lv. 775]") then
								for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
									if v.Name == "Swan Pirate [Lv. 775]" then
										pcall(function()
											repeat fask.wait()
												if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
													Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
												elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
													if Farmtween then
														Farmtween:Stop()
													end
													v.HumanoidRootPart.Size = Vector3.new(55,55,55)
													EquipWeapon(SelectToolWeapon)
													spawn(function()
														for i2,v2 in pairs(game.Workspace.Enemies:GetChildren()) do
															if v2.Name == "Swan Pirate [Lv. 775]" then
																v2.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
															end
														end
													end)
													Usefastattack = true
													toAroundTarget(v.HumanoidRootPart.CFrame)
												end
											until not v.Parent or v.Humanoid.Health <= 0 or AutoQuestBartilo == false or game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false
											AutoBartiloBring = false
											Usefastattack = false
										end)
									end
								end
							else
								Questtween = toTarget(CFrame.new(1057.92761, 137.614319, 1242.08069).Position,CFrame.new(1057.92761, 137.614319, 1242.08069))
								if (CFrame.new(1057.92761, 137.614319, 1242.08069).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
									if Questtween then
										Questtween:Stop()
									end
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1057.92761, 137.614319, 1242.08069)
								end
							end
						else
							Bartilotween = toTarget(CFrame.new(-456.28952, 73.0200958, 299.895966).Position,CFrame.new(-456.28952, 73.0200958, 299.895966))
							if ( CFrame.new(-456.28952, 73.0200958, 299.895966).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
								if Bartilotween then
									Bartilotween:Stop()
								end
								game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =  CFrame.new(-456.28952, 73.0200958, 299.895966)
								local args = {
									[1] = "StartQuest",
									[2] = "BartiloQuest",
									[3] = 1
								}
								game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
								
							end
						end
					elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 1 then
						if game.Workspace.Enemies:FindFirstChild("Jeremy [Lv. 850] [Boss]") then
							for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
								if v.Name == "Jeremy [Lv. 850] [Boss]" then
									repeat fask.wait()
										if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
											Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
										elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
											if Farmtween then
												Farmtween:Stop()
											end
											EquipWeapon(SelectToolWeapon)
											Usefastattack = true
											v.HumanoidRootPart.Size = Vector3.new(55,55,55)
											toAroundTarget(v.HumanoidRootPart.CFrame)
										end
									until not v.Parent or v.Humanoid.Health <= 0 or AutoQuestBartilo == false
									Usefastattack = false
								end
							end
						else
							Bartilotween = toTarget(CFrame.new(2099.88159, 448.931, 648.997375).Position,CFrame.new(2099.88159, 448.931, 648.997375))
							if (CFrame.new(2099.88159, 448.931, 648.997375).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
								if Bartilotween then
									Bartilotween:Stop()
								end
								game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2099.88159, 448.931, 648.997375)
							end
						end
					elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 2 then
						if (CFrame.new(-1836, 11, 1714).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
							Bartilotween = toTarget(CFrame.new(-1836, 11, 1714).Position,CFrame.new(-1836, 11, 1714))
						elseif (CFrame.new(-1836, 11, 1714).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
							if Bartilotween then
								Bartilotween:Stop()
							end
							game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1836, 11, 1714)
							fask.wait(.5)
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1850.49329, 13.1789551, 1750.89685)
							fask.wait(1)
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1858.87305, 19.3777466, 1712.01807)
							fask.wait(1)
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1803.94324, 16.5789185, 1750.89685)
							fask.wait(1)
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1858.55835, 16.8604317, 1724.79541)
							fask.wait(1)
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1869.54224, 15.987854, 1681.00659)
							fask.wait(1)
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1800.0979, 16.4978027, 1684.52368)
							fask.wait(1)
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1819.26343, 14.795166, 1717.90625)
							fask.wait(1)
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1813.51843, 14.8604736, 1724.79541)
						end
					end
				end
			else
				break
			end
		end
	end)
end})

AutoFarmMiscSea2PageRight:AddLabel("~ Auto Rengoku ~")

ConfigAutoRengoku = AutoFarmMiscSea2PageRight:AddToggle("Auto Rengoku",{Stats = false , callback = function(starts)
	if NewWorld then
		AutoRengoku = starts
		_G.ConfigMain["Auto Rengoku"] = starts
		SaveConfigAuto()
		spawn(function()
			while fask.wait() do
				if AutoRengoku then
					if game.Players.LocalPlayer.Backpack:FindFirstChild("Hidden Key") or  game.Players.LocalPlayer.Character:FindFirstChild("Hidden Key") then
						EquipWeapon("Hidden Key")
						if (CFrame.new(6571.81885, 296.689758, -6966.76514).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
							Farmtween = toTarget(CFrame.new(6571.81885, 296.689758, -6966.76514).Position,CFrame.new(6571.81885, 296.689758, -6966.76514))
						elseif (CFrame.new(6571.81885, 296.689758, -6966.76514).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
							if Farmtween then
								Farmtween:Stop()
							end
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(6571.81885, 296.689758, -6966.76514, 0.825126112, 8.412257e-10, 0.564948559, -2.42370835e-08, 1, 3.39100339e-08, -0.564948559, -4.16727595e-08, 0.825126112)
						end
					elseif game.Workspace.Enemies:FindFirstChild("Snow Lurker [Lv. 1375]") then
						for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
							if AutoRengoku and v.Name == "Snow Lurker [Lv. 1375]" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
								repeat fask.wait()
									if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
										Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
										StartMagnetRengoku = false
									elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
										if Farmtween then
											Farmtween:Stop()
										end
										PosMonRengoku = v.HumanoidRootPart.CFrame
										EquipWeapon(SelectToolWeapon)
										Usefastattack = true
										StartMagnetRengoku = true
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 10, 10)
									end
								until game.Players.LocalPlayer.Backpack:FindFirstChild("Hidden Key") or AutoRengoku == false or not v.Parent or v.Humanoid.Health <= 0
								StartMagnetRengoku = false
								Usefastattack = false
								if (CFrame.new(5518.00684, 60.5559731, -6828.80518).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
									Farmtween = toTarget(CFrame.new(5518.00684, 60.5559731, -6828.80518).Position,CFrame.new(5518.00684, 60.5559731, -6828.80518))
								elseif (CFrame.new(5518.00684, 60.5559731, -6828.80518).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
									if Farmtween then
										Farmtween:Stop()
									end
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(5518.00684, 60.5559731, -6828.80518, 0.825126112, 8.412257e-10, 0.564948559, -2.42370835e-08, 1, 3.39100339e-08, -0.564948559, -4.16727595e-08, 0.825126112)
								end
							end
						end
					else
						StartMagnetRengoku = false
						if (CFrame.new(5518.00684, 60.5559731, -6828.80518).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
							Farmtween = toTarget(CFrame.new(5518.00684, 60.5559731, -6828.80518).Position,CFrame.new(5518.00684, 60.5559731, -6828.80518))
						elseif (CFrame.new(5518.00684, 60.5559731, -6828.80518).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
							if Farmtween then
								Farmtween:Stop()
							end
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =CFrame.new(5518.00684, 60.5559731, -6828.80518, -0.650781393, -3.64292951e-08, 0.759265184, -4.07668654e-09, 1, 4.44854642e-08, -0.759265184, 2.58550248e-08, -0.650781393)
						end
					end
				else
					break;
				end
			end
		end)
	end
end})

AutoFarmMiscSea2PageRight:AddLabel("~ Auto Farm Ectoplasm ~")

ConfigAutoFarmEctoplasm = AutoFarmMiscSea2PageRight:AddToggle("Auto Farm Ectoplasm",{Stats = false , callback = function(starts)
	if NewWorld then
		AutoFramEctoplasm = starts
		_G.ConfigMain["Auto Farm Ectoplasm"] = starts
		SaveConfigAuto()
		spawn(function()
			while fask.wait() do
				if AutoFramEctoplasm then
					if (function()for a,b in pairs(game.Workspace.Enemies:GetChildren())do if string.find(b.Name,"Ship")and b:FindFirstChild("HumanoidRootPart")then return true end end;return false end)() then
						for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
							if string.find(v.Name, "Ship") and v:FindFirstChild("HumanoidRootPart") then
								repeat fask.wait()
									if v:FindFirstChild("HumanoidRootPart") then
										if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
											Usefastattack = false
											Farmtween = toTarget(v.HumanoidRootPart.CFrame * CFrame.new(1,20,0))
											StartMagnetEctoplasm = false
										elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
											if Farmtween then
												Farmtween:Stop()
											end
											EquipWeapon(SelectToolWeapon)
											PosMonEctoplasm = v.HumanoidRootPart.CFrame
											Usefastattack = true
											StartMagnetEctoplasm = true
											game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 10, 10)
										end
									end
								until AutoFramEctoplasm == false or not v.Parent or v.Humanoid.Health <= 0
								Usefastattack = false
								StartMagnetEctoplasm = false
							end
						end
					else
						if (CFrame.new(920.14447, 129.581833, 33442.168).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
							Farmtween = toTarget(CFrame.new(920.14447, 129.581833, 33442.168).Position,CFrame.new(920.14447, 129.581833, 33442.168))
						elseif (CFrame.new(920.14447, 129.581833, 33442.168).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
							if Farmtween then
								Farmtween:Stop()
							end
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(920.14447, 129.581833, 33442.168, -0.999913812, 0, -0.0131403487, 0, 1, 0, 0.0131403487, 0, -0.999913812)
						end
					end
				else
					break;
				end
			end
		end)
	end
end})

ConfigAutoBuyBizarreRifle = AutoFarmMiscSea2PageRight:AddToggle("Auto Buy Bizarre Rifle",{Stats = false , callback = function(starts)
	if NewWorld then
		AutoBuyBizarreRifle = starts
		_G.ConfigMain["Auto Buy Bizarre Rifle"] = starts
		SaveConfigAuto()
		spawn(function()
			while fask.wait() do
				if AutoBuyBizarreRifle then
					_F("Ectoplasm","Buy",3)
				else
					break
				end
			end
		end)
	end
end})

ConfigAutoBuyGhoulMask = AutoFarmMiscSea2PageRight:AddToggle("Auto Buy Ghoul Mask",{Stats = false , callback = function(starts)
	if NewWorld then
		AutoBuyGhoulMask = starts
		_G.ConfigMain["Auto Buy Ghoul Mask"] = starts
		SaveConfigAuto()
		spawn(function()
			while fask.wait() do
				if AutoBuyGhoulMask then
					_F("Ectoplasm","Buy",3)
				else
					break
				end
			end
		end)
	end
end})

ConfigAutoBuyMidnightBlade = AutoFarmMiscSea2PageRight:AddToggle("Auto Buy Midnight Blade",{Stats = false , callback = function(starts)
	if NewWorld then
		AutoBuyMidnightBlade = starts
		_G.ConfigMain["Auto Buy Midnight Blade"] = starts
		SaveConfigAuto()
		spawn(function()
			while fask.wait() do
				if AutoBuyMidnightBlade then
					_F("Ectoplasm","Buy",3)
				else
					break
				end
			end
		end)
	end
end})

local AutoFarmMiscSea3PageRight = TapAutoFarmMisc:CreatePage("Sea 3 [ Three World ]",2)

AutoFarmMiscSea3PageRight:AddLabel("~ ❤️Valentine💕 ~")

AutoFarmMiscSea3PageRight:AddToggle("Auto Farm Hearts (Level Max Only)",{Stats = false , callback = function(starts)
	AutoHearts = starts
	spawn(function()
		while fask.wait() do
			if AutoHearts then
				xpcall(function()
					MaterialMob = {"Sweet Thief [Lv. 2350]","Candy Rebel [Lv. 2375]","Candy Pirate [Lv. 2400]","Snow Demon [Lv. 2425]"}

					CFrameMonM = {
						CFrame.new(71.89511108398438, 77.21478271484375, -12632.435546875),
						CFrame.new(134.3748016357422, 77.21473693847656, -12882.1650390625),
						CFrame.new(-1271.6993408203125, 139.93331909179688, -14354.8515625),
						CFrame.new(-844.35546875, 138.32464599609375, -14496.455078125),
					}
					if CustomFindFirstChild(MaterialMob) then
						for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
							if AutoHearts and table.find(MaterialMob,v.Name) and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
								repeat fask.wait()
									FarmtoTarget = toTarget(v.HumanoidRootPart.CFrame * CFrame.new(0,30,1))
									if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
										if FarmtoTarget then FarmtoTarget:Stop() end
										Usefastattack = true
										EquipWeapon(SelectToolWeapon)
										spawn(function()
											for i,v2 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
												if table.find(MaterialMob,v2.Name) then
													spawn(function()
														if InMyNetWork(v2.HumanoidRootPart) then
															v2.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
															v2.Humanoid.JumpPower = 0
															v2.Humanoid.WalkSpeed = 0
															v2.HumanoidRootPart.CanCollide = false
															v2.Humanoid:ChangeState(14)
															v2.Humanoid:ChangeState(11)
															v2.HumanoidRootPart.Size = Vector3.new(55,55,55)
														end
													end)
												end
											end
										end)
										if game.Players.LocalPlayer.Character:FindFirstChild("Black Leg") and game.Players.LocalPlayer.Character:FindFirstChild("Black Leg").Level.Value >= 150 then
											game:service('VirtualInputManager'):SendKeyEvent(true, "V", false, game)
											game:service('VirtualInputManager'):SendKeyEvent(false, "V", false, game)
										end
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 1)
									end
								until not CustomFindFirstChild(MaterialMob) or not AutoHearts or v.Humanoid.Health <= 0 or not v.Parent
								Usefastattack = false
							end
						end
					else
						Usefastattack = false
						for i,v in pairs(CFrameMonM) do
							if AutoHearts and not CustomFindFirstChild(MaterialMob) then
								while AutoHearts and not CustomFindFirstChild(MaterialMob) do fask.wait()
									Modstween = toTarget(v)
									if (v.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
										if Modstween then Modstween:Stop() end
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v
										break
									end
									fask.wait(0)
								end
							end
							fask.wait(0)
						end
					end
				end,function(...)
					print("Heart Error : "..(...))
				end)
			else
				break
			end
		end
	end)
end})

AutoFarmMiscSea3PageRight:AddLabel("~ Full Moon ~")

local FullMoonStatus = AutoFarmMiscSea3PageRight:AddLabel("N/S")

pcall(function()
	local MoonPhase = tonumber(game:GetService("Lighting"):GetAttribute("MoonPhase"))
	if MoonPhase == 8 then
		FullMoonStatus:Options().Text = "Moon 25% After Full Moon"
	elseif MoonPhase == 7 then
		FullMoonStatus:Options().Text = "Moon 50% After Full Moon"
	elseif MoonPhase == 6 then
		FullMoonStatus:Options().Text = "Moon 75% After Full Moon"
	elseif MoonPhase == 5 then
		FullMoonStatus:Options().Text = "Moon 100%"
	elseif MoonPhase == 4 then
		FullMoonStatus:Options().Text = "Moon 75%"
	elseif MoonPhase == 3 then
		FullMoonStatus:Options().Text = "Moon 50%"
	elseif MoonPhase == 2 then
		FullMoonStatus:Options().Text = "Moon 25%"
	elseif MoonPhase == 1 then
		FullMoonStatus:Options().Text = "Moon 0%"
	end
end)
AutoFarmMiscSea3PageRight:AddButton("Update Moon Status",function()
	pcall(function()
		local MoonPhase = tonumber(game:GetService("Lighting"):GetAttribute("MoonPhase"))
		if MoonPhase == 8 then
			FullMoonStatus:Options().Text = "Moon 25% After Full Moon"
		elseif MoonPhase == 7 then
			FullMoonStatus:Options().Text = "Moon 50% After Full Moon"
		elseif MoonPhase == 6 then
			FullMoonStatus:Options().Text = "Moon 75% After Full Moon"
		elseif MoonPhase == 5 then
			FullMoonStatus:Options().Text = "Moon 100%"
		elseif MoonPhase == 4 then
			FullMoonStatus:Options().Text = "Moon 75%"
		elseif MoonPhase == 3 then
			FullMoonStatus:Options().Text = "Moon 50%"
		elseif MoonPhase == 2 then
			FullMoonStatus:Options().Text = "Moon 25%"
		elseif MoonPhase == 1 then
			FullMoonStatus:Options().Text = "Moon 0%"
		end
	end)
end)

ConfigAutoFullMoon = AutoFarmMiscSea3PageRight:AddToggle("Auto Find Full Moon Hop",{Stats = false , callback = function(starts)
	AutoFullMoon = starts
	_G.ConfigMain["Auto Find Full Moon Hop"] = starts
	SaveConfigAuto()
	spawn(function()
		while fask.wait() do
			if AutoFullMoon and (not AutoMirageIslandHop or not AutoMirageIsland) then
				local MoonPhase = tonumber(game:GetService("Lighting"):GetAttribute("MoonPhase"))
				if MoonPhase == 5 then
					Notify({
						Title = "Alert",
						Text = "Find Full Moon",
						Timer = 3
					},"Warn")
					ChangeToggle(ConfigAutoFullMoon,false)
					break
				else
					ServerFunc:NormalTeleport()
					fask.wait(2)
				end
			else
				break
			end
		end
	end)
end})

AutoFarmMiscSea3PageRight:AddLabel("~ Mirage Island ~")

ConfigAutoMirageIsland = AutoFarmMiscSea3PageRight:AddToggle("Auto Mirage Island",{Stats = false , callback = function(starts)
	AutoMirageIsland = starts
	_G.ConfigMain["Auto Mirage Island"] = starts
	SaveConfigAuto()
	spawn(function()
		while fask.wait() do
			if AutoMirageIsland then
				local MoonPhase = tonumber(game:GetService("Lighting"):GetAttribute("MoonPhase"))
				if AutoFullMoon then
					if game:GetService("Workspace").Map:FindFirstChild("MysticIsland") and MoonPhase == 5 then
						toTarget(game:GetService("Workspace").Map:FindFirstChild("MysticIsland"):GetModelCFrame() * CFrame.new(1,100,0))
					else
						Notify({
							Title = "Alert",
							Text = "Not Find Mirage Island and full moon",
							Timer = 3
						},"Warn")
						fask.wait(2)
					end
				else
					if game:GetService("Workspace").Map:FindFirstChild("MysticIsland") then
						toTarget(game:GetService("Workspace").Map:FindFirstChild("MysticIsland"):GetModelCFrame() * CFrame.new(1,100,0))
					else
						Notify({
							Title = "Alert",
							Text = "Not Find Mirage Island",
							Timer = 3
						},"Warn")
						fask.wait(2)
					end
				end
			else
				break
			end
		end
	end)
end})

ConfigAutoMirageIslandHop = AutoFarmMiscSea3PageRight:AddToggle("Auto Mirage Island [Hop]",{Stats = false , callback = function(starts)
	AutoMirageIslandHop = starts
	_G.ConfigMain["Auto Mirage Island Hop"] = starts
	SaveConfigAuto()
	spawn(function()
		while fask.wait() do
			if AutoMirageIslandHop then
				local MoonPhase = tonumber(game:GetService("Lighting"):GetAttribute("MoonPhase"))
				if AutoFullMoon then
					if game:GetService("Workspace").Map:FindFirstChild("MysticIsland") and MoonPhase == 5 then
						toTarget(game:GetService("Workspace").Map:FindFirstChild("MysticIsland"):GetModelCFrame() * CFrame.new(1,100,0))
					else
						ServerFunc:NormalTeleport()
						ServerFunc:TeleportFast()
					end
				else
					if game:GetService("Workspace").Map:FindFirstChild("MysticIsland") then
						toTarget(game:GetService("Workspace").Map:FindFirstChild("MysticIsland"):GetModelCFrame() * CFrame.new(1,100,0))
					else
						ServerFunc:NormalTeleport()
						ServerFunc:TeleportFast()
					end
				end
			else
				break
			end
		end
	end)
end})

AutoFarmMiscSea3PageRight:AddToggle("Auto Chest Mirage",{Stats = false , callback = function(starts)
	ChestMira = starts
	spawn(function()
		while fask.wait() do
			if ChestMira then
				if game:GetService("Workspace").Map:FindFirstChild("MysticIsland") then
					for i,v in pairs(game:GetService("Workspace").Map.MysticIsland.Chests:GetChildren()) do
						if v.Name:match("Chest") and v:IsA("BasePart") and v.Transparency == 0 then
							if ChestTarget then ChestTarget:Stop() end
							repeat fask.wait()
								ChestTarget = toTarget(v.CFrame)
								game:service('VirtualInputManager'):SendKeyEvent(true, "W", false, game)
								fask.wait(0.123)
								game:service('VirtualInputManager'):SendKeyEvent(false, "W", false, game)
							until (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).Magnitude <= 2 or not ChestMira or not v.Parent

							if not ChestMira then
								if tween then tween:Cancel() end
								break
							end
							for i = 1,2 do
								game:service('VirtualInputManager'):SendKeyEvent(true, "W", false, game)
								fask.wait(0.123)
								game:service('VirtualInputManager'):SendKeyEvent(false, "W", false, game)
								fask.wait(0.123)
								game:service('VirtualInputManager'):SendKeyEvent(true, 32, false, game)
								fask.wait(0.123)
								game:service('VirtualInputManager'):SendKeyEvent(false, 32, false, game)
							end
						end
					end
				end

			end
		end
	end)
end})

AutoFarmMiscSea3PageRight:AddToggle("Auto Find Advance Shop",{Stats = false , callback = function(starts)
	FindFruitShop = starts
	spawn(function()
		while fask.wait() do
			if FindFruitShop then
				if game:GetService("Workspace").Map:FindFirstChild("MysticIsland") then
					if not game:GetService("Workspace").NPCs:FindFirstChild("Advanced Fruit Dealer") then
						for i,v in pairs(game:GetService("Workspace").Map.MysticIsland.npcspawn:GetChildren()) do
							if not game:GetService("Workspace").NPCs:FindFirstChild("Advanced Fruit Dealer") then
								if NpSTarget then NpSTarget:Stop() end
								repeat fask.wait()
									NpSTarget = toTarget(v.CFrame)
								until (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).Magnitude <= 10 or not FindFruitShop or not v.Parent
								if not FindFruitShop or game:GetService("Workspace").NPCs:FindFirstChild("Advanced Fruit Dealer") then
									if tween then tween:Cancel() end
									break
								end
								fask.wait(0.1)
							end
						end
					else
						for i,v in pairs(game:GetService("Workspace").NPCs:GetChildren()) do
							if v.Name == "Advanced Fruit Dealer" then
								toTarget(v.HumanoidRootPart.CFrame* CFrame.new(0,0,0))
							end
						end
					end
				end
				fask.wait(0.1)
			else
				break
			end
		end
	end)
end})


AutoFarmMiscSea3PageRight:AddLabel("~ 🥨 Auto Cursed Dual Katana 🥨 ~")

local function CheckMobDistanceCollection(Vc3,dis)
	local dis = dis or 1000
	for i,v in pairs(game:GetService("CollectionService"):GetTagged("ActiveRig")) do
		if not tostring(v.Name):match("%[Boss]$") and tostring(v.Name):find("%[Lv.") then
			if (v.HumanoidRootPart.Position - Vc3).Magnitude <= dis then
				return true
			end
		end
	end
	for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
		if not tostring(v.Name):match("%[Boss]$") and tostring(v.Name):find("%[Lv.") then
			if (v.HumanoidRootPart.Position - Vc3).Magnitude <= dis then
				return true
			end
		end
	end
	
	return false
end
local function CheckMobDistanceWorkspace(Vc3,dis)
	local dis = dis or 1000
	for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
		if tostring(v.Name):find("%[Lv.") then
			if (v.HumanoidRootPart.Position - Vc3).Magnitude <= dis then
				return true
			end
		end
	end
	return false
end
local function CheckNotNotifyHazeESP()
	for i,v in pairs(game:GetService("CollectionService"):GetTagged("ActiveRig")) do
		if v:FindFirstChild("HazeESP") then
			return true
		end
	end
	for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
		if v:FindFirstChild("HazeESP") then
			return true
		end
	end
	for i,v in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
		if v:FindFirstChild("HazeESP") then
			return true
		end
	end
	return false
end

local ErrorCount = 0

ConfigAutoCursedDualKatana = AutoFarmMiscSea3PageRight:AddToggle("Auto Cursed Dual Katana",{Stats = false , callback = function(starts)
	if ThreeWorld then
		AutoCursedDualKatana = starts
		_G.ConfigMain["Auto Cursed Dual Katana"] = starts
		SaveConfigAuto()
		spawn(function()
			while fask.wait() do
				if AutoCursedDualKatana then
					xpcall(function()
						if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health == 0 then if tween then tween:Cancel() end repeat fask.wait() until game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health > 0; fask.wait(0.2) end
						if not game:GetService("Workspace").Map.Turtle.Cursed:FindFirstChild("Breakable") then
							local CheckPQuest
							if game:GetService("Workspace").Map.Turtle.Cursed:FindFirstChild("GoodScroll") then
								CheckPQuest = _F("CDKQuest","Progress","Good")
							else
								CheckPQuest = _F("CDKQuest","Progress","Evil")
							end

							if CheckPQuest.Good == 4 and CheckPQuest.Evil == 4 and CheckPQuest.Finished == true then

							elseif CheckPQuest.Good == 4 and CheckPQuest.Evil == 4 and not CheckPQuest.Finished then
								if inmyself("Yama") or inmyself("Tushita") then
									if game.Workspace.Enemies:FindFirstChild("Cursed Skeleton Boss [Lv. 2025] [Boss]") or game:GetService("ReplicatedStorage"):FindFirstChild("Cursed Skeleton Boss [Lv. 2025] [Boss]") then
										if KillBossTween then
											KillBossTween:Stop()
										end
										for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
											if AutoCursedDualKatana and v.Name == "Cursed Skeleton Boss [Lv. 2025] [Boss]" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
												repeat fask.wait()
													Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
													if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
														if Farmtween then
															Farmtween:Stop()
														end
														EquipWeapon(GetFightingStyle("Sword"))
														Usefastattack = true
														toAroundTarget(v.HumanoidRootPart.CFrame)
													end
												until not AutoCursedDualKatana or v.Humanoid.Health <= 0 or not v.Parent
												Usefastattack = false
											end
										end
									else
										if game:GetService("Workspace").Map.Turtle.Cursed.Pedestal3.ProximityPrompt.Enabled == false then
											KillBossTween = toTarget(CFrame.new(-12278.8193359375, 598.8648071289062, -6551.98876953125))
											_F("CDKQuest","StartTrial","Boss")
										else
											KillBossTween = toTarget(CFrame.new(-12361.7060546875, 603.3547973632812, -6550.5341796875))
											if (CFrame.new(-12361.7060546875, 603.3547973632812, -6550.5341796875).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
												if KillBossTween then
													KillBossTween:Stop()
												end
												game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-12361.7060546875, 603.3547973632812, -6550.5341796875)
												fask.wait(2)
												fireproximityprompt(game:GetService("Workspace").Map.Turtle.Cursed.Pedestal3.ProximityPrompt,0)
												print("F2")
											end
										end
									end
								else
									_F("StoreItem",tostring(GetFightingStyle("Sword")),inmyself(GetFightingStyle("Sword")))
									fask.wait(1)
									_F("LoadItem",tostring("Tushita"))
									fask.wait(1)
								end
							elseif CheckPQuest.Good == -2 and CheckPQuest.Finished == false and CheckPQuest.Evil == -5 then
								if game:GetService("Workspace").Map:FindFirstChild("HellDimension") and game:GetService("Workspace").Map.HellDimension:FindFirstChild("Exit") and game:GetService("Workspace").Map.HellDimension:FindFirstChild("Exit").Color ~= Color3.fromRGB(0, 0, 0) then
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.HellDimension:FindFirstChild("Exit").CFrame
								elseif game:GetService("Workspace").Map:FindFirstChild("HellDimension") and tostring(game:GetService("Workspace").Map:FindFirstChild("HellDimension"):FindFirstChild("ActivePlayers").Value.Value) == game.Players.LocalPlayer.Name then
									if Questtween then
										Questtween:Stop()
									end
									if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-game:GetService("Workspace").Map.HellDimension.Torch1.Position).Magnitude <= 500 then
										if TorchTween then TorchTween:Stop() end
										if CheckMobDistanceWorkspace(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Hell Dimension").Position,500) then
											for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
												if AutoCursedDualKatana and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
													repeat fask.wait()
														if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
															Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
															Usefastattack = false
														elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
															if Farmtween then Farmtween:Stop() end
															spawn(function()
																NoDupeMob = 0.1
																for i2,v2 in pairs(game.Workspace.Enemies:GetChildren()) do
																	if InMyNetWork(v.HumanoidRootPart) and v2.Name == v.Name and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
																		v2.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(NoDupeMob,0,0)
																		v2.HumanoidRootPart.CanCollide = false
																		v2.HumanoidRootPart.Size = Vector3.new(55,55,55)
																		NoDupeMob = NoDupeMob + 0.2
																	end
																end
															end)

															game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(1,30,1)
															EquipWeapon(SelectToolWeapon)
															Usefastattack = true
														end
													until not AutoCursedDualKatana or game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health == 0 or v.Humanoid.Health == 0 or not v.Parent
													Usefastattack = false
													fask.wait(2)
												end
											end
										else
											if game:GetService("Workspace").Map.HellDimension.Torch1:FindFirstChild("ProximityPrompt").Enabled == true then
												game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.HellDimension.Torch1.CFrame
												fask.wait(0.5)
												fireproximityprompt(game:GetService("Workspace").Map.HellDimension.Torch1.ProximityPrompt,4)
												fask.wait(0.5)
											elseif game:GetService("Workspace").Map.HellDimension.Torch2:FindFirstChild("ProximityPrompt").Enabled == true then
												game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.HellDimension.Torch2.CFrame
												fask.wait(0.5)
												fireproximityprompt(game:GetService("Workspace").Map.HellDimension.Torch2.ProximityPrompt,4)
												fask.wait(0.5)
											elseif game:GetService("Workspace").Map.HellDimension.Torch3:FindFirstChild("ProximityPrompt").Enabled == true then
												game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.HellDimension.Torch3.CFrame
												fask.wait(0.5)
												fireproximityprompt(game:GetService("Workspace").Map.HellDimension.Torch3.ProximityPrompt,4)
												fask.wait(0.5)
											end
										end
									else
										TorchTween = toTarget(CFrame.new(-22754.0684, 5170.49854, 2211.71655, 0.99075067, -8.39152818e-08, 0.13569501, 7.55450031e-08, 1, 6.68338842e-08, -0.13569501, -5.59646374e-08, 0.99075067))
									end
								elseif game.Players.LocalPlayer.Backpack:FindFirstChild("Hallow Essence") then
									Questtween = toTarget(game:GetService("Workspace").Map["Haunted Castle"].Summoner.Detection.Position,game:GetService("Workspace").Map["Haunted Castle"].Summoner.Detection.CFrame)
									if (game:GetService("Workspace").Map["Haunted Castle"].Summoner.Detection.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
										if Questtween then
											Questtween:Stop()
										end
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map["Haunted Castle"].Summoner.Detection.CFrame
									end
								elseif (game:GetService("Workspace").Enemies:FindFirstChild("Soul Reaper [Lv. 2100] [Raid Boss]") or game:GetService("ReplicatedStorage"):FindFirstChild("Soul Reaper [Lv. 2100] [Raid Boss]")) and not game:GetService("Workspace").Map:FindFirstChild("HellDimension") then
									if game:GetService("Workspace").Enemies:FindFirstChild("Soul Reaper [Lv. 2100] [Raid Boss]") then
										for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
											if AutoCursedDualKatana and v.Name == "Soul Reaper [Lv. 2100] [Raid Boss]" and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
												repeat fask.wait()
													if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
														Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
													elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
														if Farmtween then
															Farmtween:Stop()
														end
														EquipWeapon(SelectToolWeapon)
														game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(3, 1, 0)
													end
												until not AutoCursedDualKatana or (game:GetService("Workspace").Map:FindFirstChild("HellDimension") and tostring(game:GetService("Workspace").Map:FindFirstChild("HellDimension"):FindFirstChild("ActivePlayers").Value.Value) == game.Players.LocalPlayer.Name)
												fask.wait(5)
											end
										end
									else
										Questtween = toTarget(CFrame.new(-9521, 316, 6684).Position,CFrame.new(-9521, 316, 6684))
										if (CFrame.new(-9521, 316, 6684).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
											if Questtween then
												Questtween:Stop()
											end
											game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-9521, 316, 6684)
										end
									end
								else
									BoneCheck = _F("Bones","Buy",1,1)
									if BoneCheck ~= 1 then
										if game:GetService("Workspace").Enemies:FindFirstChild("Reborn Skeleton [Lv. 1975]") or game:GetService("Workspace").Enemies:FindFirstChild("Living Zombie [Lv. 2000]") or game:GetService("Workspace").Enemies:FindFirstChild("Demonic Soul [Lv. 2025]") or game:GetService("Workspace").Enemies:FindFirstChild("Posessed Mummy [Lv. 2050]") then
											for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
												if AutoCursedDualKatana and (v.Name == "Reborn Skeleton [Lv. 1975]" or v.Name == "Living Zombie [Lv. 2000]" or v.Name == "Demonic Soul [Lv. 2025]" or v.Name == "Posessed Mummy [Lv. 2050]") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
													repeat fask.wait()
														if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
															Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
															Usefastattack = false
														elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
															if Farmtween then Farmtween:Stop() end
															Usefastattack = true
															PosFarmBone = v.HumanoidRootPart.CFrame
															EquipWeapon(SelectToolWeapon)
															toAroundTarget(v.HumanoidRootPart.CFrame)
															MagnetFarmBone = true
														end
													until not AutoCursedDualKatana or not v.Parent or v.Humanoid.Health <= 0
													Usefastattack = false
													MagnetFarmBone = false
												end
											end
										else
											MagnetFarmBone = false
											Usefastattack = false
											Questtween = toTarget(CFrame.new(-9506.14648, 172.130661, 6101.79053).Position,CFrame.new(-9506.14648, 172.130661, 6101.79053))
											if (CFrame.new(-9506.14648, 172.130661, 6101.79053).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
												if Questtween then
													Questtween:Stop()
												end
												game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-9506.14648, 172.130661, 6101.79053, -0.999731541, 0, -0.0231563263, 0, 1, 0, 0.0231563263, 0, -0.999731541)
											end
										end
									end
								end
							elseif CheckPQuest.Good == -2 and CheckPQuest.Finished == false and CheckPQuest.Evil == -4 then
								if CheckNotNotifyHazeESP() then
									for i,v in pairs(game:GetService("CollectionService"):GetTagged("ActiveRig")) do
										if v:FindFirstChild("HazeESP") and AutoCursedDualKatana then
											if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
												repeat fask.wait()
													if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
														Farmtween = toTarget(v.HumanoidRootPart.CFrame * CFrame.new(1,20,0))
														Usefastattack = false
													elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
														if Farmtween then
															Farmtween:Stop()
														end
														for i2,v2 in pairs(game.Workspace.Enemies:GetChildren()) do
															if InMyNetWork(v.HumanoidRootPart) and v2.Name == v.Name and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("HazeESP") then
																v2.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
																v2.HumanoidRootPart.CanCollide = false
																v2.HumanoidRootPart.Size = Vector3.new(55,55,55)
															end
														end
														EquipWeapon(SelectToolWeapon)
														Usefastattack = true
														toAroundTarget(v.HumanoidRootPart.CFrame)
													end
												until not AutoCursedDualKatana or v.Humanoid.Health <= 0 or not v.Parent
												Usefastattack = false
											end
										end
									end
								else
									local notsamespawn = {}
									Usefastattack = false
									if game:GetService("Lighting").LightingLayers.Haze.Intensity.Value == 0 then
										fask.wait(0.2)
										_F("CDKQuest","StartTrial","Evil")
										if game:GetService("Lighting").LightingLayers.Haze.Intensity.Value == 0 then
											fask.wait(0.2)
											_F("CDKQuest","StartTrial","Evil")
											if game:GetService("Lighting").LightingLayers.Haze.Intensity.Value == 0 then
												ServerFunc:NormalTeleport()
											end
										end
									end
									for i,v in pairs(game:GetService("Workspace")["_WorldOrigin"]:FindFirstChild("EnemySpawns"):GetChildren()) do
										if AutoCursedDualKatana and not CheckNotNotifyHazeESP() and not table.find(notsamespawn,v.Name) then
											Notify({
												Title = "Alert!!!!",
												Text = "Wait For Mob Spawn",
												Timer = 3
											},"Warn")
											repeat fask.wait()
												Usefastattack = false
												Totartween = toTarget(v.CFrame * CFrame.new(1,30,0))
											until (v.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 or not AutoCursedDualKatana or CheckNotNotifyHazeESP()
											ErrorCount = ErrorCount + 1
											if Totartween then Totartween:Stop() end
											table.insert(notsamespawn,v.Name)
											if CheckNotNotifyHazeESP() then break end
											print(ErrorCount)
										end
									end
									if ErrorCount >= 100 then
										ServerFunc:NormalTeleport()
									end
								end
							elseif CheckPQuest.Good == -2 and CheckPQuest.Finished == false and CheckPQuest.Evil == -3 then
								if game.Workspace.Enemies:FindFirstChild("Mythological Pirate [Lv. 1850]") then
									DieMobTween = toTarget(CFrame.new(-13452.5224609375, 469.584228515625, -6870.68603515625))
									if (CFrame.new(-13452.5224609375, 469.584228515625, -6870.68603515625).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
										if DieMobTween then
											DieMobTween:Stop()
										end
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-13452.5224609375, 469.584228515625, -6870.68603515625)
									end
									for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
										if AutoCursedDualKatana and v.Name == "Mythological Pirate [Lv. 1850]" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
											if InMyNetWork(v.HumanoidRootPart) then
												v.HumanoidRootPart.CFrame = CFrame.new(-13449.36328125, 469.58416748046875, -6865.7822265625)
												v.HumanoidRootPart.CanCollide = false
											end
										end
									end
								else
									DieMobTween = toTarget(CFrame.new(-13452.5224609375, 469.584228515625, -6870.68603515625))
									if (CFrame.new(-13452.5224609375, 469.584228515625, -6870.68603515625).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
										if DieMobTween then
											BuddySwordsTween:Stop()
										end
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-13452.5224609375, 469.584228515625, -6870.68603515625)
									end
								end
							elseif CheckPQuest.Good == -5 and CheckPQuest.Finished == false and CheckPQuest.Evil == -2 then
								if game:GetService("Workspace").Map:FindFirstChild("HeavenlyDimension") and game:GetService("Workspace").Map.HeavenlyDimension:FindFirstChild("Exit") and game:GetService("Workspace").Map.HeavenlyDimension:FindFirstChild("Exit").Color ~= Color3.fromRGB(0, 0, 0) then
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.HeavenlyDimension:FindFirstChild("Exit").CFrame
								elseif game:GetService("Workspace").Map:FindFirstChild("HeavenlyDimension") and tostring(game:GetService("Workspace").Map:FindFirstChild("HeavenlyDimension"):FindFirstChild("ActivePlayers").Value.Value) == game.Players.LocalPlayer.Name then
									if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Heavenly Dimension").Position).Magnitude <= 500 then
										if TorchTween then TorchTween:Stop() end
										if CheckMobDistanceWorkspace(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Heavenly Dimension").Position,500) then
											for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
												if AutoCursedDualKatana and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
													repeat fask.wait()
														if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
															Farmtween = toTarget(v.HumanoidRootPart.CFrame * CFrame.new(1,20,0))
															Usefastattack = false
														elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
															if Farmtween then Farmtween:Stop() end
															spawn(function()
																NoDupeMob = 0.1
																for i2,v2 in pairs(game.Workspace.Enemies:GetChildren()) do
																	if InMyNetWork(v.HumanoidRootPart) and v2.Name == v.Name and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
																		v2.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(NoDupeMob,0,0)
																		v2.HumanoidRootPart.CanCollide = false
																		v2.HumanoidRootPart.Size = Vector3.new(55,55,55)
																		NoDupeMob = NoDupeMob + 0.2
																	end
																end
															end)

															game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(1,30,1)
															EquipWeapon(SelectToolWeapon)
															Usefastattack = true
														end
													until not AutoCursedDualKatana or game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health == 0 or v.Humanoid.Health == 0 or not v.Parent
													Usefastattack = false
												end
											end
										else
											if game:GetService("Workspace").Map.HeavenlyDimension.Torch1:FindFirstChild("ProximityPrompt").Enabled == true then
												game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.HeavenlyDimension.Torch1.CFrame
												fask.wait(0.5)
												fireproximityprompt(game:GetService("Workspace").Map.HeavenlyDimension.Torch1.ProximityPrompt,4)
												fask.wait(0.5)
											elseif game:GetService("Workspace").Map.HeavenlyDimension.Torch2:FindFirstChild("ProximityPrompt").Enabled == true then
												game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.HeavenlyDimension.Torch2.CFrame
												fask.wait(0.5)
												fireproximityprompt(game:GetService("Workspace").Map.HeavenlyDimension.Torch2.ProximityPrompt,4)
												fask.wait(0.5)
											elseif game:GetService("Workspace").Map.HeavenlyDimension.Torch3:FindFirstChild("ProximityPrompt").Enabled == true then
												game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.HeavenlyDimension.Torch3.CFrame
												fask.wait(0.5)
												fireproximityprompt(game:GetService("Workspace").Map.HeavenlyDimension.Torch3.ProximityPrompt,4)
												fask.wait(0.5)
											end
										end
									else
										TorchTween = toTarget(CFrame.new(-22709.6426, 5298.98584, 3886.63745, -1.1920929e-07, 0, 1.00000012, 0, 1, 0, -1.00000012, 0, -1.1920929e-07))
									end
								elseif game:GetService("ReplicatedStorage"):FindFirstChild("Cake Queen [Lv. 2175] [Boss]") or game.Workspace.Enemies:FindFirstChild("Cake Queen [Lv. 2175] [Boss]") then
									if game.Workspace.Enemies:FindFirstChild("Cake Queen [Lv. 2175] [Boss]") then
										for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
											if AutoCursedDualKatana and v.Name == "Cake Queen [Lv. 2175] [Boss]" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
												repeat fask.wait()
													Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
													if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
														if Farmtween then
															Farmtween:Stop()
														end
														EquipWeapon(SelectToolWeapon)
														Usefastattack = true
														toAroundTarget(v.HumanoidRootPart.CFrame)
													end
												until not AutoCursedDualKatana or v.Humanoid.Health <= 0 or not v.Parent or game:GetService("Workspace").Map:FindFirstChild("HeavenlyDimension") and tostring(game:GetService("Workspace").Map:FindFirstChild("HeavenlyDimension"):FindFirstChild("ActivePlayers").Value.Value) == game.Players.LocalPlayer.Name
												Usefastattack = false
												fask.wait(5)
											end
										end
									else
										BuddySwordsTween = toTarget(CFrame.new(-821, 66, -10965).Position,CFrame.new(-821, 66, -10965))
										if (CFrame.new(-821, 66, -10965).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
											if BuddySwordsTween then
												BuddySwordsTween:Stop()
											end
											game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-821, 66, -10965)
										end
									end
								elseif AutoCursedDualKatanaHop then
									Notify({
										Title = "Alert!!!!",
										Text = "Hop Not Find Big Mom",
										Timer = 3
									},"Warn")
									ServerFunc:TeleportFast()
								else
									Notify({
										Title = "Alert!!!!",
										Text = "Not Find Big Mom",
										Timer = 3
									},"Warn")
									BuddySwordsTween = toTarget(CFrame.new(-821, 66, -10965).Position,CFrame.new(-821, 66, -10965))
									if (CFrame.new(-821, 66, -10965).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
										if BuddySwordsTween then
											BuddySwordsTween:Stop()
										end
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-821, 66, -10965)
									end
									fask.wait(1)
								end
							elseif CheckPQuest.Good == -4 and CheckPQuest.Finished == false and CheckPQuest.Evil == -2 then
								if CheckMobDistanceCollection(Vector3.new(-5545.8134765625, 313.7655944824219, -2978.4912109375),1000) then
									for i,v in pairs(game:GetService("CollectionService"):GetTagged("ActiveRig")) do
										if AutoCursedDualKatana and not tostring(v.Name):match("%[Boss]$") and tostring(v.Name):find("%[Lv.") and v:FindFirstChild("HumanoidRootPart") then
											if (v.HumanoidRootPart.Position - Vector3.new(-5545.8134765625, 313.7655944824219, -2978.4912109375)).Magnitude <= 1000 then
												repeat fask.wait()
													if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
														Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
														Usefastattack = false
													elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
														if Farmtween then Farmtween:Stop() end
														Usefastattack = true
														PosCursedDualKatana = v.HumanoidRootPart.CFrame
														EquipWeapon(SelectToolWeapon)
														toAroundTarget(v.HumanoidRootPart.CFrame)
														MagnetCursedDualKatana = true
													end
												until not AutoCursedDualKatana or not v.Parent or v.Humanoid.Health <= 0
												Usefastattack = false
												MagnetCursedDualKatana = false
											end
										end
									end
								elseif AutoCursedDualKatanaHop then
									Notify({
										Title = "Alert!!!!",
										Text = "Hop Not Find Pirate Raids",
										Timer = 3
									},"Warn")
									ServerFunc:TeleportFast()
								else
									Notify({
										Title = "Alert!!!!",
										Text = "Not Find Pirate Raids",
										Timer = 3
									},"Warn")
									MagnetCursedDualKatana = false
									Usefastattack = false
									Questtween = toTarget(CFrame.new(-5544.12109375, 379.99822998046875, -2962.108642578125).Position,CFrame.new(-5544.12109375, 379.99822998046875, -2962.108642578125))
									if (CFrame.new(-9506.14648, 172.130661, 6101.79053).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
										if Questtween then
											Questtween:Stop()
										end
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-5544.12109375, 379.99822998046875, -2962.108642578125)
									end
									fask.wait(1)
								end
							elseif CheckPQuest.Good == -3 and CheckPQuest.Finished == false and CheckPQuest.Evil == -2 then
								CDKBoat = toTarget(CFrame.new(-6124.43115234375, 16.420757293701172, -2249.501953125))
								CDKBoat:Wait()
								_F("CDKQuest","BoatQuest",game:GetService("Workspace").NPCs:FindFirstChild("Luxury Boat Dealer"))
								fask.wait(0.1)
								CDKBoat = toTarget(CFrame.new(3234.458740234375, 9.432062149047852, 1597.3251953125))
								CDKBoat:Wait()
								_F("CDKQuest","BoatQuest",game:GetService("Workspace").NPCs:FindFirstChild("Luxury Boat Dealer"))
								fask.wait(0.1)
								CDKBoat = toTarget(CFrame.new(-9549.9443359375, 21.104869842529297, 4684.04931640625))
								CDKBoat:Wait()
								_F("CDKQuest","BoatQuest",game:GetService("Workspace").NPCs:FindFirstChild("Luxury Boat Dealer"))
								fask.wait(0.1)
							elseif CheckPQuest.Good < 4 then
								_F("CDKQuest","StartTrial","Good")
							elseif CheckPQuest.Evil < 4 then
								_F("CDKQuest","StartTrial","Evil")
							end
						else
							_F("CDKQuest","OpenDoor")
							_F("CDKQuest","OpenDoor",true)
							fask.wait(2)
						end
					end,function(e)
						print("CDK ERROR : "..e)
					end)
				else
					break
				end
			end
		end)
		spawn(function()
			while fask.wait() do
				if AutoCursedDualKatana then
					if MagnetFarmBone then
						for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
							if MagnetFarmBone  and AutoCursedDualKatana and (v.Name == "Reborn Skeleton [Lv. 1975]" or v.Name == "Living Zombie [Lv. 2000]" or v.Name == "Demonic Soul [Lv. 2025]" or v.Name == "Posessed Mummy [Lv. 2050]") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and (v.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
								if InMyNetWork(v.HumanoidRootPart) then
									v.HumanoidRootPart.CFrame = PosFarmBone
									v.HumanoidRootPart.CanCollide = false
									v.HumanoidRootPart.Size = Vector3.new(50,50,50)
								end
							end
						end
					end
				else
					break
				end
			end
		end)
		spawn(function()
			while fask.wait() do
				if AutoCursedDualKatana then
					if MagnetCursedDualKatana then
						for i,v in pairs(game:GetService("CollectionService"):GetTagged("ActiveRig")) do
							if MagnetCursedDualKatana and AutoCursedDualKatana and not tostring(v.Name):match("%[Boss]$") and tostring(v.Name):find("%[Lv.") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and (v.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
								if InMyNetWork(v.HumanoidRootPart) then
									v.HumanoidRootPart.CFrame = PosCursedDualKatana
									v.HumanoidRootPart.CanCollide = false
									v.HumanoidRootPart.Size = Vector3.new(55,55,55)
								end
							end
						end
					end
				else
					break
				end
			end
		end)
	end
end})

ConfigAutoCursedDualKatanaHop = AutoFarmMiscSea3PageRight:AddToggle("Auto Cursed Dual Katana Hop",{Stats = false , callback = function(starts)
	if ThreeWorld then
		AutoCursedDualKatana = starts
		AutoCursedDualKatanaHop = starts
		_G.ConfigMain["Auto Cursed Dual Katana Hop"] = starts
		SaveConfigAuto()
		spawn(function()
			while fask.wait() do
				if AutoCursedDualKatanaHop then
					xpcall(function()
						if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health == 0 then if tween then tween:Cancel() end repeat fask.wait() until game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health > 0; fask.wait(0.2) end
						if not game:GetService("Workspace").Map.Turtle.Cursed:FindFirstChild("Breakable") then
							local CheckPQuest
							if game:GetService("Workspace").Map.Turtle.Cursed:FindFirstChild("GoodScroll") then
								CheckPQuest = _F("CDKQuest","Progress","Good")
							else
								CheckPQuest = _F("CDKQuest","Progress","Evil")
							end

							if CheckPQuest.Good == 4 and CheckPQuest.Evil == 4 and CheckPQuest.Finished == true then

							elseif CheckPQuest.Good == 4 and CheckPQuest.Evil == 4 and not CheckPQuest.Finished then
								if inmyself("Yama") or inmyself("Tushita") then
									if game.Workspace.Enemies:FindFirstChild("Cursed Skeleton Boss [Lv. 2025] [Boss]") or game:GetService("ReplicatedStorage"):FindFirstChild("Cursed Skeleton Boss [Lv. 2025] [Boss]") then
										if KillBossTween then
											KillBossTween:Stop()
										end
										for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
											if AutoCursedDualKatana and v.Name == "Cursed Skeleton Boss [Lv. 2025] [Boss]" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
												repeat fask.wait()
													Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
													if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
														if Farmtween then
															Farmtween:Stop()
														end
														EquipWeapon(GetFightingStyle("Sword"))
														Usefastattack = true
														toAroundTarget(v.HumanoidRootPart.CFrame)
													end
												until not AutoCursedDualKatana or v.Humanoid.Health <= 0 or not v.Parent
												Usefastattack = false
											end
										end
									else
										if game:GetService("Workspace").Map.Turtle.Cursed.Pedestal3.ProximityPrompt.Enabled == false then
											KillBossTween = toTarget(CFrame.new(-12278.8193359375, 598.8648071289062, -6551.98876953125))
											_F("CDKQuest","StartTrial","Boss")
										else
											KillBossTween = toTarget(CFrame.new(-12361.7060546875, 603.3547973632812, -6550.5341796875))
											if (CFrame.new(-12361.7060546875, 603.3547973632812, -6550.5341796875).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
												if KillBossTween then
													KillBossTween:Stop()
												end
												game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-12361.7060546875, 603.3547973632812, -6550.5341796875)
												fask.wait(2)
												fireproximityprompt(game:GetService("Workspace").Map.Turtle.Cursed.Pedestal3.ProximityPrompt,0)
												print("F2")
											end
										end
									end
								else
									_F("StoreItem",tostring(GetFightingStyle("Sword")),inmyself(GetFightingStyle("Sword")))
									fask.wait(1)
									_F("LoadItem",tostring("Tushita"))
									fask.wait(1)
								end
							elseif CheckPQuest.Good == -2 and CheckPQuest.Finished == false and CheckPQuest.Evil == -5 then
								if game:GetService("Workspace").Map:FindFirstChild("HellDimension") and game:GetService("Workspace").Map.HellDimension:FindFirstChild("Exit") and game:GetService("Workspace").Map.HellDimension:FindFirstChild("Exit").Color ~= Color3.fromRGB(0, 0, 0) then
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.HellDimension:FindFirstChild("Exit").CFrame
								elseif game:GetService("Workspace").Map:FindFirstChild("HellDimension") and tostring(game:GetService("Workspace").Map:FindFirstChild("HellDimension"):FindFirstChild("ActivePlayers").Value.Value) == game.Players.LocalPlayer.Name then
									if Questtween then
										Questtween:Stop()
									end
									if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Hell Dimension").Position).Magnitude <= 500 then
										if TorchTween then TorchTween:Stop() end
										if CheckMobDistanceWorkspace(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Hell Dimension").Position,500) then
											for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
												if AutoCursedDualKatana and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
													repeat fask.wait()
														if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
															Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
															Usefastattack = false
														elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
															if Farmtween then Farmtween:Stop() end
															spawn(function()
																NoDupeMob = 0.1
																for i2,v2 in pairs(game.Workspace.Enemies:GetChildren()) do
																	if InMyNetWork(v.HumanoidRootPart) and v2.Name == v.Name and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
																		v2.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(NoDupeMob,0,0)
																		v2.HumanoidRootPart.CanCollide = false
																		v2.HumanoidRootPart.Size = Vector3.new(55,55,55)
																		NoDupeMob = NoDupeMob + 0.2
																	end
																end
															end)

															game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(1,30,1)
															EquipWeapon(SelectToolWeapon)
															Usefastattack = true
														end
													until not AutoCursedDualKatana or game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health == 0 or v.Humanoid.Health == 0 or not v.Parent
													Usefastattack = false
													fask.wait(2)
												end
											end
										else
											if game:GetService("Workspace").Map.HellDimension.Torch1:FindFirstChild("ProximityPrompt").Enabled == true then
												game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.HellDimension.Torch1.CFrame
												fask.wait(0.5)
												fireproximityprompt(game:GetService("Workspace").Map.HellDimension.Torch1.ProximityPrompt,4)
												fask.wait(0.5)
											elseif game:GetService("Workspace").Map.HellDimension.Torch2:FindFirstChild("ProximityPrompt").Enabled == true then
												game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.HellDimension.Torch2.CFrame
												fask.wait(0.5)
												fireproximityprompt(game:GetService("Workspace").Map.HellDimension.Torch2.ProximityPrompt,4)
												fask.wait(0.5)
											elseif game:GetService("Workspace").Map.HellDimension.Torch3:FindFirstChild("ProximityPrompt").Enabled == true then
												game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.HellDimension.Torch3.CFrame
												fask.wait(0.5)
												fireproximityprompt(game:GetService("Workspace").Map.HellDimension.Torch3.ProximityPrompt,4)
												fask.wait(0.5)
											end
										end
									else
										TorchTween = toTarget(CFrame.new(-22754.0684, 5170.49854, 2211.71655, 0.99075067, -8.39152818e-08, 0.13569501, 7.55450031e-08, 1, 6.68338842e-08, -0.13569501, -5.59646374e-08, 0.99075067))
									end
								elseif game.Players.LocalPlayer.Backpack:FindFirstChild("Hallow Essence") then
									Questtween = toTarget(game:GetService("Workspace").Map["Haunted Castle"].Summoner.Detection.Position,game:GetService("Workspace").Map["Haunted Castle"].Summoner.Detection.CFrame)
									if (game:GetService("Workspace").Map["Haunted Castle"].Summoner.Detection.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
										if Questtween then
											Questtween:Stop()
										end
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map["Haunted Castle"].Summoner.Detection.CFrame
									end
								elseif (game:GetService("Workspace").Enemies:FindFirstChild("Soul Reaper [Lv. 2100] [Raid Boss]") or game:GetService("ReplicatedStorage"):FindFirstChild("Soul Reaper [Lv. 2100] [Raid Boss]")) and not game:GetService("Workspace").Map:FindFirstChild("HellDimension") then
									if game:GetService("Workspace").Enemies:FindFirstChild("Soul Reaper [Lv. 2100] [Raid Boss]") then
										for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
											if AutoCursedDualKatana and v.Name == "Soul Reaper [Lv. 2100] [Raid Boss]" and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
												repeat fask.wait()
													if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
														Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
													elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
														if Farmtween then
															Farmtween:Stop()
														end
														EquipWeapon(SelectToolWeapon)
														game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(3, 1, 0)
													end
												until not AutoCursedDualKatana or (game:GetService("Workspace").Map:FindFirstChild("HellDimension") and tostring(game:GetService("Workspace").Map:FindFirstChild("HellDimension"):FindFirstChild("ActivePlayers").Value.Value) == game.Players.LocalPlayer.Name)
												fask.wait(5)
											end
										end
									else
										Questtween = toTarget(CFrame.new(-9521, 316, 6684).Position,CFrame.new(-9521, 316, 6684))
										if (CFrame.new(-9521, 316, 6684).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
											if Questtween then
												Questtween:Stop()
											end
											game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-9521, 316, 6684)
										end
									end
								else
									BoneCheck = _F("Bones","Buy",1,1)
									if AutoCursedDualKatanaHop and BoneCheck ~= 1 then
										ServerFunc:TeleportFast()
									end
								end
							elseif CheckPQuest.Good == -2 and CheckPQuest.Finished == false and CheckPQuest.Evil == -4 then
								if CheckNotNotifyHazeESP() then
									for i,v in pairs(game:GetService("CollectionService"):GetTagged("ActiveRig")) do
										if v:FindFirstChild("HazeESP") and AutoCursedDualKatana then
											if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
												repeat fask.wait()
													if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
														Farmtween = toTarget(v.HumanoidRootPart.CFrame * CFrame.new(1,20,0))
														Usefastattack = false
													elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
														if Farmtween then
															Farmtween:Stop()
														end
														for i2,v2 in pairs(game.Workspace.Enemies:GetChildren()) do
															if InMyNetWork(v.HumanoidRootPart) and v2.Name == v.Name and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("HazeESP") then
																v2.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
																v2.HumanoidRootPart.CanCollide = false
																v2.HumanoidRootPart.Size = Vector3.new(55,55,55)
															end
														end
														EquipWeapon(SelectToolWeapon)
														Usefastattack = true
														toAroundTarget(v.HumanoidRootPart.CFrame)
													end
												until not AutoCursedDualKatana or v.Humanoid.Health <= 0 or not v.Parent
												Usefastattack = false
											end
										end
									end
								else
									local notsamespawn = {}
									Usefastattack = false
									if game:GetService("Lighting").LightingLayers.Haze.Intensity.Value == 0 then
										fask.wait(0.2)
										_F("CDKQuest","StartTrial","Evil")
										if game:GetService("Lighting").LightingLayers.Haze.Intensity.Value == 0 then
											fask.wait(0.2)
											_F("CDKQuest","StartTrial","Evil")
											if game:GetService("Lighting").LightingLayers.Haze.Intensity.Value == 0 then
												ServerFunc:NormalTeleport()
											end
										end
									end
									for i,v in pairs(game:GetService("Workspace")["_WorldOrigin"]:FindFirstChild("EnemySpawns"):GetChildren()) do
										if AutoCursedDualKatana and not CheckNotNotifyHazeESP() and not table.find(notsamespawn,v.Name) then
											Notify({
												Title = "Alert!!!!",
												Text = "Wait For Mob Spawn",
												Timer = 3
											},"Warn")
											repeat fask.wait()
												Usefastattack = false
												Totartween = toTarget(v.CFrame * CFrame.new(1,30,0))
											until (v.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 or not AutoCursedDualKatana or CheckNotNotifyHazeESP()
											ErrorCount = ErrorCount + 1
											if Totartween then Totartween:Stop() end
											table.insert(notsamespawn,v.Name)
											if CheckNotNotifyHazeESP() then break end
											print(ErrorCount)
										end
									end
									if ErrorCount >= 100 then
										ServerFunc:NormalTeleport()
									end
								end
							elseif CheckPQuest.Good == -2 and CheckPQuest.Finished == false and CheckPQuest.Evil == -3 then
								if game.Workspace.Enemies:FindFirstChild("Mythological Pirate [Lv. 1850]") then
									DieMobTween = toTarget(CFrame.new(-13452.5224609375, 469.584228515625, -6870.68603515625))
									if (CFrame.new(-13452.5224609375, 469.584228515625, -6870.68603515625).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
										if DieMobTween then
											DieMobTween:Stop()
										end
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-13452.5224609375, 469.584228515625, -6870.68603515625)
									end
									for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
										if AutoCursedDualKatana and v.Name == "Mythological Pirate [Lv. 1850]" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
											if InMyNetWork(v.HumanoidRootPart) then
												v.HumanoidRootPart.CFrame = CFrame.new(-13449.36328125, 469.58416748046875, -6865.7822265625)
												v.HumanoidRootPart.CanCollide = false
											end
										end
									end
								else
									DieMobTween = toTarget(CFrame.new(-13452.5224609375, 469.584228515625, -6870.68603515625))
									if (CFrame.new(-13452.5224609375, 469.584228515625, -6870.68603515625).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
										if DieMobTween then
											BuddySwordsTween:Stop()
										end
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-13452.5224609375, 469.584228515625, -6870.68603515625)
									end
								end
							elseif CheckPQuest.Good == -5 and CheckPQuest.Finished == false and CheckPQuest.Evil == -2 then
								if game:GetService("Workspace").Map:FindFirstChild("HeavenlyDimension") and game:GetService("Workspace").Map.HeavenlyDimension:FindFirstChild("Exit") and game:GetService("Workspace").Map.HeavenlyDimension:FindFirstChild("Exit").Color ~= Color3.fromRGB(0, 0, 0) then
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.HeavenlyDimension:FindFirstChild("Exit").CFrame
								elseif game:GetService("Workspace").Map:FindFirstChild("HeavenlyDimension") and tostring(game:GetService("Workspace").Map:FindFirstChild("HeavenlyDimension"):FindFirstChild("ActivePlayers").Value.Value) == game.Players.LocalPlayer.Name then
									if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Heavenly Dimension").Position).Magnitude <= 500 then
										if TorchTween then TorchTween:Stop() end
										if CheckMobDistanceWorkspace(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Heavenly Dimension").Position,500) then
											for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
												if AutoCursedDualKatana and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
													repeat fask.wait()
														if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
															Farmtween = toTarget(v.HumanoidRootPart.CFrame * CFrame.new(1,20,0))
															Usefastattack = false
														elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
															if Farmtween then Farmtween:Stop() end
															spawn(function()
																NoDupeMob = 0.1
																for i2,v2 in pairs(game.Workspace.Enemies:GetChildren()) do
																	if InMyNetWork(v.HumanoidRootPart) and v2.Name == v.Name and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
																		v2.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(NoDupeMob,0,0)
																		v2.HumanoidRootPart.CanCollide = false
																		v2.HumanoidRootPart.Size = Vector3.new(55,55,55)
																		NoDupeMob = NoDupeMob + 0.2
																	end
																end
															end)

															game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(1,30,1)
															EquipWeapon(SelectToolWeapon)
															Usefastattack = true
														end
													until not AutoCursedDualKatana or game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health == 0 or v.Humanoid.Health == 0 or not v.Parent
													Usefastattack = false
												end
											end
										else
											if game:GetService("Workspace").Map.HeavenlyDimension.Torch1:FindFirstChild("ProximityPrompt").Enabled == true then
												game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.HeavenlyDimension.Torch1.CFrame
												fask.wait(0.5)
												fireproximityprompt(game:GetService("Workspace").Map.HeavenlyDimension.Torch1.ProximityPrompt,4)
												fask.wait(0.5)
											elseif game:GetService("Workspace").Map.HeavenlyDimension.Torch2:FindFirstChild("ProximityPrompt").Enabled == true then
												game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.HeavenlyDimension.Torch2.CFrame
												fask.wait(0.5)
												fireproximityprompt(game:GetService("Workspace").Map.HeavenlyDimension.Torch2.ProximityPrompt,4)
												fask.wait(0.5)
											elseif game:GetService("Workspace").Map.HeavenlyDimension.Torch3:FindFirstChild("ProximityPrompt").Enabled == true then
												game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.HeavenlyDimension.Torch3.CFrame
												fask.wait(0.5)
												fireproximityprompt(game:GetService("Workspace").Map.HeavenlyDimension.Torch3.ProximityPrompt,4)
												fask.wait(0.5)
											end
										end
									else
										TorchTween = toTarget(CFrame.new(-22709.6426, 5298.98584, 3886.63745, -1.1920929e-07, 0, 1.00000012, 0, 1, 0, -1.00000012, 0, -1.1920929e-07))
									end
								elseif game:GetService("ReplicatedStorage"):FindFirstChild("Cake Queen [Lv. 2175] [Boss]") or game.Workspace.Enemies:FindFirstChild("Cake Queen [Lv. 2175] [Boss]") then
									if game.Workspace.Enemies:FindFirstChild("Cake Queen [Lv. 2175] [Boss]") then
										for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
											if AutoCursedDualKatana and v.Name == "Cake Queen [Lv. 2175] [Boss]" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
												repeat fask.wait()
													Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
													if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
														if Farmtween then
															Farmtween:Stop()
														end
														EquipWeapon(SelectToolWeapon)
														Usefastattack = true
														toAroundTarget(v.HumanoidRootPart.CFrame)
													end
												until not AutoCursedDualKatana or v.Humanoid.Health <= 0 or not v.Parent or game:GetService("Workspace").Map:FindFirstChild("HeavenlyDimension") and tostring(game:GetService("Workspace").Map:FindFirstChild("HeavenlyDimension"):FindFirstChild("ActivePlayers").Value.Value) == game.Players.LocalPlayer.Name
												Usefastattack = false
												fask.wait(5)
											end
										end
									else
										BuddySwordsTween = toTarget(CFrame.new(-821, 66, -10965).Position,CFrame.new(-821, 66, -10965))
										if (CFrame.new(-821, 66, -10965).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
											if BuddySwordsTween then
												BuddySwordsTween:Stop()
											end
											game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-821, 66, -10965)
										end
									end
								elseif AutoCursedDualKatanaHop then
									Notify({
										Title = "Alert!!!!",
										Text = "Hop Not Find Big Mom",
										Timer = 3
									},"Warn")
									ServerFunc:TeleportFast()
								else
									Notify({
										Title = "Alert!!!!",
										Text = "Not Find Big Mom",
										Timer = 3
									},"Warn")
									BuddySwordsTween = toTarget(CFrame.new(-821, 66, -10965).Position,CFrame.new(-821, 66, -10965))
									if (CFrame.new(-821, 66, -10965).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
										if BuddySwordsTween then
											BuddySwordsTween:Stop()
										end
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-821, 66, -10965)
									end
									fask.wait(1)
								end
							elseif CheckPQuest.Good == -4 and CheckPQuest.Finished == false and CheckPQuest.Evil == -2 then
								if CheckMobDistanceCollection(Vector3.new(-5545.8134765625, 313.7655944824219, -2978.4912109375),1000) then
									for i,v in pairs(game:GetService("CollectionService"):GetTagged("ActiveRig")) do
										if AutoCursedDualKatana and not tostring(v.Name):match("%[Boss]$") and tostring(v.Name):find("%[Lv.") and v:FindFirstChild("HumanoidRootPart") then
											if (v.HumanoidRootPart.Position - Vector3.new(-5545.8134765625, 313.7655944824219, -2978.4912109375)).Magnitude <= 1000 then
												repeat fask.wait()
													if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
														Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
														Usefastattack = false
													elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
														if Farmtween then Farmtween:Stop() end
														Usefastattack = true
														PosCursedDualKatana = v.HumanoidRootPart.CFrame
														EquipWeapon(SelectToolWeapon)
														toAroundTarget(v.HumanoidRootPart.CFrame)
														MagnetCursedDualKatana = true
													end
												until not AutoCursedDualKatana or not v.Parent or v.Humanoid.Health <= 0
												Usefastattack = false
												MagnetCursedDualKatana = false
											end
										end
									end
								elseif AutoCursedDualKatanaHop then
									Notify({
										Title = "Alert!!!!",
										Text = "Hop Not Find Pirate Raids",
										Timer = 3
									},"Warn")
									ServerFunc:TeleportFast()
								else
									Notify({
										Title = "Alert!!!!",
										Text = "Not Find Pirate Raids",
										Timer = 3
									},"Warn")
									MagnetCursedDualKatana = false
									Usefastattack = false
									Questtween = toTarget(CFrame.new(-5544.12109375, 379.99822998046875, -2962.108642578125).Position,CFrame.new(-5544.12109375, 379.99822998046875, -2962.108642578125))
									if (CFrame.new(-9506.14648, 172.130661, 6101.79053).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
										if Questtween then
											Questtween:Stop()
										end
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-5544.12109375, 379.99822998046875, -2962.108642578125)
									end
									fask.wait(1)
								end
							elseif CheckPQuest.Good == -3 and CheckPQuest.Finished == false and CheckPQuest.Evil == -2 then
								CDKBoat = toTarget(CFrame.new(-6124.43115234375, 16.420757293701172, -2249.501953125))
								CDKBoat:Wait()
								_F("CDKQuest","BoatQuest",game:GetService("Workspace").NPCs:FindFirstChild("Luxury Boat Dealer"))
								fask.wait(0.1)
								CDKBoat = toTarget(CFrame.new(3234.458740234375, 9.432062149047852, 1597.3251953125))
								CDKBoat:Wait()
								_F("CDKQuest","BoatQuest",game:GetService("Workspace").NPCs:FindFirstChild("Luxury Boat Dealer"))
								fask.wait(0.1)
								CDKBoat = toTarget(CFrame.new(-9549.9443359375, 21.104869842529297, 4684.04931640625))
								CDKBoat:Wait()
								_F("CDKQuest","BoatQuest",game:GetService("Workspace").NPCs:FindFirstChild("Luxury Boat Dealer"))
								fask.wait(0.1)
							elseif CheckPQuest.Good < 4 then
								_F("CDKQuest","StartTrial","Good")
							elseif CheckPQuest.Evil < 4 then
								_F("CDKQuest","StartTrial","Evil")
							end
						else
							_F("CDKQuest","OpenDoor")
							_F("CDKQuest","OpenDoor",true)
							fask.wait(2)
						end
					end,function(e)
						print("CDK ERROR : "..e)
					end)
				else
					break
				end
			end
		end)
		spawn(function()
			while fask.wait() do
				if AutoCursedDualKatana then
					if MagnetCursedDualKatana then
						for i,v in pairs(game:GetService("CollectionService"):GetTagged("ActiveRig")) do
							if MagnetCursedDualKatana and AutoCursedDualKatana and not tostring(v.Name):match("%[Boss]$") and tostring(v.Name):find("%[Lv.") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and (v.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
								if InMyNetWork(v.HumanoidRootPart) then
									v.HumanoidRootPart.CFrame = PosCursedDualKatana
									v.HumanoidRootPart.CanCollide = false
									v.HumanoidRootPart.Size = Vector3.new(55,55,55)
								end
							end
						end
					end
				else
					break
				end
			end
		end)
	end
end})

AutoFarmMiscSea3PageRight:AddLabel("~ 🎸 Auto Pirate Raids 🎸 ~")

ConfigAutoPirateRaids = AutoFarmMiscSea3PageRight:AddToggle("Auto Pirate Raids",{Stats = false , callback = function(starts)
	if ThreeWorld then
		AutoPirateRaids = starts
		_G.ConfigMain["Auto Pirate Raids"] = starts
		SaveConfigAuto()
		spawn(function()
			while fask.wait() do
				if AutoPirateRaids then
					if CheckMobDistanceCollection(Vector3.new(-5545.8134765625, 313.7655944824219, -2978.4912109375),1000) then
						for i,v in pairs(game:GetService("CollectionService"):GetTagged("ActiveRig")) do
							if AutoPirateRaids and not tostring(v.Name):match("%[Boss]$") and tostring(v.Name):find("%[Lv.") and v:FindFirstChild("HumanoidRootPart") then
								if (v.HumanoidRootPart.Position - Vector3.new(-5545.8134765625, 313.7655944824219, -2978.4912109375)).Magnitude <= 1000 then
									repeat fask.wait()
										if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
											Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
											Usefastattack = false
										elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
											if Farmtween then Farmtween:Stop() end
											Usefastattack = true
											PosPirateRaids = v.HumanoidRootPart.CFrame
											EquipWeapon(SelectToolWeapon)
											toAroundTarget(v.HumanoidRootPart.CFrame)
											MagnetPirateRaids = true
										end
									until not AutoPirateRaids or not v.Parent or v.Humanoid.Health <= 0
									Usefastattack = false
									MagnetPirateRaids = false
								end
							end
						end
					elseif AutoPirateRaidsHop then
						ServerFunc:TeleportFast()
					else
						MagnetPirateRaids = false
						Usefastattack = false
						Questtween = toTarget(CFrame.new(-5544.12109375, 379.99822998046875, -2962.108642578125).Position,CFrame.new(-5544.12109375, 379.99822998046875, -2962.108642578125))
						if (CFrame.new(-9506.14648, 172.130661, 6101.79053).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
							if Questtween then
								Questtween:Stop()
							end
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-5544.12109375, 379.99822998046875, -2962.108642578125)
						end
					end
				else
					break
				end
			end
		end)
		spawn(function()
			while fask.wait() do
				if AutoPirateRaids then
					if MagnetPirateRaids then
						for i,v in pairs(game:GetService("CollectionService"):GetTagged("ActiveRig")) do
							if MagnetPirateRaids and AutoPirateRaids and not tostring(v.Name):match("%[Boss]$") and tostring(v.Name):find("%[Lv.") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and (v.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
								if InMyNetWork(v.HumanoidRootPart) then
									v.HumanoidRootPart.CFrame = PosPirateRaids
									v.HumanoidRootPart.CanCollide = false
									v.HumanoidRootPart.Size = Vector3.new(55,55,55)
								end
							end
						end
					end
				else
					break
				end
			end
		end)
	end
end})

ConfigAutoPirateRaidsHop = AutoFarmMiscSea3PageRight:AddToggle("Auto Pirate Raids Hop",{Stats = false , callback = function(starts)
	if ThreeWorld then
		AutoPirateRaids = starts
		AutoPirateRaidsHop = starts
		_G.ConfigMain["Auto Pirate Raids"] = starts
		SaveConfigAuto()
		spawn(function()
			while fask.wait() do
				if AutoPirateRaids then
					if CheckMobDistanceCollection(Vector3.new(-5545.8134765625, 313.7655944824219, -2978.4912109375),1000) then
						for i,v in pairs(game:GetService("CollectionService"):GetTagged("ActiveRig")) do
							if AutoPirateRaids and not tostring(v.Name):match("%[Boss]$") and tostring(v.Name):find("%[Lv.") and v:FindFirstChild("HumanoidRootPart") then
								if (v.HumanoidRootPart.Position - Vector3.new(-5545.8134765625, 313.7655944824219, -2978.4912109375)).Magnitude <= 1000 then
									repeat fask.wait()
										if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
											Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
											Usefastattack = false
										elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
											if Farmtween then Farmtween:Stop() end
											Usefastattack = true
											PosPirateRaids = v.HumanoidRootPart.CFrame
											EquipWeapon(SelectToolWeapon)
											toAroundTarget(v.HumanoidRootPart.CFrame)
											MagnetPirateRaids = true
										end
									until not AutoPirateRaids or not v.Parent or v.Humanoid.Health <= 0
									Usefastattack = false
									MagnetPirateRaids = false
								end
							end
						end
					elseif AutoPirateRaidsHop then
						ServerFunc:TeleportFast()
					else
						MagnetPirateRaids = false
						Usefastattack = false
						Questtween = toTarget(CFrame.new(-5544.12109375, 379.99822998046875, -2962.108642578125).Position,CFrame.new(-5544.12109375, 379.99822998046875, -2962.108642578125))
						if (CFrame.new(-9506.14648, 172.130661, 6101.79053).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
							if Questtween then
								Questtween:Stop()
							end
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-5544.12109375, 379.99822998046875, -2962.108642578125)
						end
					end
				else
					break
				end
			end
		end)
		spawn(function()
			while fask.wait() do
				if AutoPirateRaids then
					if MagnetPirateRaids then
						for i,v in pairs(game:GetService("CollectionService"):GetTagged("ActiveRig")) do
							if MagnetPirateRaids and AutoPirateRaids and not tostring(v.Name):match("%[Boss]$") and tostring(v.Name):find("%[Lv.") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and (v.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
								if InMyNetWork(v.HumanoidRootPart) then
									v.HumanoidRootPart.CFrame = PosPirateRaids
									v.HumanoidRootPart.CanCollide = false
									v.HumanoidRootPart.Size = Vector3.new(55,55,55)
								end
							end
						end
					end
				else
					break
				end
			end
		end)
	end
end})

AutoFarmMiscSea3PageRight:AddLabel("~ 🎸 Auto Unlock Soul Guitar 🎸 ~")

ConfigAutoUnlockSoulGuitar = AutoFarmMiscSea3PageRight:AddToggle("Auto Unlock Soul Guitar",{Stats = false , callback = function(starts)
	if ThreeWorld then
		AutoUnlockSoulGuitar = starts
		_G.ConfigMain["Auto Unlock SoulGuitar"] = starts
		SaveConfigAuto()
		spawn(function()
			while fask.wait() do
				if AutoUnlockSoulGuitar then
					if _F("GuitarPuzzleProgress","Check") ~= nil then
						CheckGuitar = _F("GuitarPuzzleProgress","Check")
						if CheckGuitar.Swamp == false then
							if Auto_Farm_Level then FarmLevel = false end
							if game:GetService("Workspace").Map["Haunted Castle"]:FindFirstChild("SwampWater").Color == Color3.fromRGB(117, 0, 0) then
								if game:GetService("Workspace").Enemies:FindFirstChild("Living Zombie [Lv. 2000]") then
									for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
										if AutoUnlockSoulGuitar and v.Name == "Living Zombie [Lv. 2000]" and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
											repeat fask.wait()
												if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
													Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
													MagnetFarmSoulGuitar = true
												elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
													MagnetFarmSoulGuitar = true
													if Farmtween then
														Farmtween:Stop()
													end
													EquipWeapon(SelectToolWeapon)
													v.HumanoidRootPart.CFrame = CFrame.new(-10139.9404296875, 138.6524658203125, 5963.72216796875)
													v.HumanoidRootPart.Size = Vector3.new(55,55,55)
													game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-10139.9404296875, 168.6524658203125, 5983.72216796875)
													fask.wait(3)
													Usefastattack = true
												end
											until not AutoUnlockSoulGuitar or not v.Parent or v.Humanoid.Health <= 0
											Usefastattack = false
											MagnetFarmSoulGuitar = false
										end
									end
								else
									Usefastattack = false
									MagnetFarmSoulGuitar = false
									Questtween = toTarget(CFrame.new(-10139.9404296875, 148.6524658203125, 5963.72216796875))
									if (CFrame.new(-10139.9404296875, 148.6524658203125, 5963.72216796875).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
										if Questtween then Questtween:Stop() end
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-10139.9404296875, 148.6524658203125, 5963.72216796875)
										fask.wait(1)
									end
									fask.wait(3)
								end
							end
						elseif CheckGuitar.Gravestones == false then
							_F("GuitarPuzzleProgress","Gravestones")
						elseif CheckGuitar.Ghost == false then
							_F("GuitarPuzzleProgress","Ghost")
						elseif CheckGuitar.Trophies == false then
							_F("GuitarPuzzleProgress","Trophies")
						elseif CheckGuitar.Pipes == false then
							_F("GuitarPuzzleProgress","Pipes")
						elseif CheckGuitar.CraftedOnce == false then
							if Auto_Farm_Level then FarmLevel = true end
							_F("soulGuitarBuy")
							fask.wait(2)
						end
						fask.wait(1)
					else
						if game:GetService("Lighting"):GetAttribute("MoonPhase") == 5 and CheckNight() then
							if Auto_Farm_Level then FarmLevel = false end
							GuitarTween = toTarget(CFrame.new(-8654.7158203125, 141.83416748046875, 6169.04150390625))
							GuitarTween:Wait()
							_F("gravestoneEvent", 2, true)
						else
							if Auto_Farm_Level then FarmLevel = true end
						end
					end
				else
					break;
				end
			end
		end)
		spawn(function()
			local DisConBring
			DisConBring = game:GetService("RunService").RenderStepped:Connect(function()
				if AutoUnlockSoulGuitar then
					if MagnetFarmSoulGuitar then
						local CountAddMobPos = 1
						for i,v in pairs(game:GetService("CollectionService"):GetTagged("ActiveRig")) do
							if MagnetFarmSoulGuitar  and AutoUnlockSoulGuitar and v.Name == "Living Zombie [Lv. 2000]" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and (v.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
								if InMyNetWork(v.HumanoidRootPart) then
									v.HumanoidRootPart.CFrame = CFrame.new(-10139.9404296875, 138.6524658203125, 5963.72216796875) + CFrame.new(-10139.9404296875, 138.6524658203125, 5963.72216796875).LookVector * (CountAddMobPos * 2)
									v.HumanoidRootPart.CanCollide = false
									v.HumanoidRootPart.Size = Vector3.new(55,55,55)
									CountAddMobPos = CountAddMobPos + 1
								end
							end
						end
					end
				else
					DisConBring:Disconnect()
				end
			end)
		end)
	end
end})

ConfigAutoUnlockSoulGuitarHop = AutoFarmMiscSea3PageRight:AddToggle("Auto Unlock Soul Guitar Hop",{Stats = false , callback = function(starts)
	if ThreeWorld then
		AutoUnlockSoulGuitar = starts
		AutoUnlockSoulGuitarHop = starts
		_G.ConfigMain["Auto Unlock SoulGuitar Hop"] = starts
		SaveConfigAuto()
		spawn(function()
			while fask.wait() do
				if AutoUnlockSoulGuitarHop then
					if _F("GuitarPuzzleProgress","Check") ~= nil then
						CheckGuitar = _F("GuitarPuzzleProgress","Check")
						if CheckGuitar.Swamp == false then
							if game:GetService("Workspace").Map["Haunted Castle"]:FindFirstChild("SwampWater").Color == Color3.fromRGB(117, 0, 0) then
								if game:GetService("Workspace").Enemies:FindFirstChild("Living Zombie [Lv. 2000]") then
									for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
										if AutoUnlockSoulGuitar and v.Name == "Living Zombie [Lv. 2000]" and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
											repeat fask.wait()
												if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
													Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
													MagnetFarmSoulGuitar = true
												elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
													MagnetFarmSoulGuitar = true
													if Farmtween then
														Farmtween:Stop()
													end
													EquipWeapon(SelectToolWeapon)
													v.HumanoidRootPart.CFrame = CFrame.new(-10139.9404296875, 138.6524658203125, 5963.72216796875)
													v.HumanoidRootPart.Size = Vector3.new(55,55,55)
													game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-10139.9404296875, 168.6524658203125, 5983.72216796875)
													fask.wait(0.2)
													Usefastattack = true
												end
											until not AutoUnlockSoulGuitar or not v.Parent or v.Humanoid.Health <= 0
											Usefastattack = false
											MagnetFarmSoulGuitar = false
										end
									end
								else
									Usefastattack = false
									MagnetFarmSoulGuitar = false
									Questtween = toTarget(CFrame.new(-10139.9404296875, 148.6524658203125, 5963.72216796875))
									if (CFrame.new(-10139.9404296875, 148.6524658203125, 5963.72216796875).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
										if Questtween then Questtween:Stop() end
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-10139.9404296875, 148.6524658203125, 5963.72216796875)
										fask.wait(1)
									end
									fask.wait(3)
								end
							end
						elseif CheckGuitar.Gravestones == false then
							_F("GuitarPuzzleProgress","Gravestones")
						elseif CheckGuitar.Ghost == false then
							_F("GuitarPuzzleProgress","Ghost")
						elseif CheckGuitar.Trophies == false then
							_F("GuitarPuzzleProgress","Trophies")
						elseif CheckGuitar.Pipes == false then
							_F("GuitarPuzzleProgress","Pipes")
						elseif CheckGuitar.CraftedOnce == false then
							_F("soulGuitarBuy")
							fask.wait(2)
						end
						fask.wait(1)
					else
						if game:GetService("Lighting"):GetAttribute("MoonPhase") == 5 and CheckNight() then
							GuitarTween = toTarget(CFrame.new(-8654.7158203125, 141.83416748046875, 6169.04150390625))
							GuitarTween:Wait()
							_F("gravestoneEvent", 2, true)
						elseif AutoUnlockSoulGuitarHop then
							spawn(function()
								ServerFunc:NormalTeleport()
							end)
							ServerFunc:TeleportFast()
						end
					end
				else
					break;
				end
			end
		end)
		spawn(function()
			local DisConBring
			DisConBring = game:GetService("RunService").RenderStepped:Connect(function()
				if AutoUnlockSoulGuitar then
					if MagnetFarmSoulGuitar then
						local CountAddMobPos = 1
						for i,v in pairs(game:GetService("CollectionService"):GetTagged("ActiveRig")) do
							if MagnetFarmSoulGuitar  and AutoUnlockSoulGuitar and v.Name == "Living Zombie [Lv. 2000]" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and (v.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
								if InMyNetWork(v.HumanoidRootPart) then
									v.HumanoidRootPart.CFrame = CFrame.new(-10139.9404296875, 138.6524658203125, 5963.72216796875) + CFrame.new(-10139.9404296875, 138.6524658203125, 5963.72216796875).LookVector * (CountAddMobPos * 2)
									v.HumanoidRootPart.CanCollide = false
									v.HumanoidRootPart.Size = Vector3.new(55,55,55)
									CountAddMobPos = CountAddMobPos + 1
								end
							end
						end
					end
				else
					DisConBring:Disconnect()
				end
			end)
		end)
	end
end})

AutoFarmMiscSea3PageRight:AddLabel("~ 🍮 Auto Unlock Dough Raids 🍮 ~")

ConfigAutoDoughKing = AutoFarmMiscSea3PageRight:AddToggle("Auto Dough King",{Stats = false , callback = function(starts)
	if ThreeWorld then
		AutoDoughKing = starts
		_G.ConfigMain["Auto Dough King"] = starts
		SaveConfigAuto()
		spawn(function()
			while fask.wait() do
				if AutoDoughKing then
					if game.Workspace:FindFirstChild("Enemies"):FindFirstChild("Dough King [Lv. 2300] [Raid Boss]") or game:GetService("ReplicatedStorage"):FindFirstChild("Dough King [Lv. 2300] [Raid Boss]") then
						if game:GetService("Workspace").Enemies:FindFirstChild("Dough King [Lv. 2300] [Raid Boss]") then
							for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
								if AutoDoughKing and v.Name == "Dough King [Lv. 2300] [Raid Boss]" and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
									repeat fask.wait()
										if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
											Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
										elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
											if Farmtween then
												Farmtween:Stop()
											end
											EquipWeapon(SelectToolWeapon)
											v.HumanoidRootPart.Size = Vector3.new(55,55,55)
											Usefastattack = true
											toAroundTarget(v.HumanoidRootPart.CFrame)
										end
									until not AutoDoughKing or not v.Parent or v.Humanoid.Health <= 0 or game:GetService("ReplicatedStorage"):FindFirstChild("Dough King [Lv. 2300] [Raid Boss]")
									Usefastattack = false
								end
							end
						else
							if game:GetService("Workspace").Map.CakeLoaf.BigMirror.Other.Transparency == 0 then
								Usefastattack = false
								Questtween = toTarget(CFrame.new(-2151.82153, 149.315704, -12404.9053).Position,CFrame.new(-2151.82153, 149.315704, -12404.9053))
								if (CFrame.new(-2151.82153, 149.315704, -12404.9053).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
									if Questtween then Questtween:Stop() end
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2151.82153, 149.315704, -12404.9053)
									fask.wait(1)
								end
							end
						end
					elseif game.Players.LocalPlayer.Character:FindFirstChild("Sweet Chalice") or game.Players.LocalPlayer.Backpack:FindFirstChild("Sweet Chalice") then
						--if string.find(tostring(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner", true)),"already") then

						--else
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner", true)
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")
						if game:GetService("Workspace").Enemies:FindFirstChild("Cookie Crafter [Lv. 2200]") or game:GetService("Workspace").Enemies:FindFirstChild("Cake Guard [Lv. 2225]") or game:GetService("Workspace").Enemies:FindFirstChild("Baking Staff [Lv. 2250]") or game:GetService("Workspace").Enemies:FindFirstChild("Head Baker [Lv. 2275]") then
							for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
								if AutoDoughKing and (v.Name == "Cookie Crafter [Lv. 2200]" or v.Name == "Cake Guard [Lv. 2225]" or v.Name == "Baking Staff [Lv. 2250]" or v.Name == "Head Baker [Lv. 2275]") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
									repeat fask.wait()
										if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
											Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
										elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
											if Farmtween then Farmtween:Stop() end
											Usefastattack = true
											PosFarmCakePrince = v.HumanoidRootPart.CFrame
											EquipWeapon(SelectToolWeapon)
											toAroundTarget(v.HumanoidRootPart.CFrame)
											MagnetFarmCakePrince = true
											game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner", true)
											game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")
										end
									until not AutoDoughKing or not v.Parent or v.Humanoid.Health <= 0
									Usefastattack = false
									MagnetFarmCakePrince = false
								end
							end
						else
							MagnetFarmCakePrince = false
							Usefastattack = false
							Questtween = toTarget(CFrame.new(-2077, 252, -12373).Position,CFrame.new(-2077, 252, -12373))
							if (CFrame.new(-2077, 252, -12373).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
								if Questtween then Questtween:Stop() end
								game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2077, 252, -12373)
							end
						end

						--end
					elseif (game.Players.LocalPlayer.Backpack:FindFirstChild("God's Chalice") or game.Players.LocalPlayer.Character:FindFirstChild("God's Chalice")) and GetMaterial("Conjured Cocoa") >= 10 then
						game.ReplicatedStorage.Remotes.CommF_:InvokeServer("SweetChaliceNpc")
						fask.wait(0.2)
					elseif not game.Players.LocalPlayer.Backpack:FindFirstChild("God's Chalice") and not game.Players.LocalPlayer.Character:FindFirstChild("God's Chalice") and (game.Workspace.Enemies:FindFirstChild("Deandre [Lv. 1750]") or game.Workspace.Enemies:FindFirstChild("Urban [Lv. 1750]") or game.Workspace.Enemies:FindFirstChild("Diablo [Lv. 1750]") or game.ReplicatedStorage:FindFirstChild("Deandre [Lv. 1750]") or game.ReplicatedStorage:FindFirstChild("Urban [Lv. 1750]") or game.ReplicatedStorage:FindFirstChild("Diablo [Lv. 1750]")) then
						if game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == true then
							if string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Diablo") or string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Urban") or string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Deandre") then
								for i,v in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
									if string.find(v.Name,"Diablo") then
										DoughTween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
										if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
											if DoughTween then
												DoughTween:Stop()
											end
											game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
										end
									end
									if string.find(v.Name,"Urban") then
										DoughTween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
										if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
											if DoughTween then
												DoughTween:Stop()
											end
											game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
										end
									end
									if string.find(v.Name,"Deandre") then
										DoughTween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
										if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
											if DoughTween then
												DoughTween:Stop()
											end
											game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
										end
									end
								end
								for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
									if AutoDoughKing and string.find(v.Name,"Diablo") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
										repeat fask.wait()
											if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
												Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
											elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
												if Farmtween then
													Farmtween:Stop()
												end
												EquipWeapon(SelectToolWeapon)
												Usefastattack = true
												toAroundTarget(v.HumanoidRootPart.CFrame)
											end
										until not AutoDoughKing or not v.Parent or v.Humanoid.Health <= 0
										Usefastattack = false
									end
									if AutoDoughKing and string.find(v.Name,"Urban") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
										repeat fask.wait()
											if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
												Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
											elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
												if Farmtween then
													Farmtween:Stop()
												end
												EquipWeapon(SelectToolWeapon)
												Usefastattack = true
												toAroundTarget(v.HumanoidRootPart.CFrame)
											end
										until not AutoDoughKing or not v.Parent or v.Humanoid.Health <= 0
										Usefastattack = false
									end
									if AutoDoughKing and string.find(v.Name,"Deandre") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
										repeat fask.wait()
											if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
												Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
											elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
												if Farmtween then
													Farmtween:Stop()
												end
												EquipWeapon(SelectToolWeapon)
												Usefastattack = true
												toAroundTarget(v.HumanoidRootPart.CFrame)
											end
										until not AutoDoughKing or not v.Parent or v.Humanoid.Health <= 0
										Usefastattack = false
									end
								end
							else
								local string_1 = "EliteHunter";
								local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
								Target:InvokeServer(string_1);
							end
						else
							local string_1 = "EliteHunter";
							local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
							Target:InvokeServer(string_1);
						end
					else
						if game:GetService("Workspace").Enemies:FindFirstChild("Candy Rebel [Lv. 2375]") or game:GetService("Workspace").Enemies:FindFirstChild("Sweet Thief [Lv. 2350]") or game:GetService("Workspace").Enemies:FindFirstChild("Chocolate Bar Battler [Lv. 2325]") or game:GetService("Workspace").Enemies:FindFirstChild("Cocoa Warrior [Lv. 2300]") then
							for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
								if AutoDoughKing and (v.Name == "Candy Rebel [Lv. 2375]" or v.Name == "Sweet Thief [Lv. 2350]" or v.Name == "Chocolate Bar Battler [Lv. 2325]" or v.Name == "Cocoa Warrior [Lv. 2300]") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
									repeat fask.wait()
										if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
											Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
											Usefastattack = false
										elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
											if Farmtween then Farmtween:Stop() end
											Usefastattack = true
											PosFarmCoco = v.HumanoidRootPart.CFrame
											EquipWeapon(SelectToolWeapon)
											toAroundTarget(v.HumanoidRootPart.CFrame)
											MagnetFarmCoco = true
										end
									until not AutoDoughKing or not v.Parent or v.Humanoid.Health <= 0
									Usefastattack = false
									MagnetFarmCoco = false
								end
							end
						else
							MagnetFarmCoco = false
							Usefastattack = false
							Questtween = toTarget(CFrame.new(620.6344604492188, 78.93644714355469, -12581.369140625))
							if (CFrame.new(620.6344604492188, 78.93644714355469, -12581.369140625).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
								if Questtween then
									Questtween:Stop()
								end
								game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(620.6344604492188, 78.93644714355469, -12581.369140625)
							end
						end
					end
				else
					break;
				end
			end
		end)
		spawn(function()
			while fask.wait() do
				if AutoDoughKing then
					if MagnetFarmCakePrince then
						for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
							if MagnetFarmCakePrince  and AutoUnlockDough and (v.Name == "Cookie Crafter [Lv. 2200]" or v.Name == "Cake Guard [Lv. 2225]" or v.Name == "Baking Staff [Lv. 2250]" or v.Name == "Head Baker [Lv. 2275]") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and (v.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
								if InMyNetWork(v.HumanoidRootPart) then
									v.HumanoidRootPart.CFrame = PosFarmCakePrince
									v.HumanoidRootPart.CanCollide = false
									v.HumanoidRootPart.Size = Vector3.new(55,55,55)
								end
							end
						end
					end
				else
					break
				end
			end
		end)
		spawn(function()
			while fask.wait() do
				if AutoDoughKing then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner", true)
				else
					break;
				end
			end
		end)
		spawn(function()
			while fask.wait() do
				if AutoDoughKing then
					if MagnetFarmCoco then
						for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
							if MagnetFarmCoco  and AutoDoughKing and (v.Name == "Candy Rebel [Lv. 2375]" or v.Name == "Sweet Thief [Lv. 2350]" or v.Name == "Chocolate Bar Battler [Lv. 2325]" or v.Name == "Cocoa Warrior [Lv. 2300]") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and (v.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
								if InMyNetWork(v.HumanoidRootPart) then
									v.HumanoidRootPart.CFrame = PosFarmCoco
									v.HumanoidRootPart.CanCollide = false
									v.HumanoidRootPart.Size = Vector3.new(50,50,50)
								end
							end
						end
					end
				else
					break
				end
			end
		end)
	end
end})

ConfigAutoUnlockDoughRaids = AutoFarmMiscSea3PageRight:AddToggle("Auto Unlock Dough Raids",{Stats = false , callback = function(starts)
	if ThreeWorld then
		AutoUnlockDough = starts
		_G.ConfigMain["Auto Unlock Dough"] = starts
		SaveConfigAuto()
		spawn(function()
			while fask.wait() do
				if AutoUnlockDough then
					xpcall(function()
						if not game:GetService("Workspace").Map.CakeLoaf:FindFirstChild("RedDoor") then
							if game.Players.LocalPlayer.Character:FindFirstChild("Red Key") or game.Players.LocalPlayer.Backpack:FindFirstChild("Red Key") then
								game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2712.4619140625, 64.36634826660156, -12892.9345703125)
								local args = {
									[1] = "CakeScientist",
									[2] = "Check"
								}

								game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
								local args = {
									[1] = "RaidsNpc",
									[2] = "Check"
								}

								game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
							end
						elseif game:GetService("Workspace").Map.CakeLoaf:FindFirstChild("RedDoor") then
							if game.Players.LocalPlayer.Character:FindFirstChild("Red Key") or game.Players.LocalPlayer.Backpack:FindFirstChild("Red Key") then
								RedDorTween = toTarget(CFrame.new(-2681.97998, 64.3921585, -12853.7363, 0.149007782, -1.87902192e-08, 0.98883605, 3.60619588e-08, 1, 1.35681812e-08, -0.98883605, 3.36376011e-08, 0.149007782))
								if (CFrame.new(-2681.97998, 64.3921585, -12853.7363, 0.149007782, -1.87902192e-08, 0.98883605, 3.60619588e-08, 1, 1.35681812e-08, -0.98883605, 3.36376011e-08, 0.149007782).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 5 then
									if RedDorTween then RedDorTween:Stop() end
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2681.97998, 64.3921585, -12853.7363, 0.149007782, -1.87902192e-08, 0.98883605, 3.60619588e-08, 1, 1.35681812e-08, -0.98883605, 3.36376011e-08, 0.149007782)
									fask.wait(0.5)
									EquipWeapon("Red Key")
									fask.wait(0.5)

								end
							elseif game.Workspace:FindFirstChild("Enemies"):FindFirstChild("Dough King [Lv. 2300] [Raid Boss]") or game:GetService("ReplicatedStorage"):FindFirstChild("Dough King [Lv. 2300] [Raid Boss]") then
								if game:GetService("Workspace").Enemies:FindFirstChild("Dough King [Lv. 2300] [Raid Boss]") then
									for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
										if AutoUnlockDough and v.Name == "Dough King [Lv. 2300] [Raid Boss]" and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
											repeat fask.wait()
												if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
													Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
												elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
													if Farmtween then
														Farmtween:Stop()
													end
													EquipWeapon(SelectToolWeapon)
													v.HumanoidRootPart.Size = Vector3.new(55,55,55)
													Usefastattack = true
													toAroundTarget(v.HumanoidRootPart.CFrame)
												end
											until not AutoUnlockDough or not v.Parent or v.Humanoid.Health <= 0 or game:GetService("ReplicatedStorage"):FindFirstChild("Dough King [Lv. 2300] [Raid Boss]")
											Usefastattack = false
										end
									end
								else
									if game:GetService("Workspace").Map.CakeLoaf.BigMirror.Other.Transparency == 0 then
										Usefastattack = false
										Questtween = toTarget(CFrame.new(-2151.82153, 149.315704, -12404.9053).Position,CFrame.new(-2151.82153, 149.315704, -12404.9053))
										if (CFrame.new(-2151.82153, 149.315704, -12404.9053).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
											if Questtween then Questtween:Stop() end
											game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2151.82153, 149.315704, -12404.9053)
											fask.wait(1)
										end
									end
								end
							elseif game.Players.LocalPlayer.Character:FindFirstChild("Sweet Chalice") or game.Players.LocalPlayer.Backpack:FindFirstChild("Sweet Chalice") then
								--if string.find(tostring(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner", true)),"already") then

								--else
								game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner", true)
								game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")
								if game:GetService("Workspace").Enemies:FindFirstChild("Cookie Crafter [Lv. 2200]") or game:GetService("Workspace").Enemies:FindFirstChild("Cake Guard [Lv. 2225]") or game:GetService("Workspace").Enemies:FindFirstChild("Baking Staff [Lv. 2250]") or game:GetService("Workspace").Enemies:FindFirstChild("Head Baker [Lv. 2275]") then
									for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
										if AutoUnlockDough and (v.Name == "Cookie Crafter [Lv. 2200]" or v.Name == "Cake Guard [Lv. 2225]" or v.Name == "Baking Staff [Lv. 2250]" or v.Name == "Head Baker [Lv. 2275]") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
											repeat fask.wait()
												if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
													Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
												elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
													if Farmtween then Farmtween:Stop() end
													Usefastattack = true
													PosFarmCakePrince = v.HumanoidRootPart.CFrame
													EquipWeapon(SelectToolWeapon)
													toAroundTarget(v.HumanoidRootPart.CFrame)
													MagnetFarmCakePrince = true
													game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner", true)
													game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")
												end
											until not AutoUnlockDough or not v.Parent or v.Humanoid.Health <= 0
											Usefastattack = false
											MagnetFarmCakePrince = false
										end
									end
								else
									MagnetFarmCakePrince = false
									Usefastattack = false
									Questtween = toTarget(CFrame.new(-2077, 252, -12373).Position,CFrame.new(-2077, 252, -12373))
									if (CFrame.new(-2077, 252, -12373).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
										if Questtween then Questtween:Stop() end
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2077, 252, -12373)
									end
								end

								--end
							elseif (game.Players.LocalPlayer.Backpack:FindFirstChild("God's Chalice") or game.Players.LocalPlayer.Character:FindFirstChild("God's Chalice")) and GetMaterial("Conjured Cocoa") >= 10 then
								game.ReplicatedStorage.Remotes.CommF_:InvokeServer("SweetChaliceNpc")
								fask.wait(0.2)
							elseif not game.Players.LocalPlayer.Backpack:FindFirstChild("God's Chalice") and not game.Players.LocalPlayer.Character:FindFirstChild("God's Chalice") and (game.Workspace.Enemies:FindFirstChild("Deandre [Lv. 1750]") or game.Workspace.Enemies:FindFirstChild("Urban [Lv. 1750]") or game.Workspace.Enemies:FindFirstChild("Diablo [Lv. 1750]") or game.ReplicatedStorage:FindFirstChild("Deandre [Lv. 1750]") or game.ReplicatedStorage:FindFirstChild("Urban [Lv. 1750]") or game.ReplicatedStorage:FindFirstChild("Diablo [Lv. 1750]")) then
								if game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == true then
									if string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Diablo") or string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Urban") or string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Deandre") then
										for i,v in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
											if string.find(v.Name,"Diablo") then
												DoughTween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
												if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
													if DoughTween then
														DoughTween:Stop()
													end
													game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
												end
											end
											if string.find(v.Name,"Urban") then
												DoughTween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
												if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
													if DoughTween then
														DoughTween:Stop()
													end
													game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
												end
											end
											if string.find(v.Name,"Deandre") then
												DoughTween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
												if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
													if DoughTween then
														DoughTween:Stop()
													end
													game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
												end
											end
										end
										for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
											if AutoUnlockDough and string.find(v.Name,"Diablo") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
												repeat fask.wait()
													if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
														Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
													elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
														if Farmtween then
															Farmtween:Stop()
														end
														EquipWeapon(SelectToolWeapon)
														Usefastattack = true
														toAroundTarget(v.HumanoidRootPart.CFrame)
													end
												until not AutoUnlockDough or not v.Parent or v.Humanoid.Health <= 0
												Usefastattack = false
											end
											if AutoUnlockDough and string.find(v.Name,"Urban") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
												repeat fask.wait()
													if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
														Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
													elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
														if Farmtween then
															Farmtween:Stop()
														end
														EquipWeapon(SelectToolWeapon)
														Usefastattack = true
														toAroundTarget(v.HumanoidRootPart.CFrame)
													end
												until not AutoUnlockDough or not v.Parent or v.Humanoid.Health <= 0
												Usefastattack = false
											end
											if AutoUnlockDough and string.find(v.Name,"Deandre") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
												repeat fask.wait()
													if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
														Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
													elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
														if Farmtween then
															Farmtween:Stop()
														end
														EquipWeapon(SelectToolWeapon)
														Usefastattack = true
														toAroundTarget(v.HumanoidRootPart.CFrame)
													end
												until not AutoUnlockDough or not v.Parent or v.Humanoid.Health <= 0
												Usefastattack = false
											end
										end
									else
										local string_1 = "EliteHunter";
										local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
										Target:InvokeServer(string_1);
									end
								else
									local string_1 = "EliteHunter";
									local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
									Target:InvokeServer(string_1);
								end
							else
								if game:GetService("Workspace").Enemies:FindFirstChild("Candy Rebel [Lv. 2375]") or game:GetService("Workspace").Enemies:FindFirstChild("Sweet Thief [Lv. 2350]") or game:GetService("Workspace").Enemies:FindFirstChild("Chocolate Bar Battler [Lv. 2325]") or game:GetService("Workspace").Enemies:FindFirstChild("Cocoa Warrior [Lv. 2300]") then
									for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
										if AutoUnlockDough and (v.Name == "Candy Rebel [Lv. 2375]" or v.Name == "Sweet Thief [Lv. 2350]" or v.Name == "Chocolate Bar Battler [Lv. 2325]" or v.Name == "Cocoa Warrior [Lv. 2300]") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
											repeat fask.wait()
												if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
													Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
													Usefastattack = false
												elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
													if Farmtween then Farmtween:Stop() end
													Usefastattack = true
													PosFarmCoco = v.HumanoidRootPart.CFrame
													EquipWeapon(SelectToolWeapon)
													toAroundTarget(v.HumanoidRootPart.CFrame)
													MagnetFarmCoco = true
												end
											until not AutoUnlockDough or not v.Parent or v.Humanoid.Health <= 0
											Usefastattack = false
											MagnetFarmCoco = false
										end
									end
								else
									MagnetFarmCoco = false
									Usefastattack = false
									Questtween = toTarget(CFrame.new(620.6344604492188, 78.93644714355469, -12581.369140625))
									if (CFrame.new(620.6344604492188, 78.93644714355469, -12581.369140625).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
										if Questtween then
											Questtween:Stop()
										end
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(620.6344604492188, 78.93644714355469, -12581.369140625)
									end
								end
							end
						else
							print("Error Whyyy")
						end
					end,function(e)
						print("AUDR ERROR : "..e)
					end)
				else
					break;
				end
			end
		end)
		spawn(function()
			while fask.wait() do
				if AutoUnlockDough then
					if MagnetFarmCakePrince then
						for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
							if MagnetFarmCakePrince  and AutoUnlockDough and (v.Name == "Cookie Crafter [Lv. 2200]" or v.Name == "Cake Guard [Lv. 2225]" or v.Name == "Baking Staff [Lv. 2250]" or v.Name == "Head Baker [Lv. 2275]") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and (v.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
								if InMyNetWork(v.HumanoidRootPart) then
									v.HumanoidRootPart.CFrame = PosFarmCakePrince
									v.HumanoidRootPart.CanCollide = false
									v.HumanoidRootPart.Size = Vector3.new(55,55,55)
								end
							end
						end
					end
				else
					break
				end
			end
		end)
		spawn(function()
			while fask.wait() do
				if AutoUnlockDough then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner", true)
				else
					break;
				end
			end
		end)
		spawn(function()
			while fask.wait() do
				if AutoUnlockDough then
					if MagnetFarmCoco then
						for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
							if MagnetFarmCoco  and AutoUnlockDough and (v.Name == "Candy Rebel [Lv. 2375]" or v.Name == "Sweet Thief [Lv. 2350]" or v.Name == "Chocolate Bar Battler [Lv. 2325]" or v.Name == "Cocoa Warrior [Lv. 2300]") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and (v.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
								if InMyNetWork(v.HumanoidRootPart) then
									v.HumanoidRootPart.CFrame = PosFarmCoco
									v.HumanoidRootPart.CanCollide = false
									v.HumanoidRootPart.Size = Vector3.new(50,50,50)
								end
							end
						end
					end
				else
					break
				end
			end
		end)
	end
end})

ConfigAutoUnlockDoughRaidsHop = AutoFarmMiscSea3PageRight:AddToggle("Auto Unlock Dough Raids Hop",{Stats = false , callback = function(starts)
	if ThreeWorld then
		AutoUnlockDoughHop = starts
		_G.ConfigMain["Auto Unlock Dough Hop"] = starts
		SaveConfigAuto()
		spawn(function()
			while fask.wait() do
				if AutoUnlockDoughHop then
					xpcall(function()
						if not game:GetService("Workspace").Map.CakeLoaf:FindFirstChild("RedDoor") then
							if game.Players.LocalPlayer.Character:FindFirstChild("Red Key") or game.Players.LocalPlayer.Backpack:FindFirstChild("Red Key") then
								game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2712.4619140625, 64.36634826660156, -12892.9345703125)
								local args = {
									[1] = "CakeScientist",
									[2] = "Check"
								}

								game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
								local args = {
									[1] = "RaidsNpc",
									[2] = "Check"
								}

								game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
							end
						elseif game:GetService("Workspace").Map.CakeLoaf:FindFirstChild("RedDoor") then
							if game.Players.LocalPlayer.Character:FindFirstChild("Red Key") or game.Players.LocalPlayer.Backpack:FindFirstChild("Red Key") then
								RedDorTween = toTarget(CFrame.new(-2681.97998, 64.3921585, -12853.7363, 0.149007782, -1.87902192e-08, 0.98883605, 3.60619588e-08, 1, 1.35681812e-08, -0.98883605, 3.36376011e-08, 0.149007782))
								if (CFrame.new(-2681.97998, 64.3921585, -12853.7363, 0.149007782, -1.87902192e-08, 0.98883605, 3.60619588e-08, 1, 1.35681812e-08, -0.98883605, 3.36376011e-08, 0.149007782).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 5 then
									if RedDorTween then RedDorTween:Stop() end
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2681.97998, 64.3921585, -12853.7363, 0.149007782, -1.87902192e-08, 0.98883605, 3.60619588e-08, 1, 1.35681812e-08, -0.98883605, 3.36376011e-08, 0.149007782)
									fask.wait(0.5)
									EquipWeapon("Red Key")
									fask.wait(0.5)
								end
							elseif game.Workspace:FindFirstChild("Enemies"):FindFirstChild("Dough King [Lv. 2300] [Raid Boss]") or game:GetService("ReplicatedStorage"):FindFirstChild("Dough King [Lv. 2300] [Raid Boss]") then
								if game:GetService("Workspace").Enemies:FindFirstChild("Dough King [Lv. 2300] [Raid Boss]") then
									for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
										if AutoUnlockDough and v.Name == "Dough King [Lv. 2300] [Raid Boss]" and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
											repeat fask.wait()
												if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
													Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
												elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
													if Farmtween then
														Farmtween:Stop()
													end
													EquipWeapon(SelectToolWeapon)
													v.HumanoidRootPart.Size = Vector3.new(55,55,55)
													Usefastattack = true
													toAroundTarget(v.HumanoidRootPart.CFrame)
												end
											until not AutoUnlockDough or not v.Parent or v.Humanoid.Health <= 0 or game:GetService("ReplicatedStorage"):FindFirstChild("Dough King [Lv. 2300] [Raid Boss]")
											Usefastattack = false
										end
									end
								else
									if game:GetService("Workspace").Map.CakeLoaf.BigMirror.Other.Transparency == 0 then
										Usefastattack = false
										Questtween = toTarget(CFrame.new(-2151.82153, 149.315704, -12404.9053).Position,CFrame.new(-2151.82153, 149.315704, -12404.9053))
										if (CFrame.new(-2151.82153, 149.315704, -12404.9053).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
											if Questtween then Questtween:Stop() end
											game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2151.82153, 149.315704, -12404.9053)
											fask.wait(1)
										end
									end
								end
							elseif game.Players.LocalPlayer.Character:FindFirstChild("Sweet Chalice") or game.Players.LocalPlayer.Backpack:FindFirstChild("Sweet Chalice") then
								--if string.find(tostring(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner", true)),"already") then

								--else
								game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner", true)
								game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")
								if game:GetService("Workspace").Enemies:FindFirstChild("Cookie Crafter [Lv. 2200]") or game:GetService("Workspace").Enemies:FindFirstChild("Cake Guard [Lv. 2225]") or game:GetService("Workspace").Enemies:FindFirstChild("Baking Staff [Lv. 2250]") or game:GetService("Workspace").Enemies:FindFirstChild("Head Baker [Lv. 2275]") then
									for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
										if AutoUnlockDough and (v.Name == "Cookie Crafter [Lv. 2200]" or v.Name == "Cake Guard [Lv. 2225]" or v.Name == "Baking Staff [Lv. 2250]" or v.Name == "Head Baker [Lv. 2275]") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
											repeat fask.wait()
												if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
													Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
												elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
													if Farmtween then Farmtween:Stop() end
													Usefastattack = true
													PosFarmCakePrince = v.HumanoidRootPart.CFrame
													EquipWeapon(SelectToolWeapon)
													toAroundTarget(v.HumanoidRootPart.CFrame)
													MagnetFarmCakePrince = true
													game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner", true)
													game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")
												end
											until not AutoUnlockDough or not v.Parent or v.Humanoid.Health <= 0
											Usefastattack = false
											MagnetFarmCakePrince = false
										end
									end
								else
									MagnetFarmCakePrince = false
									Usefastattack = false
									Questtween = toTarget(CFrame.new(-2077, 252, -12373).Position,CFrame.new(-2077, 252, -12373))
									if (CFrame.new(-2077, 252, -12373).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
										if Questtween then Questtween:Stop() end
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2077, 252, -12373)
									end
								end

								--end
							elseif (game.Players.LocalPlayer.Backpack:FindFirstChild("God's Chalice") or game.Players.LocalPlayer.Character:FindFirstChild("God's Chalice")) and GetMaterial("Conjured Cocoa") >= 10 then
								game.ReplicatedStorage.Remotes.CommF_:InvokeServer("SweetChaliceNpc")
								fask.wait(0.2)
							elseif not game.Players.LocalPlayer.Backpack:FindFirstChild("God's Chalice") and not game.Players.LocalPlayer.Character:FindFirstChild("God's Chalice") and (game.Workspace.Enemies:FindFirstChild("Deandre [Lv. 1750]") or game.Workspace.Enemies:FindFirstChild("Urban [Lv. 1750]") or game.Workspace.Enemies:FindFirstChild("Diablo [Lv. 1750]") or game.ReplicatedStorage:FindFirstChild("Deandre [Lv. 1750]") or game.ReplicatedStorage:FindFirstChild("Urban [Lv. 1750]") or game.ReplicatedStorage:FindFirstChild("Diablo [Lv. 1750]")) then
								if game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == true then
									if string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Diablo") or string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Urban") or string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Deandre") then
										for i,v in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
											if string.find(v.Name,"Diablo") then
												DoughTween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
												if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
													if DoughTween then
														DoughTween:Stop()
													end
													game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
												end
											end
											if string.find(v.Name,"Urban") then
												DoughTween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
												if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
													if DoughTween then
														DoughTween:Stop()
													end
													game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
												end
											end
											if string.find(v.Name,"Deandre") then
												DoughTween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
												if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
													if DoughTween then
														DoughTween:Stop()
													end
													game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
												end
											end
										end
										for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
											if AutoUnlockDough and string.find(v.Name,"Diablo") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
												repeat fask.wait()
													if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
														Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
													elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
														if Farmtween then
															Farmtween:Stop()
														end
														EquipWeapon(SelectToolWeapon)
														Usefastattack = true
														toAroundTarget(v.HumanoidRootPart.CFrame)
													end
												until not AutoUnlockDough or not v.Parent or v.Humanoid.Health <= 0
												Usefastattack = false
											end
											if AutoUnlockDough and string.find(v.Name,"Urban") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
												repeat fask.wait()
													if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
														Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
													elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
														if Farmtween then
															Farmtween:Stop()
														end
														EquipWeapon(SelectToolWeapon)
														Usefastattack = true
														toAroundTarget(v.HumanoidRootPart.CFrame)
													end
												until not AutoUnlockDough or not v.Parent or v.Humanoid.Health <= 0
												Usefastattack = false
											end
											if AutoUnlockDough and string.find(v.Name,"Deandre") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
												repeat fask.wait()
													if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
														Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
													elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
														if Farmtween then
															Farmtween:Stop()
														end
														EquipWeapon(SelectToolWeapon)
														Usefastattack = true
														toAroundTarget(v.HumanoidRootPart.CFrame)
													end
												until not AutoUnlockDough or not v.Parent or v.Humanoid.Health <= 0
												Usefastattack = false
											end
										end
									else
										local string_1 = "EliteHunter";
										local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
										local Data = Target:InvokeServer(string_1);
										if Data == "I don't have anything for you right now. Come back later." then
											ServerFunc:NormalTeleport()
										end
									end
								else
									local string_1 = "EliteHunter";
									local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
									local Data = Target:InvokeServer(string_1);
									if Data == "I don't have anything for you right now. Come back later." then
										ServerFunc:NormalTeleport()
									end
								end
							else
								if game:GetService("Workspace").Enemies:FindFirstChild("Candy Rebel [Lv. 2375]") or game:GetService("Workspace").Enemies:FindFirstChild("Sweet Thief [Lv. 2350]") or game:GetService("Workspace").Enemies:FindFirstChild("Chocolate Bar Battler [Lv. 2325]") or game:GetService("Workspace").Enemies:FindFirstChild("Cocoa Warrior [Lv. 2300]") then
									for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
										if AutoUnlockDough and (v.Name == "Candy Rebel [Lv. 2375]" or v.Name == "Sweet Thief [Lv. 2350]" or v.Name == "Chocolate Bar Battler [Lv. 2325]" or v.Name == "Cocoa Warrior [Lv. 2300]") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
											repeat fask.wait()
												if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
													Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
													Usefastattack = false
												elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
													if Farmtween then Farmtween:Stop() end
													Usefastattack = true
													PosFarmCoco = v.HumanoidRootPart.CFrame
													EquipWeapon(SelectToolWeapon)
													toAroundTarget(v.HumanoidRootPart.CFrame)
													MagnetFarmCoco = true
												end
											until not AutoUnlockDough or not v.Parent or v.Humanoid.Health <= 0
											Usefastattack = false
											MagnetFarmCoco = false
										end
									end
								else
									MagnetFarmCoco = false
									Usefastattack = false
									Questtween = toTarget(CFrame.new(620.6344604492188, 78.93644714355469, -12581.369140625))
									if (CFrame.new(620.6344604492188, 78.93644714355469, -12581.369140625).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
										if Questtween then
											Questtween:Stop()
										end
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(620.6344604492188, 78.93644714355469, -12581.369140625)
									end
								end
							end
						else
							print("Error Whyyy")
						end
					end,function(e)
						print("AUDR ERROR : "..e)
					end)
				else
					break;
				end
			end
		end)
		spawn(function()
			while fask.wait() do
				if AutoUnlockDoughHop then
					if MagnetFarmCakePrince then
						for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
							if MagnetFarmCakePrince  and AutoUnlockDoughHop and (v.Name == "Cookie Crafter [Lv. 2200]" or v.Name == "Cake Guard [Lv. 2225]" or v.Name == "Baking Staff [Lv. 2250]" or v.Name == "Head Baker [Lv. 2275]") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and (v.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
								if InMyNetWork(v.HumanoidRootPart) then
									v.HumanoidRootPart.CFrame = PosFarmCakePrince
									v.HumanoidRootPart.CanCollide = false
									v.HumanoidRootPart.Size = Vector3.new(55,55,55)
								end
							end
						end
					end
				else
					break
				end
			end
		end)
		spawn(function()
			while fask.wait() do
				if AutoUnlockDoughHop then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner", true)
				else
					break;
				end
			end
		end)
		spawn(function()
			while fask.wait() do
				if AutoUnlockDoughHop then
					if MagnetFarmCoco then
						for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
							if MagnetFarmCoco  and AutoUnlockDoughHop and (v.Name == "Candy Rebel [Lv. 2375]" or v.Name == "Sweet Thief [Lv. 2350]" or v.Name == "Chocolate Bar Battler [Lv. 2325]" or v.Name == "Cocoa Warrior [Lv. 2300]") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and (v.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
								if InMyNetWork(v.HumanoidRootPart) then
									v.HumanoidRootPart.CFrame = PosFarmCoco
									v.HumanoidRootPart.CanCollide = false
									v.HumanoidRootPart.Size = Vector3.new(50,50,50)
								end
							end
						end
					end
				else
					break
				end
			end
		end)
	end
end})

AutoFarmMiscSea3PageRight:AddLabel("~ 🍬 Buddy Swords 🍬 ~")

ConfigAutoBuddySwords = AutoFarmMiscSea3PageRight:AddToggle("Auto Buddy Swords",{Stats = false , callback = function(starts)
	if ThreeWorld then
		AutoBuddySwords = starts
		_G.ConfigMain["Auto Buddy Swords"] = starts
		SaveConfigAuto()
		spawn(function()
			while fask.wait() do
				if AutoBuddySwords then
					if game:GetService("ReplicatedStorage"):FindFirstChild("Cake Queen [Lv. 2175] [Boss]") or game.Workspace.Enemies:FindFirstChild("Cake Queen [Lv. 2175] [Boss]") then
						if game.Workspace.Enemies:FindFirstChild("Cake Queen [Lv. 2175] [Boss]") then
							for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
								if AutoBuddySwords and v.Name == "Cake Queen [Lv. 2175] [Boss]" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
									repeat fask.wait()
										Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
										if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
											if Farmtween then
												Farmtween:Stop()
											end
											EquipWeapon(SelectToolWeapon)
											Usefastattack = true
											toAroundTarget(v.HumanoidRootPart.CFrame)
											game:GetService'VirtualUser':CaptureController()
											game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
										end
									until not AutoBuddySwords or v.Humanoid.Health <= 0 or not v.Parent
									Usefastattack = false
								end
							end
						else
							BuddySwordsTween = toTarget(CFrame.new(-821, 66, -10965).Position,CFrame.new(-821, 66, -10965))
							if (CFrame.new(-821, 66, -10965).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
								if BuddySwordsTween then
									BuddySwordsTween:Stop()
								end
								game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-821, 66, -10965)
							end
						end
					elseif AutoBuddySwordsHOP then
						ServerFunc:TeleportFast()
					else
						BuddySwordsTween = toTarget(CFrame.new(-821, 66, -10965).Position,CFrame.new(-821, 66, -10965))
						if (CFrame.new(-821, 66, -10965).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
							if BuddySwordsTween then
								BuddySwordsTween:Stop()
							end
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-821, 66, -10965)
						end
					end
				else
					break
				end
			end
		end)
	end
end})

ConfigAutoBuddySwordsHop = AutoFarmMiscSea3PageRight:AddToggle("Auto Buddy Swords [ Hop ]",{Stats = false , callback = function(starts)
	if ThreeWorld then
		AutoBuddySwords = starts
		AutoBuddySwordsHOP = starts
		_G.ConfigMain["Auto Buddy Swords HOP"] = starts
		SaveConfigAuto()
		spawn(function()
			while fask.wait() do
				if AutoBuddySwords then
					if game:GetService("ReplicatedStorage"):FindFirstChild("Cake Queen [Lv. 2175] [Boss]") or game.Workspace.Enemies:FindFirstChild("Cake Queen [Lv. 2175] [Boss]") then
						if game.Workspace.Enemies:FindFirstChild("Cake Queen [Lv. 2175] [Boss]") then
							for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
								if AutoBuddySwords and v.Name == "Cake Queen [Lv. 2175] [Boss]" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
									repeat fask.wait()
										Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
										if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
											if Farmtween then
												Farmtween:Stop()
											end
											EquipWeapon(SelectToolWeapon)
											Usefastattack = true
											toAroundTarget(v.HumanoidRootPart.CFrame)
											game:GetService'VirtualUser':CaptureController()
											game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
										end
									until not AutoBuddySwords or v.Humanoid.Health <= 0 or not v.Parent
									Usefastattack = false
								end
							end
						else
							BuddySwordsTween = toTarget(CFrame.new(-821, 66, -10965).Position,CFrame.new(-821, 66, -10965))
							if (CFrame.new(-821, 66, -10965).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
								if BuddySwordsTween then
									BuddySwordsTween:Stop()
								end
								game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-821, 66, -10965)
							end
						end
					elseif AutoBuddySwordsHOP then
						ServerFunc:TeleportFast()
					else
						BuddySwordsTween = toTarget(CFrame.new(-821, 66, -10965).Position,CFrame.new(-821, 66, -10965))
						if (CFrame.new(-821, 66, -10965).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
							if BuddySwordsTween then
								BuddySwordsTween:Stop()
							end
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-821, 66, -10965)
						end
					end
				else
					break
				end
			end
		end)
	end
end})

AutoFarmMiscSea3PageRight:AddLabel("~ 🎃 Hallow Ween 🎃 ~")

ConfigAutoFarmBone = AutoFarmMiscSea3PageRight:AddToggle("Auto Farm Bone",{Stats = false , callback = function(starts)
	if ThreeWorld then
		AutoFarmBone = starts
		MainAutoFarmBone = starts
		_G.ConfigMain["Auto Farm Bone"] = starts
		SaveConfigAuto()
		spawn(function()
			while fask.wait() do
				if AutoFarmBone then
					xpcall(function()
						local GetQuestTitle = game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title
						local GetQuest = game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest
						local MyLevel = game.Players.LocalPlayer.Data.Level.Value
						local LevelFarm = 1

						local Monster = "Demonic Soul [Lv. 2025]"
						local NameQuest = "HauntedQuest2"

						local LevelQuest = 1
						local NameCheckQuest = "Demonic Soul"

						local CFrameQuest = CFrame.new(-9513, 172, 6079)


						if not string.find(GetQuestTitle.Text, NameCheckQuest) and AutoQuest == true then _F("AbandonQuest"); end
						if GetQuest.Visible == false and AutoQuest == true then
							Usefastattack = false
							StartMagnetAutoFarmLevel = false
							Questtween = toTarget(CFrameQuest)
							if (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
								if Questtween then Questtween:Stop() end
								game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameQuest
								fask.wait(0.95)
								_F("StartQuest", NameQuest, LevelQuest)
								
							end
						elseif GetQuest.Visible == true or AutoQuest == false then
							if game:GetService("Workspace").Enemies:FindFirstChild("Reborn Skeleton [Lv. 1975]") or game:GetService("Workspace").Enemies:FindFirstChild("Living Zombie [Lv. 2000]") or game:GetService("Workspace").Enemies:FindFirstChild("Demonic Soul [Lv. 2025]") or game:GetService("Workspace").Enemies:FindFirstChild("Posessed Mummy [Lv. 2050]") then
								for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
									if AutoFarmBone and (v.Name == "Reborn Skeleton [Lv. 1975]" or v.Name == "Living Zombie [Lv. 2000]" or v.Name == "Demonic Soul [Lv. 2025]" or v.Name == "Posessed Mummy [Lv. 2050]") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
										repeat fask.wait()
											if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
												Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
												Usefastattack = false
											elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
												if Farmtween then Farmtween:Stop() end
												Usefastattack = true
												PosFarmBone = v.HumanoidRootPart.CFrame
												EquipWeapon(SelectToolWeapon)
												toAroundTarget(v.HumanoidRootPart.CFrame)
												MagnetFarmBone = true
											end
										until not AutoFarmBone or not v.Parent or v.Humanoid.Health <= 0
										Usefastattack = false
										MagnetFarmBone = false
									end
								end
							else
								MagnetFarmBone = false
								Usefastattack = false
								Questtween = toTarget(CFrame.new(-9506.14648, 172.130661, 6101.79053).Position,CFrame.new(-9506.14648, 172.130661, 6101.79053))
								if (CFrame.new(-9506.14648, 172.130661, 6101.79053).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
									if Questtween then
										Questtween:Stop()
									end
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-9506.14648, 172.130661, 6101.79053, -0.999731541, 0, -0.0231563263, 0, 1, 0, 0.0231563263, 0, -0.999731541)
								end
							end
						end

					end,function(e)
						print("AUTO FARM BONE ERROR : "..e)
					end)
				elseif not MainAutoFarmBone then
					break
				end
			end
		end)
		spawn(function()
			while fask.wait() do
				if AutoFarmBone then
					if MagnetFarmBone then
						for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
							if MagnetFarmBone  and AutoFarmBone and (v.Name == "Reborn Skeleton [Lv. 1975]" or v.Name == "Living Zombie [Lv. 2000]" or v.Name == "Demonic Soul [Lv. 2025]" or v.Name == "Posessed Mummy [Lv. 2050]") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and (v.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
								if InMyNetWork(v.HumanoidRootPart) then
									v.HumanoidRootPart.CFrame = PosFarmBone
									v.HumanoidRootPart.CanCollide = false
									v.HumanoidRootPart.Size = Vector3.new(50,50,50)
								end
							end
						end
					end
				else
					break
				end
			end
		end)
	end
end})

ConfigAutoHallowScythe = AutoFarmMiscSea3PageRight:AddToggle("Auto Hallow Scythe",{Stats = false , callback = function(starts)
	if ThreeWorld then
		AutoHallowScythe = starts
		_G.ConfigMain["Auto Hallow Scythe"] = starts
		SaveConfigAuto()
		spawn(function()
			while fask.wait() do
				if AutoHallowScythe then
					if inmyself("Hallow Essence") then
						if MainAutoFarmBone then
							AutoFarmBone = false
						end
						Questtween = toTarget(game:GetService("Workspace").Map["Haunted Castle"].Summoner.Detection.Position,game:GetService("Workspace").Map["Haunted Castle"].Summoner.Detection.CFrame)
						if (game:GetService("Workspace").Map["Haunted Castle"].Summoner.Detection.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
							if Questtween then
								Questtween:Stop()
							end
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map["Haunted Castle"].Summoner.Detection.CFrame
						end
					elseif game:GetService("Workspace").Enemies:FindFirstChild("Soul Reaper [Lv. 2100] [Raid Boss]") or game:GetService("ReplicatedStorage"):FindFirstChild("Soul Reaper [Lv. 2100] [Raid Boss]") then
						if MainAutoFarmBone then
							AutoFarmBone = false
						end
						if game:GetService("Workspace").Enemies:FindFirstChild("Soul Reaper [Lv. 2100] [Raid Boss]") then
							for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
								if AutoHallowScythe and v.Name == "Soul Reaper [Lv. 2100] [Raid Boss]" and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
									repeat fask.wait()
										if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
											Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
										elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
											if Farmtween then
												Farmtween:Stop()
											end
											PosFarmBone = v.HumanoidRootPart.CFrame
											EquipWeapon(SelectToolWeapon)
											Usefastattack = true
											toAroundTarget(v.HumanoidRootPart.CFrame)
										end
									until not AutoHallowScythe or not v.Parent or v.Humanoid.Health <= 0
									Usefastattack = false
								end
							end
						else
							Usefastattack = false
							Questtween = toTarget(CFrame.new(-9521, 316, 6684).Position,CFrame.new(-9521, 316, 6684))
							if (CFrame.new(-9521, 316, 6684).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
								if Questtween then
									Questtween:Stop()
								end
								game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-9521, 316, 6684)
							end
						end
					else
						Usefastattack = false
						if MainAutoFarmBone then
							AutoFarmBone = true
						end
						local string_1 = "Bones";
						local string_2 = "Buy";
						local number_1 = 1;
						local number_2 = 1;
						local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
						Target:InvokeServer(string_1, string_2, number_1, number_2);
					end
				else
					break
				end
			end
		end)
	end
end})

ConfigAutoSoulReaper = AutoFarmMiscSea3PageRight:AddToggle("Auto Farm Soul Reaper",{Stats = false , callback = function(starts)
	if ThreeWorld then
		AutoSoulReaper = starts
		_G.ConfigMain["Auto Farm Soul Reaper"] = starts
		SaveConfigAuto()
		spawn(function()
			while fask.wait() do
				if AutoSoulReaper then
					if game:GetService("Workspace").Enemies:FindFirstChild("Soul Reaper [Lv. 2100] [Raid Boss]") or game:GetService("ReplicatedStorage"):FindFirstChild("Soul Reaper [Lv. 2100] [Raid Boss]") then
						if MainAutoFarmBone then
							AutoFarmBone = false
						end
						if game:GetService("Workspace").Enemies:FindFirstChild("Soul Reaper [Lv. 2100] [Raid Boss]") then
							for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
								if AutoSoulReaper and v.Name == "Soul Reaper [Lv. 2100] [Raid Boss]" and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
									repeat fask.wait()
										if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
											Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
										elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
											if Farmtween then
												Farmtween:Stop()
											end
											PosFarmBone = v.HumanoidRootPart.CFrame
											EquipWeapon(SelectToolWeapon)
											Usefastattack = true
											toAroundTarget(v.HumanoidRootPart.CFrame)
										end
									until not AutoSoulReaper or not v.Parent or v.Humanoid.Health <= 0
									Usefastattack = false
								end
							end
						else
							Usefastattack = false
							Questtween = toTarget(CFrame.new(-9521, 316, 6684).Position,CFrame.new(-9521, 316, 6684))
							if (CFrame.new(-9521, 316, 6684).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
								if Questtween then
									Questtween:Stop()
								end
								game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-9521, 316, 6684)
							end
						end
					end
				else
					break
				end
			end
		end)
	end
end})

if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Bones", "Check") then
	local BonePurch = AutoFarmMiscSea3PageRight:AddLabel("~ Auto Random Bone ~")
	ConfigRandomBone = AutoFarmMiscSea3PageRight:AddToggle("Auto Random Bone",{Stats = false , callback = function(starts)
		AutoRandomBone = starts
		_G.ConfigMain["Auto Random bone"] = starts
		SaveConfigAuto()
		spawn(function()
			while fask.wait() do
				if AutoRandomBone then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Bones","Buy",1,1)
				else
					break
				end
			end
		end)
	end})
end

AutoFarmMiscSea3PageRight:AddLabel("~ 🌀 Portal 🌀 ~")

if ThreeWorld then
	local PortalKill = AutoFarmMiscSea3PageRight:AddLabel("N/S")

	pcall(function()
		if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner", true) then
			if game:GetService("ReplicatedStorage"):FindFirstChild("Cake Prince [Lv. 2300] [Raid Boss]") or game:GetService("Workspace").Enemies:FindFirstChild("Cake Prince [Lv. 2300] [Raid Boss]") or game.Workspace:FindFirstChild("Enemies"):FindFirstChild("Dough King [Lv. 2300] [Raid Boss]") or game:GetService("ReplicatedStorage"):FindFirstChild("Dough King [Lv. 2300] [Raid Boss]") then
				PortalKill:Options().Text = "Can Open Door To Kill Cake Prince"
			else
				PortalKill:Options().Text = "Need Kill Mods " .. string.match(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner", true), "%d+") .. " To Open Kill Cake Prince"
			end
		end
	end)
	AutoFarmMiscSea3PageRight:AddButton("Update Cake Prince Status",function()
		pcall(function()
			if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner", true) then
				if game:GetService("ReplicatedStorage"):FindFirstChild("Cake Prince [Lv. 2300] [Raid Boss]") or game:GetService("Workspace").Enemies:FindFirstChild("Cake Prince [Lv. 2300] [Raid Boss]") or game.Workspace:FindFirstChild("Enemies"):FindFirstChild("Dough King [Lv. 2300] [Raid Boss]") or game:GetService("ReplicatedStorage"):FindFirstChild("Dough King [Lv. 2300] [Raid Boss]") then
					PortalKill:Options().Text = "Can Open Door To Kill Cake Prince"
				else
					PortalKill:Options().Text = "Need Kill Mods " .. string.match(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner", true), "%d+") .. " To Open Kill Cake Prince"
				end
			end
		end)
	end)
end

ConfigCakePrince = AutoFarmMiscSea3PageRight:AddToggle("Auto Farm Cake Prince",{Stats = false , callback = function(starts)
	if ThreeWorld then
		AutoFarmCakePrince = starts
		_G.ConfigMain["Auto Farm Cake Prince"] = starts
		SaveConfigAuto()
		spawn(function()
			while fask.wait() do
				if AutoFarmCakePrince then
					xpcall(function()
						local GetQuestTitle = game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title
						local GetQuest = game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest
						local MyLevel = game.Players.LocalPlayer.Data.Level.Value
						local LevelFarm = 1

						local Monster = "Cookie Crafter [Lv. 2200]"
						local NameQuest = "CakeQuest1"

						local LevelQuest = 1
						local NameCheckQuest = "Cookie Crafter"

						local CFrameMyMon = CFrame.new(-2365, 38, -12099)

						local CFrameQuest = CFrame.new(-2020, 38, -12025)

						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")
						if not string.find(GetQuestTitle.Text, NameCheckQuest) and AutoQuest == true then _F("AbandonQuest"); end
						if GetQuest.Visible == false and AutoQuest == true then
							Usefastattack = false
							StartMagnetAutoFarmLevel = false
							Questtween = toTarget(CFrameQuest)
							if (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
								if Questtween then Questtween:Stop() end
								game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameQuest
								fask.wait(0.95)
								_F("StartQuest", NameQuest, LevelQuest)
								
							end
						elseif GetQuest.Visible == true or AutoQuest == false then
							if game:GetService("ReplicatedStorage"):FindFirstChild("Cake Prince [Lv. 2300] [Raid Boss]") or game:GetService("Workspace").Enemies:FindFirstChild("Cake Prince [Lv. 2300] [Raid Boss]") then
								if game:GetService("Workspace").Enemies:FindFirstChild("Cake Prince [Lv. 2300] [Raid Boss]") then
									for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
										if AutoFarmCakePrince and v.Name == "Cake Prince [Lv. 2300] [Raid Boss]" and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
											repeat fask.wait()
												if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
													Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
												elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
													if Farmtween then
														Farmtween:Stop()
													end
													EquipWeapon(SelectToolWeapon)
													v.HumanoidRootPart.Size = Vector3.new(55,55,55)
													Usefastattack = true
													toAroundTarget(v.HumanoidRootPart.CFrame)
												end
											until not AutoFarmCakePrince or not v.Parent or v.Humanoid.Health <= 0 or game:GetService("ReplicatedStorage"):FindFirstChild("Cake Prince [Lv. 2300] [Raid Boss]")
											Usefastattack = false
										end
									end
								else
									if game:GetService("Workspace").Map.CakeLoaf.BigMirror.Other.Transparency == 0 then
										Usefastattack = false
										if tween then tween:Cancel() end
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2151.82153, 149.315704, -12404.9053) * CFrame.new(math.random(-5,5),math.random(-5,5),math.random(-5,5))
										fask.wait(.1)
									end
								end
							else
								if game:GetService("Workspace").Enemies:FindFirstChild("Cookie Crafter [Lv. 2200]") or game:GetService("Workspace").Enemies:FindFirstChild("Cake Guard [Lv. 2225]") or game:GetService("Workspace").Enemies:FindFirstChild("Baking Staff [Lv. 2250]") or game:GetService("Workspace").Enemies:FindFirstChild("Head Baker [Lv. 2275]") then
									for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
										if 0 and (v.Name == "Cookie Crafter [Lv. 2200]" or v.Name == "Cake Guard [Lv. 2225]" or v.Name == "Baking Staff [Lv. 2250]" or v.Name == "Head Baker [Lv. 2275]") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
											repeat fask.wait()
												if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
													Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
												elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
													if Farmtween then Farmtween:Stop() end
													Usefastattack = true
													PosFarmCakePrince = v.HumanoidRootPart.CFrame
													EquipWeapon(SelectToolWeapon)
													toAroundTarget(v.HumanoidRootPart.CFrame)
													MagnetFarmCakePrince = true
												end
											until not AutoFarmCakePrince or not v.Parent or v.Humanoid.Health <= 0
											Usefastattack = false
											MagnetFarmCakePrince = false
										end
									end
								else
									MagnetFarmCakePrince = false
									Usefastattack = false
									Questtween = toTarget(CFrame.new(-2077, 252, -12373).Position,CFrame.new(-2077, 252, -12373))
									if (CFrame.new(-2077, 252, -12373).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
										if Questtween then Questtween:Stop() end
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2077, 252, -12373)
									end
								end
							end
						end
					end,print)
				else
					break
				end
			end
		end)
		spawn(function()
			while fask.wait() do
				if AutoFarmCakePrince then
					if MagnetFarmCakePrince then
						for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
							if MagnetFarmCakePrince  and AutoFarmCakePrince and (v.Name == "Cookie Crafter [Lv. 2200]" or v.Name == "Cake Guard [Lv. 2225]" or v.Name == "Baking Staff [Lv. 2250]" or v.Name == "Head Baker [Lv. 2275]") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and (v.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
								if InMyNetWork(v.HumanoidRootPart) then
									v.HumanoidRootPart.CFrame = PosFarmCakePrince
									v.HumanoidRootPart.CanCollide = false
									v.HumanoidRootPart.Size = Vector3.new(55,55,55)
								end
							end
						end
					end
				else
					break
				end
			end
		end)
	end
end})

AutoFarmMiscSea3PageRight:AddLabel("~ Open Color ~")

local function CheckHakiColor(NameColor)
	local args = {
		[1] = "getColors"
	}

	MyHakiColor = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
	for i,v in pairs(MyHakiColor) do
		if (v.HiddenName):find(NameColor) then
			if v.Unlocked then
				return v.Unlocked
			end
		end
	end
	return false
end

AutoFarmMiscSea3PageRight:AddMultiDropdown("Select Color To Open",{Values = {"Winter Sky","Pure Red","Snow White"}, callback = function(starts)
	SelectColorToOpen = starts
end})

AutoFarmMiscSea3PageRight:AddButton("Select Color To Open",function()
	for i,v in pairs(SelectColorToOpen) do
		if v == "Winter Sky" then
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("activateColor","Winter Sky")
			fask.wait(0.25)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = (CFrame.new(-5420.16602, 1084.9657, -2666.8208, 0.390717864, 0, 0.92051065, 0, 1, 0, -0.92051065, 0, 0.390717864))
		elseif v == "Pure Red" then
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("activateColor","Pure Red")
			fask.wait(0.25)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = (CFrame.new(-5414.41357, 309.865753, -2212.45776, 0.374604106, -0, -0.92718488, 0, 1, -0, 0.92718488, 0, 0.374604106))
		elseif v == "Snow White" then
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("activateColor","Snow White")
			fask.wait(0.25)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = (CFrame.new(-4971.47559, 331.565765, -3720.02954, -0.92051065, 0, 0.390717506, 0, 1, 0, -0.390717506, 0, -0.92051065))
		end
		fask.wait(0.25)
	end
end)

function CheckButtonColorOpen()
	local OpenAll = 0
	for i,v in pairs(game:GetService("Workspace").Map["Boat Castle"].Summoner.Circle:GetChildren()) do
		if v:IsA("Part") then
			if v:FindFirstChild("Part") and v:FindFirstChild("Part").BrickColor == BrickColor.new("Lime green") then
				OpenAll = OpenAll + 1
			end
		end
	end
	return OpenAll==3
end


AutoFarmMiscSea3PageRight:AddLabel("~ Auto Tushita ~")

ConfigAutoTushita = AutoFarmMiscSea3PageRight:AddToggle("Auto Tushita",{Stats = false , callback = function(starts)
	if ThreeWorld then
		AutoTushita = starts
		_G.ConfigMain["Auto Tushita"] = starts
		SaveConfigAuto()
		spawn(function()
			while fask.wait() do
				if AutoTushita then
					if game.Players.localPlayer.Data.Level.Value > 2000 and (CheckHakiColor("Winter Sky") and CheckHakiColor("Pure Red") and CheckHakiColor("Snow White")) or CheckButtonColorOpen() or not game:GetService("Workspace").Map.Turtle:FindFirstChild("TushitaGate") or (game.Workspace.Enemies:FindFirstChild("rip_indra True Form [Lv. 5000] [Raid Boss]")  or game.ReplicatedStorage:FindFirstChild("rip_indra True Form [Lv. 5000] [Raid Boss]")) then
						if (game.Workspace.Enemies:FindFirstChild("Longma [Lv. 2000] [Boss]") or game.ReplicatedStorage:FindFirstChild("Longma [Lv. 2000] [Boss]")) and not game:GetService("Workspace").Map.Turtle:FindFirstChild("TushitaGate") then
							if game.Workspace.Enemies:FindFirstChild("Longma [Lv. 2000] [Boss]") then
								if RipTween then RipTween:Stop() end
								for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
									if AutoTushita and v.Name == "Longma [Lv. 2000] [Boss]" and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
										repeat fask.wait()
											if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
												Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
											elseif v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
												EquipWeapon(SelectToolWeapon)
												if Farmtween then Farmtween:Stop() end
												Usefastattack = true
												toAroundTarget(v.HumanoidRootPart.CFrame)
											end
										until not AutoTushita or not v.Parent or v.Humanoid.Health <= 0
										Usefastattack = false
									end
								end
							elseif game.ReplicatedStorage:FindFirstChild("Longma [Lv. 2000] [Boss]") then
								RipTween = toTarget(CFrame.new(-10171.7051, 406.981995, -9552.31738))
								Usefastattack = false
							end
						elseif game.Players.LocalPlayer.Backpack:FindFirstChild("Holy Torch") or game.Players.LocalPlayer.Character:FindFirstChild("Holy Torch") then
							ChaliceTween = toTarget(CFrame.new(5148.03613, 162.352493, 910.548218))
							ChaliceTween:Wait()
							fask.wait(0.5)
							EquipWeapon("Holy Torch")
							fask.wait(0.2)
							HolyTween = toTarget(CFrame.new(-10752.7695, 412.229523, -9366.36328))
							HolyTween:Wait()
							fask.wait(0.4)
							HolyTween = toTarget(CFrame.new(-11673.4111, 331.749023, -9474.34668))
							HolyTween:Wait()
							fask.wait(0.4)
							HolyTween = toTarget(CFrame.new(-12133.3389, 519.47522, -10653.1904))
							HolyTween:Wait()
							fask.wait(0.4)
							HolyTween = toTarget(CFrame.new(-13336.5, 485.280396, -6983.35254))
							HolyTween:Wait()
							fask.wait(0.4)
							HolyTween = toTarget(CFrame.new(-13487.4131, 334.84845, -7926.34863))
							HolyTween:Wait()
							fask.wait(1)
						elseif game.Players.LocalPlayer.Backpack:FindFirstChild("God's Chalice") or game.Players.LocalPlayer.Character:FindFirstChild("God's Chalice") then
							fask.wait(0.25)
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("activateColor","Winter Sky")
							fask.wait(0.25)
							ChaliceTween = toTarget(CFrame.new(-5420.16602, 1084.9657, -2666.8208, 0.390717864, 0, 0.92051065, 0, 1, 0, -0.92051065, 0, 0.390717864))
							ChaliceTween:Wait()
							fask.wait(0.25)
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("activateColor","Pure Red")
							fask.wait(0.25)
							ChaliceTween = toTarget(CFrame.new(-5414.41357, 309.865753, -2212.45776, 0.374604106, -0, -0.92718488, 0, 1, -0, 0.92718488, 0, 0.374604106))
							ChaliceTween:Wait()
							fask.wait(0.25)
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("activateColor","Snow White")
							fask.wait(0.25)
							ChaliceTween = toTarget(CFrame.new(-4971.47559, 331.565765, -3720.02954, -0.92051065, 0, 0.390717506, 0, 1, 0, -0.390717506, 0, -0.92051065))
							ChaliceTween:Wait()
							fask.wait(0.25)
							EquipWeapon("God's Chalice")
							ChaliceTween = toTarget(CFrame.new(-5560.27295, 313.915466, -2663.89795))
							ChaliceTween:Wait()
							fask.wait(0.5)
							EquipWeapon("God's Chalice")
							fask.wait(0.2)
						elseif not inmyself("Holy Torch") and (game.Workspace.Enemies:FindFirstChild("rip_indra True Form [Lv. 5000] [Raid Boss]")  or game.ReplicatedStorage:FindFirstChild("rip_indra True Form [Lv. 5000] [Raid Boss]")) then
							ChaliceTween = toTarget(CFrame.new(5154.17676, 141.786423, 911.046326))
							ChaliceTween:Wait()
							fask.wait(0.2)
							ChaliceTween = toTarget(CFrame.new(5148.03613, 162.352493, 910.548218))
							ChaliceTween:Wait()
							fask.wait(0.5)
						elseif not inmyself("God's Chalice") and (game.Workspace.Enemies:FindFirstChild("Deandre [Lv. 1750]") or game.Workspace.Enemies:FindFirstChild("Urban [Lv. 1750]") or game.Workspace.Enemies:FindFirstChild("Diablo [Lv. 1750]") or game.ReplicatedStorage:FindFirstChild("Deandre [Lv. 1750]") or game.ReplicatedStorage:FindFirstChild("Urban [Lv. 1750]") or game.ReplicatedStorage:FindFirstChild("Diablo [Lv. 1750]")) then
							if game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == true then
								if string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Diablo") or string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Urban") or string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Deandre") then
									for i,v in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
										if (string.find(v.Name,"Diablo") or string.find(v.Name,"Urban") or string.find(v.Name,"Deandre")) then
											TushitaTween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
											if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
												if TushitaTween then
													TushitaTween:Stop()
												end
												game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
											end
										end
									end
									for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
										if AutoTushita and (string.find(v.Name,"Diablo") or string.find(v.Name,"Urban") or string.find(v.Name,"Deandre")) and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
											repeat fask.wait()
												if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
													Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
												elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
													if Farmtween then
														Farmtween:Stop()
													end
													EquipWeapon(SelectToolWeapon)
													Usefastattack = true
													toAroundTarget(v.HumanoidRootPart.CFrame)
												end
											until not AutoTushita or not v.Parent or v.Humanoid.Health <= 0
											Usefastattack = false
										end

									end
								else
									local string_1 = "EliteHunter";
									local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
									Target:InvokeServer(string_1);
								end
							else
								local string_1 = "EliteHunter";
								local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
								Target:InvokeServer(string_1);
							end
						end
					end
				else
					break
				end
			end
		end)
	end
end})

ConfigAutoTushitaHop = AutoFarmMiscSea3PageRight:AddToggle("Auto Tushita Hop",{Stats = false , callback = function(starts)
	if ThreeWorld then
		AutoTushita = starts
		AutoTushitaHop = starts
		_G.ConfigMain["Auto Tushita Hop"] = starts
		SaveConfigAuto()
		spawn(function()
			while fask.wait() do
				if AutoTushitaHop then
					if game.Players.localPlayer.Data.Level.Value > 2000 and (CheckHakiColor("Winter Sky") and CheckHakiColor("Pure Red") and CheckHakiColor("Snow White")) or not game:GetService("Workspace").Map.Turtle:FindFirstChild("TushitaGate") or (game.Workspace.Enemies:FindFirstChild("rip_indra True Form [Lv. 5000] [Raid Boss]")  or game.ReplicatedStorage:FindFirstChild("rip_indra True Form [Lv. 5000] [Raid Boss]")) then
						if AutoTushitaHop and not game:GetService("Workspace").Map.Turtle:FindFirstChild("TushitaGate") and not game.Workspace.Enemies:FindFirstChild("Longma [Lv. 2000] [Boss]") and not game.ReplicatedStorage:FindFirstChild("Longma [Lv. 2000] [Boss]") then
							ServerFunc:TeleportFast()
						elseif (game.Workspace.Enemies:FindFirstChild("Longma [Lv. 2000] [Boss]") or game.ReplicatedStorage:FindFirstChild("Longma [Lv. 2000] [Boss]")) and game:GetService("Workspace").Map.Turtle.TushitaGate:FindFirstChild("TushitaGate").Transparency == 1 then
							if game.Workspace.Enemies:FindFirstChild("Longma [Lv. 2000] [Boss]") then
								if RipTween then RipTween:Stop() end
								for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
									if AutoTushita and v.Name == "Longma [Lv. 2000] [Boss]" and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
										repeat fask.wait()
											if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
												Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
											elseif v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
												EquipWeapon(SelectToolWeapon)
												if Farmtween then Farmtween:Stop() end
												Usefastattack = true
												toAroundTarget(v.HumanoidRootPart.CFrame)
											end
										until not AutoTushita or not v.Parent or v.Humanoid.Health <= 0
										Usefastattack = false
									end
								end
							elseif game.ReplicatedStorage:FindFirstChild("Longma [Lv. 2000] [Boss]") then
								RipTween = toTarget(CFrame.new(-10171.7051, 406.981995, -9552.31738))
								Usefastattack = false
							end
						elseif game.Players.LocalPlayer.Backpack:FindFirstChild("Holy Torch") or game.Players.LocalPlayer.Character:FindFirstChild("Holy Torch") then
							ChaliceTween = toTarget(CFrame.new(5148.03613, 162.352493, 910.548218))
							ChaliceTween:Wait()
							fask.wait(0.5)
							EquipWeapon("Holy Torch")
							fask.wait(0.2)
							HolyTween = toTarget(CFrame.new(-10752.7695, 412.229523, -9366.36328))
							HolyTween:Wait()
							fask.wait(0.4)
							HolyTween = toTarget(CFrame.new(-11673.4111, 331.749023, -9474.34668))
							HolyTween:Wait()
							fask.wait(0.4)
							HolyTween = toTarget(CFrame.new(-12133.3389, 519.47522, -10653.1904))
							HolyTween:Wait()
							fask.wait(0.4)
							HolyTween = toTarget(CFrame.new(-13336.5, 485.280396, -6983.35254, 0.912677109))
							HolyTween:Wait()
							fask.wait(0.4)
							HolyTween = toTarget(CFrame.new(-13487.4131, 334.84845, -7926.34863))
							HolyTween:Wait()
							fask.wait(1)
						elseif game.Players.LocalPlayer.Backpack:FindFirstChild("God's Chalice") or game.Players.LocalPlayer.Character:FindFirstChild("God's Chalice") then
							fask.wait(0.25)
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("activateColor","Winter Sky")
							fask.wait(0.25)
							ChaliceTween = toTarget(CFrame.new(-5420.16602, 1084.9657, -2666.8208, 0.390717864, 0, 0.92051065, 0, 1, 0, -0.92051065, 0, 0.390717864))
							ChaliceTween:Wait()
							fask.wait(0.25)
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("activateColor","Pure Red")
							fask.wait(0.25)
							ChaliceTween = toTarget(CFrame.new(-5414.41357, 309.865753, -2212.45776, 0.374604106, -0, -0.92718488, 0, 1, -0, 0.92718488, 0, 0.374604106))
							ChaliceTween:Wait()
							fask.wait(0.25)
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("activateColor","Snow White")
							fask.wait(0.25)
							ChaliceTween = toTarget(CFrame.new(-4971.47559, 331.565765, -3720.02954, -0.92051065, 0, 0.390717506, 0, 1, 0, -0.390717506, 0, -0.92051065))
							ChaliceTween:Wait()
							fask.wait(0.25)
							EquipWeapon("God's Chalice")
							ChaliceTween = toTarget(CFrame.new(-5560.27295, 313.915466, -2663.89795))
							ChaliceTween:Wait()
							fask.wait(0.5)
							EquipWeapon("God's Chalice")
							fask.wait(0.2)
							ChaliceTween = toTarget(CFrame.new(5154.17676, 141.786423, 911.046326))
							ChaliceTween:Wait()
							fask.wait(0.2)
							ChaliceTween = toTarget(CFrame.new(5148.03613, 162.352493, 910.548218))
							ChaliceTween:Wait()
							fask.wait(0.5)
						elseif not inmyself("Holy Torch") and (game.Workspace.Enemies:FindFirstChild("rip_indra True Form [Lv. 5000] [Raid Boss]")  or game.ReplicatedStorage:FindFirstChild("rip_indra True Form [Lv. 5000] [Raid Boss]")) then
							ChaliceTween = toTarget(CFrame.new(5154.17676, 141.786423, 911.046326))
							ChaliceTween:Wait()
							fask.wait(0.2)
							ChaliceTween = toTarget(CFrame.new(5148.03613, 162.352493, 910.548218))
							ChaliceTween:Wait()
							fask.wait(0.5)
						elseif not inmyself("God's Chalice") and (game.Workspace.Enemies:FindFirstChild("Deandre [Lv. 1750]") or game.Workspace.Enemies:FindFirstChild("Urban [Lv. 1750]") or game.Workspace.Enemies:FindFirstChild("Diablo [Lv. 1750]") or game.ReplicatedStorage:FindFirstChild("Deandre [Lv. 1750]") or game.ReplicatedStorage:FindFirstChild("Urban [Lv. 1750]") or game.ReplicatedStorage:FindFirstChild("Diablo [Lv. 1750]")) then
							if game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == true then
								if string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Diablo") or string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Urban") or string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Deandre") then
									for i,v in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
										if string.find(v.Name,"Diablo") then
											TushitaTween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
											if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
												if TushitaTween then
													TushitaTween:Stop()
												end
												game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
											end
										end
										if string.find(v.Name,"Urban") then
											TushitaTween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
											if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
												if TushitaTween then
													TushitaTween:Stop()
												end
												game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
											end
										end
										if string.find(v.Name,"Deandre") then
											TushitaTween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
											if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
												if TushitaTween then
													TushitaTween:Stop()
												end
												game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
											end
										end
									end
									for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
										if AutoTushita and string.find(v.Name,"Diablo") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
											repeat fask.wait()
												if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
													Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
												elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
													if Farmtween then
														Farmtween:Stop()
													end
													EquipWeapon(SelectToolWeapon)
													Usefastattack = true
													toAroundTarget(v.HumanoidRootPart.CFrame)
												end
											until not AutoTushita or not v.Parent or v.Humanoid.Health <= 0
											Usefastattack = false
										end
										if AutoTushita and string.find(v.Name,"Urban") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
											repeat fask.wait()
												if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
													Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
												elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
													if Farmtween then
														Farmtween:Stop()
													end
													EquipWeapon(SelectToolWeapon)
													Usefastattack = true
													toAroundTarget(v.HumanoidRootPart.CFrame)
												end
											until not AutoTushita or not v.Parent or v.Humanoid.Health <= 0
											Usefastattack = false
										end
										if AutoTushita and string.find(v.Name,"Deandre") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
											repeat fask.wait()
												if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
													Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
												elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
													if Farmtween then
														Farmtween:Stop()
													end
													EquipWeapon(SelectToolWeapon)
													Usefastattack = true
													toAroundTarget(v.HumanoidRootPart.CFrame)
												end
											until not AutoTushita or not v.Parent or v.Humanoid.Health <= 0
											Usefastattack = false
										end
									end
								else
									local string_1 = "EliteHunter";
									local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
									Target:InvokeServer(string_1);
								end
							else
								local string_1 = "EliteHunter";
								local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
								Target:InvokeServer(string_1);
							end
						elseif AutoTushitaHop then
							ServerFunc:TeleportFast()
						end
					elseif not (game.Workspace.Enemies:FindFirstChild("rip_indra True Form [Lv. 5000] [Raid Boss]")  or game.ReplicatedStorage:FindFirstChild("rip_indra True Form [Lv. 5000] [Raid Boss]")) then
						ServerFunc:NormalTeleport()
					end
				else
					break
				end
			end
		end)
	end
end})

AutoFarmMiscSea3PageRight:AddLabel("~ Auto Enma/Yama ~")

ConfigEmma = AutoFarmMiscSea3PageRight:AddToggle("Auto Enma/Yama",{Stats = false , callback = function(starts)
	if ThreeWorld then
		AutoYama = starts
		_G.ConfigMain["Auto Enma/Yama"] = starts
		SaveConfigAuto()
		spawn(function()
			while fask.wait() do
				if AutoYama then
					if game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("EliteHunter", "Progress") < 30 then
						if game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == true then
							if string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Diablo") or string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Urban") or string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Deandre") then
								for i,v in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
									if (string.find(v.Name,"Diablo") or string.find(v.Name,"Urban") or string.find(v.Name,"Deandre")) then
										YemaTween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
										if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
											if YemaTween then
												YemaTween:Stop()
											end
											game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
										end
									end
								end
								for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
									if AutoYama and (string.find(v.Name,"Diablo") or string.find(v.Name,"Urban") or string.find(v.Name,"Deandre")) and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
										repeat fask.wait()
											if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
												Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
											elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
												if Farmtween then
													Farmtween:Stop()
												end
												EquipWeapon(SelectToolWeapon)
												Usefastattack = true
												toAroundTarget(v.HumanoidRootPart.CFrame)
											end
										until not AutoYama or not v.Parent or v.Humanoid.Health <= 0
										Usefastattack = false
									end

								end
							else
								local string_1 = "EliteHunter";
								local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
								Target:InvokeServer(string_1);
							end
						else
							if AutoYamaHOP and game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("EliteHunter") == "I don't have anything for you right now. Come back later." then
								ServerFunc:TeleportFast()
							else
								local string_1 = "EliteHunter";
								local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
								Target:InvokeServer(string_1);
							end
						end
					else
						TweenYema = toTarget(game.Workspace.Map.Waterfall.SealedKatana.Handle.Position,game.Workspace.Map.Waterfall.SealedKatana.Handle.CFrame)
						if (game.Workspace.Map.Waterfall.SealedKatana.Handle.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
							if TweenYema then
								TweenYema:Stop()
							end
							if game.Workspace.Enemies:FindFirstChild("Ghost [Lv. 1500]") then
								for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
									if AutoYama and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and v.Name == "Ghost [Lv. 1500]" then
										repeat fask.wait()
											if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
												Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
											elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
												if Farmtween then
													Farmtween:Stop()
												end
												EquipWeapon(SelectToolWeapon)
												Usefastattack = true
												toAroundTarget(v.HumanoidRootPart.CFrame)
											end
										until not AutoYama or not v.Parent or v.Humanoid.Health <= 0
										Usefastattack = false
									end
								end
							else
								if TweenYema then
									TweenYema:Stop()
								end
								fireclickdetector(game.Workspace.Map.Waterfall.SealedKatana.Handle.ClickDetector)
							end
						end
					end
				else
					break
				end
			end
		end)
	end
end})

ConfigEmmaHOP = AutoFarmMiscSea3PageRight:AddToggle("Auto Enma/Yama [ HOP ]",{Stats = false , callback = function(starts)
	if ThreeWorld then
		AutoYama = starts
		AutoYamaHOP = starts
		_G.ConfigMain["Auto Enma/Yama HOP"] = starts
		SaveConfigAuto()
		spawn(function()
			while fask.wait() do
				if AutoYama then
					if game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("EliteHunter", "Progress") < 30 then
						if game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == true then
							if string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Diablo") or string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Urban") or string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Deandre") then
								for i,v in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
									if (string.find(v.Name,"Diablo") or string.find(v.Name,"Urban") or string.find(v.Name,"Deandre")) then
										YemaTween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
										if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
											if YemaTween then
												YemaTween:Stop()
											end
											game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
										end
									end

								end
								for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
									if AutoYama and (string.find(v.Name,"Diablo") or string.find(v.Name,"Urban") or string.find(v.Name,"Deandre")) and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
										repeat fask.wait()
											if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
												Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
											elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
												if Farmtween then
													Farmtween:Stop()
												end
												EquipWeapon(SelectToolWeapon)
												Usefastattack = true
												toAroundTarget(v.HumanoidRootPart.CFrame)
											end
										until not AutoYama or not v.Parent or v.Humanoid.Health <= 0
										Usefastattack = false
									end

								end
							else
								local string_1 = "EliteHunter";
								local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
								Target:InvokeServer(string_1);
							end
						else
							if AutoYamaHOP and game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("EliteHunter") == "I don't have anything for you right now. Come back later." then
								ServerFunc:TeleportFast()
							else
								local string_1 = "EliteHunter";
								local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
								Target:InvokeServer(string_1);
							end
						end
					else
						TweenYema = toTarget(game.Workspace.Map.Waterfall.SealedKatana.Handle.Position,game.Workspace.Map.Waterfall.SealedKatana.Handle.CFrame)
						if (game.Workspace.Map.Waterfall.SealedKatana.Handle.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
							if TweenYema then
								TweenYema:Stop()
							end
							if game.Workspace.Enemies:FindFirstChild("Ghost [Lv. 1500]") then
								for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
									if AutoYama and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and v.Name == "Ghost [Lv. 1500]" then
										repeat fask.wait()
											if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
												Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
											elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
												if Farmtween then
													Farmtween:Stop()
												end
												EquipWeapon(SelectToolWeapon)
												Usefastattack = true
												toAroundTarget(v.HumanoidRootPart.CFrame)
											end
										until not AutoYama or not v.Parent or v.Humanoid.Health <= 0
										Usefastattack = false
									end
								end
							else
								if TweenYema then
									TweenYema:Stop()
								end
								fireclickdetector(game.Workspace.Map.Waterfall.SealedKatana.Handle.ClickDetector)
							end
						end
					end
				else
					break
				end
			end
		end)
	end
end})

AutoFarmMiscSea3PageRight:AddLabel("~ Auto Rip Indra ~")

ConfigAutoRipIndra = AutoFarmMiscSea3PageRight:AddToggle("Auto Rip Indra",{Stats = false , callback = function(starts)
	if ThreeWorld then
		AutoRipIndra = starts
		_G.ConfigMain["Auto Rip Indra"] = starts
		SaveConfigAuto()
		spawn(function()
			while fask.wait() do
				if AutoRipIndra then
					if game.Workspace.Enemies:FindFirstChild("rip_indra True Form [Lv. 5000] [Raid Boss]") then
						for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
							if AutoRipIndra and v.Name == "rip_indra True Form [Lv. 5000] [Raid Boss]" and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
								repeat fask.wait()
									if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 150 then
										Farmtween = toTarget(v.HumanoidRootPart.CFrame * CFrame.new(0, 10, 10))
									elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 150 then
										if Farmtween then
											Farmtween:Stop()
										end
										EquipWeapon()
										Usefastattack = true
										if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
											_F("Buso")
										end
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 10, 10)
									end
								until not AutoRipIndra or not v.Parent or v.Humanoid.Health <= 0
								Usefastattack = false
								pcall(RefreshStatus)
							end
						end
					elseif game.ReplicatedStorage:FindFirstChild("rip_indra True Form [Lv. 5000] [Raid Boss]") then
						local CFrameBoss = CFrame.new(-5359, 424, -2735)
						if (CFrameBoss.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 150 then
							Questtween = toTarget(CFrameBoss)
						elseif (CFrameBoss.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 150 then
							if Questtween then
								Questtween:Stop()
							end
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameBoss
						end
						
					elseif game.Players.LocalPlayer.Backpack:FindFirstChild("God's Chalice") or game.Players.LocalPlayer.Character:FindFirstChild("God's Chalice") then
						fask.wait(0.25)
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("activateColor","Winter Sky")
						fask.wait(0.25)
						ChaliceTween = toTarget(CFrame.new(-5420.16602, 1084.9657, -2666.8208, 0.390717864, 0, 0.92051065, 0, 1, 0, -0.92051065, 0, 0.390717864))
						ChaliceTween:Wait()
						fask.wait(0.25)
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("activateColor","Pure Red")
						fask.wait(0.25)
						ChaliceTween = toTarget(CFrame.new(-5414.41357, 309.865753, -2212.45776, 0.374604106, -0, -0.92718488, 0, 1, -0, 0.92718488, 0, 0.374604106))
						ChaliceTween:Wait()
						fask.wait(0.25)
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("activateColor","Snow White")
						fask.wait(0.25)
						ChaliceTween = toTarget(CFrame.new(-4971.47559, 331.565765, -3720.02954, -0.92051065, 0, 0.390717506, 0, 1, 0, -0.390717506, 0, -0.92051065))
						ChaliceTween:Wait()
						fask.wait(0.25)
						EquipWeapon("God's Chalice")
						ChaliceTween = toTarget(CFrame.new(-5560.27295, 313.915466, -2663.89795))
						ChaliceTween:Wait()
						fask.wait(0.5)
						EquipWeapon("God's Chalice")
						fask.wait(0.2)
					elseif not inmyself("Holy Torch") and (game.Workspace.Enemies:FindFirstChild("rip_indra True Form [Lv. 5000] [Raid Boss]")  or game.ReplicatedStorage:FindFirstChild("rip_indra True Form [Lv. 5000] [Raid Boss]")) then
						ChaliceTween = toTarget(CFrame.new(5154.17676, 141.786423, 911.046326))
						ChaliceTween:Wait()
						fask.wait(0.2)
						ChaliceTween = toTarget(CFrame.new(5148.03613, 162.352493, 910.548218))
						ChaliceTween:Wait()
						fask.wait(0.5)
					elseif not inmyself("God's Chalice") and (game.Workspace.Enemies:FindFirstChild("Deandre [Lv. 1750]") or game.Workspace.Enemies:FindFirstChild("Urban [Lv. 1750]") or game.Workspace.Enemies:FindFirstChild("Diablo [Lv. 1750]") or game.ReplicatedStorage:FindFirstChild("Deandre [Lv. 1750]") or game.ReplicatedStorage:FindFirstChild("Urban [Lv. 1750]") or game.ReplicatedStorage:FindFirstChild("Diablo [Lv. 1750]")) then
						if game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == true then
							if string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Diablo") or string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Urban") or string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Deandre") then
								for i,v in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
									if (string.find(v.Name,"Diablo") or string.find(v.Name,"Urban") or string.find(v.Name,"Deandre")) then
										TushitaTween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
										if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
											if TushitaTween then
												TushitaTween:Stop()
											end
											game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
										end
									end
								end
								for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
									if AutoRipIndra and (string.find(v.Name,"Diablo") or string.find(v.Name,"Urban") or string.find(v.Name,"Deandre")) and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
										repeat fask.wait()
											if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
												Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
											elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
												if Farmtween then
													Farmtween:Stop()
												end
												EquipWeapon(SelectToolWeapon)
												Usefastattack = true
												toAroundTarget(v.HumanoidRootPart.CFrame)
											end
										until not AutoRipIndra or not v.Parent or v.Humanoid.Health <= 0
										Usefastattack = false
									end

								end
							else
								local string_1 = "EliteHunter";
								local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
								Target:InvokeServer(string_1);
							end
						else
							local string_1 = "EliteHunter";
							local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
							Target:InvokeServer(string_1);
						end
					end
				else
					break
				end
			end
		end)
	end
end})

AutoFarmMiscSea3PageRight:AddLabel("~ Auto Elite Hunter ~")

local CheckEliteHunter = AutoFarmMiscSea3PageRight:AddLabel("Kill " .. game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter", "Progress") .. " Elite Enemies")

local CheckEliteHunter2 = AutoFarmMiscSea3PageRight:AddLabel("Elite : "..(function()if game.Workspace.Enemies:FindFirstChild("Deandre [Lv. 1750]")or game.Workspace.Enemies:FindFirstChild("Urban [Lv. 1750]")or game.Workspace.Enemies:FindFirstChild("Diablo [Lv. 1750]")or game.ReplicatedStorage:FindFirstChild("Deandre [Lv. 1750]")or game.ReplicatedStorage:FindFirstChild("Urban [Lv. 1750]")or game.ReplicatedStorage:FindFirstChild("Diablo [Lv. 1750]")then return"Spawn"end;return"Not Spawn"end)())

AutoFarmMiscSea3PageRight:AddButton("Update Elite Status",function()
	pcall(function()
		if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health > 0 and game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter", "Progress") then
			CheckEliteHunter2:Options().Text = "Elite : "..(function()if game.Workspace.Enemies:FindFirstChild("Deandre [Lv. 1750]")or game.Workspace.Enemies:FindFirstChild("Urban [Lv. 1750]")or game.Workspace.Enemies:FindFirstChild("Diablo [Lv. 1750]")or game.ReplicatedStorage:FindFirstChild("Deandre [Lv. 1750]")or game.ReplicatedStorage:FindFirstChild("Urban [Lv. 1750]")or game.ReplicatedStorage:FindFirstChild("Diablo [Lv. 1750]")then return"Spawn"end;return"Not Spawn"end)()
		end
	end)
end)

AutoFarmMiscSea3PageRight:AddButton("Update Kill Elite",function()
	pcall(function()
		if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health > 0 and game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter", "Progress") then
			CheckEliteHunter:Options().Text = "Kill " .. game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter", "Progress") .. " Elite Enemies"
		end
	end)
end)

ConfigAutoEliteHunter = AutoFarmMiscSea3PageRight:AddToggle("Auto Elite Hunter",{Stats = false , callback = function(starts)
	if ThreeWorld then
		AutoEliteHunter = starts
		_G.ConfigMain["Auto Elite Hunter"] = starts
		SaveConfigAuto()
		spawn(function()
			while fask.wait() do
				if AutoEliteHunter then
					if game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == true then
						if string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Diablo") or string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Urban") or string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Deandre") then
							if Auto_Farm_Level then FarmLevel = false end
							print("GOO")
							for i,v in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
								if (string.find(v.Name,"Diablo") or string.find(v.Name,"Urban") or string.find(v.Name,"Deandre")) then
									EliteHunter = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
									if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
										if EliteHunter then
											EliteHunter:Stop()
										end
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
									end
								end
							end
							for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
								if AutoEliteHunter and (string.find(v.Name,"Diablo") or string.find(v.Name,"Urban") or string.find(v.Name,"Deandre")) and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
									repeat fask.wait()
										if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
											Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
										elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
											if Farmtween then
												Farmtween:Stop()
											end
											EquipWeapon(SelectToolWeapon)
											Usefastattack = true
											toAroundTarget(v.HumanoidRootPart.CFrame)
										end
									until not AutoEliteHunter or not v.Parent or v.Humanoid.Health <= 0
									Usefastattack = false
								end

							end
						else
							if StopGodChalice and inmyself("God's Chalice") then
								ChangeToggle(ConfigAutoEliteHunter,false)
							elseif AutoEliteHunterHOP and game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("EliteHunter") == "I don't have anything for you right now. Come back later." then
								ServerFunc:TeleportFast()
							else
								local string_1 = "EliteHunter";
								local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
								Target:InvokeServer(string_1);
								if game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("EliteHunter") == "I don't have anything for you right now. Come back later." then
									if Auto_Farm_Level then FarmLevel = true end
									print("Back")
								end
							end
						end
					else
						if StopGodChalice and inmyself("God's Chalice") then
							ChangeToggle(ConfigAutoEliteHunter,false)
						elseif AutoEliteHunterHOP and game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("EliteHunter") == "I don't have anything for you right now. Come back later." then
							ServerFunc:TeleportFast()
						else
							local string_1 = "EliteHunter";
							local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
							Target:InvokeServer(string_1);
							if game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("EliteHunter") == "I don't have anything for you right now. Come back later." then
								if Auto_Farm_Level then FarmLevel = true end
								print("Back")
							end
						end
					end
				else
					break
				end
			end
		end)
	end
end})

ConfigAutoEliteHunterHOP = AutoFarmMiscSea3PageRight:AddToggle("Auto Elite Hunter [ HOP ]",{Stats = false , callback = function(starts)
	if ThreeWorld then
		AutoEliteHunter = starts
		AutoEliteHunterHOP = starts
		_G.ConfigMain["Auto Elite Hunter HOP"] = starts
		SaveConfigAuto()
		spawn(function()
			while fask.wait() do
				if AutoEliteHunter then
					if game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == true then
						if string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Diablo") or string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Urban") or string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Deandre") then
							for i,v in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
								if (string.find(v.Name,"Diablo") or string.find(v.Name,"Urban") or string.find(v.Name,"Deandre")) then
									EliteHunter = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
									if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
										if EliteHunter then
											EliteHunter:Stop()
										end
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
									end
								end

							end
							for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
								if AutoEliteHunter and (string.find(v.Name,"Diablo") or string.find(v.Name,"Urban") or string.find(v.Name,"Deandre")) and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
									repeat fask.wait()
										if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
											Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
										elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
											if Farmtween then
												Farmtween:Stop()
											end
											EquipWeapon(SelectToolWeapon)
											Usefastattack = true
											toAroundTarget(v.HumanoidRootPart.CFrame)
										end
									until not AutoEliteHunter or not v.Parent or v.Humanoid.Health <= 0
									Usefastattack = false
								end

							end
						else
							if StopGodChalice and inmyself("God's Chalice") then
								ChangeToggle(ConfigAutoEliteHunterHOP,false)
							elseif AutoEliteHunterHOP and game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("EliteHunter") == "I don't have anything for you right now. Come back later." then
								ServerFunc:TeleportFast()
							else
								local string_1 = "EliteHunter";
								local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
								Target:InvokeServer(string_1);
							end
						end
					else
						if StopGodChalice and inmyself("God's Chalice") then
							ChangeToggle(ConfigAutoEliteHunterHOP,false)
						elseif AutoEliteHunterHOP and game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("EliteHunter") == "I don't have anything for you right now. Come back later." then
							ServerFunc:TeleportFast()
						else
							local string_1 = "EliteHunter";
							local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
							Target:InvokeServer(string_1);
						end
					end
				else
					break
				end
			end
		end)
	end
end})

ConfigStopGodChalice = AutoFarmMiscSea3PageRight:AddToggle("Stop if Got God's Chalice",{Stats = false , callback = function(starts)
	if ThreeWorld then
		StopGodChalice = starts
		_G.ConfigMain["Stop if Got God's Chalice"] = starts
		SaveConfigAuto()
	end
end})

AutoFarmMiscSea3PageRight:AddLabel("~ Auto Haki Rainbow ~")

ConfigAutoHakiRainbow = AutoFarmMiscSea3PageRight:AddToggle("Auto Haki Rainbow",{Stats = false , callback = function(starts)
	if ThreeWorld then
		AutoHakiRainbow = starts
		_G.ConfigMain["Auto Haki Rainbow"] = starts
		SaveConfigAuto()
		spawn(function()
			while fask.wait() do
				if AutoHakiRainbow then
					if game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == true then
						if string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Stone") or string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Island Empress") or string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Kilo Admiral") or string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Captain Elephant") or string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Beautiful Pirate") then
							if string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Stone") then
								if game.Workspace.Enemies:FindFirstChild("Stone [Lv. 1550] [Boss]") then
									for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
										if AutoHakiRainbow and v.Name == "Stone [Lv. 1550] [Boss]" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
											repeat
												pcall(function() fask.wait()
													local string_1 = "HornedMan";
													local string_2 = "Bet";
													local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
													Target:InvokeServer(string_1, string_2);
													local string_1 = "HornedMan";
													local string_2 = "Bet";
													local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
													Target:InvokeServer(string_1, string_2);
													if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
														Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
													elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
														if Farmtween then
															Farmtween:Stop()
														end
														EquipWeapon(SelectToolWeapon)
														Usefastattack = true
														toAroundTarget(v.HumanoidRootPart.CFrame)
													end
												end)
											until not AutoHakiRainbow or not v.Parent or v.Humanoid.Health <= 0 or game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false
											Usefastattack = false
										end
									end
								else
									if (CFrame.new(-1134, 40, 6877).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 250 then
										HakiRainbowTween = toTarget(CFrame.new(-1134, 40, 6877).Position,CFrame.new(-1134, 40, 6877))
									elseif (CFrame.new(-1134, 40, 6877).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
										if HakiRainbowTween then
											HakiRainbowTween:Stop()
										end
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1134, 40, 6877)
									end
								end
							elseif string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Island Empress") then
								if game.Workspace.Enemies:FindFirstChild("Island Empress [Lv. 1675] [Boss]") then
									for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
										if AutoHakiRainbow and v.Name == "Island Empress [Lv. 1675] [Boss]" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
											repeat
												pcall(function() fask.wait()
													local string_1 = "HornedMan";
													local string_2 = "Bet";
													local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
													Target:InvokeServer(string_1, string_2);
													local string_1 = "HornedMan";
													local string_2 = "Bet";
													local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
													Target:InvokeServer(string_1, string_2);
													if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
														Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
													elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
														if Farmtween then
															Farmtween:Stop()
														end
														EquipWeapon(SelectToolWeapon)
														Usefastattack = true
														toAroundTarget(v.HumanoidRootPart.CFrame)
													end
												end)
											until not AutoHakiRainbow or not v.Parent or v.Humanoid.Health <= 0 or game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false
											Usefastattack = false
										end
									end
								else
									if (CFrame.new(5614, 603, 339).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 250 then
										HakiRainbowTween = toTarget(CFrame.new(5614, 603, 339).Position,CFrame.new(5614, 603, 339))
									elseif (CFrame.new(5614, 603, 339).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
										if HakiRainbowTween then
											HakiRainbowTween:Stop()
										end
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(5614, 603, 339)
									end
								end
							elseif string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Kilo Admiral") then
								if game.Workspace.Enemies:FindFirstChild("Kilo Admiral [Lv. 1750] [Boss]") then
									for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
										if AutoHakiRainbow and v.Name == "Kilo Admiral [Lv. 1750] [Boss]" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
											repeat
												pcall(function() fask.wait()
													local string_1 = "HornedMan";
													local string_2 = "Bet";
													local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
													Target:InvokeServer(string_1, string_2);
													local string_1 = "HornedMan";
													local string_2 = "Bet";
													local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
													Target:InvokeServer(string_1, string_2);
													if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
														Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
													elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
														if Farmtween then
															Farmtween:Stop()
														end
														EquipWeapon(SelectToolWeapon)
														Usefastattack = true
														toAroundTarget(v.HumanoidRootPart.CFrame)
													end
												end)
											until not AutoHakiRainbow or not v.Parent or v.Humanoid.Health <= 0 or game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false
											Usefastattack = false
										end
									end
								else
									if (CFrame.new(2879, 433, -7090).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 250 then
										HakiRainbowTween = toTarget(CFrame.new(2879, 433, -7090).Position,CFrame.new(2879, 433, -7090))
									elseif (CFrame.new(2879, 433, -7090).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
										if HakiRainbowTween then
											HakiRainbowTween:Stop()
										end
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2879, 433, -7090)
									end
								end
							elseif string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Captain Elephant") then
								if game.Workspace.Enemies:FindFirstChild("Captain Elephant [Lv. 1875] [Boss]") then
									for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
										if AutoHakiRainbow and v.Name == "Captain Elephant [Lv. 1875] [Boss]" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
											repeat
												pcall(function() fask.wait()
													local string_1 = "HornedMan";
													local string_2 = "Bet";
													local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
													Target:InvokeServer(string_1, string_2);
													local string_1 = "HornedMan";
													local string_2 = "Bet";
													local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
													Target:InvokeServer(string_1, string_2);
													if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
														Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
													elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
														if Farmtween then
															Farmtween:Stop()
														end
														EquipWeapon(SelectToolWeapon)
														Usefastattack = true
														toAroundTarget(v.HumanoidRootPart.CFrame)
													end
												end)
											until not AutoHakiRainbow or not v.Parent or v.Humanoid.Health <= 0 or game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false
											Usefastattack = false
										end
									end
								else
									if (CFrame.new(-13348, 406, -8574).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 250 then
										HakiRainbowTween = toTarget(CFrame.new(-13348, 406, -8574).Position,CFrame.new(-13348, 406, -8574))
									elseif (CFrame.new(-13348, 406, -8574).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
										if HakiRainbowTween then
											HakiRainbowTween:Stop()
										end
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-13348, 406, -8574)
									end
								end
							elseif string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Beautiful Pirate") then
								if game.Workspace.Enemies:FindFirstChild("Beautiful Pirate [Lv. 1950] [Boss]") then
									for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
										if AutoHakiRainbow and v.Name == "Beautiful Pirate [Lv. 1950] [Boss]" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
											repeat
												pcall(function() fask.wait()
													local string_1 = "HornedMan";
													local string_2 = "Bet";
													local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
													Target:InvokeServer(string_1, string_2);
													local string_1 = "HornedMan";
													local string_2 = "Bet";
													local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
													Target:InvokeServer(string_1, string_2);
													if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
														Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
													elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
														if Farmtween then
															Farmtween:Stop()
														end
														EquipWeapon(SelectToolWeapon)
														Usefastattack = true
														toAroundTarget(v.HumanoidRootPart.CFrame)
													end
												end)
											until not AutoHakiRainbow or not v.Parent or v.Humanoid.Health <= 0 or game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false
											Usefastattack = false
										end
									end
								else
									if (CFrame.new(5206, 23, -80).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 250 then
										HakiRainbowTween = toTarget(CFrame.new(5206, 23, -80).Position,CFrame.new(5206, 23, -80))
									elseif (CFrame.new(5206, 23, -80).Position - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).magnitude > 20000 then
										if HakiRainbowTween then
											HakiRainbowTween:Stop()
										end
										local TouchInterest = game:GetService("Workspace").Map.Turtle.Entrance.Door.BossDoor.Hitbox
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = TouchInterest.CFrame
									elseif (CFrame.new(5206, 23, -80).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
										if HakiRainbowTween then
											HakiRainbowTween:Stop()
										end
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(5206, 23, -80)
									end
								end
							end
						else
							local string_1 = "HornedMan";
							local string_2 = "Bet";
							local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
							Target:InvokeServer(string_1, string_2);
							local string_1 = "HornedMan";
							local string_2 = "Bet";
							local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
							Target:InvokeServer(string_1, string_2);
						end
					else
						local string_1 = "HornedMan";
						local string_2 = "Bet";
						local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
						Target:InvokeServer(string_1, string_2);
						local string_1 = "HornedMan";
						local string_2 = "Bet";
						local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
						Target:InvokeServer(string_1, string_2);
					end
				else
					break
				end
			end
		end)
	end
end})

AutoFarmMiscSea3PageRight:AddLabel("~ Auto Musketee Hat ~")

ConfigAutoMusketeeHat = AutoFarmMiscSea3PageRight:AddToggle("Auto Musketee Hat",{Stats = false , callback = function(starts)
	if ThreeWorld then
		MusketeeHat = starts
		_G.ConfigMain["Auto Musketee Hat"] = starts
		SaveConfigAuto()
		spawn(function()
			while fask.wait() do
				if MusketeeHat then
					local v86 = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen");
					if v86 == 0 then
						if not string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "50 Forest Pirates") then
							local string_1 = "StartQuest";
							local string_2 = "CitizenQuest";
							local number_1 = 1;
							local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
							Target:InvokeServer(string_1, string_2, number_1);
							
						else
							if game.Workspace.Enemies:FindFirstChild("Forest Pirate [Lv. 1825]") then
								for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
									if v.Name == "Forest Pirate [Lv. 1825]" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
										repeat fask.wait()
											MusketeeHatPos = v.HumanoidRootPart.CFrame
											if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
												Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
												MusketeeHatMagnet = false
											elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
												if Farmtween then
													Farmtween:Stop()
												end
												EquipWeapon(SelectToolWeapon)
												Usefastattack = true
												MusketeeHatMagnet = true
												toAroundTarget(v.HumanoidRootPart.CFrame)
											end
										until not MusketeeHat or v.Humanoid.Health <= 0 or game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text == "Defeat 50 Forest Pirates (50/50)"
										Usefastattack = false
										MusketeeHatMagnet = false
									end
								end
							else
								if (CFrame.new(-13265, 428, -7781).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 250 then
									MusketeeTween = toTarget(CFrame.new(-13265, 428, -7781).Position,CFrame.new(-13265, 428, -7781))
								elseif (CFrame.new(-13265, 428, -7781).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
									if MusketeeTween then
										MusketeeTween:Stop()
									end
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-13265, 428, -7781)
								end
							end
						end
					elseif v86 == 1 then
						MusketeeHatMagnet = false
						if not string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Captain Elephant") then
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen");
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-13350, 406, -8573)
						else
							if game.Workspace.Enemies:FindFirstChild("Captain Elephant [Lv. 1875] [Boss]") then
								for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
									if v.Name == "Captain Elephant [Lv. 1875] [Boss]" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
										repeat fask.wait()
											if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
												Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
											elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
												if Farmtween then
													Farmtween:Stop()
												end
												EquipWeapon(SelectToolWeapon)
												Usefastattack = true
												toAroundTarget(v.HumanoidRootPart.CFrame)
											end
										until not MusketeeHat or v.Humanoid.Health <= 0 or game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text == "Defeat  Captain Elephant (1/1)"
										Usefastattack = false
									end
								end
							else
								if (CFrame.new(-13350, 406, -8573).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
									MusketeeTween = toTarget(CFrame.new(-13350, 406, -8573).Position,CFrame.new(-13350, 406, -8573))
								elseif (CFrame.new(-13350, 406, -8573).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
									if MusketeeTween then
										MusketeeTween:Stop()
									end
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-13350, 406, -8573)
								end
							end
						end
					elseif v86 == 2 then
						if game.Workspace.Map.Turtle:FindFirstChild("Treasure") then
							if (game.Workspace.Map.Turtle:FindFirstChild("Treasure").Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
								MusketeeTween = toTarget(game.Workspace.Map.Turtle:FindFirstChild("Treasure").Position,game.Workspace.Map.Turtle:FindFirstChild("Treasure").CFrame)
							elseif (game.Workspace.Map.Turtle:FindFirstChild("Treasure").Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
								if MusketeeTween then
									MusketeeTween:Stop()
								end
								game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Map.Turtle:FindFirstChild("Treasure").CFrame
							end
						end
					end
				else
					break
				end
			end
		end)
	end
end})

AutoFarmMiscSea3PageRight:AddLabel("~ Auto Observation Haki V.2 ~")

local KenHakiValue = AutoFarmMiscSea3PageRight:AddLabel("N/S")

pcall(function()
	if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("KenTalk","Status") then
		KenHakiValue:Options().Text = "KenHaki Value : ".. game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("KenTalk","Status"):split(". ")[1]
	end
end)

AutoFarmMiscSea3PageRight:AddButton("Update KenHaki Value",function()
	pcall(function()
		if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("KenTalk","Status") then
			KenHakiValue:Options().Text = "KenHaki Value : ".. game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("KenTalk","Status"):split(". ")[1]
		end
	end)
end)

ConfigAutoObservationHakiV2 = AutoFarmMiscSea3PageRight:AddToggle("Auto Observation Haki V.2",{Stats = false , callback = function(starts)
	if ThreeWorld then
		AutoObservationHakiV2 = starts
		_G.ConfigMain["Auto Observation Haki V2"] = starts
		SaveConfigAuto()
		spawn(function()
			while fask.wait() do
				if AutoObservationHakiV2 then
					if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen") == 4 or game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen") == 3  then
						if game.Players.LocalPlayer.Backpack:FindFirstChild("Fruit Bowl") or game.Players.LocalPlayer.Character:FindFirstChild("Fruit Bowl") then
							game.ReplicatedStorage.Remotes.CommF_:InvokeServer("KenTalk2", "Start")
							game.ReplicatedStorage.Remotes.CommF_:InvokeServer("KenTalk2", "Buy")
						else
							if ( game.Players.LocalPlayer.Character:FindFirstChild("Pineapple") or game.Players.LocalPlayer.Backpack:FindFirstChild("Pineapple") ) and ( game.Players.LocalPlayer.Character:FindFirstChild("Banana") or game.Players.LocalPlayer.Backpack:FindFirstChild("Banana") ) and ( game.Players.LocalPlayer.Character:FindFirstChild("Apple") or game.Players.LocalPlayer.Backpack:FindFirstChild("Apple") ) then
								game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen")
							else
								if game:GetService("Workspace").AppleSpawner:FindFirstChild("Apple") and not ( game.Players.LocalPlayer.Character:FindFirstChild("Apple") or game.Players.LocalPlayer.Backpack:FindFirstChild("Apple") ) then
									for i,v in pairs(game:GetService("Workspace").AppleSpawner:GetChildren()) do
										if v:IsA("Tool") then fask.wait(1)
											firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart,v.Handle,0)
											fask.wait()
											firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart,v.Handle,1)
										end
									end
								end
								if game:GetService("Workspace").PineappleSpawner:FindFirstChild("Pineapple") and not ( game.Players.LocalPlayer.Character:FindFirstChild("Pineapple") or game.Players.LocalPlayer.Backpack:FindFirstChild("Pineapple") ) then
									for i,v in pairs(game:GetService("Workspace").PineappleSpawner:GetChildren()) do
										if v:IsA("Tool") then fask.wait(1)
											firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart,v.Handle,0)
											fask.wait()
											firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart,v.Handle,1)
										end
									end
								end
								if game:GetService("Workspace").BananaSpawner:FindFirstChild("Banana") and not ( game.Players.LocalPlayer.Character:FindFirstChild("Banana") or game.Players.LocalPlayer.Backpack:FindFirstChild("Banana") ) then
									for i,v in pairs(game:GetService("Workspace").BananaSpawner:GetChildren()) do
										if v:IsA("Tool") then fask.wait(1)
											firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart,v.Handle,0)
											fask.wait()
											firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart,v.Handle,1)
										end
									end
								end
							end
						end
					end
				else
					break
				end
			end
		end)
	end
end})

local TapRace = Lib:CreateTap("Race!");

local V4Page = TapRace:CreatePage("V4",1)


if type(_G.AutoV4) ~= "table" then
	_G.AutoV4 = {
		["Select Party"] = {},
		["Select Host"] = "",
		["Select Way Gear"] = "",
		["Different Computers Mode"] = false,
		["Auto V4"] = false
	}
end

if not isfolder("RoyX_V4") then
	makefolder("RoyX_V4")
end

if not isfile("RoyX_V4/SettingV4"..game.Players.LocalPlayer.UserId..".txt") then
	writefile("RoyX_V4/SettingV4"..game.Players.LocalPlayer.UserId..".txt",HttpService:JSONEncode(_G.AutoV4))
else
	_G.AutoV4 = HttpService:JSONDecode(readfile("RoyX_V4/SettingV4"..game.Players.LocalPlayer.UserId..".txt"))
end

V4Page:AddLabel("Can't Use Now")--V4Page:AddLabel("Beta Fully")

local V4Host = V4Page:AddLabel("Host V4 : Nil")

local V4TeamPlayer = V4Page:AddLabel("Party V4 : Nil")


SelectPartyV4 = _G.AutoV4["Select Party"] or {}
SelectHostV4 = _G.AutoV4["Select Host"] or ""

PlayerName = {}
for i,v in pairs(game.Players:GetChildren()) do
	table.insert(PlayerName ,v.Name)
end

V4TeamPlayer:Options().Text = "Party V4 : " .. table.concat(SelectPartyV4,",")

local HostPlayers = V4Page:AddDropdown("Selected Host",{Values = {SelectHostV4} , callback = function(starts)
	SelectHostV4 = starts
	V4Host:Options().Text = "Host V4 : " .. SelectHostV4
	_G.AutoV4["Select Host"] = starts
	writefile("RoyX_V4/SettingV4"..game.Players.LocalPlayer.UserId..".txt",HttpService:JSONEncode(_G.AutoV4))
end})

PartyPlayers = V4Page:AddMultiDropdown("Selected Party",{Values = SelectPartyV4,setup=SelectPartyV4 , callback = function(starts)
	SelectPartyV4 = starts
	V4TeamPlayer:Options().Text = "Party V4 : " .. table.concat(SelectPartyV4,",")
	_G.AutoV4["Select Party"] = starts
	writefile("RoyX_V4/SettingV4"..game.Players.LocalPlayer.UserId..".txt",HttpService:JSONEncode(_G.AutoV4))
end})

V4Page:AddButton("Refresh Players",function()
	PartyPlayers:Clear()
	HostPlayers:Clear()
	PlayerName = {}
	for i,v in pairs(game.Players:GetChildren()) do
		table.insert(PlayerName ,v.Name)
	end
	for i, v in pairs(PlayerName) do
		PartyPlayers:Add(v)
		HostPlayers:Add(v)
	end
end)

local MsgReady = {
	"Halo_How_AreU",
	"i_find_thxxu",
	"this_game_so_good"
}

local OpenRaceMsg = {
	"what_is_it_how_to_know",
	"it_just_mob_dont_mind",
	"owo_so_cool"
}

local ReadySendNow = 0
local NameNotDup = {

}

game:GetService("Players").LocalPlayer.PlayerGui.Chat.Frame.ChatChannelParentFrame.Frame_MessageLogDisplay.Scroller.ChildAdded:Connect(function(v)
	fask.wait(0.5)
	if AutoV4 then
		if v:FindFirstChild("TextLabel") then
			local Msg = v.TextLabel.Text:gsub(" ","")
			local NameF = (v.TextLabel.TextButton.Text:gsub("%[","")):split("%]")[1]
			if AutoV4 then
				if table.find(OpenRaceMsg,Msg) then
					ReadySendNow = 0
					NameNotDup = {

					}
					game:GetService("ReplicatedStorage").Remotes.CommE:FireServer("ActivateAbility")
				end
				if game.Players.LocalPlayer.Name == SelectHostV4 then
					if table.find(MsgReady,Msg) and not table.find(NameNotDup,NameF) then
						table.insert(NameNotDup,NameF)
						ReadySendNow = ReadySendNow + 1
					end
				end
			end
		end
	end
end)

local function havetrial()
	if game:GetService("Players")["LocalPlayer"].PlayerGui.Main.Timer.Visible == true then
		if game:GetService("Players").LocalPlayer.Data.Race.Value == "Mink" and game:GetService("Workspace").Map:FindFirstChild("MinkTrial") then--มิ้ง
			return true
		elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Human" and game:GetService("Workspace").Map:FindFirstChild("HumanTrial")  then--เผ่ามนุษย์
			return true
		elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Fishman" and game:GetService("Workspace").Map:FindFirstChild("FishmanTrial") then--ปลา
			return true
		elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Cyborg" and game:GetService("Workspace").Map:FindFirstChild("CyborgTrial")  then--ไซบอร์ก
			toTarget(game:GetService("Workspace").Map.CyborgTrial:GetModelCFrame() * CFrame.new(1,150,0))
		elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Ghoul" and game:GetService("Workspace").Map:FindFirstChild("GhoulTrial")  then--กูล
			return true
		elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Skypiea" and game:GetService("Workspace").Map:FindFirstChild("SkyTrial") then--สกาย
			return true
		end
	end
	return false
end

local function DoTrialPls()
	if game:GetService("Players").LocalPlayer.Data.Race.Value == "Mink" and game:GetService("Workspace").Map:FindFirstChild("MinkTrial") then--มิ้ง
		if (game:GetService("Workspace").Map:FindFirstChild("MinkTrial"):GetModelCFrame().Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 1000 then
			if not game:GetService("Workspace"):FindFirstChild "StartPoint" then

			elseif game:GetService("Workspace"):FindFirstChild "StartPoint" then
				MinkToTar = toTarget(game:GetService("Workspace"):FindFirstChild("StartPoint").CFrame *CFrame.new(0,1,0))
			end
		else
			if MinkToTar then MinkToTar:Stop() end
		end
	elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Human" and game:GetService("Workspace").Map:FindFirstChild("HumanTrial")  then--เผ่ามนุษย์
		for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
			if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
				pcall(function()
					repeat fask.wait(.1)
						v.Humanoid.Health = 0
						v.HumanoidRootPart.CanCollide = false
						sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
					until not (AutoRaceTrial or AutoV4) or not v.Parent or v.Humanoid.Health <= 0
				end)
			end
		end
	elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Fishman" and game:GetService("Workspace").Map:FindFirstChild("FishmanTrial") then--ปลา
		for i, v in pairs(game:GetService("Workspace").SeaBeasts:GetChildren()) do
			if v:FindFirstChild("HumanoidRootPart") and (AutoRaceTrial or AutoV4) and (v:FindFirstChild("HumanoidRootPart").Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 800 then
				toTarget(v:FindFirstChild("HumanoidRootPart").CFrame * CFrame.new(0, 450, 0))
				for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
					if v:IsA("Tool") then
						if table.find({"Melee","Blox Fruit" , "Sword" },v.ToolTip) then -- "Blox Fruit" , "Sword" , "Wear" , "Agility"
							game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
							fask.wait(.2)
							game:GetService("VirtualInputManager"):SendKeyEvent(true,122,false,game.Players.LocalPlayer.Character.HumanoidRootPart)
							game:GetService("VirtualInputManager"):SendKeyEvent(false,122,false,game.Players.LocalPlayer.Character.HumanoidRootPart)
							fask.wait(.2)
							game:GetService("VirtualInputManager"):SendKeyEvent(true,120,false,game.Players.LocalPlayer.Character.HumanoidRootPart)
							game:GetService("VirtualInputManager"):SendKeyEvent(false,120,false,game.Players.LocalPlayer.Character.HumanoidRootPart)
							fask.wait(.2)
							game:GetService("VirtualInputManager"):SendKeyEvent(true,99,false,game.Players.LocalPlayer.Character.HumanoidRootPart)
							game:GetService("VirtualInputManager"):SendKeyEvent(false,99,false,game.Players.LocalPlayer.Character.HumanoidRootPart)

						end
					end
				end
			end
		end
	elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Cyborg" and game:GetService("Workspace").Map:FindFirstChild("CyborgTrial")  then--ไซบอร์ก
		toTarget(game:GetService("Workspace").Map.CyborgTrial:GetModelCFrame() * CFrame.new(1,150,0))
	elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Ghoul" and game:GetService("Workspace").Map:FindFirstChild("GhoulTrial")  then--กูล
		for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
			if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
				pcall(function()
					repeat fask.wait(.1)
						v.Humanoid.Health = 0
						v.HumanoidRootPart.CanCollide = false
						sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
					until not (AutoRaceTrial or AutoV4) or not v.Parent or v.Humanoid.Health <= 0
				end)
			end
		end
	elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Skypiea" and game:GetService("Workspace").Map:FindFirstChild("SkyTrial") then--สกาย
		if (game:GetService("Workspace").Map:FindFirstChild("SkyTrial"):GetModelCFrame().Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 1000 then
			for i,v in pairs(game:GetService("Workspace").Map.SkyTrial.Model:GetChildren()) do
				if v.Name ==  "snowisland_Cylinder.081" then
					SkyToTar = toTarget(v.CFrame* CFrame.new(0,0,0))
				end
			end
		else
			if SkyToTar then SkyToTar:Stop() end
		end

	else
		if tween then tween:Cancel() end
	end
end

V4Page:AddToggle("Auto V4",{Stats = _G.AutoV4["Auto V4"] or false , callback = function(starts)
	AutoV4 = starts
	_G.AutoV4["Auto V4"] = starts
	writefile("RoyX_V4/SettingV4"..game.Players.LocalPlayer.UserId..".txt",HttpService:JSONEncode(_G.AutoV4))
	spawn(function()
		while fask.wait() do
			if AutoV4 then
				xpcall(function()
					local CheckRaceup = _F("UpgradeRace","Check")
					if CheckRaceup == 0 or (table.find(SelectPartyV4,game.Players.LocalPlayer.Name) and CheckRaceup == 5) then
						if game.Players.LocalPlayer.Name == SelectHostV4 then
							if CheckPlayerInServ(SelectPartyV4) then
								if havetrial() then
									DoTrialPls()
								elseif game:GetService("Workspace").Map["Temple of Time"].FFABorder.Forcefield.Transparency < 1 then

								else
									local DoorCF
									if game:GetService("Players").LocalPlayer.Data.Race.Value == "Mink" then
										DoorCF = CFrame.new(29022.06640625, 14890.658203125, -379.0537109375)
									elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Human" then
										DoorCF = CFrame.new(29238.294921875, 14890.658203125, -206.130615234375)
									elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Fishman" then
										DoorCF = CFrame.new(28227.8671875, 14890.658203125, -212.64332580566406)
									elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Cyborg" then
										DoorCF = CFrame.new(28491.025390625, 14895.658203125, -422.96429443359375)
									elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Ghoul" then
										DoorCF = CFrame.new(28673.31640625, 14890.3583984375, 456.43255615234375)
									elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Skypiea" then
										DoorCF = CFrame.new(28969.44140625, 14919.306640625, 233.89479064941406)
									end
									if not DoorCF then return end
									local TaStopDone = toTarget(DoorCF * CFrame.new(math.random(0,5),0,math.random(0,5)))
									if (DoorCF.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
										if TaStopDone then
											TaStopDone:Stop()
										end
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = DoorCF
										if ReadySendNow > 2 then
											fask.wait(0.5)
											game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(tostring(OpenRaceMsg[math.random(1,#OpenRaceMsg)]), "All")
										end
										fask.wait(1)
									end
								end

							else
								Notify({
									Title = "Alert!!!!",
									Text = "U Party Not In Server",
									Timer = 3
								},"Warn")
								fask.wait(3)
							end
						elseif table.find(SelectPartyV4,game.Players.LocalPlayer.Name) then
							if CheckPlayerInServ(SelectPartyV4) and CheckPlayerInServ({SelectHostV4}) then
								if havetrial() then
									DoTrialPls()
								elseif game:GetService("Workspace").Map["Temple of Time"].FFABorder.Forcefield.Transparency < 1 then
									if game:GetService("Players")["LocalPlayer"].PlayerGui.Main.Timer.Visible == true then
										local Humn = game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid")
										if Humn then
											Humn.Health = 0
										end
									end
								else
									local DoorCF
									if game:GetService("Players").LocalPlayer.Data.Race.Value == "Mink" then
										DoorCF = CFrame.new(29015.681640625, 14890.6328125, -379.1084289550781)
									elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Human" then
										DoorCF = CFrame.new(29232.015625, 14890.6328125, -206.3213348388672)
									elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Fishman" then
										DoorCF = CFrame.new(28227.8671875, 14890.658203125, -212.64332580566406)
									elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Cyborg" then
										DoorCF = CFrame.new(28499.8359375, 14895.6328125, -423.3853759765625)
									elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Ghoul" then
										DoorCF = CFrame.new(28672.34375, 14890.333984375, 448.00518798828125)
									elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Skypiea" then
										DoorCF = CFrame.new(28962.724609375, 14919.28125, 234.03871154785156)
									end
									if not DoorCF then return end
									local TaStopDone = toTarget(DoorCF)
									if (DoorCF.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
										if TaStopDone then
											TaStopDone:Stop()
										end
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = DoorCF
										spawn(function()
											if not delaysend10sec then
												delaysend10sec = true
												game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(tostring(MsgReady[math.random(1,#MsgReady)]), "All")
												fask.wait(8)
												delaysend10sec = false
											end
										end)
										fask.wait(0.1)
									end
								end
							else
								Notify({
									Title = "Alert!!!!",
									Text = "U Party/Host Not In Server",
									Timer = 3
								},"Warn")
								fask.wait(3)
							end
						else
							table.foreach(SelectPartyV4,print)

							Notify({
								Title = "Alert!!!!",
								Text = "U Not Have Party",
								Timer = 3
							},"Warn")
							fask.wait(3)
						end
					elseif CheckRaceup == 5 then
						Notify({
							Title = "Notify!!",
							Text = "U Race Max",
							Timer = 3
						},"Success")
						fask.wait(4)
					elseif CheckRaceup % 2 == 0 then
						if game:GetService("Players")["LocalPlayer"].Character.RaceTransformed.Value == true then
							local me = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame
							repeat fask.wait()
								game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = me * CFrame.new(1,500,0)
							until not AutoV4 or game:GetService("Players")["LocalPlayer"].Character.RaceTransformed.Value == false
							fask.wait(0.2)
							game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = me
							fask.wait(0.2)
						else
							local OpenV4Race = inmyself("Awakening")
							if OpenV4Race then
								OpenV4Race.RemoteFunction:InvokeServer(true)
							end
							MaterialMob = {"Sweet Thief [Lv. 2350]","Candy Rebel [Lv. 2375]","Candy Pirate [Lv. 2400]","Snow Demon [Lv. 2425]"}

							CFrameMonM = {
								CFrame.new(71.89511108398438, 77.21478271484375, -12632.435546875),
								CFrame.new(134.3748016357422, 77.21473693847656, -12882.1650390625),
								CFrame.new(-1271.6993408203125, 139.93331909179688, -14354.8515625),
								CFrame.new(-844.35546875, 138.32464599609375, -14496.455078125),
							}
							if CustomFindFirstChild(MaterialMob) then
								for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
									if AutoV4 and game:GetService("Players")["LocalPlayer"].Character.RaceTransformed.Value == false and table.find(MaterialMob,v.Name) and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
										repeat fask.wait()
											FarmtoTarget = toTarget(v.HumanoidRootPart.CFrame * CFrame.new(0,30,1))
											if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
												if FarmtoTarget then FarmtoTarget:Stop() end
												Usefastattack = true
												EquipWeapon(SelectToolWeapon)
												spawn(function()
													for i,v2 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
														if table.find(MaterialMob,v2.Name) then
															spawn(function()
																if InMyNetWork(v2.HumanoidRootPart) then
																	v2.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
																	v2.Humanoid.JumpPower = 0
																	v2.Humanoid.WalkSpeed = 0
																	v2.HumanoidRootPart.CanCollide = false
																	v2.Humanoid:ChangeState(14)
																	v2.Humanoid:ChangeState(11)
																	v2.HumanoidRootPart.Size = Vector3.new(55,55,55)
																end
															end)
														end
													end
												end)
												if game.Players.LocalPlayer.Character:FindFirstChild("Black Leg") and game.Players.LocalPlayer.Character:FindFirstChild("Black Leg").Level.Value >= 150 then
													game:service('VirtualInputManager'):SendKeyEvent(true, "V", false, game)
													game:service('VirtualInputManager'):SendKeyEvent(false, "V", false, game)
												end
												game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 1)
											end
										until not CustomFindFirstChild(MaterialMob) or not AutoV4 or v.Humanoid.Health <= 0 or not v.Parent or game:GetService("Players")["LocalPlayer"].Character.RaceTransformed.Value == true
										Usefastattack = false
									end
								end
							else
								Usefastattack = false
								for i,v in pairs(CFrameMonM) do
									if AutoV4 and not CustomFindFirstChild(MaterialMob) and game:GetService("Players")["LocalPlayer"].Character.RaceTransformed.Value == false then
										while AutoV4 and not CustomFindFirstChild(MaterialMob) and game:GetService("Players")["LocalPlayer"].Character.RaceTransformed.Value == false do fask.wait()
											Modstween = toTarget(v)
											if (v.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
												if Modstween then Modstween:Stop() end
												game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v
												break
											end
											fask.wait(1)
										end
									end
									fask.wait(0)
								end
							end
						end
					elseif CheckRaceup % 2 == 1 then
						_F("UpgradeRace","Buy")
					end
				end,print)
			else
				break;
			end
		end
	end)
end})

V4Page:AddToggle("Auto Die After Trial",{Stats = false , callback = function(starts)
	Autodieafter = starts
	spawn(function()
		while fask.wait(1) do
			if not Autodieafter then
				break
			end
			if game:GetService("Workspace").Map["Temple of Time"].FFABorder.Forcefield.Transparency < 1 then
				if game:GetService("Players")["LocalPlayer"].PlayerGui.Main.Timer.Visible == true then
					local Humn = game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid")
					if Humn then
						Humn.Health = 0
					end
				end
			end
		end
	end)
end})
local RoomPosition = Vector3.new(28719.505859375, 14899.4365234375, -95.38821411132812)
V4Page:AddToggle("Auto Kill Player After Trial",{Stats = false , callback = function(starts)
	autokillafter = starts
	spawn(function()
		while fask.wait(0.1) do
			if autokillafter then
				if game:GetService("Workspace").Map["Temple of Time"].FFABorder.Forcefield.Transparency < 1 then
					if game:GetService("Players")["LocalPlayer"].PlayerGui.Main.Timer.Visible == true then
						local MaxRange = 250
						local tar = ""
						for i,v in pairs(game:GetService("Workspace").Characters:GetChildren()) do
							if autokillafter and (v.HumanoidRootPart.Position - RoomPosition).magnitude <= 150 then
								local rangenow = (RoomPosition - v:FindFirstChild("HumanoidRootPart").Position).Magnitude
								if rangenow < MaxRange then 
									MaxRange = rangenow
									tar = v.Name
								end
							end
						end
						for i,v in pairs(game:GetService("Workspace").Characters:GetChildren()) do
							if autokillafter and v.Name == tar then
								repeat fask.wait()
									if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then 
										Farmtween = toTargetNoDie(v.HumanoidRootPart.CFrame)
										UsefastattackPlayers = false
									else
										if Farmtween then Farmtween:Stop() end
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(1,11,0)
										EquipWeapon(SelectToolWeapon)
										UsefastattackPlayers = true
									end
								until not autokillafter or game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health == 0 or v.Humanoid.Health == 0 or (v.HumanoidRootPart.Position - RoomPosition).magnitude > 150  or not v.Parent
								UsefastattackPlayers = false
								if Farmtween then Farmtween:Stop() end
								fask.wait(1)
							end
						end
					end
				end
			else
				break
			end

		end
	end)
end})

V4Page:AddLabel("---------")

V4Page:AddButton("Tp To Temple of time",function()
	local TaStopDone = toTarget(CFrame.new(28288.15234375, 14896.5341796875, 100.4998779296875))
	NoClip = true
	TaStopDone:Wait()
	NoClip = false
end)

local RaceDoor = {
	["Human Door"] = CFrame.new(29232.015625, 14890.6328125, -206.3213348388672),
	["Mink Door"] = CFrame.new(29015.681640625, 14890.6328125, -379.1084289550781),
	["Sky Door"] = CFrame.new(28962.724609375, 14919.28125, 234.03871154785156),
	["Fish Door"] = CFrame.new(28227.8671875, 14890.658203125, -212.64332580566406),
	["Cyborg Door"] = CFrame.new(28499.8359375, 14895.6328125, -423.3853759765625),
	["Ghoul Door"] = CFrame.new(28672.34375, 14890.333984375, 448.00518798828125),
	["Ancient One"] = CFrame.new(28973.794921875, 14889.658203125, -117.06352996826172),
	["Clock"] = CFrame.new(29553.7812, 15066.6133, -88.2750015, 1, 0, 0, 0, 1, 0, 0, 0, 1)
}

for i,v in pairs(RaceDoor) do
	V4Page:AddButton(i,function()
		local TaStopDone = toTarget(v)
		NoClip = true
		TaStopDone:Wait()
		NoClip = false
	end)
end

V4Page:AddLabel("---------")

V4Page:AddButton("Tp To U Race Door",function()
	local DoorCF
	if game:GetService("Players").LocalPlayer.Data.Race.Value == "Mink" then
		DoorCF = CFrame.new(29015.681640625, 14890.6328125, -379.1084289550781)
	elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Human" then
		DoorCF = CFrame.new(29232.015625, 14890.6328125, -206.3213348388672)
	elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Fishman" then
		DoorCF = CFrame.new(28227.8671875, 14890.658203125, -212.64332580566406)
	elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Cyborg" then
		DoorCF = CFrame.new(28499.8359375, 14895.6328125, -423.3853759765625)
	elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Ghoul" then
		DoorCF = CFrame.new(28672.34375, 14890.333984375, 448.00518798828125)
	elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Skypiea" then
		DoorCF = CFrame.new(28962.724609375, 14919.28125, 234.03871154785156)
	end
	if not DoorCF then return end
	local TaStopDone = toTarget(DoorCF)
	NoClip = true
	TaStopDone:Wait()
	NoClip = false
end)

V4Page:AddToggle("Auto Pull Lever Fully",{Stats = false , callback = function(starts)
	AutoPullFuly = starts
	spawn(function()
		while fask.wait(.5) do
			if AutoPullFuly then
				if _F('CheckTempleDoor') == true and game:GetService("Workspace").Map["Temple of Time"].Lever.Prompt:FindFirstChild("ProximityPrompt").Enabled == true then
					fireproximityprompt(game:GetService("Workspace").Map["Temple of Time"].Lever.Prompt:FindFirstChild("ProximityPrompt"),0)
					return;
				end
				if game:GetService("Workspace").Map:FindFirstChild("MysticIsland") and (function()local a=tonumber(game:GetService("Lighting").ClockTime)if a>=18 or a>=0 and a<=5 then local b;if a>5 and a<=24 then b=(29-a)/0.0166667/60 else b=(5-a)/0.0166667/60 end;local c,d=math.modf(b)d=math.floor(d*60)return true end;return false end)() then
					if (function()if game:GetService("Workspace").Map:FindFirstChild("MysticIsland")then for a,b in pairs(game:GetService("Workspace").Map:FindFirstChild("MysticIsland"):GetDescendants())do if b.Name=='Part'then if b.Material==Enum.Material.Neon and b.Transparency==0 then return true end end end end;return false end)() then
						for i,v in pairs(game:GetService("Workspace").Map:FindFirstChild("MysticIsland"):GetDescendants()) do
							if v.Name == 'Part' then
								if v.Material == Enum.Material.Neon then
									toTarget(v.CFrame)
								end
							end
						end
						return;
					end
					local totar = toTarget(game:GetService("Workspace").Map:FindFirstChild("MysticIsland"):GetModelCFrame() * CFrame.new(1,100,0))
					totar:Wait()
					game:GetService("ReplicatedStorage").Remotes.CommE:FireServer("ActivateAbility")
					-- Calculate the position of the moon
					local MoonPos = game:GetService("Lighting"):GetMoonDirection() * 50 * 10000

					local Current = game.Workspace.CurrentCamera
					Current.CoordinateFrame = CFrame.new(Current.CoordinateFrame.p, MoonPos)
					return
				end
				Notify({
					Title = "Script RoyXHub_BF",
					Text = "Can't Find Because not night or mirage",
					Timer = 2
				},"Success")
				fask.wait(2)
				return;
			else
				break;
			end
		end
	end)
end})

V4Page:AddToggle("Auto Gear + Pull Lever",{Stats = false , callback = function(starts)
	AutoLeverGear = starts
	spawn(function()
		while fask.wait() do
			if AutoLeverGear then
				if _F('CheckTempleDoor') == true and game:GetService("Workspace").Map["Temple of Time"].Lever.Prompt:FindFirstChild("ProximityPrompt").Enabled == true then
					fireproximityprompt(game:GetService("Workspace").Map["Temple of Time"].Lever.Prompt:FindFirstChild("ProximityPrompt"),0)
				elseif (function()if game:GetService("Workspace").Map:FindFirstChild("MysticIsland")then for a,b in pairs(game:GetService("Workspace").Map:FindFirstChild("MysticIsland"):GetDescendants())do if b.Name=='Part'then if b.Material==Enum.Material.Neon and b.Transparency==0 then return true end end end end;return false end)() then
					if game:GetService("Workspace").Map:FindFirstChild("MysticIsland") then
						for i,v in pairs(game:GetService("Workspace").Map:FindFirstChild("MysticIsland"):GetDescendants()) do
							if v.Name == 'Part' then
								if v.Material == Enum.Material.Neon then
									toTarget(v.CFrame)
								end
							end
						end
					end
				end
			else
				break;
			end
			fask.wait(0.5)
		end
	end)
end})

V4Page:AddToggle("Auto Look Moon + Awake",{Stats = false , callback = function(starts)
	AutoLookAwake = starts
	spawn(function()
		while fask.wait(0.1) do
			if AutoLookAwake then
				if not (function()if game:GetService("Workspace").Map:FindFirstChild("MysticIsland")then for a,b in pairs(game:GetService("Workspace").Map:FindFirstChild("MysticIsland"):GetDescendants())do if b.Name=='Part'then if b.Material==Enum.Material.Neon and b.Transparency==0 then return true end end end end;return false end)() then
					game:GetService("ReplicatedStorage").Remotes.CommE:FireServer("ActivateAbility")
					-- Calculate the position of the moon
					local MoonPos = game:GetService("Lighting"):GetMoonDirection() * 50 * 10000

					local Current = game.Workspace.CurrentCamera
					Current.CoordinateFrame = CFrame.new(Current.CoordinateFrame.p, MoonPos)
				end
			else
				break;
			end
		end
	end)
end})

V4Page:AddToggle("Auto Active Race v4",{Stats = false , callback = function(starts)
	AutoActiveRacev4 = starts
	spawn(function()
		while fask.wait(1) do
			if AutoActiveRacev4 then
				local OpenV4Race = inmyself("Awakening")
				if OpenV4Race then
					OpenV4Race.RemoteFunction:InvokeServer(true)
				end
			else
				break
			end
		end
	end)
end})

local ENGTEXT = V4Page:AddLabel("⬇️Now Fully (Maybe)")

V4Page:AddToggle("Auto Ancient Quest",{Stats = false , callback = function(starts)
	AutoAncientQuest = starts
	spawn(function()
		while fask.wait() do
			if AutoAncientQuest then
				xpcall(function()
					local CheckRaceup = _F("UpgradeRace","Check")
					if CheckRaceup == 0 then
						Notify({
							Title = "Notify!!",
							Text = "Ready To Next Trial ;>",
							Timer = 3
						},"Success")
						local TaStopDone = toTarget(CFrame.new(28288.15234375, 14896.5341796875, 100.4998779296875))
						TaStopDone:Wait()
						fask.wait(4)
					elseif CheckRaceup == 5 then
						Notify({
							Title = "Notify!!",
							Text = "U Race Max",
							Timer = 3
						},"Success")
						fask.wait(4)
					else
						_F("UpgradeRace","Buy")
						if game:GetService("Players")["LocalPlayer"].Character.RaceTransformed.Value == true then
							local me = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame
							repeat fask.wait()
								game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = me * CFrame.new(1,500,0)
							until not AutoAncientQuest or game:GetService("Players")["LocalPlayer"].Character.RaceTransformed.Value == false
							fask.wait(0.2)
							game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = me
							fask.wait(0.2)
						else
							local OpenV4Race = inmyself("Awakening")
							if OpenV4Race then
								OpenV4Race.RemoteFunction:InvokeServer(true)
							end
							if game:GetService("Workspace").Enemies:FindFirstChild("Reborn Skeleton [Lv. 1975]") or game:GetService("Workspace").Enemies:FindFirstChild("Living Zombie [Lv. 2000]") or game:GetService("Workspace").Enemies:FindFirstChild("Demonic Soul [Lv. 2025]") or game:GetService("Workspace").Enemies:FindFirstChild("Posessed Mummy [Lv. 2050]") then
								for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
									if AutoAncientQuest and (v.Name == "Reborn Skeleton [Lv. 1975]" or v.Name == "Living Zombie [Lv. 2000]" or v.Name == "Demonic Soul [Lv. 2025]" or v.Name == "Posessed Mummy [Lv. 2050]") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
										repeat fask.wait()
											if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
												Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
												Usefastattack = false
											elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
												if Farmtween then Farmtween:Stop() end
												Usefastattack = true
												PosFarmBone = v.HumanoidRootPart.CFrame
												EquipWeapon(SelectToolWeapon)
												toAroundTarget(v.HumanoidRootPart.CFrame)
												spawn(function()
													for i,v2 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
														if (v2.Name == "Reborn Skeleton [Lv. 1975]" or v2.Name == "Living Zombie [Lv. 2000]" or v2.Name == "Demonic Soul [Lv. 2025]" or v2.Name == "Posessed Mummy [Lv. 2050]") then
															spawn(function()
																if InMyNetWork(v2.HumanoidRootPart) then
																	v2.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
																	v2.Humanoid.JumpPower = 0
																	v2.Humanoid.WalkSpeed = 0
																	v2.HumanoidRootPart.CanCollide = false
																	v2.Humanoid:ChangeState(14)
																	v2.Humanoid:ChangeState(11)
																	v2.HumanoidRootPart.Size = Vector3.new(55,55,55)
																end
															end)
														end
													end
												end)

											end
										until not AutoAncientQuest or not v.Parent or v.Humanoid.Health <= 0
										Usefastattack = false

									end
								end
							else
								Usefastattack = false
								Questtween = toTarget(CFrame.new(-9506.14648, 172.130661, 6101.79053).Position,CFrame.new(-9506.14648, 172.130661, 6101.79053))
								if (CFrame.new(-9506.14648, 172.130661, 6101.79053).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
									if Questtween then
										Questtween:Stop()
									end
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-9506.14648, 172.130661, 6101.79053, -0.999731541, 0, -0.0231563263, 0, 1, 0, 0.0231563263, 0, -0.999731541)
								end
							end


						end
					end
				end,print)
			else
				break
			end
		end
	end)
end})

V4Page:AddToggle("Auto Race Trial",{Stats = false , callback = function(starts)
	AutoRaceTrial = starts
	spawn(function()
		while fask.wait() do
			if AutoRaceTrial then
				xpcall(function()
					if game:GetService("Players")["LocalPlayer"].PlayerGui.Main.Timer.Visible == true then
						if game:GetService("Players").LocalPlayer.Data.Race.Value == "Mink" and game:GetService("Workspace").Map:FindFirstChild("MinkTrial") then--มิ้ง
							if (game:GetService("Workspace").Map:FindFirstChild("MinkTrial"):GetModelCFrame().Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 1000 then
								if not game:GetService("Workspace"):FindFirstChild "StartPoint" then

								elseif game:GetService("Workspace"):FindFirstChild "StartPoint" then
									MinkToTar = toTarget(game:GetService("Workspace"):FindFirstChild("StartPoint").CFrame *CFrame.new(0,1,0))
								end
							else
								if MinkToTar then MinkToTar:Stop() end
							end
						elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Human" and game:GetService("Workspace").Map:FindFirstChild("HumanTrial")  then--เผ่ามนุษย์
							for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
								if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
									pcall(function()
										repeat fask.wait(.1)
											v.Humanoid.Health = 0
											v.HumanoidRootPart.CanCollide = false
											sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
										until not AutoRaceTrial or not v.Parent or v.Humanoid.Health <= 0
									end)
								end
							end
						elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Fishman" and game:GetService("Workspace").Map:FindFirstChild("FishmanTrial") then--ปลา
							for i, v in pairs(game:GetService("Workspace").SeaBeasts:GetChildren()) do
								if v:FindFirstChild("HumanoidRootPart") and AutoRaceTrial and (v:FindFirstChild("HumanoidRootPart").Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 800 then
									toTarget(v:FindFirstChild("HumanoidRootPart").CFrame * CFrame.new(0, 450, 0))
									task.spawn(function()

										if not LoppSeaDup then 

											LoppSeaDup = true 
											for i,v in ipairs({"Melee","Blox Fruit","Gun"  , "Sword" }) do 
												EquipWeapon(GetFightingStyle(v))
												fask.wait(0.2)
												if SkillZ then 
													game:service('VirtualInputManager'):SendKeyEvent(true, "Z", false, game)
													fask.wait(0.5)
													game:service('VirtualInputManager'):SendKeyEvent(false, "Z", false, game)
												end
												if SkillX then 
													game:service('VirtualInputManager'):SendKeyEvent(true, "X", false, game)
													fask.wait(0.5)
													game:service('VirtualInputManager'):SendKeyEvent(false, "X", false, game)
												end
												if SkillC then 
													game:service('VirtualInputManager'):SendKeyEvent(true, "C", false, game)
													fask.wait(0.5)
													game:service('VirtualInputManager'):SendKeyEvent(false, "C", false, game)
												end
												if SkillV then 
													game:service('VirtualInputManager'):SendKeyEvent(true, "V", false, game)
													fask.wait(0.5)
													game:service('VirtualInputManager'):SendKeyEvent(false, "V", false, game)
												end
												if SkillF then 
													game:service('VirtualInputManager'):SendKeyEvent(true, "F", false, game)
													fask.wait(0.5)
													game:service('VirtualInputManager'):SendKeyEvent(false, "F", false, game)
												end
												fask.wait(0.5)
											end
											LoppSeaDup = false
										end
									end)
								end
							end
						elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Cyborg" and game:GetService("Workspace").Map:FindFirstChild("CyborgTrial")  then--ไซบอร์ก
							toTarget(game:GetService("Workspace").Map.CyborgTrial:GetModelCFrame() * CFrame.new(1,150,0))
						elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Ghoul" and game:GetService("Workspace").Map:FindFirstChild("GhoulTrial")  then--กูล
							for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
								if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
									pcall(function()
										repeat fask.wait(.1)
											v.Humanoid.Health = 0
											v.HumanoidRootPart.CanCollide = false
											sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
										until not AutoRaceTrial or not v.Parent or v.Humanoid.Health <= 0
									end)
								end
							end
						elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Skypiea" and game:GetService("Workspace").Map:FindFirstChild("SkyTrial") then--สกาย
							if (game:GetService("Workspace").Map:FindFirstChild("SkyTrial"):GetModelCFrame().Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 1000 then
								for i,v in pairs(game:GetService("Workspace").Map.SkyTrial.Model:GetChildren()) do
									if v.Name ==  "snowisland_Cylinder.081" then
										SkyToTar = toTarget(v.CFrame* CFrame.new(0,0,0))
									end
								end
							else
								if SkyToTar then SkyToTar:Stop() end
							end

						else
							if tween then tween:Cancel() end
						end
					end
				end,print)
			else
				break
			end
		end
	end)
end})

local BasicPage = TapRace:CreatePage("Basic",2)

BasicPage:AddLabel("~ Auto Quest Flower ~")

ConfigAutoQuestFlower = BasicPage:AddToggle("Auto Quest Flower",{Stats = false , callback = function(starts)
	if not NewWorld then return end
	AutoEvoRace2 = starts
	_G.ConfigMain["Auto Quest Flower"] = starts
	SaveConfigAuto()
	spawn(function()
		while fask.wait() do
			if AutoEvoRace2 then
				if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist","3") ~= -2 then
					if game.Players.LocalPlayer.Backpack:FindFirstChild("Flower 1") and game.Players.LocalPlayer.Backpack:FindFirstChild("Flower 2") and game.Players.LocalPlayer.Backpack:FindFirstChild("Flower 3") then
						if (CFrame.new(-2777.6001, 72.9661407, -3571.42285).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
							Farmtween = toTarget(CFrame.new(-2777.6001, 72.9661407, -3571.42285).Position,CFrame.new(-2777.6001, 72.9661407, -3571.42285))
						elseif (CFrame.new(-2777.6001, 72.9661407, -3571.42285).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
							if Farmtween then
								Farmtween:Stop()
							end
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2777.6001, 72.9661407, -3571.42285)
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist","3")
						end
					else
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist", "1")
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist", "2")
						if not game.Players.LocalPlayer.Backpack:FindFirstChild("Flower 1") and workspace.Flower1.Transparency ~= 1 then
							if workspace.Flower1.Transparency ~= 1 then
								if (workspace.Flower1.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
									Farmtween = toTarget(workspace.Flower1.Position,workspace.Flower1.CFrame)
								elseif (workspace.Flower1.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
									if Farmtween then
										Farmtween:Stop()
									end
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Flower1.CFrame
								end
							end
						elseif not game.Players.LocalPlayer.Backpack:FindFirstChild("Flower 2") and workspace.Flower2.Transparency ~= 1 then
							if workspace.Flower2.Transparency ~= 1 then
								if (workspace.Flower2.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
									Farmtween = toTarget(workspace.Flower2.Position,workspace.Flower2.CFrame)
								elseif (workspace.Flower2.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
									if Farmtween then
										Farmtween:Stop()
									end
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Flower2.CFrame
								end
							end
						elseif not game.Players.LocalPlayer.Backpack:FindFirstChild("Flower 3") then
							if game.Workspace.Enemies:FindFirstChild("Swan Pirate [Lv. 775]") then
								for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
									if AutoEvoRace2 and v.Name == "Swan Pirate [Lv. 775]" and v:FindFirstChild("Humanoid") and v.Humanoid.Health >= 0 then
										pcall(function()
											repeat fask.wait()
												if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
													Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
												elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
													if Farmtween then
														Farmtween:Stop()
													end
													EquipWeapon(SelectToolWeapon)
													Usefastattack = true
													game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 10, 10)
												end
											until not v.Parent or v.Humanoid.Health <= 0 or AutoEvoRace2 == false or game.Players.LocalPlayer.Backpack:FindFirstChild("Flower 3")
											AutoEvoBring = false
											Usefastattack = false
										end)
									end
								end
							else
								if (CFrame.new(1057.92761, 137.614319, 1242.08069).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
									Farmtween = toTarget(CFrame.new(1057.92761, 137.614319, 1242.08069).Position,CFrame.new(1057.92761, 137.614319, 1242.08069))
								elseif (CFrame.new(1057.92761, 137.614319, 1242.08069).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
									if Farmtween then
										Farmtween:Stop()
									end
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1057.92761, 137.614319, 1242.08069)
								end
							end
						end
					end
				end
			else
				break;
			end
		end
	end)
end})

BasicPage:AddLabel("~ Auto V3 ~")

local KillThisBossTab = {
	["Dai"] = false,
	["Jer"] = false,
	["Faji"] = false,
}

ConfigAutoQuestV3 = BasicPage:AddToggle("Auto V3 (Human, Mink,FishMan)",{Stats = false , callback = function(starts)
	if not NewWorld then return end
	AutoEvoRace3 = starts
	_G.ConfigMain["Auto Quest V3"] = starts
	SaveConfigAuto()
	spawn(function()
		while fask.wait() do
			if AutoEvoRace3 then
				if _F("Alchemist","1") == -2 then
					if game:GetService("Players").LocalPlayer.Data.Race.Value == "Human" or game:GetService("Players").LocalPlayer.Data.Race.Value == "Mink" or game:GetService("Players").LocalPlayer.Data.Race.Value == "Fishman" then
						local RaceCheck = _F("Wenlocktoad","1")
						if RaceCheck == 2 then
							_F("Wenlocktoad","3")
							if game:GetService("Players").LocalPlayer.Data.Race.Value == "Fishman" then
								ChangeToggle(ConfigAutoSeabeast,false)
							end
							if game:GetService("Players").LocalPlayer.Data.Race.Value == "Mink" then
								ChangeToggle(ConfigAutoChest,false)
							end
						elseif RaceCheck == 1 then
							if game:GetService("Players").LocalPlayer.Data.Race.Value == "Mink" then
								ChangeToggle(ConfigAutoChest,true)
							elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Human" then
								if havemob("Diamond [Lv. 750] [Boss]") and KillThisBossTab["Dai"] == false then
									if game.Workspace.Enemies:FindFirstChild("Diamond [Lv. 750] [Boss]") then
										if KillBossTar then KillBossTar:Stop() end
										for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
											if AutoEvoRace3 and v.Name == "Diamond [Lv. 750] [Boss]" and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health >= 0 then
												repeat fask.wait()
													if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
														Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
													elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
														if Farmtween then
															Farmtween:Stop()
														end
														EquipWeapon(SelectToolWeapon)
														Usefastattack = true
														game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 10, 10)
													end
												until not v.Parent or v.Humanoid.Health <= 0 or AutoEvoRace3 == false
												Usefastattack = false
												if not v.Parent or v.Humanoid.Health <= 0 then
													KillThisBossTab["Dai"] = true
												end
											end
										end
									else
										Usefastattack = false
										KillBossTar = toTarget(havemob("Diamond [Lv. 750] [Boss]").HumanoidRootPart.CFrame * CFrame.new(1,50,0))
									end
								elseif havemob("Jeremy [Lv. 850] [Boss]") and KillThisBossTab["Jer"] == false then
									if game.Workspace.Enemies:FindFirstChild("Jeremy [Lv. 850] [Boss]") then
										if KillBossTar then KillBossTar:Stop() end
										for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
											if AutoEvoRace3 and v.Name == "Jeremy [Lv. 850] [Boss]" and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health >= 0 then
												repeat fask.wait()
													if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
														Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
													elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
														if Farmtween then
															Farmtween:Stop()
														end
														EquipWeapon(SelectToolWeapon)
														Usefastattack = true
														game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 10, 10)
													end
												until not v.Parent or v.Humanoid.Health <= 0 or AutoEvoRace3 == false
												Usefastattack = false
												if not v.Parent or v.Humanoid.Health <= 0 then
													KillThisBossTab["Jer"] = true
												end
											end
										end
									else
										Usefastattack = false
										KillBossTar = toTarget(havemob("Jeremy [Lv. 850] [Boss]").HumanoidRootPart.CFrame * CFrame.new(1,50,0))
									end
								elseif havemob("Fajita [Lv. 925] [Boss]") and KillThisBossTab["Faji"] == false then
									if game.Workspace.Enemies:FindFirstChild("Fajita [Lv. 925] [Boss]") then
										if KillBossTar then KillBossTar:Stop() end
										for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
											if AutoEvoRace3 and v.Name == "Fajita [Lv. 925] [Boss]" and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health >= 0 then
												repeat fask.wait()
													if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
														Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
													elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
														if Farmtween then
															Farmtween:Stop()
														end
														EquipWeapon(SelectToolWeapon)
														Usefastattack = true
														game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 10, 10)
													end
												until not v.Parent or v.Humanoid.Health <= 0 or AutoEvoRace3 == false
												Usefastattack = false
												if not v.Parent or v.Humanoid.Health <= 0 then
													KillThisBossTab["Faji"] = true
												end
											end
										end
									else
										Usefastattack = false
										KillBossTar = toTarget(havemob("Fajita [Lv. 925] [Boss]").HumanoidRootPart.CFrame * CFrame.new(1,50,0))
									end
								end
							elseif game:GetService("Players").LocalPlayer.Data.Race.Value == "Fishman" then
								ChangeToggle(ConfigAutoSeabeast,true)
							end
						elseif RaceCheck == 0 then
							_F("Wenlocktoad","2")
						elseif RaceCheck == -1 then
							Notify({
								Title = "Alert!!!",
								Text = 'You Not Have "Money"!',
								Timer = 3
							},"Warn")
							fask.wait(0.2)
						elseif RaceCheck == nil then
							Notify({
								Title = "Alert!!!",
								Text = "You Not Do Flower Quest",
								Timer = 3
							},"Warn")
							fask.wait(0.2)
						end
					else
						Notify({
							Title = "Alert!!!",
							Text = "Race Support Only Human , Mink,FishMan",
							Timer = 3
						},"Warn")
						fask.wait(0.2)
					end
				end
			else
				break;
			end
		end
	end)
end})

ConfigAutoGhoulR = BasicPage:AddToggle("Auto Ghoul Race Hop",{Stats = false , callback = function(starts)
	AutoGhoulRace = starts
	_G.ConfigMain["Auto Ghoul Race Hop"] = starts
	SaveConfigAuto()
	spawn(function()
		while fask.wait() do
			if AutoGhoulRace then
				if game.Players.LocalPlayer.Data.Level.Value >= 1000 then
					if GetMaterial("Ectoplasm") >= 100 then
						ChangeToggle(ConfigAutoFarmEctoplasm,false)
						if inmyself("Hellfire Torch") then
							local args = {
								[1] = "Ectoplasm",
								[2] = "BuyCheck",
								[3] = 4
							}

							game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))

						elseif havemob("Cursed Captain [Lv. 1325] [Raid Boss]") then
							if game.Workspace.Enemies:FindFirstChild("Cursed Captain [Lv. 1325] [Raid Boss]") then
								for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
									if AutoGhoulRace and v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and v.Name == "Mob Leader [Lv. 120] [Boss]" then
										repeat fask.wait()
											if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 150 then
												Farmtween = toTarget(v.HumanoidRootPart.CFrame * CFrame.new(0, 10, 10))
											elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 150 then
												if Farmtween then
													Farmtween:Stop()
												end
												EquipWeapon(SelectToolWeapon)
												Usefastattack = true
												if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
													_F("Buso")
												end
												game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 10, 10)
											end
										until not AutoGhoulRace or not v.Parent or v.Humanoid.Health <= 0
										Usefastattack = false
									end
								end
							else
								if (CFrame.new(916.928589, 181.092773, 33422).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 150 then
									Questtween = toTarget(CFrame.new(916.928589, 181.092773, 33422))
								elseif (CFrame.new(916.928589, 181.092773, 33422).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 150 then
									if Questtween then
										Questtween:Stop()
									end
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(916.928589, 181.092773, 33422)
								end
							end
						else
							ServerFunc:NormalTeleport()
						end
					else
						ChangeToggle(ConfigAutoFarmEctoplasm,true)
						fask.wait(0.5)
					end
				end
			end
		end
	end)
end})

local SeaEventTa = Lib:CreateTap("Sea Event");


local firstpage = SeaEventTa:CreatePage("Sea EE",1)

firstpage:AddDropdown("Selected Sea Level",{Values = {"1","2","3","4","5","6"} , callback = function(starts)
	SelectSeaLvl = tonumber(starts)
	
end})



firstpage:AddToggle("Auto Rough Sea",{Stats = false , callback = function(starts)
	AutoOutSea = starts
	if starts then
		mobilefly(speaker,true)
	end
	fask.spawn(function()
		local Unpart = {}
		while fask.wait() do 
			if AutoOutSea then 
				local itmyboat = myboat()
				if itmyboat and itmyboat.Parent then
					for _, v in pairs(itmyboat.Parent:GetDescendants()) do
						if v:IsA("BasePart") then
							if v.CanCollide ~= false then 
								v.CanCollide = false
								Unpart[#Unpart+1] = v
							end
						end
					end
					for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
						if v:IsA("BasePart") then
							if v.CanCollide ~= false then 
								v.CanCollide = false
								Unpart[#Unpart+1] = v
							end
						end
					end

					
					local Hum = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
					local TarCFrame = Vector3.new(-22859.4453125, 81.92976379394531, 33646.625)
					local Current = game.Workspace.CurrentCamera
					Current.CFrame  = CFrame.new(Current.CFrame.p, TarCFrame)
					if (Hum and Hum.Sit == true) then 
						print(FLYING)
						if not FLYING then 
							mobilefly(speaker,true)
							fask.wait(0.5)
						else
							local Current = game.Workspace.CurrentCamera
							Current.CFrame  = CFrame.new(Current.CFrame.p, TarCFrame)

							if SelectSeaLvl < tonumber(game.Players.LocalPlayer.PlayerGui.Main.Compass.Frame.DangerLevel.TextLabel.Text) then
								game:service('VirtualInputManager'):SendKeyEvent(true, "W", false, game)
								
							else

								game:service('VirtualInputManager'):SendKeyEvent(false, "W", false, game)
							end
						end
						

					elseif Hum then

						itmyboat:Sit(Hum)
						fask.wait(0.5)
					end
				end
			else
				for i,v in pairs(Unpart) do 
					if v ~= nil then 
						v.CanCollide = true
					end
					
				end
				unmobilefly(speaker)
				break
			end
		end
	end)
end})


local TeleportTap = Lib:CreateTap("Teleport");

local TeleportSeaPage = TeleportTap:CreatePage("Teleport Sea",1)

TeleportSeaPage:AddButton("Teleport To Sea 1",function()
	if ThreeWorld then queue_on_teleport([[if not game:IsLoaded() then game.Loaded:Wait() end game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")]]) _F("TravelDressrosa") return end
	_F("TravelMain")
end)

TeleportSeaPage:AddButton("Teleport To Sea 2",function()
	_F("TravelDressrosa")
end)

TeleportSeaPage:AddButton("Teleport To Sea 3",function()
	if OldWorld then queue_on_teleport([[if not game:IsLoaded() then game.Loaded:Wait() end game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")]]) _F("TravelDressrosa") return end
	_F("TravelZou")
end)

if OldWorld then
	Island = {
		["Start Island"] = CFrame.new(1071.2832, 16.3085976, 1426.86792),
		["Marine Start"] = CFrame.new(-2573.3374, 6.88881969, 2046.99817),
		["Middle Town"] = CFrame.new(-655.824158, 7.88708115, 1436.67908),
		["Jungle"] = CFrame.new(-1249.77222, 11.8870859, 341.356476),
		["Pirate Village"] = CFrame.new(-1122.34998, 4.78708982, 3855.91992),
		["Desert"] = CFrame.new(1094.14587, 6.47350502, 4192.88721),
		["Frozen Village"] = CFrame.new(1198.00928, 27.0074959, -1211.73376),
		["MarineFord"] = CFrame.new(-4505.375, 20.687294, 4260.55908),
		["Colosseum"] = CFrame.new(-1428.35474, 7.38933945, -3014.37305),
		["Sky 1st Floor"] = CFrame.new(-4970.21875, 717.707275, -2622.35449),
		["Sky 2st Floor"] = CFrame.new(-4813.0249, 903.708557, -1912.69055),
		["Sky 3st Floor"] = CFrame.new(-7952.31006, 5545.52832, -320.704956),
		["Prison"] = CFrame.new(4854.16455, 5.68742752, 740.194641),
		["Magma Village"] = CFrame.new(-5231.75879, 8.61593437, 8467.87695),
		["UnderWater City"] = CFrame.new(61163.8516, 11.7796879, 1819.78418),
		["Fountain City"] = CFrame.new(5132.7124, 4.53632832, 4037.8562),
		["House Cyborg's"] = CFrame.new(6262.72559, 71.3003616, 3998.23047),
		["Shank's Room"] = CFrame.new(-1442.16553, 29.8788261, -28.3547478),
		["Mob Island"] = CFrame.new(-2850.20068, 7.39224768, 5354.99268),
	}
	-- NPC
	NPC = {
		["Random Devil Fruit"] = CFrame.new(-1436.19727, 61.8777695, 4.75247526, -0.557794094, 2.74216543e-08, 0.829979479, 5.83273234e-08, 1, 6.16037932e-09, -0.829979479, 5.18467118e-08, -0.557794094),
		["Blox Fruits Dealer"] = CFrame.new(-923.255066, 7.67800522, 1608.61011, 1, 0, 0, 0, 1, 0, 0, 0, 1),
		["Remove Devil Fruit"] = CFrame.new(5664.80469, 64.677681, 867.85907, 1, 0, 0, 0, 1, 0, 0, 0, 1),
		["Ability Teacher"] = CFrame.new(-1057.67822, 9.65220833, 1799.49146, -0.865874112, -9.26330159e-08, 0.500262439, -7.33759435e-08, 1, 5.816689e-08, -0.500262439, 1.36579752e-08, -0.865874112),
		["Dark Step"] = CFrame.new(-987.873047, 13.7778397, 3989.4978, 1, 0, 0, 0, 1, 0, 0, 0, 1),
		["Electro"] = CFrame.new(-5389.49561, 13.283, -2149.80151, 1, 0, 0, 0, 1, 0, 0, 0, 1),
		["Fishman Karate"] = CFrame.new(61581.8047, 18.8965912, 987.832703, 1, 0, 0, 0, 1, 0, 0, 0, 1),
	}
elseif NewWorld then
	Island = {
		["First Spot"] = CFrame.new(82.9490662, 18.0710983, 2834.98779),
		["Kingdom of Rose"] = game.Workspace["_WorldOrigin"].Locations["Kingdom of Rose"].CFrame,
		["Dark Ares"] = game.Workspace["_WorldOrigin"].Locations["Dark Arena"].CFrame,
		["Flamingo Mansion"] = CFrame.new(-390.096313, 331.886475, 673.464966),
		["Flamingo Room"] = CFrame.new(2302.19019, 15.1778421, 663.811035),
		["Green bit"] = CFrame.new(-2372.14697, 72.9919434, -3166.51416),
		["Cafe"] = CFrame.new(-385.250916, 73.0458984, 297.388397),
		["Factroy"] = CFrame.new(430.42569, 210.019623, -432.504791),
		["Colosseum"] = CFrame.new(-1836.58191, 44.5890656, 1360.30652),
		["Ghost Island"] = CFrame.new(-5571.84424, 195.182297, -795.432922),
		["Ghost Island 2nd"] = CFrame.new(-5931.77979, 5.19706631, -1189.6908),
		["Snow Mountain"] = CFrame.new(1384.68298, 453.569031, -4990.09766),
		["Hot and Cold"] = CFrame.new(-6026.96484, 14.7461271, -5071.96338),
		["Magma Side"] = CFrame.new(-5478.39209, 15.9775667, -5246.9126),
		["Cursed Ship"] = CFrame.new(-6511, 83, -138),
		["Cursed Ship In"] = CFrame.new(919.3607177734375, 125.0829086303711, 32880.66015625),
		["Frosted Island"] = CFrame.new(5400.40381, 28.21698, -6236.99219),
		["Forgotten Island"] = CFrame.new(-3043.31543, 238.881271, -10191.5791),
		["Usoapp Island"] = CFrame.new(4748.78857, 8.35370827, 2849.57959),
		["Raids Low"] = CFrame.new(-5554.95313, 329.075623, -5930.31396),
		-- ["Minisky"] = CFrame.new(-260.358917, 49325.7031, -35259.3008),
	}
	-- NPC
	NPC = {
		["Dargon Berath"] = CFrame.new(703.372986, 186.985519, 654.522034, 1, 0, 0, 0, 1, 0, 0, 0, 1),
		["Mysterious Man"] = CFrame.new(-2574.43335, 1627.92371, -3739.35767, 0.378697902, -9.06400288e-09, 0.92552036, -8.95582009e-09, 1, 1.34578926e-08, -0.92552036, -1.33852689e-08, 0.378697902),
		["Mysterious Scientist"] = CFrame.new(-6437.87793, 250.645355, -4498.92773, 0.502376854, -1.01223634e-08, -0.864648759, 2.34106086e-08, 1, 1.89508653e-09, 0.864648759, -2.11940012e-08, 0.502376854),
		["Sick Scientist"] = CFrame.new(-2812, 255, -12592),
		["Awakening Expert"] = CFrame.new(-408.098846, 16.0459061, 247.432846, 0.028394036, 6.17599138e-10, 0.999596894, -5.57905944e-09, 1, -4.59372484e-10, -0.999596894, -5.56376767e-09, 0.028394036),
		["Nerd"] = CFrame.new(-401.783722, 73.0859299, 262.306702, 1, 0, 0, 0, 1, 0, 0, 0, 1),
		["Bar Manager"] = CFrame.new(-385.84726, 73.0458984, 316.088806, 1, 0, 0, 0, 1, 0, 0, 0, 1),
		["Blox Fruits Dealer"] = CFrame.new(-450.725464, 73.0458984, 355.636902, -0.780352175, -2.7266168e-08, 0.625340283, 9.78516468e-09, 1, 5.58128797e-08, -0.625340283, 4.96727601e-08, -0.780352175),
		["Trevor"] = CFrame.new(-341.498322, 331.886444, 643.024963, 1, 0, 0, 0, 1, 0, 0, 0, 1),
		["Plokster"] = CFrame.new(-1885.16016, 88.3838196, -1912.28723, -0.513468027, 0, 0.858108759, 0, 1, 0, -0.858108759, 0, -0.513468027),
		["Enhancement Editor"] = CFrame.new(-346.820221, 72.9856339, 1194.36218, 1, 0, 0, 0, 1, 0, 0, 0, 1),
		["Pirate Recruiter"] = CFrame.new(-428.072998, 72.9495239, 1445.32422, 1, 0, 0, 0, 1, 0, 0, 0, 1),
		["Marines Recruiter"] = CFrame.new(-1349.77295, 72.9853363, -1045.12964, 0.866493046, 0, -0.499189168, 0, 1, 0, 0.499189168, 0, 0.866493046),
		["Chemist"] = CFrame.new(-2777.45288, 72.9919434, -3572.25732, 1, 0, 0, 0, 1, 0, 0, 0, 1),
		["Cyborg"] = CFrame.new(629.146851, 312.307373, -531.624146, 1, 0, 0, 0, 1, 0, 0, 0, 1),
		["Ghoul Mark"] = CFrame.new(635.172546, 125.976357, 33219.832, 1, 0, 0, 0, 1, 0, 0, 0, 1),
		["Guashiem"] = CFrame.new(937.953003, 181.083359, 33277.9297, 1, -8.60126406e-08, 3.81773896e-17, 8.60126406e-08, 1, -1.89969598e-16, -3.8177373e-17, 1.89969598e-16, 1),
		-- ["El Admin"] = CFrame.new(1322.80835, 126.345039, 33135.8789, 0.988783717, -8.69797603e-08, -0.149354503, 8.62223786e-08, 1, -1.15461916e-08, 0.149354503, -1.46101409e-09, 0.988783717),
		-- ["El Rodolfo"] = CFrame.new(941.228699, 40.4686775, 32778.9922, -0.818029106, -1.19524382e-08, 0.575176775, -1.28741648e-08, 1, 2.47053866e-09, -0.575176775, -5.38394795e-09, -0.818029106),
		["Arowe"] = CFrame.new(-1994.51038, 125.519142, -72.2622986, -0.16715166, -6.55417338e-08, -0.985931218, -7.13315558e-08, 1, -5.43836585e-08, 0.985931218, 6.12376851e-08, -0.16715166),
	}
elseif ThreeWorld then
	Island = {
		["Prot Town"] = CFrame.new(-287, 30, 5388),
		["Hydra Island"] = CFrame.new(3399.32227, 72.4142914, 1572.99963, -0.809679806, -4.48284467e-08, 0.586871922, 2.42332163e-08, 1, 1.09818842e-07, -0.586871922, 1.0313989e-07, -0.809679806),
		["Room Enma/Yama & Secret Temple"] = CFrame.new(5247, 7, 1097),
		["House Hydra Island"] = CFrame.new(5245, 602, 251),
		["Great Tree"] = CFrame.new(2443, 36, -6573),
		["Castle on the sea"] = CFrame.new(-5500, 314, -2855),
		["Mansion"] = CFrame.new(-12548, 337, -7481),
		["Floating Turtlea"] = CFrame.new(-10016, 332, -8326),
		["Haunted Castle"] = CFrame.new(-9509.34961, 142.130661, 5535.16309),
		["Peanut Island"] = CFrame.new(-2131, 38, -10106),
		["Ice Cream Island"] = CFrame.new(-950, 59, -10907),
		["CakeLoaf"] = CFrame.new(-1762, 38, -11878),
		["Chocolate Island"] = game:GetService("Workspace").Map.ChocolateIsland:GetModelCFrame(),
		["Candy Island"] = game:GetService("Workspace").Map["CandyCane"]:GetModelCFrame(),
		["Npc Temple of time"] = CFrame.new(2958.3017578125, 2282.337158203125, -7217.43408203125),
		["Tiki Outpost"] = game:GetService("Workspace")._WorldOrigin.Locations["Tiki Outpost"].CFrame
	}
	-- NPC
	NPC = {
		["Random Devil Fruit"] = CFrame.new(-12491, 337, -7449),
		["Blox Fruits Dealer"] = CFrame.new(-12511, 337, -7448),
		["Remove Devil Fruit"] = CFrame.new(-5571, 1089, -2661),
		["Horned Man"] = CFrame.new(-11890, 931, -8760),
		["Hungey Man"] = CFrame.new(-10919, 624, -10268),
		["Previous Hero"] = CFrame.new(-10368, 332, -10128),
		["Butler"] = CFrame.new(-5125, 316, -3130),
		["Lunoven"] = CFrame.new(-5117, 316, -3093),
		["Elite Hunter"] = CFrame.new(-5420, 314, -2828),
		["Player Hunter"] = CFrame.new(-5559, 314, -2840),
		["Uzoth"] = CFrame.new(-9785, 852, 6667),
		["Beast Hunter"] = CFrame.new(-16282, 71, 259),
		["Shark Hunter"] = CFrame.new(-16525, 107, 753),
		["Spy"] = CFrame.new(-16469, 527, 537),
	}
end

TeleportSeaPage:AddButton("Stop All Tween",function()
	NoClip = false
	if tween then tween:Cancel() end
end)

local TeleportIslandPage = TeleportTap:CreatePage("Island",1)

for i,v in pairs(Island) do
	TeleportIslandPage:AddButton(i,function()
		IslandNPC = toTarget(v.Position,v)
		NoClip = true
		IslandNPC:Wait()
		NoClip = false
	end)
end

local TeleportNPCPage = TeleportTap:CreatePage("NPC",2)

Queue = require(game:GetService("ReplicatedStorage").Queue)
NPCList = getupvalue(Queue.new,1)[1].NPCDialogueEnabler.bin

local allNPC = {}
for i,v in pairs(NPCList) do 
    local Model = v.Model
    if Model:FindFirstChild("QuestFloor",true)  and not Model.Name:lower():find("quest") and not Model.Name:lower():find("dealer") and not table.find({"Set Home Point","Bounty/Honor Expert"},Model.Name) then
        if Model:FindFirstChild("HumanoidRootPart") then 
            allNPC[Model.Name] = Model.HumanoidRootPart.CFrame
        end
        
    end
end

table.sort(allNPC)
NPC = allNPC
for i,v in pairs(NPC) do
	TeleportNPCPage:AddButton(i,function()
		IslandNPC = toTarget(v.Position,v)
		NoClip = true
		IslandNPC:Wait()
		NoClip = false
	end)
end
function StopTweenIslandNPC()
	if IslandNPC then
		NoClip = false
		IslandNPC:Stop()
	end
end

local PlayersAndESPTap = Lib:CreateTap("Players & ESP");

local PlayersPageLeft = PlayersAndESPTap:CreatePage("Players",1)

local PlayersSelectedLabel = PlayersPageLeft:AddLabel("Select Players : Nil")

PlayerName = {}
for i,v in pairs(game.Players:GetChildren()) do
	table.insert(PlayerName ,v.Name)
end
SelectedKillPlayer = "nil"

local DropdownPlayers = PlayersPageLeft:AddDropdown("Selected Players",{Values = {""} , callback = function(starts)
	SelectedKillPlayer = starts
	PlayersSelectedLabel:Options().Text = "Select Players : " .. SelectedKillPlayer
end})

DropdownPlayers:Clear()
PlayerName = {}
for i,v in pairs(game.Players:GetChildren()) do
	table.insert(PlayerName ,v.Name)
end
for i, v in pairs(PlayerName) do
	DropdownPlayers:Add(v)
end

PlayersPageLeft:AddButton("Refresh Players",function()
	DropdownPlayers:Clear()
	PlayerName = {}
	for i,v in pairs(game.Players:GetChildren()) do
		table.insert(PlayerName ,v.Name)
	end
	for i, v in pairs(PlayerName) do
		DropdownPlayers:Add(v)
	end
end)



PlayersPageLeft:AddToggle("Click No Cooldown",{Stats = false , callback = function(starts)
	ClickNoCooldown = starts
end})

local Mouse = game:GetService("Players") .LocalPlayer:GetMouse()
Mouse.Button1Down:Connect(function()
	if ClickNoCooldown then
		local ac = CombatFrameworkR.activeController

		if ac and ac.equipped then
			ac.hitboxMagnitude = 55
			pcall(AttackFunction,3)
		end
	end
end)

PlayersPageLeft:AddToggle("Damge Aura",{Stats = false , callback = function(starts)
	UsefastattackAura = starts
end})

PlayersPageLeft:AddToggle("Auto Farm Players Select ( Kill Players )",{Stats = false , callback = function(starts)
	if SelectedKillPlayer ~= "nil" and SelectedKillPlayer ~= game.Players.LocalPlayer.Name then
		AutoFarmPlayers = starts
		spawn(function()
			while fask.wait() do
				local persen = game.Players.LocalPlayer.Character:WaitForChild("Humanoid").MaxHealth*SaveHealth/100
				if AutoFarmPlayers then
					if game:GetService("Players"):FindFirstChild(SelectedKillPlayer) then
						repeat fask.wait()
							if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
								local args = {
									[1] = "Buso"
								}
								game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
							end
							if game:GetService("Players")["LocalPlayer"].PlayerGui.Main.PvpDisabled.Visible == true then
								local args = {
									[1] = "EnablePvp"
								}

								game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
							end
							game:GetService'VirtualUser':CaptureController()
							game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
							TweenPlayers = toTarget(game.Players:FindFirstChild(SelectedKillPlayer).Character.HumanoidRootPart.CFrame * CFrame.new(0,0,3))
							EquipWeapon(SelectToolWeapon)
							game.Players:FindFirstChild(SelectedKillPlayer).Character.HumanoidRootPart.Size = Vector3.new(50,50,50)
						until AutoFarmPlayers == false or not game:GetService("Players"):FindFirstChild(SelectedKillPlayer) or game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health <= persen
					end
				else
					if TweenPlayers then TweenPlayers:Stop() end
					break;
				end
			end
		end)
	end
end})

SaveHealth = 35
PlayersPageLeft:AddToggle("Safe Mode",{Stats = false , callback = function(starts)
	SafeMode = starts
	spawn(function()
		while fask.wait() do
			local HealthMin = game.Players.LocalPlayer.Character:WaitForChild("Humanoid").MaxHealth*SaveHealth/100
			if SafeMode and game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health <= HealthMin then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.X,10000,game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Z)
			end
		end
	end)
end})

PlayersPageLeft:AddSlider("Save Health ( 35% )",{value = SaveHealth ,min = 1 , max = 100 , callback = function(starts)
	SaveHealth = starts
end})

SelectLockBounty = (_G.ConfigMain["Select Lock Bounty"] or 100000000)

LockBountyAt = PlayersPageLeft:AddLabel("Lock Bounty At ".. Abbreviate(SelectLockBounty))

PlayersPageLeft:AddSlider("Select Lock Bounty",{value = 10000000 ,min = 1000000 , max = 25000000 , callback = function(starts)
	SelectLockBounty = starts
	_G.ConfigMain["Select Lock Bounty"] = starts
	LockBountyAt:Options().Text = "Lock Bounty At ".. Abbreviate(starts)
	SaveConfigAuto()
end})

-- game:GetService("Players")["LocalPlayer"].leaderstats:FindFirstChild("Bounty/Honor").Value

ConfigStartLockBounty = PlayersPageLeft:AddToggle("Start Lock Bounty",{Stats = false , callback = function(starts)
	StartLockBounty = starts
	_G.ConfigMain["Start Lock Bounty"] = starts
	SaveConfigAuto()
	spawn(function()
		while fask.wait() do
			if StartLockBounty then
				if game:GetService("Players")["LocalPlayer"].leaderstats:WaitForChild("Bounty/Honor") then
					if game:GetService("Players")["LocalPlayer"].leaderstats:FindFirstChild("Bounty/Honor").Value >= SelectLockBounty then
						messagebox("Farm Bounty Complete","Now You Farm Bounty Complete",0)
						_G.ConfigMain["Start Lock Bounty"] = false
						writefile("RoyXHub_BF/" .. SelectConfig,HttpService:JSONEncode(_G.ConfigMain))
						fask.wait(.1)
						while true do end
					end
				end
			end
		end
	end)
end})

-----------------------------------------------------------------------------------------------------------------

PlayersPageLeft:AddToggle("Spectate Players",{Stats = false , callback = function(starts)
	if SelectedKillPlayer ~= "nil" then
		SpectatePlayers = starts
		local plr2 = game.Players:FindFirstChild(SelectedKillPlayer)
		repeat fask.wait(.1)
			game.Workspace.Camera.CameraSubject = plr2.Character.Humanoid
		until SpectatePlayers == false
		game.Workspace.Camera.CameraSubject = game.Players.LocalPlayer.Character:WaitForChild("Humanoid")
	end
end})

PlayersPageLeft:AddToggle("Teleport Players",{Stats = false , callback = function(starts)
	if SelectedKillPlayer ~= "nil" then
		TeleportPlayers = starts
		spawn(function()
			while fask.wait() do
				if TeleportPlayers then
					local plr2 = game.Players:FindFirstChild(SelectedKillPlayer)
					TweenPlayers = toTarget(plr2.Character.HumanoidRootPart.Position,plr2.Character.HumanoidRootPart.CFrame)
					if game.Players:FindFirstChild(SelectedKillPlayer) and (game.Players:FindFirstChild(SelectedKillPlayer).Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
						if TweenPlayers then TweenPlayers:Stop() end
						game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = plr2.Character.HumanoidRootPart.CFrame * CFrame.new(1,20,0)
					end
				else
					if TweenPlayers then TweenPlayers:Stop() end
					break;
				end
			end
		end)
	end
end})
PlayersPageLeft:AddLabel("~ Aimbot bot")

PlayersPageLeft:AddButton("Aimbot Ui",function()
	if DestroyMultiUi then _G.UiOptions:Destroy() end
	aimbot_start()
end)

PlayersPageLeft:AddLabel("~ PVP Zone")

local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 2
FOVCircle.NumSides = 460
FOVCircle.Filled = false
FOVCircle.Transparency = 0.5
FOVCircle.Radius = 200
FOVCircle.Color = Color3.fromRGB(255, 0, 0)
FOVCircle.Visible = false

FOVSize = 200

PlayersPageLeft:AddToggle("Open AimBot Circle",{Stats = false , callback = function(starts)
	AimBotCircle = starts
	spawn(function()
		local LoopConnectionAimBotCircle
		LoopConnectionAimBotCircle = game:GetService("RunService").Stepped:Connect(function()
			if AimBotCircle then
				pcall(function()
					local MaxDist = math.huge
					local MaxDist2 = 3000
					local FindPy = false
					for i,v in pairs(game:GetService("Players"):GetChildren()) do
						if  v.Name ~= game.Players.LocalPlayer.Name and (v.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 3000 then
							if ingoreAllies and tablefound(game:GetService("CollectionService"):GetTagged("Ally"..game.Players.LocalPlayer.Name),v.Name) then return end
							local Head = v.Character:FindFirstChild("HumanoidRootPart")
							local Pos, Vis = game.Workspace.CurrentCamera.WorldToScreenPoint(game.Workspace.CurrentCamera, Head.Position)
							local MousePos, TheirPos = Vector2.new(Mouse.X, Mouse.Y), Vector2.new(Pos.X, Pos.Y)
							local Dist = (TheirPos - MousePos).Magnitude
							local Dist2 = (v.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude
							if Dist < MaxDist and Dist2 < MaxDist2 and Dist <= FOVSize and Vis == true then
								MaxDist = Dist
								MaxDist2 = Dist2
								FindPy = true
								PlayerFind = v.Character
							end
						end
					end
					if FindPy == true then
						AimBotCirclePos = PlayerFind
					else
						AimBotCirclePos = nil
					end
				end)
			else
				LoopConnectionAimBotCircle:Disconnect()
			end
		end)
	end)
	spawn(function()
		local LoopConnection
		LoopConnection = game:GetService("RunService").Stepped:Connect(function()
			if AimBotCircle then
				FOVCircle.Radius = FOVSize
				FOVCircle.Thickness = 1
				FOVCircle.NumSides = 11
				FOVCircle.Position = game:GetService('UserInputService'):GetMouseLocation()
			else
				LoopConnection:Disconnect()
			end
		end)
	end)
end})

PlayersPageLeft:AddToggle("Show Fov",{Stats = false , callback = function(starts)
	ShowFov = starts
	if ShowFov then
		FOVCircle.Visible = true
	else
		FOVCircle.Visible = false
	end
end})

PlayersPageLeft:AddSlider("Fov Size",{value = 200 ,min = 1 , max = 500 , callback = function(starts)
	FOVSize = starts
end})

PlayersPageLeft:AddLabel("~~~~~~")

PlayersPageLeft:AddDropdown("Aimlock Type",{Values = {"ClosestPlayer","Select Player"} , callback = function(starts)
	SelectAimLockType = starts
end})
ClosestPlayerRange = 600
PlayersPageLeft:AddSlider("ClosestPlayer Range",{value = 600 ,min = 1 , max = 2000 , callback = function(starts)
	ClosestPlayerRange = starts
end})

function getClosestPlayer()
	local MaxRange = ClosestPlayerRange
	local NamePlayer
	for i,v in pairs(game.Workspace.Characters:GetChildren()) do
		if v ~= game.Players.LocalPlayer.Character and v.Humanoid.Health > 0 then
			local PlayerMagnitude = (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
			if PlayerMagnitude < MaxRange then
				MaxRange = PlayerMagnitude
				NamePlayer = v.Name
			end
		end
	end
	return NamePlayer
end

PlayersPageLeft:AddDropdown("Type Lock Open",{Values = {"Right Button Down","Auto Lock"} , callback = function(starts)
	TypeLockOpen = starts
end})

PlayersPageLeft:AddToggle("Open Aimlock",{Stats = false , callback = function(starts)
	Aimlock = starts
	spawn(function()
		while fask.wait() do
			if Aimlock then
				xpcall(function()
					if TypeLockOpen == "Right Button Down" then
						if not UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
							return
						end
					end
					if SelectAimLockType == "ClosestPlayer" then
						for i,v in pairs(game.Workspace.Characters:GetChildren()) do
							if v.Name == getClosestPlayer() then
								local Current = game.Workspace.CurrentCamera
								Current.CoordinateFrame = CFrame.new(Current.CoordinateFrame.p, v.HumanoidRootPart.Position)
								AimlockPos = v.Head.Position
							end
						end
					elseif SelectAimLockType == "Select Player" then
						for i,v in pairs(game.Workspace.Characters:GetChildren()) do
							if v.Name == SelectedKillPlayer then
								local Current = game.Workspace.CurrentCamera
								Current.CoordinateFrame = CFrame.new(Current.CoordinateFrame.p, v.HumanoidRootPart.Position)
								AimlockPos = v.Head.Position
							end
						end
					end
				end,function(...)
					print("AIMLOC ERROR : "..(...))
				end)
			else
				break
			end
		end
	end)
end})

PlayersPageLeft:AddLabel("~~~~~~")

PlayersPageLeft:AddToggle("Soru Lock Player",{Stats = false , callback = function(starts)
	SoruLockPlayer = starts
end})

PlayersPageLeft:AddToggle("ingore Allies Player",{Stats = false , callback = function(starts)
	ingoreAllies = starts
end})

-- if not isfolder("RoyXHubMacroBF") then makefolder("RoyXHubMacroBF") end

-- local AllMacroFile = {}
-- for i,v in pairs(listfiles("RoyXHubMacroBF")) do 
--     TableInsertNoDuplicates(AllMacroFile,tostring(v:gsub("RoyXHubMacroBF\\", "")))
-- end

-- local MacroSelectFile = PlayersPageLeft:AddDropdown("Select Macro",{Values = {""} , callback = function(starts)
--     MacroFile = starts
-- end})

-- MacroSelectFile:Refresh(AllMacroFile)

-- PlayersPageLeft:AddButton("Refresh Macro",function()
--     AllMacroFile = {}
--     for i,v in pairs(listfiles("RoyXHubMacroBF")) do 
--         TableInsertNoDuplicates(AllMacroFile,tostring(v:gsub("RoyXHubMacroBF\\", "")))
--     end
--     MacroSelectFile:Refresh(AllMacroFile)
-- end)
-- local SelectMyInventory = "Unknown"
-- local MyInventory = PlayersPageLeft:AddDropdown("My Inventory",{Values = {""} , callback = function(starts)
--     SelectMyInventory = starts
-- end})

-- MyInventory:Clear()
-- WeaponMyInventory = {}
-- for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do  
--     if v:IsA("Tool") then
--         table.insert(WeaponMyInventory,v.Name)
--     end
-- end
-- for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do  
--     if v:IsA("Tool") then
--         table.insert(WeaponMyInventory,v.Name)
--     end
-- end
-- MyInventory:Refresh(WeaponMyInventory)

-- PlayersPageLeft:AddButton("Refresh My Inventory",function()
--     MyInventory:Clear()
--     WeaponMyInventory = {}
--     for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do  
--         if v:IsA("Tool") then
--             table.insert(WeaponMyInventory,v.Name)
--         end
--     end
--     for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do  
--         if v:IsA("Tool") then
--             table.insert(WeaponMyInventory,v.Name)
--         end
--     end
--     MyInventory:Refresh(WeaponMyInventory)
-- end)

-- PlayersPageLeft:AddButton("Get Name Item",function()
--     setclipboard(SelectMyInventory)
-- end)

-- local MacroKeyBind = "G"
-- local SetKeyBind = PlayersPageLeft:AddLabel("Macro Key Bind ["..MacroKeyBind.."]")

-- PlayersPageLeft:AddButton("Set New Key Bind",function()
--     SetKeyBind:Options().Text = "Macro Key Bind [...]"
--     local inputwait = game:GetService("UserInputService").InputBegan:wait()
-- 	if inputwait.KeyCode.Name ~= "Unknown" then
-- 		SetKeyBind:Options().Text = "Macro Key Bind ["..inputwait.KeyCode.Name.."]"
-- 		MacroKeyBind = inputwait.KeyCode.Name
-- 	end
-- end)

-- PlayersPageLeft:AddToggle("Open Macro",{Stats = false , callback = function(starts)
--     OpenMacro = starts
--     print(MacroFile)
-- end})

-- UserInputService.InputBegan:Connect(function(io, p)
--     if io.KeyCode.Name == MacroKeyBind and MacroFile ~= ""  then
--         local GetRawEditMacro = readfile("RoyXHubMacroBF/"..MacroFile):gsub(" ",""):gsub("\n"," ")

--         GetRawEditMacro2 = GetRawEditMacro:split(" ")
--         print("EE")
--         for i = 1,#GetRawEditMacro2 do 
--             arge = GetRawEditMacro2[i]:split(":")
--             if #arge == 2 then
--                 if arge[1] == "wait" then
--                     fask.wait(tonumber(arge[2]) or 0)
--                 end
--             elseif #arge == 3 then
--                 if not game.Players.LocalPlayer.Character:FindFirstChild(tostring(arge[1])) then EquipWeapon(arge[1]) end
--                 repeat fask.wait() until game.Players.LocalPlayer.Character:FindFirstChild(tostring(arge[1]))
--                 fask.wait()
--                 game:service('VirtualInputManager'):SendKeyEvent(true,  string.upper(tostring(arge[2])), false, game)
--                 fask.wait(tonumber(arge[3]) or 0)
--                 game:service('VirtualInputManager'):SendKeyEvent(false, string.upper(tostring(arge[2])), false, game)
--             else
--                 Notify({
--                     Title = "Warn",
--                     Text = "Macro Error On Line "..i,
--                     Timer = 3
--                 },"Warn")
--             end
--         end
--     end
-- end)

local ESPPageRight = PlayersAndESPTap:CreatePage("ESP",2)

function isnil(thing) return (thing == nil) end
local function round(n) return math.floor(tonumber(n) + 0.5) end
Number = math.random(1, 1000000)
UpdateChestChams = LPH_JIT_MAX(function()
	for i,v in pairs(game.Workspace:GetChildren()) do
		pcall(function()
			if string.find(v.Name,"Chest") then
				if ChestESP then
					if string.find(v.Name,"Chest") then
						if not v:FindFirstChild('NameEsp'..Number) then
							local bill = Instance.new('BillboardGui',v)
							bill.Name = 'NameEsp'..Number
							bill.ExtentsOffset = Vector3.new(0, 1, 0)
							bill.Size = UDim2.new(1,200,1,30)
							bill.Adornee = v
							bill.AlwaysOnTop = true
							local name = Instance.new('TextLabel',bill)
							name.Font = "GothamBold"
							name.FontSize = "Size14"
							name.TextWrapped = true
							name.Size = UDim2.new(1,0,1,0)
							name.TextYAlignment = 'Top'
							name.BackgroundTransparency = 1
							name.TextStrokeTransparency = 0.5
							if v.Name == "Chest1" then
								name.TextColor3 = Color3.fromRGB(109, 109, 109)
								name.Text = ("Chest 1" ..' \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Position).Magnitude/3) ..' M')
							end
							if v.Name == "Chest2" then
								name.TextColor3 = Color3.fromRGB(173, 158, 21)
								name.Text = ("Chest 2" ..' \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Position).Magnitude/3) ..' M')
							end
							if v.Name == "Chest3" then
								name.TextColor3 = Color3.fromRGB(85, 255, 255)
								name.Text = ("Chest 3" ..' \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Position).Magnitude/3) ..' M')
							end
						else
							v['NameEsp'..Number].TextLabel.Text = (v.Name ..'   \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Position).Magnitude/3) ..' M')
						end
					end
				else
					if v:FindFirstChild('NameEsp'..Number) then
						v:FindFirstChild('NameEsp'..Number):Destroy()
					end
				end
			end
		end)
	end
end)
UpdateDevilChams = LPH_JIT_MAX(function()
	if DevilFruitESP then
		for i,v in pairs(game.Workspace:GetChildren()) do

			if string.find(v.Name, "Fruit") then
				if not v.Handle:FindFirstChild('NameEsp'..Number) then
					local bill = Instance.new('BillboardGui',v.Handle)
					bill.Name = 'NameEsp'..Number
					bill.ExtentsOffset = Vector3.new(0, 1, 0)
					bill.Size = UDim2.new(1,200,1,30)
					bill.Adornee = v.Handle
					bill.AlwaysOnTop = true
					local name = Instance.new('TextLabel',bill)
					name.Font = "GothamBold"
					name.FontSize = "Size14"
					name.TextWrapped = true
					name.Size = UDim2.new(1,0,1,0)
					name.TextYAlignment = 'Top'
					name.BackgroundTransparency = 1
					name.TextStrokeTransparency = 0.5
					name.TextColor3 = Color3.fromRGB(255, 0, 0)
					name.Text = (v.Name ..' \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude/3) ..' M')
				else
					v.Handle['NameEsp'..Number].TextLabel.Text = (v.Name ..'   \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude/3) ..' M')
				end
			end
		end
	else
		if v.Handle:FindFirstChild('NameEsp'..Number) then
			v.Handle:FindFirstChild('NameEsp'..Number):Destroy()
		end
	end
end)
UpdateFlowerChams = LPH_JIT_MAX(function()
	if FlowerESP then
		for i,v in pairs(game.Workspace:GetChildren()) do
			if v.Name == "Flower2" or v.Name == "Flower1" then
				if not v:FindFirstChild('NameEsp'..Number) then
					local bill = Instance.new('BillboardGui',v)
					bill.Name = 'NameEsp'..Number
					bill.ExtentsOffset = Vector3.new(0, 1, 0)
					bill.Size = UDim2.new(1,200,1,30)
					bill.Adornee = v
					bill.AlwaysOnTop = true
					local name = Instance.new('TextLabel',bill)
					name.Font = "GothamBold"
					name.FontSize = "Size14"
					name.TextWrapped = true
					name.Size = UDim2.new(1,0,1,0)
					name.TextYAlignment = 'Top'
					name.BackgroundTransparency = 1
					name.TextStrokeTransparency = 0.5
					name.TextColor3 = Color3.fromRGB(255, 0, 0)
					if v.Name == "Flower1" then
						name.Text = ("Blue Flower" ..' \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Position).Magnitude/3) ..' M')
						name.TextColor3 = Color3.fromRGB(0, 0, 255)
					end
					if v.Name == "Flower2" then
						name.Text = ("Red Flower" ..' \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Position).Magnitude/3) ..' M')
						name.TextColor3 = Color3.fromRGB(255, 0, 0)
					end
				else
					v['NameEsp'..Number].TextLabel.Text = (v.Name ..'   \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Position).Magnitude/3) ..' M')
				end
			end
		end
	else
		if v:FindFirstChild('NameEsp'..Number) then
			v:FindFirstChild('NameEsp'..Number):Destroy()
		end
	end
end)
UpdateRealFruitChams = (function()
	if ThreeWorld then
		if RealFruitESP then
			for i,v in pairs(game.Workspace.AppleSpawner:GetChildren()) do
				if v:IsA("Tool") then
					if not v.Handle:FindFirstChild('NameEsp'..Number) then
						local bill = Instance.new('BillboardGui',v.Handle)
						bill.Name = 'NameEsp'..Number
						bill.ExtentsOffset = Vector3.new(0, 1, 0)
						bill.Size = UDim2.new(1,200,1,30)
						bill.Adornee = v.Handle
						bill.AlwaysOnTop = true
						local name = Instance.new('TextLabel',bill)
						name.Font = "GothamBold"
						name.FontSize = "Size14"
						name.TextWrapped = true
						name.Size = UDim2.new(1,0,1,0)
						name.TextYAlignment = 'Top'
						name.BackgroundTransparency = 1
						name.TextStrokeTransparency = 0.5
						name.TextColor3 = Color3.fromRGB(255, 0, 0)
						name.Text = (v.Name ..' \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude/3) ..' M')
					else
						v.Handle['NameEsp'..Number].TextLabel.Text = (v.Name ..' '.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude/3) ..' M')
					end
				end
			end
			for i,v in pairs(game.Workspace.PineappleSpawner:GetChildren()) do
				if v:IsA("Tool") then
					if not v.Handle:FindFirstChild('NameEsp'..Number) then
						local bill = Instance.new('BillboardGui',v.Handle)
						bill.Name = 'NameEsp'..Number
						bill.ExtentsOffset = Vector3.new(0, 1, 0)
						bill.Size = UDim2.new(1,200,1,30)
						bill.Adornee = v.Handle
						bill.AlwaysOnTop = true
						local name = Instance.new('TextLabel',bill)
						name.Font = "GothamBold"
						name.FontSize = "Size14"
						name.TextWrapped = true
						name.Size = UDim2.new(1,0,1,0)
						name.TextYAlignment = 'Top'
						name.BackgroundTransparency = 1
						name.TextStrokeTransparency = 0.5
						name.TextColor3 = Color3.fromRGB(255, 174, 0)
						name.Text = (v.Name ..' \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude/3) ..' M')
					else
						v.Handle['NameEsp'..Number].TextLabel.Text = (v.Name ..' '.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude/3) ..' M')
					end
				end
			end
			for i,v in pairs(game.Workspace.BananaSpawner:GetChildren()) do
				if v:IsA("Tool") then
					if not v.Handle:FindFirstChild('NameEsp'..Number) then
						local bill = Instance.new('BillboardGui',v.Handle)
						bill.Name = 'NameEsp'..Number
						bill.ExtentsOffset = Vector3.new(0, 1, 0)
						bill.Size = UDim2.new(1,200,1,30)
						bill.Adornee = v.Handle
						bill.AlwaysOnTop = true
						local name = Instance.new('TextLabel',bill)
						name.Font = "GothamBold"
						name.FontSize = "Size14"
						name.TextWrapped = true
						name.Size = UDim2.new(1,0,1,0)
						name.TextYAlignment = 'Top'
						name.BackgroundTransparency = 1
						name.TextStrokeTransparency = 0.5
						name.TextColor3 = Color3.fromRGB(251, 255, 0)
						name.Text = (v.Name ..' \n'.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude/3) ..' M')
					else
						v.Handle['NameEsp'..Number].TextLabel.Text = (v.Name ..' '.. round((game:GetService('Players').LocalPlayer.Character.Head.Position - v.Handle.Position).Magnitude/3) ..' M')
					end
				end
			end
		else
			if v.Handle:FindFirstChild('NameEsp'..Number) then
				v.Handle:FindFirstChild('NameEsp'..Number):Destroy()
			end
		end
	end
end)

if not UserInputService.TouchEnabled then

	local ESP = {
		Enabled = false,
		Boxes = nil,
		BoxShift = CFrame.new(0,-1.5,0),
		BoxSize = Vector3.new(4,6,0),
		Color = Color3.fromRGB(66, 164, 245),
		FaceCamera = nil,
		Names = false,
		TeamColor = nil,
		Thickness = 2,
		Tracers = false,
		AttachShift = 1,
		Players = false,

		Objects = setmetatable({}, {__mode="kv"}),
		Overrides = {}
	}

	--Declarations--
	local cam = workspace.CurrentCamera
	local plrs = game:GetService("Players")
	local plr = plrs.LocalPlayer
	local mouse = plr:GetMouse()

	local V3new = Vector3.new
	local WorldToViewportPoint = cam.WorldToViewportPoint

	--Functions--
	local function Draw(obj, props)
		local new = Drawing.new(obj)

		props = props or {}
		for i,v in pairs(props) do
			new[i] = v
		end
		return new
	end

	function ESP:GetColor(obj)
		local ov = self.Overrides.GetColor
		if ov then
			return ov(obj)
		end
		local p = self:GetPlrFromChar(obj)
		return p and self.TeamColor and p.Team and p.Team.TeamColor.Color or self.Color
	end

	function ESP:GetPlrFromChar(char)
		local ov = self.Overrides.GetPlrFromChar
		if ov then
			return ov(char)
		end

		return plrs:GetPlayerFromCharacter(char)
	end

	function ESP:Toggle(bool)
		self.Enabled = bool
		if not bool then
			for i,v in pairs(self.Objects) do
				if v.Type == "Box" then --fov circle etc
					if v.Temporary then
						v:Remove()
					else
						for i,v in pairs(v.Components) do
							v.Visible = false
						end
					end
				end
			end
		end
	end

	function ESP:GetBox(obj)
		return self.Objects[obj]
	end

	function ESP:AddObjectListener(parent, options)
		local function NewListener(c)
			if type(options.Type) == "string" and c:IsA(options.Type) or options.Type == nil then
				if type(options.Name) == "string" and c.Name == options.Name or options.Name == nil then
					if not options.Validator or options.Validator(c) then
						local box = ESP:Add(c, {
							PrimaryPart = type(options.PrimaryPart) == "string" and c:WaitForChild(options.PrimaryPart) or type(options.PrimaryPart) == "function" and options.PrimaryPart(c),
							Color = type(options.Color) == "function" and options.Color(c) or options.Color,
							ColorDynamic = options.ColorDynamic,
							Name = type(options.CustomName) == "function" and options.CustomName(c) or options.CustomName,
							IsEnabled = options.IsEnabled,
							RenderInNil = options.RenderInNil
						})
						--TODO: add a better way of passing options
						if options.OnAdded then
							coroutine.wrap(options.OnAdded)(box)
						end
					end
				end
			end
		end

		if options.Recursive then
			parent.DescendantAdded:Connect(NewListener)
			for i,v in pairs(parent:GetDescendants()) do
				coroutine.wrap(NewListener)(v)
			end
		else
			parent.ChildAdded:Connect(NewListener)
			for i,v in pairs(parent:GetChildren()) do
				coroutine.wrap(NewListener)(v)
			end
		end
	end

	local boxBase = {}
	boxBase.__index = boxBase

	function boxBase:Remove()
		ESP.Objects[self.Object] = nil
		for i,v in pairs(self.Components) do
			v.Visible = false
			v:Remove()
			self.Components[i] = nil
		end
	end

	function boxBase:Update()
		if not self.PrimaryPart then
			--warn("not supposed to print", self.Object)
			return self:Remove()
		end

		local color
		if ESP.Highlighted == self.Object then
			color = ESP.HighlightColor
		else
			color = self.Color or self.ColorDynamic and self:ColorDynamic() or ESP:GetColor(self.Object) or ESP.Color
		end

		local allow = true
		if ESP.Overrides.UpdateAllow and not ESP.Overrides.UpdateAllow(self) then
			allow = false
		end
		if self.Player and not ESP.Players then
			allow = false
		end
		if self.IsEnabled and (type(self.IsEnabled) == "string" and not ESP[self.IsEnabled] or type(self.IsEnabled) == "function" and not self:IsEnabled()) then
			allow = false
		end
		if not workspace:IsAncestorOf(self.PrimaryPart) and not self.RenderInNil then
			allow = false
		end

		if not allow then
			for i,v in pairs(self.Components) do
				v.Visible = false
			end
			return
		end

		if ESP.Highlighted == self.Object then
			color = ESP.HighlightColor
		end

		--calculations--
		local cf = self.PrimaryPart.CFrame
		if ESP.FaceCamera then
			cf = CFrame.new(cf.p, cam.CFrame.p)
		end
		local size = self.Size
		local locs = {
			TopLeft = cf * ESP.BoxShift * CFrame.new(size.X/2,size.Y/2,0),
			TopRight = cf * ESP.BoxShift * CFrame.new(-size.X/2,size.Y/2,0),
			BottomLeft = cf * ESP.BoxShift * CFrame.new(size.X/2,-size.Y/2,0),
			BottomRight = cf * ESP.BoxShift * CFrame.new(-size.X/2,-size.Y/2,0),
			TagPos = cf * ESP.BoxShift * CFrame.new(0,size.Y/2,0),
			Torso = cf * ESP.BoxShift
		}

		if ESP.Boxes then
			local TopLeft, Vis1 = WorldToViewportPoint(cam, locs.TopLeft.p)
			local TopRight, Vis2 = WorldToViewportPoint(cam, locs.TopRight.p)
			local BottomLeft, Vis3 = WorldToViewportPoint(cam, locs.BottomLeft.p)
			local BottomRight, Vis4 = WorldToViewportPoint(cam, locs.BottomRight.p)

			if self.Components.Quad then
				if Vis1 or Vis2 or Vis3 or Vis4 then
					self.Components.Quad.Visible = true
					self.Components.Quad.PointA = Vector2.new(TopRight.X, TopRight.Y)
					self.Components.Quad.PointB = Vector2.new(TopLeft.X, TopLeft.Y)
					self.Components.Quad.PointC = Vector2.new(BottomLeft.X, BottomLeft.Y)
					self.Components.Quad.PointD = Vector2.new(BottomRight.X, BottomRight.Y)
					self.Components.Quad.Color = color
				else
					self.Components.Quad.Visible = false
				end
			end
		else
			self.Components.Quad.Visible = false
		end

		if ESP.Names then
			local TagPos, Vis5 = WorldToViewportPoint(cam, locs.TagPos.p)

			if Vis5 then
				self.Components.Name.Visible = true
				self.Components.Name.Position = Vector2.new(TagPos.X, TagPos.Y)
				self.Components.Name.Text = self.Name
				self.Components.Name.Color = color

				self.Components.Distance.Visible = true
				self.Components.Distance.Position = Vector2.new(TagPos.X, TagPos.Y + 14)
				self.Components.Distance.Text = math.floor((cam.CFrame.p - cf.p).magnitude) .." M"
				self.Components.Distance.Color = color
			else
				self.Components.Name.Visible = false
				self.Components.Distance.Visible = false
			end
		else
			self.Components.Name.Visible = false
			self.Components.Distance.Visible = false
		end

		if ESP.Tracers then
			local TorsoPos, Vis6 = WorldToViewportPoint(cam, locs.Torso.p)

			if Vis6 then
				self.Components.Tracer.Visible = true
				self.Components.Tracer.From = Vector2.new(TorsoPos.X, TorsoPos.Y)
				self.Components.Tracer.To = Vector2.new(cam.ViewportSize.X/2,cam.ViewportSize.Y/ESP.AttachShift)
				self.Components.Tracer.Color = color
			else
				self.Components.Tracer.Visible = false
			end
		else
			self.Components.Tracer.Visible = false
		end
	end

	function ESP:Add(obj, options)
		if not obj.Parent and not options.RenderInNil then
			return
		end

		local box = setmetatable({
			Name = options.Name or obj.Name,
			Type = "Box",
			Color = options.Color --[[or self:GetColor(obj)]],
			Size = options.Size or self.BoxSize,
			Object = obj,
			Player = options.Player or plrs:GetPlayerFromCharacter(obj),
			PrimaryPart = options.PrimaryPart or obj.ClassName == "Model" and (obj.PrimaryPart or obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChildWhichIsA("BasePart")) or obj:IsA("BasePart") and obj,
			Components = {},
			IsEnabled = options.IsEnabled,
			Temporary = options.Temporary,
			ColorDynamic = options.ColorDynamic,
			RenderInNil = options.RenderInNil
		}, boxBase)

		if self:GetBox(obj) then
			self:GetBox(obj):Remove()
		end

		box.Components["Quad"] = Draw("Quad", {
			Thickness = self.Thickness,
			Color = color,
			Transparency = 1,
			Filled = false,
			Visible = self.Enabled and self.Boxes
		})
		box.Components["Name"] = Draw("Text", {
			Text = box.Name,
			Color = box.Color,
			Center = true,
			Outline = true,
			Size = 19,
			Visible = self.Enabled and self.Names
		})
		box.Components["Distance"] = Draw("Text", {
			Color = box.Color,
			Center = true,
			Outline = true,
			Size = 19,
			Visible = self.Enabled and self.Names
		})

		box.Components["Tracer"] = Draw("Line", {
			Thickness = ESP.Thickness,
			Color = box.Color,
			Transparency = 1,
			Visible = self.Enabled and self.Tracers
		})
		self.Objects[obj] = box

		obj.AncestryChanged:Connect(function(_, parent)
			if parent == nil and ESP.AutoRemove ~= false then
				box:Remove()
			end
		end)
		obj:GetPropertyChangedSignal("Parent"):Connect(function()
			if obj.Parent == nil and ESP.AutoRemove ~= false then
				box:Remove()
			end
		end)

		local hum = obj:FindFirstChildOfClass("Humanoid")
		if hum then
			hum.Died:Connect(function()
				if ESP.AutoRemove ~= false then
					box:Remove()
				end
			end)
		end

		return box
	end

	local function CharAdded(char)
		local p = plrs:GetPlayerFromCharacter(char)
		if not char:FindFirstChild("HumanoidRootPart") then
			local ev
			ev = char.ChildAdded:Connect(function(c)
				if c.Name == "HumanoidRootPart" then
					ev:Disconnect()
					ESP:Add(char, {
						Name = p.Name,
						Player = p,
						PrimaryPart = c
					})
				end
			end)
		else
			ESP:Add(char, {
				Name = p.Name,
				Player = p,
				PrimaryPart = char.HumanoidRootPart
			})
		end
	end
	local function PlayerAdded(p)
		p.CharacterAdded:Connect(CharAdded)
		if p.Character then
			coroutine.wrap(CharAdded)(p.Character)
		end
	end
	plrs.PlayerAdded:Connect(PlayerAdded)
	for i,v in pairs(plrs:GetPlayers()) do
		if v ~= plr then
			PlayerAdded(v)
		end
	end

	game:GetService("RunService").RenderStepped:Connect(function()
		cam = workspace.CurrentCamera
		for i,v in (ESP.Enabled and pairs or ipairs)(ESP.Objects) do
			if v.Update then
				local s,e = pcall(v.Update, v)
				if not s then warn("[EU]", e, v.Object:GetFullName()) end
			end
		end
	end)

	ESPPageRight:AddToggle("ESP Player",{Stats = false , callback = function(starts)
		ESP:Toggle(starts)
		ESP.Boxes = starts
		ESP.Players = starts
		ESP.Names = starts
		ESP.Tracers = starts
	end})

end

ESPPageRight:AddToggle("ESP Chest",{Stats = false , callback = function(starts)
	ChestESP = starts
	while ChestESP do fask.wait()
		UpdateChestChams()
	end
end})

ESPPageRight:AddToggle("ESP Devil Fruit",{Stats = false , callback = function(starts)
	DevilFruitESP = starts
	while DevilFruitESP do fask.wait()
		UpdateDevilChams()
	end
end})

ESPPageRight:AddToggle("ESP Flower",{Stats = false , callback = function(starts)
	FlowerESP = starts
	while FlowerESP do fask.wait()
		UpdateFlowerChams()
	end
end})

ESPPageRight:AddToggle("ESP Real Fruit",{Stats = false , callback = function(starts)
	RealFruitESP = starts
	while RealFruitESP do fask.wait()
		UpdateRealFruitChams()
	end
end})

local MiscellaneousTap = Lib:CreateTap("Miscellaneous");

local AbilitiesPageLeft = MiscellaneousTap:CreatePage("Abilities",1)

AbilitiesPageLeft:AddToggle("Auto Active Ability",{Stats = false , callback = function(starts)
	AutoActiveRace = starts
	spawn(function()
		while fask.wait() do
			if AutoActiveRace then
				game:GetService("ReplicatedStorage").Remotes.CommE:FireServer("ActivateAbility")
			else
				break
			end
		end
	end)
end})
AbilitiesPageLeft:AddToggle("infinity Ability",{Stats = false , callback = function(starts)
	infinityRace = starts
	spawn(function()
		while fask.wait() do
			if infinityRace then
				if not game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Agility") then
					local Agility = game:GetService("ReplicatedStorage").FX["Agility"]:Clone()
					Agility.Parent = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
				end
			else
				if game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Agility") then
					game:GetService("Players").LocalPlayer.Character.HumanoidRootPart["Agility"]:Destroy()
				end
				break
			end
		end
	end)
end})

AbilitiesPageLeft:AddToggle("Dodge No Cooldown",{Stats = false , callback = function(starts)
	nododgecool = starts
	if nododgecool then
		for i,v in next, getgc() do
			if typeof(v) == "function" then
				if getfenv(v).script == game.Players.LocalPlayer.Character:WaitForChild("Dodge") then
					for i2,v2 in pairs(debug.getupvalues(v)) do
						if type(v2) == 'table' then
							if v2.LastUse then
								spawn(function()
									repeat fask.wait()
										setupvalue(v, i2, {LastAfter = 0,LastUse = 0})
									until not game.Players.LocalPlayer.Character:FindFirstChild("Dodge") or not nododgecool
								end)
							end
						end
					end
				end
			end
		end
	end
end})

AbilitiesPageLeft:AddToggle("Inf Sky Jump",{Stats = false , callback = function(starts)
	InfSkyJump = starts
	if InfSkyJump then
		repeat fask.wait() until not game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") or game.Players.LocalPlayer.Character.Humanoid.FloorMaterial ~= Enum.Material.Air
		for i,v in next, getgc() do
			if typeof(v) == "function" then
				if getfenv(v).script == game.Players.LocalPlayer.Character:WaitForChild("Skyjump") then
					for i2,v2 in next, getupvalues(v) do
						if tostring(v2) == "0" then
							spawn(function()
								repeat fask.wait(.1)
									setupvalue(v,i2,0)
								until not game.Players.LocalPlayer.Character:FindFirstChild("Skyjump") or not InfSkyJump
							end)
						end
					end
				end
			end
		end
	end
end})

AbilitiesPageLeft:AddToggle("Soru No Cooldown",{Stats = false , callback = function(starts)
	Sorunocool = starts
	if Sorunocool then
		for i,v in next, getgc() do
			if typeof(v) == "function" then
				if getfenv(v).script == game.Players.LocalPlayer.Character:WaitForChild("Soru") then
					for i2,v2 in pairs(debug.getupvalues(v)) do
						if type(v2) == 'table' then
							if v2.LastUse then
								spawn(function()
									repeat fask.wait()
										setupvalue(v, i2, {LastAfter = 0,LastUse = 0})
									until not game.Players.LocalPlayer.Character:FindFirstChild("Soru") or not Sorunocool
								end)
							end
						end
					end
				end
			end
		end
	end
end})

AbilitiesPageLeft:AddToggle("Infinits Energy",{Stats = false , callback = function(starts)
	InfinitsEnergy = starts
end})
AbilitiesPageLeft:AddToggle("Infinits Range observations haki",{Stats = false , callback = function(starts)
	infobservations = starts
	if infobservations then
		game.Players.LocalPlayer.VisionRadius.Value = math.huge
	end
end})
if game.Workspace:FindFirstChild("WaterEz") then
	game.Workspace:FindFirstChild("WaterEz"):Destroy()
end

AbilitiesPageLeft:AddToggle("Walk On Water",{Stats = false , callback = function(starts)
	WalkWater = starts
	spawn(function()
		while fask.wait() do
			if WalkWater == true then
				if game.Workspace:FindFirstChild("WaterEz") then
					game.Workspace:FindFirstChild("WaterEz").Position = Vector3.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position.x,-4.2,game.Players.LocalPlayer.Character.HumanoidRootPart.Position.z)
				else
					if game.Workspace:FindFirstChild("WaterEz") then
						game.Workspace:FindFirstChild("WaterEz"):Destroy()
					end

					local part = Instance.new("Part")
					part.Parent = game.Workspace
					part.Name = "WaterEz"
					part.Anchored = true
					part.Size = Vector3.new(50,0.1,50)
					part.Transparency = 1
					part.CanCollide = true
				end
			else
				if game.Workspace:FindFirstChild("WaterEz") then
					game.Workspace:FindFirstChild("WaterEz"):Destroy()
				end
				break
			end
		end
	end)
end})
local BlackScreen = Instance.new("ScreenGui")
BlackScreen.Name = "Bla"
BlackScreen.Parent = game.CoreGui
BlackScreen.IgnoreGuiInset = true
local RealBlackScreen = Instance.new("Frame")
RealBlackScreen.Parent = BlackScreen
RealBlackScreen.Visible = false
RealBlackScreen.Size = UDim2.new(10, 1000000, 10, 100000)
RealBlackScreen.BackgroundColor3 = Color3.fromRGB(0,0,0)
RealBlackScreen.ZIndex = 5

local WhiteScreenOwo = AbilitiesPageLeft:AddToggle("White Screen [ F4 To toggle ]",{Stats = false , callback = function(starts) -- f4
	WhiteScreen = starts
	_G.ConfigMain["White Screen"] = starts
	SaveConfigAuto()
	RealBlackScreen.Visible = WhiteScreen
	if WhiteScreen then
		game:GetService("RunService"):Set3dRenderingEnabled(false)
	else
		game:GetService("RunService"):Set3dRenderingEnabled(true)
	end
end})

local NOTIFYOWO = AbilitiesPageLeft:AddToggle("Off Notify Ui",{Stats = false , callback = function(starts) -- f4
	game:GetService("Players")["LocalPlayer"].PlayerGui:FindFirstChild("Notifications").Enabled = not starts
	_G.ConfigMain["Off Notify Ui"] = starts
	SaveConfigAuto()
end})

local UserInputService = game:GetService("UserInputService")
UserInputService.InputBegan:Connect(function(io, p)
	if io.KeyCode == Enum.KeyCode.F4 then
		ChangeToggle(WhiteScreenOwo,not WhiteScreenOwo.value)
	end
end)

function Format(Int)
	return string.format("%02i", Int)
end

function convertToHMS(Seconds)
	local Minutes = (Seconds - Seconds%60)/60
	Seconds = Seconds - Minutes*60
	local Hours = (Minutes - Minutes%60)/60
	Minutes = Minutes - Hours*60
	return Format(Hours).."h"..Format(Minutes).."m"..Format(Seconds).."s"
end

if game.CoreGui:FindFirstChild("Clocker") then game.CoreGui:FindFirstChild("Clocker"):Destroy() end

local function CreateInstance(cls,props)
	local inst = Instance.new(cls)
	for i,v in pairs(props) do
		inst[i] = v
	end
	return inst
end

local Clocker = CreateInstance('ScreenGui',{DisplayOrder=0,Enabled=false,ResetOnSpawn=true,Name='Clocker', Parent=game.CoreGui})
local background = CreateInstance('ImageLabel',{Image='rbxassetid://2851926732',ImageColor3=Color3.new(0.117647, 0.117647, 0.117647),ImageRectOffset=Vector2.new(0, 0),ImageRectSize=Vector2.new(0, 0),ImageTransparency=0,ScaleType=Enum.ScaleType.Slice,SliceCenter=Rect.new(12, 12, 12, 12),Active=false,AnchorPoint=Vector2.new(0.5, 0.5),BackgroundColor3=Color3.new(1, 1, 1),BackgroundTransparency=1,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=true,Draggable=false,Position=UDim2.new(0.0424528308, 0, 0.0470347628, 0),Rotation=0,Selectable=false,Size=UDim2.new(0, 70, 0, 28),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='background',Parent = Clocker})
local timerlabel = CreateInstance('TextLabel',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Timer',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,Active=false,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(1, 1, 1),BackgroundTransparency=1,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0, 0, 0, 0),Rotation=0,Selectable=false,Size=UDim2.new(0, 70, 0, 13),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='timerlabel',Parent = background})
local timer = CreateInstance('TextLabel',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='0:0:0',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,Active=false,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(1, 1, 1),BackgroundTransparency=1,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0, 0, 0.535714269, 0),Rotation=0,Selectable=false,Size=UDim2.new(0, 70, 0, 13),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='timer',Parent = background})

AbilitiesPageLeft:AddToggle("Timer Ui",{Stats = false , callback = function(starts)
	TimerUi = starts
	spawn(function()
		while fask.wait() do
			if TimerUi then
				Clocker.Enabled = true
				local scripttime=game.Workspace.DistributedGameTime
				local seconds = scripttime%60
				local minutes = math.floor(scripttime/60%60)
				local hours = math.floor(scripttime/3600)
				local tempo = string.format("%.0fH:%.0fM:%.0fS", hours ,minutes, seconds)
				timer.Text = tempo
			else
				Clocker.Enabled = false
				break
			end
		end
	end)
end})

AbilitiesPageLeft:AddToggle("No Fog",{Stats = false , callback = function(starts)
	if starts then
		game:GetService("Lighting").FogEnd = 9e9
		for i,v in pairs(game:GetService("Lighting").LightingLayers:GetChildren()) do 
			if v:FindFirstChildOfClass("NumberValue") then 
				v:FindFirstChildOfClass("NumberValue").Value = 0
			end
		end
		for i,v in pairs(game:GetService("Lighting"):GetChildren()) do 
			if v:FindFirstChildOfClass("ColorCorrectionEffect") then 
				v:FindFirstChildOfClass("ColorCorrectionEffect").Enabled = false
			end
		end
	else
		game:GetService("Lighting").LightingLayers.Haze.Intensity.Value = oldva1
		game:GetService("Lighting").LightingLayers.Haze.Intensity.Value = oldva2
		game:GetService("Lighting").FogEnd = 2500
	end
end})
AbilitiesPageLeft:AddButton("No Fog Unlimited BladeWorks",function()
	game:GetService("Lighting"):ClearAllChildren()
end)
AbilitiesPageLeft:AddToggle("No Clip",{Stats = false , callback = function(starts)
	NoClipFak = starts
end})
AbilitiesPageLeft:AddToggle("Auto W",{Stats = false , callback = function(starts)
	AutoW = starts
	spawn(function()
		while fask.wait() do
			if AutoW then
				game:service('VirtualInputManager'):SendKeyEvent(true, "W", false, game)
				fask.wait(0.3)

			else
				game:service('VirtualInputManager'):SendKeyEvent(false, "W", false, game)
				break;
			end
		end
	end)
end})

AbilitiesPageLeft:AddSlider("Boat Speed",{value = 300 ,min = 150 , max = 400 , callback = function(starts)
	BoatSpeed = starts
end})

AbilitiesPageLeft:AddButton("Set Boat Speed",function()
	for i,v in pairs(game:GetService("Workspace").Boats:GetChildren()) do
		pcall(function()
			if v:FindFirstChildOfClass("VehicleSeat") then
				v:FindFirstChildOfClass("VehicleSeat").MaxSpeed = BoatSpeed
			end
		end)
	end
	
end)

AbilitiesPageLeft:AddToggle("Fly Boat",{Stats = false , callback = function(starts)
	if starts then 
		mobilefly(speaker,true)
	else
		unmobilefly(speaker)
	end

	
end})

AbilitiesPageLeft:AddSlider("Fly Boat Speed",{value = 5 ,min = 1 , max = 12 , callback = function(starts)
	vehicleflyspeed = starts
end})

local vnoclipParts = {}
AbilitiesPageLeft:AddToggle("No Clip Boat",{Stats = false , callback = function(starts)
	if starts then 
		local seat = speaker.Character:FindFirstChildOfClass('Humanoid').SeatPart
		local vehicleModel = seat.Parent
		repeat
			if vehicleModel.ClassName ~= "Model" then
				vehicleModel = vehicleModel.Parent
			end
		until vehicleModel.ClassName == "Model"
		wait(0.1)
		for i,v in pairs(vehicleModel:GetDescendants()) do
			if v:IsA("BasePart") and v.CanCollide then
				table.insert(vnoclipParts,v)
				v.CanCollide = false
			end
		end
	else
		for i,v in ipairs(vnoclipParts) do 
			v.CanCollide = true
		end
	end
end})

AbilitiesPageLeft:AddToggle("Fly",{Stats = false , callback = function(starts)
	Fly = starts
	activatefly()
end})
AbilitiesPageLeft:AddSlider("Fly Speed",{value = 10 ,min = 1 , max = 12 , callback = function(starts)
	speedSET = starts
end})

local MiscellaneousPageRight = MiscellaneousTap:CreatePage("Miscellaneous",2)

MiscellaneousPageRight:AddLabel("~ Join Team ~")

MiscellaneousPageRight:AddButton("Join Pirates Team",function()
	_F("SetTeam","Pirates")
end)

MiscellaneousPageRight:AddButton("Join Marines Team",function()
	_F("SetTeam","Marines")
end)

MiscellaneousPageRight:AddLabel("------------------------------------")

-- MiscellaneousPageRight:AddButton("Open Craft Sword",function()
--     local Main = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Main");
--     local CraftMan = Main.Craft
--     _F("UpgradeItem","Check",inmyself(GetFightingStyle("Sword")))
--     CraftMan.Visible = true
-- end)

-- MiscellaneousPageRight:AddButton("Open Craft Gun",function()
--     local Main = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Main");
--     local CraftMan = Main.Craft
--     _F("UpgradeItem","Check",inmyself(GetFightingStyle("Gun")))
--     CraftMan.Visible = true
-- end)
MiscellaneousPageRight:AddButton("Open Valentine Shop",function()
	local args = {
		[1] = "GetStore"
	}

	game:GetService("ReplicatedStorage").Remotes.Celebration:InvokeServer(unpack(args))

	game:GetService("Players")["LocalPlayer"].PlayerGui.Main.CelebrationShop.Visible = true
end)

MiscellaneousPageRight:AddButton("Open Devil Shop",function()
	local Main = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Main");
	local FruitShop = Main.FruitShop
	FruitShop:SetAttribute("Shop2", false)
	FruitShop.Visible = true
end)

MiscellaneousPageRight:AddButton("Open Advanced Devil Shop",function()
	local Main = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Main");
	local FruitShop = Main.FruitShop
	FruitShop:SetAttribute("Shop2", true)
	FruitShop.Visible = true
end)

MiscellaneousPageRight:AddButton("Open Awakened",function()
	local args = {
		[1] = "getAwakenedAbilities"
	}

	game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
	game.Players.LocalPlayer.PlayerGui.Main.AwakeningToggler.Visible = true
end)

MiscellaneousPageRight:AddButton("Open Color Haki",function()
	game.Players.localPlayer.PlayerGui.Main.Colors.Visible = true
end)

MiscellaneousPageRight:AddButton("Open Title Name",function()
	game.Players.localPlayer.PlayerGui.Main.Titles.Visible = true
end)

MiscellaneousPageRight:AddLabel("------------------------------------")

MiscellaneousPageRight:AddButton("Remove Lava",function()
	for i,v in pairs(game.Workspace:GetDescendants()) do
		if v.Name == "Lava" then
			v:Destroy()
		end
	end
	for i,v in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
		if v.Name == "Lava" then
			v:Destroy()
		end
	end
end)

MiscellaneousPageRight:AddButton("Redeem All Code",function()
	for i,v in pairs(CodeApi) do
		RedeemCode(v)
	end
end)

MiscellaneousPageRight:AddButton("Fast Mode",function()
	local decalsyeeted = true
	local g = game
	local w = g.Workspace
	local l = g.Lighting
	local t = w.Terrain
	t.WaterWaveSize = 0
	t.WaterWaveSpeed = 0
	t.WaterReflectance = 0
	t.WaterTransparency = 0
	l.GlobalShadows = false
	l.FogEnd = 9e9
	l.Brightness = 0
	settings().Rendering.QualityLevel = "Level01"
	for i, v in pairs(g:GetDescendants()) do
		if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
			v.Material = "Plastic"
			v.Reflectance = 0
		elseif v:IsA("Decal") or v:IsA("Texture") and decalsyeeted then
			v.Transparency = 1
		elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
			v.Lifetime = NumberRange.new(0)
		elseif v:IsA("Explosion") then
			v.BlastPressure = 1
			v.BlastRadius = 1
		elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
			v.Enabled = false
		elseif v:IsA("MeshPart") then
			v.Material = "Plastic"
			v.Reflectance = 0
			v.TextureID = 10385902758728957
		end
	end
	for i, e in pairs(l:GetChildren()) do
		if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
			e.Enabled = false
		end
	end
end)

local RaidsTap = Lib:CreateTap("Raids");

local RaidPageLeft = RaidsTap:CreatePage("Raids",1)

RaidPageLeft:AddToggle("Kill Aura",{Stats = false , callback = function(starts)
	RaidsAura = starts
	spawn(function()
		while fask.wait() do
			if RaidsAura then
				for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
					if RaidsAura and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and (v.HumanoidRootPart.Position-game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= DistanceKillAura then
						pcall(function()
							repeat fask.wait()
								v.Humanoid.Health = 0
							until not RaidsAura or v.Humanoid.Health <= 0 or not v.Parent
						end)
					end
				end
			else
				break
			end
		end
	end)
end})

RaidPageLeft:AddToggle("Auto Next Island",{Stats = false , callback = function(starts)
	AutoNextIsland = starts
	spawn(function()
		while fask.wait() do
			if AutoNextIsland then
				if CheckIsland() == true then
					NextIsland()
					if GoIsland == 0 then fask.wait(0.1)
					elseif (ToIslandCFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
						Farmtween = toTarget(ToIslandCFrame)
					elseif (ToIslandCFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
						if Farmtween then Farmtween:Stop() end
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = ToIslandCFrame
					end
				end
			else
				break
			end
		end
	end)
end})
RaidPageLeft:AddToggle("Auto Awakener",{Stats = false , callback = function(starts)
	Awakener = starts
	spawn(function()
		while fask.wait() do
			if Awakener then
				_F("Awakener","Awaken")
			else
				break
			end
		end
	end)
end})
function TP(P)
	NoClip = true
	Distance = (P.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
	if Distance < 10 then
		Speed = 1000
	elseif Distance < 170 then
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = P
		Speed = 350
	elseif Distance < 1000 then
		Speed = 350
	elseif Distance >= 1000 then
		Speed = 250
	end
	game:GetService("TweenService"):Create(
	game.Players.LocalPlayer.Character.HumanoidRootPart,
	TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear),
	{CFrame = P}
	):Play()
	NoClip = false
end

local AutoRaidPageRight = RaidsTap:CreatePage("Auto Raids",2)

local SelectedRaidsLabel = AutoRaidPageRight:AddLabel("Raids Selected : " .. (_G.ConfigMain["Select Raids"] or "Flame"))

RaidsSelected =  (_G.ConfigMain["Select Raids"] or "Flame")
ffraids = AutoRaidPageRight:AddDropdown("Dropdown",{Values = {""} , callback = function(starts)
	if #starts == 0 then return end
	RaidsSelected = starts
	_G.ConfigMain["Select Raids"] = starts
	SaveConfigAuto()
	SelectedRaidsLabel:Options().Text = "Raids Selected : "..starts
end})
for i, v in pairs(AllRaidsTable) do
	ffraids:Add(v)
end

RaidPageLeft:AddToggle("Auto Get Fruit 1m",{Stats = false , callback = function(starts)
	AutoGetF = starts
	spawn(function()
		while fask.wait() do
			if AutoGetF then
				if not CheckIsland() then 
					local FF = false
					local CheckInOutPrice = math.huge
					local FF2 = ''
					for i,v in pairs(Com("F_","getInventoryFruits")) do
						if not v.Price then break end
						if v.Price < 1000000 and v.Price < CheckInOutPrice then 
							CheckInOutPrice = v.Price or math.huge
							FF2 = v.Name
							FF = true
						end
					end

					if FF then
						Com("F_","LoadFruit",FF2)
					end
				end
				task.wait(10)
			else
				break
			end
		end
	end)
end})

RaidPageLeft:AddToggle("Auto Buy Chip",{Stats = false , callback = function(starts)
	AutoBuyChip = starts
	spawn(function()
		while fask.wait() do
			if AutoBuyChip then
				_F("RaidsNpc","Select",RaidsSelected)
			else
				break
			end
		end
	end)
end})

RaidPageLeft:AddToggle("Auto Start Raids",{Stats = false , callback = function(starts)
	AutoStartRaids = starts
	spawn(function()
		while fask.wait() do
			if AutoStartRaids then
				if inmyself("Special Microchip") and game.Players.LocalPlayer.PlayerGui.Main.Timer.Visible == false and not CheckIsland() then
					if NewWorld then
						fireclickdetector(Workspace.Map.CircleIsland.RaidSummon2.Button.Main.ClickDetector)
					elseif ThreeWorld then
						fireclickdetector(Workspace.Map["Boat Castle"].RaidSummon2.Button.Main.ClickDetector)
					end
					fask.wait(15)
				end
				fask.wait(1)
			else
				break
			end
		end
	end)
end})

RaidPageLeft:AddButton("Dungeon",function()
	if NewWorld then
		TP(CFrame.new(-6438.73535, 250.645355, -4501.50684))
	elseif ThreeWorld then
		TP(CFrame.new(-5013.64941, 314.843842, -2817.8042))
	end
end)

ConfigAutoRaids = AutoRaidPageRight:AddToggle("Auto Raids Hop",{Stats = false , callback = function(starts)
	AutoRaids = starts
	_G.ConfigMain["Auto Raids Hop"] = starts
	SaveConfigAuto()
	spawn(function()
		while fask.wait() do
			if AutoRaids then
				if game.Players.LocalPlayer.Backpack:FindFirstChild("Special Microchip") or game.Players.LocalPlayer.Character:FindFirstChild("Special Microchip") or CheckIsland() then
					if game.Players.LocalPlayer.Backpack:FindFirstChild("Special Microchip") or game.Players.LocalPlayer.Character:FindFirstChild("Special Microchip") and game.Players.LocalPlayer.PlayerGui.Main.Timer.Visible == false then
						if NewWorld then
							fireclickdetector(Workspace.Map.CircleIsland.RaidSummon2.Button.Main.ClickDetector)
						elseif ThreeWorld then
							fireclickdetector(Workspace.Map["Boat Castle"].RaidSummon2.Button.Main.ClickDetector)
						end
						fask.wait(16)
					elseif game.Players.LocalPlayer.PlayerGui.Main.Timer.Visible == true then
						pcall(function()
							repeat fask.wait()
								if game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5") or game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4") or game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3") or game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2") or game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1") then
									NextIsland()
									if GoIsland == 0 then fask.wait(0.1)
									elseif (ToIslandCFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
										Farmtween = toTarget(ToIslandCFrame)
									elseif (ToIslandCFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
										if Farmtween then Farmtween:Stop() end
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = ToIslandCFrame
									end
								end
								for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
									if AutoRaids and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and (v.HumanoidRootPart.Position-game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= DistanceKillAura then
										spawn(function()
											repeat fask.wait()
												v.Humanoid.Health = 0
											until not AutoRaids or v.Humanoid.Health <= 0 or not v.Parent
										end)
									end
								end
								_F("Awakener","Awaken")
							until AutoRaids == false or not game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5") or not game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4") or not game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3") or not game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2") or not game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1") or game.Players.LocalPlayer.PlayerGui.Main.Timer.Visible == false
							_F("Awakener","Awaken")
						end)
					end
				else
					spawn(function()
						if NoLoopDuplicate3 == false then
							NoLoopDuplicate3 = true
							for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
								if v:IsA("Tool") and string.find(v.Name,"Fruit") and (v.Handle.Position-game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).Magnitude <= 7000 then
									local oldCFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Handle.CFrame * CFrame.new(3,5,1)
									fask.wait(0.02)
									firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart,v.Handle,0)
									fask.wait()
									firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart,v.Handle,1)
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame  = oldCFrame
									fask.wait(30)
								end
							end
							NoLoopDuplicate3 = false
						end
					end)
					fask.wait(0.5)
					local CheckRaids = _F("RaidsNpc","Select",RaidsSelected)
					if tostring(CheckRaids):find("You must wait") and not game.Players.LocalPlayer.Backpack:FindFirstChild("Special Microchip") and not game.Players.LocalPlayer.Character:FindFirstChild("Special Microchip") then
						ServerFunc:NormalTeleport()
					end
					_F("Awakener","Awaken")
				end
			else
				break
			end
		end
	end)
end})
AutoRaidPageRight:AddButton("Buy Microchip",function()
	if not OldWorld and RaidsSelected ~= "" then
		_F("RaidsNpc","Select",RaidsSelected)
	end
end)
DistanceKillAura = 1000
AutoRaidPageRight:AddSlider("Distance Kill Aura",{value = 500 ,min = 1 , max = 1000 , callback = function(starts)
	DistanceKillAura = starts
end})

local ShopTap = Lib:CreateTap("Shop");

local AbilitiesShopPageLeft = ShopTap:CreatePage("Abilities Shop",1)

AbilitiesShopPageLeft:AddButton("Skyjump [ $10,000 Beli ]",function()
	_F("BuyHaki","Geppo")
end)
AbilitiesShopPageLeft:AddButton("Buso Haki [ $25,000 Beli ]",function()
	_F("BuyHaki","Buso")
end)
AbilitiesShopPageLeft:AddButton("Observation haki [ $750,000 Beli ]",function()
	local args = {
		[1] = "KenTalk",
		[2] = "Start"
	}

	game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))

	local args = {
		[1] = "KenTalk",
		[2] = "Buy"
	}

	game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)
AbilitiesShopPageLeft:AddButton("Soru [ $100,000 Beli ]",function()
	_F("BuyHaki","Soru")
end)
AbilitiesShopPageLeft:AddButton("Buy All Abilities",function()
	_F("BuyHaki","Geppo")
	_F("BuyHaki","Buso")
	local args = {
		[1] = "KenTalk",
		[2] = "Start"
	}

	game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))

	local args = {
		[1] = "KenTalk",
		[2] = "Buy"
	}

	game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
	_F("BuyHaki","Soru")
end)

local FightingStyleShopPageRight = ShopTap:CreatePage("Fighting Style Shop",2)

FightingStyleShopPageRight:AddButton("Black Leg [ $150,000 Beli ]",function()
	_F("BuyBlackLeg")
end)
FightingStyleShopPageRight:AddButton("Electro [ $500,000 Beli ]",function()
	_F("BuyElectro")
end)
FightingStyleShopPageRight:AddButton("Fishman Karate [ $750,000 Beli ]",function()
	_F("BuyFishmanKarate")
end)
FightingStyleShopPageRight:AddButton("Dragon Claw [ 1.5K Fragments ]",function()
	_F("BlackbeardReward", "DragonClaw", "2")
end)
FightingStyleShopPageRight:AddButton("Sanguineart [ $5M Beli + 5K Fragments ]",function()
	_F("BuySanguineart")
end)
FightingStyleShopPageRight:AddButton("Godhuman [ $5M Beli + 5K Fragments ]",function()
	_F("BuyGodhuman")
end)
FightingStyleShopPageRight:AddButton("Superhuman [ $3M Beli ]",function()
	_F("BuySuperhuman")
end)
FightingStyleShopPageRight:AddButton("Death Step [ $2.5M Beli + 5K Fragments ]",function()
	_F("BuyDeathStep")
end)
FightingStyleShopPageRight:AddButton("Sharkman Karate [ $2.5M Beli + 5K Fragments ]",function()
	_F("BuySharkmanKarate")
end)
FightingStyleShopPageRight:AddButton("Electric Claw [ $3M Beli + 5K Fragments ]",function()
	_F("BuyElectricClaw")
end)
FightingStyleShopPageRight:AddButton("Dragon Talon [ $3M Beli + 5K Fragments ]",function()
	_F("BuyDragonTalon" , true)
	_F("BuyDragonTalon")
end)

local PlayersShopPageRight = ShopTap:CreatePage("Players Shop",2)

PlayersShopPageRight:AddButton("Reroll Race",function()
	_F("BlackbeardReward", "Reroll", "2")
end)
PlayersShopPageRight:AddButton("Reroll Stats",function()
	_F("BlackbeardReward", "Refund", "2")
end)

local SwordShopPageLeft = ShopTap:CreatePage("Sword Shop",1)

for i,v in pairs({"Katana","Cutlass","Dual Katana","Iron Mace","Triple Katana","Pipe","Soul Cane","Dual-Headed Blade","Bisento"}) do
	SwordShopPageLeft:AddButton(v .. " [ ".. comma_value(ShopSword.Items[v].Price) .." Beli ] ",function()
		_F("BuyItem",v)
	end)
end
SwordShopPageLeft:AddButton("Pole v.2 [ 5,000 Fragments ]",function()
	_F("ThunderGodTalk")
end)

local GunShopPageRight = ShopTap:CreatePage("Gun Shop",2)

for i,v in pairs({"Slingshot","Musket","Flintlock","Refined Slingshot","Refined Flintlock","Cannon"}) do
	GunShopPageRight:AddButton(v .. " [ ".. comma_value(ShopSword.Items[v].Price) .." Beli ] ",function()
		_F("BuyItem",v)
	end)
end
GunShopPageRight:AddButton("Kabucha [ 1,500 Fragments ]",function()
	_F("BlackbeardReward", "Slingshot", "2")
end)

local AccessoryShopPageRight = ShopTap:CreatePage("Accessory Shop",2)

AccessoryShopPageRight:AddButton("Black Cape [ $50,000 Beli ]",function()
	_F("BuyItem","Black Cape")
end)
AccessoryShopPageRight:AddButton("Swordsman Hat [ 150k Beli + 300+ Sword Points ]",function()
	_F("BuyItem","Swordsman Hat")
end)
AccessoryShopPageRight:AddButton("Tomoe Ring [ $500k Beli + 200 Melee Points ]",function()
	_F("BuyItem","Tomoe Ring")
end)

local RaceAndetcShopPageRight = ShopTap:CreatePage("Race & etc. Shop",2)

RaceAndetcShopPageRight:AddButton("Race Ghoul [ 3,000 Fragments ]",function()
	_F("Ectoplasm","BuyCheck",4)
	_F("Ectoplasm","Change",4)
end)
RaceAndetcShopPageRight:AddButton("Race Cyborg [ 2,500 Fragments ]",function()
	_F("CyborgTrainer","Buy")
end)

RaceAndetcShopPageRight:AddButton("Random Race [ Use 3K Fragments ]",function()
	_F("BlackbeardReward","Reroll","2")
end)
RaceAndetcShopPageRight:AddButton("Reset Stats [ Use 2.5K Fragments ]",function()
	_F("BlackbeardReward","Refund","2")
end)

local DevilFruitTap = Lib:CreateTap("Devil Fruit");

local AutoRandomDevilFruitPage = DevilFruitTap:CreatePage("Auto Random Devil Fruit & Sniper",1)

local Error01,Error02,RandomDevilFruitMoney = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Cousin", "Check");
SelectDevilFruitSniper = {}
AutoRandomDevilFruitPage:AddMultiDropdown("Select Devil Fruit Sniper",{Values = Table_DevilFruitSniper,setup = SelectDevilFruitSniper , callback = function(starts)
	SelectDevilFruitSniper = starts
end})
ConfigAutoBuyFruitSinper = AutoRandomDevilFruitPage:AddToggle("Auto Buy Devil Fruit SinperAuto Buy Devil Fruit Sniper",{Stats = false , callback = function(starts)
	AutoBuyFruitSinper = starts
	spawn(function()
		while fask.wait() do
			if AutoBuyFruitSinper then
				for i,v in pairs(SelectDevilFruitSniper) do
					_F("PurchaseRawFruit",v)
					if game:GetService("Players")["LocalPlayer"]:WaitForChild("Data"):WaitForChild("DevilFruit").Value == v then
						AutoBuyFruitSinper = false
						ChangeToggle(ConfigAutoBuyFruitSinper,false)
						break
					end
				end
			else
				break
			end
			fask.wait(20)
		end
	end)
end})

RaceAndetcShopPageRight:AddButton("Buy Random Devil Fruit [ " .. comma_value(RandomDevilFruitMoney) .. " Beli ]",function()
	_F("Cousin","Buy")
end)
ConfigAutoRandomDevilFruit = AutoRandomDevilFruitPage:AddToggle("Auto Random Devil Fruit",{Stats = false , callback = function(starts)
	AutoBuyRandomDevilFruit = starts
	_G.ConfigMain["Auto Random Devil Fruit"] = starts
	SaveConfigAuto()
	spawn(function()
		while fask.wait() do
			if AutoBuyRandomDevilFruit then
				_F("Cousin","Buy")
			else
				break
			end
			fask.wait(30)
		end
	end)
end})

local StoreDevilFruitsPage = DevilFruitTap:CreatePage("Store Devil Fruits & Bring Fruit",2)

ListMyDF = StoreDevilFruitsPage:AddDropdown("List My Store Devil Fruits",{Values = {""} , callback = function(starts)
	SelectedStoreDevilStore = starts
end})
ListMyDF:Clear()
for i, v in pairs(TabelDevilFruitStore) do
    ListMyDF:Add(v)
end
spawn(function()
	while fask.wait(300) do
		ListMyDF:Clear()
		TabelDevilFruitStore = {}
		for i,v in pairs(game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("getInventoryFruits")) do
			table.insert(TabelDevilFruitStore,v.Name)
		end
		for i, v in pairs(TabelDevilFruitStore) do
			ListMyDF:Add(v)
		end
	end
end)
StoreDevilFruitsPage:AddButton("Load Store Devil Fruits",function()
	_F("LoadFruit",SelectedStoreDevilStore)
	ListMyDF:Clear()
	TabelDevilFruitStore = {}
	for i,v in pairs(game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("getInventoryFruits")) do
		table.insert(TabelDevilFruitStore,v.Name)
	end
	for i, v in pairs(TabelDevilFruitStore) do
		ListMyDF:Add(v)
	end
end)
ConfigAutoStoreFruits = StoreDevilFruitsPage:AddToggle("Auto Store Fruits",{Stats = false , callback = function(starts)
	AutoStoreFruits = starts
	_G.ConfigMain["Auto Store Fruits"] = starts
	SaveConfigAuto()
	spawn(function()
		while fask.wait() do
			if AutoStoreFruits then fask.wait()
				xpcall(function()
					for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
						if string.find(v.Name,"Fruit") then
							local FruitName = RemoveTextFruit(v.Name)
							if v.Name == "Bird: Falcon Fruit" then
								NameFruit = "Bird-Bird: Falcon"
							elseif v.Name == "Bird: Phoenix Fruit" then
								NameFruit = "Bird-Bird: Phoenix"
							elseif v.Name == "Human: Buddha Fruit" then
								NameFruit = "Human-Human: Buddha"
							else
								NameFruit = FruitName.."-"..FruitName
							end

							local string_1 = "getInventoryFruits";
							local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
							for i1,v1 in pairs(Target:InvokeServer(string_1)) do
								if v1.Name == NameFruit then
									HaveFruitInStore = true
								end
							end
							if not HaveFruitInStore then
								_F("StoreFruit",NameFruit,inmyself(v.Name))
							end
							HaveFruitInStore = false
						end
					end
				end,
				function(x)
					print("Error Is : "..x)
				end)
			else
				break
			end
		end
	end)
end})
ConfigBringDevilFruits = StoreDevilFruitsPage:AddToggle("Bring Devil Fruits",{Stats = false , callback = function(starts)
	BringDevilFruit = starts
	_G.ConfigMain["Bring Devil Fruit"] = starts
	SaveConfigAuto()
	spawn(function()
		while fask.wait() do
			if BringDevilFruit then
				for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
					if v:IsA("Tool") and string.find(v.Name,"Fruit") and (v.Handle.Position-game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).Magnitude <= 7000 then
						local oldCFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Handle.CFrame * CFrame.new(3,5,1)
						fask.wait(0.02)
						firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart,v.Handle,0)
						fask.wait()
						firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart,v.Handle,1)
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame  = oldCFrame
						fask.wait(20)
					end
				end
			else
				break
			end
		end
	end)
end})

ConfigTpDevilFruits = StoreDevilFruitsPage:AddToggle("Tp To Devil Fruits",{Stats = false , callback = function(starts)
	TpDevilFruit = starts
	_G.ConfigMain["Tp Devil Fruit"] = starts
	SaveConfigAuto()
	spawn(function()
		while fask.wait() do
			if TpDevilFruit then
				for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
					if string.find(v.Name,"Fruit") and TpDevilFruit then
						if v:IsA("Tool") then
							repeat fask.wait()
								TpToDf = toTarget(v.Handle.CFrame)
							until (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Handle.Position).Magnitude <= 2 or not TpDevilFruit or not v.Parent
							if not TpDevilFruit then
								if tween then tween:Cancel() end
								break
							end
						else
							repeat fask.wait()
								TpToDf = toTarget(v:GetModelCFrame())
							until (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v:GetModelCFrame().Position).Magnitude <= 2 or not TpDevilFruit or not v.Parent
							if not TpDevilFruit then
								if tween then tween:Cancel() end
								break
							end
						end
					end
				end
			else
				break
			end
		end
	end)
end})

local DevilFruitFindPage = DevilFruitTap:CreatePage("Devil Fruit Find",2)

SelectDevilFruitFinder = _G.ConfigMain["Select Devil Fruit Finder"] or {}

DevilFruitSelect = DevilFruitFindPage:AddMultiDropdown("Devil Fruit Select",{Values = Table_DevilFruitSniper,setup = SelectDevilFruitFinder  , callback = function(starts)
	SelectDevilFruitFinder = starts
	_G.ConfigMain["Select Devil Fruit Finder"] = starts
	SaveConfigAuto()
end})

ConfigDevilFruitFind = DevilFruitFindPage:AddToggle("Devil Fruit Find",{Stats = false , callback = function(starts)
	DevilFruitFind = starts
	_G.ConfigMain["Devil Fruit Find"] = starts
	SaveConfigAuto()
	spawn(function()
		while fask.wait() do
			if DevilFruitFind then
				if  (function()for a,b in pairs(game:GetService("Workspace"):GetChildren())do if b:IsA("Tool")and string.find(b.Name,"Fruit")then return true end end;return false end)() then
					for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
						if v:IsA("Tool") and string.find(v.Name,"Fruit") and DevilFruitFind then
							local RaidsName = tostring(v.Name:split("-")[2])
							if table.find(RaidsName.." Fruit",SelectDevilFruitFinder) then
								if FruitTarget then ChestTarget:Stop() end
								repeat fask.wait(0.1)
									FruitTarget = toTarget(v.Handle.CFrame)
								until (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Handle.Position).Magnitude <= 8 or not DevilFruitFind or not v.Parent
								fask.wait(0.5)
								HaveFruitInStore = false
								for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
									if string.find(v.Name,"Fruit") and v:IsA("Tool") then
										local FruitName = (v.Name):gsub(" Fruit", "")
										if v.Name == "Bird: Falcon Fruit" then
											NameFruit = "Bird-Bird: Falcon"
										elseif v.Name == "Bird: Phoenix Fruit" then
											NameFruit = "Bird-Bird: Phoenix"
										elseif v.Name == "Human: Buddha Fruit" then
											NameFruit = "Human-Human: Buddha"
										else
											NameFruit = FruitName.."-"..FruitName
										end

										for i1,v1 in pairs(_F("getInventory")) do
											if v1.Name == NameFruit then
												HaveFruitInStore = true
											end
										end
										if HaveFruitInStore == false then
											_F("StoreFruit",NameFruit,inmyself(v.Name))
										end
										HaveFruitInStore = false
									end
								end
								HaveFruitInStore = false
								for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
									if string.find(v.Name,"Fruit") and v:IsA("Tool") then
										local FruitName = (v.Name):gsub(" Fruit", "")
										if v.Name == "Bird: Falcon Fruit" then
											NameFruit = "Bird-Bird: Falcon"
										elseif v.Name == "Bird: Phoenix Fruit" then
											NameFruit = "Bird-Bird: Phoenix"
										elseif v.Name == "Human: Buddha Fruit" then
											NameFruit = "Human-Human: Buddha"
										else
											NameFruit = FruitName.."-"..FruitName
										end

										for i1,v1 in pairs(_F("getInventory")) do
											if v1.Name == NameFruit then
												HaveFruitInStore = true
											end
										end
										if HaveFruitInStore == false then
											_F("StoreFruit",NameFruit,inmyself(v.Name))
										end
										HaveFruitInStore = false
									end
								end
							end
						end
					end
				else
					ServerFunc:NormalTeleport()
				end
			else
				break
			end
		end
	end)
end})

local SettingTap = Lib:CreateTap("Setting");

local SettingPage = SettingTap:CreatePage("Setting",1)

SettingPage:AddButton("Copy JobId",function()
	setclipboard(tostring(game.JobId))
end)

SettingPage:AddTextBox("Insert JobId",{Placeholder = "Insert JobId",callback = function(starts)
	JobIdBro = starts
end})

SettingPage:AddTextBox("Royx Webhook Id",{Placeholder = "Insert Id",callback = function(starts)
	game:GetService("ReplicatedStorage").__ServerBrowser:InvokeServer("teleport",crypt:aesDecrypt(aesEncrypt, passphrase, iv))
end})

SettingPage:AddButton("Teleport JobId",function()
	game:GetService("ReplicatedStorage").__ServerBrowser:InvokeServer("teleport",JobIdBro)
end)

SettingPage:AddButton("Join Discord",function()
	setclipboard("https://discord.com/invite/uhnwMCtR")
	Notify({
		Title = "Alert",
		Text = "Clipboard Set Paste Link In Google",
		Timer = 3
	},"Warn")
end)
SettingPage:AddButton("Rejoin",function()
	ServerFunc:Rejoin()
end)
SettingPage:AddButton("Server Hop",function()
	ServerFunc:NormalTeleport()
end)
SettingPage:AddButton("Server Hop Less People",function()
	ServerFunc:TeleportFast()
end)

SettingPage:AddLabel("~~ Ui Setting ~~")

SettingPage:AddToggle("Destroy Multi Ui",{Stats = true , callback = function(starts)
	DestroyMultiUi = starts
end})

SettingPage:AddLabel("~~ FPS Setting ~~")

local SelectLockFPS = (_G.ConfigMain["Select Lock FPS"] or 25)

local ShowFpsSelectLock = SettingPage:AddLabel("Select FPS Lock : "..SelectLockFPS)

ConfigLockFPSNow = SettingPage:AddToggle("Lock FPS Now",{Stats = false , callback = function(starts)
	LockFPSNow = starts
	_G.ConfigMain["Lock FPS Now"] = starts
	if LockFPSNow then
		setfpscap(SelectLockFPS)
	else
		setfpscap(200)
	end
	SaveConfigAuto()
end})

SettingPage:AddTextBox("Select Lock FPS",{Placeholder = "Insert Lock FPS",callback = function(starts)
	if not tonumber(starts) then return end
	SelectLockFPS = starts
	_G.ConfigMain["Select Lock FPS"] = starts
	ShowFpsSelectLock:Options().Text = "Select FPS Lock : "..SelectLockFPS
	if LockFPSNow then
		setfpscap(SelectLockFPS)
	else
		setfpscap(200)
	end
	SaveConfigAuto()
end})

function _InitializeReduceCPU()
	UserInputService.WindowFocused:Connect(function()
		if LockFPSNow then setfpscap(SelectLockFPS) return end
		setfpscap(200)
	end)
	UserInputService.WindowFocusReleased:Connect(function()
		if LockFPSNow then setfpscap(SelectLockFPS) return end
		setfpscap(SelectLockFPS)
	end)
end
_InitializeReduceCPU()

local SettingConfigPage = SettingTap:CreatePage("Setting Config",2)

ConfigSelected = SettingConfigPage:AddDropdown("Select Config",{Values = {SelectConfig} , callback = function(starts)
	SelectConfig = starts
end})

NameConfig = nil

SettingConfigPage:AddTextBox("Name Config",{Placeholder = "Insert Name Config",callback = function(starts)
	NameConfig = starts
end})

SettingConfigPage:AddButton("Create New Profile",function()
	if NameConfig == nil then return end
	writefile("RoyXHub_BF/"..NameConfig..".json",HttpService:JSONEncode(_G.ConfigMain))
	TableInsertNoDuplicates(TableConfigSelect,NameConfig .. ".json")
	for i, v in pairs(TableConfigSelect) do
		ConfigSelected:Add(v)
	end
end)

SettingConfigPage:AddButton("Set To Default",function()
	ConfigSelect["Default"] = SelectConfig
	writefile("RoyXHub_BF/" .."Configs"..".json",HttpService:JSONEncode(ConfigSelect))
end)

SettingConfigPage:AddButton("Delete File",function()
	if SelectConfig == "DefaultConfig.json" then return end
	delfile("RoyXHub_BF/"..SelectConfig)
	TableConfigSelect = {}
	ConfigSelected:Clear()
	for i,v in pairs(listfiles("RoyXHub_BF")) do
		if not RemoveSomeThing(v):find("Configs") then
			TableInsertNoDuplicates(TableConfigSelect,RemoveSomeThing(v))
			for i, v in pairs(TableConfigSelect) do
				ConfigSelected:Add(v)
			end
		end
	end
end)

SettingConfigPage:AddButton("Refresh Profile",function()
	TableConfigSelect = {}
	ConfigSelected:Clear()
	for i,v in pairs(listfiles("RoyXHub_BF")) do
		if not RemoveSomeThing(v):find("Configs") then
			TableInsertNoDuplicates(TableConfigSelect,RemoveSomeThing(v))
			for i, v in pairs(TableConfigSelect) do
				ConfigSelected:Add(v)
			end
		end
	end
end)

ConfigAutoSaveConfig = SettingConfigPage:AddToggle("Auto Save Config",{Stats = (ConfigSelect["Auto Save Config"]) , callback = function(starts)
	AutoSaveConfig = starts
	ConfigSelect["Auto Save Config"] = starts
	writefile("RoyXHub_BF/" .."Configs"..".json",HttpService:JSONEncode(ConfigSelect))
end})

ConfigAutoLoadConfig = SettingConfigPage:AddToggle("Auto Load Config",{Stats = (ConfigSelect["Auto Load Config"]) , callback = function(starts)
	AutoLoadConfig = starts
	ConfigSelect["Auto Load Config"] = starts
	writefile("RoyXHub_BF/" .."Configs"..".json",HttpService:JSONEncode(ConfigSelect))
end})

ConfigAutoExecute = SettingConfigPage:AddToggle("Auto Execute When Rejoin",{Stats = (ConfigSelect["Auto Execute"]) , callback = function(starts)
	AutoExecute = starts
	ConfigSelect["Auto Execute"] = starts
	writefile("RoyXHub_BF/" .."Configs"..".json",HttpService:JSONEncode(ConfigSelect))
end})

local function LoadSetting(ConfigSetting)
	local Settings = ConfigSetting
	SelectToolWeapon = Settings["Select Weapon"]
	SelectWeaponLockMastery = Settings["Select Weapon Lock Mastery"]
	SelectFastAttackMode = (Settings["Fast Attack Mode"] or "Fast Attack")
	ChangeModeFastAttack(SelectFastAttackMode)
	SelectLockLevel = Settings["Select Lock Level"] or MaxLevel
	SelectMastery = Settings["Select Lock Mastery"] or 600
	SelectRedeemx2 = Settings["Select Redeem Level"] or MaxLevel
	SelectBeli = Settings["Select Lock Beli"] or 0
	SelectFragments = Settings["Select Lock Fragments"] or 30000

	ChangeToggle(ConfigAutoFarmLvl,Settings["Auto Farm Level"])
	ChangeToggle(ConfigDoubleQuest,Settings["Double Quest"])
	ChangeToggle(ConfigFarmWithQuestBoss,Settings["Farm Boss Quest Too"])
	ChangeToggle(ConfigSkipFarmLevel,Settings["Skip Farm Level"])
	ChangeToggle(ConfigAutoQuest,Settings["Auto Quest Level Farm"])
	ChangeToggle(ConfigLockBeli,Settings["Start Lock Beli"])
	ChangeToggle(ConfigLockFragments,Settings["Start Lock Fragments"])
	ChangeToggle(ConfigLockLevel,Settings["Start Lock Level"])
	ChangeToggle(ConfigLockMastery,Settings["Start Lock Mastery"])
	ChangeToggle(ConfigRedeemCodex2Level,Settings["Auto Redeem Code x2"])

	if OldWorld then
		ChangeToggle(ConfigAutoNewWorld,Settings["Auto New World"])
	end
	if NewWorld then
		ChangeToggle(ConfigAutoFactory,Settings["Auto Factory"])
		ChangeToggle(ConfigAutoThirdWorld,Settings["Auto Third World"])
	end

	ChangeToggle(ConfigAutoGodhuman,Settings["Auto Godhuman"])
	ChangeToggle(ConfigAutoSuperhuman,Settings["Auto Superhuman"])
	ChangeToggle(ConfigAutoDeathStep,Settings["Auto Death Step"])
	ChangeToggle(ConfigAutoDragonTalon,Settings["Auto Dragon Talon"])
	ChangeToggle(ConfigAutoElectricClaw,Settings["Auto Electric Claw"])

	ChangeToggle(ConfigAutoBuyTrueTripleKatana,Settings["Auto Buy True Triple Katana"])
	SelectHakiColor = Settings["Select Legendary Sword"] or {}
	ChangeToggle(ConfigAutoBuyLegendarySword,Settings["Auto Buy Legendary Sword"])
	ChangeToggle(ConfigAutoBuyLegendarySwordHop,Settings["Auto Buy Legendary Sword Hop"])
	ChangeToggle(ConfigLockLegendarySwordToBuy,Settings["Lock Legendary Sword To Buy"])
	SelectHakiColor = Settings["Select Haki Color"] or {}
	ChangeToggle(ConfigAutoBuyEnhancement,Settings["Auto Buy Enhancement"])
	ChangeToggle(ConfigAutoBuyEnhancementHop,Settings["Auto Buy Enhancement Hop"])
	ChangeToggle(ConfigLockHakiColorToBuy,Settings["Lock Haki Color To Buy"])

	SelectMaterial = Settings["Select Material"] or ""
	ChangeToggle(ConfigAutoFarmMaterial,Settings["Auto Farm Material"])

	ChangeToggle(ConfigAutoFarmDevilFruitMastery,Settings["Auto Farm Devil Fruit Mastery"])
	ChangeToggle(ConfigAutoFarmMasteryGun,Settings["Auto Farm Gun Mastery"])
	SelectWeaponSwordList = Settings["Select Sword List"] or {}
	SelectRaritySwordList = Settings["Select Rarity Sword List"] or {}
	MasteryWeaponList = Settings["Select Mastery Sword List"] or 600
	ChangeToggle(ConfigAutoFarmMasterySwordList,Settings["Auto Farm Sword Mastery List"])

	ChangeToggle(ConfigFastAttack,Settings["Fast Attack"])
	ChangeToggle(WhiteScreenOwo,Settings["White Screen"])
	ChangeToggle(ConfigGreaterteleportation,Settings["Greater Teleportation"])
	ChangeToggle(ConfigAutoObservationhaki,Settings["Auto Observation Haki"])
	ChangeToggle(ConfigAutoRejoin,Settings["Auto Rejoin"])

	ChangeToggle(ConfixSkillZ,Settings["Skill Z"])
	ChangeToggle(ConfixSkillX,Settings["Skill X"])
	ChangeToggle(ConfixSkillC,Settings["Skill C"])
	ChangeToggle(ConfixSkillV,Settings["Skill V"])
	ChangeToggle(ConfixSkillV,Settings["Skill F"])
	SkillZT = (_G.ConfigMain["Skill Z Time"] or 0.1)
	SkillXT = (_G.ConfigMain["Skill X Time"] or 0.1)
	SkillCT = (_G.ConfigMain["Skill C Time"] or 0.1)
	SkillVT = (_G.ConfigMain["Skill V Time"] or 0.1)

	ChangeToggle(ConfigAutoStatkaitan,Settings["Auto Stat kaitan"])
	ChangeToggle(ConfigStatsMelee,Settings["Melee"])
	ChangeToggle(ConfigStatsDefense,Settings["Defense"])
	ChangeToggle(ConfigStatsSword,Settings["Sword"])
	ChangeToggle(ConfigStatsGun,Settings["Gun"])
	ChangeToggle(ConfigStatsDemonFruit,Settings["Demon Fruit"])

	ChangeToggle(ConfigFarmAllBoss,Settings["Auto Farm All Boss"])
	SelectBoss = (Settings["Select Boss"] or "")
	ChangeToggle(ConfigAutoFarmBossHop,Settings["Auto Farm Boss Hop"])
	ChangeToggle(ConfigAutoFarmObservationHop,Settings["Auto Farm Observation Hop"])
	ChangeToggle(ConfigAutoOpenSaberRoom,Settings["Auto Open Saber Room"])
	ChangeToggle(ConfigAutoPole,Settings["Auto Pole V.1"])
	ChangeToggle(ConfigAutoPoleHop,Settings["Auto Pole V.1 [ HOP ]"])

	SelectLockBounty = (Settings["Select Lock Bounty"] or 100000000)
	ChangeToggle(ConfigStartLockBounty,Settings["Start Lock Bounty"])

	ChangeToggle(ConfigAutoFarmLaw,Settings["Auto Farm Law"])
	ChangeToggle(ConfigAutoQuestBartilo,Settings["Auto Quest Bartilo"])
	ChangeToggle(ConfigAutoQuestFlower,Settings["Auto Quest Flower"])
	ChangeToggle(ConfigAutoQuestV3,Settings["Auto Quest V3"])
	ChangeToggle(ConfigAutoRengoku,Settings["Auto Rengoku"])
	ChangeToggle(ConfigAutoGhoulR,Settings["Auto Ghoul Race"])
	ChangeToggle(ConfigAutoFarmEctoplasm,Settings["Auto Ghoul Race Hop"])
	ChangeToggle(ConfigAutoFarmEctoplasm,Settings["Auto Farm Ectoplasm"])
	ChangeToggle(ConfigAutoBuyBizarreRifle,Settings["Auto Buy Bizarre Rifle"])
	ChangeToggle(ConfigAutoBuyGhoulMask,Settings["Auto Buy Ghoul Mask"])
	ChangeToggle(ConfigAutoBuyMidnightBlade,Settings["Auto Buy Midnight Blade"])

	ChangeToggle(ConfigAutoMirageIsland,Settings["Auto Mirage Island"])
	ChangeToggle(ConfigAutoMirageIslandHop,Settings["Auto Mirage Island Hop"])
	ChangeToggle(ConfigAutoFullMoon,Settings["Auto Find Full Moon Hop"])
	ChangeToggle(ConfigAutoCursedDualKatana,Settings["Auto Cursed Dual Katana"])
	ChangeToggle(ConfigAutoCursedDualKatanaHop,Settings["Auto Cursed Dual Katana Hop"])
	ChangeToggle(ConfigAutoPirateRaids,Settings["Auto Pirate Raids"])
	ChangeToggle(ConfigAutoPirateRaidsHop,Settings["Auto Pirate Raids Hop"])
	ChangeToggle(ConfigAutoUnlockSoulGuitar,Settings["Auto Unlock SoulGuitar"])
	ChangeToggle(ConfigAutoUnlockSoulGuitarHop,Settings["Auto Unlock SoulGuitar Hop"])
	ChangeToggle(ConfigAutoDoughKing,Settings["Auto Dough King"])
	ChangeToggle(ConfigAutoUnlockDoughRaids,Settings["Auto Unlock Dough"])
	ChangeToggle(ConfigAutoUnlockDoughRaidsHop,Settings["Auto Unlock Dough Hop"])
	ChangeToggle(ConfigAutoBuddySwords,Settings["Auto Buddy Swords"])
	ChangeToggle(ConfigAutoBuddySwordsHop,Settings["Auto Buddy Swords HOP"])
	ChangeToggle(ConfigAutoFarmBone,Settings["Auto Farm Bone"])
	ChangeToggle(ConfigAutoHallowScythe,Settings["Auto Hallow Scythe"])
	ChangeToggle(ConfigAutoSoulReaper,Settings["Auto Farm Soul Reaper"])
	if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Bones", "Check") then
		ChangeToggle(ConfigRandomBone,Settings["Auto Random bone"])
	end
	ChangeToggle(ConfigCakePrince,Settings["Auto Farm Cake Prince"])
	ChangeToggle(ConfigAutoTushita,Settings["Auto Tushita"])
	ChangeToggle(ConfigAutoTushitaHop,Settings["Auto Tushita Hop"])
	ChangeToggle(ConfigEmma,Settings["Auto Enma/Yama"])
	ChangeToggle(ConfigEmmaHOP,Settings["Auto Enma/Yama HOP"])
	ChangeToggle(ConfigAutoEliteHunter,Settings["Auto Elite Hunter"])
	ChangeToggle(ConfigAutoEliteHunterHOP,Settings["Auto Elite Hunter HOP"])
	ChangeToggle(ConfigStopGodChalice,Settings["Stop if Got God's Chalice"])
	ChangeToggle(ConfigAutoHakiRainbow,Settings["Auto Haki Rainbow"])
	ChangeToggle(ConfigAutoMusketeeHat,Settings["Auto Musketee Hat"])
	ChangeToggle(ConfigAutoObservationHakiV2,Settings["Auto Observation Haki V2"])

	ChangeToggle(ConfigAutoFastMode,Settings["Auto Fast mode"])

	RaidsSelected = (Settings["Select Raids"] or "Flame")
	SelectedRaidsLabel:Options().Text = "Raids Selected : "..RaidsSelected
	ChangeToggle(ConfigAutoRaids,Settings["Auto Raids Hop"])

	ChangeToggle(ConfigAutoRandomDevilFruit,Settings["Auto Random Devil Fruit"])
	ChangeToggle(ConfigAutoStoreFruits,Settings["Auto Store Fruits"])
	ChangeToggle(ConfigBringDevilFruits,Settings["Bring Devil Fruit"])
	SelectLockFPS = (Settings["Select Lock FPS"] or 25)
	ChangeToggle(ConfigLockFPSNow,Settings["Lock FPS Now"])
end

if SelectConfig ~= "nil" and UConfig == false and AutoLoadConfig then
	spawn(function()
		LoadSetting(game:GetService("HttpService"):JSONDecode(readfile("RoyXHub_BF/" .. SelectConfig)))
	end)
end

if UConfig == true then
	spawn(function()
		LoadSetting(_G.ConfigMain)
	end)
end

SettingConfigPage:AddButton("Save Config",function()
	writefile("RoyXHub_BF/" .. SelectConfig,HttpService:JSONEncode(_G.ConfigMain))
end)
SettingConfigPage:AddButton("Load Config",function()
	spawn(function()
		LoadSetting(game:GetService("HttpService"):JSONDecode(readfile("RoyXHub_BF/" .. SelectConfig)))
	end)
end)
SettingConfigPage:AddButton("Reset Setting",function()
	writefile("RoyXHub_BF/" .. SelectConfig,HttpService:JSONEncode(DefaultConfig))
end)

SettingConfigPage:AddLabel("~ Hook Zone ~")

SettingConfigPage:AddButton("Hook My UserName With Profile",function()
	HookProfile[game.Players.LocalPlayer.Name] = SelectConfig
	writefile("RoyXHub_BF/HookProfile.json",HttpService:JSONEncode(HookProfile))
end)

SettingConfigPage:AddButton("Reset All Hook",function()
	HookProfile = {}
	writefile("RoyXHub_BF/HookProfile.json",HttpService:JSONEncode({}))
end)

for _,v in pairs(listfiles("RoyXHub_BF")) do
	if not RemoveSomeThing(v):find("Configs") and not RemoveSomeThing(v):find("HookProfile") then
		TableInsertNoDuplicates(TableConfigSelect,RemoveSomeThing(v))
		for i, v in pairs(TableConfigSelect) do
			ConfigSelected:Add(v)
		end
	end
end

if LPH_OBFUSCATED and AutoExecute then
	queue_on_teleport(([[
        setfpscap(200)
        fask.wait(0.5)
        pcall(function()
            writefile("a_temp/268.txt",tostring(os.time() + 10))
        end)
        _G.Key = "%s"
        _G.DiscordId = "%s"
        loadstring(game:HttpGet("https://raw.githubusercontent.com/markxd07/Lux-Sexy/main/Body.lua"))();
    ]]):format( (_G.Key or " "),( _G.DiscordId or " ") ))
end

Notify({
	Title = "Script RoyXHub_BF",
	Text = "Cracked By xZc & Hades",
	Timer = 15
},"Warn")
LoadingScriptSuccess = true
if RoyXUi and not _G.Auto_Close_ui then RoyXUi.Enabled = true end
