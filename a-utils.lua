
nilname = "\\#f0D\\nil"


function convert_s16(num)
    local min = -32768
    local max = 32767
    while (num < min) do
        num = max + (num - min)
    end
    while (num > max) do
        num = min + (num - max)
    end
    return num
end
function s16(x)
    x = (math.floor(x) & 0xFFFF)
    if x >= 32768 then return x - 65536 end
    return x
end
function s32(x)
    x = (math.floor(x) & 0xFFFFFFFF)
    if x >= 2147483648 then return x - 4294967296 end
    return x
end
function interact_w_door(m)
    local wdoor = obj_get_nearest_object_with_behavior_id(m.marioObj, id_bhvDoorWarp)
    local door = obj_get_nearest_object_with_behavior_id(m.marioObj, id_bhvDoor)
    local sdoor = obj_get_nearest_object_with_behavior_id(m.marioObj, id_bhvStarDoor)

    if door ~= nil and dist_between_objects(m.marioObj, door) < 150 then
        interact_door(m, 0, door)
        --djui_chat_message_create("door.")
        if door.oAction == 0 then
            if (should_push_or_pull_door(m, door) & 1) ~= 0 then
                door.oInteractStatus = 0x00010000
            else
                door.oInteractStatus = 0x00020000
            end
        end
    elseif sdoor ~= nil and dist_between_objects(m.marioObj, sdoor) < 150 then
        interact_door(m, 0, sdoor)
        --djui_chat_message_create("star door.")
        if sdoor.oAction == 0 then
            if (should_push_or_pull_door(m, sdoor) & 1) ~= 0 then
                sdoor.oInteractStatus = 0x00010000
            else
                sdoor.oInteractStatus = 0x00020000
            end
        end
    elseif wdoor ~= nil and dist_between_objects(m.marioObj, wdoor) < 150 then
        interact_warp_door(m, 0, wdoor)
        set_mario_action(m, ACT_DECELERATING, 0)
        --djui_chat_message_create("warp door.")
        if wdoor.oAction == 0 then
            if (should_push_or_pull_door(m, wdoor) & 1) ~= 0 then
                wdoor.oInteractStatus = 0x00010000
            else
                wdoor.oInteractStatus = 0x00020000
            end
        end
    end
end





function walkingsounds(m) 
        local where = m.marioObj.header.gfx.cameraToObject
    if (((m.marioObj.header.gfx.animInfo.animFrame >= 7) and not (m.marioObj.header.gfx.animInfo.animFrame >= 10)) or ((m.marioObj.header.gfx.animInfo.animFrame >= 55) and not (m.marioObj.header.gfx.animInfo.animFrame >= 58))) then
        play_sound(SOUND_ACTION_METAL_STEP_WATER, where);
    end
end


function update_h_walking_speed(m) 

    local val = m.intendedMag / 1.5

    if (m.forwardVel <= 0.0) then
        m.forwardVel = m.forwardVel + 0.7
    elseif (m.forwardVel <= val) then
        m.forwardVel = m.forwardVel + 1.1 - m.forwardVel / 43.0
    elseif (m.floor ~= nil and m.floor.normal.y >= 0.95) then
        m.forwardVel = m.forwardVel - 1.0
    end

    if (m.forwardVel > 14.0) then
        m.forwardVel = 14.0
    end

    m.slideVelX = m.forwardVel * sins(m.faceAngle.y);
    m.slideVelZ = m.forwardVel * coss(m.faceAngle.y);

    m.vel.x = m.slideVelX
    m.vel.y = 0.0
    m.vel.z= m.slideVelZ
end



--random vanilla strings get code by: Blocky
local sVanillaStrings = {}

local ACT_COUNT = 6

function cache_vanilla_strings()
    if #sVanillaStrings > 0 then return end

    for course = COURSE_BOB, COURSE_RR do

        sVanillaStrings[#sVanillaStrings + 1] = smlua_text_utils_course_name_get(course)

        for act = 1, ACT_COUNT do
            sVanillaStrings[#sVanillaStrings + 1] = smlua_text_utils_act_name_get(course, act)
        end
    end

    for id = DIALOG_000, DIALOG_COUNT - 1 do
        sVanillaStrings[#sVanillaStrings + 1] = smlua_text_utils_dialog_get(id).text
    end
end

cache_vanilla_strings()

function split_words(string)
    local out = {}
    for word in string:gmatch("[^%s]+") do
        out[#out + 1] = word
    end
    return out
end

function get_string_from_random_vanilla_parts(wordCount)

    wordCount = wordCount or 1

    local out = {}
    for i = 1, wordCount do
        local base = sVanillaStrings[math.random(1, #sVanillaStrings)]
        local words = split_words(base)

        out[#out + 1] = words[math.random(1, #words)]
    end

    return table.concat(out, " ")
end


somari = false
--function used for built in support for some external mods
local function modsupport()
    for key, value in pairs(gActiveMods) do
        if ((value.name == "\\#7a5b1b\\Somari \\#aee1fe\\64: \\#fe8c0f\\DASH!") and string.match(value.incompatible, "romhack")) then
            somari = true
        end
    end
end


local servermodsync = false

--- @param m MarioState
--Called when a player connects
local function on_player_connected(m)
    -- only run on server
    if not network_is_server() then
        return
    end
    if servermodsync == false then --only run this once
        modsupport()               --mod check for host since on_join doesn't work for them
        servermodsync = true
    end
end

--Called when the local player finishes the join process (if the player isn't the host)
local function on_join()
    modsupport() --mod check for any player that isn't the host
end

hook_event(HOOK_ON_PLAYER_CONNECTED, on_player_connected) -- hook for player joining
hook_event(HOOK_JOINED_GAME, on_join)                     -- Called when the local player finishes the join process (if the player isn't the host)
