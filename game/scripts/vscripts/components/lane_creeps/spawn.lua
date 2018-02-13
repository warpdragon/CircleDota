-- Required by components/index
require('settings')

if SpawnLaneCreeps == nil then
    DebugPrint ('[lane_creeps/spawn] creating LaneCreep Spawner')
    SpawnLaneCreeps = class({})
end

function SpawnLaneCreeps:Init ()
  DebugPrint ('[lane_creeps/spawn] initialize')

  Timers:CreateTimer(function()
    if not self.Settings then
      self.Settings = buildLaneCreepSettings() -- build settings
      buildLaneCreepSettings = nil -- remove build function
    end
    self:SpawnCreeps()
    return self.Settings.SpawnInterval
  end)
end

-- Fancy function to spawn our lane creeps
-- it's desinged in a way so we don't need to write a function for every lane
function SpawnLaneCreeps:SpawnCreeps()
  -- First we loop through the first layer of our settings table.
  PrintTable(self.Settings.Lanes)
  for teamID,Lane in pairs(self.Settings.Lanes) do
    -- We get the teamID for later use and the table lane.
    -- Now we loop through the creeps to spawn them.
    for direction,Path in pairs(Lane.Paths) do
      for creepID,creepName in pairs(Lane.Creeps) do
      print('creepID:', creepID)
      -- creepID is used for calculating the delay
      -- creepName is the unit name we need to spawn our creep
        -- below we have a assert that can crash the function so we need to catch
        -- it before it can do anything
        print('WHOA?')
        -- First we spawn the creep.
        -- The `assert` here is to make sure the creep actually got spawned:
        --  If it didn't spawn the `creep` variable is `nil`
        --  `assert` checks if it is `nil` and then
        --  calls `error` with a text or a table.
        local hCreep = assert(CreateUnitByName(
          creepName,  -- class name
          -- we want to spawn the creep 10 to 200 units
          --  around the actual spawn position
          Path.Spawn + RandomVector(RandomInt(10, 200)), -- position
          true, -- find clear space
          nil, -- owner
          nil, -- owner
          teamID -- team
        ), {
          -- the error text for the assert
          msg = "error spawning creep: '" .. creepName .. "' is not a valid class name",
          creepID = creepID,
          teamID = teamID,
        })

        -- then we apply color with a helper function
        self:ApplyTeamColor(hCreep, teamID)

        -- We don't want the creeps to walk next to each other so we add some
        -- delay inbetween giving them orders.
        local delay = creepID * self.Settings.CreepInterval - self.Settings.CreepInterval
        local index = 0
        hCreep.Orders = {
          index = 1,
          Waypoints = {}
        }
        Timers:CreateTimer(delay, function()
          -- We loop through all the Waypoints and queue the orders.
          for WaypointGroupID,WaypointGroup in pairs(Path.Waypoints) do
            --[[
            print("teamID:", teamID, "teamshortname:", GetTeamName(teamID))
            print("Waypoint:", WaypointGroupID)
            PrintTable(WaypointGroup)
            print("condition:", WaypointGroup.condition)
            print("condition result:", WaypointGroup.condition())
            ]]
            for WaypointID,Waypoint in pairs(WaypointGroup[tostring(WaypointGroup.condition())]) do
              hCreep.Orders.Waypoints[index] = Waypoint
              index = index + 1
            end
          end
          ExecuteOrderFromTable(hCreep.Orders.Waypoints[0].buildOrder(hCreep))
        end)
      end
    end
  end
end

function SpawnLaneCreeps:ApplyTeamColor(hUnit, teamID)
  local vColor = TEAM_COLORS[teamID]
  hUnit:SetRenderColor(vColor[1], vColor[2], vColor[3])
end
