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


function replace_acts(m, action)
    if _G.charSelect.character_get_current_number(m.playerIndex) == CT_NILL then
        if HActions[action] then
            return HActions[action]
        end
    end
    if m.playerIndex == 0 then
        idleanim = math.random(2)
        if idleanim == 2 and m.action ~= ACT_LAND_NIL then
            _G.charSelect.character_add_animations(NIL, yay)
        elseif idleanim == 1 and m.action ~= ACT_LAND_NIL then
            _G.charSelect.character_add_animations(NIL, yayalt)
        end
    end
end

hook_event(HOOK_BEFORE_SET_MARIO_ACTION, replace_acts)


local function onlymine(m, action)
    if _G.charSelect.character_get_current_number(m.playerIndex) == CT_NILL then
        if (ONLYMYACTIONS[m.action] ~= true) and ((m.action & ACT_FLAG_CUSTOM_ACTION) == 0) and ((m.action & ACT_GROUP_CUTSCENE) == 0) and KBACTS[m.action] == false then
            if ((m.action & ACT_FLAG_AIR) ~= 0) then
                set_mario_action(m, ACT_GENERAL_THING, 0)
                --djui_chat_message_create("set action to flyng")
            elseif ((m.action & ACT_FLAG_SWIMMING_OR_FLYING) ~= 0) then
                set_mario_action(m, ACT_GENERAL_THING, 0)
                --djui_chat_message_create("set action to flyng")
            elseif ((m.action & ACT_FLAG_AIR) == 0) then
                set_mario_action(m, ACT_STANDING_NIL, 0)
                --djui_chat_message_create("set action to fall")
            elseif ((m.action & ACT_FLAG_IDLE) ~= 0) then
                set_mario_action(m, ACT_STANDING_NIL, 0)
                --djui_chat_message_create("set action to idle")
            end
        end
    end
end
hook_event(HOOK_MARIO_UPDATE, onlymine)
