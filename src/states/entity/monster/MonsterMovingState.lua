--[[
    GD50
    Super Mario Bros. Remake

    -- MonsterMovingState Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

MonsterMovingState = Class{__includes = BaseState}

function MonsterMovingState:init(fireHero, monster)
    self.fireHero = fireHero
    self.monster = monster
    self.animation = Animation {
        frames = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18},
        interval = 0.15
    }
    self.monster.currentAnimation = self.animation

    gSounds['monster_hurt']:play()

end

function MonsterMovingState:update(dt)
    self.monster.currentAnimation:update(dt)

end