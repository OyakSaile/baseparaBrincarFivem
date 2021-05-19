-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISPATCH
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	for i = 1,12 do
		EnableDispatchService(i,false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RADIOVOLUME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("volume", function(source,args)
	if args[1] then
		if tonumber(args[1]) then
			if tonumber(args[1]) <= 200 and tonumber(args[1]) >= 0 then
				exports.tokovoip:setRadioVolume(tonumber(args[1])-100)
			else
				TriggerEvent("Notify","amarelo","Você deve digitar um número entre 0 e 200",5000)
			end
		else
			TriggerEvent("Notify","amarelo","Você deve digitar um número entre 0 e 200",5000)
		end
	else
		TriggerEvent("Notify","amarelo","Você deve digitar um número entre 0 e 200",5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TYREBURST
-----------------------------------------------------------------------------------------------------------------------------------------
local oldSpeed = 0
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			timeDistance = 4
			SetPedHelmet(ped,false)
			DisableControlAction(0,345,true)
			local veh = GetVehiclePedIsUsing(ped)
			if GetPedInVehicleSeat(veh,-1) == ped then
				local speed = GetEntitySpeed(veh) * 2.236936
				if speed ~= oldSpeed then
					if (oldSpeed - speed) >= 60 then
						TriggerServerEvent("upgradeStress",10)
						if GetVehicleClass(veh) ~= 8 then
							vehicleTyreBurst(veh)
						end
					end
					oldSpeed = speed
				end
			end
		else
			oldSpeed = 0
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLETYREBURST
-----------------------------------------------------------------------------------------------------------------------------------------
function vehicleTyreBurst(vehicle)
	local tyre = math.random(4)
	if tyre == 1 then
		if not IsVehicleTyreBurst(vehicle,0,false) then
			SetVehicleTyreBurst(vehicle,0,true,1000.0)
		end
	elseif tyre == 2 then
		if not IsVehicleTyreBurst(vehicle,1,false) then
			SetVehicleTyreBurst(vehicle,1,true,1000.0)
		end
	elseif tyre == 3 then
		if not IsVehicleTyreBurst(vehicle,4,false) then
			SetVehicleTyreBurst(vehicle,4,true,1000.0)
		end
	elseif tyre == 4 then
		if not IsVehicleTyreBurst(vehicle,5,false) then
			SetVehicleTyreBurst(vehicle,5,true,1000.0)
		end
	end

	if math.random(100) < 30 then
		Citizen.Wait(10)
		vehicleTyreBurst(vehicle)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = {
	{ 733.7,-1088.73,21.37,315,11,"Mecânica",0.4 },
	{ -222.94,-1509.0,31.41,357,18,"Bicicletário",0.4 },
	{ 1851.99,2595.64,45.69,357,18,"Bicicletário",0.4 },
	{ 2679.43,3443.93,55.81,164,4,"Circuitos",0.4 },
	{ -566.72,-2117.39,5.98,164,4,"Circuitos",0.4 },
	{ 1679.4,-1564.53,112.57,164,4,"Circuitos",0.4 },
	{ -1732.07,-727.34,10.4,164,4,"Circuitos",0.4 },
	{ -1367.59,15.04,53.38,164,4,"Circuitos",0.4 },
	{ 636.43,649.9,128.9,164,4,"Circuitos",0.4 },
	{ 364.86,-543.57,28.75,164,4,"Circuitos",0.4 },
	{ 247.31,-1513.38,29.10,164,4,"Circuitos",0.4 },
	{ -324.69,-1098.09,23.03,164,4,"Circuitos",0.4 },
	{ 265.05,-1262.65,29.3,361,4,"Posto de Gasolina",0.4 },
	{ 819.02,-1027.96,26.41,361,4,"Posto de Gasolina",0.4 },
	{ 1208.61,-1402.43,35.23,361,4,"Posto de Gasolina",0.4 },
	{ 1181.48,-330.26,69.32,361,4,"Posto de Gasolina",0.4 },
	{ 621.01,268.68,103.09,361,4,"Posto de Gasolina",0.4 },
	{ 2581.09,361.79,108.47,361,4,"Posto de Gasolina",0.4 },
	{ 175.08,-1562.12,29.27,361,4,"Posto de Gasolina",0.4 },
	{ -319.76,-1471.63,30.55,361,4,"Posto de Gasolina",0.4 },
	{ 1782.33,3328.46,41.26,361,4,"Posto de Gasolina",0.4 },
	{ 49.42,2778.8,58.05,361,4,"Posto de Gasolina",0.4 },
	{ 264.09,2606.56,44.99,361,4,"Posto de Gasolina",0.4 },
	{ 1039.38,2671.28,39.56,361,4,"Posto de Gasolina",0.4 },
	{ 1207.4,2659.93,37.9,361,4,"Posto de Gasolina",0.4 },
	{ 2539.19,2594.47,37.95,361,4,"Posto de Gasolina",0.4 },
	{ 2679.95,3264.18,55.25,361,4,"Posto de Gasolina",0.4 },
	{ 2005.03,3774.43,32.41,361,4,"Posto de Gasolina",0.4 },
	{ 1687.07,4929.53,42.08,361,4,"Posto de Gasolina",0.4 },
	{ 1701.53,6415.99,32.77,361,4,"Posto de Gasolina",0.4 },
	{ 180.1,6602.88,31.87,361,4,"Posto de Gasolina",0.4 },
	{ -94.46,6419.59,31.48,361,4,"Posto de Gasolina",0.4 },
	{ -2555.17,2334.23,33.08,361,4,"Posto de Gasolina",0.4 },
	{ -1800.09,803.54,138.72,361,4,"Posto de Gasolina",0.4 },
	{ -1437.0,-276.8,46.21,361,4,"Posto de Gasolina",0.4 },
	{ -2096.3,-320.17,13.17,361,4,"Posto de Gasolina",0.4 },
	{ -724.56,-935.97,19.22,361,4,"Posto de Gasolina",0.4 },
	{ -525.26,-1211.19,18.19,361,4,"Posto de Gasolina",0.4 },
	{ -70.96,-1762.21,29.54,361,4,"Posto de Gasolina",0.4 },
    { 1147.31,-1535.03,35.39,80,35,"Hospital",0.5 },
	{ 55.43,-876.19,30.66,357,14,"Garagem",0.4 },
	{ 44.38,-842.49,31.14,357,14,"Garagem",0.4 },
	{ 317.25,2623.14,44.46,357,14,"Garagem",0.4 },
	{ -773.34,5598.15,33.60,357,14,"Garagem",0.4 },
	{ 275.23,-345.54,45.17,357,14,"Garagem",0.4 },
	{ 596.40,90.65,93.12,357,14,"Garagem",0.4 },
	{ -340.76,265.97,85.67,357,14,"Garagem",0.4 },
	{ -2030.01,-465.97,11.60,357,14,"Garagem",0.4 },
	{ -1184.92,-1510.00,4.64,357,14,"Garagem",0.4 },
	{ -73.44,-2004.99,18.27,357,14,"Garagem",0.4 },
	{ 214.02,-808.44,31.01,357,14,"Garagem",0.4 },
	{ -348.88,-874.02,31.31,357,14,"Garagem",0.4 },
	{ 67.74,12.27,69.21,357,14,"Garagem",0.4 },
	{ 361.90,297.81,103.88,357,14,"Garagem",0.4 },
	{ 1035.89,-763.89,57.99,357,14,"Garagem",0.4 },
	{ -796.63,-2022.77,9.16,357,14,"Garagem",0.4 },
	{ 453.27,-1146.76,29.52,357,14,"Garagem",0.4 },
	{ 528.66,-146.3,58.38,357,14,"Garagem",0.4 },
	{ -1159.48,-739.32,19.89,357,14,"Garagem",0.4 },
	{ 29.29,-1770.35,29.61,357,14,"Garagem",0.4 },
	{ 101.22,-1073.68,29.38,357,14,"Garagem",0.4 },
	{ -281.25,-888.64,31.32,357,14,"Garagem",0.4 },
	{ 717.74,-966.32,30.4,176,34,"Trocas",0.4 },
	{ 406.04,6526.17,27.75,214,31,"Colheita",0.4 },
	{ 361.08,-1584.91,29.3,60,4,"Departamento Policial",0.4 },
	{ 25.68,-1346.6,29.5,52,36,"Loja de Departamento",0.4 },
	{ 2556.47,382.05,108.63,52,36,"Loja de Departamento",0.4 },
	{ 1163.55,-323.02,69.21,52,36,"Loja de Departamento",0.4 },
	{ -707.31,-913.75,19.22,52,36,"Loja de Departamento",0.4 },
	{ -47.72,-1757.23,29.43,52,36,"Loja de Departamento",0.4 },
	{ 373.89,326.86,103.57,52,36,"Loja de Departamento",0.4 },
	{ -3242.95,1001.28,12.84,52,36,"Loja de Departamento",0.4 },
	{ 1729.3,6415.48,35.04,52,36,"Loja de Departamento",0.4 },
	{ 548.0,2670.35,42.16,52,36,"Loja de Departamento",0.4 },
	{ 1960.69,3741.34,32.35,52,36,"Loja de Departamento",0.4 },
	{ 2677.92,3280.85,55.25,52,36,"Loja de Departamento",0.4 },
	{ 1698.5,4924.09,42.07,52,36,"Loja de Departamento",0.4 },
	{ -1820.82,793.21,138.12,52,36,"Loja de Departamento",0.4 },
	{ 1393.21,3605.26,34.99,52,36,"Loja de Departamento",0.4 },
	{ -2967.78,390.92,15.05,52,36,"Loja de Departamento",0.4 },
	{ -3040.14,585.44,7.91,52,36,"Loja de Departamento",0.4 },
	{ 1135.56,-982.24,46.42,52,36,"Loja de Departamento",0.4 },
	{ 1166.0,2709.45,38.16,52,36,"Loja de Departamento",0.4 },
	{ -1487.21,-378.99,40.17,52,36,"Loja de Departamento",0.4 },
	{ -1222.76,-907.21,12.33,52,36,"Loja de Departamento",0.4 },
	{ 1588.17,6455.71,26.02,269,63,"Restaurante",0.5 }, -- Avalanches
	{ 1692.62,3759.50,34.70,76,6,"Loja de Armas",0.4 },
	{ 252.89,-49.25,69.94,76,6,"Loja de Armas",0.4 },
	{ 843.28,-1034.02,28.19,76,6,"Loja de Armas",0.4 },
	{ -331.35,6083.45,31.45,76,6,"Loja de Armas",0.4 },
	{ -663.15,-934.92,21.82,76,6,"Loja de Armas",0.4 },
	{ -1305.18,-393.48,36.69,76,6,"Loja de Armas",0.4 },
	{ -1118.80,2698.22,18.55,76,6,"Loja de Armas",0.4 },
	{ 2568.83,293.89,108.73,76,6,"Loja de Armas",0.4 },
	{ -3172.68,1087.10,20.83,76,6,"Loja de Armas",0.4 },
	{ 21.32,-1106.44,29.79,76,6,"Loja de Armas",0.4 },
	{ 811.19,-2157.67,29.61,76,6,"Loja de Armas",0.4 },
	{ 235.26,216.78,106.29,207,46,"Banco",0.4 },
	{ -1213.44,-331.02,37.78,207,46,"Banco",0.4 },
	{ -351.59,-49.68,49.04,207,46,"Banco",0.4 },
	{ 313.47,-278.81,54.17,207,46,"Banco",0.4 },
	{ 149.35,-1040.53,29.37,207,46,"Banco",0.4 },
	{ -2962.60,482.17,15.70,207,46,"Banco",0.4 },
	{ -112.81,6469.91,31.62,207,46,"Banco",0.4 },
	{ 1175.74,2706.80,38.09,207,46,"Banco",0.4 },
	{ -51.82,-1111.38,26.44,225,4,"Benefactor",0.4 },
	{ 471.99,-1114.81,29.4,225,22,"Premium Benefactor",0.4 },
	{ 1322.64,-1651.97,52.27,75,4,"Tatuagens",0.4 },
    { -1153.67,-1425.68,4.95,75,4,"Tatuagens",0.4 },
    { 322.13,180.46,103.58,75,4,"Tatuagens",0.4 },
    { -3170.07,1075.05,20.82,75,4,"Tatuagens",0.4 },
    { 1864.63,3747.73,33.03,75,4,"Tatuagens",0.4 },
    { -293.71,6200.04,31.48,75,4,"Tatuagens",0.4 },
	{ -815.12,-184.15,37.57,71,4,"Barbearia",0.4 },
	{ 138.13,-1706.46,29.3,71,4,"Barbearia",0.4 },
	{ -1280.92,-1117.07,7.0,71,4,"Barbearia",0.4 },
	{ 1930.54,3732.06,32.85,71,4,"Barbearia",0.4 },
	{ 1214.2,-473.18,66.21,71,4,"Barbearia",0.4 },
	{ -33.61,-154.52,57.08,71,4,"Barbearia",0.4 },
	{ -276.65,6226.76,31.7,71,4,"Barbearia",0.4 },
	{ 75.35,-1392.92,29.38,366,4,"Loja de Roupas",0.4 },
	{ -710.15,-152.36,37.42,366,4,"Loja de Roupas",0.4 },
	{ -163.73,-303.62,39.74,366,4,"Loja de Roupas",0.4 },
	{ -822.38,-1073.52,11.33,366,4,"Loja de Roupas",0.4 },
	{ -1193.13,-767.93,17.32,366,4,"Loja de Roupas",0.4 },
	{ -1449.83,-237.01,49.82,366,4,"Loja de Roupas",0.4 },
	{ 4.83,6512.44,31.88,366,4,"Loja de Roupas",0.4 },
	{ 1693.95,4822.78,42.07,366,4,"Loja de Roupas",0.4 },
	{ 125.82,-223.82,54.56,366,4,"Loja de Roupas",0.4 },
	{ 614.2,2762.83,42.09,366,4,"Loja de Roupas",0.4 },
	{ 1196.72,2710.26,38.23,366,4,"Loja de Roupas",0.4 },
	{ -3170.53,1043.68,20.87,366,4,"Loja de Roupas",0.4 },
	{ -1101.42,2710.63,19.11,366,4,"Loja de Roupas",0.4 },
	{ 425.6,-806.25,29.5,366,4,"Loja de Roupas",0.4 },
	{ -622.23,-231.08,38.06,617,3,"Joalheria",0.4 },
	{ -1728.06,-1050.69,1.71,266,4,"Embarcações",0.4 },
	{ 1966.36,3975.86,31.51,266,4,"Embarcações",0.4 },
	{ -776.72,-1495.02,2.29,266,4,"Embarcações",0.4 },
	{ -893.97,5687.78,3.29,266,4,"Embarcações",0.4 },
	{ 458.37,-598.98,28.5,513,4,"Motorista",0.4 },
	{ 359.24,269.91,103.06,67,4,"Transportador",0.4 },
	{ -558.29,5362.55,70.22,285,4,"Lenhador",0.4 },
	{ 961.09,-2109.96,31.95,410,4,"Caminhão Peixes",0.4 }, -- rem
	{ -1188.27,2727.94,2.4,68,26,"Área de Pesca",0.4 },
	{ 961.18,-2185.41,30.49,478,22,"Fábrica de Carnes",0.5 }, -- rem
	{ 2940.85,2797.66,40.78,485,16,"Mineradora",0.6 },
	{ 1083.01,-1975.1,31.48,478,16,"Fábrica de Minérios",0.4 }, -- rem
	{ 286.79,2843.75,44.71,485,16,"Loja de Minérios",0.6 }, -- rem
	{ 132.6,-1305.06,29.2,93,4,"Bar",0.4 },
	{ -565.14,271.56,83.02,93,4,"Bar",0.4 },
	{ 83.7,-1543.71,29.47,318,4,"Lixeiro",0.4 },
	{ 4.58,-705.95,45.98,351,4,"Escritório",0.4 },
	{ -117.29,-604.52,36.29,351,4,"Escritório",0.4 },
	{ -826.9,-699.89,28.06,351,4,"Escritório",0.4 },
	{ -935.68,-378.77,38.97,351,4,"Escritório",0.4 },
	{ 320.03,-1075.96,29.48,403,3,"Farmácia",0.4 },
	{ 237.81,-413.08,48.12,498,8,"Cartório",0.4 },
	{ 46.66,-1749.79,29.64,78,11,"Mega Mall",0.4 },
	{ -419.17,-1689.88,19.85,467,11,"Reciclagem",0.4 }
}

Citizen.CreateThread(function()
	for _,v in pairs(blips) do
		local blip = AddBlipForCoord(v[1],v[2],v[3])
		SetBlipSprite(blip,v[4])
		SetBlipAsShortRange(blip,true)
		SetBlipColour(blip,v[5])
		SetBlipScale(blip,v[7])
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(v[6])
		EndTextCommandSetBlipName(blip)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- EMPURRAR
-----------------------------------------------------------------------------------------------------------------------------------------
local entityEnumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end
		enum.destructor = nil
		enum.handle = nil
	end
}

local function EnumerateEntities(initFunc,moveFunc,disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end

		local enum = { handle = iter, destructor = disposeFunc }
		setmetatable(enum, entityEnumerator)

		local next = true
		repeat
		coroutine.yield(id)
		next,id = moveFunc(iter)
		until not next

		enum.destructor,enum.handle = nil,nil
		disposeFunc(iter)
	end)
end

function EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle,FindNextVehicle,EndFindVehicle)
end

function GetVeh()
    local vehicles = {}
    for vehicle in EnumerateVehicles() do
        table.insert(vehicles,vehicle)
    end
    return vehicles
end

function GetClosestVeh(coords)
	local vehicles = GetVeh()
	local closestDistance = -1
	local closestVehicle = -1
	local coords = coords

	if coords == nil then
		local ped = PlayerPedId()
		coords = GetEntityCoords(ped)
	end

	for i=1,#vehicles,1 do
		local vehicleCoords = GetEntityCoords(vehicles[i])
		local distance = GetDistanceBetweenCoords(vehicleCoords,coords.x,coords.y,coords.z,true)
		if closestDistance == -1 or closestDistance > distance then
			closestVehicle  = vehicles[i]
			closestDistance = distance
		end
	end
	return closestVehicle,closestDistance
end

local First = vector3(0.0,0.0,0.0)
local Second = vector3(5.0,5.0,5.0)
local Vehicle = { Coords = nil, Vehicle = nil, Dimension = nil, IsInFront = false, Distance = nil }

Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		local closestVehicle,Distance = GetClosestVeh()
		if Distance < 6.1 and not IsPedInAnyVehicle(ped) then
			Vehicle.Coords = GetEntityCoords(closestVehicle)
			Vehicle.Dimensions = GetModelDimensions(GetEntityModel(closestVehicle),First,Second)
			Vehicle.Vehicle = closestVehicle
			Vehicle.Distance = Distance
			if GetDistanceBetweenCoords(GetEntityCoords(closestVehicle) + GetEntityForwardVector(closestVehicle), GetEntityCoords(ped), true) > GetDistanceBetweenCoords(GetEntityCoords(closestVehicle) + GetEntityForwardVector(closestVehicle) * -1, GetEntityCoords(ped), true) then
				Vehicle.IsInFront = false
			else
				Vehicle.IsInFront = true
			end
		else
			Vehicle = { Coords = nil, Vehicle = nil, Dimensions = nil, IsInFront = false, Distance = nil }
		end
		Citizen.Wait(500)
	end
end)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(500)
		if Vehicle.Vehicle ~= nil then
			local ped = PlayerPedId()
			if IsControlPressed(0,244) and GetEntityHealth(ped) > 100 and IsVehicleSeatFree(Vehicle.Vehicle,-1) and not IsEntityAttachedToEntity(ped,Vehicle.Vehicle) and not (GetEntityRoll(Vehicle.Vehicle) > 75.0 or GetEntityRoll(Vehicle.Vehicle) < -75.0) then
				RequestAnimDict("missfinale_c2ig_11")
				TaskPlayAnim(ped,"missfinale_c2ig_11","pushcar_offcliff_m",2.0,-8.0,-1,35,0,0,0,0)
				NetworkRequestControlOfEntity(Vehicle.Vehicle)

				if Vehicle.IsInFront then
					AttachEntityToEntity(ped,Vehicle.Vehicle,GetPedBoneIndex(6286),0.0,Vehicle.Dimensions.y*-1+0.1,Vehicle.Dimensions.z+1.0,0.0,0.0,180.0,0.0,false,false,true,false,true)
				else
					AttachEntityToEntity(ped,Vehicle.Vehicle,GetPedBoneIndex(6286),0.0,Vehicle.Dimensions.y-0.3,Vehicle.Dimensions.z+1.0,0.0,0.0,0.0,0.0,false,false,true,false,true)
				end

				while true do
					Citizen.Wait(5)
					if IsDisabledControlPressed(0,34) then
						TaskVehicleTempAction(ped,Vehicle.Vehicle,11,100)
					end

					if IsDisabledControlPressed(0,9) then
						TaskVehicleTempAction(ped,Vehicle.Vehicle,10,100)
					end

					if Vehicle.IsInFront then
						SetVehicleForwardSpeed(Vehicle.Vehicle,-1.0)
					else
						SetVehicleForwardSpeed(Vehicle.Vehicle,1.0)
					end

					if not IsDisabledControlPressed(0,244) then
						DetachEntity(ped,false,false)
						StopAnimTask(ped,"missfinale_c2ig_11","pushcar_offcliff_m",2.0)
						break
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RECOIL
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()

		if IsPedArmed(ped,6) then
			DisableControlAction(1,140,true)
			DisableControlAction(1,141,true)
			DisableControlAction(1,142,true)
			Citizen.Wait(1)
		else
			Citizen.Wait(1000)
		end

		if IsPedShooting(ped) then
			local cam = GetFollowPedCamViewMode()
			local veh = IsPedInAnyVehicle(ped)
			
			local speed = math.ceil(GetEntitySpeed(ped))
			if speed > 70 then
				speed = 70
			end

			local _,wep = GetCurrentPedWeapon(ped)
			local class = GetWeapontypeGroup(wep)
			local p = GetGameplayCamRelativePitch()
			local camDist = #(GetGameplayCamCoord() - GetEntityCoords(ped))

			local recoil = math.random(110,120+(math.ceil(speed*0.5)))/100
			local rifle = false

			if class == 970310034 or class == 1159398588 then
				rifle = true
			end

			if camDist < 5.3 then
				camDist = 1.5
			else
				if camDist < 8.0 then
					camDist = 4.0
				else
					camDist =  7.0
				end
			end

			if veh then
				recoil = recoil + (recoil * camDist)
			else
				recoil = recoil * 0.1
			end

			if cam == 4 then
				recoil = recoil * 0.6
				if rifle then
					recoil = recoil * 0.1
				end
			end

			if rifle then
				recoil = recoil * 0.6
			end

			local spread = math.random(4)
			local h = GetGameplayCamRelativeHeading()
			local hf = math.random(10,40+speed) / 100

			if veh then
				hf = hf * 2.0
			end

			if spread == 1 then
				SetGameplayCamRelativeHeading(h+hf)
			elseif spread == 2 then
				SetGameplayCamRelativeHeading(h-hf)
			end

			local set = p + recoil
			SetGameplayCamRelativePitch(set,0.8)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADGLOBAL - 1000
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		N_0xf4f2c0d4ee209e20()
		DistantCopCarSirens(false)

		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_PISTOL50"),0.6)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_REVOLVER"),0.4)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_PISTOL"),0.8)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_PISTOL_MK2"),0.6)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_UNARMED"),0.1)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_COMBATPISTOL"),0.8)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_FLASHLIGHT"),0.1)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_NIGHTSTICK"),0.1)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_HATCHET"),0.1)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_KNIFE"),0.1)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_BAT"),0.1)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_BATTLEAXE"),0.1)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_BOTTLE"),0.1)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_CROWBAR"),0.1)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_DAGGER"),0.1)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_GOLFCLUB"),0.1)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_HAMMER"),0.1)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_MACHETE"),0.1)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_POOLCUE"),0.1)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_STONE_HATCHET"),0.1)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_SWITCHBLADE"),0.1)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_WRENCH"),0.1)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_KNUCKLE"),0.1)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_COMPACTRIFLE"),0.4)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_APPISTOL"),0.6)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_HEAVYPISTOL"),0.6)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_MACHINEPISTOL"),0.7)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_MICROSMG"),0.7)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_MINISMG"),0.7)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_SNSPISTOL"),0.6)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_SNSPISTOL_MK2"),0.6)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_VINTAGEPISTOL"),0.6)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_CARBINERIFLE"),0.6)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_ASSAULTRIFLE"),0.6)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_ASSAULTRIFLE_MK2"),0.6)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_ASSAULTSMG"),0.7)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_GUSENBERG"),0.7)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_SAWNOFFSHOTGUN"),1.3)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_PUMPSHOTGUN"),2.0)
		
		--ClearAreaOfPeds(GetEntityCoords(PlayerPedId()),1000.0,1)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADGLOBAL - 5
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		HideHudComponentThisFrame(1)
		HideHudComponentThisFrame(2)
		HideHudComponentThisFrame(3)
		HideHudComponentThisFrame(4)
		HideHudComponentThisFrame(5)
		HideHudComponentThisFrame(6)
		HideHudComponentThisFrame(7)
		HideHudComponentThisFrame(8)
		HideHudComponentThisFrame(9)
		HideHudComponentThisFrame(10)
		HideHudComponentThisFrame(11)
		HideHudComponentThisFrame(12)
		HideHudComponentThisFrame(13)
		HideHudComponentThisFrame(15)
		HideHudComponentThisFrame(17)
		HideHudComponentThisFrame(18)
		HideHudComponentThisFrame(20)
		HideHudComponentThisFrame(21)
		HideHudComponentThisFrame(22)
		--DisableControlAction(1,37,true)
        DisableControlAction(1,192,true)
        DisableControlAction(1,204,true)
        DisableControlAction(1,211,true)
        DisableControlAction(1,349,true)
        DisableControlAction(1,157,false)
        DisableControlAction(1,158,false)
        DisableControlAction(1,160,false)
        DisableControlAction(1,164,false)
        DisableControlAction(1,165,false)
        DisableControlAction(1,159,false)
        DisableControlAction(1,161,false)
        DisableControlAction(1,162,false)
        DisableControlAction(1,163,false)
		
		RemoveAllPickupsOfType(GetHashKey("PICKUP_WEAPON_KNIFE"))
		RemoveAllPickupsOfType(GetHashKey("PICKUP_WEAPON_PISTOL"))
		RemoveAllPickupsOfType(GetHashKey("PICKUP_WEAPON_MINISMG"))
		RemoveAllPickupsOfType(GetHashKey("PICKUP_WEAPON_SMG"))
		RemoveAllPickupsOfType(GetHashKey("PICKUP_WEAPON_PUMPSHOTGUN"))
		RemoveAllPickupsOfType(GetHashKey("PICKUP_WEAPON_CARBINERIFLE"))
		RemoveAllPickupsOfType(GetHashKey("PICKUP_WEAPON_COMBATPISTOL"))

		DisablePlayerVehicleRewards(PlayerId())

		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			SetPedInfiniteAmmo(ped,true,"WEAPON_FIREEXTINGUISHER")
		end
		Citizen.Wait(5)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADGLOBAL - 0
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	AddTextEntry("FE_THDR_GTAO","Cidade Gringa")
	StartAudioScene("CHARACTER_CHANGE_IN_SKY_SCENE")
	SetAudioFlag("PoliceScannerDisabled",true)

	while true do
		Citizen.Wait(0)

		SetRandomBoats(false)
		SetGarbageTrucks(false)
		SetCreateRandomCops(false)
		SetCreateRandomCopsOnScenarios(false)
		SetCreateRandomCopsNotOnScenarios(false)

		DisableVehicleDistantlights(true)
		-- SetPedDensityMultiplierThisFrame(0.0)
		SetVehicleDensityMultiplierThisFrame(0.75)
		SetParkedVehicleDensityMultiplierThisFrame(0.75)
		-- SetScenarioPedDensityMultiplierThisFrame(0.0,0.0)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADGLOBAL - 10
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		RemoveVehiclesFromGeneratorsInArea(65.95 - 5.0,-1719.34 - 5.0,29.32 - 5.0,65.95 + 5.0,-1719.34 + 5.0,29.32 + 5.0)
		RemoveVehiclesFromGeneratorsInArea(115.57 - 5.0,-1758.6 - 5.0,29.34 - 5.0,115.57 + 5.0,-1758.6 + 5.0,29.34 + 5.0)
		RemoveVehiclesFromGeneratorsInArea(-4.02 - 5.0,-1533.7 - 5.0,29.63 - 5.0,-4.02 + 5.0,-1533.7 + 5.0,29.63 + 5.0)
		RemoveVehiclesFromGeneratorsInArea(100.79 - 5.0,-1605.9 - 5.0,29.52 - 5.0,100.79 + 5.0,-1605.9 + 5.0,29.52 + 5.0)
		RemoveVehiclesFromGeneratorsInArea(43.77 - 5.0,-1288.61 - 5.0,29.15 - 5.0,43.77 + 5.0,-1288.61 + 5.0,29.15 + 5.0)

		------ agachar
		local ped = PlayerPedId()
        DisableControlAction(0,36,true)
        if not IsPedInAnyVehicle(ped) then
            RequestAnimSet("move_ped_crouched")
            RequestAnimSet("move_ped_crouched_strafing")
            if IsDisabledControlJustPressed(0,36) then
                if agachar then
                    ResetPedStrafeClipset(ped)
                    ResetPedMovementClipset(ped,0.25)
                    agachar = false
                else
                    SetPedStrafeClipset(ped,"move_ped_crouched_strafing")
                    SetPedMovementClipset(ped,"move_ped_crouched",0.25)
                    agachar = true
                end
            end
        end

	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- IPLOADER
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	LoadInterior(GetInteriorAtCoords(313.36,-591.02,43.29))
	LoadInterior(GetInteriorAtCoords(440.84,-983.14,30.69))
	LoadInterior(GetInteriorAtCoords(1768.09,3327.09,41.45))
	
	-- Ilha
	Citizen.InvokeNative(0x9A9D1BA639675CF1, 'HeistIsland', true)

	-- misc natives
	Citizen.InvokeNative(0xF74B1FFA4A15FBEA, true)
	Citizen.InvokeNative(0x53797676AD34A9AA, false)    
	SetScenarioGroupEnabled('Heist_Island_Peds', true)

	-- audio stuff
	SetAudioFlag('PlayerOnDLCHeist4Island', true)
	SetAmbientZoneListStatePersistent('AZL_DLC_Hei4_Island_Zones', true, true)
	SetAmbientZoneListStatePersistent('AZL_DLC_Hei4_Island_Disabled_Zones', false, true)

	for _,v in pairs(allIpls) do
		loadInt(v.coords,v.interiorsProps)
	end
