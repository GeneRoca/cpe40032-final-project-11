HighScoreState = Class{__includes = BaseState}


function HighScoreState:init()
    self.transitionAlpha = 255
    self.transitionAlphas = 0
end

function HighScoreState:enter(params)
    Timer.tween(0.5, {
        [self] = {transitionAlpha = 0}
    })
    :finish(function()
    end)
end
    
function HighScoreState:update(dt)

    Timer.update(dt)

    if love.keyboard.wasPressed('escape') then
        Timer.tween(0.5, {
            [self] = {transitionAlphas = 255}
        }):finish(function()
        gStateMachine:change('start')
        end)
        gSounds['click']:play()
    end
    
end

function HighScoreState:render()
    
    love.graphics.printf('High Scores', 0, 30, WINDOW_WIDTH / 2 - 130 , 'center')
    
    
    love.graphics.setColor(0, 0, 0, self.transitionAlpha)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    love.graphics.setColor(0, 0, 0, self.transitionAlphas)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    
end