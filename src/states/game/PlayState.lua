PlayState = Class{__includes = BaseState}


function PlayState:init()

    self.transitionAlpha = 255
    self.transitionAlphas = 0
    self.alert = 0
    self.count = 0 
    self.timer = 0

    plays = true

end

function PlayState:enter(params, difficulty, speed)

    self.difficulty = params.difficulty
    self.speed = params.speed
    self.highScores = params.highScores
    
    Timer.tween(1, {
        [self] = {transitionAlpha = 0}
    })
    :finish(function()
    end)

    self.fireHero = FireHero {
        
        texture = 'fire_hero',
        x = 20, 
        y = 70,
        width = 14,
        height = 29,

        stateMachine = StateMachine {

            ['idle'] = function() return FireHeroIdleState(self.fireHero) end,

        }, 
    }
    
    self.fireHero:changeState('idle')

    self.monster = Monster {

        texture = 'eye-monster',
        x = 400, 
        y = 60,
        width = 16, 
        height = 16,

        stateMachine = StateMachine {

            ['moving'] = function() return MonsterMovingState(self.fireHero, self.monster) end,
            ['hurt'] = function() return MonsterHurtState(self.fireHero, self.monster) end,
            ['Mattack'] = function() return MonsterAttackState(self.fireHero, self.monster) end,
            ['afterHurt'] = function() return MonsterAfterHurtState(self.fireHero, self.monster) end
        
        },
    }

    self.monster:changeState('moving', {

        difficulty = self.difficulty, 
        speed = self.speed,
        timers = self.count

    })

    self.attack = Attack {

        texture = 'fire_wave',
        x = 115, 
        y = 35,
        width = 16, 
        height = 16,
        
        stateMachine = StateMachine {
            ['fireWave'] = function() return FireWaveState(self.fireHero, self.monster, self.attack) end,
            ['fireBall'] = function() return FireBallState(self.fireHero, self.monster, self.attack) end,
            ['noAttack'] = function() return NoAttackState(self.fireHero, self.monster, self.attack) end
            
        },
    }
    self.attack:changeState('noAttack')

    gSounds['music']:stop()
    gSounds['music2']:setLooping(true)
    gSounds['music2']:play()
    
    chooseWord()
    letters = 0

end


function PlayState:update(dt)
    
    Timer.update(dt)

    self.fireHero:update(dt)
    self.monster:update(dt)
    self.attack:update(dt)

    if love.keyboard.wasPressed('escape') then

        gStateMachine:change('continue', {
            highScores = self.highScores
        })

        gSounds['click']:play()
        gSounds['fire']:stop()

        chooseWord()

    end

    self.timer = self.timer + dt

    if self.timer > 1 then
        
        self.timer = self.timer % 1

        -- THE TIMER WON'T START WHILE IT IS STILL TRANSITIONING
        if self.transitionAlpha == 0 then

            self.count = self.count + 1
            
        end
        

        if self.monster.x < 150 then

            alerts = true
            near = true

            Timer.every(0.5, function()

                if near then
                    
                    Timer.tween(0.4, {
                        [self] = {alert = 100}
                    }):finish(function()
                        near = false
                    end)

                else

                    Timer.tween(0.4, {
                        [self] = {alert = 0}
                    }):finish(function()
                        near = true
                    end)

                end

            end)

        elseif self.monster.x > 149 then

            alerts = false

        end

    end

    if gameOver == true then 

        gStateMachine:change('gameOver', {
            count = self.count,
            difficulty = self.difficulty,
            speed = self.speed,
            highScores = self.highScores
        })

        gameOver = false

    end

end

function PlayState:render()

    self.fireHero:render()
    self.monster:render()
    self.attack:render()

    love.graphics.setFont(gFonts['xs'])
    love.graphics.printf('Type quickly! Push the monster as long as you can!', 0, 15, WINDOW_WIDTH / 2 - 130 , 'center')

    -- DRAW GOAL WORD
    love.graphics.setFont(gFonts['small'])
   
    love.graphics.printf(fullString, 0, VIRTUAL_HEIGHT / 2 + 73, VIRTUAL_WIDTH, 'center')

    halfString = currentCharIndex == 1 and '' or fullString:sub(1, currentCharIndex - 1)
    love.graphics.printf(halfString, 0, VIRTUAL_HEIGHT / 2 + 102, VIRTUAL_WIDTH - gFonts['small']:getWidth(fullString:sub(halfString:len() + 1, fullString:len())), 'center')
    love.graphics.printf(tostring(self.count), 0, 5, VIRTUAL_WIDTH + 450, 'center')
    
    if cursor then

        love.graphics.print('|', VIRTUAL_WIDTH / 2 - gFonts['small']:getWidth(fullString) / 2 + gFonts['small']:getWidth(halfString), VIRTUAL_HEIGHT - 43)
    
    end

    love.graphics.setFont(gFonts['xs'])
    
    if alerts then
    
        love.graphics.setColor(100, 0, 0, self.alert)
        love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    
    end

    -- TRANSITIONING
    love.graphics.setColor(0, 0, 0, self.transitionAlpha)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    love.graphics.setColor(0, 0, 0, self.transitionAlphas)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    
end
