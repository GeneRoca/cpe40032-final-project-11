Story5State = Class{__includes = BaseState}

function Story5State:init()
    
    self.transitionAlpha = 255
    self.transitionAlphas = 0
    self.count = 20
    self.timer = 0
end

function Story5State:enter(params)

    self.highScores = params.highScores
    
    Timer.tween(0.5, {
        [self] = {transitionAlpha = 0}
    })
    :finish(function()
    end)

    self.textToPrint = 'Can this be his calling? Can he defeat them on his own? A chance to prove his worth. A different calling. This time to protect his own kind using this "curse".'
    self.printedText = " "
    self.typeTimerMax = 0.1
    self.typeTimer = 0.08
    self.typePosition = 0

end

function Story5State:update(dt)

    Timer.update(dt)

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then 

        Timer.tween(1.5, {
            [self] = {transitionAlphas = 255}
        }):finish(function()
        gStateMachine:change('start', {
            highScores = self.highScores
        })
        end)

    end
    
    self.typeTimer = self.typeTimer - dt

    if self.typeTimer <= 0 then

        self.typeTimer = 0.08
        self.typePosition = self.typePosition + 1

        self.printedText = string.sub(self.textToPrint, 0, self.typePosition)

    end
    
    if love.keyboard.wasPressed('escape') then

        Timer.tween(1.5, {
            [self] = {transitionAlphas = 255}
        }):finish(function()
        gStateMachine:change('start', {
            highScores = self.highScores
        })
        end)

    end
    
    self.timer = self.timer + dt

    if self.timer > COUNTDOWN_TIME then

        self.timer = self.timer % COUNTDOWN_TIME
        self.count = self.count - 1

        if self.count == 0 then

            Timer.tween(1.5, {
                [self] = {transitionAlphas = 255}
            }):finish(function()
            gStateMachine:change('start', {
                highScores = self.highScores
            })
            end)

        end
        
    end

end

        
function Story5State:render()

    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)     
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.setFont(gFonts['small'])
    love.graphics.printf(self.printedText, 0, 60, WINDOW_WIDTH / 2 - 130 , 'center')

    -- TRANSITIONING
    love.graphics.setColor(0, 0, 0, self.transitionAlpha)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    love.graphics.setColor(0, 0, 0, self.transitionAlphas)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

end
