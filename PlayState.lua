Class = require 'middleclass'
vector = require 'vector'
require 'Block'
require 'Timer'
require 'LossState'
require 'WinState'

PlayState = Class("PlayState")

function PlayState:initialize(quota)
  self.grid = {}
  self.gridSize = 54
  self.startX = 20
  self.startY = 20
  for j = 1, 10 do
    local row = {}
    for i = 1, 10 do
      table.insert(row, Block(math.random(1, 6), vector((j - 1) * self.gridSize + self.startX, (i - 1) * self.gridSize + self.startY)))
    end
    table.insert(self.grid, row)
  end
  self.clickedNdx = nil
  self.clicked = false
  self.clickedPrev = false
  self.boxSize = 30
  self.swapping = false
  self.swapTimer = 0
  self.swapTime = 2
  love.graphics.setBackgroundColor(155, 155, 155)
  self.score = 0
  self.quota = quota
  self.timer = Timer(45, vector(600, 100), vector(150, 20))
  love.graphics.setFont(littleFont2)
  self.crackle = love.audio.newSource("crackle.wav", "static")
  self.swapSound = love.audio.newSource("swap.wav", "static")
  self.blockImage = love.graphics.newImage("graphics/block.png")
  self.cursor = love.graphics.newImage("graphics/cursor3.png")
  self.hourglass = love.graphics.newImage("graphics/hourglass3.png")
end

function PlayState:update(dt)
  self.timer:update(dt)
  if self.timer:finished() then
    weeksSurvived = weeksSurvived + 1
    if self.score < self.quota then
      losses = losses + 1
      gameStack:pop()
      gameStack:push(LossState())
    else
      gameStack:pop()
      gameStack:push(WinState())
    end
  end
  self.clicked = love.mouse.isDown('l')
  for j = 1, 10 do
    for i = 1, 10 do
      self.grid[i][j]:update(dt)
    end
  end
  if not self.swapping then
    if not self.clickedPrev and self.clicked then
      self.clickedNdx = {math.floor((love.mouse:getX() - self.startX) / self.gridSize) + 1, math.floor((love.mouse:getY() - self.startY) / self.gridSize) + 1}
      if self.clickedNdx[1] > 10 or self.clickedNdx[1] < 1 or self.clickedNdx[2] > 10 or self.clickedNdx[2] < 1 then
        self.clickedNdx = nil
      end
    end
    if not self.clicked and self.clickedNdx ~= nil then
      local swapNdx = {math.floor((love.mouse:getX() - self.startX) / self.gridSize) + 1, math.floor((love.mouse:getY() - self.startY) / self.gridSize) + 1}
      if not (swapNdx[1] > 10 or swapNdx[1] < 1 or swapNdx[2] > 10 or swapNdx[2] < 1) then
        if (swapNdx[1] == self.clickedNdx[1] + 1 or swapNdx[1] == self.clickedNdx[1] - 1) and swapNdx[2] == self.clickedNdx[2] then
          self:swap(self.clickedNdx[1], self.clickedNdx[2], swapNdx[1], swapNdx[2])
        end
        if (swapNdx[2] == self.clickedNdx[2] + 1 or swapNdx[2] == self.clickedNdx[2] - 1) and swapNdx[1] == self.clickedNdx[1] then
          self:swap(self.clickedNdx[1], self.clickedNdx[2], swapNdx[1], swapNdx[2])
        end
      end
      if swapNdx[1] > 10 or swapNdx[1] < 1 or swapNdx[2] > 10 or swapNdx[2] < 1 then
        swapdNdx = nil
      end
      self.clickedNdx = nil
    end
    if not self.swapping then
      for j = 1, 10 do
        for i = 1, 8 do
          local typeID = self.grid[i][j].typeID
          if self.grid[i + 1][j].typeID == typeID and self.grid[i + 2][j].typeID == typeID then
            self.crackle:play()
            self:removeBlock(i, j)
            self:removeBlock(i + 1, j)
            self:removeBlock(i + 2, j)
          end
        end
      end
      for j = 1, 8 do
        for i = 1, 10 do
          local typeID = self.grid[i][j].typeID
          if self.grid[i][j + 1].typeID == typeID and self.grid[i][j + 2].typeID == typeID then
            self.crackle:play()
            self:removeBlock(i, j)
            self:removeBlock(i, j + 1)
            self:removeBlock(i, j + 2)
          end
        end
      end
    end
  end
  if self.swapping then
    self.swapTimer = self.swapTimer + dt
    if self.swapTimer >= self.swapTime then
      self.swapTimer = 0
      self.swapping = false
    end
  end
  self.clickedPrev = self.clicked
end

function PlayState:removeBlock(x, y)
  self.score = self.score + 1
  self.swapping = true
  for j = 2, y do
    self.grid[x][j - 1]:setPos(vector((x - 1) * self.gridSize + self.startX, (j - 1) * self.gridSize + self.startY))
  end
  for j = 1, y - 1 do
    self.grid[x][y - j + 1] = self.grid[x][y - j]
  end
  self.grid[x][1] = Block(math.random(1, 6), vector((x - 1) * self.gridSize + self.startX, self.startY - self.gridSize))
  self.grid[x][1]:setPos(vector((x - 1) * self.gridSize + self.startX, self.startY))
end

function PlayState:swap(x1, y1, x2, y2)
  self.swapSound:play()
  self.swapping = true
  if y1 > 0 and y2 > 0 then
    self.grid[x1][y1]:setPos(vector((x2 - 1) * self.gridSize + self.startX, (y2 - 1) * self.gridSize + self.startY))
    self.grid[x2][y2]:setPos(vector((x1 - 1) * self.gridSize + self.startX, (y1 - 1) * self.gridSize + self.startY))
    local temp = self.grid[x1][y1]
    self.grid[x1][y1] = self.grid[x2][y2]
    self.grid[x2][y2] = temp
  end
end

function PlayState:draw()
  self.timer:draw()
  for j = 1, 10 do
    for i = 1, 10 do
      love.graphics.setColor(255, 255, 255)
      --love.graphics.rectangle("line", (i - 1) * self.gridSize + self.startX, (j - 1) * self.gridSize + self.startY, self.gridSize, self.gridSize)
      love.graphics.draw(self.blockImage, (i - 1) * self.gridSize + self.startX, (j - 1) * self.gridSize + self.startY, 0, self.gridSize / 100, self.gridSize / 100)
      --self.grid[i][j]:draw()
    end
  end
  for j = 1, 10 do
    for i = 1, 10 do
      self.grid[i][j]:draw()
    end
  end
  love.graphics.setColor(20, 20, 20)
  love.graphics.print("Crushed: " .. self.score, 650, 20)
  love.graphics.print("Quota: " .. self.quota, 650, 50)
  love.graphics.setColor(255, 255, 255)
  if self.swapping then
    love.graphics.draw(self.hourglass, love.mouse.getX() - 50 * 0.35, love.mouse.getY() - 50 * 0.35, 0, 0.7, 0.7)
  else
    love.graphics.draw(self.cursor, love.mouse.getX() - 50 * 0.35, love.mouse.getY() - 50 * 0.35, 0, 0.7, 0.7)
  end
end
