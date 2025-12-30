-- 🔒 ANTI EXECUTAR 2x
if getgenv().GUNA_HELPER_LOADED then
	warn("GUNA HELPER já foi executado!")
	return
end
getgenv().GUNA_HELPER_LOADED = true

-- SERVICES
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")

local player = Players.LocalPlayer

-- GUI
local ScreenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
ScreenGui.Name = "GunaHelper"
ScreenGui.ResetOnSpawn = false

---------------------------------------------------
-- 🌫️ INTRO BLUR
---------------------------------------------------
local Blur = Instance.new("BlurEffect", Lighting)
Blur.Size = 0

local Intro = Instance.new("Frame", ScreenGui)
Intro.Size = UDim2.new(1,0,1,0)
Intro.BackgroundTransparency = 1

local IntroText = Instance.new("TextLabel", Intro)
IntroText.Size = UDim2.new(1,0,1,0)
IntroText.BackgroundTransparency = 1
IntroText.Text = "script by:\ngunaprooficial99"
IntroText.Font = Enum.Font.GothamBold
IntroText.TextSize = 42
IntroText.TextTransparency = 1
IntroText.TextStrokeTransparency = 0.6

task.spawn(function()
	local h = 0
	while Intro.Parent do
		h = (h + 1) % 360
		IntroText.TextColor3 = Color3.fromHSV(h/360,1,1)
		task.wait(0.03)
	end
end)

TweenService:Create(Blur, TweenInfo.new(0.6), {Size = 24}):Play()
TweenService:Create(IntroText, TweenInfo.new(0.6), {TextTransparency = 0}):Play()
task.wait(2)
TweenService:Create(IntroText, TweenInfo.new(0.6), {TextTransparency = 1}):Play()
TweenService:Create(Blur, TweenInfo.new(0.6), {Size = 0}):Play()
task.wait(0.7)
Intro:Destroy()
Blur:Destroy()

---------------------------------------------------
-- 🟣 MAIN GUI
---------------------------------------------------
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0,420,0,260)
Main.Position = UDim2.new(0.5,-210,0.5,-130)
Main.BackgroundColor3 = Color3.fromRGB(10,10,10)
Main.BackgroundTransparency = 1
Instance.new("UICorner", Main).CornerRadius = UDim.new(0,16)

TweenService:Create(Main, TweenInfo.new(0.6, Enum.EasingStyle.Back), {
	BackgroundTransparency = 0
}):Play()

local Stroke = Instance.new("UIStroke", Main)
Stroke.Thickness = 3

task.spawn(function()
	local h = 0
	while Main.Parent do
		h = (h + 1) % 360
		Stroke.Color = Color3.fromHSV(h/360,1,1)
		task.wait(0.03)
	end
end)

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1,0,0,50)
Title.BackgroundTransparency = 1
Title.Text = "GUNA HELPER"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 30

task.spawn(function()
	local h = 0
	while Title.Parent do
		h = (h + 1) % 360
		Title.TextColor3 = Color3.fromHSV(h/360,1,1)
		task.wait(0.03)
	end
end)

---------------------------------------------------
-- 🔘 BOTÕES
---------------------------------------------------
local function CreateButton(text, y, red)
	local b = Instance.new("TextButton", Main)
	b.Size = UDim2.new(0.8,0,0,45)
	b.Position = UDim2.new(0.1,0,0,y)
	b.Text = text
	b.Font = Enum.Font.Gotham
	b.TextSize = 18
	b.BackgroundColor3 = Color3.fromRGB(20,20,20)
	b.TextColor3 = Color3.new(1,1,1)
	b.AutoButtonColor = false
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,12)

	local s = Instance.new("UIStroke", b)
	s.Thickness = 2

	task.spawn(function()
		local h = 0
		while b.Parent do
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

local Miranda = CreateButton("Miranda Hub", 70, true)
local AutoSteal = CreateButton("Auto Steal (No Cooldown)", 125, false)
local POV = CreateButton("POV", 180, false)

Miranda.MouseButton1Click:Connect(function()
	loadstring(game:HttpGet("https://pastefy.app/JJVhs3rK/raw"))()
end)

AutoSteal.MouseButton1Click:Connect(function()
	loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Instantly-interact-prompts-30752"))()
end)

POV.MouseButton1Click:Connect(function()
	RunService.RenderStepped:Connect(function()
		workspace.CurrentCamera.FieldOfView = 120
	end)
end)

---------------------------------------------------
-- 🔵 ÍCONE REDONDO COM IMAGEM
---------------------------------------------------
local Icon = Instance.new("ImageButton", ScreenGui)
Icon.Size = UDim2.new(0,70,0,70)
Icon.Position = UDim2.new(0,20,0.5,-35)
Icon.Image = "rbxassetid://85064207194102"
Icon.BackgroundColor3 = Color3.fromRGB(15,15,15)
Icon.Visible = false
Icon.AutoButtonColor = false
Instance.new("UICorner", Icon).CornerRadius = UDim.new(1,0)

local IconStroke = Instance.new("UIStroke", Icon)
IconStroke.Thickness = 2

task.spawn(function()
	local h = 0
	while Icon.Parent do
		h = (h + 1) % 360
		IconStroke.Color = Color3.fromHSV(h/360,1,1)
		task.wait(0.03)
	end
end)

---------------------------------------------------
-- 📦 MINIMIZAR / RESTAURAR
---------------------------------------------------
Main.InputBegan:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
		Main.Visible = false
		Icon.Visible = true
	end
end)

Icon.MouseButton1Click:Connect(function()
	Main.Visible = true
	Icon.Visible = false
end)
