PlayState = Class{__includes = BaseState}


function PlayState:enter(params)

    self.fireHero = FireHero({
        x = 20, y = 70,
        width = 14, height = 29,
        texture = 'fire_hero',
        stateMachine = StateMachine {
            ['idle'] = function() return FireHeroIdleState(self.fireHero) end,
        },
        
    })
    self.fireHero:changeState('idle')

        self.monster = Monster {
            texture = 'eye-monster',
            x = 350, y = 100,
            width = 16, height = 16,
            stateMachine = StateMachine {
                ['moving'] = function() return MonsterMovingState(self.fireHero, self.monster) end,
            }
            }
            self.monster:changeState('moving')
end

function PlayState:update(dt)
    
    Timer.update(dt)

    -- update fireHero and level
    self.fireHero:update(dt)
    self.monster:update(dt)

    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('begin', {
        })
        gSounds['click']:play()
        gSounds['fire']:stop()
    end

end

function PlayState:render()

    self.fireHero:render()
    self.monster:render()
    love.graphics.setFont(gFonts['xs'])
    love.graphics.printf('Type quickly! Defeat the monster before it gets you.', 0, 15, WINDOW_WIDTH / 2 - 130 , 'center')

    -- DRAW GOAL WORD
    love.graphics.setFont(gFonts['small'])
    love.graphics.printf('eugene', 0, 220, WINDOW_WIDTH / 2 - 130 , 'center')
    love.graphics.setFont(gFonts['xs'])

end
