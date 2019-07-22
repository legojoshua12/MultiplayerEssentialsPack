-- Reforestation
-- Author: FramedArchitecture
-- DateCreated: 11/9/2012
--------------------------------------------------------------------
local bExpansion2		= ContentManager.IsActive("6DA07636-4123-4018-B643-6575B4EC336B", ContentType.GAMEPLAY)
local plantForestID		= GameInfoTypes["IMPROVEMENT_PLANT_FOREST_3UC"]
local forestTechInfo	= GameInfo.Technologies["TECH_AGRICULTURE"]
local random			= math.random
local resources			= {}
--------------------------------------------------------------------
function OnUpdateForests(playerID, x, y, improvementID)
	if (improvementID ~= plantForestID) then return end
	PlantForest(Map.GetPlot(x, y))
end
--------------------------------------------------------------------
function OnMapUpdateForests()
	local n = Map.GetNumPlots() - 1
	for i = 0, n do
		local plot = Map.GetPlotByIndex(i);
		if (plot:GetImprovementType() == plantForestID) then
			PlantForest(plot)
		end
	end
end
--------------------------------------------------------------------
function OnTechResearched(teamID, techID)
	if forestTechInfo and (techID == forestTechInfo.ID) then
		Events.ActivePlayerTurnStart.Add(OnMapUpdateForests)
		GameEvents.TeamTechResearched.Remove(OnTechResearched)
	end
end
--------------------------------------------------------------------
function PlantForest(plot)
	plot:SetImprovementType(-1);
	plot:SetFeatureType(FeatureTypes.FEATURE_FOREST, -1);
	if (random(1, 100) < 4) then
		local resourceInfo = GameInfo.Resources[resources[random(#resources)]]
		if resourceInfo then
			plot:SetResourceType(resourceInfo.ID, 1);
		end
	end
end
--------------------------------------------------------------------
function Initialize()
	if bExpansion2 then
		GameEvents.BuildFinished.Add(OnUpdateForests)
	else
		local bInitialized = false
		if forestTechInfo then
			for i = 0, GameDefines.MAX_CIV_PLAYERS-1, 1 do
				if Teams[Players[i]:GetTeam()]:IsHasTech(forestTechInfo.ID) then	
					bInitialized = true
					break;
				end
			end
		end
		if bInitialized then
			Events.ActivePlayerTurnStart.Add(OnMapUpdateForests)
		else
			GameEvents.TeamTechResearched.Add(OnTechResearched)
		end
	end

	for row in GameInfo.Resource_FeatureBooleans( "FeatureType = 'FEATURE_FOREST'" ) do
		table.insert(resources, row.ResourceType)
	end

	print("-- Reforestation Mod Loaded --")
end
--------------------------------------------------------------------
Initialize();