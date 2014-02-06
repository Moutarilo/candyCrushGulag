Class = require 'middleclass'
vector = require 'vector'

Timer = Class("Timer")

function Timer:initialize(totalTime, pos, dims)
  self.totalTime = totalTime
  self.currentTime = 0
  self.pos = pos
  self.dims = dims
end

function Timer:update(dt)
  self.currentTime = self.currentTime + dt
end

function Timer:finished()
  return self.currentTime > self.totalTime
end

function Timer:draw()
  love.graphics.setColor(20, 20, 20)
  love.graphics.rectangle("fill", self.pos.x, self.pos.y, (1 - self.currentTime / self.totalTime) * self.dims.x, self.dims.y)
  love.graphics.rectangle("line", self.pos.x, self.pos.y, self.dims.x, self.dims.y)
end
