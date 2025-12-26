--[[ 
 GUNA HELPER - ALL IN ONE
 Coloque em StarterPlayer > StarterPlayerScripts (LocalScript)
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GunaHelper"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = player:WaitForChild("PlayerGui")

-- MAIN FRAME
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 420, 0, 260)
Main.Position = UDim2.new(0.5, -210, 0.5, -130)
Main.BackgroundColor3 = Color3.fromRGB(10,10,10)
Main.BorderSizePixel = 0
Main.Parent = ScreenGui

Instance.new("UICorner", Main).CornerRadius = UDim.new(0,16)

-- STROKE RGB
local Stroke = Instance.new("UIStroke")
Stroke.Thickness = 3
Stroke.Parent = Main

-- NEON GRADIENT
local Gradient = Instance.new("UIGradient")
Gradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(120,0,255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(0,255,255))
}
Gradient.Parent = Main

-- TITLE
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,0,0,50)
Title.BackgroundTransparency = 1
Title.Text = "GUNA HELPER"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 30
Title.Parent = Main

-- MINIMIZE BUTTON
local Minimize = Instance.new("TextButton")
Minimize.Size = UDim2.new(0,40,0,40)
Minimize.Position = UDim2.new(1,-45,0,5)
Minimize.Text = "-"
Minimize.Font = Enum.Font.GothamBold
Minimize.TextSize = 28
Minimize.BackgroundTransparency = 1
Minimize.TextColor3 = Color3.new(1,1,1)
Minimize.Parent = Main

-- ICON (TEXT RGB)
local Icon = Instance.new("TextButton")
Icon.Size = UDim2.new(0,160,0,45)
Icon.Position = UDim2.new(0,20,0.5,-22)
Icon.Text = "GUNA HELPER"
Icon.Font = Enum.Font.GothamBold
Icon.TextSize = 18
Icon.BackgroundColor3 = Color3.fromRGB(15,15,15)
Icon.Visible = false
Icon.AutoButtonColor = false
Icon.Parent = ScreenGui

Instance.new("UICorner", Icon).CornerRadius = UDim.new(0,12)
local IconStroke = Instance.new("UIStroke", Icon)
IconStroke.Thickness = 2

-- RGB ANIMATIONS
task.spawn(function()
	local h = 0
	while true do
		h = (h + 1) % 360
		local c = Color3.fromHSV(h/360,1,1)
		Title.TextColor3 = c
		Stroke.Color = c
		Icon.TextColor3 = c
		IconStroke.Color = c
		task.wait(0.03)
	end
end)

task.spawn(function()
	while true do
		Gradient.Rotation += 1
		task.wait(0.02)
	end
end)

-- BUTTON CREATOR
local function CreateButton(text, y, miranda)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(0.8,0,0,45)
	b.Position = UDim2.new(0.1,0,0,y)
	b.Text = text
	b.Font = Enum.Font.GothamBold
	b.TextSize = 18
	b.BackgroundColor3 = Color3.fromRGB(20,20,20)
	b.TextColor3 = Color3.new(1,1,1)
	b.AutoButtonColor = false
	b.Parent = Main

	Instance.new("UICorner", b).CornerRadius = UDim.new(0,12)
	local s = Instance.new("UIStroke", b)
	s.Thickness = 2

	task.spawn(function()
		local h = 0
		while true do
			if miranda then
				s.Color = Color3.fromRGB(255, math.sin(tick()*3)*127+128, math.sin(tick()*3)*127+128)
			else
				h = (h + 1) % 360
				s.Color = Color3.fromHSV(h/360,1,1)
			end
			task.wait(0.03)
		end
	end)

	return b
end

-- BUTTONS
local Miranda = CreateButton("Miranda Hub", 70, true)
local AutoSteal = CreateButton("Auto Steal (No Cooldown)", 125, false)
local POV = CreateButton("POV", 180, false)

-- BUTTON ACTIONS (ORDEM CORRETA)
Miranda.MouseButton1Click:Connect(function()
	loadstring(game:HttpGet("https://pastefy.app/JJVhs3rK/raw"))()
end)

AutoSteal.MouseButton1Click:Connect(function()
	loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Instantly-interact-prompts-30752"))()
end)

POV.MouseButton1Click:Connect(function()
	local camera = workspace.CurrentCamera
	RunService.RenderStepped:Connect(function()
		if camera then
			camera.FieldOfView = 120
		end
	end)
end)

-- DRAG MAIN
local dragging, dragInput, mousePos, framePos

Main.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		mousePos = input.Position
		framePos = Main.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

Main.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - mousePos
		Main.Position = UDim2.new(
			framePos.X.Scale, framePos.X.Offset + delta.X,
			framePos.Y.Scale, framePos.Y.Offset + delta.Y
		)
	end
end)

-- MINIMIZE / RESTORE
Minimize.MouseButton1Click:Connect(function()
	Main.Visible = false
	Icon.Visible = true
end)

Icon.MouseButton1Click:Connect(function()
	Main.Visible = true
	Icon.Visible = false
end)
