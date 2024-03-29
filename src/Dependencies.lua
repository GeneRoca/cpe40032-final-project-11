-- LIBRARIES
Class = require 'lib/class'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

-- UTILITY
require 'src/Constants'
require 'src/StateMachine'
require 'src/Util'

-- GAME STATES
require 'src/states/BaseState'
require 'src/states/game/PlayState'
require 'src/states/game/StartState'
require 'src/states/game/HighScoreState'
require 'src/states/game/EnterHighScoreState'
require 'src/states/game/QuitState'
require 'src/states/game/BeginState'
require 'src/states/game/GameOverState'
require 'src/states/game/ContinueState'
require 'src/states/game/StoryState'
require 'src/states/game/Story1State'
require 'src/states/game/Story2State'
require 'src/states/game/Story3State'
require 'src/states/game/Story4State'
require 'src/states/game/Story5State'
require 'src/states/game/DifficultyState'
require 'src/states/game/ConfirmState'

-- ENTITY STATES
require 'src/states/entity/FireHeroIdleState'

-- MONSTER STATES
require 'src/states/entity/monster/MonsterMovingState'
require 'src/states/entity/monster/MonsterHurtState'
require 'src/states/entity/monster/MonsterAttackState'

-- ATTACK STATES
require 'src/states/entity/attack/FireBallState'
require 'src/states/entity/attack/FireWaveState'
require 'src/states/entity/attack/NoAttackState'

-- GENERAL
require 'src/Animation'
require 'src/Entity'
require 'src/FireHero'
require 'src/Monster'
require 'src/Attack'

-- SOUND FILES
gSounds = {

    ['music'] = love.audio.newSource('sounds/music.mp3'),
    ['music2'] = love.audio.newSource('sounds/music2.mp3'),
    ['click'] = love.audio.newSource('sounds/click.mp3'),
    ['back'] = love.audio.newSource('sounds/back.wav'),
    ['select'] = love.audio.newSource('sounds/select.mp3'),
    ['fire'] = love.audio.newSource('sounds/fire.mp3'),
    ['fireWhoosh'] = love.audio.newSource('sounds/fireWhoosh.mp3'),
    ['fireBall'] = love.audio.newSource('sounds/fireBall.mp3'),
    ['monster_hurt'] = love.audio.newSource('sounds/monster_hurt.mp3'),
    ['monster_attack'] = love.audio.newSource('sounds/monster_attack.mp3'),
    ['laugh'] = love.audio.newSource('sounds/laugh.mp3')

}

-- IMAGE FILES
gTextures = {
    
    ['fire_hero'] = love.graphics.newImage('graphics/fire_hero.png'),
    ['background'] = love.graphics.newImage('graphics/background.jpeg'),
    ['frame'] = love.graphics.newImage('graphics/frame.png'),
    ['frame2'] = love.graphics.newImage('graphics/frame2.png'),
    ['frame3'] = love.graphics.newImage('graphics/frame3.png'),
    ['eye-monster'] = love.graphics.newImage('graphics/eye-monster.png'),
    ['fire_wave'] = love.graphics.newImage('graphics/fire_wave.png'),
    ['timer'] = love.graphics.newImage('graphics/timer.png')
    

}

-- TO CUT AN IMAGE FILE TO CREATE FRAMES 
gFrames = {

    ['fire_hero'] = GenerateQuads(gTextures['fire_hero'], 112, 160),
    ['eye-monster'] = GenerateQuads(gTextures['eye-monster'], 352, 161),
    ['fire_wave'] = GenerateQuads(gTextures['fire_wave'], 486, 192),

}

-- FONT SIZES
gFonts = {

    ['large'] = love.graphics.newFont('fonts/font.ttf', 128),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 64),
    ['small'] = love.graphics.newFont('fonts/font.ttf', 32),
    ['xs'] = love.graphics.newFont('fonts/font.ttf', 16)

}