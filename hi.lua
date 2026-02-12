--ahah i like goombas
gPlayerSyncTable[0].hasstar = false
gPlayerSyncTable[0].hashi = false
gPlayerSyncTable[0].hasHurt = false

KBACTS = {
    [ACT_FORWARD_AIR_KB] = true,
    [ACT_BACKWARD_AIR_KB] = true,
    [ACT_BACKWARD_GROUND_KB] = true,
    [ACT_FORWARD_GROUND_KB] = true,
    [ACT_HARD_FORWARD_AIR_KB] = true,
    [ACT_HARD_BACKWARD_AIR_KB] = true,
    [ACT_SOFT_BACKWARD_GROUND_KB] = true,
    [ACT_SOFT_FORWARD_GROUND_KB] = true,
}




function nilmessage(string)
    play_sound(SOUND_MENU_MESSAGE_APPEAR, gLakituState.curPos)
    djui_chat_message_create(nilname .. "\\#dcdcdc\\: " .. string)
end

function nil_chat_hurt(m)
    if m.playerIndex ~= 0 then return end

    local s = gPlayerSyncTable[0]

    local poss3 = math.random(1, 3)

    if _G.charSelect.character_get_current_number(m.playerIndex) == CT_NILL then
        if KBACTS[m.action] == true then
            if m.hurtCounter ~= 0 and s.hasHurt == false then
                set_mario_action(m, ACT_GENERAL_THING, 0)
                m.invincTimer = 30
                if m.playerIndex == 0 then
                if poss3 == 1 then
                    nilmessage("Ouchie..")
                elseif poss3 == 2 then
                    nilmessage("Oow...")
                elseif poss3 == 3 then
                    nilmessage("ahhg!")
                end
            end
            end
        end
    end
end

--hook_event(HOOK_ON_SET_MARIO_ACTION, nil_chat_hurt)


function on_warp(m)
    gPlayerSyncTable[0].hashi = false
    gPlayerSyncTable[0].hasstar = false
end

--hook_event(HOOK_ON_WARP, on_warp)

gPlayerSyncTable[0].greatings = true
