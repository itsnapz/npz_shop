local playerPos = vector3(0, 0, 0)
local playerPed = PlayerPedId()
local inv = {}
local herak = Config.Locations["sanchez"].drug
local weed = Config.Locations["rodriguez"].drug
local meth = Config.Locations["garcia"].drug
local peds = {}
local doesExist = false

RegisterKeyMapping('selldrugs', 'Sell Drug to NPC', 'keyboard', 'E')

function indexOf(array, value)
    for i, v in ipairs(array) do
        if v == value then
            return i
        end
    end
    return nil
end

function invContains(table, item)
    for _, value in pairs(table) do
      if value == item then
        return true
      end
    end
    return false
end

-- Givnutí drog pomocí commandu
RegisterCommand('drug', function(source, args)
    local drug = args[1]
    if drug == Config.Items["heroin"].type then
        table.insert(inv, drug)
        print('Přidáno ' .. drug .. ' do tvého inventáře')
        print('Momentálně máš: ' .. json.encode(inv))
    elseif drug == Config.Items["weed"].type then
        table.insert(inv, drug)
        print('Přidáno ' .. drug .. ' do tvého inventáře')
        print('Momentálně máš: ' .. json.encode(inv))
    elseif drug == Config.Items["meth"].type then 
        table.insert(inv, drug)
        print('Přidáno ' .. drug .. ' do tvého inventáře')
        print('Momentálně máš: ' .. json.encode(inv))
    else
        print(drug .. ' Není droga')
    end
end)

-- Checkuje kde hráč je
Citizen.CreateThread(function()
    while true do 
        playerPos = GetEntityCoords(playerPed)
        Citizen.Wait(1000)
    end
end)

-- Command na kouknutí co je v invu
RegisterCommand('inv', function()
    print(json.encode(inv))
end)

-- Zobrazení textu
Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)
        local sleep = true
        for k,v in pairs(Config.Locations) do 
            local distance = #(playerPos - v.coords)
            if distance <= 1.5 then
                sleep = false
                Draw3DText(v.coords.x, v.coords.y, v.coords.z, v.text, 0.3)
            end
        end
        if sleep then
            Citizen.Wait(1000)
        end
    end
end)

RegisterCommand('selldrugs', function()
    playerPos = GetEntityCoords(playerPed)
    local distanceToSanchez = #(playerPos - Config.Locations["sanchez"].coords)
    local distanceToRodriguez = #(playerPos - Config.Locations["rodriguez"].coords)
    local distanceToGarcia = #(playerPos - Config.Locations["garcia"].coords)
    if distanceToSanchez <= 1.5 then
        if invContains(inv, herak) then
            table.remove(inv, indexOf(inv, herak))
            TaskStartScenarioAtPosition(peds[1], "WORLD_HUMAN_BUM_STANDING", Config.Peds[1].coordsPos.x, Config.Peds[1].coordsPos.y, Config.Peds[1].coordsPos.z, Config.Peds[1].coordsPos.w, 4000, false, false)
            print('Prodal jsi '.. herak .. ' | ' .. Config.Items["heroin"].description)
        else
            print('Nemáš nic co bych chtěl')
        end
    elseif distanceToRodriguez <= 1.5 then
        if invContains(inv, weed) then
            table.remove(inv, indexOf(inv, weed))
            TaskStartScenarioAtPosition(peds[2], "WORLD_HUMAN_BUM_STANDING", Config.Peds[2].coordsPos.x, Config.Peds[2].coordsPos.y, Config.Peds[2].coordsPos.z, Config.Peds[2].coordsPos.w, 4000, false, false)
            print('Prodal jsi '.. weed ..' | ' .. Config.Items["weed"].description)
        else
            print('Nemáš nic co bych chtěl')
        end
    elseif distanceToGarcia <= 1.5 then 
        if invContains(inv, meth) then 
            table.remove(inv, indexOf(inv, meth))
            TaskStartScenarioAtPosition(peds[3], "WORLD_HUMAN_BUM_STANDING", Config.Peds[3].coordsPos.x, Config.Peds[3].coordsPos.y, Config.Peds[3].coordsPos.z, Config.Peds[3].coordsPos.w, 4000, false, false)
            print('Prodal jsi '.. meth ..' | ' .. Config.Items["meth"].description)
        else 
            print('Nemáš nic co bych chtěl')
        end
    end
end)

-- Zobrazení NPC
Citizen.CreateThread(function()
    for k,v in pairs(Config.Peds) do 
        local modelHash = GetHashKey(v.model)
        RequestModel(modelHash)
        while not HasModelLoaded(modelHash) do 
            Citizen.Wait(1000)
        end
        local ped = CreatePed(v.type, modelHash, v.coordsPos.x, v.coordsPos.y, v.coordsPos.z-0.90, v.coordsPos.w, true, true)
        table.insert(peds, ped)
        SetBlockingOfNonTemporaryEvents(ped, true)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetPedCanRagdollFromPlayerImpact(ped, false)
        SetPedCanPlayAmbientAnims(ped, true)
        SetPedDiesWhenInjured(ped, false)
        SetPedCanPlayAmbientBaseAnims(ped, true)
        SetPedCanPlayGestureAnims(ped, true)
        SetPedCanPlayInjuredAnims(ped, true)
        SetPedCanPlayVisemeAnims(ped, true, 0)
    end
end)

-- Funkce na custom 3D Text
function Draw3DText(x,y,z,text,scale)
    local onScreen, _x, _y = World3dToScreen2d(x,y,z)
    local pX,pY,pZ = table.unpack(GetGameplayCamCoords())
    SetTextScale(scale, scale)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextCentre(1)
    SetTextColour(255, 255, 255, 255)
    SetTextDropShadow(0, 0, 0, 255)
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(_x,_y)
end