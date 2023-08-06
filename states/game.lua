local game = {}

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

    self.assets = {
        office = {
            img = love.graphics.newImage("assets/images/game/office.png"),
            spritesheet = false,
            x = 300,
            y = 0
        },
        desk = {
            img = love.graphics.newImage("assets/images/game/desk.png"),
            spritesheet = true,
            frameByWidth = false,
            frameWidth = 851,
            frameHeight = 435,

            frames = {},
            curFrame = 1,
            speed = 99,
        },
        mapbutton = {
            img = love.graphics.newImage("assets/images/game/mapbutton.png"),
            spritesheet = false,
            x = 505,
            y = love.graphics.getHeight() - 50
        },
        maskbutton = {
            img = love.graphics.newImage("assets/images/game/maskbutton.png"),
            spritesheet = false,
            x = 15,
            y = love.graphics.getHeight() - 50
        },
    }

    -- set up the frames for the spritesheets
    for k, v in pairs(self.assets) do
        if v.spritesheet then
            if v.frameByWidth then
                for i = 1, v.img:getWidth() / v.frameWidth do
                    table.insert(v.frames, love.graphics.newQuad((i - 1) * v.frameWidth, 0, v.frameWidth, v.frameHeight, v.img:getWidth(), v.img:getHeight()))
                end
            else
                for i = 1, v.img:getHeight() / v.frameHeight do
                    table.insert(v.frames, love.graphics.newQuad(0, (i - 1) * v.frameHeight, v.frameWidth, v.frameHeight, v.img:getWidth(), v.img:getHeight()))
                end
            end
        end
    end

    officeOffset = 0
end

function game:update(dt)
    -- update the frames for the spritesheets
    for k, v in pairs(self.assets) do
        if v.spritesheet then
            v.curFrame = v.curFrame + v.speed * dt
            if v.curFrame >= #v.frames + 1 then
                v.curFrame = 1
            end
        end
    end

    local mx, my = love.mouse.getPosition()
    if mx < 300 then
        officeOffset = officeOffset + 500 * dt
    elseif mx > love.graphics.getWidth() - 300 then
        officeOffset = officeOffset - 500 * dt
    end

    if officeOffset > 300 then
        officeOffset = 300
    elseif officeOffset < -275 then
        officeOffset = -275
    end
end

function game:draw()
    love.graphics.push()
    love.graphics.translate(officeOffset, 0)
    love.graphics.draw(self.assets.office.img, 0, 0, 0, 1, 1, self.assets.office.x, self.assets.office.y)
    love.graphics.draw(self.assets.desk.img, self.assets.desk.frames[math.floor(self.assets.desk.curFrame)], 225, 350, 0, 1, 1)
    love.graphics.pop()

    love.graphics.draw(self.assets.mapbutton.img, self.assets.mapbutton.x, self.assets.mapbutton.y)
    love.graphics.draw(self.assets.maskbutton.img, self.assets.maskbutton.x, self.assets.maskbutton.y)
end

function game:mousepressed(x, y, button)

end

function game:mousereleased(x, y, button)

end

function game:mousemoved(x, y, dx, dy)

end

return game