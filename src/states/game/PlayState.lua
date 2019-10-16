PlayState = Class{__includes = BaseState}


function PlayState:init()
    self.transitionAlpha = 255
    self.transitionAlphas = 0
    self.alert = 0
end

function PlayState:enter(params, difficulty, speed)
    self.difficulty = params.difficulty
    self.speed = params.speed
    Timer.tween(1, {
        [self] = {transitionAlpha = 0}
    })
    :finish(function()
    end)
    self.count = 0

    self.fireHero = FireHero {
        x = 20, y = 70,
        width = 14, height = 29,
        texture = 'fire_hero',
        stateMachine = StateMachine {
            ['idle'] = function() return FireHeroIdleState(self.fireHero) end,
        }, 
    }
    self.fireHero:changeState('idle')

    self.monster = Monster {
        texture = 'eye-monster',
        x = 400, y = 100,
        width = 16, height = 16,
        stateMachine = StateMachine {
            ['moving'] = function() return MonsterMovingState(self.fireHero, self.monster) end,
            ['hurt'] = function() return MonsterHurtState(self.fireHero, self.monster) end,
        
        },
    }
    self.monster:changeState('moving', {
        difficulty = self.difficulty, 
        speed = self.speed
    })

    self.attack = Attack {
        texture = 'fire_wave',
        x = 110, y = 40,
        width = 16, height = 16,
        stateMachine = StateMachine {
            ['fireWave'] = function() return FireWaveState(self.fireHero, self.monster, self.attack) end,
            ['noAttack'] = function() return NoAttackState(self.fireHero, self.monster, self.attack) end
        },
    }
    self.attack:changeState('noAttack')

    self.timer = 0
    
end

function PlayState:update(dt)
    
    Timer.update(dt)

    -- update fireHero and level
    self.fireHero:update(dt)
    self.monster:update(dt)
    self.attack:update(dt)

    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('continue', {
        })
        gSounds['click']:play()
        gSounds['fire']:stop()
        chooseWord()
    end

    self.timer = self.timer + dt

    if self.timer > 1 then
        
        self.timer = self.timer % 1
        -- THE TIMER WON'T START WHILE IT STILL TRANSITIONING
        if self.transitionAlpha == 0 then
            self.count = self.count + 1
        end
        
        if self.monster.x <= 70 then
            Timer.tween(1.5, {
                [self] = {transitionAlphas = 255}
            }):finish(function()
            gStateMachine:change('gameOver', {
                difficulty = self.difficulty,
                speed = self.speed
            })
            end)
            
            gSounds['fire']:stop()
            
        end

        if self.monster.x < 200 then
            Timer.every(1, function()
                if near then
                    Timer.tween(0.5, {
                        [self] = {alert = 100}
                    }):finish(function()
                    end)
                    near = false
                elseif not near then
                    Timer.tween(0.5, {
                        [self] = {alert = 0}
                    }):finish(function()
                    end)
                    near = true
                end
            end)
        end
    end
end

function PlayState:render()

    self.fireHero:render()
    self.monster:render()
    self.attack:render()
    love.graphics.setFont(gFonts['xs'])
    love.graphics.printf('Type quickly! Defeat the monster before it gets you.', 0, 15, WINDOW_WIDTH / 2 - 130 , 'center')

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
    
    love.graphics.setColor(100, 0, 0, self.alert)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

    love.graphics.setColor(0, 0, 0, self.transitionAlpha)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    love.graphics.setColor(0, 0, 0, self.transitionAlphas)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    

end
