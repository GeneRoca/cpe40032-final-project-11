--[[
    GD50
    Super Mario Bros. Remake

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

SnailChasingState = Class{__includes = BaseState}

function SnailChasingState:init(tilemap, player, snail)
    self.tilemap = tilemap
    self.player = player
    self.snail = snail
    self.animation = Animation {
        frames = {79, 80, 81, 82, 83, 84},
        interval = 0.07
    }
    self.snail.currentAnimation = self.animation
end

function SnailChasingState:update(dt)
    self.snail.currentAnimation:update(dt)

    -- calculate difference between snail and player on X axis
    -- and only chase if <= 5 tiles
    local diffX = math.abs(self.player.x - self.snail.x)

    if diffX > 5 * TILE_SIZE then
        self.snail:changeState('moving')
    elseif self.player.x < self.snail.x then
        self.snail.direction = 'left'
        self.snail.x = self.snail.x - SNAIL_MOVE_SPEED * dt * 2.4

        gSounds['quack']:play()
        gSounds['quack']:setVolume(0.3)

        -- stop the snail if there's a missing tile on the floor to the left or a solid tile directly left
        local tileLeft = self.tilemap:pointToTile(self.snail.x, self.snail.y)
        local tileBottomLeft = self.tilemap:pointToTile(self.snail.x, self.snail.y + self.snail.height)

        if (tileLeft and tileBottomLeft) and (tileLeft:collidable() or not tileBottomLeft:collidable()) then
            self.snail.x = self.snail.x + SNAIL_MOVE_SPEED * dt * 2.4
            gSounds['quack']:play()
            gSounds['quack']:setVolume(0.3)
        end
    else
        self.snail.direction = 'right'
        self.snail.x = self.snail.x + SNAIL_MOVE_SPEED * dt * 2.4

        gSounds['quack']:play()
        gSounds['quack']:setVolume(0.3)

        -- stop the snail if there's a missing tile on the floor to the right or a solid tile directly right
        local tileRight = self.tilemap:pointToTile(self.snail.x + self.snail.width, self.snail.y)
        local tileBottomRight = self.tilemap:pointToTile(self.snail.x + self.snail.width, self.snail.y + self.snail.height)

        if (tileRight and tileBottomRight) and (tileRight:collidable() or not tileBottomRight:collidable()) then
            self.snail.x = self.snail.x - SNAIL_MOVE_SPEED * dt * 2.4
            gSounds['quack']:play()
            gSounds['quack']:setVolume(0.3)
        end
    end
end