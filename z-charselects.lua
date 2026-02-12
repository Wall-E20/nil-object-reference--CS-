
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

 NIL = smlua_model_util_get_id("nil_geo") -- Located in "actors"
 NIL_2 = smlua_model_util_get_id("nil_alt_geo") -- Located in "actors"


 funny_colors_table = {
    [PANTS]  = "0B050F",
    [SHIRT]  = "1D1430",
    [GLOVES] = "0B050F",
    [SHOES]  = "191919",
    [HAIR]   = "EA00FF",
    [SKIN]   = "917B69",
    [CAP]    = "EA00FF",
    [EMBLEM] = "EA00FF",
}


niltable = {
     [CHAR_ANIM_SINGLE_JUMP] = nil,
    [charSelect.CS_ANIM_MENU] = "h_menupose",}

 yay = {
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
 yayalt = {
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
    [_G.charSelect.CS_ANIM_MENU] = "h_menupose",
}


nil_icon = string.random(2)

star_icon = get_texture_info("ICON")

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



random = {
    [PANTS]  = {r = math.random(0, 255), g = math.random(0, 255), b = math.random(0, 255)},
    [SHIRT]  = {r = math.random(0, 255), g = math.random(0, 255), b = math.random(0, 255)},
    [GLOVES] = {r = math.random(0, 255), g = math.random(0, 255), b = math.random(0, 255)},
    [SHOES]  = {r = math.random(0, 255), g = math.random(0, 255), b = math.random(0, 255)},
    [HAIR]   = {r = math.random(0, 255), g = math.random(0, 255), b = math.random(0, 255)},
    [SKIN]   = {r = math.random(0, 255), g = math.random(0, 255), b = math.random(0, 255)},
    [CAP]    = {r = math.random(0, 255), g = math.random(0, 255), b = math.random(0, 255)},
    [EMBLEM] = {r = math.random(0, 255), g = math.random(0, 255), b = math.random(0, 255)},
}

NILOPTIONMENU = _G.charSelect.add_option("nil's random sizes", nil, nil, {"Off", "On"}, {"Randomize nil's Sizes randomly every frame", "(only when movesets are on.)"}, true)

local randommodel = math.random(1, E_MODEL_MAX - 1)
--her name is nil lol
local name
local CSloaded = false
local function on_character_select_load()
    CT_NILL = _G.charSelect.character_add(tostring(name), "''nil - Object reference not set to an insrance of an object.'' haha, jk. hello <3", "Wall_E20",
        nil,
        NIL, nil, nil_icon, 1.2)

    _G.charSelect.character_add_celebration_star(NIL, math.random(1, E_MODEL_MAX - 1), star_icon)

    _G.charSelect.character_add_peach_custom(NIL, math.random(1, E_MODEL_MAX - 1), math.random(1, E_MODEL_MAX - 1), math.random(1, E_MODEL_MAX - 1))
    _G.charSelect.character_add_ending_toad_model(NIL, math.random(1, E_MODEL_MAX - 1), math.random(1, E_MODEL_MAX - 1), math.random(1, E_MODEL_MAX - 1))

    _G.charSelect.config_character_sounds()

    _G.charSelect.character_add_voice(NIL, voice)
    _G.charSelect.character_add_voice(NIL_2, voice)

    _G.charSelect.character_add_palette_preset(NIL, funny_colors_table, get_string_from_random_vanilla_parts(3))
    _G.charSelect.character_add_palette_preset(NIL_2, funny_colors_table, get_string_from_random_vanilla_parts(3))


    _G.charSelect.character_add_palette_preset(NIL, random, get_string_from_random_vanilla_parts(4))
    _G.charSelect.character_add_palette_preset(NIL_2, random, get_string_from_random_vanilla_parts(4))


	_G.charSelect.character_add_health_meter(CT_NILL, NOTEXTURE_METER)
	_G.charSelect.character_set_category(CT_NILL, "nil")
    _G.charSelect.character_add_course_texture(CT_NILL, COURSE_NIL)

    _G.charSelect.character_add_costume(CT_NILL, nil, nil, nil, nil, NIL_2, nil, nil_icon, 1.2)
    _G.charSelect.character_add_costume(CT_NILL, nil, nil, nil, nil, randommodel, nil, nil_icon, 1.2)

    _G.charSelect.character_add_menu_instrumental(CT_NILL,audio_stream_load("untitled.ogg"))

    _G.charSelect.character_hook_moveset(CT_NILL, HOOK_ALLOW_FORCE_WATER_ACTION, allowwater)
    _G.charSelect.character_hook_moveset(CT_NILL, HOOK_BEFORE_MARIO_UPDATE, before_NIL_update)
    _G.charSelect.character_hook_moveset(CT_NILL, HOOK_MARIO_UPDATE, nilupdate)
    _G.charSelect.character_hook_moveset(CT_NILL, HOOK_ON_INTERACT, on_interact)
    _G.charSelect.character_hook_moveset(CT_NILL, HOOK_ALLOW_INTERACT, on_allow_interact)
    _G.charSelect.character_hook_moveset(CT_NILL, HOOK_ON_SET_MARIO_ACTION, nil_chat_hurt)
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

