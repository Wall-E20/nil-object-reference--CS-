_G.ACT_GENERAL_THING = allocate_mario_action(ACT_FLAG_AIR | ACT_FLAG_ALLOW_FIRST_PERSON | ACT_FLAG_MOVING |
    ACT_FLAG_CUSTOM_ACTION)



nilExtraStates2 = {}
for i = 0, (MAX_PLAYERS - 1) do
    nilExtraStates2[i] = {}
    local e = nilExtraStates2[i]
    e.VelController = 1
    e.sidewaysSpeed = 0
    e.intendedDYaw = 0
    e.intendedMag = 0
    e.speedbug = false
    e.freecamera = false
end



local function cameramode(m)
        local s = nilExtraStates2[m.playerIndex]
    if camera_config_is_free_cam_enabled() then
        s.freecamera = true
    else
        s.freecamera = false
    end
end
hook_event(HOOK_MARIO_UPDATE, cameramode)


function the_whole_thing_act(m)
    
    local s = nilExtraStates2[m.playerIndex]
    if m.heldObj ~= nil then
        set_character_animation(m, CHAR_ANIM_IDLE_HEAVY_OBJ)
        if (m.input & INPUT_B_PRESSED ~= 0) then
            set_mario_action(m, ACT_AIR_THROW, 0)
        end
    else
        set_character_animation(m, CHAR_ANIM_A_POSE)
    end
    if s.freecamera == false then
        set_camera_mode(m.area.camera, CAMERA_MODE_BEHIND_MARIO, 1)
    end
    if s.freecamera == false then
        m.faceAngle.y = m.intendedYaw - approach_s32(s16(m.intendedYaw - m.faceAngle.y), 0, 0x800, 0x800);
    else
        if m.playerIndex ~= 0 then
        else
            gMarioStates[m.playerIndex].faceAngle.y = gLakituState.yaw - 32767
        end
    end

    if m.vel.y > 0 then
        m.vel.y = m.vel.y - 1.5
    end
    if m.vel.y >= 75 then
        m.vel.y = m.vel.y - 10
    end
    if m.vel.y < 0 then
        m.vel.y = m.vel.y + 1.5
    end
    if m.pos.y == m.floorHeight and m.vel.y < 0 then
        m.vel.y = 0
    end





    if (m.input & INPUT_NONZERO_ANALOG) ~= 0 then
        if s.freecamera then
            if m.controller.stickX < 0 then
                s.VelController = s.VelController + 1
                if somari == false then
                    if s.VelController >= 32 then
                        s.VelController = s.VelController - 1
                    end
                end
            end
            if m.controller.stickX > 0 then
                s.VelController = s.VelController - 1
                if somari == false then
                    if s.VelController <= -32 then
                        s.VelController = s.VelController + 1
                    end
                end
            end
            --m.controller.stickY > 0
            s.intendedDYaw = m.intendedYaw - m.faceAngle.y;
            s.intendedMag = m.intendedMag / 32.0

            m.forwardVel = m.forwardVel + s.intendedMag * coss(s.intendedDYaw) * 1.5
            s.sidewaysSpeed = s.intendedMag * sins(s.intendedDYaw) * 1
        end
        if somari == false then
            if m.forwardVel >= 35 then
                m.forwardVel = m.forwardVel - 2.5
            end
        end
        if m.forwardVel <= -32 then
            m.forwardVel = m.forwardVel + 2.5
        end
        if s.freecamera then
            if m.controller.stickY > 0 then
                set_character_animation(m, CHAR_ANIM_WATER_ACTION_END)
            end

            if m.controller.stickY < 0 then
                set_character_animation(m, CHAR_ANIM_WATER_ACTION_END_WITH_OBJ)
            end

            if m.controller.stickX > 0 then
                set_character_animation(m, CHAR_ANIM_WATER_IDLE)
            end

            if m.controller.stickX < 0 then
                set_character_animation(m, CHAR_ANIM_WATER_IDLE_WITH_OBJ)
            end
        else
            set_character_animation(m, CHAR_ANIM_WATER_ACTION_END)
        end
        if s.freecamera then
            if s.VelController < 0 and m.controller.stickX < 0 then
                s.VelController = s.VelController + 1
            end
            if s.VelController > 0 and m.controller.stickX > 0 then
                s.VelController = s.VelController - 1
            end
            m.vel.x = m.forwardVel * sins(m.faceAngle.y);
            m.vel.z = m.forwardVel * coss(m.faceAngle.y);
        end
    end
    if s.freecamera then
        m.vel.x = m.vel.x + (s.sidewaysSpeed + s.VelController) * sins(m.faceAngle.y + 0x4000);
        m.vel.z = m.vel.z + (s.sidewaysSpeed + s.VelController) * coss(m.faceAngle.y + 0x4000);
    end
    if (m.input & INPUT_NONZERO_ANALOG) == 0 then
        if s.VelController > 0 then
            s.VelController = s.VelController - 1
        end

        if s.VelController < 0 then
            s.VelController = s.VelController + 1
        end
        if m.forwardVel <= 0 then
            m.forwardVel = m.forwardVel + 1
        else
            m.forwardVel = m.forwardVel - 1
        end
        if m.forwardVel >= 0 then
            m.forwardVel = m.forwardVel - 1
        else
            m.forwardVel = m.forwardVel + 1
        end
    end
    --[[
    djui_chat_message_create('frwrdvel = ' .. m.forwardVel)
    djui_chat_message_create('velx = ' .. m.vel.x)
    djui_chat_message_create('velz = ' .. m.vel.z)
    djui_chat_message_create('flyanim = ' .. flytimer)
    ]]

    if (m.controller.buttonDown & A_BUTTON ~= 0) then
        set_character_animation(m, CHAR_ANIM_DOUBLE_JUMP_RISE)
        playanim = true
        m.vel.y = m.vel.y + 3
        if m.vel.y >= 50 then
            m.vel.y = m.vel.y - 3
        end
    end

    if (m.controller.buttonPressed & Y_BUTTON) ~= 0 then
              reset_camera(m.area.camera)
        set_mario_action(m, ACT_FALL_NIL, 0)
    end
    if (m.controller.buttonDown & Z_TRIG ~= 0) then
        set_character_animation(m, CHAR_ANIM_DOUBLE_JUMP_FALL)
        if m.playerIndex ~= 0 then
        else
            if ((m.vel.x >= 180 or m.vel.z >= 180) or (m.vel.x <= -180 or m.vel.z <= -180)) and s.speedbug == false then
                s.speedbug = true
                chatsound()
                nilmessage("oh! looks like you discovered a bug! <3\n something like a blj or something :0")
            end
        end
        m.vel.y = m.vel.y - 3
        if m.vel.y <= -50 then
            m.vel.y = m.vel.y + 3
        end
        if m.pos.y == m.floorHeight then
            m.vel.y = 0
        end
    end
    interact_w_door(m)
    if m.pos.y == m.floorHeight and m.vel.y <= 0 then
        apply_slope_accel(m)
        perform_ground_step(m)
        update_air_without_turn(m)
    else
        perform_air_step(m, 0)
        update_air_without_turn(m)
    end
