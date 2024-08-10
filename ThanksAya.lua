(function(...)
	local UserInputService = game:GetService("UserInputService")
	local args = {...}
	if true then
		spawn(function()
			set_thread_identity = set_thread_identity or function(...) end
			set_thread_identity(8)
			local TweenService = game:GetService("TweenService")
			local RunService = game:GetService("RunService")
			local LocalPlayer = game:GetService("Players").LocalPlayer
			local Mouse = LocalPlayer:GetMouse()		
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
					local Tween = TweenService:Create(object, TweenInfo.new(0.2), {Position = pos})
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
			local RoyXUi = args[1]
				
			if not RoyXUi then return end
			if game:GetService("CoreGui"):FindFirstChild("CloseUI") then
				game:GetService("CoreGui"):FindFirstChild("CloseUI"):Destroy()
			end
		
			local ScreenGui = Instance.new("ScreenGui")
			local Frame = Instance.new("Frame")
			Frame.ZIndex = 99999
								 
			local UICorner = Instance.new("UICorner")
			local TextLabel = Instance.new("TextLabel")
			local TextButton = Instance.new("TextButton")
					MakeDraggable(TextButton,Frame)
				
			ScreenGui.Name = "CloseUI"
			ScreenGui.Parent = game:GetService("CoreGui")
			ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		
			Frame.Parent = ScreenGui
			Frame.Active = true
			Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			Frame.BorderSizePixel = 0
			Frame.Position = UDim2.new(0.081166774, 0, 0.0841463208, 0)
			Frame.Size = UDim2.new(0, 47, 0, 47)
		
			UICorner.Parent = Frame
		
			TextLabel.Parent = Frame
			TextLabel.Active = true
			TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TextLabel.BackgroundTransparency = 1.000
			TextLabel.Position = UDim2.new(0, 0, 0.0212765951, 0)
			TextLabel.Size = UDim2.new(0, 47, 0, 47)
			TextLabel.Font = Enum.Font.GothamBold
			TextLabel.Text = "OFF"
			TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			TextLabel.TextSize = 14.000
		
			TextButton.Parent = Frame
			TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TextButton.BackgroundTransparency = 1.000
			TextButton.Size = UDim2.new(0, 47, 0, 47)
			TextButton.Font = Enum.Font.SourceSans
			TextButton.Text = ""
			TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
			TextButton.TextSize = 14.000
		
			local focus = false
		
			TextButton.MouseButton1Down:Connect(function()
				if not focus then
					TextLabel.Text = "ON"
					RoyXUi.Enabled = false
				else
					TextLabel.Text = "OFF"
					RoyXUi.Enabled = true
				end
				focus = not focus
			end)
		end)
	end
end)(...)
