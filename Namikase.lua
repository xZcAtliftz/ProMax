local luxurylibrary = {}

local Mouse = game:GetService("Players").LocalPlayer:GetMouse()

local function tween(object,waits,Style,...)
  game:GetService("TweenService"):Create(object,TweenInfo.new(waits,Style),...):Play()
end

local function gradient_obj(args)
  tween(args,2.5,Enum.EasingStyle.Linear,{Offset = Vector2.new(-1,0)})
  task.wait(2.5)
  args.Offset = Vector2.new(1, 0)
  args.Rotation = 180
  tween(args,2.5,Enum.EasingStyle.Linear,{Offset = Vector2.new(-1,0)})
  task.wait(2.5)
  args.Offset = Vector2.new(1, 0)
  args.Rotation = 0
end

local function InitDupe(args)
  if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild(args) then
    game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild(args):Destroy()
  end
end

local ActualTypes = {
  Shadow = "ImageLabel",
  Circle = "ImageLabel",
  Circle2 = "ImageLabel",
  Circle3 = "ImageLabel",
}

local Properties = {
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
  Circle2 = {
    BackgroundTransparency = 1,
    Image = "http://www.roblox.com/asset/?id=14970076293"
  },
  Circle3 = {
    BackgroundTransparency = 1,
    Image = "http://www.roblox.com/asset/?id=15536419557"
  },
}

local Types = {
  "Shadow",
  "Circle",
  "Circle2",
  "Circle3",
}

local FindType = function(String)
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

local GetXY = function(GuiObject)
  local Max, May = GuiObject.AbsoluteSize.X, GuiObject.AbsoluteSize.Y
  local Px, Py = math.clamp(Mouse.X - GuiObject.AbsolutePosition.X, 0, Max), math.clamp(Mouse.Y - GuiObject.AbsolutePosition.Y, 0, May)
  return Px/Max, Py/May
end

local CircleAnim = function(Type,GuiObject, EndColour, StartColour)
  local PX, PY = GetXY(GuiObject)
  local Circle = Objects.new(Type)
  Circle.Size = UDim2.fromScale(0,0)
  Circle.Position = UDim2.fromScale(PX,PY)
  Circle.ImageColor3 = StartColour or GuiObject.ImageColor3
  Circle.ZIndex = 200
  Circle.Parent = GuiObject
  local Size = GuiObject.AbsoluteSize.X
  game:GetService("TweenService"):Create(Circle, TweenInfo.new(0.5), {Position = UDim2.fromScale(PX,PY) - UDim2.fromOffset(Size/2,Size/2), ImageTransparency = 1, ImageColor3 = EndColour, Size = UDim2.fromOffset(Size,Size)}):Play()
  spawn(function()
    wait(0.5)
    Circle:Destroy()
  end)
end

local ThemeList = {
  ["Luxury"] = {
    ["Color"] = Color3.fromRGB(222, 197, 70),
    ["Color2"] = Color3.fromRGB(179, 159, 56),
    ["Background"] = Color3.fromRGB(21,21,21),
    ["TextColor"] = Color3.fromRGB(255,255,255),
    ["RichText_Color"] = tostring("255,255,255"),
    ["RichText_Color2"] = tostring("222, 197, 70"),
    ["Sec_TextColor"] = Color3.fromRGB(255, 255, 255),
    ["Console"] = Color3.fromRGB(30,30,30),
    ["Logo"] = "rbxassetid://16796144919",
    ["Logo Size"] = UDim2.new(0.614,0,1.657,0),
    ["Logo Loading"] = "rbxassetid://15552824720",
    ["Logo Position"] = UDim2.new(0.442,0,-0.441,0),
    ["Logo Size Loading"] = UDim2.new(0.35,0,0.45,0),
  },
  ["RoyX"] = {
    ["Color"] = Color3.fromRGB(78, 158, 255),
    ["Color2"] = Color3.fromRGB(20, 169, 249),
    ["Background"] = Color3.fromRGB(255,255,255),
    ["TextColor"] = Color3.fromRGB(0, 0, 0),
    ["RichText_Color"] = tostring("0,0,0"),
    ["RichText_Color2"] = tostring("20, 169, 249"),
    ["Sec_TextColor"] = Color3.fromRGB(68,68,68),
    ["Console"] = Color3.fromRGB(235,235,235),
    ["Logo"] = "rbxassetid://15536117564",
    ["Logo Size"] = UDim2.new(0.753,0,2.031,0),
    ["Logo Loading"] = "rbxassetid://15536117564",
    ["Logo Position"] = UDim2.new(0.357,0,-0.708,0),
    ["Logo Size Loading"] = UDim2.new(0.35,0,0.45,0),
  }
}

local Theme = function(args,style)
  for i,v in pairs(ThemeList) do
    if args == i then
      for i,v in pairs(v) do
        if style == i then
          return v
        end
      end
    end
  end
end

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
    local Tween = game:GetService("TweenService"):Create(object, TweenInfo.new(0.2), {Position = pos})
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

  game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == DragInput and Dragging then
      Update(input)
    end
  end)
end

