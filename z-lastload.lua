local HActions = {
    [ACT_WALKING] = ACT_WALKING_NIL,
    [ACT_IDLE] = ACT_STANDING_NIL,
    [ACT_FREEFALL] = ACT_FALL_NIL,
    [ACT_JUMP] = ACT_JUMP_NIL,
    [ACT_SPAWN_NO_SPIN_AIRBORNE] = ACT_FALL_NIL,
    [ACT_SPAWN_SPIN_AIRBORNE] = ACT_FALL_NIL,
    [ACT_WARP_DOOR_SPAWN] = ACT_STANDING_NIL,
    [ACT_STAR_DANCE_EXIT] = ACT_STAR_DANCE_WATER,
    [ACT_STAR_DANCE_NO_EXIT] = ACT_STAR_DANCE_WATER,
    [ACT_FALL_AFTER_STAR_GRAB] = ACT_STAR_DANCE_WATER,
    [ACT_EXIT_LAND_SAVE_DIALOG] = ACT_LAND_NIL,
    [ACT_DEATH_EXIT_LAND] = ACT_LAND_NIL,
}

local function replace_acts(m, action)
    if _G.charSelect.character_get_current_number(m.playerIndex) == CT_NILL then
        if HActions[action] then
            return HActions[action]
        end
    end
end
hook_event(HOOK_BEFORE_SET_MARIO_ACTION, replace_acts)

local ONLYMYACTIONS = {
    [ACT_STANDING_NIL] = true,
    [ACT_WALKING_NIL] = true,
    [ACT_FALL_NIL] = true,
    [ACT_LAND_NIL] = true,
    [ACT_GENERAL_THING] = true,
    [ACT_JUMP_NIL] = true,
    [ACT_DISAPPEARED] = true,
    [ACT_STAR_DANCE_EXIT] = true,
    [ACT_STAR_DANCE_NO_EXIT] = true,
    [ACT_STAR_DANCE_WATER] = true,
    [ACT_CREDITS_CUTSCENE] = true,
    [ACT_DEATH_EXIT_LAND] = true,
    [ACT_SQUISHED] = true,
    [ACT_IN_CANNON] = true,
    [ACT_TELEPORT_FADE_OUT] = true,
    [ACT_TELEPORT_FADE_IN] = true,
    [ACT_PULLING_DOOR] = true,
    [ACT_PUSHING_DOOR] = true,
    [ACT_DECELERATING] = true,
    [ACT_DROWNING] = true,
    [ACT_AIR_THROW] = true,
    --[thisisfortheerrormessagelmao] = true,
}

local function onlymine(m, action)
    if _G.charSelect.character_get_current_number(m.playerIndex) == CT_NILL then
        if m.playerIndex ~= 0 then
        else
            if (ONLYMYACTIONS[m.action] ~= true) and ((m.action & ACT_FLAG_CUSTOM_ACTION) == 0) and ((m.action & ACT_GROUP_CUTSCENE) == 0) and not _G.charSelect.is_menu_open() then
                if ((m.action & ACT_FLAG_AIR) ~= 0) then
                    set_mario_action(m, ACT_GENERAL_THING, 0)
                    --djui_chat_message_create("set action to flyng")
                elseif ((m.action & ACT_FLAG_SWIMMING_OR_FLYING) ~= 0) then
                    set_mario_action(m, ACT_GENERAL_THING, 0)
                    --djui_chat_message_create("set action to flyng")
                elseif ((m.action & ACT_FLAG_AIR) == 0) then
                    set_mario_action(m, ACT_FALL_NIL, 0)
                    --djui_chat_message_create("set action to fall")
                elseif ((m.action & ACT_FLAG_IDLE) ~= 0) then
                    set_mario_action(m, ACT_STANDING_NIL, 0)
                    --djui_chat_message_create("set action to idle")
                end
            end
        end
    end
end
hook_event(HOOK_MARIO_UPDATE, onlymine)
