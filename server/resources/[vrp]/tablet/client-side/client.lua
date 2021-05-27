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
Tunnel.bindInterface("tablet",cnVRP)
vSERVER = Tunnel.getInterface("tablet")
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADFOCUS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TABLET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tablet",function(source,args)
	if GetEntityHealth(PlayerPedId()) > 101 then
		SetNuiFocus(true,true)
		SetCursorLocation(0.5,0.5)
		SendNUIMessage({ action = "openSystem" })
	else
		return
	end
	
	if not IsPedInAnyVehicle(PlayerPedId()) and GetEntityHealth(PlayerPedId()) > 101 then
		vRP.createObjects("amb@code_human_in_bus_passenger_idles@female@tablet@base","base","prop_cs_tablet",50,28422)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TABLET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("tablet","Abrir o tablet","keyboard","f11")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSESYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("closeSystem",function(data)
	vRP.removeObjects("one")
	SetNuiFocus(false,false)
	SetCursorLocation(0.5,0.5)
	SendNUIMessage({ action = "closeSystem" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTMEDIA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestMedia",function(data,cb)
	local result = vSERVER.requestMedia(data.media)
	if result then
		cb(json.encode(result))
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTBUY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("messageMedia",function(data,cb)
	vSERVER.messageMedia(data.message,data.page)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEMEDIA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("tablet:updateMedia")
AddEventHandler("tablet:updateMedia",function(media,data,back)
	SendNUIMessage({ action = "messageMedia", media = media, data = data, back = back })
end)