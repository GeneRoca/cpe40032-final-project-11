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
        ['quit'] = function()return QuitState() end

    }

    gSounds['music']:setLooping(true)
    gSounds['music']:play()

    
    gStateMachine:change('start')

    love.keyboard.keysPressed = {}
end

function love.resize(w, h)

    push:resize(w, h)

end

function love.keypressed(key)

    love.keyboard.keysPressed[key] = true

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


function initializeDictionary()

    for line in love.filesystem.lines('large.txt') do
        table.insert(words, line) 
    end

end

function chooseWord()

    currentCharIndex = 1
    fullString = words[math.random(#words)]
    
end