GameOverState = Class{__includes = BaseState}

function GameOverState:init()

    self.transitionAlpha = 255
    self.transitionAlphas = 0
    self.totalScore = 0

    highlighted = 1
    plays = false

    chooseWord()

end

function GameOverState:enter(params, difficulty, speed, count)
    self.highScores = params.highScores
    self.difficulty = params.difficulty
    self.speed = params.speed
    self.count = params.count

    Timer.tween(0.5, {
        [self] = {transitionAlpha = 0}
    })
    :finish(function()
    end)

    gSounds['laugh']:play()

    empower = 0

    self.totalScore = self.totalScore + self.count + additional

end

function GameOverState:update(dt)

    if self.difficulty == 1 then

        self.speed = 20

    elseif self.difficulty == 2 then

        self.speed = 25

    elseif self.difficulty == 3 then

        self.speed = 25

    end

    Timer.update(dt)

    if love.keyboard.wasPressed('left') or love.keyboard.wasPressed('right') then

        highlighted = highlighted == 1 and 2 or 1
        gSounds['select']:play()

    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then

        local highScore = false

         local scoreIndex = 11

        for i = 10, 1, -1 do

            local score = self.highScores[i].score or 0

            if self.totalScore > score then
                highScoreIndex = i
                highScore = true
            end
        end

        if highlighted == 1 then

            gSounds['click']:play()
            gSounds['music2']:stop()
            gSounds['music']:setLooping(true)
            gSounds['music']:play()

            if highScore then

                Timer.tween(0.5, {
                    [self] = {transitionAlphas = 255}
                }):finish(function()
                gStateMachine:change('enter-high-score', {
                    highScores = self.highScores,
                    score = self.totalScore,
                    scoreIndex = highScoreIndex,
                    difficulty = self.difficulty,
                    speed = self.speed,
                    highlighted = highlighted
    
                })
                end)
                
            else
                Timer.tween(0.5, {
                    [self] = {transitionAlphas = 255}
                }):finish(function()
                gStateMachine:change('begin', {
    
                    difficulty = self.difficulty,
                    speed = self.speed,
                    highScores = self.highScores
    
                })
                end)
            end
                
        
        elseif highlighted == 2 then

            gSounds['click']:play()
            gSounds['music2']:stop()
            gSounds['music']:play()

            if highScore then

                Timer.tween(0.5, {
                    [self] = {transitionAlphas = 255}
                }):finish(function()
                gStateMachine:change('enter-high-score', {
                    highScores = self.highScores,
                    score = self.totalScore,
                    scoreIndex = highScoreIndex,
                    difficulty = self.difficulty,
                    speed = self.speed,
                    highlighted = highlighted

                })
                end)
            else
                Timer.tween(0.5, {
                    [self] = {transitionAlphas = 255}
                }):finish(function()
                gStateMachine:change('start', {
    
                    difficulty = self.difficulty,
                    speed = self.speed,
                    highScores = self.highScores
    
                })
                end)
            end

        end

    end

    if love.keyboard.wasPressed('escape') then
        
        gSounds['click']:play()
        gSounds['music2']:stop()
        gSounds['music']:play()
    
        Timer.tween(0.5, {
            [self] = {transitionAlphas = 255}
        }):finish(function()
        gStateMachine:change('start', {
            highScores = self.highScores
        })
        end)
    
    end

end


function GameOverState:render()
    
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT) 
    
    love.graphics.setColor(100, 0, 0, 255)
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('Game Over', 0, 40, WINDOW_WIDTH / 2 - 126 , 'center')
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf('Game Over', 0, 40, WINDOW_WIDTH / 2 - 130 , 'center')
    love.graphics.setColor(175, 0, 0, 255)

    love.graphics.setFont(gFonts['xs'])
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf('Time Survived: ' .. tostring(self.count), 0, 120, WINDOW_WIDTH / 2 - 130 , 'center')
    love.graphics.printf('Total Number of Letters: ' .. additional, 0, 140, WINDOW_WIDTH / 2 - 130 , 'center')
    love.graphics.printf('Total Score: ' .. tostring(self.totalScore), 0, 160, WINDOW_WIDTH / 2 - 130 , 'center')

    love.graphics.setFont(gFonts['small'])
    love.graphics.setColor(100, 0, 0, 255)
    love.graphics.printf('Want to retry?', 0, 199, WINDOW_WIDTH / 2 - 126 , 'center')
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf('Want to retry?', 0, 198, WINDOW_WIDTH / 2 - 130 , 'center')
    love.graphics.setColor(75, 0, 0, 255)

    love.graphics.setFont(gFonts['xs'])
    
        if highlighted == 1 then
    
            love.graphics.setColor(255, 255, 255, 255)
    
        end
    
        love.graphics.printf("Yes", 0, VIRTUAL_HEIGHT / 2 + 95, VIRTUAL_WIDTH / 2 + 200, 'center')
    
        love.graphics.setColor(75, 0, 0, 255)
    
        if highlighted == 2 then
        
            love.graphics.setColor(255, 255, 255, 255)
        
        end

        love.graphics.printf("No", 0, VIRTUAL_HEIGHT / 2 + 95, VIRTUAL_WIDTH / 2 + 300, 'center')

    love.graphics.setFont(gFonts['small'])
    love.graphics.setColor(255, 255, 255, 255)

    -- TRANSITIONING
    love.graphics.setColor(0, 0, 0, self.transitionAlpha)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    love.graphics.setColor(0, 0, 0, self.transitionAlphas)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)        

end