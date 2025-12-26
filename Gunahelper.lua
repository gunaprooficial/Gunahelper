-- GUNA HELPER - SCRIPT FINAL COMPLETO

local Players = game:GetService("Players")
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
local Stroke = Instance.new("UIStroke", Main)
Stroke.Thickness = 3

-- NEON GRADIENT
local Gradient = Instance.new("UIGradient", Main)
Gradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(120,0,255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(0,255,255))
}

-- TITLE
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1,0,0,50)
Title.BackgroundTransparency = 1
Title.Text = "GUNA HELPER"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 30

-- MINIMIZE
local Minimize = Instance.new("TextButton", Main)
Minimize.Size = UDim2.new(0,40,0,40)
Minimize.Position = UDim2.new(1,-45,0,5)
Minimize.Text = "-"
Minimize.Font = Enum.Font.GothamBold
Minimize.TextSize = 28
Minimize.BackgroundTransparency = 1
Minimize.TextColor3 = Color3.new(1,1,1)

-- ICON (ROUND)
local Icon = Instance.new("TextButton", ScreenGui)
Icon.Size = UDim2.new(0,70,0,70)
Icon.Position = UDim2.new(0,20,0.5,-35)
Icon.Text = "GUNA\nHELPER"
Icon.TextScaled = true
Icon.TextWrapped = true
Icon.Font = Enum.Font.GothamBold
Icon.BackgroundColor3 = Color3.fromRGB(15,15,15)
Icon.Visible = false
Icon.AutoButtonColor = false

local IconCorner = Instance.new("UICorner", Icon)
IconCorner.CornerRadius = UDim.new(1,0)

local IconStroke = Instance.new("UIStroke", Icon)
IconStroke.Thickness = 2

-- RGB ANIMATION
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
local function CreateButton(text, y, red)
	local b = Instance.new("TextButton", Main)
	b.Size = UDim2.new(0.8,0,0,45)
	b.Position = UDim2.new(0.1,0,0,y)
	b.Text = text
	b.Font = Enum.Font.GothamBold
	b.TextSize = 18
	b.BackgroundColor3 = Color3.fromRGB(20,20,20)
	b.TextColor3 = Color3.new(1,1,1)
	b.AutoButtonColor = false

	Instance.new("UICorner", b).CornerRadius = UDim.new(0,12)
	local s = Instance.new("UIStroke", b)
	s.Thickness = 2

	task.spawn(function()
		local h = 0
		while true do
			if red then
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

-- ACTIONS
Miranda.MouseButton1Click:Connect(function()
	loadstring(game:HttpGet("https://pastefy.app/JJVhs3rK/raw"))()
end)

AutoSteal.MouseButton1Click:Connect(function()
	loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Instantly-interact-prompts-30752"))()
end)

POV.MouseButton1Click:Connect(function()
	local cam = workspace.CurrentCamera
	RunService.RenderStepped:Connect(function()
		if cam then cam.FieldOfView = 120 end
	end)
end)

-- DRAG MAIN
local dragging, dragInput, dragStart, startPos

Main.InputBegan:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = i.Position
		startPos = Main.Position
		i.Changed:Connect(function()
			if i.UserInputState == Enum.UserInputState.End then dragging = false end
		end)
	end
end)

Main.InputChanged:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch then
		dragInput = i
	end
end)

UserInputService.InputChanged:Connect(function(i)
	if i == dragInput and dragging then
		local delta = i.Position - dragStart
		Main.Position = UDim2.new(startPos.X.Scale,startPos.X.Offset+delta.X,startPos.Y.Scale,startPos.Y.Offset+delta.Y)
	end
end)

-- DRAG ICON
local iDrag, iInput, iStart, iPos

Icon.InputBegan:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
		iDrag = true
		iStart = i.Position
		iPos = Icon.Position
		i.Changed:Connect(function()
			if i.UserInputState == Enum.UserInputState.End then iDrag = false end
		end)
	end
end)

Icon.InputChanged:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch then
		iInput = i
	end
end)

UserInputService.InputChanged:Connect(function(i)
	if i == iInput and iDrag then
		local d = i.Position - iStart
		Icon.Position = UDim2.new(iPos.X.Scale,iPos.X.Offset+d.X,iPos.Y.Scale,iPos.Y.Offset+d.Y)
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
