GameOverState = Class{__includes = BaseState}

function GameOverState:init()

end

function GameOverState:enter(params)
    
end

function GameOverState:update(dt)

    -- toggle highlighted option if we press an arrow key up or down
    if love.keyboard.wasPressed('left') or love.keyboard.wasPressed('right') then
        highlighted = highlighted == 1 and 2 or 1
        gSounds['select']:play()
    end

    -- confirm whichever option we have selected to change screens
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then

        if highlighted == 1 then
            gSounds['click']:play()
            gStateMachine:change('start', {
            })
        else
            gSounds['click']:play()
            gStateMachine:change('begin', {
            })
        end
    end

    -- we no longer have this globally, so include here
    if love.keyboard.wasPressed('escape') then
        gSounds['click']:play()
        gStateMachine:change('start', {
        })
    end
end


function GameOverState:render()
    
    
    love.graphics.setColor(100, 0, 0, 255)
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('Game Over', 0, 84, WINDOW_WIDTH / 2 - 126 , 'center')
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf('Game Over', 0, 83, WINDOW_WIDTH / 2 - 130 , 'center')
    love.graphics.setColor(175, 0, 0, 255)

    love.graphics.setFont(gFonts['small'])
    love.graphics.setColor(100, 0, 0, 255)
    love.graphics.printf('Want to retry?', 0, 149, WINDOW_WIDTH / 2 - 126 , 'center')
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf('Want to retry?', 0, 148, WINDOW_WIDTH / 2 - 130 , 'center')
    love.graphics.setColor(175, 0, 0, 255)
        -- instructions
        love.graphics.setFont(gFonts['small'])

        -- if we're highlighting 1, render that option blue
        if highlighted == 1 then
            love.graphics.setColor(255, 255, 255, 255)
        end
        love.graphics.printf("No", 0, VIRTUAL_HEIGHT / 2 + 60,
            VIRTUAL_WIDTH / 2 + 100, 'center')
    
        -- reset the color
        love.graphics.setColor(175, 0, 0, 255)
    
        -- render option 2 blue if we're highlighting that one
        if highlighted == 2 then
            love.graphics.setColor(255, 255, 255, 255)
        end
        love.graphics.printf("Yes", 0, VIRTUAL_HEIGHT / 2 + 60,
            VIRTUAL_WIDTH / 2 + 400, 'center')
    
        -- reset the color
        love.graphics.setColor(255, 255, 255, 255)

end