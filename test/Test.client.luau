local Flightpath = require(game.ReplicatedStorage.Flightpath)
local player = game.Players.LocalPlayer

local testgui = Instance.new("ScreenGui")
testgui.Parent = player.PlayerGui

local imageLabel = Instance.new("ImageLabel")
imageLabel.Parent = testgui
imageLabel.AnchorPoint = Vector2.new(0.5,0.5)
imageLabel.Position = UDim2.fromScale(0.5,0.5)
imageLabel.Size = UDim2.fromScale(0.5,0.5)

task.wait(5)


local v = Flightpath.new(imageLabel)
v.Video = require(script.Parent.Robot)
v.Fps = 20
v.Looped = true

v:Play()

task.wait(5)

v:Pause()
task.wait(5)

v:Resume()

task.wait(5)

v:Stop()