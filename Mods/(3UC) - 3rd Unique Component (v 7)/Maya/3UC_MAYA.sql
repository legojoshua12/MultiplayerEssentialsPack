-- Buildings
------------------------------	
INSERT INTO Buildings 	
	(Type, BuildingClass, Cost, Happiness, GoldMaintenance, PrereqTech, ArtDefineTag,  SpecialistType, SpecialistCount, MinAreaSize, ConquestProb, HurryCostModifier, Help, Description, Civilopedia, Strategy, IconAtlas, PortraitIndex)
SELECT	'BUILDING_3UC_BALLCOURT', BuildingClass, 80, Happiness, GoldMaintenance, PrereqTech, ArtDefineTag, SpecialistType, SpecialistCount, MinAreaSize, ConquestProb, HurryCostModifier, 'TXT_KEY_BUILDING_3UC_BALLCOURT_HELP', 'TXT_KEY_BUILDING_3UC_BALLCOURT', 'TXT_KEY_BUILDING_3UC_BALLCOURT_TEXT', 'TXT_KEY_BUILDING_3UC_BALLCOURT_STRATEGY', 'BALLCOURT_ICON_ATLAS', 0
FROM Buildings WHERE Type = 'BUILDING_COLOSSEUM';	
------------------------------	
-- Building_Flavors
------------------------------		
INSERT INTO Building_Flavors 	
		(BuildingType, 				FlavorType, Flavor)
SELECT	'BUILDING_3UC_BALLCOURT',	FlavorType, Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_COLOSSEUM';
------------------------------	
-- Building_ClassesNeededInCity
------------------------------		
INSERT INTO Building_ClassesNeededInCity 	
		(BuildingType, 				BuildingClassType)
SELECT	'BUILDING_3UC_BALLCOURT',	BuildingClassType
FROM Building_ClassesNeededInCity WHERE BuildingType = 'BUILDING_COLOSSEUM';
------------------------------	
-- Building_YieldChanges
------------------------------		
INSERT INTO Building_YieldChanges 	
		(BuildingType, 				YieldType, Yield)
VALUES	('BUILDING_3UC_BALLCOURT',	'YIELD_FAITH', 1);

------------------------------	
-- Building_YieldModifiers
------------------------------
INSERT INTO Building_YieldModifiers 	
			(BuildingType, YieldType, Yield)
SELECT 'BUILDING_3UC_BALLCOURT', YieldType, Yield
FROM Building_YieldModifiers WHERE BuildingType = 'BUILDING_COLOSSEUM';

--------------------------------	
-- Civilization_BuildingClassOverrides 
--------------------------------		
INSERT INTO Civilization_BuildingClassOverrides 
		(CivilizationType, 					BuildingClassType, 			BuildingType)
VALUES	('CIVILIZATION_MAYA',	'BUILDINGCLASS_COLOSSEUM',	'BUILDING_3UC_BALLCOURT');


