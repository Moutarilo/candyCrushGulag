Class = require 'middleclass'
require 'PlayState'

Instructions = Class("Instructions")

function Instructions:initialize()
  self.spaceDown = false
  self.spaceDownPrev = false
  love.graphics.setFont(littleFont2)
end

function Instructions:update(dt)
  self.spaceDown = love.keyboard.isDown(' ')
  if not self.spaceDown and self.spaceDownPrev then
    gameStack:pop()
    gameStack:push(PlayState(25))
  end
  self.spaceDownPrev = self.spaceDown
end

function Instructions:draw()
  love.graphics.print("Welcome to the gulag, traitorous comrade.", 50, 50)
  love.graphics.print("You must crush the required number of candies to recieve your rations.", 50, 80)
  love.graphics.print("This week's quota is 25 candies.", 50, 110)
  love.graphics.print("Press space to continue.", 50, 140)
end
