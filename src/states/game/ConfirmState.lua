ConfirmState = Class{__includes = BaseState}

function ConfirmState:init()

    self.transitionAlphas = 0

    highlighted = 1

end

function ConfirmState:enter(params, difficulty, speed)
    self.highScores = params.highScores
    self.difficulty = params.difficulty
    self.speed = params.speed
    
end

function ConfirmState:update(dt)

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
            gStateMachine:change('begin', {

                difficulty = self.difficulty,
                speed = self.speed,
                highScores = self.highScores

            })
            end)

        else

            Timer.tween(0.5, {
                [self] = {transitionAlphas = 255}
            }):finish(function()
            gStateMachine:change('difficulty', {

                highScores = self.highScores
            
            })
            end)

        end
    end

    -- we no longer have this globally, so include here
    if love.keyboard.wasPressed('escape') then

        gSounds['click']:play()
        gStateMachine:change('difficulty', {
            
            highScores = self.highScores

        })

    end
end


function ConfirmState:render()
    
    love.graphics.setFont(gFonts['medium'])

    love.graphics.setColor(100, 0, 0, 255)
    love.graphics.printf('Confirm', 0, 74, WINDOW_WIDTH / 2 - 126 , 'center')
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf('Confirm', 0, 70, WINDOW_WIDTH / 2 - 130 , 'center')
    love.graphics.setColor(175, 0, 0, 255)
    
        love.graphics.setFont(gFonts['small'])

        if highlighted == 1 then

            love.graphics.setColor(255, 255, 255, 255)

        end

        love.graphics.printf("Yes", 0, VIRTUAL_HEIGHT / 2 + 30, VIRTUAL_WIDTH / 2 + 100, 'center')
    
        love.graphics.setColor(175, 0, 0, 255)
    
        if highlighted == 2 then

            love.graphics.setColor(255, 255, 255, 255)

        end

        love.graphics.printf("No", 0, VIRTUAL_HEIGHT / 2 + 30, VIRTUAL_WIDTH / 2 + 400, 'center')

        -- TRANSITIONING
        love.graphics.setColor(0, 0, 0, self.transitionAlphas)
        love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    
        love.graphics.setColor(255, 255, 255, 255)

end