-- EDSupport
-- Author: calcul8or, based on code "borrowed" from CL Zapotecs
-- DateCreated: 4/19/2015 12:15:27 PM
--------------------------------------------------------------

--=============================================================
-- Civ Specific Decisions
--=============================================================
--Oregon Civil War - Must be at war, Cost 250 Gold, Get 4 Horses and Cavalry Units
--=============================================================
print("EDSupport has loaded")
local Decisions_ORCivilWar = {}
	Decisions_ORCivilWar.Name = "TXT_KEY_DECISIONS_OREGON_ORCIVILWAR_NAME"
	Decisions_ORCivilWar.Desc = "TXT_KEY_DECISIONS_OREGON_ORCIVILWAR_DESC"
	HookDecisionCivilizationIcon(Decisions_ORCivilWar, "CIVILIZATION_OREGON")

Decisions_ORCivilWar.CanFunc = ( 
	function(pPlayer)
		print("OR Civil War line 19")
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_OREGON) then return false, false end
		if load(pPlayer, "Decisions_ORCivilWar") == true then
			Decisions_ORCivilWar.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_OREGON_ORCIVILWAR_ADOPTED")
			return false, false, true
		end		
		Decisions_ORCivilWar.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_OREGON_ORCIVILWAR_DESC")
		
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1) then return true, false end
		if not Teams[pPlayer:GetTeam()]:IsHasTech(GameInfoTypes.TECH_MILITARY_SCIENCE) then return true, false end
		if pPlayer:GetGold() < 250 then return true, false end
		--if pPlayer:GetFaith() < 50 then return true, false end
		if (pPlayer:GetCapitalCity() == nil) then return true, false end
		if (Teams[pPlayer:GetTeam()]:GetAtWarCount() <= 0) then return true, false end
		return true, true
	end
	)
	
	Decisions_ORCivilWar.DoFunc = ( --Payment Block
	function(pPlayer)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -1)
		pPlayer:ChangeGold(-250)
		--pPlayer:ChangeFaith(-50)

		save(pPlayer, "Decisions_ORCivilWar", true)
		Initialize_Decisions_ORCivilWar()
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes["CIVILIZATION_OREGON"], "Decisions_ORCivilWar", Decisions_ORCivilWar)

function Initialize_Decisions_ORCivilWar()
	local n = GameDefines.MAX_MAJOR_CIVS - 1
	for playerID = 0, n, 1 do
		local pPlayer = Players[playerID]
		if pPlayer and load(pPlayer, "Decisions_ORCivilWar") then
			oregonID = playerID
			oregonTeamID = pPlayer:GetTeam()
		    break
		end
	end

	if (oregonID ~= -1) then
		print("OR Civil War enacted line 62ish")
		local dPlayer = Players[oregonID]
		local CapCity = dPlayer:GetCapitalCity()
		local PlotX = CapCity:GetX()
		local PlotY = CapCity:GetY()
		dPlayer:GetCapitalCity():SetNumRealBuilding(GameInfoTypes['BUILDING_DECISIONS_ORCIVILWAR'], 1)
		dPlayer:InitUnit(GameInfoTypes["UNIT_CAVALRY"], PlotX, PlotY):JumpToNearestValidPlot()
		dPlayer:InitUnit(GameInfoTypes["UNIT_CAVALRY"], PlotX, PlotY):JumpToNearestValidPlot()
		--dPlayer:InitUnit(GameInfoTypes["UNIT_CAVALRY"], PlotX, PlotY):JumpToNearestValidPlot()
		--dPlayer:InitUnit(GameInfoTypes["UNIT_CAVALRY"], PlotX, PlotY):JumpToNearestValidPlot()
	end
end

--===================================================================
--OR Ecology
--===================================================================

local Decisions_OREnactEcology = {}
	Decisions_OREnactEcology.Name = "TXT_KEY_DECISIONS_OREGON_ORENACTECOLOGY_NAME"
	Decisions_OREnactEcology.Desc = "TXT_KEY_DECISIONS_OREGON_ORENACTECOLOGY_DESC"
	HookDecisionCivilizationIcon(Decisions_OREnactEcology, "CIVILIZATION_OREGON")

Decisions_OREnactEcology.CanFunc = ( 
	function(pPlayer)
		print("OR Ecology")
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_OREGON) then return false, false end
		if load(pPlayer, "Decisions_OREnactEcology") == true then
			Decisions_OREnactEcology.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_OREGON_ORENACTECOLOGY_ADOPTED")
			return false, false, true
		end		
		Decisions_OREnactEcology.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_OREGON_ORENACTECOLOGY_DESC")
		
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1) then return true, false end
		if not Teams[pPlayer:GetTeam()]:IsHasTech(GameInfoTypes.TECH_ECOLOGY) then return true, false end
		if pPlayer:GetGold() < 300 then return true, false end
		--if pPlayer:GetFaith() < 50 then return true, false end
		if (pPlayer:GetCapitalCity() == nil) then return true, false end
		--if (Teams[pPlayer:GetTeam()]:GetAtWarCount() <= 0) then return true, false end
		return true, true
	end
	)
	
	Decisions_OREnactEcology.DoFunc = ( --Payment Block
	function(pPlayer)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -1)
		pPlayer:ChangeGold(-300)
		--pPlayer:ChangeFaith(-50)

		save(pPlayer, "Decisions_OREnactEcology", true)
		Initialize_Decisions_OREnactEcology()
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes["CIVILIZATION_OREGON"], "Decisions_OREnactEcology", Decisions_OREnactEcology)

function Initialize_Decisions_OREnactEcology()
	local n = GameDefines.MAX_MAJOR_CIVS - 1
	for playerID = 0, n, 1 do
		local pPlayer = Players[playerID]
		if pPlayer and load(pPlayer, "Decisions_OREnactEcology") then
			oregonID = playerID
			oregonTeamID = pPlayer:GetTeam()
		    break
		end
	end

	if (oregonID ~= -1) then
		--local CapCity = pPlayer:GetCapitalCity()
		print("Enacted OR Ecology. oregonID is " .. oregonID)
		local ORPlayer = Players[oregonID]
		if not ORPlayer:HasPolicy(GameInfoTypes["POLICY_ORECOLOGY"]) then
				print("Setting dummy policy")
				ORPlayer:SetNumFreePolicies(1)
				ORPlayer:SetNumFreePolicies(0)
				ORPlayer:SetHasPolicy(GameInfoTypes["POLICY_ORECOLOGY"], true)	
		end
	end
end