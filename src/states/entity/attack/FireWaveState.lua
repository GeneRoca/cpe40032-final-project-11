FireWaveState = Class{__includes = BaseState}

function FireWaveState:init(fireHero, monster, attack)
    self.fireHero = fireHero
    self.monster = monster
    self.attack = attack
    self.animation = Animation {
        frames = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18},
        interval = 0.1
    }
    self.attack.currentAnimation = self.animation

    self.count = 2
    self.timer = 0

end

function FireWaveState:update(dt)
    self.attack.currentAnimation:update(dt)

    -- TO PLAY THE ANIMATION ONCE
    self.timer = self.timer + dt

    if self.timer > COUNTDOWN_TIME then
        self.timer = self.timer % COUNTDOWN_TIME
        self.count = self.count - 1

        if self.count == 0 then
            self.attack:changeState('noAttack')
        end
    end
end