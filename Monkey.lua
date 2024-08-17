-- main color is 186, 181, 129

do  
	local ui =  game:GetService("CoreGui").RobloxGui.Modules.Profile.Utils:FindFirstChild("Roxy")  

	if ui then 
		ui:Destroy() 
	end 
end

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Mouse = LocalPlayer:GetMouse()

getgenv().Settings = {
	Key = Enum.KeyCode.LeftControl
}

local function MakeDraggable(topbarobject, object)
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
		local Tween = TweenService:Create(object, TweenInfo.new(.1), {Position = pos})
		Tween:Play()
	end

	topbarobject.InputBegan:Connect(
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

	topbarobject.InputChanged:Connect(
		function(input)
			if
				input.UserInputType == Enum.UserInputType.MouseMovement or
				input.UserInputType == Enum.UserInputType.Touch
			then
				DragInput = input
			end
		end
	)

	UserInputService.InputChanged:Connect(
		function(input)
			if input == DragInput and Dragging then
				Update(input)
			end
		end
	)
end

local function tablefound(ta, object)
	for i,v in pairs(ta) do
		if v == object then
			return true
		end
	end
	return false
end

local function tween(object,waits,...)
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

local function GetXY(GuiObject)
	local Max, May = GuiObject.AbsoluteSize.X, GuiObject.AbsoluteSize.Y
	local Px, Py = math.clamp(Mouse.X - GuiObject.AbsolutePosition.X, 0, Max), math.clamp(Mouse.Y - GuiObject.AbsolutePosition.Y, 0, May)
	return Px/Max, Py/May
end

local function CircleAnim(GuiObject, EndColour, StartColour)
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


local Ripple = function(obj)
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


local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local Roxy = Instance.new("ScreenGui")

Roxy.Name = "Roxy"
Roxy.Parent = game:GetService("CoreGui").RobloxGui.Modules.Profile.Utils
Roxy.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local Library = {}

local function tablefound(ta, object)
	for i,v in pairs(ta) do
		if v == object then
			return true
		end
	end
	return false
end

function Library.new()
	local FocusUI = false

	local PageOrders = -1

	local MainFrame2 = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local UIListLayout = Instance.new("UIListLayout")
	local MainFrame = Instance.new("Frame")
	local UICorner_2 = Instance.new("UICorner")
	local ImageLabel = Instance.new("ImageLabel")
	local ImageLabel_2 = Instance.new("ImageLabel")
	local MainTap = Instance.new("Frame")
	local UICorner_3 = Instance.new("UICorner")
	local ImageButton = Instance.new("ImageButton")
	local ImageButton_2 = Instance.new("ImageButton")
	local Page = Instance.new("Frame")
	local pagesFolder = Instance.new("Folder")
	local UIPageLayout = Instance.new("UIPageLayout")

	MainFrame2.Name = "MainFrame2"
	MainFrame2.Parent = Roxy
	MainFrame2.AnchorPoint = Vector2.new(0.5, 0.5)
	MainFrame2.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
	MainFrame2.BackgroundTransparency = 1.000
	MainFrame2.BorderSizePixel = 0
	MainFrame2.Position = UDim2.new(0.959999979, 0, 0.5, 0)
	MainFrame2.Size = UDim2.new(0, 550, 0.970000029, 0)

	UICorner.Parent = MainFrame2

	UIListLayout.Parent = MainFrame2
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
	UIListLayout.Padding = UDim.new(0, 5)

	MainFrame.Name = "MainFrame"
	MainFrame.Parent = Roxy
	MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	MainFrame.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
	MainFrame.BorderSizePixel = 0
	MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
	MainFrame.Size = UDim2.new(0, 0, 0, 0)
	MainFrame.ClipsDescendants = true

	TweenService:Create(MainFrame,TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{Size = UDim2.new(0, 550, 0, 600)}):Play()


	UICorner_2.CornerRadius = UDim.new(0, 5)
	UICorner_2.Parent = MainFrame

	ImageLabel.Parent = MainFrame
	ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	ImageLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	ImageLabel.BackgroundTransparency = 1.000
	ImageLabel.BorderSizePixel = 0
	ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
	ImageLabel.Size = UDim2.new(1.10000002, 2, 1.10000002, 5)
	ImageLabel.Image = "rbxassetid://5028857084"
	ImageLabel.ImageColor3 = Color3.fromRGB(0, 0, 0)

	ImageLabel_2.Parent = MainFrame
	ImageLabel_2.AnchorPoint = Vector2.new(0.5, 0.5)
	ImageLabel_2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	ImageLabel_2.BackgroundTransparency = 1.000
	ImageLabel_2.BorderSizePixel = 0
	ImageLabel_2.Position = UDim2.new(0.0799999982, 0, 0.0700000003, 0)
	ImageLabel_2.Size = UDim2.new(0.14, 0, 0.13, 0)
	ImageLabel_2.Image = "rbxassetid://16796144919"


	MainTap.Name = "MainTap"
	MainTap.Parent = MainFrame
	MainTap.AnchorPoint = Vector2.new(0.5, 0.5)
	MainTap.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	MainTap.BackgroundTransparency = 0.100
	MainTap.BorderSizePixel = 0
	MainTap.Position = UDim2.new(0.550000012, 0, 0.0700000003, 0)
	MainTap.Size = UDim2.new(0.800000012, 0, 0, 35)

	UICorner_3.CornerRadius = UDim.new(0, 5)
	UICorner_3.Parent = MainTap


	ImageButton.Parent = MainTap
	ImageButton.AnchorPoint = Vector2.new(0, 0.5)
	ImageButton.BackgroundTransparency = 1.000
	ImageButton.Position = UDim2.new(-0.0299999993, 0, 0.5, 0)
	ImageButton.Rotation = 90.000
	ImageButton.Size = UDim2.new(0, 20, 0, 20)
	ImageButton.ZIndex = 7
	ImageButton.Image = "http://www.roblox.com/asset/?id=6282522798"

	ImageButton_2.Parent = MainTap
	ImageButton_2.AnchorPoint = Vector2.new(0, 0.5)
	ImageButton_2.BackgroundTransparency = 1.000
	ImageButton_2.Position = UDim2.new(1, 0, 0.5, 0)
	ImageButton_2.Rotation = 270.000
	ImageButton_2.Size = UDim2.new(0, 20, 0, 20)
	ImageButton_2.ZIndex = 7
	ImageButton_2.Image = "http://www.roblox.com/asset/?id=6282522798"

	MakeDraggable(MainFrame,MainFrame)

	local Scroll_Tap = Instance.new("ScrollingFrame")
	local UIListLayout_2 = Instance.new("UIListLayout")
	local UIPadding = Instance.new("UIPadding")

	Scroll_Tap.Name = "Scroll_Tap"
	Scroll_Tap.Parent = MainTap
	Scroll_Tap.Active = true
	Scroll_Tap.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Scroll_Tap.BackgroundTransparency = 1.000
	Scroll_Tap.BorderSizePixel = 0
	Scroll_Tap.Size = UDim2.new(1, 0, 1, 0)
	Scroll_Tap.CanvasSize = UDim2.new(0, 91, 0, 0)
	Scroll_Tap.ScrollBarThickness = 0

	UIListLayout_2.Parent = Scroll_Tap
	UIListLayout_2.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout_2.Padding = UDim.new(0, 5)

	UIPadding.Parent = Scroll_Tap
	UIPadding.PaddingLeft = UDim.new(0, 10)
	UIPadding.PaddingTop = UDim.new(0, 5)

	Page.Name = "Page"
	Page.Parent = MainFrame
	Page.AnchorPoint = Vector2.new(0.5, 0.5)
	Page.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Page.BackgroundTransparency = 1.000
	Page.BorderSizePixel = 0
	Page.ClipsDescendants = true
	Page.Position = UDim2.new(0.5, 0, 0.550000012, 0)
	Page.Size = UDim2.new(0.949999988, 0, 0.850000024, 0)

	pagesFolder.Name = "pagesFolder"
	pagesFolder.Parent = Page

	UIPageLayout.Parent = pagesFolder
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
					TweenInfo.new(0, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
					{Size = UDim2.new(0, 0, 0, 0)}
				):Play()
			else
				TweenService:Create(
					MainFrame,
					TweenInfo.new(0, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
					{Size = UDim2.new(0, 550, 0, 600)}
				):Play()
				repeat wait() 
				until MainFrame.Size == UDim2.new(0, 550, 0, 600)
				uitoggled = false
			end
		end
	end)

	local LibraryTab = {}

	function LibraryTab:CreateTap(Title)
		PageOrders = PageOrders + 1

		local name = tostring(Title) or tostring(math.random(500,100000))

		local TapMain = Instance.new("Frame")
		local UICorner_4 = Instance.new("UICorner")
		local ImageLabel_3 = Instance.new("ImageLabel")
		local Main = Instance.new("TextLabel")
		local ButtonBar = Instance.new("TextButton")

		TapMain.Name = name.."_Tap"
		TapMain.Parent = Scroll_Tap
		TapMain.AnchorPoint = Vector2.new(0.5, 0.5)
		TapMain.BackgroundColor3 = Color3.fromRGB(163, 162, 165)
		TapMain.BorderSizePixel = 0
		TapMain.ClipsDescendants = true
		TapMain.Position = UDim2.new(0.550000012, 0, 0.0700000003, 0)
		TapMain.ClipsDescendants = true
		TapMain.BackgroundTransparency = 0.6
		--TapMain.Size = UDim2.new(0, 71, 0, 25)

		UICorner_4.CornerRadius = UDim.new(0, 4)
		UICorner_4.Parent = TapMain

		ImageLabel_3.Parent = TapMain
		ImageLabel_3.AnchorPoint = Vector2.new(0.5, 0.5)
		ImageLabel_3.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		ImageLabel_3.BackgroundTransparency = 1.000
		ImageLabel_3.BorderSizePixel = 0
		ImageLabel_3.Position = UDim2.new(0.5, 0, 0.5, 0)
		ImageLabel_3.Size = UDim2.new(1.10000002, 2, 1.10000002, 3)
		ImageLabel_3.Image = "rbxassetid://5028857084"
		ImageLabel_3.ImageColor3 = Color3.fromRGB(249, 53, 139)

		Main.Name = "Main"
		Main.Parent = TapMain
		Main.AnchorPoint = Vector2.new(0.5, 0.5)
		Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Main.BackgroundTransparency = 1.000
		Main.Position = UDim2.new(0.5, 0, 0.5, 0)
		Main.Size = UDim2.new(0, 31, 0, 15)
		Main.ZIndex = 2
		Main.Font = Enum.Font.GothamBold
		Main.Text = tostring(Title)
		Main.TextColor3 = Color3.fromRGB(255, 255, 255)
		Main.TextSize = 15.000

		ButtonBar.Name = "ButtonBar"
		ButtonBar.Parent = TapMain
		ButtonBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ButtonBar.BackgroundTransparency = 1.000
		ButtonBar.BorderSizePixel = 0
		ButtonBar.Size = UDim2.new(1, 0, 1, 0)
		ButtonBar.AutoButtonColor = false
		ButtonBar.Text = ""
		ButtonBar.TextColor3 = Color3.fromRGB(255, 255, 255)
		ButtonBar.TextSize = 14.000
		ButtonBar.AutoButtonColor = false

		if TapMain.Name == name.."_Tap" then
			TapMain.Size = UDim2.new(0, 40 + Main.TextBounds.X, 0, 25)
			ButtonBar.Size = UDim2.new(0, 40 + Main.TextBounds.X, 0, 25)
			Main.Size = UDim2.new(0, 40 + Main.TextBounds.X, 0, 25)
			ImageLabel_3.Size = UDim2.new(0, 40 + Main.TextBounds.X, 0, 25)
		end

		local MainPage = Instance.new("Frame")
		local UICorner_5 = Instance.new("UICorner")

		MainPage.Name = name.."_MainPage"
		MainPage.Parent = pagesFolder
		MainPage.Active = true
		MainPage.AnchorPoint = Vector2.new(0.5, 0.5)
		MainPage.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
		MainPage.BackgroundTransparency = 0.800
		MainPage.BorderSizePixel = 0
		MainPage.ClipsDescendants = true
		MainPage.Position = UDim2.new(0.5, 0, 0.5, 0)
		MainPage.Size = UDim2.new(1, 0, 0.99000001, 0)

		UICorner_5.Parent = MainPage

		MainPage.LayoutOrder = PageOrders


		--

		local ImageLabel_4 = Instance.new("ImageLabel")
		local MainKeybind = Instance.new("Frame")
		local UICorner_6 = Instance.new("UICorner")
		local gay1 = Instance.new("ImageLabel")
		local HeadTitle = Instance.new("TextBox")
		ImageLabel_4.Parent = MainPage
		ImageLabel_4.AnchorPoint = Vector2.new(0.5, 0.5)
		ImageLabel_4.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
		ImageLabel_4.BackgroundTransparency = 1.000
		ImageLabel_4.BorderSizePixel = 0
		ImageLabel_4.Position = UDim2.new(0.5, 0, 0.5, 0)
		ImageLabel_4.Size = UDim2.new(1.10000002, 0, 1.10000002, 0)
		ImageLabel_4.Image = "rbxassetid://5028857084"
		ImageLabel_4.ImageColor3 = Color3.fromRGB(15, 15, 15)

		MainKeybind.Name = "MainKeybind"
		MainKeybind.Parent = MainPage
		MainKeybind.AnchorPoint = Vector2.new(0.5, 0)
		MainKeybind.BackgroundColor3 = Color3.fromRGB(13, 13, 15)
		MainKeybind.BackgroundTransparency = 0.700
		MainKeybind.BorderSizePixel = 0
		MainKeybind.Position = UDim2.new(0.5, 0, 0, 5)
		MainKeybind.Size = UDim2.new(0.970000029, 0, 0, 30)

		UICorner_6.Parent = MainKeybind

		gay1.Name = "gay1"
		gay1.Parent = MainKeybind
		gay1.AnchorPoint = Vector2.new(0, 0.5)
		gay1.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
		gay1.BackgroundTransparency = 1.000
		gay1.BorderSizePixel = 0
		gay1.Position = UDim2.new(0, 15, 0.5, 0)
		gay1.Size = UDim2.new(0, 25, 0, 25)
		gay1.Image = "http://www.roblox.com/asset/?id=6031154871"

		HeadTitle.Name = "HeadTitle"
		HeadTitle.Parent = MainKeybind
		HeadTitle.AnchorPoint = Vector2.new(0.5, 0.5)
		HeadTitle.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
		HeadTitle.BackgroundTransparency = 1.000
		HeadTitle.BorderSizePixel = 0
		HeadTitle.ClipsDescendants = true
		HeadTitle.Position = UDim2.new(0.5, 20, 0.5, 0)
		HeadTitle.Size = UDim2.new(0.899999976, 0, 0, 40)
		HeadTitle.Font = Enum.Font.GothamBold
		HeadTitle.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
		HeadTitle.PlaceholderText = "Search"
		HeadTitle.Text = ""
		HeadTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
		HeadTitle.TextSize = 13.000
		HeadTitle.TextXAlignment = Enum.TextXAlignment.Left

		local HeadTitle_UIStr0ke = Instance.new("UIStroke")

		HeadTitle_UIStr0ke.Parent = MainKeybind
		HeadTitle_UIStr0ke.Thickness = 1
		HeadTitle_UIStr0ke.LineJoinMode = Enum.LineJoinMode.Round
		HeadTitle_UIStr0ke.Color = Color3.fromRGB(45, 45, 45)
		HeadTitle_UIStr0ke.Transparency = 0

		HeadTitle.MouseEnter:Connect(function()
			tween( HeadTitle_UIStr0ke,0.3,{Color = Color3.fromRGB(186, 181, 129) , Transparency = 0 })
		end)
		HeadTitle.MouseLeave:Connect(function()
			tween( HeadTitle_UIStr0ke,0.3,{Color = Color3.fromRGB(255,255,255) , Transparency = 0.85 })
		end)

		-- [[ Page Example Here ]]

		local left = Instance.new("Frame")
		local UICorner_7 = Instance.new("UICorner")
		local Scroll_Left = Instance.new("ScrollingFrame")
		local UIListLayout_3 = Instance.new("UIListLayout")
		local UIPadding_2 = Instance.new("UIPadding")

		left.Name = "left"
		left.Parent = MainPage
		left.AnchorPoint = Vector2.new(0.5, 0.5)
		left.BackgroundColor3 = Color3.fromRGB(249, 53, 139)
		left.BackgroundTransparency = 1.000
		left.BorderSizePixel = 0
		left.ClipsDescendants = true
		left.Position = UDim2.new(0.25, 0, 0.600000024, -35)
		left.Size = UDim2.new(0.479999989, 0, 0.970000029, -35)

		UICorner_7.CornerRadius = UDim.new(0, 4)
		UICorner_7.Parent = left


		Scroll_Left.Name = "Scroll_Left"
		Scroll_Left.Parent = left
		Scroll_Left.Active = true
		Scroll_Left.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Scroll_Left.BackgroundTransparency = 1.000
		Scroll_Left.BorderSizePixel = 0
		Scroll_Left.Size = UDim2.new(1, 0, 1, 0)
		Scroll_Left.CanvasSize = UDim2.new(0, 0, 0, 397)
		Scroll_Left.ScrollBarThickness = 0

		UIListLayout_3.Parent = Scroll_Left
		UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout_3.Padding = UDim.new(0, 5)

		UIPadding_2.Parent = Scroll_Left
		UIPadding_2.PaddingLeft = UDim.new(0, 5)
		UIPadding_2.PaddingTop = UDim.new(0, 5)


		local Right_2 = Instance.new("Frame")
		local UICorner_26 = Instance.new("UICorner")
		local Scroll_Right0 = Instance.new("ScrollingFrame")
		local UIListLayout_6 = Instance.new("UIListLayout")
		local UIPadding_5 = Instance.new("UIPadding")



		Right_2.Name = "Right"
		Right_2.Parent = MainPage
		Right_2.AnchorPoint = Vector2.new(0.5, 0.5)
		Right_2.BackgroundColor3 = Color3.fromRGB(249, 53, 139)
		Right_2.BackgroundTransparency = 1.000
		Right_2.BorderSizePixel = 0
		Right_2.ClipsDescendants = true
		Right_2.Position = UDim2.new(0.74000001, 0, 0.600000024, -35)
		Right_2.Size = UDim2.new(0.479999989, 0, 0.970000029, -35)

		UICorner_26.CornerRadius = UDim.new(0, 4)
		UICorner_26.Parent = Right_2

		Scroll_Right0.Name = "Scroll_Right0"
		Scroll_Right0.Parent = Right_2
		Scroll_Right0.Active = true
		Scroll_Right0.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Scroll_Right0.BackgroundTransparency = 1.000
		Scroll_Right0.BorderSizePixel = 0
		Scroll_Right0.Size = UDim2.new(1, 0, 1, 0)
		Scroll_Right0.ScrollBarThickness = 0
		Scroll_Right0.CanvasSize = UDim2.new(0, 0, 0, 397)

		UIListLayout_6.Parent = Scroll_Right0
		UIListLayout_6.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout_6.Padding = UDim.new(0, 5)

		UIPadding_5.Parent = Scroll_Right0
		UIPadding_5.PaddingLeft = UDim.new(0, 5)
		UIPadding_5.PaddingTop = UDim.new(0, 5)

		local function GetType(value)
			if value == 1 then
				return Scroll_Left
			elseif value == 2 then
				return Scroll_Right0
			else
				return Scroll_Left
			end
		end

		--UIListLayout_3:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		--	if UIListLayout_3.AbsoluteContentSize.Y > UIListLayout_6.AbsoluteContentSize.Y then
		--		Scroll_Left.CanvasSize = UDim2.new(0, 0, 0, UIListLayout_3.AbsoluteContentSize.Y + 15)
		--		--Scroll_Left.CanvasSize = UDim2.new(0, 0, 0, UIListLayout_3.AbsoluteContentSize.Y)
		--	end
		--end)
		--UIListLayout_6:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		--	if UIListLayout_6.AbsoluteContentSize.Y > UIListLayout_3.AbsoluteContentSize.Y then
		--		Scroll_Right0.CanvasSize = UDim2.new(0, 0, 0, UIListLayout_6.AbsoluteContentSize.Y + 15)
		--		--Scroll_Right0.CanvasSize = UDim2.new(0, 0, 0, UIListLayout_6.AbsoluteContentSize.Y)
		--	end
		--end)
		
		game:GetService("RunService").PostSimulation:Connect(function()
			Scroll_Left.CanvasSize = UDim2.new(0, 0, 0, UIListLayout_3.AbsoluteContentSize.Y + 15)
			Scroll_Right0.CanvasSize = UDim2.new(0, 0, 0, UIListLayout_6.AbsoluteContentSize.Y + 15)
		end)


		-- [[ End ]]

		ButtonBar.MouseButton1Click:connect(function()
			if MainPage.Name == name.."_MainPage" then
				UIPageLayout:JumpToIndex(MainPage.LayoutOrder)
				for i ,v in next , Scroll_Tap:GetChildren() do
					if v:IsA("Text") then
						TweenService:Create(
							v,
							TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{TextTransparency = 0.65}
						):Play()
					end
				end
				for i ,v in next , Scroll_Tap:GetChildren() do
					if v:IsA("Frame") then
						TweenService:Create(
							v,
							TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{BackgroundTransparency = 0.6}
						):Play()
					end
				end
				TweenService:Create(
					TapMain,
					TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{BackgroundTransparency = 0}
				):Play()
			end
		end)

		if FocusUI == false then
			TweenService:Create(
				TapMain,
				TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{BackgroundTransparency = 0.6}
			):Play()
			MainPage.Visible = true
			MainPage.Name  = name.."_MainPage"
			for i ,v in next , Scroll_Tap:GetChildren() do
				if i == 1 then
					TweenService:Create(
						TapMain,
						TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundTransparency = 0}
					):Play()
				end
			end
			FocusUI  = true
		end

		local LibraryPage = {}

		function LibraryPage:CreatePage(Title,Type)

			local Main_2 = Instance.new("Frame")
			local UICorner_8 = Instance.new("UICorner")
			local MainSection = Instance.new("Frame")
			local UICorner_9 = Instance.new("UICorner")
			local MainSection_2 = Instance.new("Frame")
			local UICorner_10 = Instance.new("UICorner")
			local TextLabel = Instance.new("TextLabel")

			Main_2.Name = "Main"
			Main_2.Parent = GetType(Type)
			Main_2.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
			Main_2.BorderSizePixel = 0
			Main_2.ClipsDescendants = true
			Main_2.Position = UDim2.new(0.0199362058, 0, 0.0109949457, 0)
			Main_2.Size = UDim2.new(0.979999959, 0, -0.202333272, 377)

			UICorner_8.CornerRadius = UDim.new(0, 6)
			UICorner_8.Parent = Main_2

			MainSection.Name = "MainSection"
			MainSection.Parent = Main_2
			MainSection.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
			MainSection.BorderSizePixel = 0
			MainSection.ClipsDescendants = true
			MainSection.Size = UDim2.new(1, 0, 0, 23)

			UICorner_9.CornerRadius = UDim.new(0, 6)
			UICorner_9.Parent = MainSection

			MainSection_2.Name = "MainSection"
			MainSection_2.Parent = MainSection
			MainSection_2.AnchorPoint = Vector2.new(0.5, 0)
			MainSection_2.BackgroundColor3 = Color3.fromRGB(186, 181, 129)
			MainSection_2.BackgroundTransparency = 0.200
			MainSection_2.BorderSizePixel = 0
			MainSection_2.ClipsDescendants = true
			MainSection_2.Position = UDim2.new(0.5, 0, -0.100000001, 0)
			MainSection_2.Size = UDim2.new(1, 0, 0, 4)

			UICorner_10.CornerRadius = UDim.new(0, 6)
			UICorner_10.Parent = MainSection_2

			TextLabel.Parent = MainSection
			TextLabel.AnchorPoint = Vector2.new(0, 0.5)
			TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TextLabel.BackgroundTransparency = 1.000
			TextLabel.Position = UDim2.new(0, 10, 0.5, 5)
			TextLabel.Size = UDim2.new(0, 30, 0, 15)
			TextLabel.ZIndex = 2
			TextLabel.Font = Enum.Font.GothamBold
			TextLabel.Text = tostring(Title)
			TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			TextLabel.TextSize = 14.000
			TextLabel.TextTransparency = 0.400
			TextLabel.TextXAlignment = Enum.TextXAlignment.Left

			local Right = Instance.new("Frame")
			local UIListLayout_4 = Instance.new("UIListLayout")
			local UIPadding_3 = Instance.new("UIPadding")
			Right.Name = "Right"
			Right.Parent = Main_2
			Right.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
			Right.BackgroundTransparency = 1.000
			Right.BorderSizePixel = 0
			Right.ClipsDescendants = true
			Right.Position = UDim2.new(0, 0, 0, 23)
			Right.Size = UDim2.new(1, 0, 0, 357)

			UIListLayout_4.Parent = Right
			UIListLayout_4.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout_4.Padding = UDim.new(0, 5)

			UIPadding_3.Parent = Right
			UIPadding_3.PaddingLeft = UDim.new(0, 5)
			UIPadding_3.PaddingTop = UDim.new(0, 7)

			game:GetService("RunService").Stepped:Connect(function ()
				pcall(function ()
					Scroll_Tap.CanvasSize = UDim2.new(0,UIListLayout_2.AbsoluteContentSize.X + 10,0,0)
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
				MainToggle_3.ImageColor3 = Color3.fromRGB(186, 181, 129)
			
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
			
				-- Add the Change function to the visual table
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
				Frame_2.BackgroundColor3 = Color3.fromRGB(186, 181, 129)
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
							{TextColor3 = Color3.fromRGB(186, 181, 129)}
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
							{TextColor3 = Color3.fromRGB(186, 181, 129)}
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
							{TextColor3 = Color3.fromRGB(186, 181, 129)}
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
							{TextColor3 = Color3.fromRGB(186, 181, 129)}
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
				SliderBar_2.BackgroundColor3 = Color3.fromRGB(186, 181, 129)
				SliderBar_2.BorderSizePixel = 0
				SliderBar_2.Size = UDim2.new((visualDefault or 0)/visualMax, 0, 0, 5)

				UICorner_24.CornerRadius = UDim.new(0, 4)
				UICorner_24.Parent = SliderBar_2

				SliderBar_3.Name = "SliderBar"
				SliderBar_3.Parent = SliderBar
				SliderBar_3.AnchorPoint = Vector2.new(0.5, 0.5)
				SliderBar_3.BackgroundColor3 = Color3.fromRGB(186, 181, 129)
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
				Text_6.TextColor3 = Color3.fromRGB(186, 181, 129)
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
	ImageButton.MouseButton1Down:Connect(function()
		UIPageLayout:Previous()
		TweenService:Create(
			ImageButton,
			TweenInfo.new(0.1, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out),
			{Size = UDim2.new(0, 10, 0, 10)}
		):Play()
		repeat wait() until ImageButton.Size == UDim2.new(0, 10, 0, 10)
		TweenService:Create(
			ImageButton,
			TweenInfo.new(0.1, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out),
			{Size = UDim2.new(0, 20, 0, 20)}
		):Play()
		for i ,v in next , Scroll_Tap:GetChildren() do
			if v:IsA("Text") then
				TweenService:Create(
					v,
					TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{TextTransparency = 0.65}
				):Play()
			end
		end
		for i ,v in next , Scroll_Tap:GetChildren() do
			if v:IsA("Frame") then
				TweenService:Create(
					v,
					TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{BackgroundTransparency = 0.6}
				):Play()
			end
		end

		for i ,v in next , Scroll_Tap:GetChildren() do

			local ff = tostring(UIPageLayout.CurrentPage):split("_")[1]
			print(ff,v.Name)
			if v:IsA("Frame") and (ff.."_Tap") == (v.Name) then
				TweenService:Create(
					v,
					TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{BackgroundTransparency = 0}
				):Play()
			end
		end
		for i ,v in next , Scroll_Tap:GetChildren() do
			if v:IsA("TextButton") and v.Name == tostring(UIPageLayout.CurrentPage):gsub("%MainPage", "ButtonBar") then
				TweenService:Create(
					v,
					TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{TextTransparency = 0}
				):Play()
				TweenService:Create(
					v,
					TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{BackgroundTransparency = 0}
				):Play()
			elseif v:IsA("TextButton") then
				TweenService:Create(
					v,
					TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{TextTransparency = 0.5}
				):Play()
				TweenService:Create(
					v,
					TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{BackgroundTransparency = 0.65}
				):Play()
			end
		end
	end)
	ImageButton_2.MouseButton1Down:Connect(function()
		UIPageLayout:Next()
		TweenService:Create(
			ImageButton_2,
			TweenInfo.new(0.1, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out),
			{Size = UDim2.new(0, 10, 0, 10)}
		):Play()
		repeat wait() until ImageButton_2.Size == UDim2.new(0, 10, 0, 10)
		TweenService:Create(
			ImageButton_2,
			TweenInfo.new(0.1, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out),
			{Size = UDim2.new(0, 20, 0, 20)}
		):Play()
		for i ,v in next , Scroll_Tap:GetChildren() do
			if v:IsA("Text") then
				TweenService:Create(
					v,
					TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{TextTransparency = 0.65}
				):Play()
			end
		end
		for i ,v in next , Scroll_Tap:GetChildren() do
			if v:IsA("Frame") then
				TweenService:Create(
					v,
					TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{BackgroundTransparency = 0.6}
				):Play()
			end
		end

		for i ,v in next , Scroll_Tap:GetChildren() do

			local ff = tostring(UIPageLayout.CurrentPage):split("_")[1]
			print(ff,v.Name)
			if v:IsA("Frame") and (ff.."_Tap") == (v.Name) then
				TweenService:Create(
					v,
					TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{BackgroundTransparency = 0}
				):Play()
			end
		end
		for i ,v in next , Scroll_Tap:GetChildren() do
			if v:IsA("TextButton") and v.Name == tostring(UIPageLayout.CurrentPage):gsub("%MainPage", "ButtonBar") then

				TweenService:Create(
					v,
					TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{TextTransparency = 0}
				):Play()
				TweenService:Create(
					v,
					TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{BackgroundTransparency = 0}
				):Play()
			elseif v:IsA("TextButton") then
				TweenService:Create(
					v,
					TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{TextTransparency = 0.5}
				):Play()
				TweenService:Create(
					v,
					TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{BackgroundTransparency = 0.65}
				):Play()
			end
		end
	end)
	return LibraryTab
end
return Library
