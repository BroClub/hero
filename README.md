# BroClub

BroClub explains how to create the best fivem client scripts

## Vanilla Server Setup

Checkout the installation [video]([https://pip.pypa.io/en/stable/](https://www.youtube.com/watch?v=7y0GqFdj3sM)) to get a fresh server.

## Client script template

```lua
-- called once this resource starts. Since this is clientside, this resource start when the player connected
function onStartup()
end

-- called on every frame. Used for ingame Settings. No calculations like distances
function onFrame()
end

-- called every 500ms. Used for expensive calculations.
function onCalculation()
end


-- start every frame function
AddEventHandler("onClientResourceStart", function (resourcename)
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
```

## License
[MIT](https://choosealicense.com/licenses/mit/)
