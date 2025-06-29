
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


    _G.charSelect.character_hook_moveset(CT_NILL, HOOK_BEFORE_MARIO_UPDATE, before_NIL_update)
    _G.charSelect.character_hook_moveset(CT_NILL, HOOK_ALLOW_FORCE_WATER_ACTION, allowwater)
    _G.charSelect.character_hook_moveset(CT_NILL, HOOK_MARIO_UPDATE, cs_nil_update)
    _G.charSelect.character_hook_moveset(CT_NILL, HOOK_MARIO_UPDATE, iwalkonlava)
    _G.charSelect.character_hook_moveset(CT_NILL, HOOK_BEFORE_SET_MARIO_ACTION, replace_acts)
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