end

hook_mario_action(_G.ACT_GENERAL_THING, the_whole_thing_act)

function nilgravity(m)
    m.vel.y = m.vel.y
end

hook_mario_action(_G.ACT_GENERAL_THING, { gravity = nilgravity })


_G.ACT_STANDING_NIL = allocate_mario_action(ACT_FLAG_IDLE | ACT_FLAG_ALLOW_FIRST_PERSON | ACT_FLAG_STATIONARY |
    ACT_FLAG_CUSTOM_ACTION)

function act_idle_NIL(m)
    local s = nilExtraStates2[m.playerIndex]

    if m.heldObj ~= nil then
        if (m.input & INPUT_B_PRESSED ~= 0) then
            set_mario_action(m, ACT_THROW_GROUND_NILL, 0)
        end
    end

    if (m.input & INPUT_A_PRESSED ~= 0) then
        s.VelController = 0
        set_mario_action(m, ACT_JUMP_NIL, 0);
    end

    if (m.input & INPUT_FIRST_PERSON ~= 0) then
        s.VelController = 0
        set_mario_action(m, ACT_FIRST_PERSON,0)
    end

    if (m.input & INPUT_NONZERO_ANALOG ~= 0) then
        set_mario_action(m, ACT_WALKING_NIL, 0);
    end

    if m.heldObj ~= nil then
        set_character_animation(m, CHAR_ANIM_IDLE_WITH_LIGHT_OBJ)
    else
        set_character_animation(m, CHAR_ANIM_FIRST_PERSON)
    end
    if (is_anim_at_end(m) ~= 0) then
        m.actionState = 0;
    end
    if (m.controller.buttonPressed & Y_BUTTON) ~= 0 then
        s.VelController = 0
        set_mario_action(m, ACT_GENERAL_THING, 0);
    end
    local stepResult = perform_ground_step(m)
    if (stepResult == GROUND_STEP_LEFT_GROUND) then
        set_mario_action(m, ACT_FALL_NIL, 0);
        set_character_animation(m, CHAR_ANIM_GENERAL_FALL);
    end
    stop_and_set_height_to_floor(m)
