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

