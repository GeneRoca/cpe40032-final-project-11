NoAttackState = Class{__includes = BaseState}

function NoAttackState:init(fireHero, monster, attack)
    self.fireHero = fireHero
    self.monster = monster
    self.attack = attack
    self.animation = Animation {
        frames = {18},
        interval = 0.15
    }
    self.attack.currentAnimation = self.animation

end

function NoAttackState:update(dt)
    self.attack.currentAnimation:update(dt)

    if attacks == true then
        
        gSounds['fireBall']:play()
        self.attack:changeState('fireWave')
    end

    attacks = false
end