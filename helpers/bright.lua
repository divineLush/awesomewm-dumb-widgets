-------------------------------------------------
-- Bright helper
-------------------------------------------------

local awful = require("awful")
local helper = {}

function helper:inc()
    awful.util.spawn("light -A 5%")
end

function helper:dec()
    awful.util.spawn("light -U 5%")
end

return helper
