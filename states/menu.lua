local menu = {}
local olans = love.audio.newSource
function love.audio.newSource(path, type)
    local type = type or "static"
    return olans(path, type)
end
function menu:enter()
    self.assets = {
        basemenu = {
            img = newImage("assets/images/menu/basemenu.png"),
            spritesheet = false
        },
        bonniemenu = {
            img = newImage("assets/images/menu/bonniemenu.png"),
            spritesheet = false
        },
        chicamenu = {
            img = newImage("assets/images/menu/chicamenu.png"),
            spritesheet = false
        },
        freddymenu = {
            img = newImage("assets/images/menu/freddymenu.png"),
            spritesheet = false
        },

        continue = {
            img = newImage("assets/images/menu/continue.png"),
            spritesheet = false
        },
        newgame = {
            img = newImage("assets/images/menu/newgame.png"),
            spritesheet = false
        },
        nightword = {
            img = newImage("assets/images/menu/nightword.png"),
            spritesheet = false
        },
        nightnumber = {
            img = newImage("assets/images/menu/nightnumber.png"),
            spritesheet = true,
            frameByWidth = true,
            frameWidth = 14,
            frameHeight = 17,

            frames = {},
            curFrame = 2,
            speed = 0,
        },
        logo = {
            img = newImage("assets/images/menu/logo.png"),
            spritesheet = false,
            x = 25,
            y = 25
        },
        selection = {
            img = newImage("assets/images/menu/selection.png"),
            spritesheet = false,
            x = 25,
            y = 425
        },

        static = {
            img = newImage("assets/images/menu/static.png"),
            spritesheet = true,
            frameByWidth = false,
            frameWidth = 1024,
            frameHeight = 768,

            frames = {},
            curFrame = 1,
            speed = 99,
        },

        staticaudio = {
            spritesheet = false,
            audio = love.audio.newSource("assets/audio/static2.wav"),
            play = function(self)
                self.audio:play()
            end,
            stop = function(self)
                self.audio:stop()
            end
        },
        menutheme = {
            spritesheet = false,
            audio = love.audio.newSource("assets/audio/The_Sand_Temple_Loop_G.wav"),
            play = function(self)
                self.audio:play()
            end,
            stop = function(self)
                self.audio:stop()
            end
        },
    }

    self.assets.menutheme.audio:setLooping(true)
    self.assets.menutheme:play()
    self.assets.staticaudio:play()

    -- set up the frames for the spritesheets
    for k, v in pairs(self.assets) do
        if v.spritesheet then
            if v.frameByWidth then
                for i = 1, v.img:getWidth() / v.frameWidth do
                    table.insert(v.frames, newQuad((i - 1) * v.frameWidth, 0, v.frameWidth, v.frameHeight, v.img:getWidth(), v.img:getHeight()))
                end
            else
                for i = 1, v.img:getHeight() / v.frameHeight do
                    table.insert(v.frames, newQuad(0, (i - 1) * v.frameHeight, v.frameWidth, v.frameHeight, v.img:getWidth(), v.img:getHeight()))
                end
            end
        end
    end

    staticAlpha = 1
    curbasemenu = 1

    function determineRndMenu()
        -- determine the curbasemenu
        local rnd = love.math.random(1, 100)
        if rnd == 2 then 
            curbasemenu = 2
        elseif rnd == 3 then
            curbasemenu = 3
        elseif rnd == 4 then
            curbasemenu = 4
        else
            curbasemenu = 1
        end

        Timer.script(function(w)
            w(0.1)
            determineRndMenu()
        end)
    end

    determineRndMenu()
end

function menu:update(dt)
    -- update the frames for the spritesheets
    for k, v in pairs(self.assets) do
        if v.spritesheet then
            v.curFrame = v.curFrame + v.speed * dt
            if v.curFrame >= #v.frames + 1 then
                v.curFrame = 1
            end
        end
    end
end

function menu:mousepressed(x, y, button)
    if self.assets.selection.y == 425 then -- newgame
        -- set the state to game
        Gamestate.switch(states.game, 1)
    elseif self.assets.selection.y == 500 then -- continue
        -- set the state to game
        Gamestate.switch(states.game, save.night)
    end

    self.assets.menutheme:stop()
    self.assets.staticaudio:stop()
end

function menu:mousereleased(x, y, button)

end

function menu:mousemoved(x, y, dx, dy)
    -- if mouse is hovering over continue
    if x >= 50 and x <= 50 + self.assets.continue.img:getWidth() and y >= 500 and y <= 500 + self.assets.continue.img:getHeight() then
        -- set selected x and y to continue (x is x - 50, y is y)
        self.assets.selection.x = 25
        self.assets.selection.y = 500
    -- if mouse is hovering over new game
    elseif x >= 50 and x <= 50 + self.assets.newgame.img:getWidth() and y >= 425 and y <= 425 + self.assets.newgame.img:getHeight() then
        self.assets.selection.x = 25
        self.assets.selection.y = 425
    end
end

function menu:draw()
    draw(
        curbasemenu == 1 and self.assets.basemenu.img or 
        curbasemenu == 2 and self.assets.bonniemenu.img or 
        curbasemenu == 3 and self.assets.chicamenu.img or 
        curbasemenu == 4 and self.assets.freddymenu.img, 
        0, 
        0
    )
    
    -- set blend to add
    setBlendMode("add", "alphamultiply")
    draw(self.assets.static.img, self.assets.static.frames[math.floor(self.assets.static.curFrame)], 0, 0)
    -- reset blend to alpha
    setBlendMode("alpha")
    setColor(1, 1, 1, 1)

    draw(self.assets.continue.img, 75, 500)
    draw(self.assets.newgame.img, 75, 425)
    draw(self.assets.selection.img, self.assets.selection.x, self.assets.selection.y)

    if self.assets.selection.y == 500 then
        -- continue is selected
        draw(self.assets.nightword.img, 75, 550)
        draw(self.assets.nightnumber.img, self.assets.nightnumber.frames[save.night+1], 75 + self.assets.nightword.img:getWidth() + 10, 552)
    end

    -- draw the logo
    draw(self.assets.logo.img, self.assets.logo.x, self.assets.logo.y)
end

return menu