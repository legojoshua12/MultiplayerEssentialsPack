-- Buildings
------------------------------	
INSERT INTO Buildings 	
	(Type, BuildingClass, Cost, FreeStartEra, NeverCapture, GoldMaintenance, PrereqTech, ArtDefineTag, SpecialistType, SpecialistCount, MinAreaSize, ConquestProb, HurryCostModifier, Help, Description, Civilopedia, Strategy, IconAtlas, PortraitIndex)
SELECT	'BUILDING_3UC_DOJO', BuildingClass, Cost, FreeStartEra, NeverCapture, GoldMaintenance, PrereqTech, ArtDefineTag, SpecialistType, SpecialistCount, MinAreaSize, ConquestProb, HurryCostModifier, 'TXT_KEY_BUILDING_3UC_DOJO_HELP', 'TXT_KEY_BUILDING_3UC_DOJO', 'TXT_KEY_BUILDING_3UC_DOJO_TEXT', 'TXT_KEY_BUILDING_3UC_DOJO_STRATEGY', 'DOJO_ICON_ATLAS', 0
FROM Buildings WHERE Type = 'BUILDING_BARRACKS';	
------------------------------	
-- Building_Flavors
------------------------------		
INSERT INTO Building_Flavors 	
		(BuildingType, 				FlavorType, Flavor)
SELECT	'BUILDING_3UC_DOJO',	FlavorType, Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_BARRACKS';
------------------------------	
-- Building_ClassesNeededInCity
------------------------------		
INSERT INTO Building_ClassesNeededInCity 	
		(BuildingType, 				BuildingClassType)
SELECT	'BUILDING_3UC_DOJO',	BuildingClassType
FROM Building_ClassesNeededInCity WHERE BuildingType = 'BUILDING_BARRACKS';
------------------------------	
-- Building_YieldChanges
------------------------------		
INSERT INTO Building_YieldChanges 	
		(BuildingType, 				YieldType, Yield)
VALUES ('BUILDING_3UC_DOJO', 'YIELD_CULTURE', 2);
------------------------------	
-- Building_DomainFreeExperiences
------------------------------
INSERT INTO Building_DomainFreeExperiences 	
		(BuildingType, 				DomainType, Experience)
VALUES ('BUILDING_3UC_DOJO', 'DOMAIN_LAND', 30),
	 ('BUILDING_3UC_DOJO', 'DOMAIN_SEA', 15),
	('BUILDING_3UC_DOJO', 'DOMAIN_AIR', 15);


------------------------------	
-- Building_ResourceQuantityRequirements
------------------------------
INSERT INTO Building_ResourceQuantityRequirements 	
			(BuildingType, ResourceType, Cost)
SELECT 'BUILDING_3UC_DOJO', ResourceType, Cost
FROM Building_ResourceQuantityRequirements WHERE BuildingType = 'BUILDING_BARRACKS';

------------------------------	
-- Building_YieldModifiers
------------------------------
INSERT INTO Building_YieldModifiers 	
			(BuildingType, YieldType, Yield)
SELECT 'BUILDING_3UC_DOJO', YieldType, Yield
FROM Building_YieldModifiers WHERE BuildingType = 'BUILDING_BARRACKS';


--------------------------------	
-- Civilization_BuildingClassOverrides 
--------------------------------		
INSERT INTO Civilization_BuildingClassOverrides 
		(CivilizationType, 					BuildingClassType, 			BuildingType)
VALUES	('CIVILIZATION_JAPAN',	'BUILDINGCLASS_BARRACKS',	'BUILDING_3UC_DOJO');