end

hook_mario_action(_G.ACT_STANDING_NIL, act_idle_NIL)

_G.ACT_WALKING_NIL = allocate_mario_action(ACT_FLAG_MOVING | ACT_FLAG_MOVING |
    ACT_FLAG_CUSTOM_ACTION)


timer = 0

local function act_walking_NIL(m)
    local s = nilExtraStates2[m.playerIndex]
    local accel = 170000

    --    timer = timer + 3


    if m.heldObj ~= nil then
        set_mario_anim_with_accel(m, CHAR_ANIM_WALK_WITH_LIGHT_OBJ, accel);
        if (m.input & INPUT_B_PRESSED ~= 0) then
            set_mario_action(m, ACT_THROW_GROUND_NILL, 0)
        end
    else
        set_mario_anim_with_accel(m, CHAR_ANIM_WALKING, accel);
    end
    --[[
    set_anim_to_frame(m, timer)
    if is_anim_past_end(m) ~= 0 then
        timer = 0
    end
    --]]
    update_h_walking_speed(m)
    walkingsounds(m)

    if (m.input & INPUT_FIRST_PERSON ~= 0) then
        set_mario_action(m, ACT_FIRST_PERSON, 0);
    end

    if (m.controller.buttonDown & A_BUTTON) ~= 0 then
        s.VelController = 0
        set_mario_action(m, ACT_JUMP_NIL, 0);
    end

    if (m.input & INPUT_ZERO_MOVEMENT ~= 0) then
        set_mario_action(m, ACT_STANDING_NIL, 0);
    end
    if (m.controller.buttonPressed & Y_BUTTON) ~= 0 then
        s.VelController = 0
        set_mario_action(m, ACT_GENERAL_THING, 0);
    end


    m.faceAngle.y = m.intendedYaw - approach_s32((s16)(m.intendedYaw - m.faceAngle.y), 0, 0x800, 0x800);


    interact_w_door(m)
    local stepResult = perform_ground_step(m)
    if (stepResult == GROUND_STEP_LEFT_GROUND) then
        set_mario_action(m, ACT_FALL_NIL, 0);
        set_character_animation(m, CHAR_ANIM_GENERAL_FALL);
    end
end
hook_mario_action(_G.ACT_WALKING_NIL, act_walking_NIL)

_G.ACT_JUMP_NIL = allocate_mario_action(ACT_FLAG_MOVING | ACT_FLAG_AIR |
    ACT_FLAG_CUSTOM_ACTION | ACT_GROUP_AIRBORNE | ACT_FLAG_CONTROL_JUMP_HEIGHT)

