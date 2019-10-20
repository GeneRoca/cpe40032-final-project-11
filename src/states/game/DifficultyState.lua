DifficultyState = Class{__includes = BaseState}

function DifficultyState:init()

    self.transitionAlpha = 255
    self.difficulty = 0
    self.speed = speeds
    self.highlighted = 2

end

function DifficultyState:enter(params)
    self.highScores = params.highScores
    Timer.tween(0.5, {
        [self] = {transitionAlpha = 0}
    })
    :finish(function()
    end)

end

function DifficultyState:update(dt)

    Timer.update(dt)
    
    if love.keyboard.wasPressed('left') then
       
        if self.highlighted == 1 then
        
            self.highlighted = self.highlighted + 2

            gSounds['select']:play()
        
        else
        
            self.highlighted = self.highlighted - 1
            
            gSounds['select']:play()
        
        end
    
    elseif love.keyboard.wasPressed('right') then
    
        if self.highlighted == 3 then
    
            self.highlighted = self.highlighted - 2
    
            gSounds['select']:play()
    
        else
    
            self.highlighted = self.highlighted + 1
    
            gSounds['select']:play()
    
        end
    
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then

        if self.highlighted == 1 then

            gSounds['click']:play()

            self.difficulty = 1
            self.speed = 20

            gStateMachine:change('confirm', {

                difficulty = self.difficulty,
                speed = self.speed,
                highScores = self.highScores
                
            })

        elseif self.highlighted == 2 then

            gSounds['click']:play()

            self.difficulty = 2
            self.speed = 25

            gStateMachine:change('confirm', {

                difficulty = self.difficulty,
                speed = self.speed,
                highScores = self.highScores

            })

        elseif self.highlighted == 3 then

            gSounds['click']:play()

            self.difficulty = 3
            self.speed = 25

            gStateMachine:change('confirm', {

                difficulty = self.difficulty,
                speed = self.speed,
                highScores = self.highScores

            })

        end

        difficulties = self.difficulty

    end

    
    if love.keyboard.wasPressed('escape') then

        gStateMachine:change('start', {

            highScores = self.highScores

        })

    end

end


function DifficultyState:render()
    
    love.graphics.setFont(gFonts['medium'])
    love.graphics.setColor(100, 0, 0, 255)
    love.graphics.printf('Difficulty', 0, 74, WINDOW_WIDTH / 2 - 126 , 'center')
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf('Difficulty', 0, 70, WINDOW_WIDTH / 2 - 130 , 'center')
    love.graphics.setColor(175, 0, 0, 255)

        love.graphics.setFont(gFonts['small'])

        if self.highlighted == 1 then

            love.graphics.setColor(255, 255, 255, 255)

        end

        love.graphics.printf("Easy", 0, VIRTUAL_HEIGHT / 2 + 30, VIRTUAL_WIDTH / 2 + 30, 'center')
               
        love.graphics.setColor(175, 0, 0, 255)
    
        if self.highlighted == 2 then

            love.graphics.setColor(255, 255, 255, 255)

        end
        
        love.graphics.printf("Normal", 0, VIRTUAL_HEIGHT / 2 + 30, VIRTUAL_WIDTH / 2 + 260, 'center')

        love.graphics.setColor(175, 0, 0, 255)
    
        if self.highlighted == 3 then

            love.graphics.setColor(255, 255, 255, 255)

        end

        love.graphics.printf("Hard", 0, VIRTUAL_HEIGHT / 2 + 30, VIRTUAL_WIDTH / 2 + 480, 'center')

        -- TRANISITIONING
        love.graphics.setColor(0, 0, 0, self.transitionAlpha)
        love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    
        love.graphics.setColor(255, 255, 255, 255)

end