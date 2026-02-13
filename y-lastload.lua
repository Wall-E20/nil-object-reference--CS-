local HActions = {
    [ACT_WALKING] = ACT_WALKING_NIL,
    [ACT_IDLE] = ACT_STANDING_NIL,
    [ACT_FREEFALL] = ACT_FALL_NIL,
    [ACT_DIVE] = ACT_FALL_NIL,
    [ACT_JUMP] = ACT_JUMP_NIL,
    [ACT_WALL_KICK_AIR] = ACT_JUMP_NIL,
    [ACT_TOP_OF_POLE_JUMP] = ACT_JUMP_NIL,
    [ACT_SPAWN_NO_SPIN_AIRBORNE] = ACT_FALL_NIL,
    [ACT_SPAWN_SPIN_AIRBORNE] = ACT_FALL_NIL,
    [ACT_WARP_DOOR_SPAWN] = ACT_STANDING_NIL,
    [ACT_STAR_DANCE_EXIT] = ACT_STAR_DANCE_WATER,
    [ACT_STAR_DANCE_NO_EXIT] = ACT_STAR_DANCE_WATER,
    [ACT_FALL_AFTER_STAR_GRAB] = ACT_STAR_DANCE_WATER,
    [ACT_EXIT_LAND_SAVE_DIALOG] = ACT_LAND_NIL,
    [ACT_DEATH_EXIT_LAND] = ACT_LAND_NIL,
    [ACT_JUMP_LAND] = ACT_LAND_NIL,
    [ACT_FREEFALL_LAND] = ACT_LAND_NIL,
    [ACT_DOUBLE_JUMP_LAND] = ACT_LAND_NIL,
    [ACT_TRIPLE_JUMP_LAND] = ACT_LAND_NIL,
}


ONLYMYACTIONS = {
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
    [ACT_FIRST_PERSON] = true,
}


function replace_acts(m, action)
    local s = nilExtraStates2[m.playerIndex]

    if HActions[action] then
        return HActions[action]
    end

    if s.moves == true then
        if m.playerIndex == 0 then
            idleanim = math.random(2)
            if idleanim == 2 and m.action ~= ACT_LAND_NIL then
                _G.charSelect.character_add_animations(NIL, yay)
                _G.charSelect.character_add_animations(NIL_2, yay)
            elseif idleanim == 1 and m.action ~= ACT_LAND_NIL then
                _G.charSelect.character_add_animations(NIL, yayalt)
                _G.charSelect.character_add_animations(NIL_2, yayalt)
            end
        end
    end
end

--hook_event(HOOK_BEFORE_SET_MARIO_ACTION, replace_acts)
