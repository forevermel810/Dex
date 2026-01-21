getgenv().AutoTrigger = true

local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")
local VIM = game:GetService("VirtualInputManager")

local player = Players.LocalPlayer
local gui = player.PlayerGui.Button["Boss Spawn"]

gui.Archivable = true
gui.Visible = true
gui.Position = UDim2.new(0.02, 0, 0.02, 0)
gui.Size = UDim2.new(0.40, 0, 0.40, 0)

if not (gui.Visible and gui.Archivable) then
    return
end

local targetFrame = gui.Spawn.Frame
local lastVisible = false
local running = true

local stopButton = Instance.new("TextButton")
stopButton.Size = UDim2.new(0, 80, 0, 30)
stopButton.Position = UDim2.new(0.02, 0, 0.45, 0)
stopButton.Text = "STOP"
stopButton.TextColor3 = Color3.new(1, 1, 1)
stopButton.BackgroundColor3 = Color3.new(0.8, 0.2, 0.2)
stopButton.Font = Enum.Font.GothamBold
stopButton.TextSize = 14
stopButton.Parent = player.PlayerGui:WaitForChild("ScreenGui") or Instance.new("ScreenGui", player.PlayerGui)

stopButton.MouseButton1Click:Connect(function()
    running = false
    getgenv().AutoTrigger = false
    GuiService.SelectedObject = nil
    stopButton:Destroy()
end)

spawn(function()
    while task.wait(0.02) and running do
        local visible = targetFrame.Parent.Visible
        if getgenv().AutoTrigger and visible then
            if not lastVisible then
                GuiService.SelectedObject = targetFrame
                lastVisible = true
            end
            VIM:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
            VIM:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
        else
            if lastVisible then
                GuiService.SelectedObject = nil
                lastVisible = false
            end
        end
    end
end)