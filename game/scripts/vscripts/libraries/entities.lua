--[[
Checks if the passed entity is a valid entity and alive
]]
function IsValidAlive(entity)
  return IsValidEntity(entity) and entity:IsAlive()
end
