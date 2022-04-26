local displaytag = false
local civicTags, maxDistance = {}, 10.0

displayTags = function()
  local playerPed = PlayerPedId()
  local playerCoords = GetEntityCoords(playerPed)

  for _, i in ipairs(GetActivePlayers()) do
    local targetPed =  GetPlayerPed(i)
    local targetCoords = GetEntityCoords(targetPed)
    local serverid = GetPlayerServerId(i)
    local nametags = Player(serverid).state.name

    if not civicTags[i] or not IsMpGamerTagActive(civicTags[i].tag) then
      civicTags[i] = {
        tag = CreateFakeMpGamerTag(targetPed, nametags, false, false, 0),
        ped = targetPed,
      }
    end

    local nametag = civicTags[i].tag
    local distance = #(targetCoords - playerCoords)

    if (distance <= maxDistance) and HasEntityClearLosToEntity(playerPed, targetPed, 17) then
      SetMpGamerTagVisibility(nametag, 0, true)
    else
      SetMpGamerTagVisibility(nametag, 0, false)
    end
  end
end

cleanupTags = function()
  for _, v in pairs(civicTags) do
      if IsMpGamerTagActive(v.tag) then
          RemoveMpGamerTag(v.tag)
      end
  end
  civicTags = {}
end

CreateThread(function()
  local sleep = 50
  while true do
    if displaytag then
      displayTags()
      sleep = 50
    else
      sleep = 100
    end
    Wait(sleep)
  end
end)

RegisterCommand('distag2', function()
    displaytag = true
end, false)

RegisterCommand('distagoff', function()
    displaytag = false
    cleanupTags()
end, false)

RegisterKeyMapping("distag2", "Display Player Name Tags.", "keyboard", "h")
RegisterKeyMapping("distagoff", "Disable Player Name Tags.", "keyboard", "left-alt") --You can change these binds in your FiveM Settings.
