
function buildLaneCreepSettings()
  local Waypoints = {}
  -- we don't want to expose any functions to global
  --  if we don't need to expose them
  local function getPosition(name)
    return GetGroundPosition(assert(
      Entities:FindByName(nil, name),
      "invalid entity: couldn't find entity by name: '" .. name .. "'"
    ):GetAbsOrigin(), nil)
  end

  local function buildWaypoint(name)
    -- build a new Waypoint if it doesn't exist already and return it
    if not Waypoints[name] then
      Waypoints[name] = {
        buildOrder = function(hUnit)
          return {
            UnitIndex = hUnit:entindex(),
            OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
            Position = getPosition(name), --Optional.  Only used when targeting the ground
            Queue = 1 --Optional.  Used for queueing up abilities
          }
        end,
        Zone = Entities:FindByName(nil, "zone_" .. name)
      }
    end
    return Waypoints[name]
  end

  local function buildSinglePoint(iTime)
    return {
      condition = function() return "always" end,
      ["always"] = {
        buildWaypoint("point_" .. tostring(iTime) .. "_oclock"),
      }
    }
  end

  -- redirect output
  local function startTouchHandler(keys)
    local hTrigger = keys.caller
    local hActivator = keys.activator
    print(hTrigger)

    local index = hActivator.Orders.index
    local Waypoint = hActivator.Orders.Waypoints[index]
    print(index)
    if Waypoint.Zone == hTrigger then
      ExecuteOrderFromTable(Waypoint.buildOrder(hActivator))
      if hActivator.Orders.Waypoints[index + 1] then
        index = index + 1
      end
    end
  end
  for Waypoint in Waypoints do
    Waypoint.Zone.startTouchHandler = startTouchHandler
    Waypoint.Zone:RedirectOutput('OnStartTouch', 'startTouchHandler', Waypoint.Zone)
  end


  local Prefab = {
    air_c = {
      condition = function() return IsValidAlive(Entities:FindByName(nil, "fountain_air")) end,
      ["true"] = {
        buildWaypoint("point_cc_air"),
        buildWaypoint("fountain_air"),
        buildWaypoint("point_c_air"),
      },
      ["false"] = {
        buildWaypoint("point_10_oclock"),
        buildWaypoint("point_11_oclock"),
      },
    },
    air_cc = {
      condition = function() return IsValidAlive(Entities:FindByName(nil, "fountain_air")) end,
      ["true"] = {
        buildWaypoint("point_c_air"),
        buildWaypoint("fountain_air"),
        buildWaypoint("point_cc_air"),
      },
      ["false"] = {
        buildWaypoint("point_11_oclock"),
        buildWaypoint("point_10_oclock"),
      }
    },
    water_c = {
      condition = function() return IsValidAlive(Entities:FindByName(nil, "fountain_water")) end,
      ["true"] = {
        buildWaypoint("point_cc_water"),
        buildWaypoint("fountain_water"),
        buildWaypoint("point_c_water"),
      },
      ["false"] = {
        buildWaypoint("point_1_oclock"),
        buildWaypoint("point_2_oclock"),
      },
    },
    water_cc = {
      condition = function() return IsValidAlive(Entities:FindByName(nil, "fountain_water")) end,
      ["true"] = {
        buildWaypoint("point_c_water"),
        buildWaypoint("fountain_water"),
        buildWaypoint("point_cc_water"),
      },
      ["false"] = {
        buildWaypoint("point_2_oclock"),
        buildWaypoint("point_1_oclock"),
      }
    },
    fire_c = {
      condition = function() return IsValidAlive(Entities:FindByName(nil, "fountain_fire")) end,
      ["true"] = {
        buildWaypoint("point_cc_fire"),
        buildWaypoint("fountain_fire"),
        buildWaypoint("point_c_fire"),
      },
      ["false"] = {
        buildWaypoint("point_4_oclock"),
        buildWaypoint("point_5_oclock"),
      }
    },
    fire_cc = {
      condition = function() return IsValidAlive(Entities:FindByName(nil, "fountain_fire")) end,
      ["true"] = {
        buildWaypoint("point_c_fire"),
        buildWaypoint("fountain_fire"),
        buildWaypoint("point_cc_fire"),
      },
      ["false"] = {
        buildWaypoint("point_5_oclock"),
        buildWaypoint("point_4_oclock"),
      }
    },
    earth_c = {
      condition = function() return IsValidAlive(Entities:FindByName(nil, "fountain_earth")) end,
      ["true"] = {
        buildWaypoint("point_cc_earth"),
        buildWaypoint("fountain_earth"),
        buildWaypoint("point_c_earth"),
      },
      ["false"] = {
        buildWaypoint("point_7_oclock"),
        buildWaypoint("point_8_oclock"),
      }
    },
    earth_cc = {
      condition = function() return IsValidAlive(Entities:FindByName(nil, "fountain_earth")) end,
      ["true"] = {
        buildWaypoint("point_c_earth"),
        buildWaypoint("fountain_earth"),
        buildWaypoint("point_cc_earth"),
      },
      ["false"] = {
        buildWaypoint("point_8_oclock"),
        buildWaypoint("point_7_oclock"),
      }
    },
    air_c_12 = {
      condition = function() return "always" end,
      ["always"] = {
        buildWaypoint("point_c_air"),
        buildWaypoint("point_12_oclock"),
      }
    },
    air_cc_9 = {
      condition = function() return "always" end,
      ["always"] = {
        buildWaypoint("point_cc_air"),
        buildWaypoint("point_9_oclock"),
      }
    },
    fire_c_6 = {
      condition = function() return "always" end,
      ["always"] = {
        buildWaypoint("point_c_fire"),
        buildWaypoint("point_6_oclock"),
      }
    },
    fire_cc_3 = {
      condition = function() return "always" end,
      ["always"] = {
        buildWaypoint("point_cc_fire"),
        buildWaypoint("point_3_oclock"),
      }
    },
    water_c_3 = {
      condition = function() return "always" end,
      ["always"] = {
        buildWaypoint("point_c_water"),
        buildWaypoint("point_3_oclock"),
      }
    },
    water_cc_12 = {
      condition = function() return "always" end,
      ["always"] = {
        buildWaypoint("point_cc_water"),
        buildWaypoint("point_12_oclock"),
      }
    },
    earth_c_9 = {
      condition = function() return "always" end,
      ["always"] = {
        buildWaypoint("point_c_earth"),
        buildWaypoint("point_9_oclock"),
      }
    },
    earth_cc_6 = {
      condition = function() return "always" end,
      ["always"] = {
        buildWaypoint("point_cc_earth"),
        buildWaypoint("point_6_oclock"),
      }
    },
    point_3 = buildSinglePoint(3),
    point_6 = buildSinglePoint(6),
    point_9 = buildSinglePoint(9),
    point_12 = buildSinglePoint(12)
  }

  return {
    Lanes = {
      [DOTA_TEAM_GOODGUYS] = { -- air
        Paths = {
          clockwise = {
            Spawn = getPosition("point_c_air_spawn"),
            Waypoints = {
              Prefab.air_c_12,
              Prefab.water_c,
              Prefab.point_3,
              Prefab.fire_c,
              Prefab.point_6,
              Prefab.earth_c,
              {
                condition = function() return "always" end,
                ["always"] = {
                  buildWaypoint("point_9_oclock"),
                  buildWaypoint("point_10_oclock"),
                  buildWaypoint("point_11_oclock"),
                  buildWaypoint("point_12_oclock"),
                }
              }
            }
          },
          counterclockwise = {
            Spawn = getPosition("point_cc_air_spawn"),
            Waypoints = {
              Prefab.air_cc_9,
              Prefab.earth_cc,
              Prefab.point_6,
              Prefab.fire_cc,
              Prefab.point_3,
              Prefab.water_cc,
              {
                condition = function() return "always" end,
                ["always"] = {
                  buildWaypoint("point_12_oclock"),
                  buildWaypoint("point_11_oclock"),
                  buildWaypoint("point_10_oclock"),
                  buildWaypoint("point_9_oclock"),
                }
              }
            }
          }
        },
        Creeps = {
          "npc_dota_creep_air_ranged",
          "npc_dota_creep_air_melee",
          "npc_dota_creep_air_melee",
          "npc_dota_creep_air_melee",
        }
      },
      [DOTA_TEAM_BADGUYS] = { -- fire
        Paths = {
          clockwise = {
            Spawn = getPosition("point_c_fire_spawn"),
            Waypoints = {
              Prefab.fire_c_7,
              Prefab.earth_c,
              Prefab.point_9,
              Prefab.air_c,
              Prefab.point_12,
              Prefab.water_c,
              {
                condition = function() return "always" end,
                ["always"] = {
                  buildWaypoint("point_3_oclock"),
                  buildWaypoint("point_4_oclock"),
                  buildWaypoint("point_5_oclock"),
                  buildWaypoint("point_6_oclock"),
                }
              }
            }
          },
          counterclockwise = {
            Spawn = getPosition("point_cc_fire_spawn"),
            Waypoints = {
              Prefab.fire_cc_3,
              Prefab.water_cc,
              Prefab.point_12,
              Prefab.water_cc,
              Prefab.point_9,
              Prefab.earth_cc,
              {
                condition = function() return "always" end,
                ["always"] = {
                  buildWaypoint("point_6_oclock"),
                  buildWaypoint("point_5_oclock"),
                  buildWaypoint("point_4_oclock"),
                  buildWaypoint("point_3_oclock"),
                }
              }
            }
          }
        },
        Creeps = {
          "npc_dota_creep_fire_ranged",
          "npc_dota_creep_fire_melee",
          "npc_dota_creep_fire_melee",
          "npc_dota_creep_fire_melee",
        }
      },
      [DOTA_TEAM_CUSTOM_1] = { -- water
        Paths = {
          clockwise = {
            Spawn = getPosition("point_c_water_spawn"),
            Waypoints = {
              Prefab.water_c_3,
              Prefab.fire_c,
              Prefab.point_6,
              Prefab.earth_c,
              Prefab.point_9,
              Prefab.air_c,
              {
                condition = function() return "always" end,
                ["always"] = {
                  buildWaypoint("point_12_oclock"),
                  buildWaypoint("point_1_oclock"),
                  buildWaypoint("point_2_oclock"),
                  buildWaypoint("point_3_oclock"),
                }
              }
            }
          },
          counterclockwise = {
            Spawn = getPosition("point_cc_water_spawn"),
            Waypoints = {
              Prefab.water_cc_12,
              Prefab.air_cc,
              Prefab.point_9,
              Prefab.earth_cc,
              Prefab.point_6,
              Prefab.fire_cc,
              {
                condition = function() return "always" end,
                ["always"] = {
                  buildWaypoint("point_3_oclock"),
                  buildWaypoint("point_2_oclock"),
                  buildWaypoint("point_1_oclock"),
                  buildWaypoint("point_12_oclock"),
                }
              }
            }
          }
        },
        Creeps = {
          "npc_dota_creep_water_ranged",
          "npc_dota_creep_water_melee",
          "npc_dota_creep_water_melee",
          "npc_dota_creep_water_melee",
        }
      },
      [DOTA_TEAM_CUSTOM_2] = { -- earth
        Paths = {
          clockwise = {
            Spawn = getPosition("point_c_earth_spawn"),
            Waypoints = {
              Prefab.earth_c_9,
              Prefab.air_c,
              Prefab.point_12,
              Prefab.water_c,
              Prefab.point_3,
              Prefab.fire_c,
              {
                condition = function() return "always" end,
                ["always"] = {
                  buildWaypoint("point_6_oclock"),
                  buildWaypoint("point_7_oclock"),
                  buildWaypoint("point_8_oclock"),
                  buildWaypoint("point_9_oclock"),
                }
              }
            }
          },
          counterclockwise = {
            Spawn = getPosition("point_cc_earth_spawn"),
            Waypoints = {
              Prefab.earth_cc_6,
              Prefab.fire_cc,
              Prefab.point_3,
              Prefab.water_c,
              Prefab.point_12,
              Prefab.air_c,
              {
                condition = function() return "always" end,
                ["always"] = {
                  buildWaypoint("point_9_oclock"),
                  buildWaypoint("point_8_oclock"),
                  buildWaypoint("point_7_oclock"),
                  buildWaypoint("point_6_oclock"),
                }
              }
            }
          }
        },
        Creeps = {
          "npc_dota_creep_earth_ranged",
          "npc_dota_creep_earth_melee",
          "npc_dota_creep_earth_melee",
          "npc_dota_creep_earth_melee",
        }
      }
    },
    SpawnInterval = 30,
    CreepInterval = .3
  }
end
