local game = {}
local function lerp(a, b, t)
    return a + (b - a) * t
end
local function fpsLerp(a, b, dt, t)
    return a + (b - a) * (dt / t)
end

local function campanFunc()
    Timer.tween(3, game, {campan = -300}, "linear", function()
        Timer.after(5, function()
            Timer.tween(3, game, {campan = 0}, "linear", function()
                Timer.after(5, campanFunc)
            end)
        end)
    end)
end

function game:enter(night)
    self.ai = {
        -- All fnaf 2 animatronics ai levels
        tfreddy = 0,
        tbonnie = 0,
        tchica = 0,
        
        mangle = 0,
        balloonboy = 0,
        marionette = 0,

        wfreddy = 0,
        wbonnie = 0,
        wchica = 0,
        wfoxy = 0,
        wgfreddy = 0,
    }
    self.timers = {
        tfreddy = nil,
        tbonnie = nil,
        tchica = nil,

        mangle = nil,
        balloonboy = nil,
        marionette = nil,

        wfreddy = nil,
        wbonnie = nil,
        wchica = nil,
        wfoxy = nil,
        wgfreddy = nil,
    }

    self.battery = 100

    self.positions = {
        -- 0 is stage
        tfreddy = 0,
        tbonnie = 0,
        tchica = 0,

        mangle = 0,
        balloonboy = 0,
        marionette = 0,

        wfreddy = 0,
        wbonnie = 0,
        wchica = 0,
        wfoxy = 0,
        wgfreddy = 0,
    }
    self.camsUp = false

    self.office = {
        normal = {
            img = newImage("assets/images/game/office.png"),
            spritesheet = false,
            x = 300,
            y = 0
        },
        leftlight = {
            img = newImage("assets/images/game/office-leftlight.png"),
            spritesheet = false,
            x = 300,
            y = 0
        },
        rightlight = {
            img = newImage("assets/images/game/office-rightlight.png"),
            spritesheet = false,
            x = 300,
            y = 0
        },
        middlelight = {
            img = newImage("assets/images/game/office-middlelight.png"),
            spritesheet = false,
            x = 300,
            y = 0
        },

        draw = function()
            draw(self.office.normal.img, 0, 0, 0, 1, 1, self.office.normal.x, self.office.normal.y)
            if self.lighton and officeOffset > 200 then
                draw(self.office.leftlight.img, 0, 0, 0, 1, 1, self.office.leftlight.x, self.office.leftlight.y)
            elseif self.lighton and officeOffset < -225 then
                draw(self.office.rightlight.img, 0, 0, 0, 1, 1, self.office.rightlight.x, self.office.rightlight.y)
            elseif self.lighton then
                draw(self.office.middlelight.img, 0, 0, 0, 1, 1, self.office.middlelight.x, self.office.middlelight.y)
            end
        end
    }

    self.assets = {
        desk = {
            img = newImage("assets/images/game/desk.png"),
            spritesheet = true,
            frameByWidth = false,
            frameWidth = 851,
            frameHeight = 435,

            frames = {},
            curFrame = 1,
            speed = 100,
        },
        mapbutton = {
            img = newImage("assets/images/game/mapbutton.png"),
            spritesheet = false,
            x = 505,
            y = getHeight() - 50,
            movedOut = false
        },
        maskbutton = {
            img = newImage("assets/images/game/maskbutton.png"),
            spritesheet = false,
            x = 15,
            y = getHeight() - 50,
            movedOut = false
        },
        flashlight = {
            spritesheet = false,
            img = newImage("assets/images/game/flashlight.png"),
        },
        battery = {
            spritesheet = true,
            img = newImage("assets/images/game/battery.png"),
            frameByWidth = true,
            frameWidth = 100,
            frameHeight = 50,
            
            frames = {},
            curFrame = 1,
            speed = 0,
            maxFrames = 6
        },
        mask = {
            img = newImage("assets/images/game/mask.png"),
            spritesheet = false,
            x = 0,
            y = 0,
            ox = 0,
            oy = 0,
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
            alpha = 0.5
        },
        camblip = {
            img = newImage("assets/images/game/camblip.png"),
            spritesheet = true,
            frameByWidth = false,
            frameWidth = 1024,
            frameHeight = 768,

            frames = {},
            curFrame = 1,
            speed = 50
        },
        camflip = {
            img = newImage("assets/images/game/camflip.png"),
            spritesheet = true,
            frameByWidth = false,
            frameWidth = 1024,
            frameHeight = 768,
            draw = false,

            frames = {},
            curFrame = 1,
            speed = 50,
            paused = true, -- is paused
            pauseOnFinish = true, -- pause when animation is finished
            animFlip = true -- goes backwards instead of forwards
        },
        danger = {
            img = newImage("assets/images/game/danger.png"),
            spritesheet = true,
            frameByWidth = true,
            maxFrames = 2,
            frameWidth = 57,
            frameHeight = 49,

            frames = {},
            curFrame = 1,
            speed = 5,
        },
        musicboxcounter = {
            img = newImage("assets/images/game/musicbox-counter.png"),
            spritesheet = true,
            frameByWidth = true,
            maxFrames = 22,
            frameWidth = 54,
            frameHeight = 54,

            frames = {},
            curFrame = 1,
            speed = 0
        },
        musicbutton = {
            img = newImage("assets/images/game/musicbutton.png"),
            spritesheet = false,
        },
        musicbuttontext = {
            img = newImage("assets/images/game/musicbutton-text.png"),
            spritesheet = false,
        },
        rec = {
            img = newImage("assets/images/game/rec.png"),
            spritesheet = true,
            frameByWidth = true,
            maxFrames = 2,
            frameWidth = 47,
            frameHeight = 47,

            frames = {},
            curFrame = 1,
            speed = 2,
        },

        leftlight = {
            img = newImage("assets/images/game/leftlight.png"),
            spritesheet = false,
            x = 0,
            y = 0,
            ox = 0,
            oy = 0,
        },
        rightlight = {
            img = newImage("assets/images/game/rightlight.png"),
            spritesheet = false,
            x = 0,
            y = 0,
            ox = 0,
            oy = 0,
        },
        leftlighton = {
            img = newImage("assets/images/game/leftlight-on.png"),
            spritesheet = false,
            x = 0,
            y = 0,
            ox = 0,
            oy = 0,
        },
        rightlighton = {
            img = newImage("assets/images/game/rightlight-on.png"),
            spritesheet = false,
            x = 0,
            y = 0,
            ox = 0,
            oy = 0,
        },


        deepbreathing = {
            spritesheet = false, -- is audio
            audio = love.audio.newSource("assets/audio/deepbreaths.wav"),
            play = function(self)
                self.audio:play()
            end,
            stop = function(self)
                self.audio:stop()
            end
        },
        maskon = {
            spritesheet = false,
            audio = love.audio.newSource("assets/audio/FENCING_42_GEN-HDF10953.wav"),
            play = function(self)
                self.audio:play()
            end,
            stop = function(self)
                self.audio:stop()
            end
        },
        maskoff = {
            spritesheet = false,
            audio = love.audio.newSource("assets/audio/FENCING_43_GEN-HDF10954.wav"),
            play = function(self)
                self.audio:play()
            end,
            stop = function(self)
                self.audio:stop()
            end
        },
        fansound = {
            spritesheet = false,
            audio = love.audio.newSource("assets/audio/fansound.wav"),
            play = function(self)
                self.audio:play()
            end,
            stop = function(self)
                self.audio:stop()
            end
        },

        call = {
            spritesheet = false,
            audio = (
                save.night == 1 and love.audio.newSource("assets/audio/call 1b.wav") or
                save.night == 2 and love.audio.newSource("assets/audio/call 2b.wav") or
                save.night == 3 and love.audio.newSource("assets/audio/call 3b.wav") or
                save.night == 4 and love.audio.newSource("assets/audio/call 4b.wav") or
                save.night == 5 and love.audio.newSource("assets/audio/call 5b.wav") or
                save.night == 6 and love.audio.newSource("assets/audio/call 6b.wav")
            ),
            play = function(self)
                self.audio:play()
            end,
            stop = function(self)
                self.audio:stop()
            end
        }
    }

    self.lighton = false

    self.campan = 0
    campanFunc()

    self.camButtons = {
        camback = newImage("assets/images/game/camback.png"),
        cambackon = newImage("assets/images/game/cambackon.png"),
        camsOutline = newImage("assets/images/game/camsoutline.png"),
        map = newImage("assets/images/game/map.png"),

        cam1 = {
            x = 0,
            y = 0,
            img = newImage("assets/images/game/cam1.png"),
            selected = false,
        },
        cam2 = {
            x = 0,
            y = 0,
            img = newImage("assets/images/game/cam2.png"),
            selected = false,
        },
        cam3 = {
            x = 0,
            y = 0,
            img = newImage("assets/images/game/cam3.png"),
            selected = false,
        },
        cam4 = {
            x = 0,
            y = 0,
            img = newImage("assets/images/game/cam4.png"),
            selected = false,
        },
        cam5 = {
            x = 0,
            y = 0,
            img = newImage("assets/images/game/cam5.png"),
            selected = false,
        },
        cam6 = {
            x = 0,
            y = 0,
            img = newImage("assets/images/game/cam6.png"),
            selected = false,
        },
        cam7 = {
            x = 0,
            y = 0,
            img = newImage("assets/images/game/cam7.png"),
            selected = false,
        },
        cam8 = {
            x = 580,
            y = 415,
            img = newImage("assets/images/game/cam8.png"),
            selected = false,
        },
        cam9 = {
            x = 885,
            y = 390,
            img = newImage("assets/images/game/cam9.png"),
            selected = false,
        },
        cam10 = {
            x = 0,
            y = 0,
            img = newImage("assets/images/game/cam10.png"),
            selected = false,
        },
        cam11 = {
            x = 0,
            y = 0,
            img = newImage("assets/images/game/cam11.png"),
            selected = false,
        },
        cam12 = {
            x = 0,
            y = 0,
            img = newImage("assets/images/game/cam12.png"),
            selected = false,
        },
    }

    self.cams = {
        cam1 = {

        },
        cam2 = {

        },
        cam3 = {

        },
        cam4 = {

        },
        cam5 = {

        },
        cam6 = {

        },
        cam7 = {

        },
        cam8 = {
            normal = newImage("assets/images/game/partsservice.png"),
            light = newImage("assets/images/game/partsservice-light.png"),
            sflight = newImage("assets/images/game/partsservice-sf-light.png"),
            foxylight = newImage("assets/images/game/partsservice-foxy-light.png"),
            wbgonelight = newImage("assets/images/game/partsservice-wb-gone-light.png"),
            wbwcgonelight = newImage("assets/images/game/partsservice-wbwc-gone-light.png"),
            wbwcwfgonelight = newImage("assets/images/game/partsservice-wbwcwf-gone-light.png"),

            draw = function()
                if self.lighton then
                    love.graphics.draw(self.cams[self.curcam].light, 0, 0)
                else
                    love.graphics.draw(self.cams[self.curcam].normal, 0, 0)
                end
            end
        },
        cam9 = {
            normal = newImage("assets/images/game/stage.png"),
            light = newImage("assets/images/game/stage-light.png"),
            tbgone = newImage("assets/images/game/stage-tbgone.png"),
            tbtcgone = newImage("assets/images/game/stage-tbtcgone.png"),
            tbtcwfgone = newImage("assets/images/game/stage-tbtctf-gone.png"),

            draw = function()
                if self.lighton then
                    love.graphics.draw(self.cams[self.curcam].light, 0, 0)
                else
                    love.graphics.draw(self.cams[self.curcam].normal, 0, 0)
                end
            end
        },
        cam10 = {

        },
        cam11 = {

        },
        cam12 = {

        },
    }


    self.curcam = "cam9"
    self.assets.fansound.audio:setLooping(true)
    self.assets.fansound:play()

    -- set up the frames for the spritesheets
    for k, v in pairs(self.assets) do
        if v.spritesheet then
            if v.maxFrames then
                -- if there is a max frame, then only add that many frames
                if v.frameByWidth then
                    for i = 1, v.maxFrames do
                        table.insert(v.frames, newQuad((i - 1) * v.frameWidth, 0, v.frameWidth, v.frameHeight, v.img:getWidth(), v.img:getHeight()))
                    end
                else
                    for i = 1, v.maxFrames do
                        table.insert(v.frames, newQuad(0, (i - 1) * v.frameHeight, v.frameWidth, v.frameHeight, v.img:getWidth(), v.img:getHeight()))
                    end
                end
            else
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

            if v.animFlip then
                v.curFrame = #v.frames
            end
        end
    end

    officeOffset = 0

    Timer.after(2, function()
        self.assets.call.audio:play()
    end)
