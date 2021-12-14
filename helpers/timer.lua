-------------------------------------------------
-- Timer Helper
-------------------------------------------------

local gears = require("gears")
local naughty = require("naughty")

local helper = {}

local timer = gears.timer {
    timeout = 10,
    single_shot = true,
    callback = function()
        naughty.notify({ title = "Fun Fact!", text = "You wasted 25 minutes of your life!", timeout = 15 })
        set_text(0)
    end
}

function helper:start()
    local msg = 'Timer Started!'

    if timer.started then
        timer:again()
        msg = 'Timer ReStarted!'
    else
        timer:start()
    end

    naughty.notify({ title = 'Achtung!', text = msg })
end

function helper:stop()
    if timer.started then
        timer:stop()
        naughty.notify({ title = 'Achtung!', text = 'Timer Stopped!' })
    end
end

return helper

