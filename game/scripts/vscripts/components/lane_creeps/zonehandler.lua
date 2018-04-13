function OnStartTouch(keys)
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
