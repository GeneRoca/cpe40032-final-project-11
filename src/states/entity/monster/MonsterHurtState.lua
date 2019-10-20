MonsterHurtState = Class{__includes = BaseState}

function MonsterHurtState:init(fireHero, monster)

    self.fireHero = fireHero
    self.monster = monster
    self.animation = Animation {

        frames = {1, 2, 3, 4, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59},
        interval = 0.25

    }

    self.monster.currentAnimation = self.animation

    self.count = 2
    self.timer = 0

    self.letter = letters

    gSounds['monster_attack']:stop()
end

function MonsterHurtState:enter(params, difficulty, speed)

    self.difficulty = params.difficulty
    self.speed = params.speed
    self.timers = params.timers

end


function MonsterHurtState:update(dt)

    self.monster.currentAnimation:update(dt)
    
    if self.difficulty == 3 and self.difficulty == 2 then

        self.monster.x = self.monster.x + (self.letter * 5) * dt

    else
    
        self.monster.x = self.monster.x + (self.letter + (self.letter / 2)) * dt
    
    end
    
    self.timer = self.timer + dt

    if self.timer > COUNTDOWN_TIME then

        self.timer = self.timer % COUNTDOWN_TIME
        self.count = self.count - 1

        if self.count == 0 then

            self.monster:changeState('moving', {

                difficulty = self.difficulty,
                speed = self.speed,
                letter = self.letter,
                
                gSounds['monster_hurt']:play()

            })

        end

    end

    if attacks == true then
        
        self.monster:changeState('hurt', {

            difficulty = self.difficulty,
            speed = self.speed

        })
        
    end


end