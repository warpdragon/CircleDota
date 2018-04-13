-- Required by components/index
function InitModule(towerModule)
  if towerModule ~= nil then
    towerModule:Init()
  end
end

if SpawnTowers == nil then
	DebugPrint ( '[buildings/towers] spawning towers' )
	SpawnTowers = class({})
end


function SpawnTowers:Init ()
	DebugPrint ( '[buildings/towers] initialize' )
	SpawnTowers = self
	SpawnAirTowers()
	SpawnEarthTowers()

end

function SpawnAirTowers()
	local point1cc = Entities:FindByName( nil, "tier1_cc_air"):GetAbsOrigin()
	local point1c = Entities:FindByName( nil, "tier1_c_air"):GetAbsOrigin()
	local unit1cc = CreateUnitByName("npc_dota_air_tower1_counter_clockwise", point1cc, true, nil, nil, DOTA_TEAM_GOODGUYS)
	unit1cc:SetRenderColor(255,224,192)
	local unit1c = CreateUnitByName("npc_dota_air_tower1_clockwise", point1c, true, nil, nil, DOTA_TEAM_GOODGUYS)
	unit1c:SetRenderColor(255,224,192)
end

function SpawnFireTowers()

end

function SpawnWaterTowers()

end

function SpawnEarthTowers()
	local point1cc = Entities:FindByName( nil, "tier1_cc_earth"):GetAbsOrigin()
	local point1c = Entities:FindByName( nil, "tier1_c_earth"):GetAbsOrigin()
	local unit1cc = CreateUnitByName("npc_dota_earth_tower1_counter_clockwise", point1cc, true, nil, nil, DOTA_TEAM_CUSTOM_2)
	unit1cc:SetRenderColor(96,255,64)
	local unit1c = CreateUnitByName("npc_dota_earth_tower1_clockwise", point1c, true, nil, nil, DOTA_TEAM_CUSTOM_2)
	unit1c:SetRenderColor(96,255,64)
end
