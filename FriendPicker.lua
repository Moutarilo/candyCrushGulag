Class = require 'middleclass'

FriendPicker = Class("FriendPicker")

function FriendPicker:initialize()
  self.space = false
  self.spacePrev = false
  self.portrait1 = love.graphics.newImage("graphics/portrait2.png")
  self.portrait2 = love.graphics.newImage("graphics/portrait3.png")
  self.portrait3 = love.graphics.newImage("graphics/portrait4.png")
  self.portraitSize = self.portrait1:getWidth()
end

function FriendPicker:draw()
  love.graphics.draw(self.portrait1, 50, 30, 0, 150 / self.portraitSize, 150 / self.portraitSize)
  love.graphics.draw(self.portrait2, 50, 180, 0, 150 / self.portraitSize, 150 / self.portraitSize)
  love.graphics.draw(self.portrait3, 50, 310, 0, 150 / self.portraitSize, 150 / self.portraitSize)
  --love.graphics.print("Katya", 200, 50)
  --love.graphics.print("Fyodor", 200, 200)
  --love.graphics.print("Alexei", 200, 330)
  love.graphics.print("Attention Laborers:", 330, 50)
  love.graphics.print("Three new inmates have joined our ranks.", 330, 80)
  love.graphics.print("Press space to carry on.", 330, 110)
end

function FriendPicker:update(dt)
  self.space = love.keyboard.isDown(' ')
  if not self.space and self.spacePrev then
    gameStack:pop()
    gameStack:push(PlayState(weeksSurvived * 10 + 25))
  end
  self.spacePrev = self.space
end