end)

function loadInt(coordsTable,table)
	for _,v in pairs(coordsTable) do
		local interior = GetInteriorAtCoords(v[1],v[2],v[3])
		LoadInterior(interior)
		for _,i in pairs(table) do
			EnableInteriorProp(interior,i)
			Citizen.Wait(10)
		end
		RefreshInterior(interior)
	end
end

allIpls = {
	{
		interiorsProps = {
			"swap_clean_apt",
			"layer_debra_pic",
			"layer_whiskey",
			"swap_sofa_A"
		},
		coords = {{ -1150.7,-1520.7,10.6 }}
	},{
		interiorsProps = {
			"csr_beforeMission",
			"csr_inMission"
		},
		coords = {{ -47.1,-1115.3,26.5 }}
	},{
		interiorsProps = {
			"V_Michael_bed_tidy",
			"V_Michael_M_items",
			"V_Michael_D_items",
			"V_Michael_S_items",
			"V_Michael_L_Items"
		},
		coords = {{ -802.3,175.0,72.8 }}
	},{
		interiorsProps = {
			"meth_lab_production",
			"meth_lab_upgrade",
			"meth_lab_setup"
		},
		coords = {{ 38.49,3714.1,11.01 }}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TASERTIME
-----------------------------------------------------------------------------------------------------------------------------------------
local tasertime = false
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()

		if IsPedBeingStunned(ped) then
			timeDistance = 4
			SetPedToRagdoll(ped,7500,7500,0,0,0,0)
		end

		if IsPedBeingStunned(ped) and not tasertime then
			tasertime = true
			timeDistance = 4
			TriggerEvent("cancelando",true)
			ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE",1.0)
		elseif not IsPedBeingStunned(ped) and tasertime then
			tasertime = false
			Citizen.Wait(7500)
			StopGameplayCamShaking()
			TriggerEvent("cancelando",false)
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TELEPORT
-----------------------------------------------------------------------------------------------------------------------------------------
local teleport = {
	{ 338.65,-583.87,74.17,330.34,-601.22,43.29,"DESCER" },  ----hospital parte do heli
	{ 330.34,-601.22,43.29,338.65,-583.87,74.17,"SUBIR" },

	{ 332.26,-595.6,43.29,359.55,-584.95,28.82,"DESCER" },  ---- hospital subir da rua pro hp
	{ 359.55,-584.95,28.82,332.26,-595.6,43.29,"SUBIR" },

	{ 253.96,225.2,101.88,252.3,220.23,101.69,"ENTRAR" },
	{ 252.3,220.23,101.69,253.96,225.2,101.88,"SAIR" },

	{ 4.58,-705.95,45.98,-139.85,-627.0,168.83,"ENTRAR" },
	{ -139.85,-627.0,168.83,4.58,-705.95,45.98,"SAIR" },

	{ -117.29,-604.52,36.29,-74.48,-820.8,243.39,"ENTRAR" },
	{ -74.48,-820.8,243.39,-117.29,-604.52,36.29,"SAIR" },

	{ -826.9,-699.89,28.06,-1575.14,-569.15,108.53,"ENTRAR" },
	{ -1575.14,-569.15,108.53,-826.9,-699.89,28.06,"SAIR" },

	{ -935.68,-378.77,38.97,-1386.84,-478.56,72.05,"ENTRAR" },
	{ -1386.84,-478.56,72.05,-935.68,-378.77,38.97,"SAIR" },

	{ -741.07,5593.13,41.66,446.19,5568.79,781.19,"SUBIR" },
	{ 446.19,5568.79,781.19,-741.07,5593.13,41.66,"DESCER" },

	{ -740.78,5597.04,41.66,446.37,5575.02,781.19,"SUBIR" },
	{ 446.37,5575.02,781.19,-740.78,5597.04,41.66,"DESCER" },

	{ 40.69,3715.73,39.68,28.1,3711.62,13.6,"ENTRAR" }, -- META
	{ 28.1,3711.62,13.6,40.69,3715.73,39.68,"SAIR" },

	{ 241.14,-1378.93,33.75,275.8,-1361.48,24.54,"ENTRAR" },
	{ 275.8,-1361.48,24.54,241.14,-1378.93,33.75,"SAIR" },

	{ 232.89,-411.39,48.12,224.63,-360.7,-98.78,"ENTRAR" },
	{ 224.63,-360.7,-98.78,232.89,-411.39,48.12,"SAIR" },

	{ 234.33,-387.57,-98.78,244.34,-429.14,-98.78,"ENTRAR" },
	{ 244.34,-429.14,-98.78,234.33,-387.57,-98.78,"SAIR" }
}

Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)
			for k,v in pairs(teleport) do
				local distance = #(coords - vector3(v[1],v[2],v[3]))
				if distance <= 2 then
					timeDistance = 4
					DrawText3D(v[1],v[2],v[3],"~g~E~w~   "..v[7])
					if IsControlJustPressed(1,38) then
						DoScreenFadeOut(1000)
						Citizen.Wait(2000)
						SetEntityCoords(ped,v[4],v[5],v[6])
						Citizen.Wait(1000)
						DoScreenFadeIn(1000)
					end
				end
			end
		end
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z,text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,100)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text)) / 450
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,100)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLESUPPRESSED
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	local SUPPRESSED_MODELS = { "SHAMAL","LUXOR","LUXOR2","JET","LAZER","TITAN","BARRACKS","BARRACKS2","CRUSADER","RHINO","AIRTUG","RIPLEY","PHANTOM","HAULER","RUBBLE","BIFF","TACO","PACKER","TRAILERS","TRAILERS2","TRAILERS3","TRAILERS4","BLIMP","POLMAV","MULE","MULE2","MULE3","MULE4" }
	while true do
		for _,model in next,SUPPRESSED_MODELS do
			SetVehicleModelIsSuppressed(GetHashKey(model),true)
		end
		Wait(10000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NPC NAO DROPAR ARMA
-----------------------------------------------------------------------------------------------------------------------------------------
function SetWeaponDrops()
    local handle, ped = FindFirstPed()
    local finished = false

    repeat
        if not IsEntityDead(ped) then
            SetPedDropsWeaponsWhenDead(ped, false)
        end
        finished, ped = FindNextPed(handle)
    until not finished

    EndFindPed(handle)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        SetWeaponDrops()
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PEDS
-----------------------------------------------------------------------------------------------------------------------------------------
local pedlist = {
	{ 406.04,6526.17,27.75,82.26,0x62018559,"s_m_y_airworker","anim@heists@heist_corona@single_team","single_team_loop_boss" }, -- Colheita
	{ -555.2,5364.38,70.43,70.08,0x62018559,"s_m_y_airworker","anim@heists@heist_corona@single_team","single_team_loop_boss" }, -- Lenhador
	{ 453.68,-600.56,28.6,262.54,0x62018559,"s_m_y_airworker","anim@heists@heist_corona@single_team","single_team_loop_boss" }, -- Motorista
	{ 78.04,-1536.51,29.47,137.53,0xEE75A00F,"s_m_y_garbage","anim@heists@heist_corona@single_team","single_team_loop_boss" }, -- Lixeiro 1
	{ 84.2,-1552.04,29.6,50.8,0xEE75A00F,"s_m_y_garbage","anim@heists@heist_corona@single_team","single_team_loop_boss" }, -- Lixeiro
	{ 354.72,269.84,103.02,337.89,0xD768B228,"s_m_m_security_01","anim@heists@heist_corona@single_team","single_team_loop_boss" }, -- Transportador
	{ 1078.69,-1954.9,31.03,105.61,0xD7DA9E99,"s_m_y_construct_01","anim@heists@heist_corona@single_team","single_team_loop_boss" }, -- Minerador
	{ 1075.95,-1978.71,31.48,143.1,0xC5FEFADE,"s_m_y_construct_02","amb@prop_human_parking_meter@female@idle_a","idle_a_female" }, -- Minerador
	{ 1082.45,-1997.86,31.23,19.94,0xC5FEFADE,"s_m_y_construct_02","anim@heists@heist_corona@single_team","single_team_loop_boss" }, -- Minerador
	{ 287.65,2843.45,44.71,77.11,0xC5FEFADE,"s_m_y_construct_02","anim@heists@heist_corona@single_team","single_team_loop_boss" }, -- Minerador
	{ 1163.26,-1483.47,34.85,88.64,0xAB594AB6,"s_f_y_scrubs_01","anim@heists@heist_corona@single_team","single_team_loop_boss" }, -- Hospital
	{ 1598.9,6457.99,25.32,247.46,0xAB594AB6,"s_f_y_scrubs_01","anim@heists@heist_corona@single_team","single_team_loop_boss" }, -- Restaurant
	{ 714.02,-961.53,30.4,183.57,0xD7DA9E99,"s_m_y_construct_01","anim@heists@heist_corona@single_team","single_team_loop_boss" }, -- Costura
	{ -223.42,-1508.51,31.37,229.18,0x2D0EFCEB,"u_m_y_cyclist_01","anim@heists@heist_corona@single_team","single_team_loop_boss" }, -- Bike
	{ 1851.99,2595.64,45.69,268.29,0x2D0EFCEB,"u_m_y_cyclist_01","anim@heists@heist_corona@single_team","single_team_loop_boss" } -- Bike
 }
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADPEDLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local localPeds = {}
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		local ped = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(ped))

		for k,v in pairs(pedlist) do
			local distance = GetDistanceBetweenCoords(x,y,z,v[1],v[2],v[3],true)
			if distance <= 60 then
				if localPeds[k] == nil then
					RequestModel(GetHashKey(v[6]))
					while not HasModelLoaded(GetHashKey(v[6])) do
						RequestModel(GetHashKey(v[6]))
						Citizen.Wait(10)
					end

					localPeds[k] = CreatePed(4,v[5],v[1],v[2],v[3]-1,v[4],false,true)
					SetEntityInvincible(localPeds[k],true)
					FreezeEntityPosition(localPeds[k],true)
					SetBlockingOfNonTemporaryEvents(localPeds[k],true)

					if v[7] ~= nil then
						RequestAnimDict(v[7])
						while not HasAnimDictLoaded(v[7]) do
							RequestAnimDict(v[7])
							Citizen.Wait(10)
						end

						TaskPlayAnim(localPeds[k],v[7],v[8],8.0,0.0,-1,1,0,0,0,0)
					end
				end
			else
				if localPeds[k] then
					DeleteEntity(localPeds[k])
					localPeds[k] = nil
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FREE PEDS
-----------------------------------------------------------------------------------------------------------------------------------------
local freepedlist = {
	{ 24.51,-1347.27,29.5,261.02,0xD15D7E71,"a_m_m_ktown_01","anim@heists@heist_corona@single_team","single_team_loop_boss" }, -- Perto do Vanilla
	{ 2557.15,380.71,108.63,350.7,0xD15D7E71,"a_m_m_ktown_01","anim@heists@heist_corona@single_team","single_team_loop_boss" }, -- Posto North Avenida
	{ 1164.73,-322.66,69.21,99.48,0xD15D7E71,"a_m_m_ktown_01","anim@heists@heist_corona@single_team","single_team_loop_boss" }, -- Perto da Barragen
	{ -706.16,-913.63,19.22,89.09,0xD15D7E71,"a_m_m_ktown_01","anim@heists@heist_corona@single_team","single_team_loop_boss" }, -- Perto da Waze News
	{ -46.7,-1757.85,29.43,49.43,0xD15D7E71,"a_m_m_ktown_01","anim@heists@heist_corona@single_team","single_team_loop_boss" }, -- Perto dos Ballas
	{ 372.56,326.44,103.57,260.89,0xD15D7E71,"a_m_m_ktown_01","anim@heists@heist_corona@single_team","single_team_loop_boss" }, -- Perto do Banco Central
	{ -3242.23,999.97,12.84,352.58,0xD15D7E71,"a_m_m_ktown_01","anim@heists@heist_corona@single_team","single_team_loop_boss" }, -- Perto do Deck
	{ 1727.86,6415.3,35.04,238.52,0xD15D7E71,"a_m_m_ktown_01","anim@heists@heist_corona@single_team","single_team_loop_boss" }, -- Perto do Tunel Palleto
	{ 549.14,2671.29,42.16,92.83,0xD15D7E71,"a_m_m_ktown_01","anim@heists@heist_corona@single_team","single_team_loop_boss" }, -- Perto do Animal Ark
	{ 1960.04,3740.11,32.35,300.19,0xD15D7E71,"a_m_m_ktown_01","anim@heists@heist_corona@single_team","single_team_loop_boss" }, -- Perto do North Avenue
	{ 2677.9,3279.42,55.25,322.63,0xD15D7E71,"a_m_m_ktown_01","anim@heists@heist_corona@single_team","single_team_loop_boss" }, -- Perto do Desmanche
	{ 1698.06,4922.92,42.07,315.58,0xD15D7E71,"a_m_m_ktown_01","anim@heists@heist_corona@single_team","single_team_loop_boss" }, -- Perto da Fazenda
	{ -1820.16,794.29,138.09,130.71,0xD15D7E71,"a_m_m_ktown_01","anim@heists@heist_corona@single_team","single_team_loop_boss" }, -- Posto Canyon Drive
	{ 1392.74,3606.39,34.99,184.36,0x917ED459,"mp_m_weed_01","anim@heists@heist_corona@single_team","single_team_loop_boss" }, -- Loja abandonada no North
	{ -2966.35,391.02,15.05,93.07,0xD15D7E71,"a_m_m_ktown_01","anim@heists@heist_corona@single_team","single_team_loop_boss" }, -- Banco pra cima da Praia
	{ -3039.01,584.45,7.91,14.95,0xD15D7E71,"a_m_m_ktown_01","anim@heists@heist_corona@single_team","single_team_loop_boss" }, -- Na Praia Afastada
	{ 1134.16,-982.44,46.42,279.52,0xD15D7E71,"a_m_m_ktown_01","anim@heists@heist_corona@single_team","single_team_loop_boss" }, -- Depois da Ponte da DP Praça
	{ 1165.89,2710.82,38.16,177.46,0xB1BB9B59,"s_m_y_prisoner_01","anim@heists@heist_corona@single_team","single_team_loop_boss" }, -- Perto da Prisão
	{ -1486.21,-377.97,40.17,136.67,0xD15D7E71,"a_m_m_ktown_01","anim@heists@heist_corona@single_team","single_team_loop_boss" }, -- Perto do Centro
	{ -1221.94,-908.37,12.33,33.74,0xC79F6928,"a_f_y_beach_01","anim@heists@heist_corona@single_team","single_team_loop_boss" }, -- Perto do Pier Príncipal
	{ 991.91,-2175.43,29.98,182.48,0x4163A158,"s_m_y_factory_01","anim@heists@heist_corona@single_team","single_team_loop_boss" }, -- Fábrica de carnes
	{ 991.23,-2183.83,30.68,94.63,0x4163A158,"s_m_y_factory_01","anim@heists@heist_corona@single_team","single_team_loop_boss" }, -- Matadouro fábrica
	{ 962.0,-2109.92,31.95,84.02,0x14D7B4E0,"s_m_m_dockwork_01","anim@heists@heist_corona@single_team","single_team_loop_boss" }, -- Veículo fábrica
	{ 970.27,-2181.42,29.98,165.58,0xFCFA9E1E,"a_c_cow","anim@heists@heist_corona@single_team","single_team_loop_boss" }, -- Vaca
	{ 982.85,-2183.34,30.67,265.12,0xB11BAB56,"a_c_pig","anim@heists@heist_corona@single_team","single_team_loop_boss" }, -- Porco
    { 73.99,-1393.05,29.38,265.06,0x445AC854,"a_f_y_bevhills_01","anim@heists@heist_corona@single_team","single_team_loop_boss" }, -- Perto do Vanilla
	{ -709.02,-151.54,37.42,123.5,0x445AC854,"a_f_y_bevhills_01","anim@heists@heist_corona@single_team","single_team_loop_boss" }, -- Perto da Prefeitura
	{ -165.09,-303.19,39.74,251.93,0x445AC854,"a_f_y_bevhills_01","anim@heists@heist_corona@single_team","single_team_loop_boss" }, -- No Rockford Plaza
	{ 427.06,-806.23,29.5,85.88,0x445AC854,"a_f_y_bevhills_01","anim@heists@heist_corona@single_team","single_team_loop_boss" }, -- Perto da Antiga Polícia
	{ -823.15,-1072.28,11.33,205.58,0x445AC854,"a_f_y_bevhills_01","anim@heists@heist_corona@single_team","single_team_loop_boss" }, -- Perto da Waze News
	{ -1193.92,-767.02 ,17.32,209.75,0x445AC854,"a_f_y_bevhills_01","anim@heists@heist_corona@single_team","single_team_loop_boss" }, -- Perto do Bahamas
	{ -1448.76,-237.87,49.82,47.44,0x445AC854,"a_f_y_bevhills_01","anim@heists@heist_corona@single_team","single_team_loop_boss" }, -- Perto do Cemitério
	{ 5.97,6511.48,31.88,44.83,0x445AC854,"a_f_y_bevhills_01","anim@heists@heist_corona@single_team","single_team_loop_boss" }, -- Em Paleto Bay
	{ 1695.36,4822.95,42.07,98.0,0x445AC854,"a_f_y_bevhills_01","anim@heists@heist_corona@single_team","single_team_loop_boss" }, -- Sentido North
	{ 127.0,-224.2,54.56,71.23,0x445AC854,"a_f_y_bevhills_01","anim@heists@heist_corona@single_team","single_team_loop_boss" }, -- Avenida do Banco Central
	{ 612.95,2762.66,42.09,266.26,0x445AC854,"a_f_y_bevhills_01","anim@heists@heist_corona@single_team","single_team_loop_boss" }, -- Ao lado do Animal ARK
	{ 1196.64,2711.63,38.23,178.79,0x445AC854,"a_f_y_bevhills_01","anim@heists@heist_corona@single_team","single_team_loop_boss" }, -- Perto da Prisão
	{ -3169.4,1043.13,20.87,64.8,0x445AC854,"a_f_y_bevhills_01","anim@heists@heist_corona@single_team","single_team_loop_boss" }, -- Pra cima da Praia
	{ -1102.35,2711.72,19.11,215.38,0x445AC854,"a_f_y_bevhills_01","anim@heists@heist_corona@single_team","single_team_loop_boss" }, -- Rota 68
    { 1208.58,-3115.36,5.55,267.65,0x441405EC,"s_m_y_xmech_01","anim@heists@heist_corona@single_team","single_team_loop_boss" }, -- Na zona do porto
	{ 1199.03,-3121.63,5.55,300.76,0x441405EC,"s_m_y_xmech_02","anim@heists@heist_corona@single_team","single_team_loop_boss" }, -- Na zona do porto
	{ 1986.48,3789.67,32.19,295.75,0x441405EC,"s_m_y_xmech_01","anim@heists@heist_corona@single_team","single_team_loop_boss" }, -- No norte
    { 1203.78,2647.17,37.81,47.87,0x441405EC,"s_m_y_xmech_01","anim@heists@heist_corona@single_team","single_team_loop_boss" }, -- Rota 69
    { -86.31,31.57,71.96,76.27,0x445AC854,"a_f_y_bevhills_01","anim@heists@heist_corona@single_team","single_team_loop_boss" }, -- Loja de Eletrônicos
    { -623.09,-229.22,38.06,200.48,0x36DF2D5D,"a_f_y_bevhills_04","anim@heists@heist_corona@single_team","single_team_loop_boss" }, -- Joalheria
	{ 318.23,-1078.4,29.48,5.53,0xDF8B1301,"cs_patricia","anim@heists@heist_corona@single_team","single_team_loop_boss" }, -- Do lado da Praça
    { -1170.73,-1570.53,4.67,123.18,0x0DE9A30A,"s_m_m_ammucountry","anim@heists@heist_corona@single_team","single_team_loop_boss" }, -- Loja de Maconha
	{ -56.4,-1098.57,26.43,14.28,0x9B557274,"s_m_y_devinsec_01","anim@heists@heist_corona@single_team","single_team_loop_boss" }, -- Loja de carros normais
	{ -54.15,67.33,71.97,79.09,0x9B557274,"s_m_y_devinsec_01","anim@heists@heist_corona@single_team","single_team_loop_boss" }
 }
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADPEDLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local localFreePeds = {}
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		local ped = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(ped))

		for k,v in pairs(freepedlist) do
			local distance = GetDistanceBetweenCoords(x,y,z,v[1],v[2],v[3],true)
			if distance <= 60 then
				if localFreePeds[k] == nil then
					RequestModel(GetHashKey(v[6]))
					while not HasModelLoaded(GetHashKey(v[6])) do
						RequestModel(GetHashKey(v[6]))
						Citizen.Wait(10)
					end

					localFreePeds[k] = CreatePed(4,v[5],v[1],v[2],v[3]-1,v[4],false,true)

					if v[7] ~= nil then
						RequestAnimDict(v[7])
						while not HasAnimDictLoaded(v[7]) do
							RequestAnimDict(v[7])
							Citizen.Wait(10)
						end

						TaskPlayAnim(localFreePeds[k],v[7],v[8],8.0,0.0,-1,1,0,0,0,0)
					end
				end
			else
				if localFreePeds[k] then
					DeleteEntity(localFreePeds[k])
					localFreePeds[k] = nil
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- Rich Presence
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        SetDiscordAppId(745078205140041738)
        SetDiscordRichPresenceAsset('logo')
        SetDiscordRichPresenceAssetText('rolepley')
        SetDiscordRichPresenceAssetSmall('ON-Arts')
        SetDiscordRichPresenceAssetSmallText('A Identidade visual da sua Cidade!')
        SetDiscordRichPresenceAction(0, "Jogar", "https://discord.gg/7yKkShSVCC")
        SetDiscordRichPresenceAction(1, "discord", "https://discord.gg/7yKkShSVCC")
        Citizen.Wait(60000)
    end
end)