local anim8 = require 'libraries/anim8'

Player = {}
Player.__index = Player

function Player:new()
    local instance = setmetatable({}, Player)

    instance.isMoving = false

    instance.x = love.graphics.getWidth() / 4
    instance.y = love.graphics.getHeight() / 4

    instance.speed = 3

    instance.spritesheet = love.graphics.newImage('assets/player-spritesheet.png')
    instance.spritesheet:setFilter("nearest")

    instance.direction = "down"

    instance.grid = anim8.newGrid(
        16, 16, instance.spritesheet:getWidth(), instance.spritesheet:getHeight()
    )

    instance.animation = {
        stoppedDown = anim8.newAnimation(instance.grid('1-1', 1), 0.25),
        stoppedUp = anim8.newAnimation(instance.grid('1-1', 3), 0.25),
        stoppedLeft = anim8.newAnimation(instance.grid('1-1', 4), 0.25),
        stoppedRight = anim8.newAnimation(instance.grid('1-1', 2), 0.25),

        down = anim8.newAnimation(instance.grid('1-4', 1), 0.25),
        up = anim8.newAnimation(instance.grid('1-4', 3), 0.25),
        left = anim8.newAnimation(instance.grid('1-4', 4), 0.25),
        right = anim8.newAnimation(instance.grid('1-4', 2), 0.25)
    }

    instance.standart = instance.animation.down

    instance.bullets = {}

    return instance
end

function Player:update(dt)
    for index, bullet in ipairs(self.bullets) do
        bullet:update(dt)

        if bullet.alive == false then
            table.remove(self.bullets, index)
        end
    end

    if love.keyboard.isDown("w") then
        self.isMoving = true
        self.direction = "up"
        self.y = self.y - self.speed
        self.standart = self.animation.up
    end
    
    if love.keyboard.isDown("s") then
        self.isMoving = true
        self.direction = "down"
        self.y = self.y + self.speed
        self.standart = self.animation.down
    end
    
    if love.keyboard.isDown("d") then
        self.isMoving = true
        self.direction = "right"
        self.x = self.x + self.speed
        self.standart = self.animation.right
    end
    
    if love.keyboard.isDown("a") then
        self.isMoving = true
        self.direction = "left"
        self.x = self.x - self.speed
        self.standart = self.animation.left
    end

    if self.isMoving == false then
        if self.standart == self.animation.up then
            self.standart = self.animation.stoppedUp
            
        elseif self.standart == self.animation.down then
            self.standart = self.animation.stoppedDown
            
        elseif self.standart == self.animation.right then
            self.standart = self.animation.stoppedRight
            
        elseif self.standart == self.animation.left then
            self.standart = self.animation.stoppedLeft
        end
    end
    
    self.isMoving = false
    self.standart:update(dt)
end

return Player