-- Required by components/index
function InitModule(myModule)
  if myModule ~= nil then
    myModule:Init()
  end
end

if SpawnLaneCreeps == nil then
    DebugPrint ( '[lane_creeps/spawn] spawning lane creeps' )
    SpawnLaneCreeps = class({})
end

local LaneSpawnInterval = 30.0
local StartAfter = 30.0

function SpawnLaneCreeps:Init ()
  	DebugPrint ( '[lane_creeps/spawn] initialize' )
  	SpawnLaneCreeps = self
  	Timers:CreateTimer(Dynamic_Wrap(SpawnLaneCreeps, 'LaneCreepTimer'))
end

function SpawnLaneCreeps:LaneCreepTimer ()
  	print ('LaneCreepTimer')
  	SpawnAirCreeps()
  	SpawnFireCreeps()
  	SpawnWaterCreeps()
  	SpawnEarthCreeps()
  	return LaneSpawnInterval
end

function SpawnAirCreeps()
    local point = Entities:FindByName( nil, "point_cc_air_spawn"):GetAbsOrigin()
    local point2 = Entities:FindByName( nil, "point_cc_air"):GetAbsOrigin()
    local point3 = Entities:FindByName( nil, "point_9_oclock"):GetAbsOrigin()
    local point4 = Entities:FindByName( nil, "point_c_earth"):GetAbsOrigin()
    local point5 = Entities:FindByName( nil, "fountain_earth"):GetAbsOrigin()
    local units_to_spawn = 4  
    for i=1,units_to_spawn do
      Timers:CreateTimer(StartAfter, function()
          	local unit = nil
          	if i==1 then
            	unit = CreateUnitByName("npc_dota_creep_air_ranged", point+RandomVector(RandomInt(100,200)), true, nil, nil, DOTA_TEAM_GOODGUYS)
          	else
          		unit = CreateUnitByName("npc_dota_creep_air_melee", point+RandomVector(RandomInt(100,200)), true, nil, nil, DOTA_TEAM_GOODGUYS)

            end
            unit:SetRenderColor(255,224,192)
            ExecuteOrderFromTable({ UnitIndex = unit:GetEntityIndex(),
                                    OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
                                    Position = point2, Queue = true})
            ExecuteOrderFromTable({ UnitIndex = unit:GetEntityIndex(),
                                    OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
                                    Position = point3, Queue = true})
            ExecuteOrderFromTable({ UnitIndex = unit:GetEntityIndex(),
                                    OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
                                    Position = point4, Queue = true})
            ExecuteOrderFromTable({ UnitIndex = unit:GetEntityIndex(),
                                    OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
                                    Position = point5, Queue = true})
        end)
    end
end

function SpawnFireCreeps()

end

function SpawnWaterCreeps()

end

function SpawnEarthCreeps()
    local point = Entities:FindByName( nil, "point_c_earth_spawn"):GetAbsOrigin()
    local point2 = Entities:FindByName( nil, "point_c_earth"):GetAbsOrigin()
    local point3 = Entities:FindByName( nil, "point_9_oclock"):GetAbsOrigin()
    local point4 = Entities:FindByName( nil, "point_cc_air"):GetAbsOrigin()
    local point5 = Entities:FindByName( nil, "fountain_air"):GetAbsOrigin()
    local units_to_spawn = 4  
    for i=1,units_to_spawn do
        Timers:CreateTimer(StartAfter, function()
          	local unit = nil
          	if i==1 then
            	unit = CreateUnitByName("npc_dota_creep_earth_ranged", point+RandomVector(RandomInt(100,200)), true, nil, nil, DOTA_TEAM_CUSTOM_2)
          	else
          		unit = CreateUnitByName("npc_dota_creep_earth_melee", point+RandomVector(RandomInt(100,200)), true, nil, nil, DOTA_TEAM_CUSTOM_2)
            end
            unit:SetRenderColor(96,255,64)
            ExecuteOrderFromTable({ UnitIndex = unit:GetEntityIndex(),
                                    OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
                                    Position = point2, Queue = true})
            ExecuteOrderFromTable({ UnitIndex = unit:GetEntityIndex(),
                                    OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
                                    Position = point3, Queue = true})
            ExecuteOrderFromTable({ UnitIndex = unit:GetEntityIndex(),
                                    OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
                                    Position = point4, Queue = true})
            ExecuteOrderFromTable({ UnitIndex = unit:GetEntityIndex(),
                                    OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
                                    Position = point5, Queue = true})
        end)
    end
end
