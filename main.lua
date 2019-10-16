require 'src/Dependencies'

function love.load()

    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('Typing Game')

    math.randomseed(os.time())
  
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = true
    })

    gStateMachine = StateMachine {
        ['start'] = function() return StartState() end,
        ['play'] = function() return PlayState() end,
        ['highscore'] = function()return HighScoreState() end,
        ['begin'] = function()return BeginState() end,
        ['gameOver'] = function()return GameOverState() end,
        ['continue'] = function()return ContinueState() end,
        ['story'] = function()return StoryState() end,
        ['story1'] = function()return Story1State() end,
        ['story2'] = function()return Story2State() end,
        ['story3'] = function()return Story3State() end,
        ['story4'] = function()return Story4State() end,
        ['story5'] = function()return Story5State() end,
        ['confirm'] = function()return ConfirmState() end,
        ['difficulty'] = function()return DifficultyState() end,
        ['quit'] = function()return QuitState() end


    }

    gSounds['music']:setLooping(true)
    gSounds['music']:play()

    initializeDictionary()
    chooseWord()
    
    gStateMachine:change('story')

    
    Timer.every(0.5, function()
        cursor = not cursor
    end)

    Timer.every(5, function()
        tips = not tips
    end)

    love.keyboard.keysPressed = {}
end

function love.resize(w, h)

    push:resize(w, h)

end

function love.keypressed(key)

    love.keyboard.keysPressed[key] = true

    for i = 1, #ALPHABET do
        local char = ALPHABET:sub(i, i)

        -- if we have pressed this key of the alphabet...
        if key == char then

            -- if we have typed the current correct letter...
            if char == fullString:sub(currentCharIndex, currentCharIndex) then

                -- successfully typed full word
                if currentCharIndex == fullString:len() then
                   letters = letters + fullString:len()
                    chooseWord()
                    attacks = true
                    gSounds['monster_hurt']:play()
                else
                    currentCharIndex = currentCharIndex + 1
                    
                end
            else

                -- else if we typed the wrong letter...
                currentCharIndex = 1
                gSounds['back']:play()
            end
        end
    end


end

function love.keyboard.wasPressed(key)

    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end

end

function love.update(dt)

    gStateMachine:update(dt)

    love.keyboard.keysPressed = {}

end


function love.draw()

    push:start()
    love.graphics.draw(gTextures['background'], 0, 0)
    gStateMachine:render()
    push:finish()

end


