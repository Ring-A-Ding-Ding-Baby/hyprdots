-- -- source = ~/.config/stylix/palette.conf
--
-- $bemenu-colors = --nb "$base02H" --nf "$base07H" \
--                  --ab "$base04H" --af "$base07H" \
--                  --fb "$base00H" --ff "$base07H" \
--                  --hb "$base07H" --hf "$base00H" \
--                  --sb "$base08H" --sf "$base07H" \
--                  --cb "$base05H" --cf "$base00H" \
--                  --tb "$base01H" --tf "$base06H" \
--                  --fbb "$base07H" --fbf "$base00H" \
--                  --scb "$base00H" --scf "$base03H"
local bemenu_run = [[  bemenu-run -p $(whoami) -Cin --fn "FiraCode Nerd Font 15" ]]
local exec = hl.dsp.exec_cmd
local submap = hl.dsp.submap
local window = hl.dsp.window
local workspace = hl.dsp.workspace
local focus = hl.dsp.focus
local layout = hl.dsp.layout
local bind = hl.bind

bind("SUPER + H", focus({ direction = "left" }))
bind("SUPER + J", focus({ direction = "down" }))
bind("SUPER + K", focus({ direction = "up" }))
bind("SUPER + L", focus({ direction = "right" }))
bind("SUPER + SHIFT + H", window.move({ direction = "left", group_aware = true }))
bind("SUPER + SHIFT + J", window.move({ direction = "down", group_aware = true }))
bind("SUPER + SHIFT + K", window.move({ direction = "up", group_aware = true }))
bind("SUPER + SHIFT + L", window.move({ direction = "right", group_aware = true }))

for i = 1, 10 do
  local key = i % 10
  bind("SUPER + " .. key, focus({ workspace = i }))
  bind("SUPER + SHIFT + " .. key, window.move({ workspace = i }))
end

bind("SUPER + S", workspace.swap_monitors({ monitor1 = "+1", monitor2 = "+2" }))
bind("SUPER + G", hl.dsp.group.toggle())
bind("SUPER + BRACKETLEFT", hl.dsp.group.prev())
bind("SUPER + BRACKETRIGHT", hl.dsp.group.next())
bind("SUPER + SHIFT + BRACKETLEFT", window.cycle_next({ floating = true }))
bind("SUPER + SHIFT + BRACKETRIGHT", window.cycle_next({ next = true, floating = true }))
bind("SUPER + U", focus({ urgent_or_last = true }))
bind("SUPER + M", layout("focusmaster"))
bind("SUPER + SHIFT + M", layout("swapwithmaster"))
bind("XF86AudioMicMute", exec("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))
bind("XF86AudioMute", exec("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
bind("SUPER + F", window.fullscreen({ mode = "fullscreen" }))
bind("SUPER + ESCAPE", exec("hyprlock"))
bind("SUPER + DELETE", exec("wlogout"))
bind("SUPER + Q", window.close())
bind("SUPER + RETURN", exec("wezterm"))
bind("SUPER + D", exec(bemenu_run))

bind("SUPER + E", workspace.toggle_special("file_manager"))
bind("SUPER + B", workspace.toggle_special("bluetooth"))
bind("SUPER + N", workspace.toggle_special("wifi"))
bind("SUPER + T", workspace.toggle_special("htop"))
bind("SUPER + M", workspace.toggle_special("messenger"))

bind("SUPER + R", submap("RESIZE"))
bind("SUPER + O", submap("LAYOUT"))
bind("SUPER + A", submap("AUDIO"))
bind("SUPER + V", submap("VISUAL"))

bind("XF86AudioLowerVolume", exec("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"))
bind("XF86AudioRaiseVolume", exec("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"))
bind("XF86MonBrightnessUp", exec("brightnessctl set 5%+"))
bind("XF86MonBrightnessDown", exec("brightnessctl set 5%-"))

local screenshot_to_folder = "grim -g -"
local screenshot_to_buffer = "grim -g - - | wl-copy"
local active_screen =
[[hyprctl -j monitors | jq -rc --argjson aw "$(hyprctl -j activeworkspace)" '.[] | select(.id = $aw.id) | "\(.x),\(.y) \(.width)x\(.height)"']]
local active_window = [[hyprctl -j activewindow | jq -rc '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"']]
local active_workspace_windows =
[[hyprctl -j clients | jq -cr --argjson aw "$(hyprctl -j activewindow)" '.[] | select(.workspace.id == $aw.workspace.id) | "\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"']]


hl.define_submap("VISUAL", function()
  bind("Y", submap("YANK"))
  bind("ESCAPE", submap("reset"))
end)

hl.define_submap("YANK", function()
  bind("R", exec("slurp | " .. screenshot_to_buffer))
  bind("R", submap("reset"))
  bind("SHIFT + R", exec("slurp | " .. screenshot_to_folder))
  bind("SHIFT + R", submap("reset"))
  bind("Y", exec(active_screen .. " | " .. screenshot_to_buffer))
  bind("Y", submap("reset"))
  bind("SHIFT + Y", exec(active_screen .. " | " .. screenshot_to_folder))
  bind("SHIFT + Y", submap("reset"))
  bind("W", exec(active_window .. " | " .. screenshot_to_buffer))
  bind("W", submap("reset"))
  bind("SHIFT + W", exec(active_window .. " | " .. screenshot_to_folder))
  bind("SHIFT + W", submap("reset"))
  bind("S", exec(active_workspace_windows .. " | slurp -r | " .. screenshot_to_buffer))
  bind("S", submap("reset"))
  bind("SHIFT + S", exec(active_workspace_windows .. " | slurp -r | " .. screenshot_to_folder))
  bind("SHIFT + S", submap("reset"))
  bind("ESCAPE", submap("reset"))
end)

hl.define_submap("LAYOUT", function()
  bind("H", layout("orientationleft"))
  bind("L", layout("orientationright"))
  bind("K", layout("orientationtop"))
  bind("J", layout("orientationbottom"))
  bind("O", layout("orientationcenter"))
  bind("ESCAPE", submap("reset"))
end)

hl.define_submap("RESIZE", function()
  bind("H", window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
  bind("L", window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
  bind("K", window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
  bind("J", window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
  bind("ESCAPE", submap("reset"))
end)

hl.define_submap("AUDIO", function()
  bind("A", workspace.toggle_special("audio"))
  bind("A", submap("reset"))
  bind("N", exec("playerctl next"))
  bind("P", exec("playerctl previous"))
  bind("SPACE", exec("playerctl play-pause"))
  bind("R", exec("playerctl loop Track"))
  bind("SHIFT + R", exec("playerctl loop None"))
  bind("D", exec("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
  bind("M", exec("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))
  bind("H", exec("playerctld unshift"))
  bind("L", exec("playerctld shift"))
  bind("K", exec("playerctl volume 0.05+"), { repeating = true })
  bind("J", exec("playerctl volume 0.05-"), { repeating = true })
  bind("SHIFT + K", exec("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true })
  bind("SHIFT + J", exec("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true })
  bind("ESCAPE", submap("reset"))
end)
