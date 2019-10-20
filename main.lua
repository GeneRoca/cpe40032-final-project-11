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

    gStateMachine = StateMachine{

        ['story'] = function()return StoryState() end,
        ['story1'] = function()return Story1State() end,
        ['story2'] = function()return Story2State() end,
        ['story3'] = function()return Story3State() end,
        ['story4'] = function()return Story4State() end,
        ['story5'] = function()return Story5State() end,
        ['start'] = function() return StartState() end,
        ['play'] = function() return PlayState() end,
        ['highscore'] = function()return HighScoreState() end,
        ['begin'] = function()return BeginState() end,
        ['gameOver'] = function()return GameOverState() end,
        ['continue'] = function()return ContinueState() end,
        ['confirm'] = function()return ConfirmState() end,
        ['difficulty'] = function()return DifficultyState() end,
        ['enter-high-score'] = function()return EnterHighScoreState() end,
        ['high-scores'] = function()return HighScoreState() end,
        ['quit'] = function()return QuitState() end

    }

    gSounds['music']:setLooping(true)
    gSounds['music']:play()

    initializeDictionary()
    chooseWord()
    
    gStateMachine:change('story', {
        highScores = loadHighScores()
    })

    
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
    
    if plays == true then

        for i = 1, #ALPHABET do

            local char = ALPHABET:sub(i, i)

            if key == char then

                -- SUCCESSFULY TYPED THE LETTER
                if char == fullString:sub(currentCharIndex, currentCharIndex) then

                    -- SUCCESSFULLY TYPED THE WORD
                    if currentCharIndex == fullString:len() then

                        letters = letters + fullString:len()
                        additional = additional + fullString:len()
                        chooseWord()
                        attacks = true

                    else
                        currentCharIndex = currentCharIndex + 1
                        
                    end
                else

                    -- FAILED TO TYPE THE WORD 
                    currentCharIndex = 1
                    gSounds['back']:play()
                    speeds = speeds + 2
                    empower = empower + 1
                    
                    if empower > 4 then

                        speeds = speeds + 10

                    end
                    
                    if empower > 10 then

                        speeds = speeds + 10

                    end

                    return currentCharIndex

                end
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

function loadHighScores()
    love.filesystem.setIdentity('TypingGame')

    -- if the file doesn't exist, initialize it with some default scores
    if not love.filesystem.exists('TypingGame.lst') then
        local scores = ''
        for i = 10, 1, -1 do
            scores = scores .. 'CTO\n'
            scores = scores .. tostring(i * 1000) .. '\n'
        end

        love.filesystem.write('TypingGame.lst', scores)
    end

    -- flag for whether we're reading a name or not
    local name = true
    local currentName = nil
    local counter = 1

    -- initialize scores table with at least 10 blank entries
    local scores = {}

    for i = 1, 10 do
        -- blank table; each will hold a name and a score
        scores[i] = {
            name = nil,
            score = nil
        }
    end

    -- iterate over each line in the file, filling in names and scores
    for line in love.filesystem.lines('TypingGame.lst') do
        if name then
            scores[counter].name = string.sub(line, 1, 3)
        else
            scores[counter].score = tonumber(line)
            counter = counter + 1
        end

        -- flip the name flag
        name = not name
    end

    return scores
end

