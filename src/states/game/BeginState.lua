BeginState = Class{__includes = BaseState}

function BeginState:init()
    self.transitionAlpha = 255
    self.transitionAlphas = 0
end

function BeginState:enter(params, difficulty, speed)
    self.difficulty = params.difficulty
    self.speed = params.speed
    Timer.tween(0.5, {
        [self] = {transitionAlpha = 0}
    })
    :finish(function()
    end)
end

function BeginState:update(dt)

    Timer.update(dt)

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        Timer.tween(1.5, {
            [self] = {transitionAlpha = 255}
        }):finish(function()
        gStateMachine:change('play', {
            difficulty = self.difficulty,
            speed = self.speed
        })
        end)
        gSounds['click']:play()
    elseif love.keyboard.wasPressed('escape') then
        Timer.tween(0.5, {
            [self] = {transitionAlphas = 255}
        }):finish(function()
        gStateMachine:change('difficulty')
        end)
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
    if tips then
        love.graphics.printf('TIPS: Type the words correctly so you can attack the monster.', 0, 15, WINDOW_WIDTH / 2 - 130 , 'center')
    else
        love.graphics.printf("TIPS: You can't escape or pause the game, it might be used for cheating.", 0, 15, WINDOW_WIDTH / 2 - 130 , 'center')
    end
    love.graphics.setColor(0, 0, 0, self.transitionAlpha)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    love.graphics.setColor(0, 0, 0, self.transitionAlphas)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    
end