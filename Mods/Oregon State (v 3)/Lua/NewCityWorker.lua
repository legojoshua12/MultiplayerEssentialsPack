-- NewCityWorker
-- Author: calcul8or
-- DateCreated: 3/29/2015 1:51:36 PM
--------------------------------------------------------------
function CityBonus(playerID, cityX, cityY)
	local pPlayer = Players[playerID]
	if (pPlayer:IsAlive() and pPlayer:GetCivilizationType() == GameInfoTypes["CIVILIZATION_OREGON"]) then
		print("Found OR, gonna check the distance")
		local CapCity = pPlayer:GetCapitalCity()
		local plotDistance = Map.PlotDistance(CapCity:GetX(), CapCity:GetY(), cityX, cityY)
		if plotDistance >= 7 then
			pPlayer:InitUnit(GameInfoTypes["UNIT_WORKER"], cityX, cityY):JumpToNearestValidPlot()
		end
	end
end

GameEvents.PlayerCityFounded.Add(CityBonus)

--==============================================================================================================
--Settler Damage
--==============================================================================================================
--function SettlerAttrition(iPlayer, iUnit, iX, iY)
--function SettlerAttrition(iPlayer)
--	local pPlayer = Players[iPlayer];
--	if (pPlayer:IsAlive() and pPlayer:GetCivilizationType() == GameInfoTypes["CIVILIZATION_JEDITIMELORD"]) then
--		print("Found a JT unit");
		--local MovingUnit = pPlayer:GetUnitByID(iUnit);
		--Add check for other settler types
		--Add chek if in own territory
--		for unit in pPlayer:Units() do
--			if (unit:GetUnitType() == GameInfoTypes["UNIT_ORSETTLER"] or unit:GetUnitType() == GameInfoTypes["UNIT_ORSETTLER_MED"] or unit:GetUnitType() == GameInfoTypes["UNIT_ORSETTLER_IND"]) then
--				print("The unit is a settler");
--				local iRandom = math.random(100)
				--local pPlot = MovingUnit:GetPlot();
--				print("Random number is " .. iRandom);
--				if (iRandom <= 20) then
--					print("Setting Settler damage")
--					unit:ChangeDamage(10, iPlayer)
--				end
--			end
--		end
--	end
--end

--GameEvents.PlayerDoTurn.Add(SettlerAttrition)

--GameEvents.UnitSetXY.Add(SettlerAttrition)
