Attacks = Class{__includes = Entity}

function Attacks:init(def)

    Entity.init(self, def)

end

function Attacks:update(dt)

    Entity.update(self, dt)

end

function Attacks:render()

    love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.currentAnimation:getCurrentFrame()],
        self.x, self.y)
        
end