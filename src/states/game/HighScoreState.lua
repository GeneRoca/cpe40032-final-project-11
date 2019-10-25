HighScoreState = Class{__includes = BaseState}

function HighScoreState:init()

    self.transitionAlpha = 255
    self.transitionAlphas = 0

end

function HighScoreState:enter(params)

    self.highScores = params.highScores
    
    Timer.tween(0.5, {
        [self] = {transitionAlpha = 0}
    })
    :finish(function()
    end)

end
    
function HighScoreState:update(dt)

    Timer.update(dt)

    if love.keyboard.wasPressed('escape') or love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then

        Timer.tween(0.5, {
            [self] = {transitionAlphas = 255}
        }):finish(function()
        gStateMachine:change('start', {
            highScores = self.highScores
        })
        end)
        gSounds['click']:play()
    
    end
    
end

function HighScoreState:render()
    love.graphics.setColor(0, 0, 0, 150)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    love.graphics.setFont(gFonts['small'])

    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf('High Scores', 0, 10, WINDOW_WIDTH / 2 - 130 , 'center')
    
    love.graphics.setFont(gFonts['xs'])

    -- iterate over all high score indices in our high scores table
    for i = 1, 10 do
        local name = self.highScores[i].name or '---'
        local score = self.highScores[i].score or '---'

        -- score number (1-10)
        love.graphics.printf(tostring(i) .. '.', VIRTUAL_WIDTH / 4,
            35 + i * 20, 50, 'left')

        -- score name
        love.graphics.printf(name, VIRTUAL_WIDTH / 2 - 27,
            35 + i * 20, 50, 'center')

        -- score itself
        love.graphics.printf(tostring(score), VIRTUAL_WIDTH / 2 + 27,
            35 + i * 20, 100, 'right')
    end

    love.graphics.printf("Press Escape or Enter to return to the main menu!", 0, VIRTUAL_HEIGHT - 25, VIRTUAL_WIDTH, 'center')

    -- TRANSITIONING
    love.graphics.setColor(0, 0, 0, self.transitionAlpha)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    love.graphics.setColor(0, 0, 0, self.transitionAlphas)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    
end