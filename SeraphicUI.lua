repeat task.wait() until game:IsLoaded()

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Mouse = LocalPlayer:GetMouse()

getgenv().Settings = {
    Name = "Luxury Hub | Premium Edition",
    DateType = 1,
    Logo = 16796144919,
    Key = Enum.KeyCode.RightControl
}

function MakeDraggable(topbarobject, object)
	local Dragging = nil
	local DragInput = nil	
	local DragStart = nil
	local StartPosition = nil

	local function Update(input)
		local Delta = input.Position - DragStart
		local pos = UDim2.new(StartPosition.X.Scale,StartPosition.X.Offset + Delta.X,StartPosition.Y.Scale,StartPosition.Y.Offset + Delta.Y)
		local Tween = TweenService:Create(object, TweenInfo.new(.1), {Position = pos})
		Tween:Play()
	end

	topbarobject.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			Dragging = true
			DragStart = input.Position
			StartPosition = object.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					Dragging = false
				end
			end)
		end
	end)

	topbarobject.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			DragInput = input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input == DragInput and Dragging then
			Update(input)
		end
	end)
end

function tween(object,waits,...)
	TweenService:Create(object,TweenInfo.new(waits,Enum.EasingStyle.Quad),...):Play()
end

local ActualTypes = {
	RoundFrame = "ImageLabel",
	Shadow = "ImageLabel",
	Circle = "ImageLabel",
	CircleButton = "ImageButton",
	Frame = "Frame",
	Label = "TextLabel",
	Button = "TextButton",
	SmoothButton = "ImageButton",
	Box = "TextBox",
	ScrollingFrame = "ScrollingFrame",
	Menu = "ImageButton",
	NavBar = "ImageButton"
}

local Properties = {
	RoundFrame = {
		BackgroundTransparency = 1,
		Image = "http://www.roblox.com/asset/?id=5554237731",
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(3,3,297,297)
	},
	SmoothButton = {
		AutoButtonColor = false,
		BackgroundTransparency = 1,
		Image = "http://www.roblox.com/asset/?id=5554237731",
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(3,3,297,297)
	},
	Shadow = {
		Name = "Shadow",
		BackgroundTransparency = 1,
		Image = "http://www.roblox.com/asset/?id=5554236805",
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(23,23,277,277),
		Size = UDim2.fromScale(1,1) + UDim2.fromOffset(30,30),
		Position = UDim2.fromOffset(-15,-15)
	},
	Circle = {
		BackgroundTransparency = 1,
		Image = "http://www.roblox.com/asset/?id=5554831670"
	},
	CircleButton = {
		BackgroundTransparency = 1,
		AutoButtonColor = false,
		Image = "http://www.roblox.com/asset/?id=5554831670"
	},
	Frame = {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.fromScale(1,1)
	},
	Label = {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(5,0),
		Size = UDim2.fromScale(1,1) - UDim2.fromOffset(5,0),
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left
	},
	Button = {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(5,0),
		Size = UDim2.fromScale(1,1) - UDim2.fromOffset(5,0),
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left
	},
	Box = {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(5,0),
		Size = UDim2.fromScale(1,1) - UDim2.fromOffset(5,0),
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left
	},
	ScrollingFrame = {
		BackgroundTransparency = 1,
		ScrollBarThickness = 0,
		CanvasSize = UDim2.fromScale(0,0),
		Size = UDim2.fromScale(1,1)
	},
	Menu = {
		Name = "More",
		AutoButtonColor = false,
		BackgroundTransparency = 1,
		Image = "http://www.roblox.com/asset/?id=5555108481",
		Size = UDim2.fromOffset(20,20),
		Position = UDim2.fromScale(1,0.5) - UDim2.fromOffset(25,10)
	},
	NavBar = {
		Name = "SheetToggle",
		Image = "http://www.roblox.com/asset/?id=5576439039",
		BackgroundTransparency = 1,
		Size = UDim2.fromOffset(20,20),
		Position = UDim2.fromOffset(5,5),
		AutoButtonColor = false
	}
}

local Types = {
	"RoundFrame",
	"Shadow",
	"Circle",
	"CircleButton",
	"Frame",
	"Label",
	"Button",
	"SmoothButton",
	"Box",
	"ScrollingFrame",
	"Menu",
	"NavBar"
}

function RefreshUi(args)
    if game:GetService("CoreGui"):FindFirstChild(args) then 
        game:GetService("CoreGui"):FindFirstChild(args):Destroy() 
    end 
end

RefreshUi("Seraphic")
RefreshUi("Seraphic_MUI")

local ScreenGui = Instance.new("ScreenGui")
local ImageButton = Instance.new("ImageButton")
local MiniCorner = Instance.new("UICorner")
ScreenGui.Name = "Seraphic_MUI"
ScreenGui.Parent = game.CoreGui
ImageButton.Parent = ScreenGui
ImageButton.Position = UDim2.new(0.120833337, 0, 0.0952890813, 0)
ImageButton.Size = UDim2.new(0, 50, 0, 50)
ImageButton.Image = "rbxassetid://"..getgenv().Settings.Logo
ImageButton.Draggable = true
ImageButton.Name = "MiniINTERFACE"
ImageButton.BackgroundColor3 = Color3.new(0, 0, 0)
ImageButton.MouseButton1Down:connect(function()
	game:GetService("VirtualInputManager"):SendKeyEvent(true,"RightControl",false,game)
	game:GetService("VirtualInputManager"):SendKeyEvent(false,"RightControl",false,game)
end)


MiniCorner.CornerRadius = UDim.new(0, 5)
MiniCorner.Parent = ImageButton

