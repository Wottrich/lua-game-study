
player = {
    avatar_path = "images/14bis.png",
    width = 64,
    height = 64,
    position = {
        x = 0,
        y = 0
    }
}

function movePlayer() 
    if love.keyboard.isDown("w") then
        player.position.y = player.position.y - 1
    end
    if love.keyboard.isDown("s") then
        player.position.y = player.position.y + 1
    end
    if love.keyboard.isDown("a") then
        player.position.x = player.position.x - 1
    end
    if love.keyboard.isDown("d") then
        player.position.x = player.position.x + 1
    end
end

-- Load some default values for our rectangle.
function love.load()
    love.window.setMode(320, 480, { resizable = false })
    love.window.setTitle("14bis vs Meteoros")

    background = love.graphics.newImage("images/background.png")
    player.avatar = love.graphics.newImage(player.avatar_path)
end

-- Increase the size of the rectangle every frame.
function love.update(dt)
    if love.keyboard.isDown("a", "w", "s", "d") then
        movePlayer()
    end
end

-- Draw a coloured rectangle.
function love.draw()
    love.graphics.draw(background, 0, 0)
    love.graphics.draw(player.avatar, player.position.x, player.position.y)
end