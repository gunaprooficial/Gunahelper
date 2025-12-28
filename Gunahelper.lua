-- GUNA HELPER | INTRO + GUI FINAL

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer

------------------------------------------------
-- SCREEN GUI
------------------------------------------------
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GunaHelper"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = player:WaitForChild("PlayerGui")

------------------------------------------------
-- INTRO
------------------------------------------------
local Intro = Instance.new("Frame", ScreenGui)
Intro.Size = UDim2.new(1,0,1,0)
Intro.BackgroundColor3 = Color3.fromRGB(5,5,5)
Intro.BackgroundTransparency = 1

local IntroCorner = Instance.new("UICorner", Intro)
IntroCorner.CornerRadius = UDim.new(0,20)

local IntroStroke = Instance.new("UIStroke", Intro)
IntroStroke.Thickness = 4
IntroStroke.Transparency = 1

local IntroText = Instance.new("TextLabel", Intro)
IntroText.Size = UDim2.new(1,0,1,0)
IntroText.BackgroundTransparency = 1
IntroText.Text = "script by: gunaprooficial99"
IntroText.Font = Enum.Font.GothamMedium
IntroText.TextSize = 32
IntroText.TextTransparency = 1

task.spawn(function()
	local h = 0
	while Intro.Parent do
		h = (h + 1) % 360
		local c = Color3.fromHSV(h/360,1,1)
		IntroText.TextColor3 = c
		IntroStroke.Color = c
		task.wait(0.03)
	end
end)

TweenService:Create(Intro, TweenInfo.new(0.8), {BackgroundTransparency = 0}):Play()
TweenService:Create(IntroText, TweenInfo.new(0.8), {TextTransparency = 0}):Play()
TweenService:Create(IntroStroke, TweenInfo.new(0.8), {Transparency = 0}):Play()

task.wait(2)

TweenService:Create(Intro, TweenInfo.new(0.8), {BackgroundTransparency = 1}):Play()
TweenService:Create(IntroText, TweenInfo.new(0.8), {TextTransparency = 1}):Play()
TweenService:Create(IntroStroke, TweenInfo.new(0.8), {Transparency = 1}):Play()

task.wait(0.9)
Intro:Destroy()

------------------------------------------------
-- MAIN GUI
------------------------------------------------
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0,0,0,0)
Main.Position = UDim2.new(0.5,-210,0.5,-130)
Main.BackgroundColor3 = Color3.fromRGB(10,10,10)
Main.BorderSizePixel = 0
Main.BackgroundTransparency = 1
Main.Parent = ScreenGui

Instance.new("UICorner", Main).CornerRadius = UDim.new(0,16)

local Stroke = Instance.new("UIStroke", Main)
Stroke.Thickness = 3
Stroke.Transparency = 1

local Gradient = Instance.new("UIGradient", Main)
Gradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(120,0,255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(0,255,255))
}

TweenService:Create(Main, TweenInfo.new(0.5, Enum.EasingStyle.Back), {
	Size = UDim2.new(0,420,0,260),
	BackgroundTransparency = 0
}):Play()
TweenService:Create(Stroke, TweenInfo.new(0.5), {Transparency = 0}):Play()

------------------------------------------------
-- TITLE
------------------------------------------------
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1,0,0,50)
Title.BackgroundTransparency = 1
Title.Text = "GUNA HELPER"
Title.Font = Enum.Font.GothamMedium
Title.TextSize = 28
Title.TextStrokeTransparency = 1

------------------------------------------------
-- MINIMIZE
------------------------------------------------
local Minimize = Instance.new("TextButton", Main)
Minimize.Size = UDim2.new(0,40,0,40)
Minimize.Position = UDim2.new(1,-45,0,5)
Minimize.Text = "-"
Minimize.Font = Enum.Font.GothamMedium
Minimize.TextSize = 26
Minimize.BackgroundTransparency = 1
Minimize.TextColor3 = Color3.new(1,1,1)

