-- Buildings
------------------------------	
INSERT INTO Buildings 	
	(Type, BuildingClass,  GreatWorkSlotType, GreatWorkCount, Cost, FreeStartEra, Happiness, NeverCapture, GoldMaintenance, PrereqTech, ArtDefineTag, SpecialistType, SpecialistCount, MinAreaSize, ConquestProb, HurryCostModifier, Help, Description, Civilopedia, Strategy, IconAtlas, PortraitIndex)
SELECT	'BUILDING_3UC_GER', BuildingClass,  GreatWorkSlotType, GreatWorkCount, Cost, FreeStartEra, Happiness, NeverCapture, GoldMaintenance, PrereqTech, ArtDefineTag, SpecialistType, SpecialistCount, MinAreaSize, ConquestProb, HurryCostModifier,  'TXT_KEY_BUILDING_3UC_GER_HELP', 'TXT_KEY_BUILDING_3UC_GER', 'TXT_KEY_BUILDING_3UC_GER_TEXT', 'TXT_KEY_BUILDING_3UC_GER_STRATEGY', 'GER_ICON_ATLAS', 0
FROM Buildings WHERE Type = 'BUILDING_CIRCUS';	
------------------------------	
-- Building_Flavors
------------------------------		
INSERT INTO Building_Flavors 	
		(BuildingType, 				FlavorType, Flavor)
SELECT	'BUILDING_3UC_GER',	FlavorType, Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_CIRCUS';
------------------------------	
-- Building_ClassesNeededInCity
------------------------------		
INSERT INTO Building_ClassesNeededInCity 	
		(BuildingType, 				BuildingClassType)
SELECT	'BUILDING_3UC_GER',	BuildingClassType
FROM Building_ClassesNeededInCity WHERE BuildingType = 'BUILDING_CIRCUS';

------------------------------	
-- Building_DomainFreeExperiences
------------------------------
INSERT INTO Building_DomainFreeExperiences 	
		(BuildingType, 				DomainType, Experience)
VALUES ('BUILDING_3UC_GER', 'DOMAIN_LAND', 15);

------------------------------	
-- Building_YieldModifiers
------------------------------
INSERT INTO Building_YieldModifiers 	
			(BuildingType, YieldType, Yield)
SELECT 'BUILDING_3UC_GER', YieldType, Yield
FROM Building_YieldModifiers WHERE BuildingType = 'BUILDING_CIRCUS';


--------------------------------	
-- Civilization_BuildingClassOverrides 
--------------------------------		
INSERT INTO Civilization_BuildingClassOverrides 
		(CivilizationType, 					BuildingClassType, 			BuildingType)
VALUES	('CIVILIZATION_MONGOL',	'BUILDINGCLASS_CIRCUS',	'BUILDING_3UC_GER');


