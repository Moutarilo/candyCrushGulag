Class = require 'middleclass'

WinState = Class("WinState")

function WinState:initialize()
  self.newQuota = weeksSurvived * 10 + 25
  self.spaceDown = false
  self.spaceDownPrev = false
end

function WinState:update(dt)
  self.spaceDown = love.keyboard.isDown(' ')
  if not self.spaceDown and self.spaceDownPrev then
    gameStack:pop()
    gameStack:push(PlayState(self.newQuota))
  end
  self.spaceDownPrev = self.spaceDown
end

function WinState:draw()
  love.graphics.setColor(20, 20, 20)
  love.graphics.print("You have met this week's quota.", 50, 50)
  love.graphics.print("Next week's quota is " .. self.newQuota .. ".", 50, 80)
  love.graphics.print("Press space to continue.", 50, 110)
end
