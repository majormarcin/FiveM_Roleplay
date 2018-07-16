local time = 8

Citizen.CreateThread(function()
	TriggerServerEvent('es_rp:spawnPlayer')
end)
RegisterNetEvent('es_rp:playerLoaded')
AddEventHandler('es_rp:playerLoaded', function()
	NetworkSetTalkerProximity(30.0)
	
	exports.spawnmanager:setAutoSpawn(true)
	exports.spawnmanager:forceRespawn()

	exports.spawnmanager:setAutoSpawnCallback(function()
		TriggerServerEvent('es_rp:spawnPlayer')
	end)

	RequestIpl("post_hiest_unload")
	RequestIpl("facelobby")
	RequestIpl("FIBlobby")
	RequestIpl("FIBlobby")
	RequestIpl("farm")
	RequestIpl("farm_props")
	RequestIpl("farmint")
	RequestIpl("v_carshowroom")
	RequestIpl("shutter_open")
	RequestIpl("shr_int")
	RequestIpl("csr_inMission")
	RemoveIpl("farmint_cap")
	RemoveIpl("fakeint")
	RemoveIpl("shutter_closed")
	LoadMpDlcMaps()
	UseFreemodeMapBehavior(true)
	RequestIpl("FIBlobbyfake")
	RequestIpl("DT1_03_Gr_Closed")
	RequestIpl("v_tunnel_hole")
	RequestIpl("TrevorsMP")
	RequestIpl("TrevorsTrailer")
	RequestIpl("farm")
	RequestIpl("farmint")
	RequestIpl("farmint_cap")
	RequestIpl("farm_props")
	RequestIpl("CS1_02_cf_offmission")
	RequestIpl("hei_carrier")
	RequestIpl("hei_carrier_DistantLights")
	RequestIpl("hei_Carrier_int1")
	RequestIpl("hei_Carrier_int2")
	RequestIpl("hei_Carrier_int3")
	RequestIpl("hei_Carrier_int4")
	RequestIpl("hei_Carrier_int5")
	RequestIpl("hei_Carrier_int6")
	RequestIpl("hei_carrier_LODLights")
	RequestIpl("hei_yacht_heist")
	RequestIpl("hei_yacht_heist_Bar")
	RequestIpl("hei_yacht_heist_Bedrm")
	RequestIpl("hei_yacht_heist_Bridge")
	RequestIpl("hei_yacht_heist_DistantLights")
	RequestIpl("hei_yacht_heist_enginrm")
	RequestIpl("hei_yacht_heist_LODLights")
	RequestIpl("hei_yacht_heist_Lounge")
	RequestIpl("v_bahama")
	RequestIpl("v_rockclub")
	RemoveIpl("sp1_10_fake_interior")
  	RemoveIpl("sp1_10_fake_interior_lod")
  	RequestIpl("sp1_10_real_interior")
  	RequestIpl("sp1_10_real_interior_lod")

	local interior = GetInteriorAtCoords(-30.8793, -1088.336, 25.4221)

	DisableInterior(interior, false)
	LoadInterior(interior)
end)


RegisterNetEvent('es_rp:setTime')
AddEventHandler('es_rp:setTime', function(t)
	time = t
end)

Citizen.CreateThread(function()
	while true do
		NetworkOverrideClockTime(time, 0, 0)		
		Citizen.Wait(10000)
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(0)
		
		SetPedDensityMultiplierThisFrame(0.6)
		SetVehicleDensityMultiplierThisFrame(0.5)
	end
end)

AddEventHandler("es_rp:teleportUser", function(s, x, y, z)
	Citizen.CreateThread(function()
		if(s == 0)then
			RequestCollisionAtCoord(x, y, z)
			SetEntityCoords(GetPlayerPed(-1), x, y, z)

			while not HasCollisionLoadedAroundEntity(GetPlayerPed(-1)) do
				FreezeEntityPosition(GetPlayerPed(-1), true)
				Citizen.Wait(0)
			end
			FreezeEntityPosition(GetPlayerPed(-1), false)
		elseif(s == 1)then
			for i = 0, 20 do
	            RequestNamedPtfxAsset("scr_rcbarry1")
	            UseParticleFxAssetNextCall("scr_rcbarry1")
				StartParticleFxLoopedOnEntity("scr_alien_teleport", GetPlayerPed(-1), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0)
				SetEntityAlpha(GetPlayerPed(-1), math.ceil(255 - (12.75*i)))
				Citizen.Wait(70)
			end

			SetEntityCoords(GetPlayerPed(-1), x, y, z)

			while not HasCollisionLoadedAroundEntity(GetPlayerPed(-1)) do
				FreezeEntityPosition(GetPlayerPed(-1), true)
				Citizen.Wait(0)
			end
			FreezeEntityPosition(GetPlayerPed(-1), false)

			for i = 0, 20 do
	            RequestNamedPtfxAsset("scr_rcbarry1")
	            UseParticleFxAssetNextCall("scr_rcbarry1")
				StartParticleFxLoopedOnEntity("scr_alien_teleport", GetPlayerPed(-1), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0)
				SetEntityAlpha(GetPlayerPed(-1), math.ceil(0 + (12.75*i)))
				Citizen.Wait(70)
			end
		end

		return
	end)
end)

RegisterNetEvent('es_rp:spawn')
AddEventHandler('es_rp:spawn', function(model, x, y, z, heading, weapons, health, armour)
	exports.spawnmanager:spawnPlayer({x = x, y = y, z = z, model = model, heading = heading}, function()
		SetEntityHealth(GetPlayerPed(-1), health)
		SetPedArmour(GetPlayerPed(-1), armour)

		for i in ipairs(weapons) do
			GiveWeaponToPed(GetPlayerPed(-1), GetHashKey(weapons[i]), 1000, false, false)
		end
	end)
end)