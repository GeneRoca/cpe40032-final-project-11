StoryState = Class{__includes = BaseState}

local textToPrint = "Dryad is a peaceful race whose purpose was to create and protect life in nature. These gentle creatures are only capable of creation and restoration of nature's hosts."
local printedText = " "
local typeTimerMax = 2
local typeTimer = 0.08

local typePosition = 0


function StoryState:init()
    self.transitionAlpha = 255
    self.transitionAlphas = 0

    self.count = 21
    self.timer = 0
end

function StoryState:enter()
    Timer.tween(0.5, {
        [self] = {transitionAlpha = 0}
    })
    :finish(function()
    end)
end

function StoryState:update(dt)
    Timer.update(dt)

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then 
        Timer.tween(1.5, {
            [self] = {transitionAlphas = 255}
        }):finish(function()
        gStateMachine:change('start')
        end)
    end
    
    typeTimer = typeTimer - dt

    if typeTimer <= 0 then
        typeTimer = 0.08
        typePosition = typePosition + 1

        printedText = string.sub(textToPrint, 0, typePosition)
    end
    
    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('quit')
    end

    self.timer = self.timer + dt

    if self.timer > COUNTDOWN_TIME then
        self.timer = self.timer % COUNTDOWN_TIME
        self.count = self.count - 1

        if self.count == 0 then
            Timer.tween(1.5, {
                [self] = {transitionAlphas = 255}
            }):finish(function()
            gStateMachine:change('story1')
            end)
        end
    end

end

        
function StoryState:render()

    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)     
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.setFont(gFonts['small'])
    love.graphics.printf(printedText, 0, 40, WINDOW_WIDTH / 2 - 130 , 'center')
    love.graphics.setColor(0, 0, 0, self.transitionAlpha)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    love.graphics.setColor(0, 0, 0, self.transitionAlphas)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
end
