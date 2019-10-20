MonsterAttackState = Class{__includes = BaseState}

function MonsterAttackState:init(fireHero, monster)

    self.fireHero = fireHero
    self.monster = monster
    self.animation = Animation {

        frames = {19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18},
        interval = 0.09

    }

    self.monster.currentAnimation = self.animation

    self.timer = 0
    self.count = 1
    
    gSounds['monster_attack']:play()

end

function MonsterAttackState:enter(params, difficulty, speed)

    self.difficulty = params.difficulty
    self.speed = params.speed

end


function MonsterAttackState:update(dt)

    self.monster.currentAnimation:update(dt)    

    self.timer = self.timer + dt

    if self.timer > COUNTDOWN_TIME then

        self.timer = self.timer % COUNTDOWN_TIME
        self.count = self.count - 1

        if self.count == 0 then

            gameOver = true

        end

    end

    if attacks == true then

        self.monster:changeState('hurt', {

            difficulty = self.difficulty,
            speed = self.speed,
            
        })

    end

end


