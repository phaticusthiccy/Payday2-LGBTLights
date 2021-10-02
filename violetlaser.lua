local green = Color.green
local red = Color.red
local blue = Color.blue
local white = Color.white
local violet = Color('EE82EE')

local PLAYER_LASER_COLOR = violet 
local ENEMY_SNIPER_LASER_COLOR = red
local LASER_ALPHA = 0.40 
local RAINBOW_LASER_ENABLED = true
local RAINBOW_LASER_ALPHA = 0.375 

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