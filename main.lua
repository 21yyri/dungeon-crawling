function love.load()
    love.window.setTitle('Dungeon Crawling')
    anim8 = require 'libraries/anim8'

    Player = {
        isMoving = false,
        x = love.graphics.getWidth() / 4,
        y = love.graphics.getHeight() / 4,
        speed = 3,
        spritesheet = love.graphics.newImage('assets/player-spritesheet.png'),
    }
    
    Player.grid = anim8.newGrid(
        16, 16, Player.spritesheet:getWidth(), Player.spritesheet:getHeight()
    )
    
    Player.animation = {
        stoppedDown = anim8.newAnimation(Player.grid('1-1', 1), 0.25),
        stoppedUp = anim8.newAnimation(Player.grid('1-1', 3), 0.25),
        stoppedLeft = anim8.newAnimation(Player.grid('1-1', 4), 0.25),
        stoppedRight = anim8.newAnimation(Player.grid('1-1', 2), 0.25),
        
        down = anim8.newAnimation(Player.grid('1-4', 1), 0.25),
        up = anim8.newAnimation(Player.grid('1-4', 3), 0.25),
        left = anim8.newAnimation(Player.grid('1-4', 4), 0.25),
        right = anim8.newAnimation(Player.grid('1-4', 2), 0.25)
    }
    
    Player.standart = Player.animation.down
    
    Player.spritesheet:setFilter("nearest")
    
    love.window.setMode(512, 480)
end

function love.update(dt)
    if love.keyboard.isDown("w") then
        Player.isMoving = true
        Player.y = Player.y - Player.speed
        Player.standart = Player.animation.up
    end
    
    if love.keyboard.isDown("s") then
        Player.isMoving = true
        Player.y = Player.y + Player.speed
        Player.standart = Player.animation.down
    end
    
    if love.keyboard.isDown("d") then
        Player.isMoving = true
        Player.x = Player.x + Player.speed
        Player.standart = Player.animation.right
    end
    
    if love.keyboard.isDown("a") then
        Player.isMoving = true
        Player.x = Player.x - Player.speed
        Player.standart = Player.animation.left
    end
    
    if Player.isMoving == false then
        if Player.standart == Player.animation.up then
            Player.standart = Player.animation.stoppedUp
            
        elseif Player.standart == Player.animation.down then
            Player.standart = Player.animation.stoppedDown
            
        elseif Player.standart == Player.animation.right then
            Player.standart = Player.animation.stoppedRight
            
        elseif Player.standart == Player.animation.left then
            Player.standart = Player.animation.stoppedLeft
        end
    end
    
    Player.isMoving = false
    Player.standart:update(dt)
end

function love.draw() 
    love.graphics.setBackgroundColor(1, 1, 1)
    Player.standart:draw(Player.spritesheet, Player.x, Player.y, nil, 7)
end