task.spawn(function()
  luxurylibrary.Init = function(args,options)
    local Name = options.Name or "Hello, "..game:GetService("Players").LocalPlayer.Name
    local Desc = options.Desc or "Welcome to Luxury Hub"
    local Animation = options.Animation or true
    local ThemeColor = options.Theme or "Luxury"
    local partner_Name = options.PName or "LUXURY"
    local partner_Logo = options.Logo or 0

    InitDupe("luxury.ui")

    local luxuryui = Instance.new("ScreenGui")
    luxuryui.Name = "luxury.ui"
    luxuryui.Parent = game:GetService("Players").LocalPlayer.PlayerGui
    luxuryui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local Configuration = Instance.new("Configuration")
    Configuration.Parent = luxuryui

    if args then
      Configuration:SetAttribute("NAME",Name)
      Configuration:SetAttribute("DESC",Desc)
      Configuration:SetAttribute("ANIMATION",Animation)
      Configuration:SetAttribute("THEME",ThemeColor)
      Configuration:SetAttribute("PNAME",partner_Name)
      Configuration:SetAttribute("LOGO",partner_Logo)
    end

    luxurylibrary.create = function()

      local layout = -1
      local focus = false

      if Configuration:GetAttribute("NAME") ~= (nil or "") and Configuration:GetAttribute("DESC") ~= (nil or "") then

        local main = Instance.new("Frame")
        local uicorner = Instance.new("UICorner")
        local select_frame = Instance.new("Frame")
        local UICorner = Instance.new("UICorner")

        local function load()
          local loading_frame = Instance.new("Frame")
          local uicorner = Instance.new("UICorner")
          local ImageLabel = Instance.new("ImageLabel")
          local TextLabel = Instance.new("TextLabel")
          local ImageLabel_2 = Instance.new("ImageLabel")

          if game:GetService("Lighting"):FindFirstChild("Blur Effect") then
            game:GetService("Lighting"):FindFirstChild("Blur Effect"):Destroy()
          end

          local blur = Instance.new("BlurEffect",game:GetService("Lighting"))
          blur.Size = 24
          blur.Name = "Blur Effect"

          loading_frame.Name = "loading_frame"
          loading_frame.Parent = luxuryui
          loading_frame.Active = true
          loading_frame.AnchorPoint = Vector2.new(0.5, 0.5)
          loading_frame.BackgroundColor3 = Theme(Configuration:GetAttribute("THEME"),"Background")
          loading_frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
          loading_frame.BorderSizePixel = 0
          loading_frame.ClipsDescendants = true
          loading_frame.Position = UDim2.new(0.5, 0, 0.5, 0)
          loading_frame.Size = UDim2.new(0, 0, 0, 0)
          loading_frame.ZIndex = 999

          uicorner.CornerRadius = UDim.new(0, 15)
          uicorner.Name = "uicorner"
          uicorner.Parent = loading_frame

          ImageLabel.Parent = loading_frame
          ImageLabel.Active = true
          ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
          ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
          ImageLabel.BackgroundTransparency = 1.000
          ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
          ImageLabel.BorderSizePixel = 0
          ImageLabel.Position = UDim2.new(0.5, 0, 0.300000012, 0)
          ImageLabel.Size = Theme(Configuration:GetAttribute("THEME"),"Logo Size Loading")
          ImageLabel.Image = Theme(Configuration:GetAttribute("THEME"),"Logo Loading")
          ImageLabel.ImageTransparency = 1

          TextLabel.Parent = loading_frame
          TextLabel.Active = true
          TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
          TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
          TextLabel.BackgroundTransparency = 1.000
          TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
          TextLabel.BorderSizePixel = 0
          TextLabel.Position = UDim2.new(0.5, 0, 0.469999999, 0)
          TextLabel.Size = UDim2.new(0.641147435, 0, 0.08130081, 0)
          TextLabel.FontFace = Font.fromId(12187373592,Enum.FontWeight.Bold)
          TextLabel.Text = "Welcome to Luxury Hub  Hope you have a better experience."
          TextLabel.TextColor3 = Theme(Configuration:GetAttribute("THEME"),"Sec_TextColor")
          TextLabel.TextScaled = true
          TextLabel.TextSize = 20.000
          TextLabel.TextWrapped = true
          TextLabel.TextTransparency = 1

          ImageLabel_2.Parent = loading_frame
          ImageLabel_2.Active = true
          ImageLabel_2.AnchorPoint = Vector2.new(0.5, 0.5)
          ImageLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
          ImageLabel_2.BackgroundTransparency = 1.000
          ImageLabel_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
          ImageLabel_2.BorderSizePixel = 0
          ImageLabel_2.Position = UDim2.new(0.500176907, 0, 0.552845538, 0)
          ImageLabel_2.Size = UDim2.new(0.0468831956, 0, 0.0601626001, 0)
          ImageLabel_2.Image = "rbxassetid://15551798247"
          ImageLabel_2.ImageColor3 = Theme(Configuration:GetAttribute("THEME"),"Color")
          ImageLabel_2.ImageTransparency = 1

          tween(loading_frame,0.5,Enum.EasingStyle.Back,{Size = UDim2.new(0.504999995, 0, 0.75, 0)})
          task.wait(2)
          tween(ImageLabel,0.25,Enum.EasingStyle.Quart,{ImageTransparency = 0})
          tween(TextLabel,0.25,Enum.EasingStyle.Quart,{TextTransparency = 0})
          task.wait(1.5)
          tween(ImageLabel_2,0.25,Enum.EasingStyle.Quart,{ImageTransparency = 0})

          task.spawn(function()
            while task.wait() do
              tween(ImageLabel_2,0.25,Enum.EasingStyle.Quart,{Rotation = ImageLabel_2.Rotation + 20})
            end
          end)

          local function DL()
            delay(5,function()
              tween(ImageLabel_2,0.25,Enum.EasingStyle.Quart,{ImageTransparency = 1})
              task.wait(2)
              tween(TextLabel,0.25,Enum.EasingStyle.Quart,{TextTransparency = 1})
              task.wait(1)
              tween(ImageLabel,1,Enum.EasingStyle.Back,{Position = UDim2.new(0.5, 0, 0.45, 0)})
              task.wait(1)
              tween(ImageLabel,1,Enum.EasingStyle.Back,{Size = UDim2.new(1.5,0,1.5,0),ImageTransparency = 1})
              task.wait(0.5)
              tween(loading_frame,0.5,Enum.EasingStyle.Quart,{Size = UDim2.new(0, 0, 0, 0)})
              tween(main,0.5,Enum.EasingStyle.Back,{Size = UDim2.new(0.504999995, 0, 0.75, 0)})
              tween(blur,0.25,Enum.EasingStyle.Quart,{Size = 0})
              repeat task.wait() until blur.Size <= 0
              blur:Destroy()
            end)
          end
          DL()
        end
        load()

        local topbar = Instance.new("Frame")

        topbar.Name = "topbar"
        topbar.Parent = main
        topbar.Active = true
        topbar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        topbar.BackgroundTransparency = 1.000
        topbar.BorderColor3 = Color3.fromRGB(0, 0, 0)
        topbar.BorderSizePixel = 0
        topbar.Size = UDim2.new(0.99990201, 0, 0.123456791, 0)

        main.Name = "main"
        main.Parent = luxuryui
        main.Active = true
        main.AnchorPoint = Vector2.new(0.5, 0.5)
        main.BackgroundColor3 = Theme(Configuration:GetAttribute("THEME"),"Background")
        main.BorderColor3 = Color3.fromRGB(0, 0, 0)
        main.BorderSizePixel = 0
        main.Position = UDim2.new(0.5, 0, 0.5, 0)
        main.Size = UDim2.new(0, 0, 0, 0)

        MakeDraggable(topbar,main)

        local bind_button = Instance.new("TextButton")
        local bindUICorner = Instance.new("UICorner")
        local bind_icon = Instance.new("ImageLabel")

        bind_button.Name = "bind_button"
        bind_button.Parent = luxuryui
        bind_button.BackgroundColor3 = Theme(Configuration:GetAttribute("THEME"),"Background")
        bind_button.BorderColor3 = Color3.fromRGB(0, 0, 0)
        bind_button.BorderSizePixel = 0
        bind_button.Position = UDim2.new(0.0239708181, 0, 0.0916666687, 0)
        bind_button.Size = UDim2.new(0.065, 0, 0.116, 0)
        bind_button.Font = Enum.Font.SourceSans
        bind_button.Text = ""
        bind_button.TextColor3 = Color3.fromRGB(0, 0, 0)
        bind_button.TextSize = 14.000
        bind_button.TextTransparency = 1.000
        bind_button.AutoButtonColor = false

        bindUICorner.CornerRadius = UDim.new(0, 30)
        bindUICorner.Parent = bind_button

        bind_icon.Name = "bind_icon"
        bind_icon.Parent = bind_button
        bind_icon.Active = true
        bind_icon.AnchorPoint = Vector2.new(0.5, 0.5)
        bind_icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        bind_icon.BackgroundTransparency = 1.000
        bind_icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
        bind_icon.BorderSizePixel = 0
        bind_icon.Position = UDim2.new(0.5, 0, 0.5, 0)
        bind_icon.Size = UDim2.new(0.8, 0, 0.8, 0)
        bind_icon.Image = Theme(Configuration:GetAttribute("THEME"),"Logo")
        bind_icon.ScaleType = Enum.ScaleType.Fit

        MakeDraggable(bind_button,bind_button)

        local bindfocus = false
        bind_button.MouseButton1Down:Connect(function()
          if not bindfocus then
            tween(main,0.5,Enum.EasingStyle.Quart,{Size = UDim2.new(0, 0, 0, 0)})
          else
            tween(main,0.5,Enum.EasingStyle.Back,{Size = UDim2.new(0.504999995, 0, 0.75, 0)})
          end
          bindfocus = not bindfocus
        end)

        uicorner.CornerRadius = UDim.new(0, 15)
        uicorner.Name = "uicorner"
        uicorner.Parent = main

        select_frame.Name = "select_frame"
        select_frame.Parent = main
        select_frame.Active = true
        select_frame.BackgroundColor3 = Theme(Configuration:GetAttribute("THEME"),"Color")
        select_frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
        select_frame.BorderSizePixel = 0
        select_frame.Position = UDim2.new(0.0259091333, 0, 0.0341463424, 0)
        select_frame.Size = UDim2.new(0.123, 0, 0.938, 0)

        UICorner.CornerRadius = UDim.new(0, 15)
        UICorner.Parent = select_frame

        local container = Instance.new("Frame")
        local Folder = Instance.new("Folder")
        local mainframe = Instance.new("Frame")

        container.Name = "container"
        container.Parent = main
        container.Active = true
        container.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        container.BackgroundTransparency = 1.000
        container.BorderColor3 = Color3.fromRGB(0, 0, 0)
        container.BorderSizePixel = 0
        container.Position = UDim2.new(0.160974994, 0, 0.0333333351, 0)
        container.Size = UDim2.new(0.814161718, 0, 0.938271582, 0)
        container.ClipsDescendants = true

        Folder.Parent = container

        mainframe.Name = "mainframe"
        mainframe.Parent = Folder
        mainframe.Active = true
        mainframe.AnchorPoint = Vector2.new(0.5, 0.5)
        mainframe.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        mainframe.BackgroundTransparency = 1.000
        mainframe.BorderColor3 = Color3.fromRGB(0, 0, 0)
        mainframe.BorderSizePixel = 0
        mainframe.Position = UDim2.new(0.5, 0, 0.5, 0)
        mainframe.Size = UDim2.new(1, 0, 1, 0)
        mainframe.LayoutOrder = layout

        local partner_frame = Instance.new("Frame")
        local TextLabel = Instance.new("TextLabel")
        local TextLabel_2 = Instance.new("TextLabel")
        local TextLabel_3 = Instance.new("TextLabel")
        local icon = Instance.new("ImageLabel")
        local lux = Instance.new("TextButton")
        local UIGradient_2 = Instance.new("UIGradient")
        local UICorner = Instance.new("UICorner")
        local TextLabel_4 = Instance.new("TextLabel")
        local roy = Instance.new("TextButton")
        local UICorner_2 = Instance.new("UICorner")
        local TextLabel_5 = Instance.new("TextLabel")

        partner_frame.Name = "partner_frame"
        partner_frame.Parent = mainframe
        partner_frame.Active = true
        partner_frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        partner_frame.BackgroundTransparency = 1.000
        partner_frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
        partner_frame.BorderSizePixel = 0
        partner_frame.Position = UDim2.new(0.0139416987, 0, 0.164473683, 0)
        partner_frame.Size = UDim2.new(0.988593161, 0, 0.38026315, 0)

        TextLabel.Parent = partner_frame
        TextLabel.Active = true
        TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel.BackgroundTransparency = 1.000
        TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
        TextLabel.BorderSizePixel = 0
        TextLabel.Position = UDim2.new(5.88441508e-05, 0, 0, 0)
        TextLabel.Size = UDim2.new(0.983333349, 0, 0.280276805, 0)
        TextLabel.FontFace = Font.fromId(12187373592,Enum.FontWeight.Bold)
        TextLabel.Text = "Welcome to"
        TextLabel.TextColor3 = Theme(Configuration:GetAttribute("THEME"),"TextColor")
        TextLabel.TextScaled = true
        TextLabel.TextSize = 14.000
        TextLabel.TextWrapped = true
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left

        TextLabel_2.Parent = partner_frame
        TextLabel_2.Active = true
        TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel_2.BackgroundTransparency = 1.000
        TextLabel_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
        TextLabel_2.BorderSizePixel = 0
        TextLabel_2.Position = UDim2.new(-0.000210962535, 0, 0.155709341, 0)
        TextLabel_2.Size = UDim2.new(0.983333349, 0, 0.304498255, 0)
        TextLabel_2.FontFace = Font.fromId(12187373592,Enum.FontWeight.Bold)
        TextLabel_2.Text = tostring('<font color="rgb('..tostring(Theme(Configuration:GetAttribute("THEME"),"RichText_Color2"))..')">'..Configuration:GetAttribute("PNAME")..'</font>')..'<font color="rgb('..tostring(Theme(Configuration:GetAttribute("THEME"),"RichText_Color"))..')">HUB</font>'
        TextLabel_2.TextColor3 = Color3.fromRGB(255,255,255)
        TextLabel_2.TextScaled = true
        TextLabel_2.TextSize = 14.000
        TextLabel_2.TextWrapped = true
        TextLabel_2.TextXAlignment = Enum.TextXAlignment.Left
        TextLabel_2.RichText = true

        TextLabel_3.Parent = partner_frame
        TextLabel_3.Active = true
        TextLabel_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel_3.BackgroundTransparency = 1.000
        TextLabel_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
        TextLabel_3.BorderSizePixel = 0
        TextLabel_3.Position = UDim2.new(-0.000210962535, 0, 0.435986161, 0)
        TextLabel_3.Size = UDim2.new(0.983333349, 0, 0.0968858153, 0)
        TextLabel_3.FontFace = Font.fromId(12187373592,Enum.FontWeight.Bold)
        TextLabel_3.Text = "PARTNER SCRIPT HUB"
        TextLabel_3.TextColor3 = Theme(Configuration:GetAttribute("THEME"),"Sec_TextColor")
        TextLabel_3.TextScaled = true
        TextLabel_3.TextSize = 14.000
        TextLabel_3.TextWrapped = true
        TextLabel_3.TextXAlignment = Enum.TextXAlignment.Left

        icon.Name = "icon"
        icon.Parent = partner_frame
        icon.Active = true
        icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        icon.BackgroundTransparency = 1.000
        icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
        icon.BorderSizePixel = 0
        icon.Position = Theme(Configuration:GetAttribute("THEME"),"Logo Position")
        icon.Size = Theme(Configuration:GetAttribute("THEME"),"Logo Size")
        icon.Image = Theme(Configuration:GetAttribute("THEME"),"Logo")
        icon.ScaleType = Enum.ScaleType.Crop

        lux.Name = "lux"
        lux.Parent = partner_frame
        lux.AnchorPoint = Vector2.new(0.5, 0.5)
        lux.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        lux.BorderColor3 = Color3.fromRGB(0, 0, 0)
        lux.BorderSizePixel = 0
        lux.Position = UDim2.new(0.123000003, 0, 0.649999976, 0)
        lux.Size = UDim2.new(0.256410271, 0, 0.13494809, 0)
        lux.Font = Enum.Font.SourceSans
        lux.TextColor3 = Color3.fromRGB(0, 0, 0)
        lux.TextSize = 14.000
        lux.TextTransparency = 1.000
        lux.AutoButtonColor = false

        UIGradient_2.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Theme(Configuration:GetAttribute("THEME"),"Color")), ColorSequenceKeypoint.new(1.00, Theme(Configuration:GetAttribute("THEME"),"Color2"))}
        UIGradient_2.Parent = lux

        UICorner.CornerRadius = UDim.new(0, 30)
        UICorner.Parent = lux

        TextLabel_4.Parent = lux
        TextLabel_4.Active = true
        TextLabel_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel_4.BackgroundTransparency = 1.000
        TextLabel_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
        TextLabel_4.BorderSizePixel = 0
        TextLabel_4.Size = UDim2.new(0.99999994, 0, 1.00000012, 0)
        TextLabel_4.FontFace = Font.fromId(12187373592,Enum.FontWeight.Bold)
        TextLabel_4.Text = "LUXURY HUB"
        TextLabel_4.TextColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel_4.TextScaled = true
        TextLabel_4.TextSize = 14.000
        TextLabel_4.TextWrapped = true

        roy.Name = "roy"
        roy.Parent = partner_frame
        roy.AnchorPoint = Vector2.new(0.5, 0.5)
        roy.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        roy.BorderColor3 = Color3.fromRGB(0, 0, 0)
        roy.BorderSizePixel = 0
        roy.Position = UDim2.new(0.400000006, 0, 0.649999976, 0)
        roy.Size = UDim2.new(0.256410271, 0, 0.13494809, 0)
        roy.Font = Enum.Font.SourceSans
        roy.TextColor3 = Color3.fromRGB(0, 0, 0)
        roy.TextSize = 14.000
        roy.TextTransparency = 1.000
        roy.AutoButtonColor = false
        roy.BackgroundTransparency = 1

        lux.MouseButton1Down:Connect(function()
          setclipboard(tostring("https://discord.gg/luxuryhub"))
          CircleAnim("Circle3",lux,Color3.fromRGB(0,0,0),Color3.fromRGB(0,0,0))
        end)

        lux.MouseEnter:Connect(function()
          tween(TextLabel_4,0.25,Enum.EasingStyle.Circular,{TextColor3 = Color3.fromRGB(0,0,0)})
        end)

        lux.MouseLeave:Connect(function()
          tween(TextLabel_4,0.25,Enum.EasingStyle.Circular,{TextColor3 = Color3.fromRGB(255, 255, 255)})
        end)

        roy.MouseButton1Down:Connect(function()
          setclipboard(tostring("https://discord.gg/royx"))
          CircleAnim("Circle3",roy,Color3.fromRGB(0,0,0),Color3.fromRGB(0,0,0))
        end)

        roy.MouseEnter:Connect(function()
          tween(TextLabel_5,0.25,Enum.EasingStyle.Circular,{TextColor3 = Theme(Configuration:GetAttribute("THEME"),"TextColor")})
        end)

        roy.MouseLeave:Connect(function()
          tween(TextLabel_5,0.25,Enum.EasingStyle.Circular,{TextColor3 = Theme(Configuration:GetAttribute("THEME"),"Color")})
        end)

        local strokeroy = Instance.new("UIStroke",roy)
        strokeroy.Name = "strokeroy"
        strokeroy.Thickness = 1
        strokeroy.Transparency = 0
        strokeroy.Color = Color3.fromRGB(255,255,255)
        strokeroy.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

        local UIGradientstrokeroy = Instance.new("UIGradient")

        UIGradientstrokeroy.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Theme(Configuration:GetAttribute("THEME"),"Color")), ColorSequenceKeypoint.new(1.00, Theme(Configuration:GetAttribute("THEME"),"Color2"))}
        UIGradientstrokeroy.Parent = strokeroy

        UICorner_2.CornerRadius = UDim.new(0, 30)
        UICorner_2.Parent = roy

        TextLabel_5.Parent = roy
        TextLabel_5.Active = true
        TextLabel_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel_5.BackgroundTransparency = 1.000
        TextLabel_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
        TextLabel_5.BorderSizePixel = 0
        TextLabel_5.Size = UDim2.new(0.99999994, 0, 1.00000012, 0)
        TextLabel_5.FontFace = Font.fromId(12187373592,Enum.FontWeight.Bold)
        TextLabel_5.Text = "ROYX HUB"
        TextLabel_5.TextColor3 = Theme(Configuration:GetAttribute("THEME"),"Color")
        TextLabel_5.TextScaled = true
        TextLabel_5.TextSize = 14.000
        TextLabel_5.TextWrapped = true

        local announce = Instance.new("Frame")
        local console = Instance.new("Frame")
        local UICorner = Instance.new("UICorner")
        local UIListLayout = Instance.new("UIListLayout")
        local UIPadding = Instance.new("UIPadding")

        announce.Name = "announce"
        announce.Parent = mainframe
        announce.Active = true
        announce.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        announce.BackgroundTransparency = 1.000
        announce.BorderColor3 = Color3.fromRGB(0, 0, 0)
        announce.BorderSizePixel = 0
        announce.Position = UDim2.new(0.0139416987, 0, 0.472736239, 0)
        announce.Size = UDim2.new(0.988593161, 0, 0.526315808, 0)

        console.Name = "console"
        console.Parent = announce
        console.Active = true
        console.BackgroundColor3 = Theme(Configuration:GetAttribute("THEME"),"Console")
        console.BorderColor3 = Color3.fromRGB(0, 0, 0)
        console.BorderSizePixel = 0
        console.Position = UDim2.new(0, 0, 0.167992249, 0)
        console.Size = UDim2.new(0.997435868, 0, 0.82249999, 0)

        UICorner.Parent = console

        UIPadding.Parent = console
        UIPadding.PaddingLeft = UDim.new(0.0250000004, 0)
        UIPadding.PaddingTop = UDim.new(0.0500000007, 0)

        local TextLabel_2 = Instance.new("TextLabel")

        TextLabel_2.Parent = announce
        TextLabel_2.Active = true
        TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel_2.BackgroundTransparency = 1.000
        TextLabel_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
        TextLabel_2.BorderSizePixel = 0
        TextLabel_2.Position = UDim2.new(-0.000210962535, 0, -0.00401382428, 0)
        TextLabel_2.Size = UDim2.new(0.983333349, 0, 0.172006041, 0)
        TextLabel_2.FontFace = Font.fromId(12187373592,Enum.FontWeight.Bold)
        TextLabel_2.Text = "ANNOUNCEMENT"
        TextLabel_2.TextColor3 =  Theme(Configuration:GetAttribute("THEME"),"Sec_TextColor")
        TextLabel_2.TextScaled = true
        TextLabel_2.TextSize = 14.000
        TextLabel_2.TextWrapped = true
        TextLabel_2.TextXAlignment = Enum.TextXAlignment.Left

        luxurylibrary.log = function(args)

          local template_announce = Instance.new("Frame")
          local TextLabel = Instance.new("TextLabel")

          template_announce.Name = "template_announce"
          template_announce.Parent = console
          template_announce.Active = true
          template_announce.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
          template_announce.BackgroundTransparency = 1.000
          template_announce.BorderColor3 = Color3.fromRGB(0, 0, 0)
          template_announce.BorderSizePixel = 0
          template_announce.Position = UDim2.new(-6.53761347e-08, 0, -7.72988287e-08, 0)
          template_announce.Size = UDim2.new(0.947300792, 0, 0.103343464, 0)

          TextLabel.Parent = template_announce
          TextLabel.Active = true
          TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
          TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
          TextLabel.BackgroundTransparency = 1.000
          TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
          TextLabel.BorderSizePixel = 0
          TextLabel.Position = UDim2.new(0.5, 0, 0.334945679, 0)
          TextLabel.Size = UDim2.new(1, 0, 0.669891357, 0)
          TextLabel.Font = Enum.Font.GothamBold
          TextLabel.Text = args
          TextLabel.TextColor3 = Theme(Configuration:GetAttribute("THEME"),"TextColor")
          TextLabel.TextScaled = true
          TextLabel.TextSize = 14.000
          TextLabel.TextWrapped = true
          TextLabel.TextXAlignment = Enum.TextXAlignment.Left

        end

        UIListLayout.Parent = console
        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

        local UIPageLayout = Instance.new("UIPageLayout")

        UIPageLayout.Parent = Folder
        UIPageLayout.SortOrder = Enum.SortOrder.LayoutOrder
        UIPageLayout.Circular = true
        UIPageLayout.EasingStyle = Enum.EasingStyle.Circular
        UIPageLayout.Padding = UDim.new(0.0500000007, 0)
        UIPageLayout.ScrollWheelInputEnabled = false
        UIPageLayout.TweenTime = 0.250
        UIPageLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right

        local title_topbar = Instance.new("Frame")
        local TextLabel = Instance.new("TextLabel")
        local TextLabel_2 = Instance.new("TextLabel")
        local UIGradient = Instance.new("UIGradient")

        title_topbar.Name = "title_topbar"
        title_topbar.Parent = mainframe
        title_topbar.Active = true
        title_topbar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        title_topbar.BackgroundTransparency = 1.000
        title_topbar.BorderColor3 = Color3.fromRGB(0, 0, 0)
        title_topbar.BorderSizePixel = 0
        title_topbar.Position = UDim2.new(0.0140000004, 0, 0.0250000004, 0)
        title_topbar.Size = UDim2.new(0.984970987, 0, 0.103386045, 0)

        TextLabel.Parent = title_topbar
        TextLabel.Active = true
        TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel.BackgroundTransparency = 1.000
        TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
        TextLabel.BorderSizePixel = 0
        TextLabel.Size = UDim2.new(0.425595224, 0, 0.76119405, 0)
        TextLabel.FontFace = Font.fromId(12187373592,Enum.FontWeight.Bold)
        TextLabel.Text = tostring(Configuration:GetAttribute("NAME"))
        TextLabel.TextColor3 = Theme(Configuration:GetAttribute("THEME"),"TextColor")
        TextLabel.TextScaled = true
        TextLabel.TextSize = 14.000
        TextLabel.TextWrapped = true
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left

        TextLabel_2.Parent = title_topbar
        TextLabel_2.Active = true
        TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel_2.BackgroundTransparency = 1.000
        TextLabel_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
        TextLabel_2.BorderSizePixel = 0
        TextLabel_2.Position = UDim2.new(0, 0, 0.581156731, 0)
        TextLabel_2.Size = UDim2.new(0.425595224, 0, 0.328358203, 0)
        TextLabel_2.ZIndex = 999
        TextLabel_2.FontFace = Font.fromId(12187373592,Enum.FontWeight.Bold)
        TextLabel_2.Text = tostring(Configuration:GetAttribute("DESC"))
        TextLabel_2.TextColor3 = Theme(Configuration:GetAttribute("THEME"),"Color")
        TextLabel_2.TextScaled = true
        TextLabel_2.TextSize = 14.000
        TextLabel_2.TextWrapped = true
        TextLabel_2.TextXAlignment = Enum.TextXAlignment.Left

        UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Theme(Configuration:GetAttribute("THEME"),"Color")), ColorSequenceKeypoint.new(1.00, Theme(Configuration:GetAttribute("THEME"),"Color2"))}
        UIGradient.Parent = TextLabel

        task.spawn(function()
          while task.wait() do
            if Configuration:GetAttribute("ANIMATION") then
              gradient_obj(UIGradient)
            end
          end
        end)

        local scroll_select_frame = Instance.new("ScrollingFrame")
        local UIListLayout = Instance.new("UIListLayout")
        local UIPadding = Instance.new("UIPadding")

        scroll_select_frame.Name = "scroll_select_frame"
        scroll_select_frame.Parent = select_frame
        scroll_select_frame.Active = true
        scroll_select_frame.AnchorPoint = Vector2.new(0.5, 0.5)
        scroll_select_frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        scroll_select_frame.BackgroundTransparency = 1.000
        scroll_select_frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
        scroll_select_frame.BorderSizePixel = 0
        scroll_select_frame.Position = UDim2.new(0.5, 0, 0.5, 0)
        scroll_select_frame.Size = UDim2.new(1, 0, 1, 0)
        scroll_select_frame.ScrollBarThickness = 0

        UIListLayout.Parent = scroll_select_frame
        UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout.Padding = UDim.new(0.0250000004, 0)

        UIPadding.Parent = scroll_select_frame
        UIPadding.PaddingTop = UDim.new(0.0250000004, 0)


        local Frame = Instance.new("Frame")
        local UIListLayout = Instance.new("UIListLayout")

        Frame.Parent = main
        Frame.Active = true
        Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Frame.BackgroundTransparency = 1.000
        Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Frame.BorderSizePixel = 0
        Frame.Position = UDim2.new(0.5974648, 0, 0.0419753082, 0)
        Frame.Size = UDim2.new(0.377, 0, 0.051, 0)

        UIListLayout.Parent = Frame
        UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

        local status_button = Instance.new("ImageButton")
        local status_text = Instance.new("TextLabel")

        local text_bound_frame = Instance.new("Frame")
        local UICorner = Instance.new("UICorner")

        text_bound_frame.Name = "text_bound_frame"
        text_bound_frame.Parent = main
        text_bound_frame.Active = true
        text_bound_frame.BackgroundColor3 = Color3.fromRGB(52, 44, 29)
        text_bound_frame.BackgroundTransparency = 1.000
        text_bound_frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
        text_bound_frame.BorderSizePixel = 0
        text_bound_frame.Position = UDim2.new(0.726960778, 0, 0.0436289087, 0)
        text_bound_frame.Size = UDim2.new(0.246621862, 0, 0.0481481478, 0)

        local stroketext_bound = Instance.new("UIStroke",text_bound_frame)
        stroketext_bound.Name = "strokeroy"
        stroketext_bound.Thickness = 1
        stroketext_bound.Transparency = 1
        stroketext_bound.Color = Theme(Configuration:GetAttribute("THEME"),"TextColor")
        stroketext_bound.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

        UICorner.Parent = text_bound_frame

        text_bound_frame.Name = "text_bound_frame"
        text_bound_frame.Parent = Frame
        text_bound_frame.Active = true
        text_bound_frame.BackgroundColor3 = Color3.fromRGB(52, 44, 29)
        text_bound_frame.BackgroundTransparency = 1.000
        text_bound_frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
        text_bound_frame.BorderSizePixel = 0
        text_bound_frame.Size = UDim2.new(0, 0, 0.853169858, 0)

        UICorner.Parent = text_bound_frame

        status_text.Name = "status_text"
        status_text.Parent = text_bound_frame
        status_text.Active = true
        status_text.AnchorPoint = Vector2.new(0.5, 0.5)
        status_text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        status_text.BackgroundTransparency = 1.000
        status_text.BorderColor3 = Color3.fromRGB(0, 0, 0)
        status_text.BorderSizePixel = 0
        status_text.Position = UDim2.new(0.447756052, 0, 0.5, 0)
        status_text.Size = UDim2.new(0.846785605, 0, 0.650159001, 0)
        status_text.Font = Enum.Font.GothamBold
        status_text.Text = ""
        status_text.TextColor3 = Theme(Configuration:GetAttribute("THEME"),"TextColor")
        status_text.TextSize = 15.000
        status_text.TextWrapped = true
        status_text.TextXAlignment = Enum.TextXAlignment.Right
        status_text.RichText = true
        status_text.TextScaled = true
        status_text.TextTransparency = 1

        status_button.Name = "status_button"
        status_button.Parent = main
        status_button.AnchorPoint = Vector2.new(0.5, 0.5)
        status_button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        status_button.BorderColor3 = Color3.fromRGB(0, 0, 0)
        status_button.BorderSizePixel = 0
        status_button.Position = UDim2.new(0.948498785, 0, 0.064, 0)
        status_button.Size = UDim2.new(0.0309567191, 0, 0.0370370373, 0)
        status_button.Image = "http://www.roblox.com/asset/?id=6022668884"
        status_button.ImageColor3 = Theme(Configuration:GetAttribute("THEME"),"Color")
        status_button.ScaleType = Enum.ScaleType.Fit
        status_button.BackgroundTransparency = 1

        local status_focus = false

        status_button.MouseButton1Down:Connect(function()
          if not status_focus then
            tween(status_text,0.25,Enum.EasingStyle.Circular,{TextTransparency = 0})
            tween(text_bound_frame,0.25,Enum.EasingStyle.Circular,{Size = UDim2.new(1.00000012, 0, 0.853169858, 0)})
            tween(stroketext_bound,0.25,Enum.EasingStyle.Circular,{Transparency = 0.58})
          else
            tween(status_text,0.25,Enum.EasingStyle.Circular,{TextTransparency = 1})
            tween(text_bound_frame,0.25,Enum.EasingStyle.Circular,{Size = UDim2.new(0, 0, 0.853169858, 0)})
            tween(stroketext_bound,0.25,Enum.EasingStyle.Circular,{Transparency = 1})
          end
          status_focus = not status_focus
        end)

        luxurylibrary.status = function(args)
          status_text.Text = args
        end

        local function welcome()
          local buttonbar = Instance.new("Frame")
          local button = Instance.new("ImageButton")

          buttonbar.Name = "buttonbar"
          buttonbar.Parent = scroll_select_frame
          buttonbar.Active = true
          buttonbar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
          buttonbar.BackgroundTransparency = 1.000
          buttonbar.BorderColor3 = Color3.fromRGB(0, 0, 0)
          buttonbar.BorderSizePixel = 0
          buttonbar.Position = UDim2.new(0.125, 0, 0.0256410893, 0)
          buttonbar.Size = UDim2.new(0.75, 0, 0.0670000017, 0)

          button.Name = "button"
          button.Parent = buttonbar
          button.AnchorPoint = Vector2.new(0.5, 0.5)
          button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
          button.BackgroundTransparency = 1.000
          button.BorderColor3 = Color3.fromRGB(0, 0, 0)
          button.BorderSizePixel = 0
          button.Position = UDim2.new(0.5, 0, 0.5, 0)
          button.Size = UDim2.new(0.75, 0, 0.75, 0)
          button.Image = "rbxassetid://"..tostring(15537313086)
          button.ScaleType = Enum.ScaleType.Fit

          button.MouseButton1Down:Connect(function()
            tween(button,0.25,Enum.EasingStyle.Circular,{Rotation = 0,Size = UDim2.new(0.65,0,0.65,0),ImageColor3 = Configuration:GetAttribute("COLOR")})
            UIPageLayout:JumpTo(mainframe)

            for i,v in pairs(scroll_select_frame:GetChildren()) do
              if v:IsA("Frame") then
                for i,v in pairs(v:GetChildren()) do
                  if v:IsA("ImageButton") then
                    tween(v,0.25,Enum.EasingStyle.Circular,{ImageColor3  = Color3.fromRGB(255,255,255)})
                  end
                end
                tween(button,0.25,Enum.EasingStyle.Circular,{ImageColor3  = Color3.fromRGB(0, 0, 0)})
              end
            end
          end)

          button.MouseEnter:Connect(function()
            tween(button,0.25,Enum.EasingStyle.Back,{Rotation = 0,Size = UDim2.new(0.85,0,0.85,0)})
          end)

          button.MouseLeave:Connect(function()
            tween(button,0.25,Enum.EasingStyle.Back,{Rotation = 0,Size = UDim2.new(0.75,0,0.75,0)})
          end)

          if not focus then
            tween(button,0.25,Enum.EasingStyle.Circular,{ImageColor3  = Color3.fromRGB(0, 0, 0)})
            focus = true
          end
        end
        welcome()

        luxurylibrary.createtab = function(options)

          layout = layout + 1
          local random = math.random(100,9999)
          local typeui = options.Type or nil

          local Logo = options.Image or 15525911198

          local buttonbar = Instance.new("Frame")
          local button = Instance.new("ImageButton")

          buttonbar.Name = "buttonbar"
          buttonbar.Parent = scroll_select_frame
          buttonbar.Active = true
          buttonbar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
          buttonbar.BackgroundTransparency = 1.000
          buttonbar.BorderColor3 = Color3.fromRGB(0, 0, 0)
          buttonbar.BorderSizePixel = 0
          buttonbar.Position = UDim2.new(0.125, 0, 0.0256410893, 0)
          buttonbar.Size = UDim2.new(0.75, 0, 0.0670000017, 0)

          button.Name = "button"
          button.Parent = buttonbar
          button.AnchorPoint = Vector2.new(0.5, 0.5)
          button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
          button.BackgroundTransparency = 1.000
          button.BorderColor3 = Color3.fromRGB(0, 0, 0)
          button.BorderSizePixel = 0
          button.Position = UDim2.new(0.5, 0, 0.5, 0)
          button.Size = UDim2.new(0.75, 0, 0.75, 0)
          button.Image = "rbxassetid://"..tostring(Logo)
          button.ScaleType = Enum.ScaleType.Fit

          task.spawn(function()
            if typeui == tostring("Kaitun") and type(typeui) == "string" then

              local MainUI = game.Players.LocalPlayer.PlayerGui.Main
              local Inv = require(MainUI.UIController.Inventory)
              local Sprite = require(MainUI.UIController.Inventory.Spritesheets)
              local itemList = getupvalue(Inv.UpdateSort,2)

              local FightGet = {
                ["Superhuman"] = {
                  ID = "http://www.roblox.com/asset/?id=10338473987",
                  ImageRectOffset = Vector2.new(0,0),
                  ImageRectSize = Vector2.new(0,0),
                },
                ["GodHuman"] = {
                  ID = "http://www.roblox.com/asset/?id=9945562382",
                  ImageRectOffset = Vector2.new(300,200),
                  ImageRectSize = Vector2.new(100,100),
                },
                ["DragonTalon"] = {
                  ID = "http://www.roblox.com/asset/?id=9945562382",
                  ImageRectOffset = Vector2.new(100,500),
                  ImageRectSize = Vector2.new(100,100),
                },
                ["ElectricClaw"] = {
                  ID = "http://www.roblox.com/asset/?id=9945562382",
                  ImageRectOffset = Vector2.new(200,0),
                  ImageRectSize = Vector2.new(100,100),
                },
                ["SharkmanKarate"] = {
                  ID = "http://www.roblox.com/asset/?id=9945562382",
                  ImageRectOffset = Vector2.new(0,0),
                  ImageRectSize = Vector2.new(100,100),
                },
                ["DeathStep"] = {
                  ID = "http://www.roblox.com/asset/?id=9945562382",
                  ImageRectOffset = Vector2.new(400,300),
                  ImageRectSize = Vector2.new(100,100),
                },
              }

              local GetMeleeText = function()
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
                  if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buy"..tostring(v) , true) == 1 then
                    table.insert(AllHaveMelee,tostring(v)) 
                    if tostring(v) == "Godhuman" then
                      table.insert(AllHaveMelee,"GodHuman")
                    end
                  end
                  task.wait(0.01)
                end
                return AllHaveMelee
              end

              local page_frame = Instance.new("Frame")

              page_frame.Name = random.."_pageframe"
              page_frame.Parent = Folder
              page_frame.Active = true
              page_frame.AnchorPoint = Vector2.new(0.5, 0.5)
              page_frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
              page_frame.BackgroundTransparency = 1.000
              page_frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
              page_frame.BorderSizePixel = 0
              page_frame.Position = UDim2.new(0.5, 0, 0.5, 0)
              page_frame.Size = UDim2.new(1, 0, 1, 0)
              page_frame.LayoutOrder = layout
              page_frame:SetAttribute("KAITUN",true)

              local title_topbar = Instance.new("Frame")
              local TextLabel = Instance.new("TextLabel")
              local UIGradient = Instance.new("UIGradient")
              local TextLabel_2 = Instance.new("TextLabel")
              local TextLabel_3 = Instance.new("TextLabel")

              title_topbar.Name = "title_topbar"
              title_topbar.Parent = page_frame
              title_topbar.Active = true
              title_topbar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
              title_topbar.BackgroundTransparency = 1.000
              title_topbar.BorderColor3 = Color3.fromRGB(0, 0, 0)
              title_topbar.BorderSizePixel = 0
              title_topbar.Position = UDim2.new(0.0140000256, 0, 0.0250000004, 0)
              title_topbar.Size = UDim2.new(0.984970987, 0, 0.1625247, 0)

              TextLabel.Parent = title_topbar
              TextLabel.Active = true
              TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
              TextLabel.BackgroundTransparency = 1.000
              TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
              TextLabel.BorderSizePixel = 0
              TextLabel.Size = UDim2.new(0.425595164, 0, 0.418757498, 0)
              TextLabel.FontFace = Font.fromId(12187373592,Enum.FontWeight.Bold)
              TextLabel.Text = "Kaitun Page"
              TextLabel.TextColor3 = Theme(Configuration:GetAttribute("THEME"),"TextColor")
              TextLabel.TextScaled = true
              TextLabel.TextSize = 14.000
              TextLabel.TextWrapped = true
              TextLabel.TextXAlignment = Enum.TextXAlignment.Left

              UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Theme(Configuration:GetAttribute("THEME"),"Color")), ColorSequenceKeypoint.new(1.00, Theme(Configuration:GetAttribute("THEME"),"Color2"))}
              UIGradient.Parent = TextLabel

              task.spawn(function()
                while task.wait() do
                  if Configuration:GetAttribute("ANIMATION") then
                    gradient_obj(UIGradient)
                  end
                end
              end)

              TextLabel_2.Parent = title_topbar
              TextLabel_2.Active = true
              TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
              TextLabel_2.BackgroundTransparency = 1.000
              TextLabel_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
              TextLabel_2.BorderSizePixel = 0
              TextLabel_2.Position = UDim2.new(0, 0, 0.340119123, 0)
              TextLabel_2.Size = UDim2.new(0.425595164, 0, 0.221293315, 0)
              TextLabel_2.ZIndex = 999
              TextLabel_2.FontFace = Font.fromId(12187373592,Enum.FontWeight.Bold)
              TextLabel_2.Text = "All your Item in Inventory"
              TextLabel_2.TextColor3 = Theme(Configuration:GetAttribute("THEME"),"Color")
              TextLabel_2.TextScaled = true
              TextLabel_2.TextSize = 14.000
              TextLabel_2.TextWrapped = true
              TextLabel_2.TextXAlignment = Enum.TextXAlignment.Left

              TextLabel_3.Parent = title_topbar
              TextLabel_3.Active = true
              TextLabel_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
              TextLabel_3.BackgroundTransparency = 1.000
              TextLabel_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
              TextLabel_3.BorderSizePixel = 0
              TextLabel_3.Position = UDim2.new(0, 0, 0.634914517, 0)
              TextLabel_3.Size = UDim2.new(0.993383646, 0, 0.343315363, 0)
              TextLabel_3.ZIndex = 999
              TextLabel_3.FontFace = Font.fromId(12187373592,Enum.FontWeight.Bold)
              TextLabel_3.Text = "List"
              TextLabel_3.TextColor3 = Theme(Configuration:GetAttribute("THEME"),"TextColor")
              TextLabel_3.TextScaled = true
              TextLabel_3.TextSize = 14.000
              TextLabel_3.TextWrapped = true
              TextLabel_3.TextXAlignment = Enum.TextXAlignment.Left

              local container_kaitun = Instance.new("Frame")
              local UIPageLayout_kaitun = Instance.new("UIPageLayout")
              local UIPadding = Instance.new("UIPadding")

              UIPadding.Parent = container_kaitun
              UIPadding.PaddingTop = UDim.new(0.100000001, 0)

              container_kaitun.Name = "container_kaitun"
              container_kaitun.Parent = page_frame
              container_kaitun.Active = true
              container_kaitun.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
              container_kaitun.BackgroundTransparency = 1.000
              container_kaitun.BorderColor3 = Color3.fromRGB(0, 0, 0)
              container_kaitun.BorderSizePixel = 0
              container_kaitun.ClipsDescendants = true
              container_kaitun.Position = UDim2.new(0.0139416987, 0, 0.129501507, 0)
              container_kaitun.Size = UDim2.new(0.978, 0, 0.871, 0)

              UIPageLayout_kaitun.Parent = container_kaitun
              UIPageLayout_kaitun.SortOrder = Enum.SortOrder.LayoutOrder
              UIPageLayout_kaitun.Circular = true
              UIPageLayout_kaitun.EasingStyle = Enum.EasingStyle.Circular
              UIPageLayout_kaitun.ScrollWheelInputEnabled = false
              UIPageLayout_kaitun.TweenTime = 0.250

              local list_inspect = Instance.new("Frame")
              local UIListLayout = Instance.new("UIListLayout")

              local UIGridLayout = Instance.new("UIGridLayout")

              UIGridLayout.Parent = list_inspect
              UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
              UIGridLayout.CellPadding = UDim2.new(0.0250000004, 0, 0.06, 0)
              UIGridLayout.CellSize = UDim2.new(0.324999988, 0, 0.949999988, 0)
              UIGridLayout.FillDirectionMaxCells = 2

              local function Sword()
                local sword = Instance.new("TextButton")
                local UIGradient = Instance.new("UIGradient")
                local UICorner = Instance.new("UICorner")
                local Title = Instance.new("TextLabel")
                local Desc = Instance.new("TextLabel")
                local ImageLabel = Instance.new("ImageLabel")
                local background = Instance.new("ImageLabel")
                local Tools = Instance.new("ImageLabel")

                task.spawn(function()
                  while task.wait() do
                    if Configuration:GetAttribute("ANIMATION") then
                      gradient_obj(UIGradient)
                    end
                  end
                end)

                sword.Name = "sword"
                sword.Parent = list_inspect
                sword.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                sword.BorderColor3 = Color3.fromRGB(0, 0, 0)
                sword.BorderSizePixel = 0
                sword.Size = UDim2.new(0.325224072, 0, 1.00531912, 0)
                sword.AutoButtonColor = false
                sword.Font = Enum.Font.SourceSans
                sword.Text = ""
                sword.TextColor3 = Color3.fromRGB(0, 0, 0)
                sword.TextSize = 14.000
                sword.TextTransparency = 1.000
                sword.LayoutOrder = 0

                local frame_inspect = Instance.new("Frame")
                local listscroll = Instance.new("ScrollingFrame")
                local UIGridLayout = Instance.new("UIGridLayout")

                frame_inspect.Name = "frame_inspect"
                frame_inspect.Parent = container_kaitun
                frame_inspect.Active = true
                frame_inspect.BackgroundColor3 = Color3.fromRGB(57, 57, 57)
                frame_inspect.BackgroundTransparency = 1.000
                frame_inspect.BorderColor3 = Color3.fromRGB(0, 0, 0)
                frame_inspect.BorderSizePixel = 0
                frame_inspect.Position = UDim2.new(0, 0, -1.40858248e-07, 0)
                frame_inspect.Size = UDim2.new(0.989860594, 0, 1.00031638, 0)
                frame_inspect.LayoutOrder = 1

                local back = Instance.new("TextButton")
                local ImageLabelback = Instance.new("ImageLabel")

                back.Name = "back"
                back.Parent = frame_inspect
                back.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                back.BackgroundTransparency = 1.000
                back.BorderColor3 = Color3.fromRGB(0, 0, 0)
                back.BorderSizePixel = 0
                back.Position = UDim2.new(0.748522222, 0, -0.119129822, 0)
                back.Size = UDim2.new(0.216634557, 0, 0.063759625, 0)
                back.FontFace = Font.fromId(12187373592,Enum.FontWeight.Bold)
                back.Text = "Back"
                back.TextColor3 = Theme(Configuration:GetAttribute("THEME"),"TextColor")
                back.TextScaled = true
                back.TextSize = 14.000
                back.TextWrapped = true
                back.TextXAlignment = Enum.TextXAlignment.Right

                back.MouseButton1Down:Connect(function()
                  UIPageLayout_kaitun:JumpToIndex(0)
                end)

                ImageLabelback.Parent = back
                ImageLabelback.Active = true
                ImageLabelback.AnchorPoint = Vector2.new(0.5, 0.5)
                ImageLabelback.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ImageLabelback.BackgroundTransparency = 1.000
                ImageLabelback.BorderColor3 = Color3.fromRGB(0, 0, 0)
                ImageLabelback.BorderSizePixel = 0
                ImageLabelback.Position = UDim2.new(1.10000002, 0, 0.5, 0)
                ImageLabelback.Rotation = 180.000
                ImageLabelback.Size = UDim2.new(0.181, 0, 0.789, 0)
                ImageLabelback.Image = "http://www.roblox.com/asset/?id=6023426922"
                ImageLabelback.ImageColor3 = Color3.fromRGB(255, 61, 61)

                listscroll.Name = "list"
                listscroll.Parent = frame_inspect
                listscroll.Active = true
                listscroll.AnchorPoint = Vector2.new(0.5, 0.5)
                listscroll.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                listscroll.BorderColor3 = Color3.fromRGB(0, 0, 0)
                listscroll.BorderSizePixel = 0
                listscroll.Position = UDim2.new(0.5, 0, 0.5, 0)
                listscroll.Size = UDim2.new(1, 0, 1, 0)
                listscroll.ScrollBarThickness = 0
                listscroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
                listscroll.BackgroundTransparency = 1

                UIGridLayout.Parent = listscroll
                UIGridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
                UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
                UIGridLayout.CellPadding = UDim2.new(0.0149999997, 0, 0.0450000018, 0)
                UIGridLayout.CellSize = UDim2.new(0.230000004, 0, 0.29, 0)
                UIGridLayout.FillDirectionMaxCells = 4

                sword.MouseButton1Down:Connect(function()
                  if page_frame:GetAttribute("KAITUN") then

                    for i,v in pairs(listscroll:GetChildren()) do
                      if v:IsA("Frame") then
                        v:Destroy()
                      end
                    end

                    UIPageLayout_kaitun:JumpTo(frame_inspect)
                    for i,v in pairs(itemList) do
                      if v.Visible and v.details.Type == "Sword" then
                        for Image,list in pairs(Sprite) do
                          local FName = v.details.Name:gsub(",",""):gsub(":",""):gsub("'","")
                          local IconSize = list[FName.."1.png"]
                          local IconOutlineSize = list[FName.."2.png"]

                          if IconSize then
                            local num = (IconSize[3] and 1 or 2)

                            local template = Instance.new("Frame")
                            local UICorner = Instance.new("UICorner")
                            local item = Instance.new("ImageLabel")
                            local glow = Instance.new("ImageLabel")

                            template.Name = "template"
                            template.Parent = listscroll
                            template.Active = true
                            template.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
                            template.BorderColor3 = Color3.fromRGB(0, 0, 0)
                            template.BorderSizePixel = 0
                            template.Size = UDim2.new(0, 100, 0, 100)

                            UICorner.CornerRadius = UDim.new(0, 15)
                            UICorner.Parent = template

                            item.Name = "item"
                            item.Parent = template
                            item.Active = true
                            item.AnchorPoint = Vector2.new(0.5, 0.5)
                            item.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            item.BackgroundTransparency = 1.000
                            item.BorderColor3 = Color3.fromRGB(0, 0, 0)
                            item.BorderSizePixel = 0
                            item.Position = UDim2.new(0.5, 0, 0.5, 0)
                            item.Size = UDim2.new(0.850000024, 0, 0.850000024, 0)
                            item.ImageTransparency = 0.5
                            item.Image = Image
                            item.ImageRectOffset = Vector2.new(IconSize[1] / num, IconSize[2] / num);
                            item.ImageRectSize = Vector2.new(IconSize[3] and 150, IconSize[4] and 150);
                            item.ZIndex = 1

                            glow.Name = "glow"
                            glow.Parent = template
                            glow.Active = true
                            glow.AnchorPoint = Vector2.new(0.5, 0.5)
                            glow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            glow.BackgroundTransparency = 1.000
                            glow.BorderColor3 = Color3.fromRGB(0, 0, 0)
                            glow.BorderSizePixel = 0
                            glow.Position = UDim2.new(0.5, 0, 0.5, 0)
                            glow.Size = UDim2.new(1, 0, 1, 0)
                            glow.Image = "rbxassetid://15534890357"
                            glow.ImageTransparency = 0.95
                            glow.ZIndex = 0

                            local TextButton = Instance.new("TextButton",template)
                            TextButton.Name = "TextButton"
                            TextButton.Position = UDim2.new(0.5, 0, 0.5, 0)
                            TextButton.AnchorPoint = Vector2.new(0.5, 0.5)
                            TextButton.Size = UDim2.new(1, 0, 1, 0)
                            TextButton.BackgroundTransparency = 1.000
                            TextButton.Text = ""

                            TextButton.MouseButton1Down:Connect(function()
                              game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LoadItem",v.details.Name)
                            end)

                            template.MouseEnter:Connect(function()
                              tween(item,0.5,Enum.EasingStyle.Circular,{ImageTransparency = 0})
                            end)

                            template.MouseLeave:Connect(function()
                              tween(item,0.5,Enum.EasingStyle.Circular,{ImageTransparency = 0.5})
                            end)
                          end
                        end
                      end
                    end
                  end
                end)

                UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(170, 170, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(170, 85, 255))}
                UIGradient.Parent = sword

                UICorner.CornerRadius = UDim.new(0, 15)
                UICorner.Parent = sword

                Title.Name = "Title"
                Title.Parent = sword
                Title.Active = true
                Title.AnchorPoint = Vector2.new(0.5, 0.5)
                Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Title.BackgroundTransparency = 1.000
                Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Title.BorderSizePixel = 0
                Title.Position = UDim2.new(0.471378595, 0, 0.715885401, 0)
                Title.Size = UDim2.new(0.842519701, 0, 0.185185179, 0)
                Title.FontFace = Font.fromId(12187373592,Enum.FontWeight.Bold)
                Title.Text = "Swords"
                Title.TextColor3 = Color3.fromRGB(255, 255, 255)
                Title.TextScaled = true
                Title.TextSize = 20.000
                Title.TextWrapped = true
                Title.TextXAlignment = Enum.TextXAlignment.Left

                Desc.Name = "Desc"
                Desc.Parent = sword
                Desc.Active = true
                Desc.AnchorPoint = Vector2.new(0.5, 0.5)
                Desc.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Desc.BackgroundTransparency = 1.000
                Desc.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Desc.BorderSizePixel = 0
                Desc.Position = UDim2.new(0.471378595, 0, 0.845026791, 0)
                Desc.Size = UDim2.new(0.842519701, 0, 0.153439149, 0)
                Desc.FontFace = Font.fromId(12187373592,Enum.FontWeight.Bold)
                Desc.Text = "Inspect Your Swords"
                Desc.TextColor3 = Color3.fromRGB(255, 255, 255)
                Desc.TextScaled = true
                Desc.TextSize = 20.000
                Desc.TextWrapped = true
                Desc.TextXAlignment = Enum.TextXAlignment.Left

                ImageLabel.Parent = sword
                ImageLabel.Active = true
                ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ImageLabel.BackgroundTransparency = 1.000
                ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
                ImageLabel.BorderSizePixel = 0
                ImageLabel.Position = UDim2.new(0.0826771632, 0, 0.365210146, 0)
                ImageLabel.Size = UDim2.new(0.196850389, 0, 0.264550269, 0)
                ImageLabel.Image = "rbxassetid://15534417635"
                ImageLabel.ScaleType = Enum.ScaleType.Fit

                background.Name = "background"
                background.Parent = sword
                background.Active = true
                background.AnchorPoint = Vector2.new(0.5, 0.5)
                background.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                background.BackgroundTransparency = 1.000
                background.BorderColor3 = Color3.fromRGB(0, 0, 0)
                background.BorderSizePixel = 0
                background.Position = UDim2.new(0.5, 0, 0.5, 0)
                background.Size = UDim2.new(1, 0, 1, 0)
                background.ZIndex = 0
                background.Image = "rbxassetid://15534482279"
                background.ImageTransparency = 0.850
                background.ScaleType = Enum.ScaleType.Crop

                local UICornerbackground = Instance.new("UICorner")

                UICornerbackground.CornerRadius = UDim.new(0, 15)
                UICornerbackground.Parent = background

                Tools.Name = "Tools"
                Tools.Parent = sword
                Tools.Active = true
                Tools.AnchorPoint = Vector2.new(0.5, 0.5)
                Tools.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Tools.BackgroundTransparency = 1.000
                Tools.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Tools.BorderSizePixel = 0
                Tools.Position = UDim2.new(0.779527545, 0, 0.267195761, 0)
                Tools.Size = UDim2.new(1, 0, 1, 0)
                Tools.ZIndex = 0
                Tools.Image = "rbxassetid://15534505777"
                Tools.ScaleType = Enum.ScaleType.Fit
              end

              local function Gun()

                local gun = Instance.new("TextButton")
                local UIGradient_2 = Instance.new("UIGradient")
                local UICorner_2 = Instance.new("UICorner")
                local Title_2 = Instance.new("TextLabel")
                local Desc_2 = Instance.new("TextLabel")
                local ImageLabel_2 = Instance.new("ImageLabel")
                local background_2 = Instance.new("ImageLabel")
                local Tools_2 = Instance.new("ImageLabel")

                task.spawn(function()
                  while task.wait() do
                    if Configuration:GetAttribute("ANIMATION") then
                      gradient_obj(UIGradient_2)
                    end
                  end
                end)

                gun.Name = "gun"
                gun.Parent = list_inspect
                gun.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                gun.BorderColor3 = Color3.fromRGB(0, 0, 0)
                gun.BorderSizePixel = 0
                gun.Position = UDim2.new(0.351504505, 0, -0.0531914905, 0)
                gun.Size = UDim2.new(0.325224072, 0, 1.00531912, 0)
                gun.AutoButtonColor = false
                gun.Font = Enum.Font.SourceSans
                gun.Text = ""
                gun.TextColor3 = Color3.fromRGB(0, 0, 0)
                gun.TextSize = 14.000
                gun.TextTransparency = 1.000
                gun.LayoutOrder = 1

                local frame_inspect = Instance.new("Frame")
                local listscroll = Instance.new("ScrollingFrame")
                local UIGridLayout = Instance.new("UIGridLayout")

                frame_inspect.Name = "frame_inspect"
                frame_inspect.Parent = container_kaitun
                frame_inspect.Active = true
                frame_inspect.BackgroundColor3 = Color3.fromRGB(57, 57, 57)
                frame_inspect.BackgroundTransparency = 1.000
                frame_inspect.BorderColor3 = Color3.fromRGB(0, 0, 0)
                frame_inspect.BorderSizePixel = 0
                frame_inspect.Position = UDim2.new(0, 0, -1.40858248e-07, 0)
                frame_inspect.Size = UDim2.new(0.989860594, 0, 1.00031638, 0)
                frame_inspect.LayoutOrder = 1

                local back = Instance.new("TextButton")
                local ImageLabelback = Instance.new("ImageLabel")

                back.Name = "back"
                back.Parent = frame_inspect
                back.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                back.BackgroundTransparency = 1.000
                back.BorderColor3 = Color3.fromRGB(0, 0, 0)
                back.BorderSizePixel = 0
                back.Position = UDim2.new(0.748522222, 0, -0.119129822, 0)
                back.Size = UDim2.new(0.216634557, 0, 0.063759625, 0)
                back.FontFace = Font.fromId(12187373592,Enum.FontWeight.Bold)
                back.Text = "Back"
                back.TextColor3 = Theme(Configuration:GetAttribute("THEME"),"TextColor")
                back.TextScaled = true
                back.TextSize = 14.000
                back.TextWrapped = true
                back.TextXAlignment = Enum.TextXAlignment.Right

                back.MouseButton1Down:Connect(function()
                  UIPageLayout_kaitun:JumpToIndex(0)
                end)

                ImageLabelback.Parent = back
                ImageLabelback.Active = true
                ImageLabelback.AnchorPoint = Vector2.new(0.5, 0.5)
                ImageLabelback.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ImageLabelback.BackgroundTransparency = 1.000
                ImageLabelback.BorderColor3 = Color3.fromRGB(0, 0, 0)
                ImageLabelback.BorderSizePixel = 0
                ImageLabelback.Position = UDim2.new(1.10000002, 0, 0.5, 0)
                ImageLabelback.Rotation = 180.000
                ImageLabelback.Size = UDim2.new(0.181, 0, 0.789, 0)
                ImageLabelback.Image = "http://www.roblox.com/asset/?id=6023426922"
                ImageLabelback.ImageColor3 = Color3.fromRGB(255, 61, 61)

                listscroll.Name = "list"
                listscroll.Parent = frame_inspect
                listscroll.Active = true
                listscroll.AnchorPoint = Vector2.new(0.5, 0.5)
                listscroll.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                listscroll.BorderColor3 = Color3.fromRGB(0, 0, 0)
                listscroll.BorderSizePixel = 0
                listscroll.Position = UDim2.new(0.5, 0, 0.5, 0)
                listscroll.Size = UDim2.new(1, 0, 1, 0)
                listscroll.ScrollBarThickness = 0
                listscroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
                listscroll.BackgroundTransparency = 1

                UIGridLayout.Parent = listscroll
                UIGridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
                UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
                UIGridLayout.CellPadding = UDim2.new(0.0149999997, 0, 0.0450000018, 0)
                UIGridLayout.CellSize = UDim2.new(0.230000004, 0, 0.29, 0)
                UIGridLayout.FillDirectionMaxCells = 4

                gun.MouseButton1Down:Connect(function()
                  if page_frame:GetAttribute("KAITUN") then
                    for i,v in pairs(listscroll:GetChildren()) do
                      if v:IsA("Frame") then
                        v:Destroy()
                      end
                    end
                    UIPageLayout_kaitun:JumpTo(frame_inspect)
                    for i,v in pairs(itemList) do
                      if v.Visible and v.details.Type == "Gun" then
                        for Image,list in pairs(Sprite) do
                          local FName = v.details.Name:gsub(",",""):gsub(":",""):gsub("'","")
                          local IconSize = list[FName.."1.png"]
                          local IconOutlineSize = list[FName.."2.png"]

                          if IconSize then
                            local num = (IconSize[3] and 1 or 2)

                            local template = Instance.new("Frame")
                            local UICorner = Instance.new("UICorner")
                            local item = Instance.new("ImageLabel")
                            local glow = Instance.new("ImageLabel")

                            template.Name = "template"
                            template.Parent = listscroll
                            template.Active = true
                            template.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
                            template.BorderColor3 = Color3.fromRGB(0, 0, 0)
                            template.BorderSizePixel = 0
                            template.Size = UDim2.new(0, 100, 0, 100)

                            UICorner.CornerRadius = UDim.new(0, 15)
                            UICorner.Parent = template

                            item.Name = "item"
                            item.Parent = template
                            item.Active = true
                            item.AnchorPoint = Vector2.new(0.5, 0.5)
                            item.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            item.BackgroundTransparency = 1.000
                            item.BorderColor3 = Color3.fromRGB(0, 0, 0)
                            item.BorderSizePixel = 0
                            item.Position = UDim2.new(0.5, 0, 0.5, 0)
                            item.Size = UDim2.new(0.850000024, 0, 0.850000024, 0)
                            item.ImageTransparency = 0.5
                            item.Image = Image
                            item.ImageRectOffset = Vector2.new(IconSize[1] / num, IconSize[2] / num);
                            item.ImageRectSize = Vector2.new(IconSize[3] and 150, IconSize[4] and 150);
                            item.ZIndex = 1

                            glow.Name = "glow"
                            glow.Parent = template
                            glow.Active = true
                            glow.AnchorPoint = Vector2.new(0.5, 0.5)
                            glow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            glow.BackgroundTransparency = 1.000
                            glow.BorderColor3 = Color3.fromRGB(0, 0, 0)
                            glow.BorderSizePixel = 0
                            glow.Position = UDim2.new(0.5, 0, 0.5, 0)
                            glow.Size = UDim2.new(1, 0, 1, 0)
                            glow.Image = "rbxassetid://15534890357"
                            glow.ImageTransparency = 0.95
                            glow.ZIndex = 0

                            local TextButton = Instance.new("TextButton",template)
                            TextButton.Name = "TextButton"
                            TextButton.Position = UDim2.new(0.5, 0, 0.5, 0)
                            TextButton.AnchorPoint = Vector2.new(0.5, 0.5)
                            TextButton.Size = UDim2.new(1, 0, 1, 0)
                            TextButton.BackgroundTransparency = 1.000
                            TextButton.Text = ""

                            TextButton.MouseButton1Down:Connect(function()
                              game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LoadItem",v.details.Name)
                            end)

                            template.MouseEnter:Connect(function()
                              tween(item,0.5,Enum.EasingStyle.Circular,{ImageTransparency = 0})
                            end)

                            template.MouseLeave:Connect(function()
                              tween(item,0.5,Enum.EasingStyle.Circular,{ImageTransparency = 0.5})
                            end)
                          end
                        end
                      end
                    end
                  end
                end)

                UIGradient_2.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 170, 127)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(85, 170, 0))}
                UIGradient_2.Parent = gun

                UICorner_2.CornerRadius = UDim.new(0, 15)
                UICorner_2.Parent = gun

                Title_2.Name = "Title"
                Title_2.Parent = gun
                Title_2.Active = true
                Title_2.AnchorPoint = Vector2.new(0.5, 0.5)
                Title_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Title_2.BackgroundTransparency = 1.000
                Title_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Title_2.BorderSizePixel = 0
                Title_2.Position = UDim2.new(0.471378595, 0, 0.715885401, 0)
                Title_2.Size = UDim2.new(0.842519701, 0, 0.185185179, 0)
                Title_2.FontFace = Font.fromId(12187373592,Enum.FontWeight.Bold)
                Title_2.Text = "Guns"
                Title_2.TextColor3 = Color3.fromRGB(255, 255, 255)
                Title_2.TextScaled = true
                Title_2.TextSize = 20.000
                Title_2.TextWrapped = true
                Title_2.TextXAlignment = Enum.TextXAlignment.Left

                Desc_2.Name = "Desc"
                Desc_2.Parent = gun
                Desc_2.Active = true
                Desc_2.AnchorPoint = Vector2.new(0.5, 0.5)
                Desc_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Desc_2.BackgroundTransparency = 1.000
                Desc_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Desc_2.BorderSizePixel = 0
                Desc_2.Position = UDim2.new(0.471378595, 0, 0.845026791, 0)
                Desc_2.Size = UDim2.new(0.842519701, 0, 0.153439149, 0)
                Desc_2.FontFace = Font.fromId(12187373592,Enum.FontWeight.Bold)
                Desc_2.Text = "Inspect Your Guns"
                Desc_2.TextColor3 = Color3.fromRGB(255, 255, 255)
                Desc_2.TextScaled = true
                Desc_2.TextSize = 20.000
                Desc_2.TextWrapped = true
                Desc_2.TextXAlignment = Enum.TextXAlignment.Left

                ImageLabel_2.Parent = gun
                ImageLabel_2.Active = true
                ImageLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ImageLabel_2.BackgroundTransparency = 1.000
                ImageLabel_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
                ImageLabel_2.BorderSizePixel = 0
                ImageLabel_2.Position = UDim2.new(0.0826771632, 0, 0.365210146, 0)
                ImageLabel_2.Size = UDim2.new(0.196850389, 0, 0.264550269, 0)
                ImageLabel_2.Image = "rbxassetid://15534417635"
                ImageLabel_2.ScaleType = Enum.ScaleType.Fit

                background_2.Name = "background"
                background_2.Parent = gun
                background_2.Active = true
                background_2.AnchorPoint = Vector2.new(0.5, 0.5)
                background_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                background_2.BackgroundTransparency = 1.000
                background_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
                background_2.BorderSizePixel = 0
                background_2.Position = UDim2.new(0.5, 0, 0.5, 0)
                background_2.Size = UDim2.new(1, 0, 1, 0)
                background_2.ZIndex = 0
                background_2.Image = "rbxassetid://15534482279"
                background_2.ImageTransparency = 0.850
                background_2.ScaleType = Enum.ScaleType.Crop

                local UICornerbackground = Instance.new("UICorner")

                UICornerbackground.CornerRadius = UDim.new(0, 15)
                UICornerbackground.Parent = background_2

                Tools_2.Name = "Tools"
                Tools_2.Parent = gun
                Tools_2.Active = true
                Tools_2.AnchorPoint = Vector2.new(0.5, 0.5)
                Tools_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Tools_2.BackgroundTransparency = 1.000
                Tools_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Tools_2.BorderSizePixel = 0
                Tools_2.Position = UDim2.new(0.779527545, 0, 0.223134801, 0)
                Tools_2.Size = UDim2.new(1, 0, 1.08812177, 0)
                Tools_2.ZIndex = 0
                Tools_2.Image = "rbxassetid://15534523150"
                Tools_2.ScaleType = Enum.ScaleType.Fit
              end

              local function Accessories()
                local accessorry = Instance.new("TextButton")
                local UIGradient = Instance.new("UIGradient")
                local UICorner = Instance.new("UICorner")
                local Title = Instance.new("TextLabel")
                local Desc = Instance.new("TextLabel")
                local ImageLabel = Instance.new("ImageLabel")
                local background = Instance.new("ImageLabel")
                local Tools = Instance.new("ImageLabel")

                task.spawn(function()
                  while task.wait() do
                    if Configuration:GetAttribute("ANIMATION") then
                      gradient_obj(UIGradient)
                    end
                  end
                end)

                accessorry.Name = "accessorry"
                accessorry.Parent = list_inspect
                accessorry.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                accessorry.BorderColor3 = Color3.fromRGB(0, 0, 0)
                accessorry.BorderSizePixel = 0
                accessorry.Position = UDim2.new(0.340224028, 0, 0, 0)
                accessorry.Size = UDim2.new(0.325224072, 0, 0.499349892, 0)
                accessorry.AutoButtonColor = false
                accessorry.Font = Enum.Font.SourceSans
                accessorry.Text = ""
                accessorry.TextColor3 = Color3.fromRGB(0, 0, 0)
                accessorry.TextSize = 14.000
                accessorry.TextTransparency = 1.000
                accessorry.LayoutOrder = 2
                accessorry.ZIndex = 999

                local frame_inspect = Instance.new("Frame")
                local listscroll = Instance.new("ScrollingFrame")
                local UIGridLayout = Instance.new("UIGridLayout")

                frame_inspect.Name = "frame_inspect"
                frame_inspect.Parent = container_kaitun
                frame_inspect.Active = true
                frame_inspect.BackgroundColor3 = Color3.fromRGB(57, 57, 57)
                frame_inspect.BackgroundTransparency = 1.000
                frame_inspect.BorderColor3 = Color3.fromRGB(0, 0, 0)
                frame_inspect.BorderSizePixel = 0
                frame_inspect.Position = UDim2.new(0, 0, -1.40858248e-07, 0)
                frame_inspect.Size = UDim2.new(0.989860594, 0, 1.00031638, 0)
                frame_inspect.LayoutOrder = 1

                local back = Instance.new("TextButton")
                local ImageLabelback = Instance.new("ImageLabel")

                back.Name = "back"
                back.Parent = frame_inspect
                back.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                back.BackgroundTransparency = 1.000
                back.BorderColor3 = Color3.fromRGB(0, 0, 0)
                back.BorderSizePixel = 0
                back.Position = UDim2.new(0.748522222, 0, -0.119129822, 0)
                back.Size = UDim2.new(0.216634557, 0, 0.063759625, 0)
                back.FontFace = Font.fromId(12187373592,Enum.FontWeight.Bold)
                back.Text = "Back"
                back.TextColor3 = Theme(Configuration:GetAttribute("THEME"),"TextColor")
                back.TextScaled = true
                back.TextSize = 14.000
                back.TextWrapped = true
                back.TextXAlignment = Enum.TextXAlignment.Right

                back.MouseButton1Down:Connect(function()
                  UIPageLayout_kaitun:JumpToIndex(0)
                end)

                ImageLabelback.Parent = back
                ImageLabelback.Active = true
                ImageLabelback.AnchorPoint = Vector2.new(0.5, 0.5)
                ImageLabelback.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ImageLabelback.BackgroundTransparency = 1.000
                ImageLabelback.BorderColor3 = Color3.fromRGB(0, 0, 0)
                ImageLabelback.BorderSizePixel = 0
                ImageLabelback.Position = UDim2.new(1.10000002, 0, 0.5, 0)
                ImageLabelback.Rotation = 180.000
                ImageLabelback.Size = UDim2.new(0.181, 0, 0.789, 0)
                ImageLabelback.Image = "http://www.roblox.com/asset/?id=6023426922"
                ImageLabelback.ImageColor3 = Color3.fromRGB(255, 61, 61)

                listscroll.Name = "list"
                listscroll.Parent = frame_inspect
                listscroll.Active = true
                listscroll.AnchorPoint = Vector2.new(0.5, 0.5)
                listscroll.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                listscroll.BorderColor3 = Color3.fromRGB(0, 0, 0)
                listscroll.BorderSizePixel = 0
                listscroll.Position = UDim2.new(0.5, 0, 0.5, 0)
                listscroll.Size = UDim2.new(1, 0, 1, 0)
                listscroll.ScrollBarThickness = 0
                listscroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
                listscroll.BackgroundTransparency = 1

                UIGridLayout.Parent = listscroll
                UIGridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
                UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
                UIGridLayout.CellPadding = UDim2.new(0.0149999997, 0, 0.0450000018, 0)
                UIGridLayout.CellSize = UDim2.new(0.230000004, 0, 0.29, 0)
                UIGridLayout.FillDirectionMaxCells = 4

                accessorry.MouseButton1Down:Connect(function()
                  if page_frame:GetAttribute("KAITUN") then
                    for i,v in pairs(listscroll:GetChildren()) do
                      if v:IsA("Frame") then
                        v:Destroy()
                      end
                    end
                    UIPageLayout_kaitun:JumpTo(frame_inspect)
                    for i,v in pairs(itemList) do
                      if v.Visible and v.details.Type == "Accessory" then
                        for Image,list in pairs(Sprite) do
                          local FName = v.details.Name:gsub(",",""):gsub(":",""):gsub("'","")
                          local IconSize = list[FName.."1.png"]
                          local IconOutlineSize = list[FName.."2.png"]

                          if IconSize then
                            local num = (IconSize[3] and 1 or 2)

                            local template = Instance.new("Frame")
                            local UICorner = Instance.new("UICorner")
                            local item = Instance.new("ImageLabel")
                            local glow = Instance.new("ImageLabel")

                            template.Name = "template"
                            template.Parent = listscroll
                            template.Active = true
                            template.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
                            template.BorderColor3 = Color3.fromRGB(0, 0, 0)
                            template.BorderSizePixel = 0
                            template.Size = UDim2.new(0, 100, 0, 100)

                            UICorner.CornerRadius = UDim.new(0, 15)
                            UICorner.Parent = template

                            item.Name = "item"
                            item.Parent = template
                            item.Active = true
                            item.AnchorPoint = Vector2.new(0.5, 0.5)
                            item.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            item.BackgroundTransparency = 1.000
                            item.BorderColor3 = Color3.fromRGB(0, 0, 0)
                            item.BorderSizePixel = 0
                            item.Position = UDim2.new(0.5, 0, 0.5, 0)
                            item.Size = UDim2.new(0.850000024, 0, 0.850000024, 0)
                            item.ImageTransparency = 0.5
                            item.Image = Image
                            item.ImageRectOffset = Vector2.new(IconSize[1] / num, IconSize[2] / num);
                            item.ImageRectSize = Vector2.new(IconSize[3] and 150, IconSize[4] and 150);
                            item.ZIndex = 1

                            glow.Name = "glow"
                            glow.Parent = template
                            glow.Active = true
                            glow.AnchorPoint = Vector2.new(0.5, 0.5)
                            glow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            glow.BackgroundTransparency = 1.000
                            glow.BorderColor3 = Color3.fromRGB(0, 0, 0)
                            glow.BorderSizePixel = 0
                            glow.Position = UDim2.new(0.5, 0, 0.5, 0)
                            glow.Size = UDim2.new(1, 0, 1, 0)
                            glow.Image = "rbxassetid://15534890357"
                            glow.ImageTransparency = 0.95
                            glow.ZIndex = 0

                            local TextButton = Instance.new("TextButton",template)
                            TextButton.Name = "TextButton"
                            TextButton.Position = UDim2.new(0.5, 0, 0.5, 0)
                            TextButton.AnchorPoint = Vector2.new(0.5, 0.5)
                            TextButton.Size = UDim2.new(1, 0, 1, 0)
                            TextButton.BackgroundTransparency = 1.000
                            TextButton.Text = ""

                            TextButton.MouseButton1Down:Connect(function()
                              game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LoadItem",v.details.Name)
                            end)

                            template.MouseEnter:Connect(function()
                              tween(item,0.5,Enum.EasingStyle.Circular,{ImageTransparency = 0})
                            end)

                            template.MouseLeave:Connect(function()
                              tween(item,0.5,Enum.EasingStyle.Circular,{ImageTransparency = 0.5})
                            end)
                          end
                        end
                      end
                    end
                  end
                end)

                UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(34, 214, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(49, 70, 255))}
                UIGradient.Parent = accessorry

                UICorner.CornerRadius = UDim.new(0, 15)
                UICorner.Parent = accessorry

                Title.Name = "Title"
                Title.Parent = accessorry
                Title.Active = true
                Title.AnchorPoint = Vector2.new(0.5, 0.5)
                Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Title.BackgroundTransparency = 1.000
                Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Title.BorderSizePixel = 0
                Title.Position = UDim2.new(0.471378595, 0, 0.715885401, 0)
                Title.Size = UDim2.new(0.842519701, 0, 0.185185179, 0)
                Title.FontFace = Font.fromId(12187373592,Enum.FontWeight.Bold)
                Title.Text = "Accessories"
                Title.TextColor3 = Color3.fromRGB(255, 255, 255)
                Title.TextScaled = true
                Title.TextSize = 20.000
                Title.TextWrapped = true
                Title.TextXAlignment = Enum.TextXAlignment.Left

                Desc.Name = "Desc"
                Desc.Parent = accessorry
                Desc.Active = true
                Desc.AnchorPoint = Vector2.new(0.5, 0.5)
                Desc.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Desc.BackgroundTransparency = 1.000
                Desc.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Desc.BorderSizePixel = 0
                Desc.Position = UDim2.new(0.471378595, 0, 0.845026791, 0)
                Desc.Size = UDim2.new(0.842519701, 0, 0.153439149, 0)
                Desc.FontFace = Font.fromId(12187373592,Enum.FontWeight.Bold)
                Desc.Text = "Inspect Your Accessories"
                Desc.TextColor3 = Color3.fromRGB(255, 255, 255)
                Desc.TextScaled = true
                Desc.TextSize = 20.000
                Desc.TextWrapped = true
                Desc.TextXAlignment = Enum.TextXAlignment.Left

                ImageLabel.Parent = accessorry
                ImageLabel.Active = true
                ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ImageLabel.BackgroundTransparency = 1.000
                ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
                ImageLabel.BorderSizePixel = 0
                ImageLabel.Position = UDim2.new(0.0826771632, 0, 0.365210146, 0)
                ImageLabel.Size = UDim2.new(0.196850389, 0, 0.264550269, 0)
                ImageLabel.Image = "rbxassetid://15534417635"
                ImageLabel.ScaleType = Enum.ScaleType.Fit

                background.Name = "background"
                background.Parent = accessorry
                background.Active = true
                background.AnchorPoint = Vector2.new(0.5, 0.5)
                background.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                background.BackgroundTransparency = 1.000
                background.BorderColor3 = Color3.fromRGB(0, 0, 0)
                background.BorderSizePixel = 0
                background.Position = UDim2.new(0.5, 0, 0.5, 0)
                background.Size = UDim2.new(1, 0, 1, 0)
                background.ZIndex = 0
                background.Image = "rbxassetid://15534482279"
                background.ImageTransparency = 0.850
                background.ScaleType = Enum.ScaleType.Crop

                local UICornerbackground = Instance.new("UICorner")

                UICornerbackground.CornerRadius = UDim.new(0, 15)
                UICornerbackground.Parent = background

                Tools.Name = "Tools"
                Tools.Parent = accessorry
                Tools.Active = true
                Tools.AnchorPoint = Vector2.new(0.5, 0.5)
                Tools.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Tools.BackgroundTransparency = 1.000
                Tools.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Tools.BorderSizePixel = 0
                Tools.Position = UDim2.new(0.779527545, 0, 0.267195761, 0)
                Tools.Size = UDim2.new(1, 0, 1, 0)
                Tools.ZIndex = 0
                Tools.Image = "rbxassetid://15534613266"
                Tools.ScaleType = Enum.ScaleType.Fit
              end

              local function Fruit()

                local fruit = Instance.new("TextButton")
                local UIGradient = Instance.new("UIGradient")
                local UICorner = Instance.new("UICorner")
                local Title = Instance.new("TextLabel")
                local Desc = Instance.new("TextLabel")
                local ImageLabel = Instance.new("ImageLabel")
                local background = Instance.new("ImageLabel")
                local Tools = Instance.new("ImageLabel")

                task.spawn(function()
                  while task.wait() do
                    if Configuration:GetAttribute("ANIMATION") then
                      gradient_obj(UIGradient)
                    end
                  end
                end)

                fruit.Name = "fruit"
                fruit.Parent = list_inspect
                fruit.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                fruit.BorderColor3 = Color3.fromRGB(0, 0, 0)
                fruit.BorderSizePixel = 0
                fruit.Position = UDim2.new(0.340224028, 0, 0, 0)
                fruit.Size = UDim2.new(0.325224072, 0, 0.499349892, 0)
                fruit.AutoButtonColor = false
                fruit.Font = Enum.Font.SourceSans
                fruit.Text = ""
                fruit.TextColor3 = Color3.fromRGB(0, 0, 0)
                fruit.TextSize = 14.000
                fruit.TextTransparency = 1.000
                fruit.LayoutOrder = 3
                fruit.ZIndex = 999

                local frame_inspect = Instance.new("Frame")
                local listscroll = Instance.new("ScrollingFrame")
                local UIGridLayout = Instance.new("UIGridLayout")

                frame_inspect.Name = "frame_inspect"
                frame_inspect.Parent = container_kaitun
                frame_inspect.Active = true
                frame_inspect.BackgroundColor3 = Color3.fromRGB(57, 57, 57)
                frame_inspect.BackgroundTransparency = 1.000
                frame_inspect.BorderColor3 = Color3.fromRGB(0, 0, 0)
                frame_inspect.BorderSizePixel = 0
                frame_inspect.Position = UDim2.new(0, 0, -1.40858248e-07, 0)
                frame_inspect.Size = UDim2.new(0.989860594, 0, 1.00031638, 0)
                frame_inspect.LayoutOrder = 1

                local back = Instance.new("TextButton")
                local ImageLabelback = Instance.new("ImageLabel")

                back.Name = "back"
                back.Parent = frame_inspect
                back.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                back.BackgroundTransparency = 1.000
                back.BorderColor3 = Color3.fromRGB(0, 0, 0)
                back.BorderSizePixel = 0
                back.Position = UDim2.new(0.748522222, 0, -0.119129822, 0)
                back.Size = UDim2.new(0.216634557, 0, 0.063759625, 0)
                back.FontFace = Font.fromId(12187373592,Enum.FontWeight.Bold)
                back.Text = "Back"
                back.TextColor3 = Theme(Configuration:GetAttribute("THEME"),"TextColor")
                back.TextScaled = true
                back.TextSize = 14.000
                back.TextWrapped = true
                back.TextXAlignment = Enum.TextXAlignment.Right

                back.MouseButton1Down:Connect(function()
                  UIPageLayout_kaitun:JumpToIndex(0)
                end)

                ImageLabelback.Parent = back
                ImageLabelback.Active = true
                ImageLabelback.AnchorPoint = Vector2.new(0.5, 0.5)
                ImageLabelback.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ImageLabelback.BackgroundTransparency = 1.000
                ImageLabelback.BorderColor3 = Color3.fromRGB(0, 0, 0)
                ImageLabelback.BorderSizePixel = 0
                ImageLabelback.Position = UDim2.new(1.10000002, 0, 0.5, 0)
                ImageLabelback.Rotation = 180.000
                ImageLabelback.Size = UDim2.new(0.181, 0, 0.789, 0)
                ImageLabelback.Image = "http://www.roblox.com/asset/?id=6023426922"
                ImageLabelback.ImageColor3 = Color3.fromRGB(255, 61, 61)

                listscroll.Name = "list"
                listscroll.Parent = frame_inspect
                listscroll.Active = true
                listscroll.AnchorPoint = Vector2.new(0.5, 0.5)
                listscroll.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                listscroll.BorderColor3 = Color3.fromRGB(0, 0, 0)
                listscroll.BorderSizePixel = 0
                listscroll.Position = UDim2.new(0.5, 0, 0.5, 0)
                listscroll.Size = UDim2.new(1, 0, 1, 0)
                listscroll.ScrollBarThickness = 0
                listscroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
                listscroll.BackgroundTransparency = 1

                UIGridLayout.Parent = listscroll
                UIGridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
                UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
                UIGridLayout.CellPadding = UDim2.new(0.0149999997, 0, 0.0450000018, 0)
                UIGridLayout.CellSize = UDim2.new(0.230000004, 0, 0.29, 0)
                UIGridLayout.FillDirectionMaxCells = 4

                fruit.MouseButton1Down:Connect(function()
                  if page_frame:GetAttribute("KAITUN") then
                    for i,v in pairs(listscroll:GetChildren()) do
                      if v:IsA("Frame") then
                        v:Destroy()
                      end
                    end
                    UIPageLayout_kaitun:JumpTo(frame_inspect)
                    for i,v in pairs(itemList) do
                      if v.Visible and v.details.Type == "Blox Fruit" then
                        for Image,list in pairs(Sprite) do
                          local FName = v.details.Name:gsub(",",""):gsub(":",""):gsub("'","")
                          local IconSize = list[FName.."1.png"]
                          local IconOutlineSize = list[FName.."2.png"]

                          if IconSize then
                            local num = (IconSize[3] and 1 or 2)

                            local template = Instance.new("Frame")
                            local UICorner = Instance.new("UICorner")
                            local item = Instance.new("ImageLabel")
                            local glow = Instance.new("ImageLabel")

                            template.Name = "template"
                            template.Parent = listscroll
                            template.Active = true
                            template.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
                            template.BorderColor3 = Color3.fromRGB(0, 0, 0)
                            template.BorderSizePixel = 0
                            template.Size = UDim2.new(0, 100, 0, 100)

                            UICorner.CornerRadius = UDim.new(0, 15)
                            UICorner.Parent = template

                            item.Name = "item"
                            item.Parent = template
                            item.Active = true
                            item.AnchorPoint = Vector2.new(0.5, 0.5)
                            item.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            item.BackgroundTransparency = 1.000
                            item.BorderColor3 = Color3.fromRGB(0, 0, 0)
                            item.BorderSizePixel = 0
                            item.Position = UDim2.new(0.5, 0, 0.5, 0)
                            item.Size = UDim2.new(0.850000024, 0, 0.850000024, 0)
                            item.ImageTransparency = 0.5
                            item.Image = Image
                            item.ImageRectOffset = Vector2.new(IconSize[1] / num, IconSize[2] / num);
                            item.ImageRectSize = Vector2.new(IconSize[3] and 150, IconSize[4] and 150);
                            item.ZIndex = 1

                            glow.Name = "glow"
                            glow.Parent = template
                            glow.Active = true
                            glow.AnchorPoint = Vector2.new(0.5, 0.5)
                            glow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            glow.BackgroundTransparency = 1.000
                            glow.BorderColor3 = Color3.fromRGB(0, 0, 0)
                            glow.BorderSizePixel = 0
                            glow.Position = UDim2.new(0.5, 0, 0.5, 0)
                            glow.Size = UDim2.new(1, 0, 1, 0)
                            glow.Image = "rbxassetid://15534890357"
                            glow.ImageTransparency = 0.95
                            glow.ZIndex = 0

                            local Count = Instance.new("TextLabel")

                            Count.Name = "Count"
                            Count.Parent = template
                            Count.Active = true
                            Count.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            Count.BackgroundTransparency = 1.000
                            Count.BorderColor3 = Color3.fromRGB(0, 0, 0)
                            Count.BorderSizePixel = 0
                            Count.Position = UDim2.new(0.0749998465, 0, 0.0694298968, 0)
                            Count.Size = UDim2.new(0.842059076, 0, 0.190931723, 0)
                            Count.FontFace = Font.fromId(12187373592,Enum.FontWeight.Bold)
                            Count.TextColor3 = Color3.fromRGB(255, 255, 255)
                            Count.TextScaled = true
                            Count.TextSize = 14.000
                            Count.TextWrapped = true
                            Count.TextXAlignment = Enum.TextXAlignment.Right
                            Count.Text = "x "..v.details.Count

                            template.MouseEnter:Connect(function()
                              tween(item,0.5,Enum.EasingStyle.Circular,{ImageTransparency = 0})
                            end)

                            template.MouseLeave:Connect(function()
                              tween(item,0.5,Enum.EasingStyle.Circular,{ImageTransparency = 0.5})
                            end)
                          end
                        end
                      end
                    end
                  end
                end)

                UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 102)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 188, 189))}
                UIGradient.Parent = fruit

                UICorner.CornerRadius = UDim.new(0, 15)
                UICorner.Parent = fruit

                Title.Name = "Title"
                Title.Parent = fruit
                Title.Active = true
                Title.AnchorPoint = Vector2.new(0.5, 0.5)
                Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Title.BackgroundTransparency = 1.000
                Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Title.BorderSizePixel = 0
                Title.Position = UDim2.new(0.471378595, 0, 0.715885401, 0)
                Title.Size = UDim2.new(0.842519701, 0, 0.185185179, 0)
                Title.FontFace = Font.fromId(12187373592,Enum.FontWeight.Bold)
                Title.Text = "Fruits"
                Title.TextColor3 = Color3.fromRGB(255, 255, 255)
                Title.TextScaled = true
                Title.TextSize = 20.000
                Title.TextWrapped = true
                Title.TextXAlignment = Enum.TextXAlignment.Left

                Desc.Name = "Desc"
                Desc.Parent = fruit
                Desc.Active = true
                Desc.AnchorPoint = Vector2.new(0.5, 0.5)
                Desc.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Desc.BackgroundTransparency = 1.000
                Desc.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Desc.BorderSizePixel = 0
                Desc.Position = UDim2.new(0.471378595, 0, 0.845026791, 0)
                Desc.Size = UDim2.new(0.842519701, 0, 0.153439149, 0)
                Desc.FontFace = Font.fromId(12187373592,Enum.FontWeight.Bold)
                Desc.Text = "Inspect Your Fruits"
                Desc.TextColor3 = Color3.fromRGB(255, 255, 255)
                Desc.TextScaled = true
                Desc.TextSize = 20.000
                Desc.TextWrapped = true
                Desc.TextXAlignment = Enum.TextXAlignment.Left

                ImageLabel.Parent = fruit
                ImageLabel.Active = true
                ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ImageLabel.BackgroundTransparency = 1.000
                ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
                ImageLabel.BorderSizePixel = 0
                ImageLabel.Position = UDim2.new(0.0826771632, 0, 0.365210146, 0)
                ImageLabel.Size = UDim2.new(0.196850389, 0, 0.264550269, 0)
                ImageLabel.Image = "rbxassetid://15534417635"
                ImageLabel.ScaleType = Enum.ScaleType.Fit

                background.Name = "background"
                background.Parent = fruit
                background.Active = true
                background.AnchorPoint = Vector2.new(0.5, 0.5)
                background.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                background.BackgroundTransparency = 1.000
                background.BorderColor3 = Color3.fromRGB(0, 0, 0)
                background.BorderSizePixel = 0
                background.Position = UDim2.new(0.5, 0, 0.5, 0)
                background.Size = UDim2.new(1, 0, 1, 0)
                background.ZIndex = 0
                background.Image = "rbxassetid://15534482279"
                background.ImageTransparency = 0.850
                background.ScaleType = Enum.ScaleType.Crop

                local UICornerbackground = Instance.new("UICorner")

                UICornerbackground.CornerRadius = UDim.new(0, 15)
                UICornerbackground.Parent = background

                Tools.Name = "Tools"
                Tools.Parent = fruit
                Tools.Active = true
                Tools.AnchorPoint = Vector2.new(0.5, 0.5)
                Tools.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Tools.BackgroundTransparency = 1.000
                Tools.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Tools.BorderSizePixel = 0
                Tools.Position = UDim2.new(0.779527545, 0, 0.267195761, 0)
                Tools.Size = UDim2.new(1, 0, 1, 0)
                Tools.ZIndex = 0
                Tools.Image = "rbxassetid://15534631309"
                Tools.ScaleType = Enum.ScaleType.Fit
              end

              local function Material()
                local materials = Instance.new("TextButton")
                local UIGradient = Instance.new("UIGradient")
                local UICorner = Instance.new("UICorner")
                local Title = Instance.new("TextLabel")
                local Desc = Instance.new("TextLabel")
                local ImageLabel = Instance.new("ImageLabel")
                local background = Instance.new("ImageLabel")
                local Tools = Instance.new("ImageLabel")

                task.spawn(function()
                  while task.wait() do
                    if Configuration:GetAttribute("ANIMATION") then
                      gradient_obj(UIGradient)
                    end
                  end
                end)

                materials.Name = "materials"
                materials.Parent = list_inspect
                materials.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                materials.BorderColor3 = Color3.fromRGB(0, 0, 0)
                materials.BorderSizePixel = 0
                materials.Position = UDim2.new(0.340224028, 0, 0, 0)
                materials.Size = UDim2.new(0.325224072, 0, 0.499349892, 0)
                materials.AutoButtonColor = false
                materials.Font = Enum.Font.SourceSans
                materials.Text = ""
                materials.TextColor3 = Color3.fromRGB(0, 0, 0)
                materials.TextSize = 14.000
                materials.TextTransparency = 1.000
                materials.LayoutOrder = 4
                materials.ZIndex = 999

                local frame_inspect = Instance.new("Frame")
                local listscroll = Instance.new("ScrollingFrame")
                local UIGridLayout = Instance.new("UIGridLayout")

                frame_inspect.Name = "frame_inspect"
                frame_inspect.Parent = container_kaitun
                frame_inspect.Active = true
                frame_inspect.BackgroundColor3 = Color3.fromRGB(57, 57, 57)
                frame_inspect.BackgroundTransparency = 1.000
                frame_inspect.BorderColor3 = Color3.fromRGB(0, 0, 0)
                frame_inspect.BorderSizePixel = 0
                frame_inspect.Position = UDim2.new(0, 0, -1.40858248e-07, 0)
                frame_inspect.Size = UDim2.new(0.989860594, 0, 1.00031638, 0)
                frame_inspect.LayoutOrder = 1

                local back = Instance.new("TextButton")
                local ImageLabelback = Instance.new("ImageLabel")

                back.Name = "back"
                back.Parent = frame_inspect
                back.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                back.BackgroundTransparency = 1.000
                back.BorderColor3 = Color3.fromRGB(0, 0, 0)
                back.BorderSizePixel = 0
                back.Position = UDim2.new(0.748522222, 0, -0.119129822, 0)
                back.Size = UDim2.new(0.216634557, 0, 0.063759625, 0)
                back.FontFace = Font.fromId(12187373592,Enum.FontWeight.Bold)
                back.Text = "Back"
                back.TextColor3 = Theme(Configuration:GetAttribute("THEME"),"TextColor")
                back.TextScaled = true
                back.TextSize = 14.000
                back.TextWrapped = true
                back.TextXAlignment = Enum.TextXAlignment.Right

                back.MouseButton1Down:Connect(function()
                  UIPageLayout_kaitun:JumpToIndex(0)
                end)

                ImageLabelback.Parent = back
                ImageLabelback.Active = true
                ImageLabelback.AnchorPoint = Vector2.new(0.5, 0.5)
                ImageLabelback.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ImageLabelback.BackgroundTransparency = 1.000
                ImageLabelback.BorderColor3 = Color3.fromRGB(0, 0, 0)
                ImageLabelback.BorderSizePixel = 0
                ImageLabelback.Position = UDim2.new(1.10000002, 0, 0.5, 0)
                ImageLabelback.Rotation = 180.000
                ImageLabelback.Size = UDim2.new(0.181, 0, 0.789, 0)
                ImageLabelback.Image = "http://www.roblox.com/asset/?id=6023426922"
                ImageLabelback.ImageColor3 = Color3.fromRGB(255, 61, 61)

                listscroll.Name = "list"
                listscroll.Parent = frame_inspect
                listscroll.Active = true
                listscroll.AnchorPoint = Vector2.new(0.5, 0.5)
                listscroll.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                listscroll.BorderColor3 = Color3.fromRGB(0, 0, 0)
                listscroll.BorderSizePixel = 0
                listscroll.Position = UDim2.new(0.5, 0, 0.5, 0)
                listscroll.Size = UDim2.new(1, 0, 1, 0)
                listscroll.ScrollBarThickness = 0
                listscroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
                listscroll.BackgroundTransparency = 1

                UIGridLayout.Parent = listscroll
                UIGridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
                UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
                UIGridLayout.CellPadding = UDim2.new(0.0149999997, 0, 0.0450000018, 0)
                UIGridLayout.CellSize = UDim2.new(0.230000004, 0, 0.29, 0)
                UIGridLayout.FillDirectionMaxCells = 4

                materials.MouseButton1Down:Connect(function()
                  if page_frame:GetAttribute("KAITUN") then
                    for i,v in pairs(listscroll:GetChildren()) do
                      if v:IsA("Frame") then
                        v:Destroy()
                      end
                    end
                    UIPageLayout_kaitun:JumpTo(frame_inspect)
                    for i,v in pairs(itemList) do
                      if v.Visible and v.details.Type == "Material" then
                        for Image,list in pairs(Sprite) do
                          local FName = v.details.Name:gsub(",",""):gsub(":",""):gsub("'","")
                          local IconSize = list[FName.."1.png"]
                          local IconOutlineSize = list[FName.."2.png"]

                          if IconSize then
                            local num = (IconSize[3] and 1 or 2)

                            local template = Instance.new("Frame")
                            local UICorner = Instance.new("UICorner")
                            local item = Instance.new("ImageLabel")
                            local glow = Instance.new("ImageLabel")

                            template.Name = "template"
                            template.Parent = listscroll
                            template.Active = true
                            template.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
                            template.BorderColor3 = Color3.fromRGB(0, 0, 0)
                            template.BorderSizePixel = 0
                            template.Size = UDim2.new(0, 100, 0, 100)

                            UICorner.CornerRadius = UDim.new(0, 15)
                            UICorner.Parent = template

                            item.Name = "item"
                            item.Parent = template
                            item.Active = true
                            item.AnchorPoint = Vector2.new(0.5, 0.5)
                            item.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            item.BackgroundTransparency = 1.000
                            item.BorderColor3 = Color3.fromRGB(0, 0, 0)
                            item.BorderSizePixel = 0
                            item.Position = UDim2.new(0.5, 0, 0.5, 0)
                            item.Size = UDim2.new(0.850000024, 0, 0.850000024, 0)
                            item.ImageTransparency = 0.5
                            item.Image = Image
                            item.ImageRectOffset = Vector2.new(IconSize[1] / num, IconSize[2] / num);
                            item.ImageRectSize = Vector2.new(IconSize[3] and 150, IconSize[4] and 150);
                            item.ZIndex = 1

                            glow.Name = "glow"
                            glow.Parent = template
                            glow.Active = true
                            glow.AnchorPoint = Vector2.new(0.5, 0.5)
                            glow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            glow.BackgroundTransparency = 1.000
                            glow.BorderColor3 = Color3.fromRGB(0, 0, 0)
                            glow.BorderSizePixel = 0
                            glow.Position = UDim2.new(0.5, 0, 0.5, 0)
                            glow.Size = UDim2.new(1, 0, 1, 0)
                            glow.Image = "rbxassetid://15534890357"
                            glow.ImageTransparency = 0.95
                            glow.ZIndex = 0

                            local Count = Instance.new("TextLabel")

                            Count.Name = "Count"
                            Count.Parent = template
                            Count.Active = true
                            Count.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            Count.BackgroundTransparency = 1.000
                            Count.BorderColor3 = Color3.fromRGB(0, 0, 0)
                            Count.BorderSizePixel = 0
                            Count.Position = UDim2.new(0.0749998465, 0, 0.0694298968, 0)
                            Count.Size = UDim2.new(0.842059076, 0, 0.190931723, 0)
                            Count.FontFace = Font.fromId(12187373592,Enum.FontWeight.Bold)
                            Count.TextColor3 = Color3.fromRGB(255, 255, 255)
                            Count.TextScaled = true
                            Count.TextSize = 14.000
                            Count.TextWrapped = true
                            Count.TextXAlignment = Enum.TextXAlignment.Right
                            Count.Text = "x "..v.details.Count

                            template.MouseEnter:Connect(function()
                              tween(item,0.5,Enum.EasingStyle.Circular,{ImageTransparency = 0})
                            end)

                            template.MouseLeave:Connect(function()
                              tween(item,0.5,Enum.EasingStyle.Circular,{ImageTransparency = 0.5})
                            end)
                          end
                        end
                      end
                    end
                  end
                end)

                UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(180, 103, 8)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 170, 0))}
                UIGradient.Parent = materials

                UICorner.CornerRadius = UDim.new(0, 15)
                UICorner.Parent = materials

                Title.Name = "Title"
                Title.Parent = materials
                Title.Active = true
                Title.AnchorPoint = Vector2.new(0.5, 0.5)
                Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Title.BackgroundTransparency = 1.000
                Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Title.BorderSizePixel = 0
                Title.Position = UDim2.new(0.471378595, 0, 0.715885401, 0)
                Title.Size = UDim2.new(0.842519701, 0, 0.185185179, 0)
                Title.FontFace = Font.fromId(12187373592,Enum.FontWeight.Bold)
                Title.Text = "Materials"
                Title.TextColor3 = Color3.fromRGB(255, 255, 255)
                Title.TextScaled = true
                Title.TextSize = 20.000
                Title.TextWrapped = true
                Title.TextXAlignment = Enum.TextXAlignment.Left

                Desc.Name = "Desc"
                Desc.Parent = materials
                Desc.Active = true
                Desc.AnchorPoint = Vector2.new(0.5, 0.5)
                Desc.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Desc.BackgroundTransparency = 1.000
                Desc.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Desc.BorderSizePixel = 0
                Desc.Position = UDim2.new(0.471378595, 0, 0.845026791, 0)
                Desc.Size = UDim2.new(0.842519701, 0, 0.153439149, 0)
                Desc.FontFace = Font.fromId(12187373592,Enum.FontWeight.Bold)
                Desc.Text = "Inspect Your Materials"
                Desc.TextColor3 = Color3.fromRGB(255, 255, 255)
                Desc.TextScaled = true
                Desc.TextSize = 20.000
                Desc.TextWrapped = true
                Desc.TextXAlignment = Enum.TextXAlignment.Left

                ImageLabel.Parent = materials
                ImageLabel.Active = true
                ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ImageLabel.BackgroundTransparency = 1.000
                ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
                ImageLabel.BorderSizePixel = 0
                ImageLabel.Position = UDim2.new(0.0826771632, 0, 0.365210146, 0)
                ImageLabel.Size = UDim2.new(0.196850389, 0, 0.264550269, 0)
                ImageLabel.Image = "rbxassetid://15534417635"
                ImageLabel.ScaleType = Enum.ScaleType.Fit

                background.Name = "background"
                background.Parent = materials
                background.Active = true
                background.AnchorPoint = Vector2.new(0.5, 0.5)
                background.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                background.BackgroundTransparency = 1.000
                background.BorderColor3 = Color3.fromRGB(0, 0, 0)
                background.BorderSizePixel = 0
                background.Position = UDim2.new(0.5, 0, 0.5, 0)
                background.Size = UDim2.new(1, 0, 1, 0)
                background.ZIndex = 0
                background.Image = "rbxassetid://15534482279"
                background.ImageTransparency = 0.850
                background.ScaleType = Enum.ScaleType.Crop

                local UICornerbackground = Instance.new("UICorner")

                UICornerbackground.CornerRadius = UDim.new(0, 15)
                UICornerbackground.Parent = background

                Tools.Name = "Tools"
                Tools.Parent = materials
                Tools.Active = true
                Tools.AnchorPoint = Vector2.new(0.5, 0.5)
                Tools.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Tools.BackgroundTransparency = 1.000
                Tools.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Tools.BorderSizePixel = 0
                Tools.Position = UDim2.new(0.779527545, 0, 0.267195761, 0)
                Tools.Size = UDim2.new(0.899999976, 0, 0.850000024, 0)
                Tools.ZIndex = 0
                Tools.Image = "rbxassetid://15534682077"
                Tools.ScaleType = Enum.ScaleType.Fit
              end

              local function Fighting()
                local fighting = Instance.new("TextButton")
                local UIGradient = Instance.new("UIGradient")
                local UICorner = Instance.new("UICorner")
                local Title = Instance.new("TextLabel")
                local Desc = Instance.new("TextLabel")
                local ImageLabel = Instance.new("ImageLabel")
                local background = Instance.new("ImageLabel")
                local Tools = Instance.new("ImageLabel")

                task.spawn(function()
                  while task.wait() do
                    if Configuration:GetAttribute("ANIMATION") then
                      gradient_obj(UIGradient)
                    end
                  end
                end)

                fighting.Name = "fighting"
                fighting.Parent = list_inspect
                fighting.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                fighting.BorderColor3 = Color3.fromRGB(0, 0, 0)
                fighting.BorderSizePixel = 0
                fighting.Position = UDim2.new(0.340224028, 0, 0, 0)
                fighting.Size = UDim2.new(0.325224072, 0, 0.499349892, 0)
                fighting.AutoButtonColor = false
                fighting.Font = Enum.Font.SourceSans
                fighting.Text = ""
                fighting.TextColor3 = Color3.fromRGB(0, 0, 0)
                fighting.TextSize = 14.000
                fighting.TextTransparency = 1.000
                fighting.LayoutOrder = 5
                fighting.ZIndex = 999

                local frame_inspect = Instance.new("Frame")
                local listscroll = Instance.new("ScrollingFrame")
                local UIGridLayout = Instance.new("UIGridLayout")

                frame_inspect.Name = "frame_inspect"
                frame_inspect.Parent = container_kaitun
                frame_inspect.Active = true
                frame_inspect.BackgroundColor3 = Color3.fromRGB(57, 57, 57)
                frame_inspect.BackgroundTransparency = 1.000
                frame_inspect.BorderColor3 = Color3.fromRGB(0, 0, 0)
                frame_inspect.BorderSizePixel = 0
                frame_inspect.Position = UDim2.new(0, 0, -1.40858248e-07, 0)
                frame_inspect.Size = UDim2.new(0.989860594, 0, 1.00031638, 0)
                frame_inspect.LayoutOrder = 1

                local back = Instance.new("TextButton")
                local ImageLabelback = Instance.new("ImageLabel")

                back.Name = "back"
                back.Parent = frame_inspect
                back.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                back.BackgroundTransparency = 1.000
                back.BorderColor3 = Color3.fromRGB(0, 0, 0)
                back.BorderSizePixel = 0
                back.Position = UDim2.new(0.748522222, 0, -0.119129822, 0)
                back.Size = UDim2.new(0.216634557, 0, 0.063759625, 0)
                back.FontFace = Font.fromId(12187373592,Enum.FontWeight.Bold)
                back.Text = "Back"
                back.TextColor3 = Theme(Configuration:GetAttribute("THEME"),"TextColor")
                back.TextScaled = true
                back.TextSize = 14.000
                back.TextWrapped = true
                back.TextXAlignment = Enum.TextXAlignment.Right

                back.MouseButton1Down:Connect(function()
                  UIPageLayout_kaitun:JumpToIndex(0)
                end)

                ImageLabelback.Parent = back
                ImageLabelback.Active = true
                ImageLabelback.AnchorPoint = Vector2.new(0.5, 0.5)
                ImageLabelback.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ImageLabelback.BackgroundTransparency = 1.000
                ImageLabelback.BorderColor3 = Color3.fromRGB(0, 0, 0)
                ImageLabelback.BorderSizePixel = 0
                ImageLabelback.Position = UDim2.new(1.10000002, 0, 0.5, 0)
                ImageLabelback.Rotation = 180.000
                ImageLabelback.Size = UDim2.new(0.181, 0, 0.789, 0)
                ImageLabelback.Image = "http://www.roblox.com/asset/?id=6023426922"
                ImageLabelback.ImageColor3 = Color3.fromRGB(255, 61, 61)

                listscroll.Name = "list"
                listscroll.Parent = frame_inspect
                listscroll.Active = true
                listscroll.AnchorPoint = Vector2.new(0.5, 0.5)
                listscroll.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                listscroll.BorderColor3 = Color3.fromRGB(0, 0, 0)
                listscroll.BorderSizePixel = 0
                listscroll.Position = UDim2.new(0.5, 0, 0.5, 0)
                listscroll.Size = UDim2.new(1, 0, 1, 0)
                listscroll.ScrollBarThickness = 0
                listscroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
                listscroll.BackgroundTransparency = 1

                UIGridLayout.Parent = listscroll
                UIGridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
                UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
                UIGridLayout.CellPadding = UDim2.new(0.0149999997, 0, 0.0450000018, 0)
                UIGridLayout.CellSize = UDim2.new(0.230000004, 0, 0.29, 0)
                UIGridLayout.FillDirectionMaxCells = 4

                fighting.MouseButton1Down:Connect(function()
                  if page_frame:GetAttribute("KAITUN") then

                    for i,v in pairs(listscroll:GetChildren()) do
                      if v:IsA("Frame") then
                        v:Destroy()
                      end
                    end
                    UIPageLayout_kaitun:JumpTo(frame_inspect)

                    local getloadmelee = function()
                      local melee = GetMeleeText()
                      for i,v in pairs(melee) do
                        for getnum,getreal in pairs(FightGet) do
                          if getnum == v then

                            local template = Instance.new("Frame")
                            local UICorner = Instance.new("UICorner")
                            local item = Instance.new("ImageLabel")
                            local glow = Instance.new("ImageLabel")

                            for o,oo in pairs(FightGet) do
                              if o == getnum then
                                for i,v in pairs(oo) do
                                  if i == "ID" then
                                    item.Image = v
                                  end
                                  if i == "ImageRectOffset" then
                                    item.ImageRectOffset = v
                                  end
                                  if i == "ImageRectSize" then
                                    item.ImageRectSize = v
                                  end
                                end
                              end
                            end

                            template.Name = "template"
                            template.Parent = listscroll
                            template.Active = true
                            template.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
                            template.BorderColor3 = Color3.fromRGB(0, 0, 0)
                            template.BorderSizePixel = 0
                            template.Size = UDim2.new(0, 100, 0, 100)

                            UICorner.CornerRadius = UDim.new(0, 15)
                            UICorner.Parent = template

                            item.Name = "item"
                            item.Parent = template
                            item.Active = true
                            item.AnchorPoint = Vector2.new(0.5, 0.5)
                            item.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            item.BackgroundTransparency = 1.000
                            item.BorderColor3 = Color3.fromRGB(0, 0, 0)
                            item.BorderSizePixel = 0
                            item.Position = UDim2.new(0.5, 0, 0.5, 0)
                            item.Size = UDim2.new(0.850000024, 0, 0.850000024, 0)
                            item.ImageTransparency = 0.5
                            item.ZIndex = 1

                            glow.Name = "glow"
                            glow.Parent = template
                            glow.Active = true
                            glow.AnchorPoint = Vector2.new(0.5, 0.5)
                            glow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            glow.BackgroundTransparency = 1.000
                            glow.BorderColor3 = Color3.fromRGB(0, 0, 0)
                            glow.BorderSizePixel = 0
                            glow.Position = UDim2.new(0.5, 0, 0.5, 0)
                            glow.Size = UDim2.new(1, 0, 1, 0)
                            glow.Image = "rbxassetid://15534890357"
                            glow.ImageTransparency = 0.95
                            glow.ZIndex = 0

                            template.MouseEnter:Connect(function()
                              tween(item,0.5,Enum.EasingStyle.Circular,{ImageTransparency = 0})
                            end)

                            template.MouseLeave:Connect(function()
                              tween(item,0.5,Enum.EasingStyle.Circular,{ImageTransparency = 0.5})
                            end)
                          end
                        end
                      end
                    end
                    getloadmelee()
                  end
                end)

                UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(38, 38, 38)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(81, 81, 81))}
                UIGradient.Parent = fighting

                UICorner.CornerRadius = UDim.new(0, 15)
                UICorner.Parent = fighting

                Title.Name = "Title"
                Title.Parent = fighting
                Title.Active = true
                Title.AnchorPoint = Vector2.new(0.5, 0.5)
                Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Title.BackgroundTransparency = 1.000
                Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Title.BorderSizePixel = 0
                Title.Position = UDim2.new(0.471378595, 0, 0.715885401, 0)
                Title.Size = UDim2.new(0.842519701, 0, 0.185185179, 0)
                Title.FontFace = Font.fromId(12187373592,Enum.FontWeight.Bold)
                Title.Text = "Fighting Styles"
                Title.TextColor3 = Color3.fromRGB(255, 255, 255)
                Title.TextScaled = true
                Title.TextSize = 20.000
                Title.TextWrapped = true
                Title.TextXAlignment = Enum.TextXAlignment.Left

                Desc.Name = "Desc"
                Desc.Parent = fighting
                Desc.Active = true
                Desc.AnchorPoint = Vector2.new(0.5, 0.5)
                Desc.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Desc.BackgroundTransparency = 1.000
                Desc.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Desc.BorderSizePixel = 0
                Desc.Position = UDim2.new(0.471378595, 0, 0.845026791, 0)
                Desc.Size = UDim2.new(0.842519701, 0, 0.153439149, 0)
                Desc.FontFace = Font.fromId(12187373592,Enum.FontWeight.Bold)
                Desc.Text = "Inspect Your Fighting Styles"
                Desc.TextColor3 = Color3.fromRGB(255, 255, 255)
                Desc.TextScaled = true
                Desc.TextSize = 20.000
                Desc.TextWrapped = true
                Desc.TextXAlignment = Enum.TextXAlignment.Left

                ImageLabel.Parent = fighting
                ImageLabel.Active = true
                ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ImageLabel.BackgroundTransparency = 1.000
                ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
                ImageLabel.BorderSizePixel = 0
                ImageLabel.Position = UDim2.new(0.0826771632, 0, 0.365210146, 0)
                ImageLabel.Size = UDim2.new(0.196850389, 0, 0.264550269, 0)
                ImageLabel.Image = "rbxassetid://15534417635"
                ImageLabel.ScaleType = Enum.ScaleType.Fit

                background.Name = "background"
                background.Parent = fighting
                background.Active = true
                background.AnchorPoint = Vector2.new(0.5, 0.5)
                background.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                background.BackgroundTransparency = 1.000
                background.BorderColor3 = Color3.fromRGB(0, 0, 0)
                background.BorderSizePixel = 0
                background.Position = UDim2.new(0.5, 0, 0.5, 0)
                background.Size = UDim2.new(1, 0, 1, 0)
                background.ZIndex = 0
                background.Image = "rbxassetid://15534482279"
                background.ImageTransparency = 0.850
                background.ScaleType = Enum.ScaleType.Crop

                local UICornerbackground = Instance.new("UICorner")

                UICornerbackground.CornerRadius = UDim.new(0, 15)
                UICornerbackground.Parent = background

                Tools.Name = "Tools"
                Tools.Parent = fighting
                Tools.Active = true
                Tools.AnchorPoint = Vector2.new(0.5, 0.5)
                Tools.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Tools.BackgroundTransparency = 1.000
                Tools.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Tools.BorderSizePixel = 0
                Tools.Position = UDim2.new(0.779527545, 0, 0.267195761, 0)
                Tools.Size = UDim2.new(0.899999976, 0, 0.850000024, 0)
                Tools.ZIndex = 0
                Tools.Image = "rbxassetid://15534706422"
                Tools.ScaleType = Enum.ScaleType.Fit
              end

              task.spawn(function()
                Fruit()
                Accessories()
                Sword()
                Gun()
                Material()
                Fighting()
              end)

              list_inspect.Name = "list_inspect"
              list_inspect.Parent = container_kaitun
              list_inspect.Active = true
              list_inspect.BackgroundColor3 = Color3.fromRGB(57, 57, 57)
              list_inspect.BackgroundTransparency = 1.000
              list_inspect.BorderColor3 = Color3.fromRGB(0, 0, 0)
              list_inspect.BorderSizePixel = 0
              list_inspect.Position = UDim2.new(0.0139416987, 0, 0.196052626, 0)
              list_inspect.Size = UDim2.new(0.99, 0, 0.286, 0)

              UIListLayout.Parent = list_inspect
              UIListLayout.FillDirection = Enum.FillDirection.Horizontal
              UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
              UIListLayout.Padding = UDim.new(0.0250000004, 0)

              button.MouseButton1Down:Connect(function()
                tween(button,0.25,Enum.EasingStyle.Circular,{Rotation = 0,Size = UDim2.new(0.65,0,0.65,0),ImageColor3 = Configuration:GetAttribute("COLOR")})
                for i,v in pairs(Folder:GetChildren()) do
                  if v:IsA("Frame") and v.Name ~= "mainframe" then
                    if v.Name == page_frame.Name then
                      UIPageLayout:JumpTo(v)
                    end
                  end
                end

                for i,v in pairs(scroll_select_frame:GetChildren()) do
                  if v:IsA("Frame") then
                    for i,v in pairs(v:GetChildren()) do
                      if v:IsA("ImageButton") then
                        tween(v,0.25,Enum.EasingStyle.Circular,{ImageColor3  = Color3.fromRGB(255,255,255)})
                      end
                    end
                    tween(button,0.25,Enum.EasingStyle.Circular,{ImageColor3  = Color3.fromRGB(0, 0, 0)})
                  end
                end
              end)

              button.MouseEnter:Connect(function()
                tween(button,0.25,Enum.EasingStyle.Back,{Rotation = 0,Size = UDim2.new(0.85,0,0.85,0)})
              end)

              button.MouseLeave:Connect(function()
                tween(button,0.25,Enum.EasingStyle.Back,{Rotation = 0,Size = UDim2.new(0.75,0,0.75,0)})
              end)
            else

              local Title = options.Title or "Page"
              local Desc = options.Desc or "Description"

              local page_frame = Instance.new("Frame")

              page_frame.Name = random.."_pageframe"
              page_frame.Parent = Folder
              page_frame.Active = true
              page_frame.AnchorPoint = Vector2.new(0.5, 0.5)
              page_frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
              page_frame.BackgroundTransparency = 1.000
              page_frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
              page_frame.BorderSizePixel = 0
              page_frame.Position = UDim2.new(0.5, 0, 0.5, 0)
              page_frame.Size = UDim2.new(1, 0, 1, 0)
              page_frame.LayoutOrder = layout	

              button.MouseButton1Down:Connect(function()
                tween(button,0.25,Enum.EasingStyle.Circular,{Rotation = 0,Size = UDim2.new(0.65,0,0.65,0),ImageColor3 = Configuration:GetAttribute("COLOR")})
                for i,v in pairs(Folder:GetChildren()) do
                  if v:IsA("Frame") and v.Name ~= "mainframe" then
                    if v.Name == page_frame.Name then
                      UIPageLayout:JumpTo(v)
                    end
                  end
                end

                for i,v in pairs(scroll_select_frame:GetChildren()) do
                  if v:IsA("Frame") then
                    for i,v in pairs(v:GetChildren()) do
                      if v:IsA("ImageButton") then
                        tween(v,0.25,Enum.EasingStyle.Circular,{ImageColor3  = Color3.fromRGB(255,255,255)})
                      end
                    end
                    tween(button,0.25,Enum.EasingStyle.Circular,{ImageColor3  = Color3.fromRGB(0, 0, 0)})
                  end
                end
              end)

              button.MouseEnter:Connect(function()
                tween(button,0.25,Enum.EasingStyle.Back,{Rotation = 0,Size = UDim2.new(0.85,0,0.85,0)})
              end)

              button.MouseLeave:Connect(function()
                tween(button,0.25,Enum.EasingStyle.Back,{Rotation = 0,Size = UDim2.new(0.75,0,0.75,0)})
              end)

              local title_topbar = Instance.new("Frame")
              local TextLabel = Instance.new("TextLabel")
              local UIGradient = Instance.new("UIGradient")
              local TextLabel_2 = Instance.new("TextLabel")

              title_topbar.Name = "title_topbar"
              title_topbar.Parent = page_frame
              title_topbar.Active = true
              title_topbar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
              title_topbar.BackgroundTransparency = 1.000
              title_topbar.BorderColor3 = Color3.fromRGB(0, 0, 0)
              title_topbar.BorderSizePixel = 0
              title_topbar.Position = UDim2.new(0.0140000256, 0, 0.0250000004, 0)
              title_topbar.Size = UDim2.new(0.984970987, 0, 0.1625247, 0)

              TextLabel.Parent = title_topbar
              TextLabel.Active = true
              TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
              TextLabel.BackgroundTransparency = 1.000
              TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
              TextLabel.BorderSizePixel = 0
              TextLabel.Size = UDim2.new(0.425595164, 0, 0.418757498, 0)
              TextLabel.FontFace = Font.fromId(12187373592,Enum.FontWeight.Bold)
              TextLabel.Text = Title
              TextLabel.TextColor3 = Theme(Configuration:GetAttribute("THEME"),"TextColor")
              TextLabel.TextScaled = true
              TextLabel.TextSize = 14.000
              TextLabel.TextWrapped = true
              TextLabel.TextXAlignment = Enum.TextXAlignment.Left

              UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Theme(Configuration:GetAttribute("THEME"),"Color")), ColorSequenceKeypoint.new(1.00, Theme(Configuration:GetAttribute("THEME"),"Color2"))}
              UIGradient.Parent = TextLabel

              TextLabel_2.Parent = title_topbar
              TextLabel_2.Active = true
              TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
              TextLabel_2.BackgroundTransparency = 1.000
              TextLabel_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
              TextLabel_2.BorderSizePixel = 0
              TextLabel_2.Position = UDim2.new(0, 0, 0.340119123, 0)
              TextLabel_2.Size = UDim2.new(0.425595164, 0, 0.221293315, 0)
              TextLabel_2.ZIndex = 999
              TextLabel_2.FontFace = Font.fromId(12187373592,Enum.FontWeight.Bold)
              TextLabel_2.Text = Desc
              TextLabel_2.TextColor3 = Theme(Configuration:GetAttribute("THEME"),"TextColor")
              TextLabel_2.TextScaled = true
              TextLabel_2.TextSize = 14.000
              TextLabel_2.TextWrapped = true
              TextLabel_2.TextXAlignment = Enum.TextXAlignment.Left

              local container = Instance.new("Frame")

              container.Name = "container_kaitun"
              container.Parent = page_frame
              container.Active = true
              container.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
              container.BackgroundTransparency = 1.000
              container.BorderColor3 = Color3.fromRGB(0, 0, 0)
              container.BorderSizePixel = 0
              container.ClipsDescendants = true
              container.Position = UDim2.new(0.013941776, 0, 0.129501507, 0)
              container.Size = UDim2.new(0.986058295, 0, 0.867105246, 0)

              local left = Instance.new("Frame")
              local left_scroll = Instance.new("ScrollingFrame")
              local UIListLayout = Instance.new("UIListLayout")
              local UIPadding = Instance.new("UIPadding")

              left.Name = "left"
              left.Parent = container
              left.Active = true
              left.BackgroundColor3 = Color3.fromRGB(33, 34, 23)
              left.BackgroundTransparency = 1.000
              left.BorderColor3 = Color3.fromRGB(0, 0, 0)
              left.BorderSizePixel = 0
              left.Position = UDim2.new(0, 0, -2.53299941e-08, 0)
              left.Size = UDim2.new(0.499224812, 0, 0.996925354, 0)

              left_scroll.Name = "left_scroll"
              left_scroll.Parent = left
              left_scroll.Active = true
              left_scroll.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
              left_scroll.BackgroundTransparency = 1.000
              left_scroll.BorderColor3 = Color3.fromRGB(0, 0, 0)
              left_scroll.BorderSizePixel = 0
              left_scroll.Size = UDim2.new(1, 0, 0.998262465, 0)
              left_scroll.CanvasSize = UDim2.new(0, 0, 0, 0)

              UIListLayout.Parent = left_scroll
              UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

              UIPadding.Parent = left_scroll
              UIPadding.PaddingLeft = UDim.new(0.0250000004, 0)

              local right = Instance.new("Frame")
              local right_scroll = Instance.new("ScrollingFrame")
              local UIListLayout = Instance.new("UIListLayout")
              local UIPadding = Instance.new("UIPadding")

              right.Name = "right"
              right.Parent = container
              right.Active = true
              right.BackgroundColor3 = Color3.fromRGB(33, 34, 23)
              right.BackgroundTransparency = 1.000
              right.BorderColor3 = Color3.fromRGB(0, 0, 0)
              right.BorderSizePixel = 0
              right.Position = UDim2.new(0.499224812, 0, -2.53299941e-08, 0)
              right.Size = UDim2.new(0.499224812, 0, 0.996925354, 0)

              right_scroll.Name = "right_scroll"
              right_scroll.Parent = right
              right_scroll.Active = true
              right_scroll.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
              right_scroll.BackgroundTransparency = 1.000
              right_scroll.BorderColor3 = Color3.fromRGB(0, 0, 0)
              right_scroll.BorderSizePixel = 0
              right_scroll.Size = UDim2.new(1, 0, 0.998262465, 0)
              right_scroll.CanvasSize = UDim2.new(0, 0, 0, 0)

              UIListLayout.Parent = right_scroll
              UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

              UIPadding.Parent = right_scroll
              UIPadding.PaddingLeft = UDim.new(0.0250000004, 0)

              local function Side(args)
                if args == 1 then
                  return left_scroll
                elseif args == 2 then
                  return right_scroll
                else
                  return left_scroll
                end
              end

              luxurylibrary.Seperator = function(side)
                local SideScroll = side or Side(1)
                local Line = Instance.new("Frame")

                Line.Name = "Line"
                Line.Parent = Side(SideScroll)
                Line.Active = true
                Line.BackgroundColor3 = Theme(Configuration:GetAttribute("THEME"),"TextColor")
                Line.BackgroundTransparency = 0.450
                Line.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Line.BorderSizePixel = 0
                Line.Position = UDim2.new(-2.67984518e-07, 0, 0.120260887, 0)
                Line.Size = UDim2.new(0.926596642, 0, 0.00205974048, 0)
              end

              luxurylibrary.Label = function(side,name)
                local SideScroll = side or Side(1)

                local Label = Instance.new("TextLabel")

                Label.Name = "Label"
                Label.Parent = Side(SideScroll)
                Label.Active = true
                Label.AnchorPoint = Vector2.new(0.5, 0.5)
                Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Label.BackgroundTransparency = 1.000
                Label.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Label.BorderSizePixel = 0
                Label.Position = UDim2.new(0.476751745, 0, 0.0960609615, 0)
                Label.Size = UDim2.new(0.953504086, 0, 0.0525193885, 0)
                Label.FontFace = Font.fromId(12187373592,Enum.FontWeight.Bold)
                Label.Text = name
                Label.TextColor3 = Theme(Configuration:GetAttribute("THEME"),"TextColor")
                Label.TextScaled = true
                Label.TextSize = 25.000
                Label.TextWrapped = true
                Label.TextXAlignment = Enum.TextXAlignment.Left

                local labelfunction = {}


                function labelfunction:Options()
                  return Label
                end

                return labelfunction
              end

              luxurylibrary.Toggle = function(side,name,default,callback)
                local SideScroll = side or Side(1)

                local TextButton = Instance.new("TextButton")
                local TextLabel = Instance.new("TextLabel")

                TextButton.Parent = Side(SideScroll)
                TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TextButton.BackgroundTransparency = 1.000
                TextButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
                TextButton.BorderSizePixel = 0
                TextButton.Position = UDim2.new(-3.94896169e-08, 0, 0, 0)
                TextButton.Size = UDim2.new(0.975155294, 0, 0.0698012486, 0)
                TextButton.Modal = true
                TextButton.Font = Enum.Font.SourceSans
                TextButton.Text = ""
                TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
                TextButton.TextSize = 14.000
                TextButton.TextTransparency = 1.000

                TextLabel.Parent = TextButton
                TextLabel.Active = true
                TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
                TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TextLabel.BackgroundTransparency = 1.000
                TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
                TextLabel.BorderSizePixel = 0
                TextLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
                TextLabel.Size = UDim2.new(1, 0, 1, 0)
                TextLabel.FontFace = Font.fromId(12187373592,Enum.FontWeight.Bold)
                TextLabel.Text = name
                TextLabel.TextColor3 = Theme(Configuration:GetAttribute("THEME"),"TextColor")
                TextLabel.TextScaled = true
                TextLabel.TextSize = 25.000
                TextLabel.TextWrapped = true
                TextLabel.TextXAlignment = Enum.TextXAlignment.Left

                local Frame = Instance.new("Frame")
                local UICorner = Instance.new("UICorner")
                local Frame_2 = Instance.new("Frame")
                local UICorner_2 = Instance.new("UICorner")

                Frame.Parent = TextButton
                Frame.Active = true
                Frame.AnchorPoint = Vector2.new(0.5, 0.5)
                Frame.BackgroundColor3 = Theme(Configuration:GetAttribute("THEME"),"Console")
                Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Frame.BorderSizePixel = 0
                Frame.Position = UDim2.new(0.860000014, 0, 0.5, 0)
                Frame.Size = UDim2.new(0.235594466, 0, 0.828974307, 0)

                UICorner.CornerRadius = UDim.new(0, 300)
                UICorner.Parent = Frame

                Frame_2.Parent = Frame
                Frame_2.Active = true
                Frame_2.AnchorPoint = Vector2.new(0.5, 0.5)
                Frame_2.BackgroundColor3 = Theme(Configuration:GetAttribute("THEME"),"Color")
                Frame_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Frame_2.BorderSizePixel = 0
                Frame_2.Position = UDim2.new(0.200000003, 0, 0.5, 0)
                Frame_2.Size = UDim2.new(0.321839094, 0, 0.756756783, 0)

                UICorner_2.CornerRadius = UDim.new(0, 30)
                UICorner_2.Parent = Frame_2

                local stroke = Instance.new("UIStroke",Frame)
                stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                stroke.Color = Theme(Configuration:GetAttribute("THEME"),"TextColor")
                stroke.LineJoinMode = Enum.LineJoinMode.Round
                stroke.Transparency = 0.85
                stroke.Thickness = 1

                local togglefocus = false

                TextButton.MouseButton1Down:Connect(function()
                  if not togglefocus then
                    tween(Frame_2,0.25,Enum.EasingStyle.Circular,{Position = UDim2.new(0.76, 0, 0.5, 0)})
                  else
                    tween(Frame_2,0.25,Enum.EasingStyle.Circular,{Position = UDim2.new(0.200000003, 0, 0.5, 0)})
                  end
                  togglefocus = not togglefocus
                  callback(togglefocus)
                end)

                if default then
                  tween(Frame_2,0.25,Enum.EasingStyle.Circular,{Position = UDim2.new(0.76, 0, 0.5, 0)})
                  togglefocus = not togglefocus
                  callback(togglefocus)
                end

                local togglefunction = {}

                function togglefunction.SetValue(value)
                  if value then
                    tween(Frame_2,0.25,Enum.EasingStyle.Circular,{Position = UDim2.new(0.76, 0, 0.5, 0)})
                    togglefocus = not togglefocus
                  else
                    tween(Frame_2,0.25,Enum.EasingStyle.Circular,{Position = UDim2.new(0.200000003, 0, 0.5, 0)})
                    togglefocus = not togglefocus
                  end
                  callback(value)
                end
                return togglefunction
              end
            end
          end)
        end
      end
    end
  end
end)
return luxurylibrary
