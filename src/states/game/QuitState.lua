QuitState = Class{__includes = BaseState}

function QuitState:init()

    self.transitionAlpha = 255
    self.transitionAlphas = 0

    highlighted = 1

end

function QuitState:enter(params)

    self.highScores = params.highScores

    Timer.tween(0.5, {
        [self] = {transitionAlpha = 0}
    })
    :finish(function()
    end)

end

function QuitState:update(dt)
    
    Timer.update(dt)
    
    if love.keyboard.wasPressed('left') or love.keyboard.wasPressed('right') then
    
        highlighted = highlighted == 1 and 2 or 1
        gSounds['select']:play()
    
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then

        if highlighted == 1 then
    
            gSounds['click']:play()
            Timer.tween(0.5, {
                [self] = {transitionAlphas = 255}
            }):finish(function()
            gStateMachine:change('start', {
                highScores = self.highScores
            })
            end)
    
        else

            gSounds['click']:play()
            love.event.quit()
        
        end
    
    end

    if love.keyboard.wasPressed('escape') then

        love.event.quit()
        
    end

end

function QuitState:render()

    love.graphics.setColor(100, 0, 0, 255)
    love.graphics.printf('Are you sure you want to quit?', 0, 126, WINDOW_WIDTH / 2 - 126 , 'center')
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf('Are you sure you want to quit?', 0, 125, WINDOW_WIDTH / 2 - 130 , 'center')
    love.graphics.setColor(175, 0, 0, 255)

        love.graphics.setFont(gFonts['small'])

        if highlighted == 1 then
    
            love.graphics.setColor(255, 255, 255, 255)
    
        end
    
        love.graphics.printf("No", 0, VIRTUAL_HEIGHT / 2 + 60, VIRTUAL_WIDTH / 2 + 100, 'center')
    
        love.graphics.setColor(175, 0, 0, 255)

        if highlighted == 2 then
        
            love.graphics.setColor(255, 255, 255, 255)
        
        end
        
        love.graphics.printf("Yes", 0, VIRTUAL_HEIGHT / 2 + 60,
            VIRTUAL_WIDTH / 2 + 400, 'center')

        -- TRANSITIONING
        love.graphics.setColor(0, 0, 0, self.transitionAlpha)
        love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
        love.graphics.setColor(0, 0, 0, self.transitionAlphas)
        love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    
        love.graphics.setColor(255, 255, 255, 255)

end