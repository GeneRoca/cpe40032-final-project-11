BeginState = Class{__includes = BaseState}

function BeginState:init()

    self.transitionAlpha = 255
    self.transitionAlphas = 0
    self.count = 3
    self.timer = 0

end

function BeginState:enter(params, difficulty, speed)
    self.highScores = params.highScores
    self.difficulty = params.difficulty
    self.speed = params.speed

    Timer.tween(0.5, {
        [self] = {transitionAlpha = 0}
    })
    :finish(function()
    end)

    additional = 0

end

function BeginState:update(dt)

    Timer.update(dt)

    self.timer = self.timer + dt

    if self.timer > COUNTDOWN_TIME then

        self.timer = self.timer % COUNTDOWN_TIME
        self.count = self.count - 1

        if self.count == 0 then

            Timer.tween(1.5, {
                [self] = {transitionAlpha = 255}
            }):finish(function()
            gStateMachine:change('play', {
    
                difficulty = self.difficulty,
                speed = self.speed,
                highScores = self.highScores
    
            })
            end)

        end

    end

    
end


function BeginState:render()

    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    
    love.graphics.draw(gTextures['frame'], 0, 0)
    love.graphics.setFont(gFonts['small'])

    love.graphics.setColor(100, 0, 0, 255)
    love.graphics.printf('Approaching demons...', 0, 126, WINDOW_WIDTH / 2 - 126 , 'center')
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf('Approaching demons...', 0, 125, WINDOW_WIDTH / 2 - 130 , 'center')
    love.graphics.setFont(gFonts['xs'])

    if tips then

        love.graphics.printf('TIPS: Type the words correctly so you can attack the monster.', 0, 15, WINDOW_WIDTH / 2 - 130 , 'center')
    else

        love.graphics.printf("TIPS: You can't escape or pause the game because it can be use for cheating.", 0, 15, WINDOW_WIDTH / 2 - 130 , 'center')
    
    end

    -- TRANSITIONING
    love.graphics.setColor(0, 0, 0, self.transitionAlpha)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    love.graphics.setColor(0, 0, 0, self.transitionAlphas)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    
end