end

function game:update(dt)
    -- update the frames for the spritesheets
    for k, v in pairs(self.assets) do
        if v.spritesheet and not v.paused then
            if not v.animFlip then
                v.curFrame = v.curFrame + v.speed * dt
                if v.curFrame >= #v.frames then
                    if not v.pauseOnFinish then
                        v.curFrame = 1
                    else
                        v.curFrame = #v.frames
                        v.paused = true
                    end
                end
            else
                v.curFrame = v.curFrame - v.speed * dt
                if v.curFrame <= 1 then
                    if not v.pauseOnFinish then
                        v.curFrame = #v.frames
                    else
                        v.curFrame = 1
                        v.paused = true
                    end
                end
            end
        end
    end

    for i, v in ipairs(self.ai) do
        -- if ai doesn't equal 0 and timers are nil
        if v ~= 0 and self.timers[i] == nil then
            -- set timers
            self.timers[i] = Timer.after(love.math.random(3, 5), function()
                self.ai[i] = 0
                self.timers[v] = nil

                -- CHECK IF AI SHOULD MOVE!
                local ai = self.ai[i]
                local rnd = love.math.random(1,20)
                if rnd <= ai then
                    -- can move
                    self.positions[i] = self.positions[i] + 1
                end

                self.timers[i] = nil
            end)
        end
    end

    local mx, my = love.mouse.getPosition()
    if mx < 300 then
        officeOffset = officeOffset + 800 * dt
    elseif mx > getWidth() - 300 then
        officeOffset = officeOffset - 800 * dt
    end

    if officeOffset > 300 then
        officeOffset = 300
    elseif officeOffset < -275 then
        officeOffset = -275
    end

    -- if mouse hovers over maskbutton
    if not self.camsUp then
        if mx > self.assets.maskbutton.x and mx < self.assets.maskbutton.x + self.assets.maskbutton.img:getWidth() and my > self.assets.maskbutton.y and my < self.assets.maskbutton.y + self.assets.maskbutton.img:getHeight() then
            if not self.assets.maskbutton.movedOut then
                self.assets.maskbutton.movedOut = true
                if self.assets.deepbreathing.audio:isPlaying() then
                    self.assets.maskon:stop()
                    self.assets.maskoff:play()
                    self.assets.deepbreathing:stop()
                else
                    self.assets.maskoff:stop()
                    self.assets.maskon:play()
                    self.assets.deepbreathing:play()
                end
            end
        else
            if self.assets.maskbutton.movedOut then
                self.assets.maskbutton.movedOut = false
            end
        end
    end
    
    -- if mouse hovers over mapbutton
    if not self.assets.deepbreathing.audio:isPlaying() then
        if mx > self.assets.mapbutton.x and mx < self.assets.mapbutton.x + self.assets.mapbutton.img:getWidth() and my > self.assets.mapbutton.y and my < self.assets.mapbutton.y + self.assets.mapbutton.img:getHeight() then
            if not self.assets.mapbutton.movedOut then
                self.assets.mapbutton.movedOut = true
                self.camsUp = not self.camsUp
                self.assets.camflip.paused = false
                if not self.flippedOnce then
                    self.assets.camflip.animFlip = true
                    self.flippedOnce = true
                else
                    self.assets.camflip.animFlip = not self.assets.camflip.animFlip
                end
                if self.camsUp then
                    self.assets.static.alpha = 1
                end
            end
        else
            if self.assets.mapbutton.movedOut then
                self.assets.mapbutton.movedOut = false
            end
        end
    end

    self.lighton = not self.assets.deepbreathing.audio:isPlaying() and love.keyboard.isDown("lctrl")
