NoAttackState = Class{__includes = BaseState}

function NoAttackState:init(fireHero, monster, attack)

    self.fireHero = fireHero
    self.monster = monster
    self.attack = attack
    self.animation = Animation {

        frames = {17},
        interval = 0.15

    }

    self.attack.currentAnimation = self.animation

end

function NoAttackState:enter()

    gSounds['fireBall']:stop()
    gSounds['fireWhoosh']:stop()

end

function NoAttackState:update(dt)

    self.attack.currentAnimation:update(dt)

    if attacks == true and self.monster.x < 200 then
        
        self.attack:changeState('fireWave')
    
    elseif attacks == true and self.monster.x > 199 then
        
        self.attack:changeState('fireBall')

    end

    attacks = false
    
end