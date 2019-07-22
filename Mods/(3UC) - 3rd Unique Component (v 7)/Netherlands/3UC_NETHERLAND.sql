-- Buildings
------------------------------	
INSERT INTO Buildings 	
	(Type, BuildingClass, Espionage, EspionageModifier, TradeRouteRecipientBonus, TradeRouteTargetBonus, GreatWorkSlotType, GreatWorkCount, Cost, FreeStartEra, Happiness, NeverCapture, GoldMaintenance, PrereqTech, ArtDefineTag, SpecialistType, SpecialistCount, MinAreaSize, ConquestProb, HurryCostModifier, Help, Description, Civilopedia, Strategy, IconAtlas, PortraitIndex)
SELECT	'BUILDING_3UC_WAAG', BuildingClass, 'true', -25, 2, 2, GreatWorkSlotType, GreatWorkCount, Cost, FreeStartEra, Happiness, NeverCapture, GoldMaintenance, PrereqTech, ArtDefineTag, SpecialistType, SpecialistCount, MinAreaSize, ConquestProb, HurryCostModifier,  'TXT_KEY_BUILDING_3UC_WAAG_HELP', 'TXT_KEY_BUILDING_3UC_WAAG', 'TXT_KEY_BUILDING_3UC_WAAG_TEXT', 'TXT_KEY_BUILDING_3UC_WAAG_STRATEGY', 'WAAG_ICON_ATLAS', 0
FROM Buildings WHERE Type = 'BUILDING_BANK';	
------------------------------	
-- Building_Flavors
------------------------------		
INSERT INTO Building_Flavors 	
		(BuildingType, 			FlavorType, Flavor)
SELECT	'BUILDING_3UC_WAAG',	FlavorType, Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_BANK';
------------------------------	
-- Building_ClassesNeededInCity
------------------------------		
INSERT INTO Building_ClassesNeededInCity 	
		(BuildingType, 			BuildingClassType)
SELECT	'BUILDING_3UC_WAAG',	BuildingClassType
FROM Building_ClassesNeededInCity WHERE BuildingType = 'BUILDING_BANK';
------------------------------	
-- Building_YieldChanges
------------------------------		
INSERT INTO Building_YieldChanges 	
		(BuildingType, 			YieldType, Yield)
SELECT	'BUILDING_3UC_WAAG',	YieldType, Yield
FROM Building_YieldChanges WHERE BuildingType = 'BUILDING_BANK';

------------------------------	
-- Building_ResourceQuantityRequirements
------------------------------
INSERT INTO Building_ResourceQuantityRequirements 	
			(BuildingType, ResourceType, Cost)
SELECT 'BUILDING_3UC_WAAG', ResourceType, Cost
FROM Building_ResourceQuantityRequirements WHERE BuildingType = 'BUILDING_BANK';

------------------------------	
-- Building_YieldModifiers
------------------------------
INSERT INTO Building_YieldModifiers 	
			(BuildingType, YieldType, Yield)
SELECT 'BUILDING_3UC_WAAG', YieldType, Yield
FROM Building_YieldModifiers WHERE BuildingType = 'BUILDING_BANK';


--------------------------------	
-- Civilization_BuildingClassOverrides 
--------------------------------		
INSERT INTO Civilization_BuildingClassOverrides 
		(CivilizationType, 					BuildingClassType, 			BuildingType)
VALUES	('CIVILIZATION_NETHERLANDS',	'BUILDINGCLASS_BANK',	'BUILDING_3UC_WAAG');


