FireBallState = Class{__includes = BaseState}

function FireBallState:init(fireHero, monster, attack)

    self.fireHero = fireHero
    self.monster = monster
    self.attack = attack
    self.animation = Animation {

        frames = {23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 41, 41, 41, 41, 41, 41, 41, 41, 41, 41, 41, 41, 41, 41, 41, 41, 41, 41, 41, 41, 41},
        interval = 0.08

    }

    self.attack.currentAnimation = self.animation

    self.count = 2
    self.timer = 0

end

function FireBallState:enter()

    gSounds['fireWhoosh']:play()

end

function FireBallState:update(dt)
    
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