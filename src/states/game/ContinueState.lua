ContinueState = Class{__includes = BaseState}

function ContinueState:init()

    self.transitionAlpha = 255
    self.transitionAlphas = 0

end

function ContinueState:enter(params)
    self.highScores = params.highScores
    Timer.tween(0.5, {
        [self] = {transitionAlpha = 0}
    })
    :finish(function()
    end)
    
end

function ContinueState:update(dt)
    
    Timer.update(dt)

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then

        Timer.tween(0.5, {
            [self] = {transitionAlphas = 255}
        }):finish(function()
        gStateMachine:change('start', {

            highScores = self.highScores

        })
        end)

        gSounds['click']:play()
        gSounds['music2']:stop()
        gSounds['music']:setLooping(true)
        gSounds['music']:play()

    elseif love.keyboard.wasPressed('escape') then

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


function ContinueState:render()
    
    love.graphics.setFont(gFonts['small'])
    love.graphics.setColor(100, 0, 0, 255)
    love.graphics.printf("You've escaped the game!\nThe progress won't be saved.", 0, 106, WINDOW_WIDTH / 2 - 126 , 'center')
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf("You've escaped the game!\nThe progress won't be saved.", 0, 105, WINDOW_WIDTH / 2 - 130 , 'center')
    love.graphics.setFont(gFonts['xs'])
    love.graphics.printf('Press enter to go back to main menu', 0, 200, WINDOW_WIDTH / 2 - 130 , 'center')

    -- TRANSITIONING
    love.graphics.setColor(0, 0, 0, self.transitionAlpha)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    love.graphics.setColor(0, 0, 0, self.transitionAlphas)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    
    
end