-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cnVRP = {}
Tunnel.bindInterface("shops",cnVRP)
vSERVER = Tunnel.getInterface("shops")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("close",function(data)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideNUI" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestShop",function(data,cb)
	local inventoryShop,inventoryUser,weight,maxweight,infos = vSERVER.requestShop(data.shop)
	if inventoryShop then
		cb({ inventoryShop = inventoryShop, inventoryUser = inventoryUser, weight = weight, maxweight = maxweight, infos = infos })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTBUY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("functionShops",function(data,cb)
	vSERVER.functionShops(data.shop,data.item,data.amount,data.slot)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("populateSlot",function(data,cb)
	TriggerServerEvent("shops:populateSlot",data.item,data.slot,data.target,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateSlot",function(data,cb)
	TriggerServerEvent("shops:updateSlot",data.item,data.slot,data.target,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("shops:Update")
AddEventHandler("shops:Update",function(action)
	SendNUIMessage({ action = action })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:DEPARTAMENTSTORE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:departamentStore",function()
	if GetClockHours() >= 15 and GetClockHours() <= 20 then
		SendNUIMessage({ action = "showNUI", name = tostring("departamentStore"), type = vSERVER.getShopType("departamentStore") })
		SetNuiFocus(true,true)
		TriggerEvent("sounds:source","shop",0.5)
	else
		TriggerEvent("Notify","amarelo","Loja fechada, a mesma só funciona das <b>15</b> ás <b>20</b> horas.",3000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:AMMUNATIONSTORE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:ammunationStore",function()
	SendNUIMessage({ action = "showNUI", name = tostring("ammunationStore"), type = vSERVER.getShopType("ammunationStore") })
	SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:NORMALPHARMACYSTORE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:normalpharmacyStore",function()
		SendNUIMessage({ action = "showNUI", name = tostring("normalpharmacyStore"), type = vSERVER.getShopType("normalpharmacyStore") })
		SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:HOSPITALPHARMACYSTORE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:hospitalpharmacyStore",function()
	if vSERVER.requestPerm("hospitalpharmacyStore") then
		SendNUIMessage({ action = "showNUI", name = tostring("hospitalpharmacyStore"), type = vSERVER.getShopType("hospitalpharmacyStore") })
		SetNuiFocus(true,true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:MEGAMALL
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:megaMallStore",function()
		SendNUIMessage({ action = "showNUI", name = tostring("megaMallStore"), type = vSERVER.getShopType("megaMallStore") })
		SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:RECYCLINGSELL
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:recyclingSell",function()
		SendNUIMessage({ action = "showNUI", name = tostring("recyclingSell"), type = vSERVER.getShopType("recyclingSell") })
		SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:BARSSTORE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:barsStore",function()
		SendNUIMessage({ action = "showNUI", name = tostring("barsStore"), type = vSERVER.getShopType("barsStore") })
		SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:JEWELRYSTORE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:jewelryStore",function()
		SendNUIMessage({ action = "showNUI", name = tostring("jewelryStore"), type = vSERVER.getShopType("jewelryStore") })
		SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:HUNTINGSTORE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:huntingStore",function()
		SendNUIMessage({ action = "showNUI", name = tostring("huntingStore"), type = vSERVER.getShopType("huntingStore") })
		SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:COFFEEMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:coffeeMachine",function()
	SendNUIMessage({ action = "showNUI", name = tostring("coffeeMachine"), type = vSERVER.getShopType("coffeeMachine") })
	SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:COLAMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:colaMachine",function()
	SendNUIMessage({ action = "showNUI", name = tostring("colaMachine"), type = vSERVER.getShopType("colaMachine") })
	SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:SODAMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:sodaMachine",function()
	SendNUIMessage({ action = "showNUI", name = tostring("sodaMachine"), type = vSERVER.getShopType("sodaMachine") })
	SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:DONUTMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:donutMachine",function()
	SendNUIMessage({ action = "showNUI", name = tostring("donutMachine"), type = vSERVER.getShopType("donutMachine") })
	SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:BURGERMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:burgerMachine",function()
	SendNUIMessage({ action = "showNUI", name = tostring("burgerMachine"), type = vSERVER.getShopType("burgerMachine") })
	SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:HOTDOGMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:hotdogMachine",function()
	SendNUIMessage({ action = "showNUI", name = tostring("hotdogMachine"), type = vSERVER.getShopType("hotdogMachine") })
	SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:WATERMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:waterMachine",function()
	SendNUIMessage({ action = "showNUI", name = tostring("waterMachine"), type = vSERVER.getShopType("waterMachine") })
	SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local shopList = {
	{ 2769.34,2685.25,58.61,"departamentStore",true,false },
	{ -313.87,-120.5,39.02,"mecanicaStore",true,false },
	{ -621.01,-228.59,38.06,"joalheriaStore",true,false },
	{ 841.99,-963.02,25.98,"mecanicaStore",true,true },
	{ 977.96,-95.11,74.87,"armasStoreMC",true,true },
	{ 1488.23,1128.22,114.34,"armasStoreMafia",true,true },
	-- { 802.52,-970.6,26.09,"coffeeMachine",false,true },
	{ 1164.3,3323.05,50.74,"departamentStore",true,false },
	{ 2517.22,-343.59,94.1,"dpStore",true,false },
	{ -505.97,5263.0,80.67,"lenhadorSell",true,false },
	{ 25.68,-1346.6,29.5,"departamentStore",true,false },
	{ 2556.47,382.05,108.63,"departamentStore",true,false },
	{ 1163.55,-323.02,69.21,"departamentStore",true,false },
	{ -707.31,-913.75,19.22,"departamentStore",true,false },
	{ -2073.48,-522.35,13.72,"pierStore",true,false },
	{ -47.72,-1757.23,29.43,"departamentStore",true,false },
	{ 373.89,326.86,103.57,"departamentStore",true,false },
	{ -3242.95,1001.28,12.84,"departamentStore",true,false },
	{ 1729.3,6415.48,35.04,"departamentStore",true,false },
	{ -2194.07,-388.71,13.48,"ShopPearls",true,false },
	{ 548.0,2670.35,42.16,"departamentStore",true,false },
	{ 1960.69,3741.34,32.35,"departamentStore",true,false },
	{ 2677.92,3280.85,55.25,"departamentStore",true,false },
	{ 1698.5,4924.09,42.07,"departamentStore",true,false },
	{ -1820.82,793.21,138.12,"departamentStore",true,false },
	{ 1393.21,3605.26,34.99,"departamentStore",true,false },
	{ -2967.78,390.92,15.05,"departamentStore",true,false },
	{ -3040.14,585.44,7.91,"departamentStore",true,false },
	{ 1135.56,-982.24,46.42,"departamentStore",true,false },
	{ 1166.0,2709.45,38.16,"departamentStore",true,false },
	{ 4903.15,-4940.73,3.37,"departamentStore",true,false },
	{ -1487.21,-378.99,40.17,"departamentStore",true,false },
	{ -1222.76,-907.21,12.33,"departamentStore",true,false },
	{ 1692.62,3759.50,34.70,"ammunationStore",true,false },
	{ 252.89,-49.25,69.94,"ammunationStore",true,false },
	{ 843.28,-1034.02,28.19,"ammunationStore",true,false },
	{ -331.35,6083.45,31.45,"ammunationStore",true,false },
	{ -663.15,-934.92,21.82,"ammunationStore",true,false },
	{ -1305.18,-393.48,36.69,"ammunationStore",true,false },
	{ -1118.80,2698.22,18.55,"ammunationStore",true,false },
	{ 2568.83,293.89,108.73,"ammunationStore",true,false },
	{ -3172.68,1087.10,20.83,"ammunationStore",true,false },
	{ 21.32,-1106.44,29.79,"ammunationStore",true,false },
	{ 811.19,-2157.67,29.61,"ammunationStore",true,false },
	{ -1082.22,-247.54,37.77,"premiumStore",false,false },
	{ -679.07,5834.47,17.34,"caçadorStore",false,false },
	{ 3802.54,4473.25,4.94,"fishingSell",false,false },
	{ 337.98,-594.77,43.29,"pharmacyStore",true,false },
	{ 895.12,-2115.16,30.77,"theslostShop",false,true },
	{ 229.39,-369.77,-98.78,"registryStore",false,false },
	{ 46.66,-1749.79,29.64,"megaMallStore",false,false },
	{ 2747.34,3473.01,55.68,"megaMallStore",false,false },
	{ -428.54,-1728.29,19.78,"recyclingSell",false,false },
	{ 719.03,-961.58,30.4,"lester",false,false },
	{ 716.56,-961.59,30.4,"lester2",false,false },
	{ 813.14,-281.25,66.47,"Drugs",false,false },
	-- { 2525.69,-342.87,101.9,"policeStore",false,false },
	{ 159.94,-995.51,29.36,"policeStore",false,false },
	-- { 416.41,-1902.86,25.62,"redCash",false,false },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADOPEN
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)

	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)
			for k,v in pairs(shopList) do
				local distance = #(coords - vector3(v[1],v[2],v[3]))
				if distance <= 1.5 then
					timeDistance = 4
					DrawText3D(v[1],v[2],v[3],"~g~E~w~   ABRIR")
					if IsControlJustPressed(1,38) and vSERVER.requestPerm(v[4]) then
						SetNuiFocus(true,true)
						TransitionToBlurred(1000)
						SendNUIMessage({ action = "showNUI", name = tostring(v[4]), type = vSERVER.getShopType(v[4]) })
						if v[5] then
							TriggerEvent("vrp_sound:source","shop",0.5)
						end
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
	SetTextFont(4)
	SetTextCentre(1)
	SetTextEntry("STRING")
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,150)
	AddTextComponentString(text)
	SetDrawOrigin(x,y,z,0)
	DrawText(0.0,0.0)
	local factor = (string.len(text) / 450) + 0.01
	DrawRect(0.0,0.0125,factor,0.03,38,42,56,200)
	ClearDrawOrigin()
end