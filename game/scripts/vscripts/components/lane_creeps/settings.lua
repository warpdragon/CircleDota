
function buildLaneCreepSettings()
  -- we don't want to expose any functions to global
  --  if we don't need to expose them
  local function getPosition(name)
    -- find a entity and return its Position
    return GetGroundPosition(assert( -- assert that the entity is not
       Entities:FindByName(nil, name),
      "invalid entity: couldn't find entity by name: '" .. name .. "'"
    ):GetAbsOrigin(), -- assert return its first argument if it is not nil
    nil)
  end

  local Prefab = {
    water_fire = {
      condition = IsValidAlive(Entities:FindByName(nil, "fountain_water")),
      ["true"] = {
        getPosition("point_cc_water"),
        getPosition("fountain_water"),
        getPosition("point_c_water"),
      },
      ["false"] = {
        getPosition("point_1_oclock"),
        getPosition("point_2_oclock"),
      },
    },
    fire_water = {

    }
  }

  return {
    Lanes = {
      [DOTA_TEAM_GOODGUYS] = { -- air
        Paths = {
          clockwise = {
            Waypoints = {
              {
                condition = "always",
                ["always"] = {
                  getPosition("point_c_air"),
                  getPosition("point_12_oclock"),
                }
              },
              Prefab.water_fire,
              {
                condition = "always",
                ["always"] = {
                  getPosition("point_3_oclock"),
                }
              },
              {
                condition = tostring(IsValidAlive(Entities:FindByName(nil, "fountain_fire"))),
                ["true"] = {
                  getPosition("point_cc_fire"),
                  getPosition("fountain_fire"),
                  getPosition("point_c_fire"),
                },
                ["false"] = {
                  getPosition("point_4_oclock"),
                  getPosition("point_5_oclock"),
                }
              },
              {
                condition = "always",
                ["always"] = {
                  getPosition("point_6_oclock"),
                }
              },
              {
                condition = tostring(IsValidAlive(Entities:FindByName(nil, "fountain_earth"))),
                ["true"] = {
                  getPosition("point_cc_earth"),
                  getPosition("fountain_earth"),
                  getPosition("point_c_earth"),
                },
                ["false"] = {
                  getPosition("point_7_oclock"),
                  getPosition("point_8_oclock"),
                }
              },
              {
                condition = "always",
                ["always"] = {
                  getPosition("point_9_oclock"),
                  getPosition("point_10_oclock"),
                  getPosition("point_11_oclock"),
                  getPosition("point_12_oclock"),
                }
              }
            },
            Spawn = getPosition("point_c_air_spawn")
          },
          counterclockwise = {
            Waypoints = {
              {
                condition = "always",
                ["always"] = {
                  getPosition("point_cc_air"),
                  getPosition("point_9_oclock"),
                }
              },
              {
                condition = tostring(IsValidAlive(Entities:FindByName(nil, "fountain_earth"))),
                ["true"] = {
                  getPosition("point_c_air"),
                  getPosition("fountain_earth"),
                  getPosition("point_cc_air"),
                },
                ["false"] = {
                  getPosition("point_8_oclock"),
                  getPosition("point_7_oclock"),
                }
              },
              {
                condition = "always",
                ["always"] = {
                  getPosition("point_6_oclock"),
                }
              },
              {
                condition = tostring(IsValidAlive(Entities:FindByName(nil, "fountain_fire"))),
                ["true"] = {
                  getPosition("point_c_fire"),
                  getPosition("fountain_fire"),
                  getPosition("point_cc_fire"),
                },
                ["false"] = {
                  getPosition("point_5_oclock"),
                  getPosition("point_4_oclock"),
                }
              },
              {
                condition = "always",
                ["always"] = {
                  getPosition("point_3_oclock"),
                }
              },
              {
                condition = IsValidAlive(Entities:FindByName(nil, "fountain_water")),
                ["true"] = {
                  getPosition("point_c_water"),
                  getPosition("fountain_water"),
                  getPosition("point_cc_water"),
                },
                ["false"] = {
                  getPosition("point_2_oclock"),
                  getPosition("point_1_oclock"),
                }
              },
              {
                condition = "always",
                ["always"] = {
                  getPosition("point_12_oclock"),
                  getPosition("point_11_oclock"),
                  getPosition("point_10_oclock"),
                  getPosition("point_9_oclock"),
                }
              }
            },
            Spawn = getPosition("point_cc_air_spawn")
          }
        },
        Creeps = {
          "npc_dota_creep_air_ranged",
          "npc_dota_creep_air_melee",
          "npc_dota_creep_air_melee",
          "npc_dota_creep_air_melee",
        },
      },
      [DOTA_TEAM_BADGUYS] = { -- fire
        Waypoints = {
          getPosition("point_cc_fire"),
          getPosition("point_9_oclock"),
          getPosition("point_c_earth"),
          getPosition("fountain_earth")
        },
        Spawn = getPosition("point_cc_fire_spawn"),
        Creeps = {
          "npc_dota_creep_fire_ranged",
          "npc_dota_creep_fire_melee",
          "npc_dota_creep_fire_melee",
          "npc_dota_creep_fire_melee",
        }
      },
      [DOTA_TEAM_CUSTOM_1] = { -- water
        Waypoints = {
          getPosition("point_cc_water"),
          getPosition("point_9_oclock"),
          getPosition("point_c_earth"),
          getPosition("fountain_earth")
        },
        Spawn = getPosition("point_cc_water_spawn"),
        Creeps = {
          "npc_dota_creep_water_ranged",
          "npc_dota_creep_water_melee",
          "npc_dota_creep_water_melee",
          "npc_dota_creep_water_melee",
        }
      },
      [DOTA_TEAM_CUSTOM_2] = { -- earth
        Waypoints = {
          getPosition("point_c_earth"),
          getPosition("point_9_oclock"),
          getPosition("point_cc_air"),
          getPosition("fountain_air")
        },
        Spawn = getPosition("point_c_earth_spawn"),
        Creeps = {
          "npc_dota_creep_earth_ranged",
          "npc_dota_creep_earth_melee",
          "npc_dota_creep_earth_melee",
          "npc_dota_creep_earth_melee",
        }
      }
    },
    SpawnInterval = 30.0,
    CreepInterval = 5.0
  }
end
