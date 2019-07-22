------------------------------------------------------------------------------
--	MODDER:   Barathor
--  THANKS:	  whoward69
------------------------------------------------------------------------------
-- MOD: * Prevents Gibraltar from spawning on small islands; especially single-tile ones which may render it unworkable! (special thanks to whoward69 for help)
--		* Prevents Gibraltar from spawning next to ice, which I believe looks really bad.
--		* Adds a land check for the Reef so it doesn't spawn too far out into the sea and become unworkable.
--  	* Adds a requirement that the core tiles of the Reef must initially be water as well so that resources aren't wasted around it and out in the sea.
--		* Adds an ice check for the upper adjacent plots of the Reef so its upper half doesn't become adjacent to ice.
--		* Adds a latitude check for all water-based natural wonders in this function.  Unlike land-based NW's, these are too flexible and need more restrictions.
--		  (With the new latitude check keeping them away from the polar areas, the ice checks aren't really needed anymore, but I kept them in for modders.)
--		* Adds Krakatoa as a custom method so its conditions can be controlled better.  It now only spawns near islands and smaller landmasses.
--
--		* (Still trying to get this to work here in this file.) Fixes a rare bug with the Reef which would cause resources to sometimes be placed on top of its lower half.
------------------------------------------------------------------------------
--	FILE:	  NaturalWondersCustomMethods.lua
--	AUTHOR:   Bob Thomas
--	PURPOSE:  Functions designed to support custom natural wonder placement.
------------------------------------------------------------------------------
--	Copyright (c) 2011 Firaxis Games, Inc. All rights reserved.
------------------------------------------------------------------------------

--[[ -------------------------------------------------------------------------
NOTE: This file is an essential component of the Start Plot System. I have
separated out the functions in this file to permit more convenient operation
for modders wishing to add new natural wonders or modify existing ones. If
you are supplying new custom methods, you will not have to supply an updated
version of AssignStartingPlots with your mod; instead, you only have to supply
an update of this file along with your updated Civ5Features.xml file.

CONTENTS OF THIS FILE:

* NWCustomEligibility(x, y, method_number)
* NWCustomPlacement(x, y, row_number, method_number)
------------------------------------------------------------------------- ]]--

include("MapmakerUtilities");

------------------------------------------------------------------------------
function NWCustomEligibility(x, y, method_number)
	if method_number == 1 then
		-- This method checks a candidate plot for eligibility to be the Great Barrier Reef.
		local iW, iH = Map.GetGridSize();
		-- MOD: going to utilize core tile for some checks now
		local plot = Map.GetPlot(x, y);
		-- MOD: get latitude to prevent it from spawning in polar regions
		-- (MOD: I prefer symmetrical latitudes, and my map script is generated in this way, which is why the check is split in two below.)
		if (y >= (iH/2)) then
			-- upper half of map
			if (math.abs((iH/2) - y)/(iH/2)) > 0.5 then
				return false
			end
		else
			-- lower half of map
			if (math.abs((iH/2) - (y + 1))/(iH/2)) > 0.5 then
				return false
			end
		end
		if plot:IsWater() == false then		-- MOD: added this to check to make sure core tile is water so it doesn't trigger land check later
			return false
		end
		if plot:IsLake() then
			return false
		end
		if plot:IsAdjacentToLand() then		-- MOD: want to make sure the 2nd core tile isn't land either
			return false
		end
		local plotIndex = y * iW + x + 1;
		-- We don't care about the center plot for this wonder. It can be forced. It's the surrounding plots that matter.
		-- This is also the only natural wonder type with a footprint larger than seven tiles.
		-- So first we'll check the extra tiles, make sure they are there, are ocean water, and have no Ice.

		-- MOD: We DO care now, otherwise the adjacent land check may just keep adding the center tile if it's land before it's converted.
		local iNumLand, iNumCoast = 0, 0;	-- MOD: added iNumLand to check for land two tiles from the reef.
		local extra_direction_types = {
			DirectionTypes.DIRECTION_EAST,
			DirectionTypes.DIRECTION_SOUTHEAST,
			DirectionTypes.DIRECTION_SOUTHWEST};
		local SEPlot = Map.PlotDirection(x, y, DirectionTypes.DIRECTION_SOUTHEAST)
		local southeastX = SEPlot:GetX();
		local southeastY = SEPlot:GetY();
		for loop, direction in ipairs(extra_direction_types) do -- The three plots extending another plot past the SE plot.
			local adjPlot = Map.PlotDirection(southeastX, southeastY, direction)
			if adjPlot == nil then
				return false
			end
			if adjPlot:IsWater() == false or adjPlot:IsLake() == true then
				return false
			end
			local featureType = adjPlot:GetFeatureType()
			if featureType ~= FeatureTypes.NO_FEATURE then
				return false
			end
			local terrainType = adjPlot:GetTerrainType()
			if terrainType == TerrainTypes.TERRAIN_COAST then
				iNumCoast = iNumCoast + 1;
			end
			if adjPlot:IsAdjacentToLand() then	-- MOD: added a check for land.
				iNumLand = iNumLand + 1;
			end
		end
		-- Now check the rest of the adjacent plots.
		local direction_types = { -- Not checking to southeast.
			DirectionTypes.DIRECTION_NORTHEAST,
			DirectionTypes.DIRECTION_EAST,
			DirectionTypes.DIRECTION_SOUTHWEST,
			DirectionTypes.DIRECTION_WEST,
			DirectionTypes.DIRECTION_NORTHWEST};
		for loop, direction in ipairs(direction_types) do
			local adjPlot = Map.PlotDirection(x, y, direction)
			if adjPlot:IsWater() == false or adjPlot:IsLake() == true then
				return false
			end
			-- MOD: Why no ice check for the upper half of plots?  Added it so the reef doesn't generate near ice.
			local featureType = adjPlot:GetFeatureType()
			if featureType ~= FeatureTypes.NO_FEATURE then
				return false
			end
			local terrainType = adjPlot:GetTerrainType()
			if terrainType == TerrainTypes.TERRAIN_COAST then
				iNumCoast = iNumCoast + 1;
			end
			if adjPlot:IsAdjacentToLand() then	-- MOD: added a check for land.
				iNumLand = iNumLand + 1;
			end
		end
		-- If not enough coasts, reject this site.
		if iNumCoast < 4 then
			return false
		end
		-- MOD: If not enough land nearby, reject this site.
		-- MOD: I want it tucked more against the land, not just off the tip of a piece of land branching out.
		-- MOD: Also, 3 doesn't necessarily mean three individual land tiles, since half the time they're double counted. It just ensures it's more than one.
		if iNumLand < 3 then
			return false
		end
		-- This site is in the water, with at least some of the water plots being coast, so it's good.
		return true

	elseif method_number == 2 then
		-- This method checks a candidate plot for eligibility to be Rock of Gibraltar.
		local plot = Map.GetPlot(x, y);
		-- Checking center plot, which must be in the water or on the coast.
		local iW, iH = Map.GetGridSize();
		if plot:IsWater() == false and AdjacentToSaltWater(x, y) == false then
			return false
		end
		-- MOD: get latitude to prevent it from spawning in polar regions
		-- (MOD: I prefer symmetrical latitudes, and my map script is generated in this way, which is why the check is split in two below.)
		if (y >= (iH/2)) then
			-- upper half of map
			if (math.abs((iH/2) - y)/(iH/2)) > 0.6 then
				return false
			end
		else
			-- lower half of map
			if (math.abs((iH/2) - (y + 1))/(iH/2)) > 0.6 then
				return false
			end
		end
		-- Now process the surrounding plots.
		local iNumLand, iNumCoast = 0, 0;
		local direction_types = {
			DirectionTypes.DIRECTION_NORTHEAST,
			DirectionTypes.DIRECTION_EAST,
			DirectionTypes.DIRECTION_SOUTHEAST,
			DirectionTypes.DIRECTION_SOUTHWEST,
			DirectionTypes.DIRECTION_WEST,
			DirectionTypes.DIRECTION_NORTHWEST
		};
		for loop, direction in ipairs(direction_types) do
			local adjPlot = Map.PlotDirection(x, y, direction)
			local plotType = adjPlot:GetPlotType();
			local terrainType = adjPlot:GetTerrainType()
			local featureType = adjPlot:GetFeatureType()
			if plotType == PlotTypes.PLOT_OCEAN then
				if featureType ~= FeatureTypes.NO_FEATURE then
					return false	-- MOD: aborts if it finds an adjacent ice plot
				end
			end
			if terrainType == TerrainTypes.TERRAIN_COAST and plot:IsLake() == false then
				if featureType == FeatureTypes.NO_FEATURE then
					iNumCoast = iNumCoast + 1;
				end
			end
			if plotType ~= PlotTypes.PLOT_OCEAN then
				if adjPlot:Area():GetNumTiles() <= iH/2 then
					return false;  -- MOD: Don't permit small landmasses; especially those single-tile islands!
				end
				iNumLand = iNumLand + 1;
			end
		end
		-- If too much land (or none), reject this site.
		if iNumLand ~= 1 then
			return false
		end
		-- If not enough coast, reject this site.
		if iNumCoast < 3 then
			return false
		end
		-- This site is good.
		return true

	elseif method_number == 3 then
		-- MOD: This new method checks a candidate plot for eligibility to be Krakatoa.
		local iW, iH = Map.GetGridSize();
		local plot = Map.GetPlot(x, y);
		-- MOD: get latitude to prevent it from spawning in polar regions
		-- (MOD: I prefer symmetrical latitudes, and my map script is generated in this way, which is why the check is split in two below.)
		if (y >= (iH/2)) then
			-- upper half of map
			if (math.abs((iH/2) - y)/(iH/2)) > 0.5 then
				return false
			end
		else
			-- lower half of map
			if (math.abs((iH/2) - (y + 1))/(iH/2)) > 0.5 then
				return false
			end
		end
		local iNumLand, iNumBigIsland = 0, 0;
		if plot:IsWater() == false then
			return false
		end
		if plot:IsLake() then
			return false
		end
		if plot:IsAdjacentToLand() then
			return false
		end
		-- Now process the surrounding plots.
		local direction_types = {
			DirectionTypes.DIRECTION_NORTHEAST,
			DirectionTypes.DIRECTION_EAST,
			DirectionTypes.DIRECTION_SOUTHEAST,
			DirectionTypes.DIRECTION_SOUTHWEST,
			DirectionTypes.DIRECTION_WEST,
			DirectionTypes.DIRECTION_NORTHWEST
		};
		for loop, direction in ipairs(direction_types) do
			local adjPlot = Map.PlotDirection(x, y, direction)
			local adjX = adjPlot:GetX();
			local adjY = adjPlot:GetY();
			local featureType = adjPlot:GetFeatureType()
			if featureType ~= FeatureTypes.NO_FEATURE then
				return false
			end
			local extra_direction_types = {
				DirectionTypes.DIRECTION_NORTHEAST,
				DirectionTypes.DIRECTION_EAST,
				DirectionTypes.DIRECTION_SOUTHEAST,
				DirectionTypes.DIRECTION_SOUTHWEST,
				DirectionTypes.DIRECTION_WEST,
				DirectionTypes.DIRECTION_NORTHWEST
			};
			for extraloop, extradirection in ipairs(extra_direction_types) do
				local extraPlot = Map.PlotDirection(adjX, adjY, extradirection)
				if extraPlot == nil then
					return false
				end
				local plotType = extraPlot:GetPlotType();
				if plotType ~= PlotTypes.PLOT_OCEAN then
					if extraPlot:Area():GetNumTiles() > iH/2 then
						-- MOD: Don't permit on larger landmasses
						return false;
					end
					if extraPlot:Area():GetNumTiles() > 2 then
						-- MOD: Want it near at least one slightly larger island, not just single-tile islands.
						iNumBigIsland = iNumBigIsland + 1
					end
					iNumLand = iNumLand + 1
				end
			end
		end
		-- MOD: Want it tucked more near the land, not just off the tip of a piece of land branching out.
		-- MOD: Also, 3 doesn't necessarily mean three individual land tiles, since half the time they're double counted. It just ensures it's more than one.
		if iNumLand < 3 then
			-- Not enough land nearby.
			return false
		end
		if iNumBigIsland < 1 then
			-- Not enough larger islands nearby.
			return false
		end
		-- This site is good.
		return true

	else -- Unidentified Method Number
		return false
	end
end
------------------------------------------------------------------------------
function NWCustomPlacement(x, y, row_number, method_number)
	local iW, iH = Map.GetGridSize();
	if method_number == 1 then
		-- This method handles tile changes for the Great Barrier Reef.
		local plot = Map.GetPlot(x, y);
		if not plot:IsWater() then
			plot:SetPlotType(PlotTypes.PLOT_OCEAN, false, false);
		end
		if plot:GetTerrainType() ~= TerrainTypes.TERRAIN_COAST then
			plot:SetTerrainType(TerrainTypes.TERRAIN_COAST, false, false)
		end
		-- The Reef has a longer shape and demands unique handling. Process the extra plots.
		local extra_direction_types = {
			DirectionTypes.DIRECTION_EAST,
			DirectionTypes.DIRECTION_SOUTHEAST,
			DirectionTypes.DIRECTION_SOUTHWEST};
		local SEPlot = Map.PlotDirection(x, y, DirectionTypes.DIRECTION_SOUTHEAST)
		if not SEPlot:IsWater() then
			SEPlot:SetPlotType(PlotTypes.PLOT_OCEAN, false, false);
		end
		if SEPlot:GetTerrainType() ~= TerrainTypes.TERRAIN_COAST then
			SEPlot:SetTerrainType(TerrainTypes.TERRAIN_COAST, false, false)
		end
		if SEPlot:GetFeatureType() ~= FeatureTypes.NO_FEATURE then
			SEPlot:SetFeatureType(FeatureTypes.NO_FEATURE, -1)
		end
		local southeastX = SEPlot:GetX();
		local southeastY = SEPlot:GetY();
		for loop, direction in ipairs(extra_direction_types) do -- The three plots extending another plot past the SE plot.
			local adjPlot = Map.PlotDirection(southeastX, southeastY, direction)
			if adjPlot:GetTerrainType() ~= TerrainTypes.TERRAIN_COAST then
				adjPlot:SetTerrainType(TerrainTypes.TERRAIN_COAST, false, false)
			end
			local adjX = adjPlot:GetX();
			local adjY = adjPlot:GetY();
			local adjPlotIndex = adjY * iW + adjX + 1;
		end
		-- Now check the rest of the adjacent plots.
		local direction_types = { -- Not checking to southeast.
			DirectionTypes.DIRECTION_NORTHEAST,
			DirectionTypes.DIRECTION_EAST,
			DirectionTypes.DIRECTION_SOUTHWEST,
			DirectionTypes.DIRECTION_WEST,
			DirectionTypes.DIRECTION_NORTHWEST
			};
		for loop, direction in ipairs(direction_types) do
			local adjPlot = Map.PlotDirection(x, y, direction)
			if adjPlot:GetTerrainType() ~= TerrainTypes.TERRAIN_COAST then
				adjPlot:SetTerrainType(TerrainTypes.TERRAIN_COAST, false, false)
			end
		end
		-- Now place the Reef's second wonder plot. (The core method will place the main plot).
		local feature_type_to_place;
		for thisFeature in GameInfo.Features() do
			if thisFeature.Type == "FEATURE_REEF" then
				feature_type_to_place = thisFeature.ID;
				break
			end
		end
		SEPlot:SetFeatureType(feature_type_to_place);
		-- MOD: This second plot of the Reef was missing impact values. This would cause resources to spawn on top of it sometimes.
		--[[ MOD: I don't know how to get this to work yet within this file.  I can fix it in the main AssignStartingPlots file, but I don't want to include the whole thing in this mod.
		AssignStartingPlots:PlaceResourceImpact(southeastX, southeastY, 1, 1)		-- Strategic layer
		AssignStartingPlots:PlaceResourceImpact(southeastX, southeastY, 2, 1)		-- Luxury layer
		AssignStartingPlots:PlaceResourceImpact(southeastX, southeastY, 3, 1)		-- Bonus layer
		]]--

	elseif method_number == 2 then
		-- This method handles tile changes for the Rock of Gibraltar.
		local plot = Map.GetPlot(x, y);
		plot:SetPlotType(PlotTypes.PLOT_LAND, false, false);
		plot:SetTerrainType(TerrainTypes.TERRAIN_GRASS, false, false)
		local direction_types = {
			DirectionTypes.DIRECTION_NORTHEAST,
			DirectionTypes.DIRECTION_EAST,
			DirectionTypes.DIRECTION_SOUTHEAST,
			DirectionTypes.DIRECTION_SOUTHWEST,
			DirectionTypes.DIRECTION_WEST,
			DirectionTypes.DIRECTION_NORTHWEST};
		for loop, direction in ipairs(direction_types) do
			local adjPlot = Map.PlotDirection(x, y, direction)
			if adjPlot:GetPlotType() == PlotTypes.PLOT_OCEAN then
				if adjPlot:GetTerrainType() ~= TerrainTypes.TERRAIN_COAST then
					adjPlot:SetTerrainType(TerrainTypes.TERRAIN_COAST, false, false)
				end
			else
				if adjPlot:GetPlotType() ~= PlotTypes.PLOT_MOUNTAIN then
					adjPlot:SetPlotType(PlotTypes.PLOT_MOUNTAIN, false, false);
				end
			end
		end

	elseif method_number == 3 then
		-- This method handles tile changes for Krakatoa.
		local plot = Map.GetPlot(x, y);
		plot:SetPlotType(PlotTypes.PLOT_MOUNTAIN, false, false);
		plot:SetTerrainType(TerrainTypes.TERRAIN_GRASS, false, false)
		local direction_types = {
			DirectionTypes.DIRECTION_NORTHEAST,
			DirectionTypes.DIRECTION_EAST,
			DirectionTypes.DIRECTION_SOUTHEAST,
			DirectionTypes.DIRECTION_SOUTHWEST,
			DirectionTypes.DIRECTION_WEST,
			DirectionTypes.DIRECTION_NORTHWEST};
		for loop, direction in ipairs(direction_types) do
			local adjPlot = Map.PlotDirection(x, y, direction)
			if adjPlot:GetPlotType() == PlotTypes.PLOT_OCEAN then
				if adjPlot:GetTerrainType() ~= TerrainTypes.TERRAIN_COAST then
					adjPlot:SetTerrainType(TerrainTypes.TERRAIN_COAST, false, false)
				end
			end
		end
	end
end
------------------------------------------------------------------------------
