-- Buildings
------------------------------	
INSERT INTO Buildings 	
	(Type, BuildingClass, TradeRouteLandGoldBonus, TradeRouteSeaGoldBonus,  NukeImmune,  NumCityCostMod, TradeRouteRecipientBonus, TradeRouteTargetBonus, GreatWorkSlotType, GreatWorkCount, Cost, FreeStartEra, Happiness, NeverCapture, GoldMaintenance, PrereqTech, ArtDefineTag, SpecialistType, SpecialistCount, MinAreaSize, ConquestProb, HurryCostModifier, Help, Description, Civilopedia, Strategy, IconAtlas, PortraitIndex)
SELECT	'BUILDING_3UC_INTERNATIONAL_TRADEHOUSE', BuildingClass, 100, 100,  NukeImmune, NumCityCostMod, 4, 2, GreatWorkSlotType, GreatWorkCount, Cost, FreeStartEra, Happiness, NeverCapture, GoldMaintenance, PrereqTech, ArtDefineTag, SpecialistType, SpecialistCount, MinAreaSize, ConquestProb, HurryCostModifier,  'TXT_KEY_BUILDING_3UC_INTERNATIONAL_TRADEHOUSE_HELP', 'TXT_KEY_BUILDING_3UC_INTERNATIONAL_TRADEHOUSE', 'TXT_KEY_BUILDING_3UC_INTERNATIONAL_TRADEHOUSE_TEXT', 'TXT_KEY_BUILDING_3UC_INTERNATIONAL_TRADEHOUSE_STRATEGY', 'ICON_ATLAS', 30
FROM Buildings WHERE Type = 'BUILDING_NATIONAL_TREASURY';	
------------------------------	
-- Building_Flavors
------------------------------		
INSERT INTO Building_Flavors 	
		(BuildingType, 				FlavorType, Flavor)
SELECT	'BUILDING_3UC_INTERNATIONAL_TRADEHOUSE',	FlavorType, Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_NATIONAL_TREASURY';

------------------------------	
-- Building_PrereqBuildingClasses
------------------------------		
INSERT INTO Building_PrereqBuildingClasses 	
		(BuildingType, 				BuildingClassType, NumBuildingNeeded)
SELECT	'BUILDING_3UC_INTERNATIONAL_TRADEHOUSE',	BuildingClassType, NumBuildingNeeded
FROM Building_PrereqBuildingClasses WHERE BuildingType = 'BUILDING_NATIONAL_TREASURY';

------------------------------	
-- Building_ClassesNeededInCity
------------------------------		
INSERT INTO Building_ClassesNeededInCity 	
		(BuildingType, 				BuildingClassType)
SELECT	'BUILDING_3UC_INTERNATIONAL_TRADEHOUSE',	BuildingClassType
FROM Building_ClassesNeededInCity WHERE BuildingType = 'BUILDING_NATIONAL_TREASURY';
------------------------------	
-- Building_YieldChanges
------------------------------		
INSERT INTO Building_YieldChanges 	
		(BuildingType, 				YieldType, Yield)
VALUES	('BUILDING_3UC_INTERNATIONAL_TRADEHOUSE',	'YIELD_GOLD', 8);

------------------------------	
-- Building_ResourceQuantityRequirements
------------------------------
INSERT INTO Building_ResourceQuantityRequirements 	
			(BuildingType, ResourceType, Cost)
SELECT 'BUILDING_3UC_INTERNATIONAL_TRADEHOUSE', ResourceType, Cost
FROM Building_ResourceQuantityRequirements WHERE BuildingType = 'BUILDING_NATIONAL_TREASURY';

------------------------------	
-- Building_YieldModifiers
------------------------------
INSERT INTO Building_YieldModifiers 	
			(BuildingType, YieldType, Yield)
SELECT 'BUILDING_3UC_INTERNATIONAL_TRADEHOUSE', YieldType, Yield
FROM Building_YieldModifiers WHERE BuildingType = 'BUILDING_NATIONAL_TREASURY';


--------------------------------	
-- Civilization_BuildingClassOverrides 
--------------------------------		
INSERT INTO Civilization_BuildingClassOverrides 
		(CivilizationType, 					BuildingClassType, 			BuildingType)
VALUES	('CIVILIZATION_PORTUGAL',	'BUILDINGCLASS_NATIONAL_TREASURY',	'BUILDING_3UC_INTERNATIONAL_TRADEHOUSE');


