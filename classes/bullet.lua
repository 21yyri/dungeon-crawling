local screenWidth, screenHeight = love.graphics.getDimensions()

local Bullet = {}
Bullet.__index = Bullet

function Bullet:new(x, y, direction)
    local instance = setmetatable({}, Bullet)

    instance.x = x
    instance.y = y

    instance.speed = 300

    instance.direction = direction

    instance.spritesheet = love.graphics.newImage("assets/bullet-sprite.png")
    instance.spritesheet:setFilter("nearest")

    instance.alive = true

    return instance
end

function Bullet:update(dt)
    if self.direction == "left" then
        self.x = self.x - self.speed * dt
    end

    if self.direction == "right" then
        self.x = self.x + self.speed * dt
    end

    if self.direction == "up" then
        self.y = self.y - self.speed * dt
    end

    if self.direction == "down" then
        self.y = self.y + self.speed * dt
    end

    local outOfX = self.x >= screenWidth or self.x <= 0 
    local outOfY = self.y >= screenHeight or self.y <= 0

    if outOfX or outOfY then
        self.alive = false
    end
end

return Bullet