end

function game:draw()
    push()
    translate(officeOffset, 0)
    self.office:draw()
    draw(self.assets.desk.img, self.assets.desk.frames[math.floor(self.assets.desk.curFrame)], 225, 350, 0, 1, 1)
    draw(self.assets.leftlight.img, -200, 355)
    draw(self.assets.rightlight.img, 1125, 350)
    if self.lighton and officeOffset > 200 then
        draw(self.assets.leftlighton.img, -200, 355)
    elseif self.lighton and officeOffset < -225 then
        draw(self.assets.rightlighton.img, 1125, 350)
    end
    pop()

    if not self.assets.camflip.draw then
        --draw(self.assets.camflip.img, self.assets.camflip.frames[math.floor(self.assets.camflip.curFrame)], 0, 0)
        -- dont draw if paused or curFrame equals frame count

        if self.assets.camflip.curFrame ~= #self.assets.camflip.frames and self.assets.camflip.curFrame ~= 1 then
            draw(self.assets.camflip.img, self.assets.camflip.frames[math.floor(self.assets.camflip.curFrame)], 0, 0)
        end
    end

    if self.assets.deepbreathing.audio:isPlaying() then
        self.assets.mask.y = fpsLerp(self.assets.mask.y, self.assets.mask.img:getHeight()+15, love.timer.getDelta(), 0.05)
    else
        self.assets.mask.y = fpsLerp(self.assets.mask.y, 0, love.timer.getDelta(), 0.05)
    end
    self.assets.mask.oy = math.sin(love.timer.getTime()*3) * 10
    draw(self.assets.mask.img, -100, self.assets.mask.y-self.assets.mask.img:getHeight()-15, 0, 1, 1, 0, self.assets.mask.oy)

    if self.camsUp and self.assets.camflip.paused then
        push()
        translate(self.campan, 0)
        self.cams[self.curcam]:draw()
        pop()
        setColor(1,1,1,self.assets.static.alpha)
        self.assets.static.alpha = fpsLerp(self.assets.static.alpha, 0.45, love.timer.getDelta(), 0.25)
        draw(self.assets.static.img, self.assets.static.frames[math.floor(self.assets.static.curFrame)], 0, 0)
        setColor(1,1,1,1)
        setBlendMode("alpha")

        draw(self.camButtons.map, 550, 375)

        -- now all the seperate buttons :(
           -- draw(self.camButtons.camback, 585, 430)
            --draw(self.camButtons.cam8.img, 590, 435)
        for i, v in pairs(self.camButtons) do
            if type(v) == "table" then
                if self.curcam ~= i then
                    draw(self.camButtons.camback, v.x, v.y)
                else
                    draw(self.camButtons.cambackon, v.x, v.y)
                end
            end
        end
        for i, v in pairs(self.camButtons) do
            if type(v) == "table" then
                draw(v.img, v.x+5, v.y+5)
            end
        end

        oprint("X: "..love.mouse.getX().." Y: "..love.mouse.getY().."", 0, 0)
        print("X: "..love.mouse.getX().." Y: "..love.mouse.getY().."", 0, 0)

    end
    if not self.assets.deepbreathing.audio:isPlaying() then draw(self.assets.mapbutton.img, self.assets.mapbutton.x, self.assets.mapbutton.y) end
    if not self.camsUp then draw(self.assets.maskbutton.img, self.assets.maskbutton.x, self.assets.maskbutton.y) end

    draw(self.assets.flashlight.img, 15, 15)
    draw(self.assets.battery.img, self.assets.battery.frames[6], 5, 30)

    --draw(self.assets.danger.img, self.assets.danger.frames[math.floor(self.assets.danger.curFrame)], 0, 0)
end

function game:mousepressed(x, y, button)
    -- go through all cams, and if its pressed, set the cam to that cam
    for i, v in pairs(self.camButtons) do
        if type(v) == "table" then
            -- check if it was pressed
            if x > v.x and x < v.x + self.camButtons.camback:getWidth() and y > v.y and y < v.y + self.camButtons.camback:getHeight() then
                self.curcam = i
                self.assets.static.alpha = 1
            end
        end
    end
end

function game:mousereleased(x, y, button)

end

function game:mousemoved(x, y, dx, dy)

end

return game