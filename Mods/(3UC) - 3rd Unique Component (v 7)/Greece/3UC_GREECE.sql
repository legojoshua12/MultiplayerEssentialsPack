-- Buildings
------------------------------	
INSERT INTO Buildings 	
	(Type, BuildingClass, TradeRouteRecipientBonus, TradeRouteTargetBonus, GreatWorkSlotType, GreatWorkCount, Cost, FreeStartEra, Happiness, NeverCapture, GoldMaintenance, PrereqTech, ArtDefineTag, SpecialistType, SpecialistCount, MinAreaSize, ConquestProb, HurryCostModifier, Help, Description, Civilopedia, Strategy, IconAtlas, PortraitIndex)
SELECT	'BUILDING_3UC_AGORA', BuildingClass, 2, 2, GreatWorkSlotType, GreatWorkCount, Cost, FreeStartEra, Happiness, NeverCapture, GoldMaintenance, PrereqTech, ArtDefineTag, SpecialistType, SpecialistCount, MinAreaSize, ConquestProb, HurryCostModifier,  'TXT_KEY_BUILDING_3UC_AGORA_HELP', 'TXT_KEY_BUILDING_3UC_AGORA', 'TXT_KEY_BUILDING_3UC_AGORA_TEXT', 'TXT_KEY_BUILDING_3UC_AGORA_STRATEGY', 'AGORA_ICON_ATLAS', 0
FROM Buildings WHERE Type = 'BUILDING_MARKET';	
------------------------------	
-- Building_Flavors
------------------------------		
INSERT INTO Building_Flavors 	
		(BuildingType, 				FlavorType, Flavor)
SELECT	'BUILDING_3UC_AGORA',	FlavorType, Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_MARKET';
------------------------------	
-- Building_ClassesNeededInCity
------------------------------		
INSERT INTO Building_ClassesNeededInCity 	
		(BuildingType, 				BuildingClassType)
SELECT	'BUILDING_3UC_AGORA',	BuildingClassType
FROM Building_ClassesNeededInCity WHERE BuildingType = 'BUILDING_MARKET';
------------------------------	
-- Building_YieldChanges
------------------------------		
INSERT INTO Building_YieldChanges 	
		(BuildingType, 				YieldType, Yield)
VALUES ('BUILDING_3UC_AGORA', 'YIELD_GOLD', 2);

------------------------------	
-- Building_ResourceQuantityRequirements
------------------------------
INSERT INTO Building_ResourceQuantityRequirements 	
			(BuildingType, ResourceType, Cost)
SELECT 'BUILDING_3UC_AGORA', ResourceType, Cost
FROM Building_ResourceQuantityRequirements WHERE BuildingType = 'BUILDING_MARKET';

------------------------------	
-- Building_YieldModifiers
------------------------------
INSERT INTO Building_YieldModifiers 	
			(BuildingType, YieldType, Yield)
SELECT 'BUILDING_3UC_AGORA', YieldType, Yield
FROM Building_YieldModifiers WHERE BuildingType = 'BUILDING_MARKET';


--------------------------------	
-- Civilization_BuildingClassOverrides 
--------------------------------		
INSERT INTO Civilization_BuildingClassOverrides 
		(CivilizationType, 					BuildingClassType, 			BuildingType)
VALUES	('CIVILIZATION_GREECE',	'BUILDINGCLASS_MARKET',	'BUILDING_3UC_AGORA');