function FindType(String)
	for _, Type in next, Types do
		if Type:sub(1, #String):lower() == String:lower() then
			return Type
		end
	end
	return false
end

local Objects = {}

function Objects.new(Type)
	local TargetType = FindType(Type)
	if TargetType then
		local NewImage = Instance.new(ActualTypes[TargetType])
		if Properties[TargetType] then
			for Property, Value in next, Properties[TargetType] do
				NewImage[Property] = Value
			end
		end
		return NewImage
	else
		return Instance.new(Type)
	end
end

function GetXY(GuiObject)
	local Max, May = GuiObject.AbsoluteSize.X, GuiObject.AbsoluteSize.Y
	local Px, Py = math.clamp(Mouse.X - GuiObject.AbsolutePosition.X, 0, Max), math.clamp(Mouse.Y - GuiObject.AbsolutePosition.Y, 0, May)
	return Px/Max, Py/May
end

function CircleAnim(GuiObject, EndColour, StartColour)
	local PX, PY = GetXY(GuiObject)
	local Circle = Objects.new("Shadow")
	Circle.Size = UDim2.fromScale(0,0)
	Circle.Position = UDim2.fromScale(PX,PY)
	Circle.ImageColor3 = StartColour or GuiObject.ImageColor3
	Circle.ZIndex = 200
	Circle.Parent = GuiObject
	local Size = GuiObject.AbsoluteSize.X
	TweenService:Create(Circle, TweenInfo.new(0.5), {Position = UDim2.fromScale(PX,PY) - UDim2.fromOffset(Size/2,Size/2), ImageTransparency = 1, ImageColor3 = EndColour, Size = UDim2.fromOffset(Size,Size)}):Play()
	spawn(function()
		wait(0.5)
		Circle:Destroy()
	end)
end


function Ripple(obj)
	spawn(function()
		local Mouse = game.Players.LocalPlayer:GetMouse()
		local Circle = Instance.new("ImageLabel")
		Circle.Name = "CiRainbowModeColorValuercle"
		Circle.Parent = obj
		Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Circle.BackgroundTransparency = 1.000
		Circle.ZIndex = 10
		Circle.Image = "rbxassetid://266543268"
		Circle.ImageColor3 = Color3.fromRGB(255, 255, 255)
		Circle.ImageTransparency = 0.5
		local NewX, NewY = Mouse.X - Circle.AbsolutePosition.X, Mouse.Y - Circle.AbsolutePosition.Y
		Circle.Position = UDim2.new(0, NewX, 0, NewY)
		local Size = 0
		if obj.AbsoluteSize.X > obj.AbsoluteSize.Y then
			Size = obj.AbsoluteSize.X * 1.5
		elseif obj.AbsoluteSize.X < obj.AbsoluteSize.Y then
			Size = obj.AbsoluteSize.Y * 1.5
		elseif obj.AbsoluteSize.X == obj.AbsoluteSize.Y then
			Size = obj.AbsoluteSize.X * 1.5
		end
		Circle:TweenSizeAndPosition(UDim2.new(0, Size, 0, Size),UDim2.new(0.5, -Size / 2, 0.5, -Size / 2),"Out","Quad",1.2,false)
		for i = 1, 20 do
			Circle.ImageTransparency = Circle.ImageTransparency + 0.1
			wait(.5 / 10)
		end
		Circle:Destroy()
	end)
end

function GetDate(med)
	GetSubPrefix = function(d)
	local d = tostring(d):gsub(" ","")
	local M = ""
		if #d == 2 then 
			local N = string.sub(d, #d ,#d + 1)
			M = N == "1" and "st" or N== "2" and "nd"or N == "3" and "rd" or "th"
		end
		return M
	end
	local E = "%A, %B"
	local P = os.date(" %d",os.time())
	local Q = ", %Y."

	function formatdate()
		local timeTable = os.date("*t")
		
		local days = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"}
		local months = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"}
		
		local formattedDate = string.format("%d %s %d", timeTable.day, months[timeTable.month], timeTable.year)
		
		return formattedDate
	end

	if med == 1 then
		Date = os.date(E, os.time())..P..GetSubPrefix(P)..os.date(Q,os.time())
	elseif med == 2 then
		Date = os.date('%Y-%m-%d').." #[ "..formatdate().." ]"
	end
	return Date
end

local Seraphic = Instance.new("ScreenGui")

Seraphic.Name = "Seraphic"
Seraphic.Parent = game:GetService("CoreGui")
Seraphic.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local Library = {}

function Library:Init()
	local FocusUI = false
	local PageOrders = -1

	local MainFrame = Instance.new("Frame")
	local Logo2 = Instance.new("ImageButton")
	local TopBar = Instance.new("Frame")
	local Logo = Instance.new("ImageButton")
	local NameHub = Instance.new("TextLabel")
	local Date = Instance.new("TextLabel")
	local TopBarUICorner = Instance.new("UICorner")
	local Welcome = Instance.new("TextLabel")
	local Name = Instance.new("TextLabel")
	local Hub = Instance.new("TextLabel")
	local DiscordFrame = Instance.new("Frame")
	local JoinDiscord = Instance.new("TextButton")
	local DiscordUICorner = Instance.new("UICorner")
    local KillUiFrame = Instance.new("Frame")
    local KillUi = Instance.new("TextButton")
	local KillUiCorner = Instance.new("UICorner")

	MainFrame.Name = "MainFrame"
	MainFrame.Parent = Seraphic
	MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	MainFrame.BorderSizePixel = 0
	MainFrame.ClipsDescendants = true
	MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
	MainFrame.Size = UDim2.new(0, 0, 0, 0)

	local MainFrameStroke = Instance.new("UIStroke")

	MainFrameStroke.Parent = MainFrame
	MainFrameStroke.Thickness = 1
	MainFrameStroke.LineJoinMode = Enum.LineJoinMode.Round
	MainFrameStroke.Color = Color3.fromRGB(213, 192, 255)
	MainFrameStroke.Transparency = 0
	
	local MainUICorner = Instance.new("UICorner")
	
	MainUICorner.CornerRadius = UDim.new(0, 9)
	MainUICorner.Name = "MainUICorner"
	MainUICorner.Parent = MainFrame

	TweenService:Create(MainFrame,TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{Size = UDim2.new(0, 573, 0, 363)}):Play()
	
	TopBar.Name = "TopBar"
	TopBar.Parent = MainFrame
	TopBar.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
	TopBar.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TopBar.BorderSizePixel = 0
	TopBar.Size = UDim2.new(0, 573, 0, 47)
	
	Logo.Name = "Logo"
	Logo.Parent = TopBar
	Logo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Logo.BackgroundTransparency = 1.000
	Logo.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Logo.BorderSizePixel = 0
	Logo.Position = UDim2.new(0.907267511, 0, -0.0213967189, 0)
	Logo.Size = UDim2.new(0, 47, 0, 47)
	Logo.Image = "rbxassetid://"..tostring(getgenv().Settings.Logo)
    Logo.Rotation = -3.5
    
	NameHub.Name = "NameHub"
	NameHub.Parent = TopBar
	NameHub.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	NameHub.BackgroundTransparency = 1.000
	NameHub.BorderColor3 = Color3.fromRGB(0, 0, 0)
	NameHub.BorderSizePixel = 0
	NameHub.Position = UDim2.new(0.0294169206, 0, 0.0693395063, 0)
	NameHub.Size = UDim2.new(0, 242, 0, 40)
	NameHub.Font = Enum.Font.GothamBold
	NameHub.Text = getgenv().Settings.Name or "Seraphic Hub | Premium Edition"
	NameHub.TextColor3 = Color3.fromRGB(255, 255, 255)
	NameHub.TextSize = 16.000
	NameHub.TextXAlignment = Enum.TextXAlignment.Left
	
	Date.Name = "Date"
	Date.Parent = TopBar
	Date.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Date.BackgroundTransparency = 1.000
	Date.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Date.BorderSizePixel = 0
	Date.Position = UDim2.new(0.552036524, 0, 0.0693395063, 0)
	Date.Size = UDim2.new(0, 200, 0, 40)
	Date.Font = Enum.Font.GothamBold
	Date.Text = GetDate(getgenv().Settings.DateType)
	Date.TextColor3 = Color3.fromRGB(255, 255, 255)
	Date.TextSize = 16.000
	Date.TextTransparency = 0.500
	Date.TextXAlignment = Enum.TextXAlignment.Right
	
	TopBarUICorner.CornerRadius = UDim.new(0, 9)
	TopBarUICorner.Name = "TopBarUICorner"
	TopBarUICorner.Parent = TopBar
	
	Welcome.Name = "Welcome"
	Welcome.Parent = MainFrame
	Welcome.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Welcome.BackgroundTransparency = 1.000
	Welcome.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Welcome.BorderSizePixel = 0
	Welcome.Position = UDim2.new(0.0471204184, 0, 0.170798898, 0)
	Welcome.Size = UDim2.new(0, 200, 0, 50)
	Welcome.Font = Enum.Font.GothamBold
	Welcome.Text = "Welcome To"
	Welcome.TextColor3 = Color3.fromRGB(255, 255, 255)
	Welcome.TextScaled = true
	Welcome.TextSize = 14.000
	Welcome.TextWrapped = true
	Welcome.TextTransparency = 1

	Name.Name = "Name"
	Name.Parent = MainFrame
	Name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Name.BackgroundTransparency = 1.000
	Name.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Name.BorderSizePixel = 0
	Name.Position = UDim2.new(0.13438046, 0, 0.308539957, 0)
	Name.Size = UDim2.new(0, 160, 0, 50)
	Name.Font = Enum.Font.GothamBold
	Name.Text = "Seraphic"
	Name.TextColor3 = Color3.fromRGB(255, 255, 255)
	Name.TextScaled = true
	Name.TextSize = 14.000
	Name.TextWrapped = true
	Name.TextXAlignment = Enum.TextXAlignment.Left
	Name.TextTransparency = 1

	Hub.Name = "Hub"
	Hub.Parent = MainFrame
	Hub.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Hub.BackgroundTransparency = 1.000
	Hub.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Hub.BorderSizePixel = 0
	Hub.Position = UDim2.new(0.413612574, 0, 0.308539957, 0)
	Hub.Size = UDim2.new(0, 80, 0, 50)
	Hub.Font = Enum.Font.GothamBold
	Hub.Text = "Hub"
	Hub.TextColor3 = Color3.fromRGB(134, 126, 180)
	Hub.TextScaled = true
	Hub.TextSize = 14.000
	Hub.TextWrapped = true
	Hub.TextXAlignment = Enum.TextXAlignment.Left
	Hub.TextTransparency = 1

	DiscordFrame.Name = "DiscordFrame"
	DiscordFrame.Parent = MainFrame
	DiscordFrame.BackgroundColor3 = Color3.fromRGB(50, 44, 62)
	DiscordFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    DiscordFrame.BackgroundTransparency = 1
	DiscordFrame.BorderSizePixel = 0
	DiscordFrame.ClipsDescendants = true
	DiscordFrame.Position = UDim2.new(0.13438046, 0, 0.498622596, 0)
	DiscordFrame.Size = UDim2.new(0, 175, 0, 35)
	
	JoinDiscord.Name = "JoinDiscord"
	JoinDiscord.Parent = DiscordFrame
	JoinDiscord.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	JoinDiscord.BackgroundTransparency = 1.000
	JoinDiscord.BorderColor3 = Color3.fromRGB(0, 0, 0)
	JoinDiscord.BorderSizePixel = 0
	JoinDiscord.Size = UDim2.new(0, 175, 0, 35)
	JoinDiscord.Font = Enum.Font.GothamBold
	JoinDiscord.Text = "Rejoin Server"
	JoinDiscord.TextColor3 = Color3.fromRGB(255, 255, 255)
	JoinDiscord.TextSize = 16.000
	JoinDiscord.TextWrapped = true
	JoinDiscord.TextTransparency = 1
	JoinDiscord.MouseButton1Click:connect(function()
		Ripple(JoinDiscord)
		wait(1.5)
		local ts = game:GetService("TeleportService")
		local p = game:GetService("Players").LocalPlayer
		ts:TeleportToPlaceInstance(game.PlaceId,game.JobId, p)
	end)
    
	DiscordUICorner.CornerRadius = UDim.new(1, 0)
	DiscordUICorner.Name = "DiscordUICorner"
	DiscordUICorner.Parent = DiscordFrame

	local DiscordFrameStroke = Instance.new("UIStroke")

	DiscordFrameStroke.Parent = DiscordFrame
	DiscordFrameStroke.Thickness = 1
	DiscordFrameStroke.LineJoinMode = Enum.LineJoinMode.Round
	DiscordFrameStroke.Color = Color3.fromRGB(154, 131, 186)
	DiscordFrameStroke.Transparency = 1

	Logo2.Name = "Logo2"
	Logo2.Parent = MainFrame
	Logo2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Logo2.BackgroundTransparency = 1.000
	Logo2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Logo2.BorderSizePixel = 0
	Logo2.Position = UDim2.new(0.0471204184, 0, 0.170798898, 0)
	Logo2.Size = UDim2.new(0, 200, 0, 200)
	Logo2.Image = "rbxassetid://"..tostring(getgenv().Settings.Logo)
    Logo2.Rotation = 180

	KillUiFrame.Name = "KillUiFrame"
	KillUiFrame.Parent = MainFrame
	KillUiFrame.BackgroundColor3 = Color3.fromRGB(50, 44, 62)
	KillUiFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    KillUiFrame.BackgroundTransparency = 1
	KillUiFrame.BorderSizePixel = 0
	KillUiFrame.ClipsDescendants = true
	KillUiFrame.Position = UDim2.new(0.634613931, 0, 0.25, 0)
	KillUiFrame.Size = UDim2.new(0, 175, 0, 35)
	KillUiFrame.Visible = false

	KillUi.Name = "KillUi"
	KillUi.Parent = KillUiFrame
	KillUi.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	KillUi.BackgroundTransparency = 1.000
	KillUi.BorderColor3 = Color3.fromRGB(0, 0, 0)
	KillUi.BorderSizePixel = 0
	KillUi.Size = UDim2.new(0, 175, 0, 35)
	KillUi.Font = Enum.Font.GothamBold
	KillUi.Text = "Destroy Ui"
	KillUi.TextColor3 = Color3.fromRGB(255, 255, 255)
	KillUi.TextSize = 16.000
	KillUi.TextWrapped = true
	KillUi.TextTransparency = 1
    
	KillUiCorner.CornerRadius = UDim.new(1, 0)
	KillUiCorner.Name = "KillUiCorner"
	KillUiCorner.Parent = KillUiFrame

	-- local KillUiFrameStroke = Instance.new("UIStroke")

	-- KillUiFrameStroke.Parent = KillUiFrame
	-- KillUiFrameStroke.Thickness = 1
	-- KillUiFrameStroke.LineJoinMode = Enum.LineJoinMode.Round
	-- KillUiFrameStroke.Color = Color3.fromRGB(154, 131, 186)
	-- KillUiFrameStroke.Transparency = 1

    -- local RejoinUiFrame = Instance.new("Frame")
    -- local RejoinButton = Instance.new("TextButton")
    -- local RejoinCorner = Instance.new("UICorner")

	-- RejoinUiFrame.Name = "RejoinUiFrame"
	-- RejoinUiFrame.Parent = MainFrame
	-- RejoinUiFrame.BackgroundColor3 = Color3.fromRGB(50, 44, 62)
	-- RejoinUiFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    -- RejoinUiFrame.BackgroundTransparency = 1
	-- RejoinUiFrame.BorderSizePixel = 0
	-- RejoinUiFrame.ClipsDescendants = true
	-- RejoinUiFrame.Position = UDim2.new(0.634613931, 0, 0.45, 0)
	-- RejoinUiFrame.Size = UDim2.new(0, 175, 0, 35)
	-- RejoinUiFrame.Visible = false

	-- RejoinButton.Name = "KillUi"
	-- RejoinButton.Parent = RejoinUiFrame
	-- RejoinButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	-- RejoinButton.BackgroundTransparency = 1.000
	-- RejoinButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	-- RejoinButton.BorderSizePixel = 0
	-- RejoinButton.Size = UDim2.new(0, 175, 0, 35)
	-- RejoinButton.Font = Enum.Font.GothamBold
	-- RejoinButton.Text = "Rejoin"
	-- RejoinButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	-- RejoinButton.TextSize = 16.000
	-- RejoinButton.TextWrapped = true
	-- RejoinButton.TextTransparency = 1
    
	-- RejoinCorner.CornerRadius = UDim.new(1, 0)
	-- RejoinCorner.Name = "RejoinCorner"
	-- RejoinCorner.Parent = RejoinUiFrame

	-- local RejoinUiFrameStroke = Instance.new("UIStroke")

	-- RejoinUiFrameStroke.Parent = RejoinUiFrame
	-- RejoinUiFrameStroke.Thickness = 1
	-- RejoinUiFrameStroke.LineJoinMode = Enum.LineJoinMode.Round
	-- RejoinUiFrameStroke.Color = Color3.fromRGB(154, 131, 186)
	-- RejoinUiFrameStroke.Transparency = 1

    -- local NotificationInterface = loadstring(game:HttpGet("https://raw.githubusercontent.com/Jxereas/UI-Libraries/main/notification_gui_library.lua", true))()

    -- KillUiEnable = false
    -- KillUiState = 0
    -- KillUi.MouseButton1Click:Connect(function()
    --     KillUiState = KillUiState + 1
    --     if KillUiState == 1 and KillUiEnable == false then
    --         KillUi.Text = "Are you Sure?"
    --         TweenService:Create(
    --             KillUiFrameStroke,
    --             TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
    --             {Color = Color3.fromRGB(255, 45, 0)}
    --         ):Play()
    --         KillUiEnable = true
    --     elseif KillUiEnable == true then
    --         TweenService:Create(
    --             KillUiFrameStroke,
    --             TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
    --             {Color = Color3.fromRGB(21, 255, 0)}
    --         ):Play()
    --         KillUi.Text = "Process..."

    --         NotificationInterface.new("Warning", "Seraphic", "Destroy Seraphic Ui in 3 seconds"):deleteTimeout(3)
    --         wait(1)
    --         NotificationInterface.new("Warning", "Seraphic", "Destroy Seraphic Ui in 2 seconds"):deleteTimeout(3)
    --         wait(1)
    --         NotificationInterface.new("Warning", "Seraphic", "Destroy Seraphic Ui in 1 second"):deleteTimeout(3)
    --         wait(1)
    --         RefreshUi("Seraphic")
    --         RefreshUi("Seraphic_MUI")
    --     end
    -- end)

    -- RejoinEnable = false
    -- RejoinState = 0
    -- RejoinButton.MouseButton1Click:Connect(function()
    --     RejoinState = RejoinState + 1
    --     if RejoinState == 1 and RejoinEnable == false then
    --         RejoinButton.Text = "Are you Sure?"
    --         TweenService:Create(
    --             RejoinUiFrameStroke,
    --             TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
    --             {Color = Color3.fromRGB(255, 45, 0)}
    --         ):Play()
    --         RejoinEnable = true
    --     elseif RejoinEnable == true then
    --         TweenService:Create(
    --             RejoinUiFrameStroke,
    --             TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
    --             {Color = Color3.fromRGB(21, 255, 0)}
    --         ):Play()
    --         RejoinButton.Text = "Process..."
    --         NotificationInterface.new("Warning", "Seraphic", "Rejoin Server in 3 seconds"):deleteTimeout(3)
    --         wait(1)
    --         NotificationInterface.new("Warning", "Seraphic", "Rejoin Server in 2 seconds"):deleteTimeout(3)
    --         wait(1)
    --         NotificationInterface.new("Warning", "Seraphic", "Rejoin Server in 1 second"):deleteTimeout(3)
    --         wait(1)
    --         local ts = game:GetService("TeleportService")
    --         local p = game:GetService("Players").LocalPlayer
    --         ts:TeleportToPlaceInstance(game.PlaceId,game.JobId, p)
    --         RejoinState = 0
    --     end
    -- end)

    -- KillUi.MouseEnter:Connect(function()
    --     TweenService:Create(
    --         KillUiFrameStroke,
    --         TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
    --         {Transparency = 0}
    --     ):Play()
    -- end)

    -- RejoinButton.MouseEnter:Connect(function()
    --     TweenService:Create(
    --         RejoinUiFrameStroke,
    --         TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
    --         {Transparency = 0}
    --     ):Play()
    -- end)

    -- KillUi.MouseLeave:Connect(function()
    --     TweenService:Create(
    --         KillUiFrameStroke,
    --         TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
    --         {Transparency = 0.5}
    --     ):Play()
    -- end)

    -- RejoinButton.MouseLeave:Connect(function()
    --     TweenService:Create(
    --         RejoinUiFrameStroke,
    --         TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
    --         {Transparency = 0.5}
    --     ):Play()
    -- end)

    function TitlePage(med)
        TweenService:Create(
            Welcome,
            TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
            {TextTransparency = med}
        ):Play()

        wait(1)
        TweenService:Create(
            Name,
            TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
            {TextTransparency = med}
        ):Play()
        TweenService:Create(
            Hub,
            TweenInfo.new(0.75, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
            {TextTransparency = med}
        ):Play()
        wait(1)
        TweenService:Create(
            DiscordFrame,
            TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
            {BackgroundTransparency = med}
        ):Play()
        wait(0.75)
        TweenService:Create(
            DiscordFrameStroke,
            TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
            {Transparency = med}
        ):Play()
        TweenService:Create(
            JoinDiscord,
            TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
            {TextTransparency = med}
        ):Play()
    end


    local State = false
    Logo2.MouseButton1Click:connect(function()
        if State == false then
            Date.Text = 'Information'
            TitlePage(1)
            TweenService:Create(
                Logo2,
                TweenInfo.new(2.5, Enum.EasingStyle.Back, Enum.EasingDirection.In),
                {Rotation = -90.5}
            ):Play()
            TweenService:Create(
                Logo2,
                TweenInfo.new(2.5, Enum.EasingStyle.Back, Enum.EasingDirection.In),
                {Position = UDim2.new(0.3200, 0, 0.134844989, 0)}
            ):Play()
            TweenService:Create(
                Logo2,
                TweenInfo.new(2.5, Enum.EasingStyle.Back, Enum.EasingDirection.In),
                {ImageTransparency = 0.5}
            ):Play()
            State = true
        elseif State == true then
            Date.Text = GetDate(getgenv().Settings.DateType)
            TweenService:Create(
                Logo2,
                TweenInfo.new(2.5, Enum.EasingStyle.Back, Enum.EasingDirection.In),
                {ImageTransparency = 0.00}
            ):Play()
            TweenService:Create(
                Logo2,
                TweenInfo.new(2.5, Enum.EasingStyle.Back, Enum.EasingDirection.In),
                {Rotation = -3.5}
            ):Play()
            TweenService:Create(
                Logo2,
                TweenInfo.new(2.5, Enum.EasingStyle.Back, Enum.EasingDirection.In),
                {Position = UDim2.new(0.634613931, 0, 0.134844989, 0)}
            ):Play()
            wait(2.7)
            TitlePage(0)
            State = false
        end
    end)

    -- ClickWave = 0
    -- State2 = false
    -- Logo.MouseButton1Click:connect(function()
    --     ClickWave = ClickWave + 1
    --     Date.Text = ClickWave
    --     if ClickWave == 2 then
    --         Date.Text = 'Settings'
    --         TweenService:Create(
    --             Logo,
    --             TweenInfo.new(6, Enum.EasingStyle.Back, Enum.EasingDirection.InOut),
    --             {Rotation = 720}
    --         ):Play()
    --         if State2 == false then
    --             TitlePage(1)
    --             TweenService:Create(
    --                 Logo2,
    --                 TweenInfo.new(2.5, Enum.EasingStyle.Back, Enum.EasingDirection.InOut),
    --                 {Rotation = -183.5}
    --             ):Play()
    --             TweenService:Create(
    --                 Logo2,
    --                 TweenInfo.new(2.5, Enum.EasingStyle.Back, Enum.EasingDirection.In),
    --                 {Position = UDim2.new(0.0471204184, 0, 0.134844989, 0)}
    --             ):Play()
    --             wait(2.7)
    --             KillUiFrame.Visible = true
    --             TweenService:Create(
    --                 KillUiFrame,
    --                 TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut),
    --                 {BackgroundTransparency = 0}
    --             ):Play()
    --             wait(0.75)
    --             TweenService:Create(
    --                 KillUiFrameStroke,
    --                 TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
    --                 {Transparency = 0.5}
    --             ):Play()
    --             TweenService:Create(
    --                 KillUi,
    --                 TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
    --                 {TextTransparency = 0}
    --             ):Play()
    --             RejoinUiFrame.Visible = true
    --             TweenService:Create(
    --                 RejoinUiFrame,
    --                 TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut),
    --                 {BackgroundTransparency = 0}
    --             ):Play()
    --             wait(0.75)
    --             TweenService:Create(
    --                 RejoinUiFrameStroke,
    --                 TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
    --                 {Transparency = 0.5}
    --             ):Play()
    --             TweenService:Create(
    --                 RejoinButton,
    --                 TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
    --                 {TextTransparency = 0}
    --             ):Play()
    --             State2 = true
    --             ClickWave = ClickWave - 2
    --         elseif State2 == true then
    --             Date.Text = 'Exit Settings'
    --             TweenService:Create(
    --                 Logo2,
    --                 TweenInfo.new(2.5, Enum.EasingStyle.Back, Enum.EasingDirection.InOut),
    --                 {Rotation = -3.5}
    --             ):Play()
    --             TweenService:Create(
    --                 Logo2,
    --                 TweenInfo.new(2.5, Enum.EasingStyle.Back, Enum.EasingDirection.In),
    --                 {Position = UDim2.new(0.634613931, 0, 0.134844989, 0)}
    --             ):Play()
    --             TweenService:Create(
    --                 KillUiFrame,
    --                 TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut),
    --                 {BackgroundTransparency = 1}
    --             ):Play()
    --             wait(0.75)
    --             TweenService:Create(
    --                 KillUiFrameStroke,
    --                 TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
    --                 {Transparency = 1}
    --             ):Play()
    --             TweenService:Create(
    --                 KillUi,
    --                 TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
    --                 {TextTransparency = 1}
    --             ):Play()
    --             KillUiFrame.Visible = false
    --             TweenService:Create(
    --                 RejoinUiFrame,
    --                 TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut),
    --                 {BackgroundTransparency = 1}
    --             ):Play()
    --             wait(0.75)
    --             TweenService:Create(
    --                 RejoinUiFrameStroke,
    --                 TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
    --                 {Transparency = 1}
    --             ):Play()
    --             TweenService:Create(
    --                 RejoinButton,
    --                 TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
    --                 {TextTransparency = 1}
    --             ):Play()
    --             RejoinUiFrame.Visible = false
    --             wait(2.7)
    --             TitlePage(0)
    --             State2 = false
    --             ClickWave = 0
    --             Date.Text = GetDate(getgenv().Settings.DateType)
    --         end
    --     end
    -- end)

    function LogoRotation()
        -- Logo 
		TweenService:Create(
	        Logo2,
            TweenInfo.new(2.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
            {Rotation = -3.5}
		):Play()
        TweenService:Create(
	        Logo2,
            TweenInfo.new(2.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
            {Position = UDim2.new(0.634613931, 0, 0.134844989, 0)}
		):Play()
        wait(2.7)
        TitlePage(0)
    end
    LogoRotation()

	MakeDraggable(MainFrame,MainFrame)

	local ScrollingTab = Instance.new("ScrollingFrame")

	ScrollingTab.Parent = MainFrame
	ScrollingTab.Active = true
	ScrollingTab.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	ScrollingTab.BackgroundTransparency = 1.000
	ScrollingTab.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ScrollingTab.BorderSizePixel = 0
	ScrollingTab.Position = UDim2.new(0.0471204184, 0, 0.691460073, 0)
	ScrollingTab.Size = UDim2.new(1, 0, 1, 0)
	ScrollingTab.CanvasSize = UDim2.new(0, 91, 0, 0)
	ScrollingTab.ScrollBarThickness = 3

	local UIListLayout_2 = Instance.new("UIListLayout")
	local UIPadding = Instance.new("UIPadding")

	UIListLayout_2.Parent = ScrollingTab
	UIListLayout_2.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout_2.Padding = UDim.new(0, 5)

	UIPadding.Parent = ScrollingTab
	UIPadding.PaddingLeft = UDim.new(0, 5)
	UIPadding.PaddingTop = UDim.new(0, 5)


	local Pages = Instance.new("Frame")
	local pagesfolder = Instance.new("Folder")
	local UIPageLayout = Instance.new("UIPageLayout")
	
	Pages.Name = "Pages"
	Pages.Parent = MainFrame
	Pages.AnchorPoint = Vector2.new(0.5, 0.5)
	Pages.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Pages.BackgroundTransparency = 1.000
	Pages.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Pages.BorderSizePixel = 0
	Pages.Position = UDim2.new(0.509598613, 0, 0.564738274, 0)
	Pages.Size = UDim2.new(0, 573, 0, 316)
	
	pagesfolder.Name = "pagesfolder"
	pagesfolder.Parent = Pages

	UIPageLayout.Parent = pagesfolder
	UIPageLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIPageLayout.EasingDirection = Enum.EasingDirection.InOut
	UIPageLayout.EasingStyle = Enum.EasingStyle.Quad
	UIPageLayout.Padding = UDim.new(0, 10)
	UIPageLayout.ScrollWheelInputEnabled = false
	UIPageLayout.TouchInputEnabled = false
	UIPageLayout.TweenTime = 0.200

	local uitoggled = false
	UserInputService.InputBegan:Connect(function(io, p)
		if io.KeyCode == getgenv().Settings.Key then
			if uitoggled == false then
				uitoggled = true
				TweenService:Create(
					MainFrame,
					TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
					{Size = UDim2.new(0, 0, 0, 0)}
				):Play()
			else
				TweenService:Create(
					MainFrame,
					TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
					{Size = UDim2.new(0, 573, 0, 363)}
				):Play()
				repeat wait() 
				until MainFrame.Size == UDim2.new(0, 573, 0, 363)
				uitoggled = false
			end
		end
	end)

	local LibraryTab = {}

	function LibraryTab:CreateTap(Title,Desc,Image)
		PageOrders = PageOrders + 1

		local name = tostring(Title) or tostring(math.random(500,100000))
		local description = tostring(Desc) or tostring(math.random(500,100000))
		local img = tostring(Image) or "http://www.roblox.com/asset/?id=6023565895"


		local Tab1 = Instance.new("Frame")
		local Tab1UICorner = Instance.new("UICorner")
		local Click = Instance.new("TextButton")
		local imagetab = Instance.new("ImageLabel")
		local Title = Instance.new("TextLabel")
		local Desc = Instance.new("TextLabel")

		Tab1.Name = name.."Tab1"
		Tab1.Parent = ScrollingTab
		Tab1.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        Tab1.BackgroundTransparency = 0.75
		Tab1.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Tab1.BorderSizePixel = 0
		Tab1.Size = UDim2.new(0, 177, 0, 80)
		Tab1.ClipsDescendants = true

		Tab1UICorner.CornerRadius = UDim.new(0, 12)
		Tab1UICorner.Name = "Tab1UICorner"
		Tab1UICorner.Parent = Tab1
		
		Click.Name = "Click"
		Click.Parent = Tab1
		Click.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Click.BackgroundTransparency = 1.000
		Click.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Click.BorderSizePixel = 0
		Click.Position = UDim2.new(-0.00564971752, 0, 0, 0)
		Click.Size = UDim2.new(0, 177, 0, 80)
		Click.Font = Enum.Font.Gotham
		Click.Text = ""
		Click.TextColor3 = Color3.fromRGB(0, 0, 0)
		Click.TextSize = 14.000
		
		imagetab.Name = "imagetab"
		imagetab.Parent = Click
		imagetab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		imagetab.BackgroundTransparency = 1.000
		imagetab.BorderColor3 = Color3.fromRGB(0, 0, 0)
		imagetab.BorderSizePixel = 0
		imagetab.Position = UDim2.new(0.0564971752, 0, 0.125, 0)
		imagetab.Size = UDim2.new(0, 60, 0, 60)
		imagetab.Image = img
		imagetab.ImageColor3 = Color3.fromRGB(134, 126, 180)
		
		Title.Name = "Title"
		Title.Parent = Tab1
		Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Title.BackgroundTransparency = 1.000
		Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Title.BorderSizePixel = 0
		Title.Position = UDim2.new(0.436271697, 0, 0.125, 0)
		Title.Size = UDim2.new(0, 99, 0, 30)
		Title.Font = Enum.Font.GothamBold
		Title.Text = name
		Title.TextColor3 = Color3.fromRGB(255, 255, 255)
		Title.TextSize = 18.000
		Title.TextWrapped = true
        Title.TextTransparency = 0.5
		Title.TextXAlignment = Enum.TextXAlignment.Left
		
		Desc.Name = "Desc"
		Desc.Parent = Tab1
		Desc.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Desc.BackgroundTransparency = 1.000
		Desc.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Desc.BorderSizePixel = 0
		Desc.Position = UDim2.new(0.436271697, 0, 0.5, 0)
		Desc.Size = UDim2.new(0, 99, 0, 30)
		Desc.Font = Enum.Font.Gotham
		Desc.Text = description
		Desc.TextColor3 = Color3.fromRGB(255, 255, 255)
		Desc.TextSize = 16.000
		Desc.TextTransparency = 0.500
		Desc.TextWrapped = true
		Desc.TextXAlignment = Enum.TextXAlignment.Left
		Desc.TextYAlignment = Enum.TextYAlignment.Top


		local MainPage = Instance.new("Frame")
		local UICornerff = Instance.new("UICorner")
		
		MainPage.Name = name.."_MainPage"
		MainPage.Parent = pagesfolder
		MainPage.Active = true
		MainPage.AnchorPoint = Vector2.new(0.5, 0.5)
		MainPage.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
		MainPage.BackgroundTransparency = 0.800
		MainPage.BorderColor3 = Color3.fromRGB(0, 0, 0)
		MainPage.BorderSizePixel = 0
		MainPage.Size = UDim2.new(0, 561, 0, 310)
		MainPage.BorderSizePixel = 0
		MainPage.ClipsDescendants = true

		UICornerff.Parent = MainPage

		MainPage.LayoutOrder = PageOrders

		local left = Instance.new("Frame")
		local UICornerleft = Instance.new("UICorner")

		left.Name = "left"
		left.Parent = MainPage
		left.AnchorPoint = Vector2.new(0.5, 0.5)
		left.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		left.BackgroundTransparency = 1.000
		left.BorderColor3 = Color3.fromRGB(0, 0, 0)
		left.BorderSizePixel = 0
		left.ClipsDescendants = true
		left.Position = UDim2.new(0.245989308, 0, 0.5, 0)
		left.Size = UDim2.new(0, 277, 0, 310)

		UICornerleft.CornerRadius = UDim.new(0, 6)
		UICornerleft.Parent = left

		local ScrollLeft = Instance.new("ScrollingFrame")
		local UIListLayout = Instance.new("UIListLayout")
		local UIPadding = Instance.new("UIPadding")
		
		ScrollLeft.Name = "ScrollLeft"
		ScrollLeft.Parent = left
		ScrollLeft.Active = true
		ScrollLeft.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ScrollLeft.BackgroundTransparency = 1.000
		ScrollLeft.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ScrollLeft.BorderSizePixel = 0
		ScrollLeft.Size = UDim2.new(1, 0, 1, 0)
		ScrollLeft.CanvasSize = UDim2.new(0, 0, 0, 397)
		ScrollLeft.ScrollBarThickness = 0
		
		UIListLayout.Parent = ScrollLeft
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.Padding = UDim.new(0, 5)
		
		UIPadding.Parent = ScrollLeft
		UIPadding.PaddingLeft = UDim.new(0, 5)
		UIPadding.PaddingTop = UDim.new(0, 5)

		local right = Instance.new("Frame")
		local ScrollRight = Instance.new("ScrollingFrame")
		local UIListLayoutright = Instance.new("UIListLayout")
		local UIPaddingright = Instance.new("UIPadding")
		
		right.Name = "right"
		right.Parent = MainPage
		right.AnchorPoint = Vector2.new(0.5, 0.5)
		right.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		right.BackgroundTransparency = 1.000
		right.BorderColor3 = Color3.fromRGB(0, 0, 0)
		right.BorderSizePixel = 0
		right.ClipsDescendants = true
		right.Position = UDim2.new(0.752228141, 0, 0.5, 0)
		right.Size = UDim2.new(0, 277, 0, 310)
		
		ScrollRight.Name = "ScrollRight"
		ScrollRight.Parent = right
		ScrollRight.Active = true
		ScrollRight.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ScrollRight.BackgroundTransparency = 1.000
		ScrollRight.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ScrollRight.BorderSizePixel = 0
		ScrollRight.Size = UDim2.new(1, 0, 1, 0)
		ScrollRight.CanvasSize = UDim2.new(0, 0, 0, 397)
		ScrollRight.ScrollBarThickness = 0
		
		UIListLayoutright.Parent = ScrollRight
		UIListLayoutright.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayoutright.Padding = UDim.new(0, 5)
		
		UIPaddingright.Parent = ScrollRight
		UIPaddingright.PaddingLeft = UDim.new(0, 5)
		UIPaddingright.PaddingTop = UDim.new(0, 5)

		local function GetType(value)
			if value == 1 then
				return ScrollLeft
			elseif value == 2 then
				return ScrollRight
			else
				return ScrollLeft
			end
		end

		game:GetService("RunService").PostSimulation:Connect(function()
			ScrollLeft.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 15)
			ScrollRight.CanvasSize = UDim2.new(0, 0, 0, UIListLayoutright.AbsoluteContentSize.Y + 15)
		end)

		Click.MouseButton1Click:connect(function()
			if MainPage.Name == name.."_MainPage" then
				UIPageLayout:JumpToIndex(MainPage.LayoutOrder)
				for i ,v in next , ScrollingTab:GetChildren() do
					if v:IsA("Frame") then
						TweenService:Create(
							v,
							TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{BackgroundTransparency = 0.75}
						):Play()
						-- This will only change the Title.TextTransparency for non-active tabs
						v.Title.TextTransparency = 0.5
					end
				end
				TweenService:Create(
					Tab1,
					TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{BackgroundTransparency = 0}
				):Play()
				TweenService:Create(
					Title,
					TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{TextTransparency = 0}
				):Play()
			end
		end)
		
		if FocusUI == false then
			TweenService:Create(
				Tab1,
				TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{BackgroundTransparency = 0.75}
			):Play()
			TweenService:Create(
				Title,
				TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{TextTransparency = 0.5}
			):Play() -- Title transparency is set to 0.5 for unfocused tabs
			MainPage.Visible = true
			MainPage.Name  = name.."_MainPage"
			for i ,v in next , ScrollingTab:GetChildren() do
				if i == 1 then
					TweenService:Create(
						Tab1,
						TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundTransparency = 0}
					):Play()
					TweenService:Create(
						Title,
						TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextTransparency = 0}
					):Play() -- Title transparency is reset to 0 for the focused tab
				end
			end
			FocusUI  = true
		end

        Logo.MouseButton1Click:Connect(function()
			if MainPage.Name == "Main".."_MainPage" then
                UIPageLayout:JumpToIndex(MainPage.LayoutOrder)
            end

            for i, v in next, ScrollingTab:GetChildren() do
                if v:IsA("Frame") and v.Name:match("Main") then
                    for _, tab in ipairs(ScrollingTab:GetChildren()) do
                        if tab:IsA("Frame") then
                            TweenService:Create(
                                tab,
                                TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                                {BackgroundTransparency = 0.75}
                            ):Play()
                            tab.Title.TextTransparency = 0.5
                        end
                    end
                    -- Highlight the "Main" tab
                    TweenService:Create(
                        v,
                        TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundTransparency = 0}
                    ):Play()
                    TweenService:Create(
                        v.Title,
                        TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {TextTransparency = 0}
                    ):Play()
                end
            end
        end)

		UIPageLayout:GetPropertyChangedSignal("CurrentPage"):Connect(function()
			local currentPage = UIPageLayout.CurrentPage
		
			-- Check if the current page is the Settings tab
			if currentPage.Name == "Settings_MainPage" then
				-- Make Tab1 visible when on the Settings tab
				Tab1.Visible = false
				Logo2.Visible = false
				Welcome.Visible = false
				Name.Visible = false
				Hub.Visible = false
				DiscordFrame.Visible = false
				KillUiFrame.Visible = false
			else
				-- Hide Tab1 when not on the Settings tab
				Tab1.Visible = true
				Logo2.Visible = true
				Welcome.Visible = true
				Name.Visible = true
				Hub.Visible = true
				DiscordFrame.Visible = true
			end
		end)		

		local LibraryPage = {}

		function LibraryPage:CreatePage(Title,Type)
			local Main_2 = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			local Main_Section = Instance.new("Frame")
			local MainSection_2 = Instance.new("Frame")
			local UICorner_2 = Instance.new("UICorner")
			local TextLabel = Instance.new("TextLabel")
			local UICorner_3 = Instance.new("UICorner")
			local Right = Instance.new("Frame")
			local UIListLayout_4 = Instance.new("UIListLayout")
			local UIPadding = Instance.new("UIPadding")
			
			Main_2.Name = "Main_2"
			Main_2.Parent = GetType(Type)
			Main_2.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
			Main_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Main_2.BorderSizePixel = 0
			Main_2.ClipsDescendants = true
			Main_2.Size = UDim2.new(0.979999959, 0, -0.202333272, 377)
			
			UICorner.CornerRadius = UDim.new(0, 6)
			UICorner.Parent = Main_2
			
			Main_Section.Name = "Main_Section"
			Main_Section.Parent = Main_2
			Main_Section.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
			Main_Section.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Main_Section.BorderSizePixel = 0
			Main_Section.ClipsDescendants = true
			Main_Section.Size = UDim2.new(1, 0, 0, 23)
			
			MainSection_2.Name = "MainSection_2"
			MainSection_2.Parent = Main_Section
			MainSection_2.BackgroundColor3 = Color3.fromRGB(96, 82, 116)
			MainSection_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
			MainSection_2.Size = UDim2.new(1, 0, 0, 4)
			
			UICorner_2.CornerRadius = UDim.new(0, 6)
			UICorner_2.Parent = MainSection_2
			
			TextLabel.Parent = MainSection_2
			TextLabel.AnchorPoint = Vector2.new(0, 0.5)
			TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TextLabel.BackgroundTransparency = 1.000
			TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TextLabel.BorderSizePixel = 0
			TextLabel.Position = UDim2.new(-0.0147058824, 10, 1.5, 5)
			TextLabel.Size = UDim2.new(0, 120, 0, 15)
			TextLabel.ZIndex = 2
			TextLabel.Font = Enum.Font.GothamBold
			TextLabel.Text = tostring(Title)
			TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			TextLabel.TextSize = 14.000
			TextLabel.TextTransparency = 0.400
			TextLabel.TextXAlignment = Enum.TextXAlignment.Left
			
			UICorner_3.CornerRadius = UDim.new(0, 6)
			UICorner_3.Parent = Main_Section
			
			Right.Name = "Right"
			Right.Parent = Main_2
			Right.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Right.BackgroundTransparency = 1.000
			Right.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Right.BorderSizePixel = 0
			Right.ClipsDescendants = true
			Right.Position = UDim2.new(0, 0, 0, 23)
			Right.Size = UDim2.new(1, 0, -0.276515573, 357)
			
			UIListLayout_4.Parent = Right
			UIListLayout_4.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout_4.Padding = UDim.new(0, 5)
			
			UIPadding.Parent = Right
			UIPadding.PaddingLeft = UDim.new(0, 5)
			UIPadding.PaddingTop = UDim.new(0, 7)

			game:GetService("RunService").Stepped:Connect(function ()
				pcall(function ()
					ScrollingTab.CanvasSize = UDim2.new(0,UIListLayout_2.AbsoluteContentSize.X + 10,0,0)
					Right.Size =  UDim2.new(1, 0, 0,UIListLayout_4.AbsoluteContentSize.Y + 45)
					Main_2.Size =  UDim2.new(0.979999959, 0, 0,UIListLayout_4.AbsoluteContentSize.Y + 45)
				end)
			end)
			
			local LibraryFunction = {}

			function LibraryFunction:AddLabel(name)

				local visual = name

				local Frame = Instance.new("Frame")
				local Text = Instance.new("TextLabel")

				Frame.Parent = Right
				Frame.AnchorPoint = Vector2.new(0.5, 0.5)
				Frame.BackgroundTransparency = 1.000
				Frame.Size = UDim2.new(0.975000024, 0, 0, 18)

				Text.Name = "Text"
				Text.Parent = Frame
				Text.AnchorPoint = Vector2.new(0.5, 0.5)
				Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Text.BackgroundTransparency = 1.000
				Text.Position = UDim2.new(0.5, 0, 0.5, 0)
				Text.Size = UDim2.new(0.899999976, 0, 0, 18)
				Text.ZIndex = 2
				Text.Font = Enum.Font.GothamBold
				Text.TextColor3 = Color3.fromRGB(255, 255, 255)
				Text.TextSize = 12.000
				Text.TextWrapped = true
				Text.TextYAlignment = Enum.TextYAlignment.Top
				Text.Text = visual or ""
				local LabelFunction = {}

				function LabelFunction.UpdateColor(value)
					TweenService:Create(
						Text,
						TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
						{TextColor3 = value}
					):Play()
				end

				function LabelFunction:Options()
					return Text
				end
				return LabelFunction

			end

			function LibraryFunction:AddToggle(name, options)
				local visualTitle = name or "Toggle"
				local visualdefault = options.Stats or false
				local visualcallback = options.callback or function() end
			
				local MainToggle = Instance.new("Frame")
				local UICorner_12 = Instance.new("UICorner")
				local Text_2 = Instance.new("TextLabel")
				local MainToggle_2 = Instance.new("ImageLabel")
				local UICorner_13 = Instance.new("UICorner")
				local MainToggle_3 = Instance.new("ImageLabel")
				local TextButton_3 = Instance.new("TextButton")
				local Text_3 = Instance.new("TextLabel")
			
				MainToggle.Name = "MainToggle"
				MainToggle.Parent = Right
				MainToggle.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
				MainToggle.BackgroundTransparency = 0.700
				MainToggle.BorderSizePixel = 0
				MainToggle.ClipsDescendants = true
				MainToggle.Size = UDim2.new(0.975000024, 0, 0, 36)
			
				UICorner_12.CornerRadius = UDim.new(0, 4)
				UICorner_12.Parent = MainToggle
			
				Text_2.Name = "Text"
				Text_2.Parent = MainToggle
				Text_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Text_2.BackgroundTransparency = 1.000
				Text_2.Position = UDim2.new(0, 10, 0, 10)
				Text_2.Size = UDim2.new(0.800000012, 0, 0, 23)
				Text_2.ZIndex = 2
				Text_2.Font = Enum.Font.GothamBold
				Text_2.Text = visualTitle
				Text_2.TextColor3 = Color3.fromRGB(255, 255, 255)
				Text_2.TextSize = 12.000
				Text_2.TextTransparency = 0.500
				Text_2.TextWrapped = true
				Text_2.TextXAlignment = Enum.TextXAlignment.Left
				Text_2.TextYAlignment = Enum.TextYAlignment.Top
			
				MainToggle_2.Name = "MainToggle"
				MainToggle_2.Parent = MainToggle
				MainToggle_2.AnchorPoint = Vector2.new(0.5, 0)
				MainToggle_2.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
				MainToggle_2.BackgroundTransparency = 0.200
				MainToggle_2.ClipsDescendants = true
				MainToggle_2.Position = UDim2.new(0.899999976, 0, 0, 5)
				MainToggle_2.Size = UDim2.new(0, 23, 0, 23)
			
				UICorner_13.CornerRadius = UDim.new(0, 6)
				UICorner_13.Parent = MainToggle_2
			
				MainToggle_3.Name = "ToggleInner"
				MainToggle_3.Parent = MainToggle_2
				MainToggle_3.AnchorPoint = Vector2.new(0.5, 0.5)
				MainToggle_3.BackgroundColor3 = Color3.fromRGB(21, 21, 21)
				MainToggle_3.BackgroundTransparency = 1.000
				MainToggle_3.Position = UDim2.new(0.5, 0, 0.5, 0)
				MainToggle_3.Size = UDim2.new(0, 0, 0, 0)
				MainToggle_3.Image = "http://www.roblox.com/asset/?id=6031068421"
				MainToggle_3.ImageColor3 = Color3.fromRGB(96, 82, 116)
			
				TextButton_3.Name = ""
				TextButton_3.Parent = MainToggle
				TextButton_3.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
				TextButton_3.BackgroundTransparency = 1.000
				TextButton_3.BorderSizePixel = 0
				TextButton_3.Size = UDim2.new(1, 0, 1, 0)
				TextButton_3.AutoButtonColor = false
				TextButton_3.Text = ""
				TextButton_3.TextColor3 = Color3.fromRGB(255, 255, 255)
				TextButton_3.TextSize = 14.000
			
				Text_3.Name = "Text"
				Text_3.Parent = MainToggle
				Text_3.AnchorPoint = Vector2.new(0.5, 0)
				Text_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Text_3.BackgroundTransparency = 1.000
				Text_3.Position = UDim2.new(0.5, 5, 0, 33)
				Text_3.Size = UDim2.new(0.949999988, 0, 0, 0)
				Text_3.Visible = false
				Text_3.ZIndex = 2
				Text_3.Text = "nil"
				Text_3.TextColor3 = Color3.fromRGB(255, 255, 255)
				Text_3.TextSize = 12.000
				Text_3.TextTransparency = 0.700
				Text_3.TextWrapped = true
				Text_3.TextXAlignment = Enum.TextXAlignment.Left
				Text_3.TextYAlignment = Enum.TextYAlignment.Top
			
				local visual = {
					toggle = false,
					togglefunction = {},
				}
			
				local function updateToggle(state)
					if state then
						tween(MainToggle_3, 0.25, {Size = UDim2.new(0, 29, 0, 29)})
						tween(Text_2, 0.1, {TextTransparency = 0})
					else
						tween(MainToggle_3, 0.25, {Size = UDim2.new(0, 0, 0, 0)})
						tween(Text_2, 0.1, {TextTransparency = 0.6})
					end
					visual.toggle = state
					options.callback(visual.toggle)
				end
			
				TextButton_3.MouseButton1Click:Connect(function()
					updateToggle(not visual.toggle)
				end)
			
				if visualdefault == true then
					updateToggle(true)
				end
			
				function visual:Change(newState)
					updateToggle(newState)
				end
			
				return visual
			end			

			function LibraryFunction:AddToggleButton(options)

				local visualTitle = options.Title or "Button"
				local visualcallback = options.callback or function() end
				local visualdefault = options.Default or false


				local Frame_2 = Instance.new("Frame")
				local UICorner_11 = Instance.new("UICorner")
				local TextLabel_2 = Instance.new("TextLabel")
				local TextButton_2 = Instance.new("TextButton")

				Frame_2.Parent = Right
				Frame_2.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
				Frame_2.Size = UDim2.new(0.975000024, 0, 0, 20)

				UICorner_11.CornerRadius = UDim.new(0, 4)
				UICorner_11.Parent = Frame_2

				TextLabel_2.Parent = Frame_2
				TextLabel_2.AnchorPoint = Vector2.new(0.5, 0.5)
				TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextLabel_2.BackgroundTransparency = 1.000
				TextLabel_2.Position = UDim2.new(0.5, 0, 0.5, 0)
				TextLabel_2.Size = UDim2.new(0, 44, 0, 12)
				TextLabel_2.ZIndex = 2
				TextLabel_2.Font = Enum.Font.GothamBold
				TextLabel_2.Text = visualTitle
				TextLabel_2.TextColor3 = Color3.fromRGB(255, 255, 255)
				TextLabel_2.TextSize = 12.000

				TextButton_2.Parent = Frame_2
				TextButton_2.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
				TextButton_2.BackgroundTransparency = 1.000
				TextButton_2.BorderSizePixel = 0
				TextButton_2.ClipsDescendants = true
				TextButton_2.Size = UDim2.new(1, 0, 1, 0)
				TextButton_2.AutoButtonColor = false
				TextButton_2.Font = Enum.Font.GothamBold
				TextButton_2.Text = ""
				TextButton_2.TextColor3 = Color3.fromRGB(255, 255, 255)
				TextButton_2.TextSize = 14.000

				TextButton_2.MouseButton1Down:Connect(function()
					if ButtonFocus == false then
						TweenService:Create(
							Frame_2,
							TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out,0.1),
							{BackgroundColor3 = Color3.fromRGB(85, 170, 127)}
						):Play()
					else
						TweenService:Create(
							Frame_2,
							TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out,0.1),
							{BackgroundColor3 = Color3.fromRGB(255, 0, 0)}
						):Play()
					end
					ButtonFocus = not ButtonFocus
					--CircleAnim(TextButton_2,Color3.fromRGB(0, 0, 0),Color3.fromRGB(0, 0, 0))
					wait(.2)
					Ripple(TextButton_2)
					options.callback(ButtonFocus)
				end)

				if options.Default == true then
					TweenService:Create(
						Frame_2,
						TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out,0.1),
						{BackgroundColor3 = Color3.fromRGB(85, 170, 127)}
					):Play()
					ButtonFocus = not ButtonFocus
					--CircleAnim(TextButton_2,Color3.fromRGB(0, 0, 0),Color3.fromRGB(0, 0, 0))
					wait(.2)
					Ripple(TextButton_2)
					options.callback(ButtonFocus)
				end
			end

			function LibraryFunction:AddButton(name,callback)

				local visualTitle = name or "Button"

				local Frame_2 = Instance.new("Frame")
				local UICorner_11 = Instance.new("UICorner")
				local TextLabel_2 = Instance.new("TextLabel")
				local TextButton_2 = Instance.new("TextButton")

				Frame_2.Parent = Right
				Frame_2.BackgroundColor3 = Color3.fromRGB(96, 82, 116)
				Frame_2.Size = UDim2.new(0.975000024, 0, 0, 20)

				UICorner_11.CornerRadius = UDim.new(0, 4)
				UICorner_11.Parent = Frame_2

				TextLabel_2.Parent = Frame_2
				TextLabel_2.AnchorPoint = Vector2.new(0.5, 0.5)
				TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextLabel_2.BackgroundTransparency = 1.000
				TextLabel_2.Position = UDim2.new(0.5, 0, 0.5, 0)
				TextLabel_2.Size = UDim2.new(0, 44, 0, 12)
				TextLabel_2.ZIndex = 2
				TextLabel_2.Font = Enum.Font.GothamBold
				TextLabel_2.Text = visualTitle
				TextLabel_2.TextColor3 = Color3.fromRGB(255, 255, 255)
				TextLabel_2.TextSize = 12.000

				TextButton_2.Parent = Frame_2
				TextButton_2.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
				TextButton_2.BackgroundTransparency = 1.000
				TextButton_2.BorderSizePixel = 0
				TextButton_2.ClipsDescendants = true
				TextButton_2.Size = UDim2.new(1, 0, 1, 0)
				TextButton_2.AutoButtonColor = false
				TextButton_2.Font = Enum.Font.GothamBold
				TextButton_2.Text = ""
				TextButton_2.TextColor3 = Color3.fromRGB(255, 255, 255)
				TextButton_2.TextSize = 14.000

				TextButton_2.MouseButton1Down:Connect(function()
					--CircleAnim(TextButton_2,Color3.fromRGB(0, 0, 0),Color3.fromRGB(0, 0, 0))
					wait(.2)
					Ripple(TextButton_2)
					pcall(callback)
				end)

			end

			function LibraryFunction:AddDropdown(name,options)
				local DropdownFunctions = false
				local visualTitle = name or "Dropdown : None"
				local visualItem = options.Values or {}
				local visualcallback = options.callback or function(Item) return end 

				local MainDropDown = Instance.new("Frame")
				local UICorner = Instance.new("UICorner")
				local MainDropDown_2 = Instance.new("Frame")
				local UICorner_2 = Instance.new("UICorner")
				local Buttum = Instance.new("TextButton")
				local TitleDropDown = Instance.new("TextBox")
				local Arrow = Instance.new("ImageButton")
				local Text_2 = Instance.new("TextLabel")


				MainDropDown.Name = "MainDropDown"
				MainDropDown.Parent = Right
				MainDropDown.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
				MainDropDown.BackgroundTransparency = 0.700
				MainDropDown.BorderSizePixel = 0
				MainDropDown.ClipsDescendants = true
				MainDropDown.Size = UDim2.new(0.975000024, 0, 0, 35)

				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = MainDropDown

				MainDropDown_2.Name = "MainDropDown"
				MainDropDown_2.Parent = MainDropDown
				MainDropDown_2.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
				MainDropDown_2.BackgroundTransparency = 0.700
				MainDropDown_2.BorderSizePixel = 0
				MainDropDown_2.ClipsDescendants = true
				MainDropDown_2.Size = UDim2.new(0.975000024, 0, 0, 35)

				UICorner_2.CornerRadius = UDim.new(0, 4)
				UICorner_2.Parent = MainDropDown_2

				Buttum.Name = "Buttum"
				Buttum.Parent = MainDropDown_2
				Buttum.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Buttum.BackgroundTransparency = 1.000
				Buttum.BorderSizePixel = 0
				Buttum.Size = UDim2.new(1, 0, 1, 0)
				Buttum.ZIndex = 20
				Buttum.AutoButtonColor = false
				Buttum.Font = Enum.Font.Unknown
				Buttum.Text = ""
				Buttum.TextColor3 = Color3.fromRGB(255, 255, 255)
				Buttum.TextSize = 12.000

				TitleDropDown.Name = "Text"
				TitleDropDown.Parent = MainDropDown_2
				TitleDropDown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TitleDropDown.BackgroundTransparency = 1.000
				TitleDropDown.Position = UDim2.new(0, 10, 0, 10)
				TitleDropDown.Size = UDim2.new(0.800000012, 0, 0, 35)
				TitleDropDown.ZIndex = 2
				TitleDropDown.Font = Enum.Font.GothamBold
				TitleDropDown.Text = visualTitle.." : None"
				TitleDropDown.TextColor3 = Color3.fromRGB(255, 255, 255)
				TitleDropDown.TextSize = 12.000
				TitleDropDown.TextWrapped = true
				TitleDropDown.TextXAlignment = Enum.TextXAlignment.Left
				TitleDropDown.TextYAlignment = Enum.TextYAlignment.Top

				Arrow.Parent = MainDropDown_2
				Arrow.AnchorPoint = Vector2.new(0, 0.5)
				Arrow.BackgroundTransparency = 1.000
				Arrow.Position = UDim2.new(1, -25, 0, 15)
				Arrow.Rotation = 0
				Arrow.Size = UDim2.new(0, 12, 0, 12)
				Arrow.ZIndex = 7
				Arrow.Image = "http://www.roblox.com/asset/?id=6282522798"

				Text_2.Name = "Text"
				Text_2.Parent = MainDropDown_2
				Text_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Text_2.BackgroundTransparency = 1.000
				Text_2.Position = UDim2.new(0, 10, 0, 45)
				Text_2.Size = UDim2.new(0.949999988, 0, 0, 0)
				Text_2.Visible = false
				Text_2.ZIndex = 2
				Text_2.Font = Enum.Font.GothamBold
				Text_2.Text = "nil"
				Text_2.TextColor3 = Color3.fromRGB(255, 255, 255)
				Text_2.TextSize = 12.000
				Text_2.TextTransparency = 0.700
				Text_2.TextWrapped = true
				Text_2.TextXAlignment = Enum.TextXAlignment.Left
				Text_2.TextYAlignment = Enum.TextYAlignment.Top

				local Scroll_Items = Instance.new("ScrollingFrame")
				local UIListLayout_5 = Instance.new("UIListLayout")
				local UIPadding_4 = Instance.new("UIPadding")

				Scroll_Items.Name = "Scroll_Items"
				Scroll_Items.Parent = MainDropDown
				Scroll_Items.Active = true
				Scroll_Items.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Scroll_Items.BackgroundTransparency = 1.000
				Scroll_Items.BorderSizePixel = 0
				Scroll_Items.Position = UDim2.new(0, 0, 0, 35)
				Scroll_Items.Size = UDim2.new(1, 0, 1, -35)
				Scroll_Items.ZIndex = 20
				Scroll_Items.CanvasSize = UDim2.new(0, 0, 0, 155)
				Scroll_Items.BottomImage = ""
				Scroll_Items.ScrollBarThickness = 0
				Scroll_Items.TopImage = ""

				UIListLayout_5.Parent = Scroll_Items
				UIListLayout_5.SortOrder = Enum.SortOrder.LayoutOrder
				UIListLayout_5.Padding = UDim.new(0, 5)

				UIPadding_4.Parent = Scroll_Items
				UIPadding_4.PaddingLeft = UDim.new(0, 10)
				UIPadding_4.PaddingTop = UDim.new(0, 5)

				for i,v in pairs(visualItem) do

					local ButtonBar = Instance.new("TextButton")
					local ButtonBarUICorner = Instance.new("UICorner")

					ButtonBar.Name = "ButtonBar"
					ButtonBar.Parent = Scroll_Items
					ButtonBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
					ButtonBar.BorderSizePixel = 0
					ButtonBar.ClipsDescendants = true
					ButtonBar.Size = UDim2.new(1, -10, 0, 20)
					ButtonBar.AutoButtonColor = false
					ButtonBar.Font = Enum.Font.GothamBold
					ButtonBar.Text = tostring(v)
					ButtonBar.TextColor3 = Color3.fromRGB(255, 255, 255)
					ButtonBar.TextSize = 12.000
					ButtonBar.TextWrapped = true
					ButtonBar.AutoButtonColor = false
					ButtonBar.ClipsDescendants = true

					ButtonBarUICorner.CornerRadius = UDim.new(0, 4)
					ButtonBarUICorner.Parent = ButtonBar

					ButtonBar.MouseEnter:Connect(function()
						TweenService:Create(
							ButtonBar,
							TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out,0.1),
							{TextColor3 = Color3.fromRGB(96, 82, 116)}
						):Play()
					end)

					ButtonBar.MouseLeave:Connect(function()
						TweenService:Create(
							ButtonBar,
							TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out,0.1),
							{TextColor3 = Color3.fromRGB(255, 255, 255)}
						):Play()
					end)

					ButtonBar.MouseButton1Down:Connect(function()
						ButtonBar.TextSize = 0
						TweenService:Create(
							ButtonBar,
							TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out,0.1),
							{TextSize = 12}
						):Play()
						TitleDropDown.Text = tostring(visualTitle.." : "..v)
						CircleAnim(ButtonBar,Color3.fromRGB(255,255,255),Color3.fromRGB(255,255,255))
						options.callback(v)
					end)
				end
				Buttum.MouseButton1Down:Connect(function()
					if DropdownFunctions == false  then
						TweenService:Create(
							MainDropDown,
							TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out,0.1),
							{Size = UDim2.new(0.975000024, 0, 0, 205)}
						):Play()
						TweenService:Create(
							Arrow,
							TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out,0.1),
							{Rotation = 180}
						):Play()
					else
						TweenService:Create(
							MainDropDown,
							TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out,0.1),
							{Size = UDim2.new(0.975000024, 0, 0, 35)}
						):Play()
						TweenService:Create(
							Arrow,
							TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out,0.1),
							{Rotation = 0}
						):Play()
					end
					Scroll_Items.CanvasSize = UDim2.new(0,0,0,UIListLayout_5.AbsoluteContentSize.Y + 10)
					DropdownFunctions = not DropdownFunctions
				end)

				local DropdownVisual = {}

				function DropdownVisual:Clear()
					TweenService:Create(
						MainDropDown,
						TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out,0.1),
						{Size = UDim2.new(0.975000024, 0, 0, 35)}
					):Play()
					DropdownFunctions = not DropdownFunctions
					TitleDropDown.Text = tostring(visualTitle.." : ")
					for i, v in next, Scroll_Items:GetChildren() do
						if v:IsA("TextButton") then
							v:Destroy()
						end
					end
				end

				function DropdownVisual:Add(value)

					local ButtonBar = Instance.new("TextButton")
					local ButtonBarUICorner = Instance.new("UICorner")

					ButtonBar.Name = "ButtonBar"
					ButtonBar.Parent = Scroll_Items
					ButtonBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
					ButtonBar.BorderSizePixel = 0
					ButtonBar.ClipsDescendants = true
					ButtonBar.Size = UDim2.new(1, -10, 0, 20)
					ButtonBar.AutoButtonColor = false
					ButtonBar.Font = Enum.Font.GothamBold
					ButtonBar.Text = tostring(value)
					ButtonBar.TextColor3 = Color3.fromRGB(255, 255, 255)
					ButtonBar.TextSize = 12.000
					ButtonBar.TextWrapped = true
					ButtonBar.AutoButtonColor = false
					ButtonBar.ClipsDescendants = true

					ButtonBarUICorner.CornerRadius = UDim.new(0, 4)
					ButtonBarUICorner.Parent = ButtonBar

					ButtonBar.MouseEnter:Connect(function()
						TweenService:Create(
							ButtonBar,
							TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out,0.1),
							{TextColor3 = Color3.fromRGB(96, 82, 116)}
						):Play()
					end)

					ButtonBar.MouseLeave:Connect(function()
						TweenService:Create(
							ButtonBar,
							TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out,0.1),
							{TextColor3 = Color3.fromRGB(255, 255, 255)}
						):Play()
					end)

					ButtonBar.MouseButton1Down:Connect(function()
						ButtonBar.TextSize = 0
						TweenService:Create(
							ButtonBar,
							TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out,0.1),
							{TextSize = 12}
						):Play()
						TitleDropDown.Text = tostring(visualTitle.." : "..value)
						CircleAnim(ButtonBar,Color3.fromRGB(255,255,255),Color3.fromRGB(255,255,255))
						options.callback(value)
					end)
					Scroll_Items.CanvasSize = UDim2.new(0,0,0,UIListLayout_5.AbsoluteContentSize.Y + 10)
				end

				return DropdownVisual


			end

			function LibraryFunction:AddMultiDropdown(name,options)
				local DropdownFunctions = false

				local MultiDropdown = {}
				local visualTitle = name or "MultiDropdown : None"
				local visualItem = options.Values or {}
				local visualcallback = options.callback or function(Item) return end 
				local visualdefault = options.setup or {}

				local MainDropDown = Instance.new("Frame")
				local UICorner = Instance.new("UICorner")
				local MainDropDown_2 = Instance.new("Frame")
				local UICorner_2 = Instance.new("UICorner")
				local Buttum = Instance.new("TextButton")
				local TitleDropDown = Instance.new("TextBox")
				local Arrow = Instance.new("ImageButton")
				local Text_2 = Instance.new("TextLabel")


				MainDropDown.Name = "MainDropDown"
				MainDropDown.Parent = Right
				MainDropDown.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
				MainDropDown.BackgroundTransparency = 0.700
				MainDropDown.BorderSizePixel = 0
				MainDropDown.ClipsDescendants = true
				MainDropDown.Size = UDim2.new(0.975000024, 0, 0, 35)

				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = MainDropDown

				MainDropDown_2.Name = "MainDropDown"
				MainDropDown_2.Parent = MainDropDown
				MainDropDown_2.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
				MainDropDown_2.BackgroundTransparency = 0.700
				MainDropDown_2.BorderSizePixel = 0
				MainDropDown_2.ClipsDescendants = true
				MainDropDown_2.Size = UDim2.new(0.975000024, 0, 0, 35)

				UICorner_2.CornerRadius = UDim.new(0, 4)
				UICorner_2.Parent = MainDropDown_2

				Buttum.Name = "Buttum"
				Buttum.Parent = MainDropDown_2
				Buttum.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Buttum.BackgroundTransparency = 1.000
				Buttum.BorderSizePixel = 0
				Buttum.Size = UDim2.new(1, 0, 1, 0)
				Buttum.ZIndex = 20
				Buttum.AutoButtonColor = false
				Buttum.Font = Enum.Font.Unknown
				Buttum.Text = ""
				Buttum.TextColor3 = Color3.fromRGB(255, 255, 255)
				Buttum.TextSize = 12.000

				TitleDropDown.Name = "Text"
				TitleDropDown.Parent = MainDropDown_2
				TitleDropDown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TitleDropDown.BackgroundTransparency = 1.000
				TitleDropDown.Position = UDim2.new(0, 10, 0, 10)
				TitleDropDown.Size = UDim2.new(0.800000012, 0, 0, 35)
				TitleDropDown.ZIndex = 2
				TitleDropDown.Font = Enum.Font.GothamBold
				TitleDropDown.Text = visualTitle.." : None"
				TitleDropDown.TextColor3 = Color3.fromRGB(255, 255, 255)
				TitleDropDown.TextSize = 12.000
				TitleDropDown.TextWrapped = true
				TitleDropDown.TextXAlignment = Enum.TextXAlignment.Left
				TitleDropDown.TextYAlignment = Enum.TextYAlignment.Top

				Arrow.Parent = MainDropDown_2
				Arrow.AnchorPoint = Vector2.new(0, 0.5)
				Arrow.BackgroundTransparency = 1.000
				Arrow.Position = UDim2.new(1, -25, 0, 15)
				Arrow.Rotation = 0
				Arrow.Size = UDim2.new(0, 12, 0, 12)
				Arrow.ZIndex = 7
				Arrow.Image = "http://www.roblox.com/asset/?id=6282522798"

				Text_2.Name = "Text"
				Text_2.Parent = MainDropDown_2
				Text_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Text_2.BackgroundTransparency = 1.000
				Text_2.Position = UDim2.new(0, 10, 0, 45)
				Text_2.Size = UDim2.new(0.949999988, 0, 0, 0)
				Text_2.Visible = false
				Text_2.ZIndex = 2
				Text_2.Font = Enum.Font.GothamBold
				Text_2.Text = "nil"
				Text_2.TextColor3 = Color3.fromRGB(255, 255, 255)
				Text_2.TextSize = 12.000
				Text_2.TextTransparency = 0.700
				Text_2.TextWrapped = true
				Text_2.TextXAlignment = Enum.TextXAlignment.Left
				Text_2.TextYAlignment = Enum.TextYAlignment.Top

				local Scroll_Items = Instance.new("ScrollingFrame")
				local UIListLayout_5 = Instance.new("UIListLayout")
				local UIPadding_4 = Instance.new("UIPadding")

				Scroll_Items.Name = "Scroll_Items"
				Scroll_Items.Parent = MainDropDown
				Scroll_Items.Active = true
				Scroll_Items.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Scroll_Items.BackgroundTransparency = 1.000
				Scroll_Items.BorderSizePixel = 0
				Scroll_Items.Position = UDim2.new(0, 0, 0, 35)
				Scroll_Items.Size = UDim2.new(1, 0, 1, -35)
				Scroll_Items.ZIndex = 20
				Scroll_Items.CanvasSize = UDim2.new(0, 0, 0, 155)
				Scroll_Items.BottomImage = ""
				Scroll_Items.ScrollBarThickness = 0
				Scroll_Items.TopImage = ""

				UIListLayout_5.Parent = Scroll_Items
				UIListLayout_5.SortOrder = Enum.SortOrder.LayoutOrder
				UIListLayout_5.Padding = UDim.new(0, 5)

				UIPadding_4.Parent = Scroll_Items
				UIPadding_4.PaddingLeft = UDim.new(0, 10)
				UIPadding_4.PaddingTop = UDim.new(0, 5)

				for i,v in pairs(visualItem) do

					local ButtonBar = Instance.new("TextButton")
					local ButtonBarUICorner = Instance.new("UICorner")

					ButtonBar.Name = "ButtonBar"
					ButtonBar.Parent = Scroll_Items
					ButtonBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
					ButtonBar.BorderSizePixel = 0
					ButtonBar.ClipsDescendants = true
					ButtonBar.Size = UDim2.new(1, -10, 0, 20)
					ButtonBar.AutoButtonColor = false
					ButtonBar.Font = Enum.Font.GothamBold
					ButtonBar.Text = tostring(v)
					ButtonBar.TextColor3 = Color3.fromRGB(255, 255, 255)
					ButtonBar.TextSize = 12.000
					ButtonBar.TextWrapped = true
					ButtonBar.AutoButtonColor = false
					ButtonBar.ClipsDescendants = true

					ButtonBarUICorner.CornerRadius = UDim.new(0, 4)
					ButtonBarUICorner.Parent = ButtonBar

					for o,p in pairs(visualdefault) do
						if v == p  then
							table.insert(MultiDropdown,p)
							TitleDropDown.Text = tostring(visualTitle.." : "..table.concat(MultiDropdown,","))
							visualcallback(MultiDropdown)
						end
					end

					ButtonBar.MouseButton1Down:Connect(function()
						if tablefound(MultiDropdown,v) == false then
							table.insert(MultiDropdown,v)
						else
							for ine,va in pairs(MultiDropdown) do
								if va == v then
									table.remove(MultiDropdown,ine)
								end
							end					end
						pcall(visualcallback,MultiDropdown)
						TitleDropDown.Text = tostring(visualTitle.." : "..table.concat(MultiDropdown,","))
					end)


					ButtonBar.MouseEnter:Connect(function()
						TweenService:Create(
							ButtonBar,
							TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out,0.1),
							{TextColor3 = Color3.fromRGB(96, 82, 116)}
						):Play()
					end)

					ButtonBar.MouseLeave:Connect(function()
						TweenService:Create(
							ButtonBar,
							TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out,0.1),
							{TextColor3 = Color3.fromRGB(255, 255, 255)}
						):Play()
					end)

				end
				Buttum.MouseButton1Down:Connect(function()
					if DropdownFunctions == false  then
						TweenService:Create(
							MainDropDown,
							TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out,0.1),
							{Size = UDim2.new(0.975000024, 0, 0, 205)}
						):Play()
						TweenService:Create(
							Arrow,
							TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out,0.1),
							{Rotation = 180}
						):Play()
					else
						TweenService:Create(
							MainDropDown,
							TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out,0.1),
							{Size = UDim2.new(0.975000024, 0, 0, 35)}
						):Play()
						TweenService:Create(
							Arrow,
							TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out,0.1),
							{Rotation = 0}
						):Play()
					end
					Scroll_Items.CanvasSize = UDim2.new(0,0,0,UIListLayout_5.AbsoluteContentSize.Y + 10)
					DropdownFunctions = not DropdownFunctions
				end)
				local DropdownVisual = {}

				function DropdownVisual:Clear()
					TweenService:Create(
						MainDropDown,
						TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out,0.1),
						{Size = UDim2.new(0.975000024, 0, 0, 35)}
					):Play()
					DropdownFunctions = not DropdownFunctions
					TitleDropDown.Text = tostring(visualTitle.." : ")
					for i, v in next, Scroll_Items:GetChildren() do
						if v:IsA("TextButton") then
							v:Destroy()
						end
					end
				end

				function DropdownVisual:Add(value)

					local ButtonBar = Instance.new("TextButton")
					local ButtonBarUICorner = Instance.new("UICorner")

					ButtonBar.Name = "ButtonBar"
					ButtonBar.Parent = Scroll_Items
					ButtonBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
					ButtonBar.BorderSizePixel = 0
					ButtonBar.ClipsDescendants = true
					ButtonBar.Size = UDim2.new(1, -10, 0, 20)
					ButtonBar.AutoButtonColor = false
					ButtonBar.Font = Enum.Font.GothamBold
					ButtonBar.Text = tostring(value)
					ButtonBar.TextColor3 = Color3.fromRGB(255, 255, 255)
					ButtonBar.TextSize = 12.000
					ButtonBar.TextWrapped = true
					ButtonBar.AutoButtonColor = false
					ButtonBar.ClipsDescendants = true

					ButtonBarUICorner.CornerRadius = UDim.new(0, 4)
					ButtonBarUICorner.Parent = ButtonBar

					ButtonBar.MouseEnter:Connect(function()
						TweenService:Create(
							ButtonBar,
							TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out,0.1),
							{TextColor3 = Color3.fromRGB(96, 82, 116)}
						):Play()
					end)

					ButtonBar.MouseLeave:Connect(function()
						TweenService:Create(
							ButtonBar,
							TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out,0.1),
							{TextColor3 = Color3.fromRGB(255, 255, 255)}
						):Play()
					end)

					ButtonBar.MouseButton1Down:Connect(function()
						ButtonBar.TextSize = 0
						TweenService:Create(
							ButtonBar,
							TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out,0.1),
							{TextSize = 12}
						):Play()
						TitleDropDown.Text = tostring(visualTitle.." : "..value)
						CircleAnim(ButtonBar,Color3.fromRGB(255,255,255),Color3.fromRGB(255,255,255))
						options.callback(value)
					end)
					Scroll_Items.CanvasSize = UDim2.new(0,0,0,UIListLayout_5.AbsoluteContentSize.Y + 10)
				end

				return DropdownVisual

			end

			function LibraryFunction:AddSlider(name,options)

				local sliderfunc = {}

				local visualTitle = name or "Slider : nil"
				local visualMax = options.max or 100
				local visualMin = options.min or 0
				local visualDefault = options.value or 50
				local visualcallback = options.callback or function() end

				local MainSlider = Instance.new("Frame")
				local UICorner_22 = Instance.new("UICorner")
				local Text_8 = Instance.new("TextBox")
				local Text_9 = Instance.new("TextLabel")
				local SliderBar = Instance.new("Frame")
				local UICorner_23 = Instance.new("UICorner")
				local SliderBar_2 = Instance.new("Frame")
				local UICorner_24 = Instance.new("UICorner")
				local SliderBar_3 = Instance.new("Frame")
				local UICorner_25 = Instance.new("UICorner")
				local TextButton_4 = Instance.new("TextButton")
				local Text_10 = Instance.new("TextLabel")


				MainSlider.Name = "MainSlider"
				MainSlider.Parent = Right
				MainSlider.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
				MainSlider.BackgroundTransparency = 0.700
				MainSlider.BorderSizePixel = 0
				MainSlider.ClipsDescendants = true
				MainSlider.Size = UDim2.new(0.975000024, 0, 0, 43)

				UICorner_22.CornerRadius = UDim.new(0, 4)
				UICorner_22.Parent = MainSlider

				TextButton_4.Parent = MainSlider
				TextButton_4.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
				TextButton_4.BackgroundTransparency = 1.000
				TextButton_4.BorderSizePixel = 0
				TextButton_4.ClipsDescendants = true
				TextButton_4.Position = UDim2.new(0, 0, 0, -8)
				TextButton_4.Size = UDim2.new(1, 5, 1, 18)
				TextButton_4.AutoButtonColor = false
				TextButton_4.Text = ""
				TextButton_4.TextColor3 = Color3.fromRGB(255, 255, 255)
				TextButton_4.TextSize = 14.000

				Text_8.Name = "Text"
				Text_8.Parent = MainSlider
				Text_8.AnchorPoint = Vector2.new(0.5, 0)
				Text_8.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
				Text_8.BorderSizePixel = 0
				Text_8.ClipsDescendants = true
				Text_8.Position = UDim2.new(0.899999976, 0, 0, 2)
				Text_8.Size = UDim2.new(0, 40, 0, 25)
				Text_8.ZIndex = 2
				Text_8.Font = Enum.Font.GothamBold
				Text_8.PlaceholderColor3 = Color3.fromRGB(222, 222, 222)
				Text_8.Text = tostring(visualDefault and math.floor( (visualDefault / visualMax) * (visualMax - visualMin) + visualMin) or 0)
				Text_8.TextColor3 = Color3.fromRGB(255, 255, 255)
				Text_8.TextSize = 11.000
				Text_8.TextTransparency = 0

				Text_9.Name = "Text"
				Text_9.Parent = MainSlider
				Text_9.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Text_9.BackgroundTransparency = 1.000
				Text_9.Position = UDim2.new(0, 10, 0, 10)
				Text_9.Size = UDim2.new(0.75, 0, 0, 23)
				--Text_9.ZIndex = 2
				Text_9.Font = Enum.Font.GothamBold
				Text_9.Text = visualTitle
				Text_9.TextColor3 = Color3.fromRGB(255, 255, 255)
				Text_9.TextSize = 12.000
				Text_9.TextWrapped = true
				Text_9.TextXAlignment = Enum.TextXAlignment.Left
				Text_9.TextYAlignment = Enum.TextYAlignment.Top

				SliderBar.Name = "SliderBar"
				SliderBar.Parent = MainSlider
				SliderBar.AnchorPoint = Vector2.new(0.5, 0)
				SliderBar.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
				SliderBar.BorderSizePixel = 0
				SliderBar.Position = UDim2.new(0.5, 0, 0, 33)
				SliderBar.Size = UDim2.new(0.9, 0, 0, 5)

				UICorner_23.CornerRadius = UDim.new(0, 4)
				UICorner_23.Parent = SliderBar

				SliderBar_2.Name = "SliderBar"
				SliderBar_2.Parent = SliderBar
				SliderBar_2.BackgroundColor3 = Color3.fromRGB(96, 82, 116)
				SliderBar_2.BorderSizePixel = 0
				SliderBar_2.Size = UDim2.new((visualDefault or 0)/visualMax, 0, 0, 5)

				UICorner_24.CornerRadius = UDim.new(0, 4)
				UICorner_24.Parent = SliderBar_2

				SliderBar_3.Name = "SliderBar"
				SliderBar_3.Parent = SliderBar
				SliderBar_3.AnchorPoint = Vector2.new(0.5, 0.5)
				SliderBar_3.BackgroundColor3 = Color3.fromRGB(96, 82, 116)
				SliderBar_3.BorderSizePixel = 0
				SliderBar_3.ClipsDescendants = true
				SliderBar_3.Position = UDim2.new((visualDefault or 0)/visualMax, 0.5, 0.5,0.5, 0)
				SliderBar_3.Size = UDim2.new(0, 15, 0, 15)

				UICorner_25.CornerRadius = UDim.new(0, 360)
				UICorner_25.Parent = SliderBar_3

				Text_10.Name = "Text"
				Text_10.Parent = MainSlider
				Text_10.AnchorPoint = Vector2.new(0.5, 0)
				Text_10.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Text_10.BackgroundTransparency = 1.000
				Text_10.Position = UDim2.new(0.5, 5, 0, 43)
				Text_10.Size = UDim2.new(0.949999988, 0, 0, 0)
				Text_10.Visible = false
				Text_10.ZIndex = 2
				Text_10.Text = "nil"
				Text_10.TextColor3 = Color3.fromRGB(255, 255, 255)
				Text_10.TextSize = 12.000
				Text_10.TextTransparency = 0.700
				Text_10.TextWrapped = true
				Text_10.TextXAlignment = Enum.TextXAlignment.Left
				Text_10.TextYAlignment = Enum.TextYAlignment.Top

				local function move(input)
					local pos =
						UDim2.new(
							math.clamp((input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1),
							0,
							0.5,
							0
						)
					local pos1 =
						UDim2.new(
							math.clamp((input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1),
							0,
							0,
							5
						)

					SliderBar_2:TweenSize(pos1, "Out", "Sine", 0.2, true)
					SliderBar_3:TweenPosition(pos, "Out", "Sine", 0.2, true)
					local value = math.floor(((pos.X.Scale * visualMax) / visualMax) * (visualMax - visualMin) + visualMin)
					Text_8.Text = tostring(value)
					pcall(options.callback, Text_8.Text)
				end

				local dragging = false

				MainSlider.InputBegan:Connect(
					function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							dragging = true

						end
					end
				)
				MainSlider.InputEnded:Connect(
					function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							dragging = false

						end
					end
				)


				SliderBar.InputBegan:Connect(
					function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							dragging = true

						end
					end
				)
				SliderBar.InputEnded:Connect(
					function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							dragging = false

						end
					end
				)
				game:GetService("UserInputService").InputChanged:Connect(function(input)
					if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
						move(input)
					end
				end)

				Text_8.FocusLost:Connect(function()
					if Text_8.Text == "" then
						Text_8.Text  = visualDefault
					end
					if  tonumber(Text_8.Text) > visualMax then
						Text_8.Text  = visualMax
					end
					SliderBar_2:TweenSize(UDim2.new((Text_8.Text or 0) / visualMax, 0, 0, 5), "Out", "Sine", 0.2, true)
					SliderBar_3:TweenPosition(UDim2.new((Text_8.Text or 0)/visualMax, 0,0.5, 0) , "Out", "Sine", 0.2, true)
					Text_8.Text = tostring(Text_8.Text and math.floor( (Text_8.Text / visualMax) * (visualMax - visualMin) + visualMin) )
					pcall(options.callback, Text_8.Text)
				end)

				function sliderfunc.Update(value)
					SliderBar_2:TweenSize(UDim2.new((value or 0) / visualMax, 0, 0, 5), "Out", "Sine", 0.2, true)
					SliderBar_3:TweenPosition(UDim2.new((value or 0)/visualMax, 0,0.5, 0) , "Out", "Sine", 0.2, true)
					pcall(function()
						pcall(options.callback, Text_8.Text)
					end)
				end
				return sliderfunc
			end

			function LibraryFunction:AddTextBox(name,options)

				local visualTitle = name or "TextBox"
				local visualplaceholder = options.Placeholder or "Placeholder"
				local visualcallback = options.callback or function() end

				local MainTextBox = Instance.new("Frame")
				local UICorner_20 = Instance.new("UICorner")
				local Text_6 = Instance.new("TextLabel")
				local MainKeybind_2 = Instance.new("Frame")
				local UICorner_21 = Instance.new("UICorner")
				local HeadTitle_2 = Instance.new("TextBox")
				local Text_7 = Instance.new("TextLabel")

				MainTextBox.Name = "MainTextBox"
				MainTextBox.Parent = Right
				MainTextBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
				MainTextBox.BackgroundTransparency = 0.700
				MainTextBox.BorderSizePixel = 0
				MainTextBox.ClipsDescendants = true
				MainTextBox.Size = UDim2.new(0.975000024, 0, 0, 65)

				UICorner_20.CornerRadius = UDim.new(0, 4)
				UICorner_20.Parent = MainTextBox

				Text_6.Name = "Text"
				Text_6.Parent = MainTextBox
				Text_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Text_6.BackgroundTransparency = 1.000
				Text_6.Position = UDim2.new(0, 10, 0, 10)
				Text_6.Size = UDim2.new(0, 40, 0, 12)
				Text_6.ZIndex = 2
				Text_6.Font = Enum.Font.GothamBold
				Text_6.Text = visualTitle
				Text_6.TextColor3 = Color3.fromRGB(96, 82, 116)
				Text_6.TextSize = 11.000
				Text_6.TextXAlignment = Enum.TextXAlignment.Left

				MainKeybind_2.Name = "MainKeybind"
				MainKeybind_2.Parent = MainTextBox
				MainKeybind_2.AnchorPoint = Vector2.new(0.5, 0.5)
				MainKeybind_2.BackgroundColor3 = Color3.fromRGB(13, 13, 15)
				MainKeybind_2.BackgroundTransparency = 1.000
				MainKeybind_2.BorderSizePixel = 0
				MainKeybind_2.Position = UDim2.new(0.5, 0, 0, 40)
				MainKeybind_2.Size = UDim2.new(0.970000029, 0, 0, 30)

				UICorner_21.CornerRadius = UDim.new(0, 6)
				UICorner_21.Parent = MainKeybind_2

				HeadTitle_2.Name = "HeadTitle"
				HeadTitle_2.Parent = MainKeybind_2
				HeadTitle_2.AnchorPoint = Vector2.new(0.5, 0.5)
				HeadTitle_2.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
				HeadTitle_2.BackgroundTransparency = 1.000
				HeadTitle_2.BorderSizePixel = 0
				HeadTitle_2.ClipsDescendants = true
				HeadTitle_2.Position = UDim2.new(0.5, 0, 0.5, 0)
				HeadTitle_2.Size = UDim2.new(0.949999988, 0, 0, 40)
				HeadTitle_2.Font = Enum.Font.GothamBold
				HeadTitle_2.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
				HeadTitle_2.Text = visualplaceholder
				HeadTitle_2.TextColor3 = Color3.fromRGB(255, 255, 255)
				HeadTitle_2.TextSize = 13.000
				HeadTitle_2.TextTransparency = 0.700
				HeadTitle_2.TextXAlignment = Enum.TextXAlignment.Left
				HeadTitle_2.FocusLost:Connect(
					function(ep)
						if ep then
							if #HeadTitle_2.Text > 0 then
								options.callback(HeadTitle_2.Text)
								if disapper then
									HeadTitle_2.Text = ""
								end
							end
						end
					end
				)

				Text_7.Name = "Text"
				Text_7.Parent = MainTextBox
				Text_7.AnchorPoint = Vector2.new(0.5, 0)
				Text_7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Text_7.BackgroundTransparency = 1.000
				Text_7.Position = UDim2.new(0.5, 0, 0, 65)
				Text_7.Size = UDim2.new(0.949999988, 0, 0.349999994, 0)
				Text_7.Visible = false
				Text_7.ZIndex = 2
				Text_7.Text = "nil"
				Text_7.TextColor3 = Color3.fromRGB(255, 255, 255)
				Text_7.TextSize = 12.000
				Text_7.TextTransparency = 0.700
				Text_7.TextWrapped = true
				Text_7.TextXAlignment = Enum.TextXAlignment.Left
				Text_7.TextYAlignment = Enum.TextYAlignment.Top

				local MainTextBox_UIStr0ke = Instance.new("UIStroke")

				MainTextBox_UIStr0ke.Parent = MainTextBox
				MainTextBox_UIStr0ke.Thickness = 1
				MainTextBox_UIStr0ke.LineJoinMode = Enum.LineJoinMode.Round
				MainTextBox_UIStr0ke.Color = Color3.fromRGB(45, 45, 45)
				MainTextBox_UIStr0ke.Transparency = 0
			end

			return LibraryFunction
		end
		return LibraryPage
	end
	return LibraryTab
end
return Library
