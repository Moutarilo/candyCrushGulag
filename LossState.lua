Class = require 'middleclass'
require 'FriendPicker'

LossState = Class("LossState")

function LossState:initialize()
  self.selection = 0
  self.left = false
  self.leftPrev = false
  self.right = false
  self.rightPrev = false
  self.space = false
  self.spacePrev = false
end

function LossState:update(dt)
  self.left = love.keyboard.isDown('left')
  self.right = love.keyboard.isDown('right')
  self.space = love.keyboard.isDown(' ')
  if not self.right and self.rightPrev then
    self.selection = (self.selection + 1) % 2
  end
  if not self.left and self.leftPrev then
    self.selection = (self.selection - 1) % 2
  end
  if not self.space and self.spacePrev then
    if losses == 1 then
      losses = losses + 1
      if self.selection == 0 then
        gameStack:pop()
        gameStack:push(FriendPicker())
      end
    else
      losses = 0
      weeksSurvived = 0
      gameStack:pop()
    end
  end
  self.leftPrev = self.left
  self.rightPrev = self.right
  self.spacePrev = self.space
end

function LossState:draw()
  love.graphics.setColor(20, 20, 20)
  if losses == 1 then
    love.graphics.print("You failed to meet today's quota, comrade.", 50, 50)
    love.graphics.print("The glorious soviet republic is still willing to provide you with rations.", 50, 80)
    love.graphics.print("In return, you must alert us to the treasonous activities", 50, 110)
    love.graphics.print("of at least three of your friends.", 50, 140)
    love.graphics.print("Otherwise, you will surely starve.", 50, 170)
    love.graphics.print("Turn in friends", 100, 250)
    love.graphics.print("Refuse", 400, 250)
    local drawX = nil
    if self.selection == 0 then
      drawX = 95
    else
      drawX = 395
    end
    love.graphics.rectangle("fill", drawX, 280, 150, 5)
  else
    love.graphics.print("You failed to meet the quota and died of starvation.", 50, 50)
    love.graphics.print("You survived " .. weeksSurvived .. " weeks in the gulag.", 50, 80)
    love.graphics.print("Space to return to title screen", 50, 110)
  end
end
