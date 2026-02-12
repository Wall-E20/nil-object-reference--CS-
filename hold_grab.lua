--thanks to Altiami and other people on coop dx discord server for this!
---@type Vec3f
storedMarioPos = { x = 0.0, y = 0.0, z = 0.0 }

---@param interactingMarioState MarioState
---@param interactedObject Object
---@param interactionType InteractionType
---@return boolean
function on_allow_interact(interactingMarioState, interactedObject, interactionType)
    if interactionType ~= INTERACT_GRABBABLE or interactingMarioState == nil or interactedObject == nil  then
        return true
    end

    ---@type number
    local minDistance = interactedObject.hitboxRadius + interactingMarioState.marioObj.hitboxRadius + 5.0
    ---@type number
    local offsetX = interactingMarioState.pos.x - interactedObject.oPosX
    ---@type number
    local offsetZ = interactingMarioState.pos.z - interactedObject.oPosZ
    ---@type number
    local distance = math.sqrt(offsetX * offsetX + offsetZ * offsetZ)

    if distance < minDistance then
        vec3f_copy(storedMarioPos, interactingMarioState.pos)
    end

    return true
end

---@param interactingMarioState MarioState
---@param interactedObject Object
---@param interactionType InteractionType
---@param interactionInterrupted boolean
function on_interact(interactingMarioState, interactedObject, interactionType, interactionInterrupted)
    -- interaction cases not cared about
    if
        interactionType ~= INTERACT_GRABBABLE or
        interactingMarioState == nil or
        interactedObject == nil or
        interactingMarioState.playerIndex ~= 0 or
        interactedObject.oInteractionSubtype & INT_SUBTYPE_KICKABLE ~= 0 and
        interactedObject.oInteractStatus & INT_STATUS_WAS_ATTACKED ~= 0 or
        interactionInterrupted
    then
        return
    end

    if interactingMarioState.controller.buttonDown & B_BUTTON ~= 0 and
        interactedObject.oInteractionSubtype & INT_SUBTYPE_NOT_GRABBABLE == 0 
    then
        vec3f_copy(interactingMarioState.pos, storedMarioPos)
        interactingMarioState.interactObj = interactedObject
        interactingMarioState.input = interactingMarioState.input | INPUT_INTERACT_OBJ_GRABBABLE
        if interactedObject.oSyncID ~= 0 then
            network_send_object(interactedObject, false)
        end
    end
end

---comment



--hook_event(HOOK_ALLOW_INTERACT, on_allow_interact)
--hook_event(HOOK_ON_INTERACT, on_interact)
--hook_event(HOOK_MARIO_UPDATE, on_mario_update)
