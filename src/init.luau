--!strict
--[[
    Flightpath
    by imacodr

    Use Jetstream videos 
--]]

type Impl = {
	__index: Impl,
	new: (img: ImageLabel) -> Flightpath,
	deposit: (self: Flightpath, credit: number) -> (),
	withdraw: (self: Flightpath, debit: number) -> (),
}

type Proto = {
	Fps: number,
    Intance: Instance,
    Looped: boolean,
    Video: table,
    CurentFrame: number,
    Playing: boolean
}

local Flightpath: Impl = {} :: Impl
Flightpath.__index = Flightpath

function conductLoop(self)
    while self.Playing do
        for i,v in ipairs(self.Video) do
            self.CurrentFrame = i
            self.Instance.Image = v
            task.wait(1 / self.Fps)

            if (i == #self.Video) and not self.Looped then
                self.Playing = false
            end
        end
    end
end

function Flightpath.new(img: ImageLabel)
    local self = setmetatable({} :: Proto, Flightpath)
    self.Instance = img
    self.Fps = 1
    self.Looped = false
    self.Video = {}
    self.CurrentFrame = 0
    self.Playing = false
    return self
end

function Flightpath:Play()
    self.CurrentFrame = 0
    self.Playing = true
    conductLoop(self)
end

function Flightpath:Pause()
    self.Playing = false
end

function Flightpath:Resume()
    self.Playing = true
end

return Flightpath