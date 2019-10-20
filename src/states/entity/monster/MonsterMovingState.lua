MonsterMovingState = Class{__includes = BaseState}

function MonsterMovingState:init(fireHero, monster)

    self.fireHero = fireHero
    self.monster = monster
    self.animation = Animation {

        frames = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18},
        interval = 0.15

    }
    self.monster.currentAnimation = self.animation
    
    Timer.every(5, function()

        self.speed = self.speed + self.difficulty
    
    end)

end

function MonsterMovingState:enter(params, difficulty, speed, letter)
    
    self.difficulty = params.difficulty
    self.speed = params.speed
    self.letter = params.letter

    letters = 0
    
end

function MonsterMovingState:update(dt)

    self.monster.currentAnimation:update(dt)    

    self.speed = self.speed + speeds

    speeds = 0

    self.monster.x = self.monster.x - self.speed * dt

    if attacks == true then
        
        self.monster:changeState('hurt', {

            difficulty = self.difficulty,
            speed = self.speed,

        })
        
    end

    if self.monster.x <= 5 then
        
        self.monster:changeState('Mattack', {

           
            difficulty = self.difficulty,
            speed = self.speed,

        })
                
        gSounds['fire']:stop()
        
    end

end