------------------------------------------------
-- ICON
------------------------------------------------
local Icon = Instance.new("ImageButton", ScreenGui)
Icon.Size = UDim2.new(0,70,0,70)
Icon.Position = UDim2.new(0,20,0.5,-35)
Icon.Image = "rbxassetid://138131777234445"
Icon.BackgroundTransparency = 1
Icon.Visible = false
Icon.AutoButtonColor = false
Instance.new("UICorner", Icon).CornerRadius = UDim.new(1,0)

local IconStroke = Instance.new("UIStroke", Icon)
IconStroke.Thickness = 2

------------------------------------------------
-- RGB LOOP
------------------------------------------------
task.spawn(function()
	local h = 0
	while true do
		h = (h + 1) % 360
		local c = Color3.fromHSV(h/360,1,1)
		Title.TextColor3 = c
		Stroke.Color = c
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

------------------------------------------------
-- BUTTON CREATOR
------------------------------------------------
local function CreateButton(text, y, red)
	local b = Instance.new("TextButton", Main)
	b.Size = UDim2.new(0.8,0,0,45)
	b.Position = UDim2.new(0.1,0,0,y)
	b.Text = text
	b.Font = Enum.Font.Gotham
	b.TextSize = 15
	b.TextStrokeTransparency = 1
	b.BackgroundColor3 = Color3.fromRGB(20,20,20)
	b.TextColor3 = Color3.fromRGB(230,230,230)
	b.AutoButtonColor = false
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,12)

	local s = Instance.new("UIStroke", b)
	s.Thickness = 2

	task.spawn(function()
		local h = 0
		while true do
			if red then
				s.Color = Color3.fromRGB(255, math.sin(tick()*3)*80+120, math.sin(tick()*3)*80+120)
			else
				h = (h + 1) % 360
				s.Color = Color3.fromHSV(h/360,1,1)
			end
			task.wait(0.03)
		end
	end)

	return b
end

------------------------------------------------
-- BUTTONS
------------------------------------------------
local Miranda = CreateButton("Miranda Hub", 70, true)
local AutoSteal = CreateButton("Auto Steal (No Cooldown)", 125, false)
local POV = CreateButton("POV", 180, false)

------------------------------------------------
-- ACTIONS
------------------------------------------------
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

------------------------------------------------
-- DRAG MAIN
------------------------------------------------
local dragging, dragStart, startPos
Main.InputBegan:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = i.Position
		startPos = Main.Position
	end
end)

UserInputService.InputChanged:Connect(function(i)
	if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
		local delta = i.Position - dragStart
		Main.Position = UDim2.new(startPos.X.Scale,startPos.X.Offset+delta.X,startPos.Y.Scale,startPos.Y.Offset+delta.Y)
	end
end)

UserInputService.InputEnded:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
		dragging = false
	end
end)

------------------------------------------------
-- DRAG ICON
------------------------------------------------
local idrag, istart, ipos
Icon.InputBegan:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
		idrag = true
		istart = i.Position
		ipos = Icon.Position
	end
end)

UserInputService.InputChanged:Connect(function(i)
	if idrag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
		local d = i.Position - istart
		Icon.Position = UDim2.new(ipos.X.Scale,ipos.X.Offset+d.X,ipos.Y.Scale,ipos.Y.Offset+d.Y)
	end
end)

UserInputService.InputEnded:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
		idrag = false
	end
end)

------------------------------------------------
-- MINIMIZE / RESTORE
------------------------------------------------
Minimize.MouseButton1Click:Connect(function()
	TweenService:Create(Main, TweenInfo.new(0.3), {
		Size = UDim2.new(0,0,0,0),
		BackgroundTransparency = 1
	}):Play()
	task.wait(0.3)
	Main.Visible = false
	Icon.Visible = true
end)

Icon.MouseButton1Click:Connect(function()
	Main.Visible = true
	TweenService:Create(Main, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
		Size = UDim2.new(0,420,0,260),
		BackgroundTransparency = 0
	}):Play()
end)
