-- name: [CS] nil
--description: hi :>


function string.random(length)
    if length > 0 then
        return string.random(length - 1) .. string.char(math.random(65, 65 + 50))
    else
        return ""
    end
end

function nilupdate(m)
    local s = nilExtraStates2[m.playerIndex]

    -- djui_chat_message_create("VelController = " .. VelController)
    local s = nilExtraStates2[m.playerIndex]
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

    m.peakHeight = m.pos.y

    if gPlayerSyncTable[0].hasHurt == true and m.hurtCounter == 0 and m.invincTimer == 0 then
        gPlayerSyncTable[0].hasHurt = false
    end
    --[[
    if m.hurtCounter >= 1 then
        m.health = m.health - 512
        m.hurtCounter = 0
        m.invincTimer = 30
    end
    --]]
    -- djui_chat_message_create("VelController = " .. VelController)

    --chatmessages
    local s = gPlayerSyncTable[0]
    local poss4 = math.random(1, 4)
    if m.action == ACT_STAR_DANCE_WATER and s.hasstar == false and (is_anim_past_frame(m, 15) ~= 0) then
        if poss4 == 1 then
            nilmessage("here we go!")
        elseif poss4 == 2 then
            nilmessage("gg!")
        elseif poss4 == 3 then
            nilmessage("great job <3")
        elseif poss4 == 4 then
            nilmessage("we have " .. m.numStars .. " now :)")
        end
        s.hasstar = true
    end

    local obj = obj_get_nearest_object_with_behavior_id(m.marioObj, id_bhvGoomba)
    if _G.charSelect.character_get_current_number(m.playerIndex) == CT_NILL then
        if obj and dist_between_objects(obj, m.marioObj) <= 500 then
            if s.hashi == false then
                s.hashi = true
                local getnumber = math.random(1, 4)

                if getnumber == 1 then
                    nilmessage("hello Goomba :D")
                elseif getnumber == 2 then
                    nilmessage("look! A Goomba! hii")
                elseif getnumber == 3 then
                    nilmessage("a Goomba!, cool")
                elseif getnumber == 4 then
                    nilmessage("Goomba :3")
                end
            end
        end
    end

    if m.playerIndex == 0 then
        if m.controller.buttonDown & B_BUTTON ~= 0 and mario_check_object_grab(m) ~= 0 and (m.action ~= ACT_AIR_THROW or m.action ~= ACT_THROW_GROUND_NILL) then
            mario_grab_used_object(m)
            if m.heldObj ~= nil then
                if (m.action & ACT_FLAG_AIR) ~= 0 then
                    set_mario_action(m, ACT_GENERAL_THING, 0)
                else
                    set_mario_action(m, ACT_STANDING_NIL, 0)
                end
                m.actionState = 1
            end
        end
    end
    if (obj_has_behavior_id(m.heldObj, id_bhvBowser) ~= 0) then
        m.angleVel.y = m.forwardVel * 100
    end

    if m.playerIndex == 0 then
        if _G.charSelect.get_options_status(NILOPTIONMENU) == true then
            m.marioObj.header.gfx.scale.x = (math.random(98, 102) / 100)
            m.marioObj.header.gfx.scale.y = (math.random(98, 102) / 100)
            m.marioObj.header.gfx.scale.z = (math.random(98, 102) / 100)
        end
    end
if m.playerIndex ~= 0 then
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

--hook_event(HOOK_MARIO_UPDATE, nilupdate)



