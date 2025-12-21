PlayerClass = require("classes.player")
BulletClass = require("classes.bullet")

Anim8 = require('libraries/anim8')

function love.load()
    Player = PlayerClass:new()

    love.window.setTitle('putaria 3000')
    love.window.setMode(512, 480)
end

function love.keypressed(key, scancode, isrepeat)
    if key == "space" then
        local bullet = BulletClass:new(Player.x, Player.y, Player.direction)
        table.insert(Player.bullets, bullet)
    end
end

function love.update(dt)
    Player:update(dt)
    print(#Player.bullets)
end

function love.draw() 
    love.graphics.setBackgroundColor(1, 1, 1)
    Player.standart:draw(Player.spritesheet, Player.x, Player.y, nil, 7)

    for _, bullet in ipairs(Player.bullets) do
        love.graphics.draw(bullet.spritesheet, bullet.x, bullet.y, nil, 7)
    end
end
