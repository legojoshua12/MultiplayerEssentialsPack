-- Buildings
------------------------------	
INSERT INTO Buildings 	
	(Type, BuildingClass, GreatPeopleRateModifier, TradeRouteRecipientBonus, TradeRouteTargetBonus, GreatWorkSlotType, GreatWorkCount, Cost, FreeStartEra, Happiness, NeverCapture, GoldMaintenance, PrereqTech, ArtDefineTag, SpecialistType, SpecialistCount, MinAreaSize, ConquestProb, HurryCostModifier, Help, Description, Civilopedia, Strategy, IconAtlas, PortraitIndex)
SELECT	'BUILDING_3UC_FORUM', BuildingClass, 10, TradeRouteRecipientBonus, TradeRouteTargetBonus, GreatWorkSlotType, GreatWorkCount, Cost, FreeStartEra, Happiness, NeverCapture, GoldMaintenance, PrereqTech, ArtDefineTag, SpecialistType, SpecialistCount, MinAreaSize, ConquestProb, HurryCostModifier,  'TXT_KEY_BUILDING_3UC_FORUM_HELP', 'TXT_KEY_BUILDING_3UC_FORUM', 'TXT_KEY_BUILDING_3UC_FORUM_TEXT', 'TXT_KEY_BUILDING_3UC_FORUM_STRATEGY', 'ICON_ATLAS', 31
FROM Buildings WHERE Type = 'BUILDING_MARKET';	
------------------------------	
-- Building_Flavors
------------------------------		
INSERT INTO Building_Flavors 	
		(BuildingType, 				FlavorType, Flavor)
SELECT	'BUILDING_3UC_FORUM',	FlavorType, Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_MARKET';
------------------------------	
-- Building_ClassesNeededInCity
------------------------------		
INSERT INTO Building_ClassesNeededInCity 	
		(BuildingType, 				BuildingClassType)
SELECT	'BUILDING_3UC_FORUM',	BuildingClassType
FROM Building_ClassesNeededInCity WHERE BuildingType = 'BUILDING_MARKET';
------------------------------	
-- Building_YieldChanges
------------------------------		
INSERT INTO Building_YieldChanges 	
		(BuildingType, 				YieldType, Yield)
SELECT 'BUILDING_3UC_FORUM', YieldType, Yield
FROM Building_YieldChanges WHERE BuildingType = 'BUILDING_MARKET';

------------------------------	
-- Building_ResourceQuantityRequirements
------------------------------
INSERT INTO Building_ResourceQuantityRequirements 	
			(BuildingType, ResourceType, Cost)
SELECT 'BUILDING_3UC_FORUM', ResourceType, Cost
FROM Building_ResourceQuantityRequirements WHERE BuildingType = 'BUILDING_MARKET';

------------------------------	
-- Building_YieldModifiers
------------------------------
INSERT INTO Building_YieldModifiers 	
			(BuildingType, YieldType, Yield)
SELECT 'BUILDING_3UC_FORUM', YieldType, Yield
FROM Building_YieldModifiers WHERE BuildingType = 'BUILDING_MARKET';


--------------------------------	
-- Civilization_BuildingClassOverrides 
--------------------------------		
INSERT INTO Civilization_BuildingClassOverrides 
		(CivilizationType, 					BuildingClassType, 			BuildingType)
VALUES	('CIVILIZATION_ROME',	'BUILDINGCLASS_MARKET',	'BUILDING_3UC_FORUM');


