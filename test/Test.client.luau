local Flightpath = require(game.ReplicatedStorage.Flightpath)

local player = game.Players.LocalPlayer

task.wait(5)

local v = Flightpath.new(player.PlayerGui.testgui.ImageLabel)
v.Video = require(script.Parent.Plane)
v.Fps = 20
v.Looped = true

v:Play()

task.wait(5)

v:Pause()
task.wait(5)

v:Resume()

task.wait(5)

v:Stop()