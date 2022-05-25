-- called once this resource starts. Since this is clientside, this resource start when the player connected
function onStartup()
    print("onStartup")

    -- fetch the current player ped id
    local playerPed = PlayerPedId()

    -- change armour. Normal is 100 armour
    SetPlayerMaxArmour(PlayerId(-1), 600)
    SetPedArmour(playerPed, 600)

    -- set health. Normal is 200
    SetPedMaxHealth(playerPed, 600)
    SetEntityHealth(playerPed, 600)

    -- super kick power. or unarmed power. Normal is 1.5
    SetWeaponDamageModifier('WEAPON_UNARMED', 950.9)

    -- SetPedMoveRateOverride(PlayerId(),10.0)
    SetRunSprintMultiplierForPlayer(PlayerId(), 2.49) -- normal is 1.0

    SetSwimMultiplierForPlayer(PlayerId(), 1.49) -- normal is 1.0
end

-- called on every frame. Used for ingame Settings. No calculations like distances
function onFrame()
    SetSuperJumpThisFrame(PlayerId(), 2000)
    RestorePlayerStamina(PlayerId(), 100)
end

-- called every 500ms. Used for expensive calculations.
function onCalculation()
end



-- start every frame function
AddEventHandler("onClientResourceStart", function (resourcename)
    print("onClientResourceStart", resourcename)
	if resourcename == GetCurrentResourceName() then
		
        Citizen.CreateThread(function()
            Citizen.Wait(2500)
            onStartup()
        end)

		-- Every Frame
		Citizen.CreateThread(function()
			Citizen.Wait(100)
			while true do
				Citizen.Wait(0)
				onFrame()
			end
		end)

		-- Once every 500ms
		Citizen.CreateThread(function()
			Citizen.Wait(100)
			while true do
				Citizen.Wait(500)
				onCalculation()
			end
		end)

    end
end)
