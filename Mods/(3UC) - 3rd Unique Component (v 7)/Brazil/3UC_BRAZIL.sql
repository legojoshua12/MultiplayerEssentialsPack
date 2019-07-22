-- Buildings
------------------------------	
INSERT INTO Buildings 	
	(Type, BuildingClass, Cost, Happiness, EnhancedYieldTech, TechEnhancedTourism,  GoldMaintenance, PrereqTech, ArtDefineTag, SpecialistType, SpecialistCount, MinAreaSize, ConquestProb, HurryCostModifier, Help, Description, Civilopedia, Strategy, IconAtlas, PortraitIndex)
SELECT	'BUILDING_3UC_SAMBADROME', BuildingClass, Cost, Happiness, 'TECH_REFRIGERATION', 4, GoldMaintenance, PrereqTech, ArtDefineTag, SpecialistType, SpecialistCount, MinAreaSize, ConquestProb, HurryCostModifier, 'TXT_KEY_BUILDING_3UC_SAMBADROME_HELP', 'TXT_KEY_BUILDING_3UC_SAMBADROME', 'TXT_KEY_BUILDING_3UC_SAMBADROME_TEXT', 'TXT_KEY_BUILDING_3UC_SAMBADROME_STRATEGY', 'SAMBA_TECH_ATLAS', 7
FROM Buildings WHERE Type = 'BUILDING_STADIUM';	
------------------------------	
-- Building_Flavors
------------------------------		
INSERT INTO Building_Flavors 	
		(BuildingType, 				FlavorType, Flavor)
SELECT	'BUILDING_3UC_SAMBADROME',	FlavorType, Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_STADIUM';
------------------------------	
-- Building_ClassesNeededInCity
------------------------------		
INSERT INTO Building_ClassesNeededInCity 	
		(BuildingType, 				BuildingClassType)
SELECT	'BUILDING_3UC_SAMBADROME',	BuildingClassType
FROM Building_ClassesNeededInCity WHERE BuildingType = 'BUILDING_STADIUM';
------------------------------	
-- Building_YieldChanges
------------------------------		
INSERT INTO Building_YieldChanges 	
		(BuildingType, 				YieldType, Yield)
SELECT	'BUILDING_3UC_SAMBADROME',	YieldType, Yield
FROM Building_YieldChanges WHERE BuildingType = 'BUILDING_STADIUM';

------------------------------	
-- Building_ResourceQuantityRequirements
------------------------------
INSERT INTO Building_ResourceQuantityRequirements 	
			(BuildingType, ResourceType, Cost)
SELECT 'BUILDING_3UC_SAMBADROME', ResourceType, Cost
FROM Building_ResourceQuantityRequirements WHERE BuildingType = 'BUILDING_STADIUM';

------------------------------	
-- Building_YieldModifiers
------------------------------
INSERT INTO Building_YieldModifiers 	
			(BuildingType, YieldType, Yield)
SELECT 'BUILDING_3UC_SAMBADROME', YieldType, Yield
FROM Building_YieldModifiers WHERE BuildingType = 'BUILDING_STADIUM';

--------------------------------	
-- Civilization_BuildingClassOverrides 
--------------------------------		
INSERT INTO Civilization_BuildingClassOverrides 
		(CivilizationType, 					BuildingClassType, 			BuildingType)
VALUES	('CIVILIZATION_BRAZIL',	'BUILDINGCLASS_STADIUM',	'BUILDING_3UC_SAMBADROME');


