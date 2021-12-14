-------------------------------------------------
-- Pomodoro widget
-------------------------------------------------

local wibox = require("wibox")
local gears = require("gears")
local naughty = require("naughty")


local text = wibox.widget {
    font = "Hack 12",
    widget = wibox.widget.textbox,
}

local function set_text(arg)
    text:set_text('ti: '..arg)
end

local timer = gears.timer {
    timeout = 1500,
    single_shot = true,
    callback = function()
        naughty.notify({ title = "Fun Fact!", text = "You wasted 25 minutes of your life!", timeout = 15 })
        set_text(0)
    end
}

local widget = wibox.widget.background()
widget:set_widget(text)
set_text(0)

function widget:start()
    local msg = 'Timer Started!'

    if timer.started then
        timer:again()
        msg = 'Timer ReStarted!'
    else
        timer:start()
    end

    set_text(1)
    naughty.notify({ title = 'Achtung!', text = msg })
end

function widget:stop()
    if timer.started then
        timer:stop()
        set_text(0)
        naughty.notify({ title = 'Achtung!', text = 'Timer Stopped!' })
    end
end

return widget
