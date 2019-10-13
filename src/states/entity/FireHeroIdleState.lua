--[[
    GD50
    Super Mario Bros. Remake

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

FireHeroIdleState = Class{__includes = BaseState}

function FireHeroIdleState:init(fireHero)
    self.fireHero = fireHero

    self.animation = Animation {
        frames = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18},
        interval = .2
    }

    self.fireHero.currentAnimation = self.animation

    gSounds['fire']:setLooping(true)
    gSounds['fire']:play()

end

function FireHeroIdleState:update(dt)
  
    self.fireHero.currentAnimation:update(dt)

end