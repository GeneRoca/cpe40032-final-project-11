StartState = Class{__includes = BaseState}
local highlighted = 1

function StartState:init()
    self.transitionAlpha = 255
    self.transitionAlphas = 0

    self.count = 30
    self.timer = 0
end



function StartState:enter(params)
    Timer.tween(0.5, {
        [self] = {transitionAlpha = 0}
    })
    :finish(function()
    end)
end

function StartState:update(dt)
    Timer.update(dt)

    self.timer = self.timer + dt

    if self.timer > COUNTDOWN_TIME then
        self.timer = self.timer % COUNTDOWN_TIME
        self.count = self.count - 1

        if self.count == 0 then
            Timer.tween(1.5, {
                [self] = {transitionAlphas = 255}
            }):finish(function()
            gStateMachine:change('story')
            end)
        end
    end
    -- toggle highlighted option if we press an arrow key up or down
    if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('down') then
        highlighted = highlighted == 1 and 2 or 1
        gSounds['select']:play()
    end

    -- confirm whichever option we have selected to change screens
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then

        if highlighted == 1 then
            gSounds['click']:play()
            Timer.tween(0.5, {
                [self] = {transitionAlphas = 255}
            }):finish(function()
            gStateMachine:change('difficulty')
            end)
        else
            gSounds['click']:play()
            Timer.tween(0.5, {
                [self] = {transitionAlphas = 255}
            }):finish(function()
            gStateMachine:change('highscore')
            end)
        end
    end

    -- we no longer have this globally, so include here
    if love.keyboard.wasPressed('escape') then
        gSounds['click']:play()
        gStateMachine:change('quit', {
        })
    end
end

function StartState:render()

    love.graphics.draw(gTextures['frame2'], 0, 0)
    love.graphics.setFont(gFonts['medium'])
    
    love.graphics.setColor(100, 0, 0, 255)
    love.graphics.printf("Typing Game", 0, 75, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf("Typing Game", 0, 75, VIRTUAL_WIDTH-5, 'center')
    love.graphics.setColor(175, 0, 0, 255)

    love.graphics.setFont(gFonts['small'])

    -- if we're highlighting 1, render that option blue
    if highlighted == 1 then
        love.graphics.setColor(255, 255, 255, 255)
    end
    love.graphics.printf("Start", 0, VIRTUAL_HEIGHT / 2 + 60,
        VIRTUAL_WIDTH, 'center')

    -- reset the color
    love.graphics.setColor(175, 0, 0, 255)

    -- render option 2 blue if we're highlighting that one
    if highlighted == 2 then
        love.graphics.setColor(255, 255, 255, 255)
    end
    love.graphics.printf("High Scores", 0, VIRTUAL_HEIGHT / 2 + 90,
        VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(0, 0, 0, self.transitionAlpha)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    love.graphics.setColor(0, 0, 0, self.transitionAlphas)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    
    -- reset the color
    love.graphics.setColor(175, 0, 0, 255)
end