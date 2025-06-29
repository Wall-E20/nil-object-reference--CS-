-- name: [CS] nil
--description: hi :>


nilExtraStates3 = {}

local function nil_reset_extra_states(index)
    if index == nil then index = 0 end
    nilExtraStates3[index] = {
        splash = true

    }
end

for i = 0, MAX_PLAYERS - 1 do
    nil_reset_extra_states(i)
end
local voice = { --[[]]
}

-- Replace Mod Name with your Character/Pack name.
local TEXT_MOD_NAME = "nil"

-- Stops mod from loading if Character Select isn't on, Does not need to be touched
if not _G.charSelectExists then
    djui_popup_create(
        "\\#ffffdc\\\n" ..
        TEXT_MOD_NAME ..
        "\nRequires the Character Select Mod\nto use as a Library!\n\nPlease turn on the Character Select Mod\nand Restart the Room!",
        6)
    return 0
end

local NIL = smlua_model_util_get_id("nil_geo") -- Located in "actors"

--local TEX_CHAR_LIFE_OOF = get_texture_info("Iconoof") -- Located in "textures"
-- local TEX_CHAR_STAR_ICON = get_texture_info("exclamation-icon") -- Located in "textures"


local funny_colors_table = {
    [PANTS]  = { r = 0, g = 0, b = 0 },
    [SHIRT]  = { r = 0, g = 0, b = 0 },
    [GLOVES] = { r = 29, g = 29, b = 29 },
    [SHOES]  = { r = 17, g = 6, b = 29 },
    [HAIR]   = { r = 29, g = 25, b = 29 },
    [SKIN]   = { r = 172, g = 130, b = 105 },
    [CAP]    = { r = 23, g = 23, b = 40 },
    [EMBLEM] = { r = 200, g = 0, b = 40 },
}



local yay = {
    [CHAR_ANIM_A_POSE] = "h_fly_idle",
    [CHAR_ANIM_IDLE_HEAD_LEFT] = "h_idle_2",
    [CHAR_ANIM_IDLE_HEAD_RIGHT] = "h_idle_2",
    [CHAR_ANIM_IDLE_HEAD_CENTER] = "h_idle_2",
    [CHAR_ANIM_FIRST_PERSON] = "h_idle_2",
    [CHAR_ANIM_GENERAL_LAND] = "h_land",
    [CHAR_ANIM_LAND_FROM_SINGLE_JUMP] = "h_land",
    [CHAR_ANIM_GROUND_POUND_LANDING] = "h_land",
    [CHAR_ANIM_WALKING] = "h_walking",
    [CHAR_ANIM_RUNNING] = "h_walking",
    [CHAR_ANIM_RUNNING_UNUSED] = "h_walking",
    [CHAR_ANIM_TIPTOE] = "h_walking",
    [CHAR_ANIM_WATER_IDLE] = "h_fly_right",
    [CHAR_ANIM_WATER_IDLE_WITH_OBJ] = "h_fly_left",
    [CHAR_ANIM_WATER_ACTION_END] = "h_fly_foward",
    [CHAR_ANIM_WATER_ACTION_END_WITH_OBJ] = "h_fly_back",
    [CHAR_ANIM_DOUBLE_JUMP_RISE] = "h_fly_up",
    [CHAR_ANIM_DOUBLE_JUMP_FALL] = "h_fly_down",
    [CHAR_ANIM_SINGLE_JUMP] = "h_jump",
    [CHAR_ANIM_GENERAL_FALL] = "h_start_fall",
    [CHAR_ANIM_GROUND_POUND] = "h_fall",
    [CHAR_ANIM_IDLE_WITH_LIGHT_OBJ] = "h_hold_idle",
    [CHAR_ANIM_WALK_WITH_LIGHT_OBJ] = "h_hold_walk",
    [CHAR_ANIM_JUMP_WITH_LIGHT_OBJ] = "h_hold_jump",
    [CHAR_ANIM_FALL_LAND_WITH_LIGHT_OBJ] = "h_hold_land",
    [CHAR_ANIM_IDLE_HEAVY_OBJ] = "h_hold_fly",
    [charSelect.CS_ANIM_MENU] = "h_menupose",
}
local yayalt = {
    [CHAR_ANIM_A_POSE] = "h_fly_idle",
    [CHAR_ANIM_IDLE_HEAD_LEFT] = "h_dle",
    [CHAR_ANIM_IDLE_HEAD_RIGHT] = "h_dle",
    [CHAR_ANIM_IDLE_HEAD_CENTER] = "h_dle",
    [CHAR_ANIM_FIRST_PERSON] = "h_dle",
    [CHAR_ANIM_GENERAL_LAND] = "h_land_2",
    [CHAR_ANIM_LAND_FROM_SINGLE_JUMP] = "h_land_2",
    [CHAR_ANIM_GROUND_POUND_LANDING] = "h_land_2",
    [CHAR_ANIM_WALKING] = "h_walking",
    [CHAR_ANIM_RUNNING] = "h_walking",
    [CHAR_ANIM_RUNNING_UNUSED] = "h_walking",
    [CHAR_ANIM_TIPTOE] = "h_walking",
    [CHAR_ANIM_WATER_IDLE] = "h_fly_right",
    [CHAR_ANIM_WATER_IDLE_WITH_OBJ] = "h_fly_left",
    [CHAR_ANIM_WATER_ACTION_END] = "h_fly_foward",
    [CHAR_ANIM_WATER_ACTION_END_WITH_OBJ] = "h_fly_back",
    [CHAR_ANIM_DOUBLE_JUMP_RISE] = "h_fly_up",
    [CHAR_ANIM_DOUBLE_JUMP_FALL] = "h_fly_down",
    [CHAR_ANIM_SINGLE_JUMP] = "h_jump",
    [CHAR_ANIM_GENERAL_FALL] = "h_start_fall",
    [CHAR_ANIM_GROUND_POUND] = "h_fall",
    [CHAR_ANIM_IDLE_WITH_LIGHT_OBJ] = "h_hold_idle",
    [CHAR_ANIM_WALK_WITH_LIGHT_OBJ] = "h_hold_walk",
    [CHAR_ANIM_JUMP_WITH_LIGHT_OBJ] = "h_hold_jump",
    [CHAR_ANIM_FALL_LAND_WITH_LIGHT_OBJ] = "h_hold_land",
    [CHAR_ANIM_IDLE_HEAVY_OBJ] = "h_hold_fly",
    [charSelect.CS_ANIM_MENU] = "h_menupose",
}

