
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

  local function buildSinglePoint(iTime)
    return {
      condition = "always",
      ["always"] = {
        getPosition("point_" .. tostring(iTime) .. "_oclock"),
      }
    }
  end

  local Prefab = {
    air_c = {
      condition = IsValidAlive(Entities:FindByName(nil, "fountain_air")),
      ["true"] = {
        getPosition("point_cc_air"),
        getPosition("fountain_air"),
        getPosition("point_c_air"),
      },
      ["false"] = {
        getPosition("point_10_oclock"),
        getPosition("point_11_oclock"),
      },
    },
    air_cc = {
      condition = IsValidAlive(Entities:FindByName(nil, "fountain_air")),
      ["true"] = {
        getPosition("point_c_air"),
        getPosition("fountain_air"),
        getPosition("point_cc_air"),
      },
      ["false"] = {
        getPosition("point_11_oclock"),
        getPosition("point_10_oclock"),
      }
    },
    water_c = {
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
    water_cc = {
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
    fire_c = {
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
    fire_cc = {
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
    earth_c = {
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
    earth_cc = {
      condition = tostring(IsValidAlive(Entities:FindByName(nil, "fountain_earth"))),
      ["true"] = {
        getPosition("point_c_earth"),
        getPosition("fountain_earth"),
        getPosition("point_cc_earth"),
      },
      ["false"] = {
        getPosition("point_8_oclock"),
        getPosition("point_7_oclock"),
      }
    },
    air_c_12 = {
      condition = "always",
      ["always"] = {
        getPosition("point_c_air"),
        getPosition("point_12_oclock"),
      }
    },
    air_cc_9 = {
      condition = "always",
      ["always"] = {
        getPosition("point_cc_air"),
        getPosition("point_9_oclock"),
      }
    },
    fire_c_6 = {
      condition = "always",
      ["always"] = {
        getPosition("point_c_fire"),
        getPosition("point_6_oclock"),
      }
    },
    fire_cc_3 = {
      condition = "always",
      ["always"] = {
        getPosition("point_cc_fire"),
        getPosition("point_3_oclock"),
      }
    },
    water_c_3 = {
      condition = "always",
      ["always"] = {
        getPosition("point_c_water"),
        getPosition("point_3_oclock"),
      }
    },
    water_cc_12 = {
      condition = "always",
      ["always"] = {
        getPosition("point_cc_water"),
        getPosition("point_12_oclock"),
      }
    },
    earth_c_9 = {
      condition = "always",
      ["always"] = {
        getPosition("point_c_earth"),
        getPosition("point_9_oclock"),
      }
    },
    earth_cc_6 = {
      condition = "always",
      ["always"] = {
        getPosition("point_cc_earth"),
        getPosition("point_6_oclock"),
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
                condition = "always",
                ["always"] = {
                  getPosition("point_9_oclock"),
                  getPosition("point_10_oclock"),
                  getPosition("point_11_oclock"),
                  getPosition("point_12_oclock"),
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
                condition = "always",
                ["always"] = {
                  getPosition("point_12_oclock"),
                  getPosition("point_11_oclock"),
                  getPosition("point_10_oclock"),
                  getPosition("point_9_oclock"),
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
              Prefab.fire_c_6,
              Prefab.earth_c,
              Prefab.point_9,
              Prefab.air_c,
              Prefab.point_12,
              Prefab.water_c,
              {
                condition = "always",
                ["always"] = {
                  getPosition("point_3_oclock"),
                  getPosition("point_4_oclock"),
                  getPosition("point_5_oclock"),
                  getPosition("point_6_oclock"),
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
                condition = "always",
                ["always"] = {
                  getPosition("point_6_oclock"),
                  getPosition("point_5_oclock"),
                  getPosition("point_4_oclock"),
                  getPosition("point_3_oclock"),
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
                condition = "always",
                ["always"] = {
                  getPosition("point_12_oclock"),
                  getPosition("point_1_oclock"),
                  getPosition("point_2_oclock"),
                  getPosition("point_3_oclock"),
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
                condition = "always",
                ["always"] = {
                  getPosition("point_3_oclock"),
                  getPosition("point_2_oclock"),
                  getPosition("point_1_oclock"),
                  getPosition("point_12_oclock"),
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
                condition = "always",
                ["always"] = {
                  getPosition("point_6_oclock"),
                  getPosition("point_7_oclock"),
                  getPosition("point_8_oclock"),
                  getPosition("point_9_oclock"),
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
                condition = "always",
                ["always"] = {
                  getPosition("point_9_oclock"),
                  getPosition("point_8_oclock"),
                  getPosition("point_7_oclock"),
                  getPosition("point_6_oclock"),
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
    CreepInterval = .7
  }
end
