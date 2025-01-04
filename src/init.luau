--!strict
--[[
    Flightpath
    by imacodr
    
    Use Jetstream videos 
    --]]
    
local RunService = game:GetService("RunService")
type Impl = {
	__index: Impl,
	new: (img: ImageLabel) -> Flightpath,
}

type Proto = {
	Fps: number,
    Instance: ImageLabel,
    Looped: boolean,
    Video: {string},
    CurrentFrame: number,
    Playing: boolean,
    TimePosition: number,
    TimeLength: number,
    loopConnection: RBXScriptConnection?,
}

local Flightpath: Impl = {} :: Impl
Flightpath.__index = Flightpath

function checkVideo(self)
    if #self.Video == 0 then
        error("Flightpath Error: No Video Loaded")
    end
end

function Flightpath.new(img: ImageLabel)
    local self = setmetatable({} :: Proto, Flightpath)
    self.Instance = img
    self.Fps = 30
    self.Looped = false
    self.Video = {}
    self.CurrentFrame = 0
    self.Playing = false
    self.TimePosition = 0
    self.TimeLength = 0
    self.loopConnection = nil

    return self
end

function Flightpath:UpdateTimeLength()
    self.TimeLength = #self.Video / self.Fps
end

function Flightpath:StartLoop()
    if self.loopConnection then
        self.loopConnection:Disconnect()
    end

    self.loopConnection = RunService.Heartbeat:Connect(function(deltaTime)
        if self.Playing then
            self:UpdateFrame(deltaTime)
        end
    end)
end

function Flightpath:UpdateFrame(deltaTime: number)
    if #self.Video == 0 then return end

    self.TimePosition += deltaTime
    local totalFrames = #self.Video
    local newFrame = math.floor(self.TimePosition * self.Fps) + 1

    if newFrame > totalFrames then
        if self.Looped then
            self.TimePosition = 0
            self.CurrentFrame = 1
        else
            self.TimePosition = self.TimeLength
            self.CurrentFrame = totalFrames
            self.Playing = false
            return
        end
    else
        self.CurrentFrame = newFrame
    end

    self.Instance.Image = self.Video[self.CurrentFrame]
end

function Flightpath:Play()
    checkVideo(self)
    self:UpdateTimeLength()
    self.TimePosition = 0
    self.CurrentFrame = 1
    self.Playing = true
    self:StartLoop()
end

function Flightpath:Pause()
    checkVideo(self)
    self.Playing = false
end

function Flightpath:Resume()
    checkVideo(self)
    self.Playing = true
end

function Flightpath:Stop()
    checkVideo(self)
    self.Playing = false
    self.CurrentFrame = 0
    self.TimePosition = 0
end

function Flightpath:SetTime(timePosition: number)
    if timePosition < 0 or timePosition > self.TimeLength then
        error("TimePosition out of range")
    end

    self.TimePosition = timePosition
    self.CurrentFrame = math.floor(timePosition * self.Fps) + 1
    self.Instance.Image = self.Video[self.CurrentFrame]
end

return Flightpath