function nocs_nilupdate(m)
    local s = nilExtraStates2[m.playerIndex]

    if m.playerIndex == 0 then
        _G.charSelect.character_edit(CT_NILL, string.random(math.random(3, 5)), nil, nil, nil, nil, nil, nil, nil)
        _G.charSelect.character_set_nickname(CT_NILL, string.random(math.random(3, 5)))


        if _G.charSelect.is_menu_open() == false then
            _G.charSelect.character_edit(CT_NILL, nil, get_string_from_random_vanilla_parts(15), nil, nil, nil, nil, nil,
                nil)
        end
    end
    --djui_chat_message_create(tostring(s.moves))

    if (_G.charSelect.are_movesets_restricted() == true) then
        s.moves = false
    elseif (_G.charSelect.are_movesets_restricted() == false) then
        if (_G.charSelect.get_options_status(6) == 0) then
            s.moves = false
        else
            s.moves = true
        end
    end

    if m.prevAction == ACT_GENERAL_THING and m.area.camera.mode == CAMERA_MODE_BEHIND_MARIO then
        set_camera_mode(m.area.camera, CAMERA_MODE_8_DIRECTIONS, 1)
    end
    if m.playerIndex == 0 then
        if _G.charSelect.character_get_current_number(m.playerIndex) == CT_NILL then
            if s.moves == false then
                _G.charSelect.character_add_animations(NIL, niltable)
            end

            if s.moves == true and s.chatmovesets == false and get_global_timer() % 100 == 0 then
                s.chatmovesets = true
                nilmessage("yeahh, this is much better :)")
            end
            if s.moves == false and s.chatmovesets == true and get_global_timer() % 100 == 0 then
                s.chatmovesets = false
                nilmessage("waaaahh... where is my movesetssss!!... :(((")
            end
        end
        if m.marioObj.header.gfx.animInfo.animID == _G.charSelect.CS_ANIM_MENU then
            m.marioBodyState.eyeState = 6
        end
        if m.action == ACT_STAR_DANCE_WATER or m.action == ACT_STAR_DANCE_EXIT or m.action == ACT_STAR_DANCE_NO_EXIT then
            m.marioBodyState.eyeState = 8
        end
    end
end

hook_event(HOOK_MARIO_UPDATE, nocs_nilupdate)


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

function update()
    local playerIndex = 1
    gPlayerSyncTable[0].characterType = _G.charSelect.character_get_current_number()
    playerTable = _G.charSelect.character_get_current_table(gPlayerSyncTable[playerIndex].characterType)
end

hook_event(HOOK_UPDATE, update)

function before_NIL_update(m)
    if m.playerIndex ~= 0 then return end
    if m.action == ACT_IDLE then
        m.action = ACT_STANDING_NIL
    end
    if m.action == ACT_WALKING then
        m.action = ACT_WALKING_NIL
    end
    if (m.action & ACT_FLAG_WATER_OR_TEXT) ~= 0 and m.pos.y < m.waterLevel then
        m.action = ACT_GENERAL_THING
    end
end

--hook_event(HOOK_BEFORE_MARIO_UPDATE, before_NIL_update)

function allowwater(m)
    if m.pos.y <= m.waterLevel then
        return false
    end
end

--hook_event(HOOK_ALLOW_FORCE_WATER_ACTION, allowwater)


--- @param m MarioState

hook_event(HOOK_BEFORE_SET_MARIO_ACTION, function(m)
    if m.playerIndex ~= 0 then return end
    _G.charSelect.character_add_celebration_star(NIL, math.random(1, E_MODEL_MAX - 1), star_icon)

    _G.charSelect.character_add_peach_custom(NIL, math.random(1, E_MODEL_MAX - 1), math.random(1, E_MODEL_MAX - 1),
        math.random(1, E_MODEL_MAX - 1))

    _G.charSelect.character_add_ending_toad_model(NIL, math.random(1, E_MODEL_MAX - 1), math.random(1, E_MODEL_MAX - 1),
        math.random(1, E_MODEL_MAX - 1))
end)



hook_event(HOOK_ON_WARP, function()
    if gMarioStates[0].playerIndex ~= 0 then return end
    _G.charSelect.character_edit_costume(CT_NILL, 3, nil, nil, nil, nil, math.random(1, E_MODEL_MAX - 1), nil, nil,
        1.2)
    _G.charSelect.character_edit(CT_NILL, string.random(math.random(3, 5)), nil, nil, nil, nil, nil, string.random(2),
        nil)
end)

function iwalkonlava(m) return not (_G.charSelect.character_get_current_number(m.playerIndex) == CT_NILL) end

hook_event(HOOK_ALLOW_HAZARD_SURFACE, iwalkonlava)

function greetings()
    if gPlayerSyncTable[0].greatings == true and get_global_timer() % 100 == 0 then
        gPlayerSyncTable[0].greatings = false
        nilmessage("oh hi hi " .. gNetworkPlayers[0].name .. "!")
    end
end

hook_event(HOOK_UPDATE, greetings)
