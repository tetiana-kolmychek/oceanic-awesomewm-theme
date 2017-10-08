local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local naughty = require("naughty")

local gfs = require("gears.filesystem")

local themes_path = gfs.get_configuration_dir() .. 'themes/'

local basedir = themes_path .. "oceanic"

-- scan directory, and optionally filter outputs
-- Source: https://gist.github.com/anonymous/9072154f03247ab6e28c
function scandir(directory, filter)
  local i, t, popen = 0, {}, io.popen
  if not filter then
    filter = function(s) return true end
  end
  for filename in popen('ls -a "'..directory..'"'):lines() do
    if filter(filename) then
      i = i + 1
      t[i] = filename
    end
  end
  return t
end

theme = {}

theme.font          = "sans bold 9"

theme.bg_normal     = "#000000bc"
theme.bg_focus      = "#00000018"
theme.bg_urgent     = "#ddffdd64"
theme.bg_minimize   = "#00000000"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#ccffcc"
theme.fg_focus      = "#ccffcc"
theme.fg_urgent     = "#ccffcc"
theme.fg_minimize   = "#ccffcc"

theme.useless_gap   = dpi(0)
theme.border_width  = dpi(0)
theme.border_normal = "#000000"
theme.border_focus  = "#222222"
theme.border_marked = "#216464"

theme.tasklist_bg_normal = "#00000000"
theme.tasklist_bg_focus  = "#00000000"

theme.taglist_bg_focus  = "#00000064"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
--
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg
--   |label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
  taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
  taglist_square_size, theme.fg_normal
)

-- Disable tasklist icon
theme.tasklist_disable_icon = false

-- Display the taglist squares
theme.taglist_squares_sel   = basedir .. "/taglist/squarefw.png"
theme.taglist_squares_unsel = basedir .. "/taglist/squarew.png"

theme.tasklist_floating_icon = basedir .. "/tasklist/floatingw.png"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = basedir .. "/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = basedir .. "/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = basedir .. "/titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = basedir .. "/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = basedir .. "/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = basedir .. "/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = basedir .. "/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = basedir .. "/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = basedir .. "/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = basedir .. "/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = basedir .. "/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = basedir .. "/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = basedir .. "/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = basedir .. "/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = basedir .. "/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = basedir .. "/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = basedir .. "/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = basedir .. "/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = basedir .. "/titlebar/maximized_focus_active.png"

-- Adapted from https://gist.github.com/anonymous/9072154f03247ab6e28c
local wallpaper_filter = function(s)
  return string.match(s,"%.png$") or string.match(s,"%.jpg$")
end
local wallpaper_dir = basedir .. "/wallpapers/current/"
local wallpaper_files = scandir(wallpaper_dir, wallpaper_filter)
theme.wallpaper = function()
  local wallpaper_index = math.random(1, #wallpaper_files)
  local wallpaper_file = wallpaper_files[wallpaper_index]

  return wallpaper_dir .. wallpaper_file
end

-- You can use your own layout icons like this:
theme.layout_fairh = basedir .. "/layouts/fairhw.png"
theme.layout_fairv = basedir .. "/layouts/fairvw.png"
theme.layout_floating  = basedir .. "/layouts/floatingw.png"
theme.layout_magnifier = basedir .. "/layouts/magnifierw.png"
theme.layout_max = basedir .. "/layouts/maxw.png"
theme.layout_fullscreen = basedir .. "/layouts/fullscreenw.png"
theme.layout_tilebottom = basedir .. "/layouts/tilebottomw.png"
theme.layout_tileleft   = basedir .. "/layouts/tileleftw.png"
theme.layout_tile = basedir .. "/layouts/tilew.png"
theme.layout_tiletop = basedir .. "/layouts/tiletopw.png"
theme.layout_spiral  = basedir .. "/layouts/spiralw.png"
theme.layout_dwindle = basedir .. "/layouts/dwindlew.png"

theme.awesome_icon = "/usr/share/awesome/icons/awesome16.png"

theme.icon_theme = nil

return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
