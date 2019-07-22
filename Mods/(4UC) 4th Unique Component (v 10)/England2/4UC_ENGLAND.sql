-- Buildings
------------------------------	
INSERT INTO Buildings 	
	(Type, BuildingClass, XBuiltTriggersIdeologyChoice,  Cost, GoldMaintenance, PrereqTech, ArtDefineTag, SpecialistType, SpecialistCount, MinAreaSize, ConquestProb, HurryCostModifier, Help, Description, Civilopedia, Strategy, IconAtlas, PortraitIndex)
SELECT	'BUILDING_3UC_TEXTILE', BuildingClass, XBuiltTriggersIdeologyChoice, Cost, GoldMaintenance, PrereqTech, ArtDefineTag, SpecialistType, SpecialistCount, MinAreaSize, ConquestProb, HurryCostModifier, 'TXT_KEY_BUILDING_3UC_TEXTILE_HELP', 'TXT_KEY_BUILDING_3UC_TEXTILE', 'TXT_KEY_BUILDING_3UC_TEXTILE_TEXT', 'TXT_KEY_BUILDING_3UC_TEXTILE_STRATEGY', '3UC_TEXTILE_ATLAS', 0
FROM Buildings WHERE Type = 'BUILDING_FACTORY';	
------------------------------	
-- Building_Flavors
------------------------------		
INSERT INTO Building_Flavors 	
		(BuildingType, 				FlavorType, Flavor)
SELECT	'BUILDING_3UC_TEXTILE',	FlavorType, Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_FACTORY';
------------------------------	
-- Building_ClassesNeededInCity
------------------------------		
INSERT INTO Building_ClassesNeededInCity 	
		(BuildingType, 				BuildingClassType)
SELECT	'BUILDING_3UC_TEXTILE',	BuildingClassType
FROM Building_ClassesNeededInCity WHERE BuildingType = 'BUILDING_FACTORY';
------------------------------	
-- Building_YieldChanges
------------------------------		
INSERT INTO Building_YieldChanges 	
		(BuildingType, 				YieldType, Yield)
SELECT	'BUILDING_3UC_TEXTILE',	YieldType, Yield
FROM Building_YieldChanges WHERE BuildingType = 'BUILDING_FACTORY';

------------------------------	
-- Building_UnitCombatProductionModifiers
------------------------------
INSERT INTO Building_UnitCombatProductionModifiers 	
			(BuildingType, UnitCombatType, Modifier)
SELECT 'BUILDING_3UC_TEXTILE', UnitCombatType, Modifier
FROM Building_UnitCombatProductionModifiers WHERE BuildingType = 'BUILDING_FACTORY';


------------------------------	
-- Building_YieldModifiers
------------------------------
INSERT INTO Building_YieldModifiers 	
			(BuildingType, YieldType, Yield)
SELECT 'BUILDING_3UC_TEXTILE', YieldType, Yield
FROM Building_YieldModifiers WHERE BuildingType = 'BUILDING_FACTORY';

------------------------------	
-- Building_ResourceYieldChanges
------------------------------
INSERT INTO Building_ResourceYieldChanges 	
			(BuildingType, ResourceType, YieldType, Yield)
SELECT 'BUILDING_3UC_TEXTILE', ResourceType, YieldType, Yield
FROM Building_ResourceYieldChanges WHERE BuildingType = 'BUILDING_FACTORY';

------------------------------	
-- Building_ResourceYieldChanges
------------------------------
INSERT INTO Building_ResourceYieldChanges 	
			(BuildingType, ResourceType, YieldType, Yield)
VALUES	('BUILDING_3UC_TEXTILE',	'RESOURCE_COTTON',	'YIELD_GOLD', 2),
		('BUILDING_3UC_TEXTILE',	'RESOURCE_DYE',		'YIELD_GOLD', 2),
		('BUILDING_3UC_TEXTILE',	'RESOURCE_SILK',	'YIELD_GOLD', 2);

--------------------------------	
-- Civilization_BuildingClassOverrides 
--------------------------------		
INSERT INTO Civilization_BuildingClassOverrides 
		(CivilizationType, 					BuildingClassType, 			BuildingType)
VALUES	('CIVILIZATION_ENGLAND',	'BUILDINGCLASS_FACTORY',	'BUILDING_3UC_TEXTILE');


