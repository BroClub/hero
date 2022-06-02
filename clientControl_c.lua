local directions = { [0] = 'N', [45] = 'NW', [90] = 'W', [135] = 'SW', [180] = 'S', [225] = 'SE', [270] = 'E', [315] = 'NE', [360] = 'N', } 
local direction = 'N' -- default text, will be changed soon. 

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
    SetWeaponDamageModifier('WEAPON_UNARMED', 1000.0)

    SetRunSprintMultiplierForPlayer(PlayerId(), 1.49) -- normal is 1.0

    SetSwimMultiplierForPlayer(PlayerId(), 1.49) -- normal is 1.0
end

-- called on every frame. Used for ingame Settings. No calculations like distances
function onFrame()
    SetSuperJumpThisFrame(PlayerId(), 2000) -- Native, needs to be called every Frame
    RestorePlayerStamina(PlayerId(), 100) -- Native, resets player stamina, therefore makes it basically infinite 

    drawTxt(
        0.685, -- x position. 
        1.42,  -- y position
        1.0, -- width
        1.0,-- height
        1.0,  --scale
        direction, -- actual value calculated NOT every Frame. 
        255, 255, 255, 1000
    )
end

-- called every 500ms. Used for expensive calculations.
function onCalculation()
    for k,v in pairs(directions)do
        direction = GetEntityHeading(PlayerPedId()) -- where is the player looking at
        if(math.abs(direction - k) < 22.5)then -- heavy calculation. math.abs is really expensive. 
            direction = v
            break
        end
    end
end

function drawTxt(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(6)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
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