local function act_jump_NIL(m)
    local s = nilExtraStates2[m.playerIndex]
    if m.heldObj ~= nil then
        if (m.input & INPUT_B_PRESSED ~= 0) then
            set_mario_action(m, ACT_AIR_THROW, 0)
        end
    end
    local where = m.marioObj.header.gfx.cameraToObject
    if m.actionTimer < 1 then
        m.vel.y = 40 + (m.forwardVel / 4)
        m.actionTimer = m.actionTimer + 1
        play_sound(SOUND_ACTION_METAL_JUMP_WATER, where)
    end
    if m.vel.y >= 0 then
        if m.heldObj ~= nil then
            anim = CHAR_ANIM_JUMP_WITH_LIGHT_OBJ
        else
            anim = CHAR_ANIM_SINGLE_JUMP
        end
    else
        if m.heldObj == nil then
            anim = CHAR_ANIM_GENERAL_FALL
        end
    end


    if (m.controller.buttonPressed & Y_BUTTON) ~= 0 then
        s.VelController = 0

        set_mario_action(m, ACT_GENERAL_THING, 0);
    end

    common_air_action_step(m, ACT_LAND_NIL, anim, AIR_STEP_NONE)
end



hook_mario_action(_G.ACT_JUMP_NIL, act_jump_NIL, INT_GROUND_POUND)

_G.ACT_FALL_NIL = allocate_mario_action(ACT_FLAG_MOVING | ACT_FLAG_AIR |
    ACT_FLAG_CUSTOM_ACTION | ACT_GROUP_AIRBORNE)

local function act_fall_NIL(m)
    local s = nilExtraStates2[m.playerIndex]
    if m.heldObj ~= nil then
        if (m.input & INPUT_B_PRESSED ~= 0) then
            set_mario_action(m, ACT_AIR_THROW, 0)
        end
    end
    if (m.controller.buttonPressed & Y_BUTTON) ~= 0 then
        s.VelController = 0
        set_mario_action(m, ACT_GENERAL_THING, 0);
    end

    if m.heldObj ~= nil then
        anim = CHAR_ANIM_JUMP_WITH_LIGHT_OBJ
    else
        anim = CHAR_ANIM_GROUND_POUND
    end

    common_air_action_step(m, ACT_LAND_NIL, anim, AIR_STEP_NONE)
end



hook_mario_action(_G.ACT_FALL_NIL, act_fall_NIL, INT_GROUND_POUND)

_G.ACT_LAND_NIL = allocate_mario_action(ACT_FLAG_IDLE | ACT_FLAG_IDLE|
    ACT_FLAG_CUSTOM_ACTION)
function act_land_NIL(m)
    local s = nilExtraStates2[m.playerIndex]
    m.actionState = m.actionState + 1
    local where = m.marioObj.header.gfx.cameraToObject
    if (m.controller.buttonPressed & Y_BUTTON) ~= 0 then
        s.VelController = 0
        set_mario_action(m, ACT_GENERAL_THING, 0);
    end

    if (m.input & INPUT_OFF_FLOOR) ~= 0 then
        set_mario_action(m, ACT_FALL_NIL, 0);
    end

    if m.actionState == 1 then
        play_sound(SOUND_ACTION_METAL_LAND_WATER, where)
    end
    if m.heldObj ~= nil then
        landing_step(m, CHAR_ANIM_FALL_LAND_WITH_LIGHT_OBJ, ACT_STANDING_NIL);
    else
        landing_step(m, CHAR_ANIM_GROUND_POUND_LANDING, ACT_STANDING_NIL);
    end
end

hook_mario_action(_G.ACT_LAND_NIL, act_land_NIL, INT_GROUND_POUND)

_G.ACT_THROW_GROUND_NILL = allocate_mario_action(ACT_FLAG_MOVING |
    ACT_FLAG_CUSTOM_ACTION)

local function act_ground_throw_nill(m)
    set_character_animation(m, CHAR_ANIM_GROUND_THROW)
    m.actionTimer = m.actionTimer + 1
    if m.actionTimer == 7 then
        mario_throw_held_object(m)
    end
    if is_anim_at_end(m) ~= 0 then
        set_mario_action(m, ACT_STANDING_NIL, 0)
    end
end



hook_mario_action(_G.ACT_THROW_GROUND_NILL, act_ground_throw_nill)
