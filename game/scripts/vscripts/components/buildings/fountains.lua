-- Required by components/index
function InitModule(fountainModule)
  if fountainModule ~= nil then
    fountainModule:Init()
  end
end

if SpawnFountains == nil then
	DebugPrint ( '[buildings/fountains] spawning fountains' )
	SpawnFountains = class({})
end


function SpawnFountains:Init ()
	DebugPrint ( '[buildings/fountains] initialize' )
	SpawnFountains = self
	SpawnAirFountain()
	SpawnEarthFountain()

end

function SpawnAirFountain()
	local pointFountain = Entities:FindByName( nil, "fountain_air"):GetAbsOrigin()
	local unitFountain = CreateUnitByName("npc_dota_air_fountain", pointFountain, true, nil, nil, DOTA_TEAM_GOODGUYS)
	unitFountain:SetRenderColor(255,224,192)
	print ("air fountain")
end

function SpawnFireFountain()

end

function SpawnWaterFountain()

end

function SpawnEarthFountain()
	local pointFountain = Entities:FindByName( nil, "fountain_earth"):GetAbsOrigin()
	local unitFountain = CreateUnitByName("npc_dota_earth_fountain", pointFountain, true, nil, nil, DOTA_TEAM_CUSTOM_2)
	unitFountain:SetRenderColor(96,255,64)
	print ("earth fountain")

end
