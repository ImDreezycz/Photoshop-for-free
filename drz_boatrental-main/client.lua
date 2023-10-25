ESX = exports.es_extended:getSharedObject()


local ped = nil

Citizen.CreateThread(function()
    local pedModel = GetHashKey("a_m_y_surfer_01")

    RequestModel(pedModel)
    while not HasModelLoaded(pedModel) do
        Wait(1)
    end

    ped = CreatePed(4, pedModel, DRZ.PedLocation, false, true)
    SetEntityHeading(ped, 300.47)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_CLIPBOARD", 0, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetPedCombatAttributes(ped, 46, true)
    SetPedCombatAbility(ped, 0)
    SetPedCanSwitchWeapon(ped, false)
    SetBlockingOfNonTemporaryEvents(ped, true)
end)

Citizen.CreateThread(function()
    for _, blip in ipairs(DRZ.Loc.BlipLocation) do
        local locblip = AddBlipForCoord(blip.x, blip.y, blip.z)
        SetBlipSprite(locblip, 455)
        SetBlipScale(locblip, 0.8)
        SetBlipColour(locblip, 5)
        SetBlipAsShortRange(locblip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('<FONT FACE="Fire Sans">Rental Boat')
        EndTextCommandSetBlipName(locblip)
    end
end)


--[[Citizen.CreateThread(function()
    while true do
        Wait(0)
        local PlayerPedId = PlayerPedId()
        local playerCoords = GetEntityCoords(PlayerPedId)
        local distance = #(playerCoords - GetEntityCoords(ped))
        
        if distance < 2.0 then
            lib.showTextUI("Stiskni [E] - Pro otevření menu", {
                position = "right-center",
                icon = "hand"
            })
            if IsControlJustReleased(0, 38) then
                OpenLocationMenu()
            end
        else
            Wait(1000)
        end
    end
end)]]


function OpenLocationMenu()

    lib.registerContext({
        id = "location_menu",
        title = "Rental Boat Menu",
        options = {
            {
                title = "Boat 300$",
                onSelect = function()
                    ESX.TriggerServerCallback('CheckLocMoney', function(hasEnoughMoney)
                        if hasEnoughMoney then
                           TriggerServerEvent('RemoveLocMoney', 300)
                           SpawnScooterVehicle()
                        else
                            Wait(1000)
                        
                        end
                    end)
                end
            },
            {
                title = "Seashark 250$",
                onSelect = function()
                    ESX.TriggerServerCallback('CheckLocMoney', function(hasEnoughMoney)
                        if hasEnoughMoney then
                           TriggerServerEvent('RemoveLocMoney', 250)
                           SpawnSeasharkVehicle()
                        else
                            Wait(1000)
                        
                        end
                    end)
                end
            }
        }
    })

    lib.showContext("location_menu")
end

--------------------dinghy2--------------------------
function SpawnScooterVehicle()
    local vehicleModel = GetHashKey(DRZ.Boat)
    RequestModel(vehicleModel)
    while not HasModelLoaded(vehicleModel) do
        Wait(1)
    end
   local vehicle = CreateVehicle(vehicleModel, DRZ.SpawnBoat, true, false)
    SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
end

--------------------seashark--------------------------
function SpawnSeasharkVehicle()
    local vehicleModel = GetHashKey(DRZ.Seashark)
    RequestModel(vehicleModel)
    while not HasModelLoaded(vehicleModel) do
        Wait(1)
    end
    local vehicle = CreateVehicle(vehicleModel, DRZ.SpawnBoat, true, false)
    SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
end

RegisterNetEvent('DRZ_boatrental:openmenu', function()
    OpenLocationMenu()
end)

exports.ox_target:addBoxZone({
	coords = DRZ.Menu,
	size = vec3(1, 1, 1),
	rotation = 45,
	debug = drawZones,
	options = {
		{
			name = 'boat',
            event = 'drz_boatrental:openmenu',
			icon = 'fa-solid fa-home',
			label = 'Open Menu',
		}
	}
})