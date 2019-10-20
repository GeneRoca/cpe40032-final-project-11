Entity = Class{}

function Entity:init(def)

    -- POSITON
    self.x = def.x
    self.y = def.y 

    -- VELOCITY
    self.dx = def.dx
    
    -- IMAGE TO USE
    self.texture = def.texture

    self.stateMachine = def.stateMachine

end

function Entity:changeState(state, params)

    self.state = state
    self.stateMachine:change(state, params)

end

function Entity:update(dt)

    self.currentAnimation:update(dt)
    self.stateMachine:update(dt)

end

function Entity:render()

    love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.currentAnimation:getCurrentFrame()],
        self.x, self.y)

end


