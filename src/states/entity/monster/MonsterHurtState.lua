MonsterHurtState = Class{__includes = BaseState}

function MonsterHurtState:init(fireHero, monster)
    self.fireHero = fireHero
    self.monster = monster
    
    self.animation = Animation {
        frames = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18},
        interval = 0.15
    }
    self.monster.currentAnimation = self.animation

    self.count = 2
    self.timer = 0
end

function MonsterHurtState:enter(params, difficulty, speed)
    self.difficulty = params.difficulty
    self.speed = params.speed
end


function MonsterHurtState:update(dt)

    self.monster.currentAnimation:update(dt)
        
    self.monster.x = self.monster.x + (letters + 20) * dt

    letters = 0

    self.timer = self.timer + dt

    if self.timer > COUNTDOWN_TIME then
        self.timer = self.timer % COUNTDOWN_TIME
        self.count = self.count - 1

        if self.count == 0 then
            self.monster:changeState('moving', {
                difficulty = self.difficulty,
                speed = self.speed

            })
        end
    end

end