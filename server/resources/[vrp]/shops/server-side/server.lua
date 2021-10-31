-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("shops",cRP)
vCLIENT = Tunnel.getInterface("shops")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local shops = {
	["departamentStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["tacos"] = 150,
			["hamburger"] = 150,
			["hotdog"] = 150,
			["soda"] = 150,
			["cola"] = 150,
			["chocolate"] = 150,
			["water"] = 150,
			["coffee"] = 150,
			["sandwich"] = 150,
			["energetic"] = 200,
			["fries"] = 150
		}
	},
	["dpStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["perm"] = "Paramedic",
		["list"] = {
			["tacos"] = 1000,
			["hamburger"] = 1000,
			["hotdog"] = 1000,
			["soda"] = 1000,
			["cola"] = 1000,
			["water"] = 50,
			["sandwich"] = 1000,
			["fries"] = 1000
		}
	},
	["lenhadorSell"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["woodlog"] = 30,
		}
	},
	["Drugs"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["perm"] = "Admin",
		["list"] = {
			["weed"] = 100
		}
	},
	["dpStore2"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["tacos"] = 1000,
			["hamburger"] = 1000,
			["hotdog"] = 1000,
			["soda"] = 1000,
			["cola"] = 1000,
			["water"] = 50,
			["sandwich"] = 1000,
			["fries"] = 1000
		}
	},
	["mecanicaStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["tires"] = 775,
			["toolbox"] = 820,
		}
	},
	["caçadorStore"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["meat"] = 100,
		}
	},
	["joalheriaStore"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["goldbar"] = 50,
		}
	},
	["theslostShop"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["perm"] = "TheLost",
		["list"] = {
			["toolbox"] = 50,
		}
	},
	["ShopPearls"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["sugar"] = 500,
			["caramelo"] = 500,
			["massa"] = 500,
		}
	},
	["armasStoreMC"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["perm"] = "Motoclub",
		["list"] = {
			["WEAPON_SPECIALCARBINE"] = 250000,
			["WEAPON_ASSAULTRIFLE"] = 200000,
			["WEAPON_PISTOL_MK2"] = 70000,
			["WEAPON_GUSENBERG"] = 160000,
			["WEAPON_SMG"] = 160000,
			["WEAPON_PUMPSHOTGUN_MK2"] = 80000,
			["WEAPON_SMG_AMMO"] = 80000,
			["WEAPON_PISTOL_AMMO"] = 80000,
			["WEAPON_RIFLE_AMMO"] = 80000,
			["vest"] = 8000,
			["hood"] = 10000,
		}
	},
	["armasStoreMafia"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["perm"] = "Mafia",
		["list"] = {
			["WEAPON_SPECIALCARBINE"] = 250000,
			["WEAPON_ASSAULTRIFLE"] = 200000,
			["WEAPON_PISTOL_MK2"] = 70000,
			["WEAPON_GUSENBERG"] = 160000,
			["WEAPON_SMG"] = 160000,
			["WEAPON_SMG_AMMO"] = 100,
			["WEAPON_PISTOL_AMMO"] = 100,
			["WEAPON_RIFLE_AMMO"] = 100,
			["WEAPON_PUMPSHOTGUN"] = 80000,
			["vest"] = 8000,
			["hood"] = 10000,
		}
	},
	["pharmacyStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["perm"] = "Paramedic",
		["list"] = {
			["gauze"] = 500,
			["bandage"] = 650,
			["analgesic"] = 50,
			["medkit"] = 2000,
			["sinkalmy"] = 1000,
			["ritmoneury"] = 1750,
			["adrenaline"] = 4650
		}
	},
	["pierStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["soda"] = 20,
			["chocolate"] = 10
		}
	},
	["ammunationStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["GADGET_PARACHUTE"] = 1000,
			["WEAPON_KNIFE"] = 4000,
			["WEAPON_HATCHET"] = 4000,
			["WEAPON_BAT"] = 4000,
			["WEAPON_BATTLEAXE"] = 4000,
			["WEAPON_BOTTLE"] = 4000,
			["WEAPON_CROWBAR"] = 4000,
			["WEAPON_DAGGER"] = 4000,
			["WEAPON_GOLFCLUB"] = 4000,
			["WEAPON_HAMMER"] = 4000,
			["WEAPON_MACHETE"] = 4000,
			["WEAPON_POOLCUE"] = 4000,
			["WEAPON_STONE_HATCHET"] = 4000,
			["WEAPON_SWITCHBLADE"] = 4000,
			["WEAPON_WRENCH"] = 4000,
			["WEAPON_KNUCKLE"] = 4000
		}
	},
	["premiumStore"] = {
		["mode"] = "Buy",
		["type"] = "Premium",
		["list"] = {
			["premium04"] = 100,
			["premiumpersonagem"] = 150,
			["premiumgarage"] = 30,
			["premiumplate"] = 30,
			["premiumname"] = 75,
			["backpackpremium"] = 75,
			["premiumchip"] = 20,
		}
	},
	["fishingSell"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["shrimp"] = 350,
			["octopus"] = 250,
			["carp"] = 150
		}
	},
	["recyclingSell"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["plastic"] = 50,
			["glass"] = 50,
			["rubber"] = 50,
			["aluminum"] = 50,
			["copper"] = 50,
		}
	},
	["lester"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["lighter"] = 300,
			["bucket"] = 100,
			["divingsuit"] = 2500,
			["teddy"] = 250,
			["fishingrod"] = 2500,
			["identity"] = 300,
			["radio"] = 2000,
			["cellphone"] = 1000,
			["binoculars"] = 500,
			["camera"] = 1000,
			["vape"] = 10000,
			["pager"] = 3000,
			["keyboard"] = 250,
			["mouse"] = 225,
			["ring"] = 200,
			["watch"] = 350,
			["goldbar"] = 500,
			["playstation"] = 400,
			["xbox"] = 400,
			["legos"] = 200,
			["ominitrix"] = 350,
			["bracelet"] = 500,
			["dildo"] = 250,
			["postit"] = 10,
			["lockpick2"] = 250,
			["goldring"] = 500

		}
	},
	["lester2"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["handcuff"] = 7750,
			["c4"] = 7750,
			["raceticket"] = 500
		}
	},
	["registryStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["identity"] = 600
		}
	},
	["megaMallStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["divingsuit"] = 2500,
			["rope"] = 1000,
			["teddy"] = 15,
			["rose"] = 50,
			["paperbag"] = 50,
			["firecracker"] = 1000,
			["bait"] = 10,
			["radio"] = 2000,
			["cellphone"] = 1500,
			["binoculars"] = 1000,
			["camera"] = 1000,
			["fishingrod"] = 1000
		}
	},
	["coffeeMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["coffee"] = 200
		}
	},
	["sodaMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["soda"] = 1000
		}
	},
	["colaMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["cola"] = 1000
		}
	},
	["donutMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["chocolate"] = 500
		}
	},
	["snackMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["chocolate"] = 500
		}
	},
	["burgerMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["hamburger"] = 1000
		}
	},
	["hotdogMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["hotdog"] = 1000
		}
	},
	["waterMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["water"] = 50
		}
	},
	["redCash"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["analgesic"] = 150,
		}
	},
	["policeStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["WEAPON_PISTOL_MK2"] = 1,
			["WEAPON_PISTOL_MK2_AMMO"] = 1,
			["WEAPON_SMG"] = 1,
			["WEAPON_SMG_AMMO"] = 1,
			["WEAPON_CARBINERIFLE"] = 1,
			["WEAPON_CARBINERIFLE_AMMO"] = 1,
			["WEAPON_CARBINERIFLE_MK2"] = 1,
			["WEAPON_CARBINERIFLE_MK2_AMMO"] = 1,
			["WEAPON_MICROSMG"] = 1,
			["WEAPON_MICROSMG_AMMO"] = 1,
			["WEAPON_PUMPSHOTGUN"] = 1,
			["WEAPON_PUMPSHOTGUN_AMMO"] = 1,
			["WEAPON_STUNGUN"] = 1,
			["WEAPON_NIGHTSTICK"] = 1,
			["WEAPON_COMBATPISTOL"] = 1,
			["WEAPON_SHOTGUN_AMMO"]= 1,
			["WEAPON_COMBATPISTOL_AMMO"] = 1
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTPERM
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestPerm(shopType)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.wantedReturn(user_id) then
			return false
		end

		if shops[shopType]["perm"] ~= nil then
			if not vRP.hasPermission(user_id,shops[shopType]["perm"]) then
				return false
			end
		end
		
		return true
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestShop(name)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		local inventoryShop = {}
		for k,v in pairs(shops[name]["list"]) do
			table.insert(inventoryShop,{ price = parseInt(v), name = vRP.itemNameList(k), index = vRP.itemIndexList(k), key = k, weight = vRP.itemWeightList(k) })
		end

		local inventoryUser = {}
		local inv = vRP.getInventory(user_id)
		if inv then
			for k,v in pairs(inv) do
				v.amount = parseInt(v.amount)
				v.name = vRP.itemNameList(v.item)
				v.peso = vRP.itemWeightList(v.item)
				v.index = vRP.itemIndexList(v.item)
				v.key = v.item
				v.slot = k

				inventoryUser[k] = v
			end
		end

		return inventoryShop,inventoryUser,vRP.computeInvWeight(user_id),vRP.getBackpack(user_id),{ identity.name.." "..identity.name2,parseInt(user_id),parseInt(identity.bank),parseInt(vRP.getGmsId(user_id)),identity.phone,identity.registration }
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETSHOPTYPE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.getShopType(name)
    return shops[name].mode
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.functionShops(shopType,shopItem,shopAmount,slot)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if shopAmount == nil then shopAmount = 1 end
		if shopAmount <= 0 then shopAmount = 1 end
		local inv = vRP.getInventory(user_id)
		if inv then
			if shops[shopType]["mode"] == "Buy" then
				if vRP.computeInvWeight(parseInt(user_id)) + vRP.itemWeightList(shopItem) * parseInt(shopAmount) <= vRP.getBackpack(parseInt(user_id)) then
					if shops[shopType]["type"] == "Cash" then
						if shops[shopType]["list"][shopItem] then
							if vRP.paymentBank(parseInt(user_id),parseInt(shops[shopType]["list"][shopItem]*shopAmount)) then

								if inv[tostring(slot)] then
									vRP.giveInventoryItem(parseInt(user_id),shopItem,parseInt(shopAmount),false)
								else
									vRP.giveInventoryItem(parseInt(user_id),shopItem,parseInt(shopAmount),false,slot)
								end							else
								TriggerClientEvent("Notify",source,"vermelho","Dinheiro insuficiente.",5000)
							end
						end
					elseif shops[shopType]["type"] == "Consume" then
						if vRP.tryGetInventoryItem(parseInt(user_id),shops[shopType]["item"],parseInt(shops[shopType]["list"][shopItem]*shopAmount)) then
							if inv[tostring(slot)] then
								vRP.giveInventoryItem(parseInt(user_id),shopItem,parseInt(shopAmount),false)
							else
								vRP.giveInventoryItem(parseInt(user_id),shopItem,parseInt(shopAmount),false,slot)
							end
						else
							TriggerClientEvent("Notify",source,"vermelho","Insuficiente "..vRP.itemNameList(shops[shopType]["item"])..".",5000)
						end
					elseif shops[shopType]["type"] == "Premium" then
						local identity = vRP.getUserIdentity(parseInt(user_id))
						local consult = vRP.getInfos(identity.steam)
						if parseInt(consult[1].gems) >= parseInt(shops[shopType]["list"][shopItem]*shopAmount) then
							if inv[tostring(slot)] then
								vRP.giveInventoryItem(parseInt(user_id),shopItem,parseInt(shopAmount),false)
							else
								vRP.giveInventoryItem(parseInt(user_id),shopItem,parseInt(shopAmount),false,slot)
							end							vRP.remGmsId(user_id,parseInt(shops[shopType]["list"][shopItem]*shopAmount))
							TriggerClientEvent("Notify",source,"verde","Você comprou <b>"..vRP.format(parseInt(shopAmount)).."x "..vRP.itemNameList(shopItem).."</b> por <b>"..vRP.format(parseInt(shops[shopType]["list"][shopItem]*shopAmount)).." coins</b>.",5000)
						else
							TriggerClientEvent("Notify",source,"vermelho","Coins Insuficientes.",5000)
						end
					end
				else
					TriggerClientEvent("Notify",source,"backpack","Mochila cheia.",5000)
				end
			elseif shops[shopType]["mode"] == "Sell" then
				if shops[shopType]["list"][shopItem] then
					if shops[shopType]["type"] == "Cash" then
						if vRP.tryGetInventoryItem(parseInt(user_id),shopItem,parseInt(shopAmount),true,slot) then	
							vRP.giveInventoryItem(parseInt(user_id),"dollars",parseInt(shops[shopType]["list"][shopItem]*shopAmount),false)
						end
					elseif shops[shopType]["type"] == "Consume" then
						if vRP.tryGetInventoryItem(parseInt(user_id),shopItem,parseInt(shopAmount),true,slot) then

							vRP.giveInventoryItem(parseInt(user_id),shops[shopType]["item"],parseInt(shops[shopType]["list"][shopItem]*shopAmount),false)
						end
					end
				end
			end
		end

		TriggerClientEvent("shops:Update",source,"requestShop")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("shops:populateSlot")
AddEventHandler("shops:populateSlot",function(itemName,slot,target,amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if amount == nil then amount = 1 end
		if amount <= 0 then amount = 1 end

		if vRP.tryGetInventoryItem(user_id,itemName,amount,false,slot) then
			vRP.giveInventoryItem(user_id,itemName,amount,false,target)
			TriggerClientEvent("shops:Update",source,"requestShop")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("shops:updateSlot")
AddEventHandler("shops:updateSlot",function(itemName,slot,target,amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if amount == nil then amount = 1 end
		if amount <= 0 then amount = 1 end

		local inv = vRP.getInventory(user_id)
		if inv then
			if inv[tostring(slot)] and inv[tostring(target)] and inv[tostring(slot)].item == inv[tostring(target)].item then
				if vRP.tryGetInventoryItem(user_id,itemName,amount,false,slot) then
					vRP.giveInventoryItem(user_id,itemName,amount,false,target)
				end
			else
				vRP.swapSlot(user_id,slot,target)
			end
		end

		TriggerClientEvent("shops:Update",source,"requestShop")
	end
end)