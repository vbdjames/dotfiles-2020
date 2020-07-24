local hyper = hs.hotkey.modal.new({}, nil)

hyper.pressed = function()
    hyper:enter()
end

hyper.released = function()
    hyper:exit()
end

-- Set the key you want to be HYPER to F19 in karabiner or keyboard
-- Bind the Hyper key to the hammerspoon modal
hs.hotkey.bind({}, 'F19', hyper.pressed, hyper.released)

hyper.start = function(config_table)
    -- nothing yet...
end

return hyper
