-- MARIO UPDATE: PLAYED UPON COLLIDING WITH THE FLAG JUST TO IMITATE THE ORIGINAL MARIO GAME
PlayerPausedState = Class{__includes = BaseState}

function PlayerPausedState:init(player)
    self.player = player

    self.animation = Animation {
        frames = {1},
        interval = 1
    }

    self.player.currentAnimation = self.animation
end

function PlayerPausedState:update(dt)
end