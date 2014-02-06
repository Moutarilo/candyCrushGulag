require 'Stack'
require 'PlayState'
require 'MainMenu'

function love:load()
  bigFont = love.graphics.newFont("fonts/kremlin.ttf", 50)
  littleFont = love.graphics.newFont("fonts/Gravity-Bold.ttf", 20)
  littleFont2 = love.graphics.newFont("fonts/Gravity-Book.ttf", 23)
  gameStack = Stack()
  mainMenu = MainMenu()
  weeksSurvived = 0
  losses = 0
  love.mouse.setVisible(false)
  volga = love.audio.newSource("volga.mp3")
  volga:setLooping(true)
  volga:play()
  gameStack:push(mainMenu)
end

function love.draw()
  gameStack:peek():draw()
end

function love.update(dt)
  gameStack:peek():update(dt)
end
