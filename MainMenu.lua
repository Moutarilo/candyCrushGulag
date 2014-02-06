Class = require 'middleclass'
require 'Instructions'

MainMenu = Class("MainMenu")

function MainMenu:initialize()
  self.spaceDown = false
  self.spaceDownPrev = false
end

function MainMenu:update(dt)
  self.spaceDown = love.keyboard.isDown(' ')
  if not self.spaceDown and self.spaceDownPrev then
    gameStack:push(Instructions())
  end
  self.spaceDownPrev = self.spaceDown
end

function MainMenu:draw()
  love.graphics.setBackgroundColor(155, 155, 155)
  love.graphics.setColor(20, 20, 20)
  love.graphics.setFont(bigFont)
  love.graphics.print("Candy Crush Gulag", 100, 100)
  love.graphics.setFont(littleFont)
  love.graphics.print("Press Space to begin your labors", 100, 180)
end
