Class = require 'middleclass'

Block = Class("Block")

function Block:initialize(typeID, pos)
  self.typeID = typeID
  if typeID == 1 then self.image = love.graphics.newImage("graphics/horror.png") end
  if typeID == 2 then self.image = love.graphics.newImage("graphics/corn.png") end
  if typeID == 3 then self.image = love.graphics.newImage("graphics/bear.png") end
  if typeID == 4 then self.image = love.graphics.newImage("graphics/lifesaver.png") end
  if typeID == 5 then self.image = love.graphics.newImage("graphics/pinwheel.png") end
  if typeID == 6 then self.image = love.graphics.newImage("graphics/heart.png") end
  self.pos = pos
  self.targetPos = pos
  self.speed = 30
  self.imageSize = self.image:getWidth()
end

function Block:setPos(pos)
  self.targetPos = pos
end

function Block:update(dt)
  if self.pos.x < self.targetPos.x then
    self.pos.x = self.pos.x + self.speed * dt
  end
  if self.pos.x > self.targetPos.x then
    self.pos.x = self.pos.x - self.speed * dt
  end
  if self.pos.y < self.targetPos.y then
    self.pos.y = self.pos.y + self.speed * dt
  end
  if self.pos.y > self.targetPos.y then
    self.pos.y = self.pos.y - self.speed * dt
  end
end

function Block:draw()
  love.graphics.setColor(255, 255, 255)
  love.graphics.draw(self.image, self.pos.x + 2, self.pos.y + 2, 0, 50 / self.imageSize, 50 / self.imageSize)
end