hook_event(HOOK_BEFORE_SET_MARIO_ACTION, function(m)
    if m.playerIndex == 0 then
        idleanim = math.random(2)
        if idleanim == 2 and m.action ~= ACT_LAND_NIL then
            _G.charSelect.character_add_animations(NIL, yay)
        elseif idleanim == 1 and m.action ~= ACT_LAND_NIL then
            _G.charSelect.character_add_animations(NIL, yayalt)
        end
    end
end)


local NOTEXTURE_METER = {
    label = {
        left = get_texture_info("nil"),
        right = get_texture_info("nil"),
    },
    pie = {
        [1] = get_texture_info("NIL_PIE1"),
        [2] = get_texture_info("NIL_PIE2"),
        [3] = get_texture_info("NIL_PIE3"),
        [4] = get_texture_info("NIL_PIE4"),
        [5] = get_texture_info("NIL_PIE5"),
        [6] = get_texture_info("NIL_PIE6"),
        [7] = get_texture_info("NIL_PIE7"),
        [8] = get_texture_info("NIL_PIE8"),
	
    }
}
local COURSE_NIL = {
    top = get_texture_info("NIL_COURSE"),
    bottom = get_texture_info("NIL_COURSE"),
}

local CSloaded = false
local function on_character_select_load()
    CT_NILL = _G.charSelect.character_add("nil", "''Null - Object reference not set to an insrance of an object.'' haha, jk. hello <3", "Wall_E20",
        { r = 234, g = 0, b = 255 },
        NIL, nil, nil, 1.2)
    --_G.charSelect.character_add_celebration_star(NIL, E_MODEL_STAR, nil)
    _G.charSelect.config_character_sounds()
    _G.charSelect.character_add_voice(NIL, voice)
    _G.charSelect.character_add_palette_preset(NIL, funny_colors_table)
	_G.charSelect.character_add_health_meter(CT_NILL, NOTEXTURE_METER)
	_G.charSelect.character_set_category(CT_NILL, "Squishy Workshop")
    _G.charSelect.character_add_course_texture(CT_NILL, COURSE_NIL)
end

