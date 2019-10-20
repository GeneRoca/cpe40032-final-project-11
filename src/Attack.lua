Attack = Class{__includes = Entity}

function Attack:init(def)

    Entity.init(self, def)

end

function Attack:update(dt)

    Entity.update(self, dt)

end

function Attack:render()

    love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.currentAnimation:getCurrentFrame()],
        self.x, self.y)
        
end