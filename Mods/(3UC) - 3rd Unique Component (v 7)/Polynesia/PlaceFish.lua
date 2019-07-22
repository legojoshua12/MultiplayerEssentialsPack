-- Place Bison -- Author: Neirai -- DateCreated: 5/12/2014 9:35:31 AM

function buildAFish(pPlayer, pCity)
	for pCityPlot = 1, pCity:GetNumCityPlots() - 1, 1 do
		local pSpecificPlot = pCity:GetCityIndexPlot(pCityPlot)
		if
			pSpecificPlot:GetTerrainType() == TerrainTypes.TERRAIN_COAST then
			if pSpecificPlot:GetFeatureType() == (-1) and not pSpecificPlot:IsMountain() then
				if pSpecificPlot:GetResourceType(-1) == (-1) then
					pSpecificPlot:SetResourceType(GameInfoTypes.RESOURCE_FISH, 1)
					print("Fish Placed on Coast")
					return true
				end
			end
		end
	end
	return false
end
	
function PutFishSomewhere(player, city, building)
	print(building)
	print(GameInfoTypes.BUILDING_3UC_FISH_POND)
	if building == GameInfoTypes.BUILDING_3UC_FISH_POND then
		local pPlayer = Players[player]
			local pCity = pPlayer:GetCityByID(city)
			if buildAFish(pPlayer, pCity) == false then
				print("No place to place a Fish.")
		end
	end
end
GameEvents.CityConstructed.Add(PutFishSomewhere)
