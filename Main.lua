-- LocalScript
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Создаём GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 300, 0, 150)
Frame.Position = UDim2.new(0.5, -150, 0.5, -75)
Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Frame.BorderSizePixel = 0
Frame.AnchorPoint = Vector2.new(0.5,0.5)
Frame.ClipsDescendants = true
Frame.Parent = ScreenGui
Frame.BackgroundTransparency = 0.05
Frame.UICorner = Instance.new("UICorner", Frame)
Frame.UICorner.CornerRadius = UDim.new(0, 15)

-- Title
local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, -20, 0, 30)
Title.Position = UDim2.new(0, 10, 0, 10)
Title.BackgroundTransparency = 1
Title.Text = "Fling GUI"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20

-- TextBox
local TextBox = Instance.new("TextBox", Frame)
TextBox.Size = UDim2.new(1, -20, 0, 30)
TextBox.Position = UDim2.new(0, 10, 0, 50)
TextBox.PlaceholderText = "Player Name"
TextBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
TextBox.TextColor3 = Color3.fromRGB(255,255,255)
TextBox.TextSize = 18
TextBox.ClearTextOnFocus = false
Instance.new("UICorner", TextBox).CornerRadius = UDim.new(0,10)

-- Attack Button
local AttackButton = Instance.new("TextButton", Frame)
AttackButton.Size = UDim2.new(1, -20, 0, 30)
AttackButton.Position = UDim2.new(0, 10, 0, 90)
AttackButton.Text = "Attack Player"
AttackButton.BackgroundColor3 = Color3.fromRGB(80, 0, 80)
AttackButton.TextColor3 = Color3.fromRGB(255,255,255)
AttackButton.Font = Enum.Font.GothamBold
AttackButton.TextSize = 18
Instance.new("UICorner", AttackButton).CornerRadius = UDim.new(0,10)

-- Kill All Button
local KillAllButton = Instance.new("TextButton", Frame)
KillAllButton.Size = UDim2.new(1, -20, 0, 30)
KillAllButton.Position = UDim2.new(0, 10, 0, 130)
KillAllButton.Text = "Kill All"
KillAllButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
KillAllButton.TextColor3 = Color3.fromRGB(255,255,255)
KillAllButton.Font = Enum.Font.GothamBold
KillAllButton.TextSize = 18
Instance.new("UICorner", KillAllButton).CornerRadius = UDim.new(0,10)

-- Функция флинга
local function fling(targetChar)
	local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	local targetRoot = targetChar and targetChar:FindFirstChild("HumanoidRootPart")
	if not (root and targetRoot) then return end

	local oldCFrame = root.CFrame
	root.CFrame = targetRoot.CFrame

	local flingForce = Instance.new("BodyAngularVelocity")
	flingForce.AngularVelocity = Vector3.new(9999,9999,9999)
	flingForce.MaxTorque = Vector3.new(1e9,1e9,1e9)
	flingForce.Parent = root

	local hum = targetChar:FindFirstChildOfClass("Humanoid")
	if hum then
		hum.Died:Wait()
	end

	flingForce:Destroy()
	root.CFrame = oldCFrame
end

-- Attack single player
AttackButton.MouseButton1Click:Connect(function()
	local targetName = TextBox.Text
	if targetName == "" then return end
	local targetPlayer = Players:FindFirstChild(targetName)
	if targetPlayer and targetPlayer.Character then
		fling(targetPlayer.Character)
	end
end)

-- Kill All
KillAllButton.MouseButton1Click:Connect(function()
	for _, player in pairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and player.Character then
			fling(player.Character)
		end
	end
end)
