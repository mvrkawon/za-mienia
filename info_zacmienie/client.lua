Config = {

	VehicleBlacklistEnabled = false,
	VehicleBlacklist = {
		["APC"] = true,
		["BARRACKS"] = true,
		["BARRACKS2"] = true,
		["BARRACKS3"] = true,
		["CRUSADER"] = true,
		["HALFTRACK"] = true,
		["RHINO"] = true,
		["KHANJALI"] = true,
		["TRAILERSMALL2"] = true,
		["INSURGENT"] = true,
		["INSURGENT2"] = true,

		["VALKYRIE"] = true,
		["VALKYRIE2"] = true,
		["SWIFT"] = true,
		["SWIFT2"] = true,
		["SUPERVOLITO"] = true,
		["SUPERVOLITO2"] = true,
		["SKYLIFT"] = true,
		["SAVAGE"] = true,
		["MAVERICK"] = false,
		["FROGGER"] = true,
		["FROGGER2"] = true,
		["CARGOBOB"] = true,
		["CARGOBOB2"] = true,
		["CARGOBOB3"] = true,
		["CARGOBOB4"] = true,
		["BUZZARD"] = false,
		["BUZZARD2"] = true,
		["ANNIHILATOR"] = true,

		["DUNE2"] = true,
		["DUMP"] = true,
		["CUTTER"] = true,

		["HYDRA"] = true,
		["LAZER"] = true,
	},
}

ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

if Config.VehicleBlacklistEnabled then
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(0)

			local playerPed = GetPlayerPed(-1)
			if Config.VehicleBlacklistEnabled then
				local vehicle = GetVehiclePedIsIn(playerPed, false)
				if vehicle and Config.VehicleBlacklist[GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))] then
					ESX.Game.DeleteVehicle(vehicle)
				end

				local x, y, z = table.unpack(GetEntityCoords(playerPed, true))
				for model, _ in pairs(Config.VehicleBlacklist) do
					vehicle = GetClosestVehicle(x, y, z, 100.0, GetHashKey(model), 70)
					if vehicle then
						ESX.Game.DeleteVehicle(vehicle)
					end
				end
			end
		end
	end)
end

RegisterNetEvent('ps:zacmienie')
AddEventHandler('ps:zacmienie', function(left)
	Citizen.CreateThread(function()
		local scaleform = RequestScaleformMovie("breaking_news")
		while not HasScaleformMovieLoaded(scaleform) do
			Citizen.Wait(0)
		end
	SetWeatherTypePersist("Halloween")
       	SetWeatherTypeNowPersist("Halloween")
       	SetWeatherTypeNow("Halloween")
       	SetOverrideWeather("Halloween")
	SetClockTime(0, 00, 00)
		PushScaleformMovieFunction(scaleform, "SET_TEXT")
		PushScaleformMovieFunctionParameterString("UWAGA: Zaćmienie wyspy za " .. left .. " minut" .. (left == 1 and "ę" or (left < 5 and "y" or "")) .. "!")
		PushScaleformMovieFunctionParameterString("Prosimy brac <b>bilet</b> powrotny!")
		PopScaleformMovieFunctionVoid()

		PushScaleformMovieFunction(scaleform, "SET_SCROLL_TEXT")
		PushScaleformMovieFunctionParameterInt(0)
		PushScaleformMovieFunctionParameterInt(0)
		PushScaleformMovieFunctionParameterString("WAZNA WIADOMOSC!")
		PopScaleformMovieFunctionVoid()

		PushScaleformMovieFunction(scaleform, "DISPLAY_SCROLL_TEXT")
		PushScaleformMovieFunctionParameterInt(0)
		PushScaleformMovieFunctionParameterInt(0)
		PopScaleformMovieFunctionVoid()

		local passed = GetGameTimer() + 15000
		while passed > GetGameTimer() do
			Citizen.Wait(1)
			DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
		end
	end)
end)