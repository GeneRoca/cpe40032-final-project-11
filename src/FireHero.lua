--[[
    GD50
    Super Mario Bros. Remake

    -- FireHero Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

FireHero = Class{__includes = Entity}

function FireHero:init(def)
    Entity.init(self, def)

end

function FireHero:update(dt)
    Entity.update(self, dt)
end

function FireHero:render()
    Entity.render(self)
end

