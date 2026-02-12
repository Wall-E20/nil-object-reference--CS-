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
    local s = nilExtraStates2[m.playerIndex]
    if m.playerIndex == 0 then
        if HActions[action] then
            return HActions[action]
        end

        if s.moves == true then
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