local function on_character_sound(m, sound)
    if not CSloaded then return end
    if _G.charSelect.character_get_voice(m) == voice then return _G.charSelect.voice.sound(m, sound) end
end

local function on_character_snore(m)
    if not CSloaded then return end
    if _G.charSelect.character_get_voice(m) == voice then return _G.charSelect.voice.snore(m) end
end
hook_event(HOOK_MARIO_UPDATE, on_character_snore)
hook_event(HOOK_ON_MODS_LOADED, on_character_select_load)
hook_event(HOOK_CHARACTER_SOUND, on_character_sound)




function string.random(length)
    if length > 0 then
        return string.random(length - 1) .. string.char(math.random(65, 65 + 50))
    else
        return ""
    end
end

local function nilupdate(m)
    local s = nilExtraStates3[m.playerIndex]
    _G.charSelect.character_edit(CT_NILL, string.random(math.random(1, 5)), string.random(math.random(20, 30)), nil, nil,
        nil, nil, nil, nil)
    if _G.charSelect.character_get_current_number(m.playerIndex) == CT_NILL then
        m.peakHeight = m.pos.y
        if m.hurtCounter >= 1 then
            m.health = m.health - 512
            m.hurtCounter = 0
            m.invincTimer = 30
        end
        if m.marioObj.header.gfx.animInfo.animID == charSelect.CS_ANIM_MENU and is_anim_past_frame(m, 11) then
            m.marioBodyState.eyeState = 6
        end
        if m.action == ACT_STAR_DANCE_WATER and m.marioObj.header.gfx.animInfo.animFrame >= 25 then
            m.marioBodyState.eyeState = 7
        end
        if m.pos.y <= m.waterLevel - 100 then
            if get_global_timer() % 1 == 0 and s.splash == true then
                s.splash = false
                m.particleFlags = m.particleFlags | PARTICLE_WATER_SPLASH
                play_sound(SOUND_ACTION_UNKNOWN430, m.marioObj.header.gfx.cameraToObject)
            end
            m.particleFlags = m.particleFlags | PARTICLE_BUBBLE
            if ((m.action & ACT_FLAG_AIR) ~= 0) and m.action ~= ACT_GENERAL_THING then
                m.vel.y = m.vel.y + 1
                if m.vel.y <= -20 then
                    m.vel.y = -20
                end
            end
        else
            s.splash = true
        end

        m.marioObj.header.gfx.pos.y = m.pos.y - 30
        set_dialog_override_color(88, 6, 73, 150, 255, 255, 255, 255)
        m.marioBodyState.torsoAngle.x = 0
        m.marioBodyState.torsoAngle.z = 0
        -- djui_chat_message_create("VelController = " .. VelController)
    end
end
hook_event(HOOK_MARIO_UPDATE, nilupdate)

local function before_NIL_update(m)
    if _G.charSelect.character_get_current_number(m.playerIndex) == CT_NILL then
        if m.action == ACT_IDLE then
            m.action = ACT_STANDING_NIL
        end
        if m.action == ACT_WALKING then
            m.action = ACT_WALKING_NIL
        end
    end
end
hook_event(HOOK_BEFORE_MARIO_UPDATE, before_NIL_update)

local function allowwater(m)
    if _G.charSelect.character_get_current_number(m.playerIndex) == CT_NILL then
        if m.pos.y <= m.waterLevel then
            return false
        end
    end
end

hook_event(HOOK_ALLOW_FORCE_WATER_ACTION, allowwater)

function hello(msg)
    m = gMarioStates[0]
    if msg == "twirl" then
        djui_chat_message_create("ok")
        set_mario_action(m, ACT_TWIRLING, 0)
        return true
    end
    return false
end

hook_chat_command("set", "!", hello)

--- @param m MarioState
--[[
hook_event(HOOK_ON_SET_MARIO_ACTION, function(m)
    if m.playerIndex ~= 0 then return end
    for i, k in pairs(_G) do
        if k == m.action then
            if i:find("ACT") == 1 then
                djui_chat_message_create("action: " .. i)
            end
            if i:find("CHAR_ANIM") == 1 then
                djui_chat_message_create("anim: " .. i)
            end
        end
    end
end)
]]
hook_event(HOOK_ALLOW_HAZARD_SURFACE,
    function(m) return not (_G.charSelect.character_get_current_number(m.playerIndex) == CT_NILL) end)
