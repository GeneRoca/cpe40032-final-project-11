DifficultyState = Class{__includes = BaseState}

function DifficultyState:init()
    self.transitionAlpha = 255
    self.difficulty = 0
    self.speed = 0
    self.highlighted = 2
end

function DifficultyState:enter(params)
    Timer.tween(0.5, {
        [self] = {transitionAlpha = 0}
    })
    :finish(function()
    end)
end

function DifficultyState:update(dt)
    Timer.update(dt)
    -- toggle self.highlighted option if we press an arrow key up or down
    
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


    -- confirm whichever option we have selected to change screens
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then

        if self.highlighted == 1 then
            gSounds['click']:play()
            self.difficulty = 0.1
            self.speed = 20
            gStateMachine:change('confirm',{
                difficulty = self.difficulty,
                speed = self.speed
            })
        elseif self.highlighted == 2 then
            gSounds['click']:play()
            self.difficulty = 0.2
            self.speed = 30
            gStateMachine:change('confirm',{
                difficulty = self.difficulty,
                speed = self.speed
            })
        elseif self.highlighted == 3 then
            gSounds['click']:play()
            self.difficulty = 0.3
            self.speed = 40
            gStateMachine:change('confirm',{
                difficulty = self.difficulty,
                speed = self.speed
            })
        end
    end

    -- we no longer have this globally, so include here
    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('start')
    end
end


function DifficultyState:render()
    
    love.graphics.setFont(gFonts['medium'])
    love.graphics.setColor(100, 0, 0, 255)
    love.graphics.printf('Difficulty', 0, 74, WINDOW_WIDTH / 2 - 126 , 'center')
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf('Difficulty', 0, 70, WINDOW_WIDTH / 2 - 130 , 'center')
    love.graphics.setColor(175, 0, 0, 255)
        -- instructions
        love.graphics.setFont(gFonts['small'])

        -- if we're highlighting 1, render that option blue
        if self.highlighted == 1 then
            love.graphics.setColor(255, 255, 255, 255)
        end
        love.graphics.printf("Easy", 0, VIRTUAL_HEIGHT / 2 + 30,
            VIRTUAL_WIDTH / 2 + 30, 'center')
    
        -- reset the color
        love.graphics.setColor(175, 0, 0, 255)
    
        -- render option 2 blue if we're highlighting that one
        if self.highlighted == 2 then
            love.graphics.setColor(255, 255, 255, 255)
        end
        love.graphics.printf("Normal", 0, VIRTUAL_HEIGHT / 2 + 30,
            VIRTUAL_WIDTH / 2 + 260, 'center')

        love.graphics.setColor(175, 0, 0, 255)
    
        -- render option 2 blue if we're highlighting that one
        if self.highlighted == 3 then
            love.graphics.setColor(255, 255, 255, 255)
        end
        love.graphics.printf("Hard", 0, VIRTUAL_HEIGHT / 2 + 30,
            VIRTUAL_WIDTH / 2 + 480, 'center')

        love.graphics.setColor(0, 0, 0, self.transitionAlpha)
        love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    
        -- reset the color
        love.graphics.setColor(255, 255, 255, 255)

end