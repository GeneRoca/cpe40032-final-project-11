Monster = Class{__includes = Entity}

function Monster:init(def)
    Entity.init(self, def)
end

function Monster:update(dt)
    Entity.update(self, dt)
end

function Monster:render()
    love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.currentAnimation:getCurrentFrame()],
        self.x, self.y)
end