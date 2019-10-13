HighScoreState = Class{__includes = BaseState}


function HighScoreState:init()
    
end

function HighScoreState:enter(params)
    
end
    
function HighScoreState:update(dt)

    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('start', {
        })
        gSounds['click']:play()
    end
    
end

function HighScoreState:render()
    
    love.graphics.printf('High Scores', 0, 30, WINDOW_WIDTH / 2 - 130 , 'center')

end