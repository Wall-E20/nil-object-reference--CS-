--ahah i like goombas
gPlayerSyncTable[0].hasstar = false
gPlayerSyncTable[0].hashi = false

 function chatsound(_) play_sound(SOUND_MENU_MESSAGE_APPEAR, gLakituState.curPos) end

 function nilmessage(string)
    djui_chat_message_create(nilname .. "\\#dcdcdc\\: " .. string)
end


local function hi_goombas(m)
    if _G.charSelect.character_get_current_number(m.playerIndex) == CT_NILL then
            if m.playerIndex ~= 0 then return end
        local s = gPlayerSyncTable[m.playerIndex]
        local obj = obj_get_nearest_object_with_behavior_id(m.marioObj, id_bhvGoomba)

        if obj and dist_between_objects(obj, m.marioObj) <= 500 then
            if hashi == false then
                hashi = true
                local getnumber = math.random(1, 4)

                if getnumber == 1 then
                    chatsound()
                    nilmessage("hello Goomba :D")
                elseif getnumber == 2 then
                    chatsound()
                    nilmessage("look! A Goomba! hii")
                elseif getnumber == 3 then
                    chatsound()
                    nilmessage("a Goomba!, cool")
                elseif getnumber == 4 then
                    chatsound()
                    nilmessage("Goomba :3")
                end
            end
        end
    end
end
hook_event(HOOK_MARIO_UPDATE, hi_goombas)


local function nil_chat_messages(m)
    if m.playerIndex ~= 0 then return end
    local s = gPlayerSyncTable[m.playerIndex]
    local poss3 = math.random(1, 3)
    local poss4 = math.random(1, 4)
    if _G.charSelect.character_get_current_number(m.playerIndex) == CT_NILL then
        if m.hurtCounter > 0 then
            if poss3 == 1 then
                chatsound()
                nilmessage("Ouchie..")
            elseif poss3 == 2 then
                chatsound()
                nilmessage("Oow...")
            elseif poss3 == 3 then
                chatsound()
                nilmessage("ahhg!")
            end
            m.hurtCounter = 0
m.health = 1 << 8
        end
        if m.action == ACT_STAR_DANCE_WATER and gPlayerSyncTable[0].hasstar == false and (is_anim_past_frame(m, 15) ~= 0) then
            if poss4 == 1 then
                chatsound()
                nilmessage("here we go!")
            elseif poss4 == 2 then
                chatsound()
                nilmessage("gg!")
            elseif poss4 == 3 then
                chatsound()
                nilmessage("great job <3")
            elseif poss4 == 4 then
                chatsound()
                nilmessage("we have " .. m.numStars .. " now :3")
            end
            gPlayerSyncTable[0].hasstar = true
        end
    end
end
hook_event(HOOK_MARIO_UPDATE, nil_chat_messages)


local function on_warp(m)
    gPlayerSyncTable[0].hashi = false
    gPlayerSyncTable[0].hasstar = false
end
hook_event(HOOK_ON_WARP, on_warp)

gPlayerSyncTable[0].greatings = true
hook_event(HOOK_UPDATE, function()
    if gPlayerSyncTable[0].greatings == true and get_global_timer() % 20 == 0 then
        gPlayerSyncTable[0].greatings = false
        chatsound()
        nilmessage("oh hihi " .. gNetworkPlayers[0].name .. "!")
    end
end)
