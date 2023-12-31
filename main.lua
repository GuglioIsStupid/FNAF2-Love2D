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

    oprint = print

    for k, v in pairs(love.graphics) do -- i'm so sick of typing love.graphics, so i'm making all the functions global (i know it's bad practice, but i don't care)
        _G[k] = v
    end

    setDefaultFilter("nearest", "nearest")

    Gamestate.switch(states.menu)
end

function love.update(dt)
    -- fps cap is 60
    if dt < 1/60 then
        love.timer.sleep(1/60 - dt)
    end
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