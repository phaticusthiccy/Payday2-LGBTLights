--Some color values:
local green = Color.green
local red = Color.red
local blue = Color.blue
local white = Color.white

--more colors can be set in the following format by entering their hex values in Color('<hex value here>')
--see below for examples; do a web search for 'color hex value' for more colors
--usefull link: http://www.color-hex.com/color-names.html
local violet = Color('EE82EE') 		-- Violet
local ablue = Color('f0f8ff') 		-- Alice Blue
local aquam = Color('7fffd4') 		-- Aquamarine
local bisque = Color('ffe4c4') 		-- Bisque
local cyan = Color('00ffff') 		-- Cyan
local goldr = Color('ffb90f') 		-- Goldenrod
local dgreen = Color('006400') 		-- Darkgreen
local gold = Color('ffd700')		-- Gold
local gray = Color('bebebe')		-- Gray
local lgreen = Color('32cd32') 		-- Lime Green
local orange = Color('ffa500') 		-- Orange
local orchid = Color('da70d6')      -- Orchid
local yellow = Color('ffff00') 		-- Yellow

--variables below will change the colors. Edit the values to what you prefer.
local PLAYER_LASER_COLOR = blue -- Your laser color
local ENEMY_SNIPER_LASER_COLOR = red --also teammate laser color. Red as Deafault will not change Teammates laser color
local LASER_ALPHA = 0.40 --alpha (transparency) value; '1' is the maximum value (i.e. non-transparent). Non High Visible effects after 0.4
local RAINBOW_LASER_ENABLED = true --enter true or false; enables/disables rainbow laser color for the player
local RAINBOW_LASER_ALPHA = 0.375 --alpha (transparency) value of the rainbow laser color

--function below customizes teammate ("default") and enemy sniper ("cop_sniper") laser colors
local _WeaponLaser_init = WeaponLaser.init
function WeaponLaser:init(unit)
    _WeaponLaser_init (self, unit)

    self._themes = {
        default = {
            light = PLAYER_LASER_COLOR * 10,
            glow = PLAYER_LASER_COLOR / 5,
            brush = PLAYER_LASER_COLOR:with_alpha(LASER_ALPHA)
        },
        cop_sniper = {
            light = ENEMY_SNIPER_LASER_COLOR * 10,
            glow = ENEMY_SNIPER_LASER_COLOR / 5,
            brush = ENEMY_SNIPER_LASER_COLOR:with_alpha(LASER_ALPHA)
        }
    }
end

--function below customizes player laser colors ("custom_player_laser_color") 
local _WeaponLaser_update = WeaponLaser.update
function WeaponLaser:update(unit, t, dt)
    _WeaponLaser_update(self, unit, t, dt)

    if not RAINBOW_LASER_ENABLED then
        self._themes.custom_player_laser_color = {
            light = PLAYER_LASER_COLOR * 10,
            glow = PLAYER_LASER_COLOR / 5,
            brush = PLAYER_LASER_COLOR:with_alpha(LASER_ALPHA)
        }
    else --if rainbow laser color is enabled
        local red = math.sin(135 * t + 0) / 2 + 0.5
        local green = math.sin(140 * t + 60) / 2 + 0.5
        local blue = math.sin(145 * t + 120) / 2 + 0.5

        self._themes.custom_player_laser_color = {
            light = Color(red, green, blue) * 10,
            glow = Color(red, green, blue) / 2,
            brush = Color(RAINBOW_LASER_ALPHA, red, green, blue)  
        }
    end

    if not self._is_npc then
        self:set_color_by_theme("custom_player_laser_color")
    end
end