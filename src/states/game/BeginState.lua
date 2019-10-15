BeginState = Class{__includes = BaseState}

function BeginState:init()

end

function BeginState:enter(params)
    
end

function BeginState:update(dt)

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('play', {
        })
        gSounds['click']:play()
    elseif love.keyboard.wasPressed('escape') then
        gStateMachine:change('start', {
        })
        gSounds['click']:play()
    end

    
end


function BeginState:render()
    
    love.graphics.draw(gTextures['frame'], 0, 0)
    love.graphics.setFont(gFonts['small'])
    love.graphics.setColor(100, 0, 0, 255)
    love.graphics.printf('Press enter to start!', 0, 126, WINDOW_WIDTH / 2 - 126 , 'center')
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf('Press enter to start!', 0, 125, WINDOW_WIDTH / 2 - 130 , 'center')
    love.graphics.setFont(gFonts['xs'])
    love.graphics.printf('TIPS: Type the words correctly so you can attack the monster.', 0, 15, WINDOW_WIDTH / 2 - 130 , 'center')
    
end