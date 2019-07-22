-- Buildings
------------------------------	
INSERT INTO Buildings 	
	(Type, BuildingClass, AllowsProductionTradeRoutes, Cost, FreeStartEra, GoldMaintenance, PrereqTech, ArtDefineTag, XBuiltTriggersIdeologyChoice, SpecialistType, SpecialistCount, MinAreaSize, ConquestProb, HurryCostModifier, Help, Description, Civilopedia, Strategy, IconAtlas, PortraitIndex)
SELECT	'BUILDING_3UC_ROUNDHOUSE', BuildingClass, AllowsProductionTradeRoutes, Cost, FreeStartEra, GoldMaintenance, PrereqTech, ArtDefineTag, XBuiltTriggersIdeologyChoice, SpecialistType, SpecialistCount, MinAreaSize, ConquestProb, HurryCostModifier, 'TXT_KEY_BUILDING_3UC_ROUNDHOUSE_HELP', 'TXT_KEY_BUILDING_3UC_ROUNDHOUSE', 'TXT_KEY_BUILDING_3UC_ROUNDHOUSE_TEXT', 'TXT_KEY_BUILDING_3UC_ROUNDHOUSE_STRATEGY', 'ATLAS_3UC_ROUNDHOUSE', 0
FROM Buildings WHERE Type = 'BUILDING_WORKSHOP';	
------------------------------	
-- Building_Flavors
------------------------------		
INSERT INTO Building_Flavors 	
		(BuildingType, 				FlavorType, Flavor)
SELECT	'BUILDING_3UC_ROUNDHOUSE',	FlavorType, Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_WORKSHOP';
------------------------------	
-- Building_ClassesNeededInCity
------------------------------		
INSERT INTO Building_ClassesNeededInCity 	
		(BuildingType, 				BuildingClassType)
SELECT	'BUILDING_3UC_ROUNDHOUSE',	BuildingClassType
FROM Building_ClassesNeededInCity WHERE BuildingType = 'BUILDING_WORKSHOP';
------------------------------	
-- Building_YieldChanges
------------------------------		
INSERT INTO Building_YieldChanges 	
		(BuildingType, 				YieldType, Yield)
SELECT	'BUILDING_3UC_ROUNDHOUSE',	YieldType, Yield
FROM Building_YieldChanges WHERE BuildingType = 'BUILDING_WORKSHOP';

------------------------------	
-- Building_ResourceQuantityRequirements
------------------------------
INSERT INTO Building_ResourceQuantityRequirements 	
			(BuildingType, ResourceType, Cost)
SELECT 'BUILDING_3UC_ROUNDHOUSE', ResourceType, Cost
FROM Building_ResourceQuantityRequirements WHERE BuildingType = 'BUILDING_WORKSHOP';

------------------------------	
-- Building_YieldModifiers
------------------------------
INSERT INTO Building_YieldModifiers 	
			(BuildingType, YieldType, Yield)
SELECT 'BUILDING_3UC_ROUNDHOUSE', YieldType, Yield
FROM Building_YieldModifiers WHERE BuildingType = 'BUILDING_WORKSHOP';

------------------------------	
-- Building_FeatureYieldChanges
------------------------------
INSERT INTO Building_FeatureYieldChanges 	
			(BuildingType, FeatureType, YieldType, Yield)
VALUES ('BUILDING_3UC_ROUNDHOUSE', 'FEATURE_FOREST', 'YIELD_CULTURE', 1);

--------------------------------	
-- Civilization_BuildingClassOverrides 
--------------------------------		
INSERT INTO Civilization_BuildingClassOverrides 
		(CivilizationType, 					BuildingClassType, 			BuildingType)
VALUES	('CIVILIZATION_CELTS',	'BUILDINGCLASS_WORKSHOP',	'BUILDING_3UC_ROUNDHOUSE');


