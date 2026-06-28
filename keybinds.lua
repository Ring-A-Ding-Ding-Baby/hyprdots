-- source = ~/.config/stylix/palette.conf

-- $bemenu-colors = --nb "$base02H" --nf "$base07H" \
--                  --ab "$base04H" --af "$base07H" \
--                  --fb "$base00H" --ff "$base07H" \
--                  --hb "$base07H" --hf "$base00H" \
--                  --sb "$base08H" --sf "$base07H" \
--                  --cb "$base05H" --cf "$base00H" \
--                  --tb "$base01H" --tf "$base06H" \
--                  --fbb "$base07H" --fbf "$base00H" \
--                  --scb "$base00H" --scf "$base03H"

-- $bemenu-run = bemenu-run -p $(whoami) -Cin --fn "FiraCode Nerd Font 15" $bemenu-colors

hl.bind("SUPER + H", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + J", hl.dsp.focus({ direction = "down" }))
hl.bind("SUPER + K", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + L", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + SHIFT + H", hl.dsp.window.move({ direction = "left", group_aware = true }))
hl.bind("SUPER + SHIFT + J", hl.dsp.window.move({ direction = "down", group_aware = true }))
hl.bind("SUPER + SHIFT + K", hl.dsp.window.move({ direction = "up", group_aware = true }))
hl.bind("SUPER + SHIFT + L", hl.dsp.window.move({ direction = "right", group_aware = true }))

for i = 1, 10 do
  local key = i % 10
  hl.bind("SUPER + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind("SUPER + S", hl.dsp.workspace.swap_monitors())
hl.bind("SUPER + G", hl.dsp.group.toggle())
hl.bind("SUPER + BRACKETLEFT", hl.dsp.group.prev())
hl.bind("SUPER + BRACKETRIGHT", hl.dsp.group.next())
hl.bind("SUPER SHIFT + BRACKETLEFT", hl.dsp.window.cycle_next({ floating = true }))
hl.bind("SUPER SHIFT + BRACKETRIGHT", hl.dsp.window.cycle_next({ next = true, floating = true }))
hl.bind("SUPER + U", hl.dsp.focus("urgent_or_last"))
hl.bind("SUPER + M", hl.dsp.layout("focusmaster"))
hl.bind("SUPER SHIFT + M", hl.dsp.layout("swapwithmaster"))
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind("SUPER + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind("SUPER + E", hl.dsp.exec_cmd("xdg-open ~/"))
hl.bind("SUPER + ESCAPE", hl.dsp.exec_cmd("hyprlock"))
hl.bind("SUPER + DELETE", hl.dsp.exec_cmd("wlogout"))
hl.bind("SUPER + Q", hl.dsp.window.close())
hl.bind("SUPER + RETURN", hl.dsp.exec_cmd("wezterm"))
hl.bind("SUPER + D", hl.dsp.exec_cmd("$bemenu-run"))
hl.bind("SUPER + B", hl.dsp.exec_cmd("wezterm start --class popup -- bluetuith"))
hl.bind("SUPER + N", hl.dsp.exec_cmd("wezterm start --class popup -- wifitui"))
hl.bind("SUPER + R", hl.dsp.submap("RESIZE"))
hl.bind("SUPER + O", hl.dsp.submap("LAYOUT"))
hl.bind("SUPER + A", hl.dsp.submap("AUDIO"))
hl.bind("SUPER + V", hl.dsp.submap("VISUAL"))

hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"))
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 5%+"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"))

local screenshot_to_folder = "grim -g -"
local screenshot_to_buffer = "grim -g - - | wl-copy"
local active_screen =
[[hyprctl -j monitors | jq -rc --argjson aw "$(hyprctl -j activeworkspace)" '.[] | select(.id = $aw.id) | "\(.x),\(.y) \(.width)x\(.height)"']]
local active_window = [[hyprctl -j activewindow | jq -rc '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"']]
local active_workspace_windows =
[[hyprctl -j clients | jq -cr --argjson aw "$(hyprctl -j activewindow)" '.[] | select(.workspace.id == $aw.workspace.id) | "\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"']]


hl.define_submap("VISUAL", function()
  hl.bind("Y", hl.dsp.submap("YANK"))
  hl.bind("ESCAPE", hl.dsp.submap("reset"))
end)

hl.define_submap("YANK", function()
  hl.bind("R", hl.dsp.exec_cmd("slurp | " .. screenshot_to_buffer))
  hl.bind("R", hl.dsp.submap("reset"))
  hl.bind("SHIFT + R", hl.dsp.exec_cmd("slurp | " .. screenshot_to_folder))
  hl.bind("SHIFT + R", hl.dsp.submap("reset"))
  hl.bind("Y", hl.dsp.exec_cmd(active_screen .. " | " .. screenshot_to_buffer))
  hl.bind("Y", hl.dsp.submap("reset"))
  hl.bind("SHIFT + Y", hl.dsp.exec_cmd(active_screen .. " | " .. screenshot_to_folder))
  hl.bind("SHIFT + Y", hl.dsp.submap("reset"))
  hl.bind("W", hl.dsp.exec_cmd(active_window .. " | " .. screenshot_to_buffer))
  hl.bind("W", hl.dsp.submap("reset"))
  hl.bind("SHIFT + W", hl.dsp.exec_cmd(active_window .. " | " .. screenshot_to_folder))
  hl.bind("SHIFT + W", hl.dsp.submap("reset"))
  hl.bind("S", hl.dsp.exec_cmd(active_workspace_windows .. " | slurp -r | " .. screenshot_to_buffer))
  hl.bind("S", hl.dsp.submap("reset"))
  hl.bind("SHIFT + S", hl.dsp.exec_cmd(active_workspace_windows .. " | slurp -r | " .. screenshot_to_folder))
  hl.bind("SHIFT + S", hl.dsp.submap("reset"))
  hl.bind("ESCAPE", hl.dsp.submap("reset"))
end)

hl.define_submap("LAYOUT", function()
  hl.bind("H", hl.dsp.layout("orientationleft"))
  hl.bind("L", hl.dsp.layout("orientationright"))
  hl.bind("K", hl.dsp.layout("orientationtop"))
  hl.bind("J", hl.dsp.layout("orientationbottom"))
  hl.bind("O", hl.dsp.layout("orientationcenter"))
  hl.bind("ESCAPE", hl.dsp.submap("reset"))
end)

hl.define_submap("RESIZE", function()
  hl.bind("H", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
  hl.bind("L", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
  hl.bind("K", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
  hl.bind("J", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
  hl.bind("ESCAPE", hl.dsp.submap("reset"))
end)

hl.define_submap("AUDIO", function()
  hl.bind("A", hl.dsp.exec_cmd("wezterm start --class popup -- wiremix"))
  hl.bind("A", hl.dsp.submap("reset"))
  hl.bind("N", hl.dsp.exec_cmd("playerctl next"))
  hl.bind("P", hl.dsp.exec_cmd("playerctl previous"))
  hl.bind("SPACE", hl.dsp.exec_cmd("playerctl play-pause"))
  hl.bind("R", hl.dsp.exec_cmd("playerctl loop Track"))
  hl.bind("SHIFT + R", hl.dsp.exec_cmd("playerctl loop None"))
  hl.bind("D", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
  hl.bind("M", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))
  hl.bind("H", hl.dsp.exec_cmd("playerctld unshift"))
  hl.bind("L", hl.dsp.exec_cmd("playerctld shift"))
  hl.bind("K", hl.dsp.exec_cmd("playerctl volume 0.05+"))
  hl.bind("J", hl.dsp.exec_cmd("playerctl volume 0.05-"))
  hl.bind("SHIFT + K", hl.dsp.exec_cmd("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"))
  hl.bind("SHIFT + J", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"))
  hl.bind("ESCAPE", hl.dsp.submap("reset"))
end)
