--[[
    ScoreState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]

ScoreState = Class{__includes = BaseState}

local medal_one = love.graphics.newImage('assets/sprites/medal_one.png')
local medal_two = love.graphics.newImage('assets/sprites/medal_two.png')
local medal_three = love.graphics.newImage('assets/sprites/medal_three.png')

--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
function ScoreState:enter(params)
    self.score = params.score
    self.image = medal_three
end

function ScoreState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end

    if self.score >= 4 then
        self.image = medal_one
    elseif self.score >= 2 then
        self.image = medal_two
    elseif self.score >= 0 then
        self.image = medal_three
    end

end

function ScoreState:render()
    -- simply render the score to the middle of the screen
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Oof! You lost!', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')

    love.graphics.draw(self.image, VIRTUAL_WIDTH/2 - (self.image:getWidth() * 0.12)/2, 118, 0, 0.12, 0.12)
    
    love.graphics.printf('Press Enter to Play Again!', 0, 160, VIRTUAL_WIDTH, 'center')
end