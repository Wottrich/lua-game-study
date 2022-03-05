WIDTH_SCREEN = 320
HEIGHT_SCREEN = 480
MAX_METEORS = 12

player = {
    avatar_path = "images/14bis.png",
    width = 55,
    height = 63,
    position = {
        x = WIDTH_SCREEN / 2 - 64 / 2,
        y = HEIGHT_SCREEN - 64 / 2
    }
}

meteors = {}

function gameOver()
    player.avatar_path = "images/explosao_nave.png"
    player.avatar = love.graphics.newImage(player.avatar_path)
    player.width = 67
    player.height = 77
end

function hasCollision(X1, Y1, width1, height1, X2, Y2, width2, height2)
    return X2 < X1 + width1 and X1 < X2 + width2 and Y1 < Y2 + height2 and Y2 < Y1 + height1
end

function checkCollisons()
    for key, meteor in pairs(meteors) do
        if (hasCollision(meteor.x, meteor.y, meteor.width, meteor.height, player.position.x, player.position.y,
            player.width, player.height)) then
            gameOver()
        end
    end
end

function removeMeteors()
    for i = #meteors, 1, -1 do
        if meteors[i].y > HEIGHT_SCREEN then
            table.remove(meteors, i)
        end
    end
end

function createMeteors()
    meteor = {
        x = math.random(WIDTH_SCREEN),
        y = -70,
        width = 50,
        height = 44,
        weight = math.random(3),
        horizontal_shift = math.random(-1, 1)
    }
    table.insert(meteors, meteor)
end

function moveMeteors()
    for k, meteor in pairs(meteors) do
        meteor.y = meteor.y + meteor.weight
        meteor.x = meteor.x + meteor.horizontal_shift
    end
end

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

function love.load()
    love.window.setMode(WIDTH_SCREEN, HEIGHT_SCREEN, {
        resizable = false
    })
    love.window.setTitle("14bis vs Meteoros")

    math.randomseed(os.time())

    background = love.graphics.newImage("images/background.png")
    player.avatar = love.graphics.newImage(player.avatar_path)
    meteors_image = love.graphics.newImage("images/meteoro.png")
end

function love.update(dt)
    if love.keyboard.isDown("a", "w", "s", "d") then
        movePlayer()
    end

    removeMeteors()
    if #meteors < MAX_METEORS then
        createMeteors()
    end
    moveMeteors()
    checkCollisons()
end

function love.draw()
    love.graphics.draw(background, 0, 0)
    love.graphics.draw(player.avatar, player.position.x, player.position.y)

    for key, meteor in pairs(meteors) do
        love.graphics.draw(meteors_image, meteor.x, meteor.y)
    end
end
