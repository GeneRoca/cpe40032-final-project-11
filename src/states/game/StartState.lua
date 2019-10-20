StartState = Class{__includes = BaseState}

local highlighted = 1

function StartState:init()

    self.transitionAlpha = 255
    self.transitionAlphas = 0
    self.transitionAlphass = 0
    self.count = 30
    self.timer = 0
    self.highlighted = 1

end

local typePosition = 0

function StartState:enter(params)

    self.highScores = params.highScores

    Timer.tween(0.5, {
        [self] = {transitionAlpha = 0}
    })
    :finish(function()
    end)

end

function StartState:update(dt)

    Timer.update(dt)

    if love.keyboard.wasPressed('up') then
       
        if self.highlighted == 1 then
        
            self.highlighted = self.highlighted + 3

            gSounds['select']:play()
        
        else
        
            self.highlighted = self.highlighted - 1
            
            gSounds['select']:play()
        
        end
    
    elseif love.keyboard.wasPressed('down') then
    
        if self.highlighted == 4 then
    
            self.highlighted = self.highlighted - 3
    
            gSounds['select']:play()
    
        else
    
            self.highlighted = self.highlighted + 1
    
            gSounds['select']:play()
    
        end
    
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then

        
        if self.highlighted == 1 then

            gSounds['click']:play()

            Timer.tween(0.5, {
                [self] = {transitionAlphas = 255}
            }):finish(function()
            gStateMachine:change('difficulty', {
                highScores = self.highScores
            })
            end)

        elseif self.highlighted == 2 then

            gSounds['click']:play()

            Timer.tween(0.5, {
                [self] = {transitionAlphas = 255}
            }):finish(function()
            gStateMachine:change('highscore', {
                highScores = self.highScores
            })
            end)
        elseif self.highlighted == 3 then 

            gSounds['click']:play()

            Timer.tween(0.5, {
                [self] = {transitionAlphass = 255}
            }):finish(function()
            gStateMachine:change('story', {
                highScores = self.highScores
            })
            end)

        elseif self.highlighted == 4 then

            gSounds['click']:play()

            Timer.tween(0.5, {
                [self] = {transitionAlphas = 255}
            }):finish(function()
            gStateMachine:change('quit', {
                highScores = self.highScores
            })
            end)
    
        end

    end

    -- we no longer have this globally, so include here
    if love.keyboard.wasPressed('escape') then

        gSounds['click']:play()
        
        Timer.tween(0.5, {
            [self] = {transitionAlphas = 255}
        }):finish(function()
        gStateMachine:change('quit', {
            highScores = self.highScores
        })
        end)
    
    end

end

function StartState:render()

    love.graphics.draw(gTextures['frame2'], 0, -22)
    love.graphics.setFont(gFonts['medium'])
    
    love.graphics.setColor(100, 0, 0, 255)
    love.graphics.printf("Typing Game", 0, 50, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf("Typing Game", 0, 50, VIRTUAL_WIDTH-5, 'center')
    love.graphics.setColor(175, 0, 0, 255)

    love.graphics.setFont(gFonts['small'])

    if self.highlighted == 1 then

        love.graphics.setColor(255, 255, 255, 255)

    end

    love.graphics.printf("Start", 0, VIRTUAL_HEIGHT / 2 + 10, VIRTUAL_WIDTH, 'center')

    -- RESET THE COLOR
    love.graphics.setColor(175, 0, 0, 255)

    if self.highlighted == 2 then

        love.graphics.setColor(255, 255, 255, 255)

    end
    
    love.graphics.printf("High Scores", 0, VIRTUAL_HEIGHT / 2 + 40, VIRTUAL_WIDTH, 'center')

    -- RESET THE COLOR
    love.graphics.setColor(175, 0, 0, 255)

    if self.highlighted == 3 then

        love.graphics.setColor(255, 255, 255, 255)

    end
    
    love.graphics.printf("Story", 0, VIRTUAL_HEIGHT / 2 + 70, VIRTUAL_WIDTH, 'center')

    -- RESET THE COLOR
    love.graphics.setColor(175, 0, 0, 255)

    if self.highlighted == 4 then

        love.graphics.setColor(255, 255, 255, 255)

    end
    
    love.graphics.printf("Quit", 0, VIRTUAL_HEIGHT / 2 + 100, VIRTUAL_WIDTH, 'center')

    -- RESET THE COLOR
    love.graphics.setColor(175, 0, 0, 255)

    -- TRANSITIONING
    love.graphics.setColor(0, 0, 0, self.transitionAlpha)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    love.graphics.setColor(0, 0, 0, self.transitionAlphas)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    love.graphics.setColor(255, 255, 255, self.transitionAlphass)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    
    love.graphics.setColor(175, 0, 0, 255)
end