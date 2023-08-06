function love.load()
    Gamestate = require "libs.gamestate"
    Timer = require "libs.timer" 

    states = {
        menu = require "states.menu",
        game = require "states.game"
    }

    save = {
        night = 1
    }

    Gamestate.switch(states.menu)
end

function love.update(dt)
    Timer.update(dt)
    Gamestate.update(dt)
end

function love.mousepressed(x, y, button)
    Gamestate.mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)
    Gamestate.mousereleased(x, y, button)
end

function love.mousemoved(x, y, dx, dy)
    Gamestate.mousemoved(x, y, dx, dy)
end

function love.draw()
    Gamestate.draw()
end