-- Some concepts borrowed from https://github.com/zzamboni/dot-hammerspoon

hyper = {"ctrl", "alt", "cmd", "shift"}

hs.logger.defaultLogLevel="info"
hs.window.animationDuration = 0

hs.loadSpoon("SpoonInstall")
spoon.SpoonInstall.repos.miro = {
    url = "https://github.com/miromannino/miro-windows-manager",
    desc = "Miro's windows manager"
}

spoon.SpoonInstall.use_syncinstall = true

spoon.SpoonInstall:andUse("MiroWindowsManager",
    {
        repo = 'miro',
        hotkeys = {
          up = { hyper, "up" },
          right = { hyper, "right" },
          down = { hyper, "down" },
          left = { hyper, "left" },
          fullscreen = { hyper, "f" }
        }
    }
)

spoon.SpoonInstall:andUse("WindowScreenLeftAndRight",
    {
         hotkeys = {
             screen_left = { hyper, "[" },
             screen_right = { hyper, "]" }
         }
    }
)

spoon.SpoonInstall:andUse("WindowGrid",
   {
     config = { gridGeometries = { { "8x4" } } },
     hotkeys = {show_grid = {hyper, "g"}},
     start = true
   }
)

-- TODO: does not seem to be working
-- TODO: currently using CheatSheet app instead
spoon.SpoonInstall:andUse("KSheet",
   {
        -- hotkeys = {
        --     toggle = { hyper, "/" }
        -- }
    }
)

hs.hotkey.bind(hyper, '/', function()
    spoon.KSheet:show()
end)

-- Meta {{{1

hs.hotkey.bind(hyper, 'i', function()
    hs.hints.windowHints()
end)

hs.hotkey.bind(hyper, 'b', function()
    hs.application.launchOrFocus("/Applications/Google Chrome.app")
end)

hs.hotkey.bind(hyper, 'e', function()
    hs.application.launchOrFocus('Sublime Text')
end)

hs.hotkey.bind(hyper, 'm', function()
    hs.application.launchOrFocus('Google Play Music Desktop Player')
end)

hs.hotkey.bind(hyper, 'r', function()
    hs.application.launchOrFocus("/Applications/Microsoft Remote Desktop.app")
end)

hs.hotkey.bind(hyper, 's', function()
    hs.application.launchOrFocus("/Applications/Slack.app")
end)

hs.hotkey.bind(hyper, 't', function()
    hs.application.launchOrFocus("/Applications/iTerm.app")
end)

hs.hotkey.bind(hyper, 'v', function()
    hs.application.launchOrFocus("/Applications/VMware Fusion.app")
end)


-- hs.hotkey.bind(hyper, 'P', function()
--   hs.openPreferences()
-- end)

-- hs.hotkey.bind(hyper, 'R', function()
--   hs.reload()
-- end)

function reloadConfig(files)---- {{{2
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            hs.reload()
            break
        end
    end
end-- }}}2

function uptime()---- {{{2

    local days = hs.execute("uptime | \
        grep -o '\\d\\+\\sdays\\?' | grep -o '\\d\\+'")

    local seconds = hs.execute("uptime | \
        grep -o '\\d\\+\\ssecs\\?' | grep -o '\\d\\+'")

    if tonumber(days) then
        local minutes = hs.execute("uptime | awk '{print $5}' | \
                sed -e 's/[^0-9:].*//' | sed 's/:/*60+/g' | bc")
        local minutes = tonumber(minutes) or 0
        local seconds = tonumber(seconds) or 0
        local days = tonumber(days) or 0
        return (days * 24 * 60 + minutes) * 60 + seconds
    elseif tonumber(seconds) then
        return tonumber(seconds)
    else
        local minutes = hs.execute("uptime | awk '{print $3}' | \
            sed -e 's/[^0-9:].*//' | sed 's/:/*60+/g' | bc")
        local minutes = tonumber(minutes) or 0
        return minutes * 60
    end

end-- }}}2

hs.pathwatcher.new(os.getenv("HOME") ..
    "/.hammerspoon/", reloadConfig):start()

if uptime() > 1000 then
-- I don't want the alert when I have just turned on the computer
    hs.alert.show("Hammerspoon loaded")
end

-- }}}1
