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
        if m.marioObj.header.gfx.animInfo.animID == charSelect.CS_ANIM_MENU and is_anim_past_frame(m, 11) then
            m.marioBodyState.eyeState = 6
        end
        if m.action == ACT_STAR_DANCE_WATER and m.marioObj.header.gfx.animInfo.animFrame >= 25 then
            m.marioBodyState.eyeState = 7
        end

        m.marioObj.header.gfx.pos.y = m.pos.y - 30
        --set_dialog_override_color(88, 6, 73, 150, 255, 255, 255, 255)
        m.marioBodyState.torsoAngle.x = 0
        m.marioBodyState.torsoAngle.z = 0
        -- djui_chat_message_create("VelController = " .. VelController)
    end
end
hook_event(HOOK_MARIO_UPDATE, nilupdate)



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



---@type Vec3f
storedMarioPos = { x = 0.0, y = 0.0, z = 0.0 }


---@return boolean
---@param updatingMarioState MarioState
function cs_nil_update(m, updatingMarioState)
    local s = nilExtraStates3[m.playerIndex]
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
    if _G.charSelect.character_get_current_number() == CT_NILL then
        if updatingMarioState.controller.buttonDown & B_BUTTON ~= 0 and mario_check_object_grab(updatingMarioState) ~= 0 and (updatingMarioState.action ~= ACT_AIR_THROW or updatingMarioState.action ~= ACT_THROW_GROUND_NILL) then
            mario_grab_used_object(updatingMarioState)
            if updatingMarioState.heldObj ~= nil then
                if (updatingMarioState.action & ACT_FLAG_AIR) ~= 0 then
                    set_mario_action(updatingMarioState, ACT_GENERAL_THING, 0)
                else
                    set_mario_action(updatingMarioState, ACT_STANDING_NIL, 0)
                end
                updatingMarioState.actionState = 1
            end
        end
    end
    if _G.charSelect.character_get_current_number(m.playerIndex) == CT_NILL then
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
    local s = nilExtraStates3[m.playerIndex]

    m.peakHeight = m.pos.y
    if m.hurtCounter >= 1 then
        m.health = m.health - 512
        m.hurtCounter = 0
        m.invincTimer = 30
    end
    -- djui_chat_message_create("VelController = " .. VelController)
end

function before_NIL_update(m)
    if _G.charSelect.character_get_current_number(m.playerIndex) == CT_NILL then
        if m.action == ACT_IDLE then
            m.action = ACT_STANDING_NIL
        end
        if m.action == ACT_WALKING then
            m.action = ACT_WALKING_NIL
        end
    end
end

--hook_event(HOOK_BEFORE_MARIO_UPDATE, before_NIL_update)

function allowwater(m)
    if _G.charSelect.character_get_current_number(m.playerIndex) == CT_NILL then
        if m.pos.y <= m.waterLevel then
            return false
        end
    end
end

--hook_event(HOOK_ALLOW_FORCE_WATER_ACTION, allowwater)


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
function iwalkonlava(m) return not (_G.charSelect.character_get_current_number(m.playerIndex) == CT_NILL) end

--hook_event(HOOK_ALLOW_HAZARD_SURFACE, iwalkonlava)
