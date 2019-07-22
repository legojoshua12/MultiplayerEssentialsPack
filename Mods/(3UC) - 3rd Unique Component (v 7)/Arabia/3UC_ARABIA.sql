-- Buildings
------------------------------	
INSERT INTO Buildings 	
							(Type, BuildingClass, Cost, FaithCost, UnlockedByBelief, GoldMaintenance, PrereqTech, ArtDefineTag, XBuiltTriggersIdeologyChoice, SpecialistType, SpecialistCount, MinAreaSize, ConquestProb, HurryCostModifier, Help, Description, Civilopedia, Strategy, IconAtlas, PortraitIndex)
SELECT	'BUILDING_3UC_MADRASAH', BuildingClass, Cost, FaithCost, UnlockedByBelief, GoldMaintenance, PrereqTech, ArtDefineTag, XBuiltTriggersIdeologyChoice, SpecialistType, SpecialistCount, MinAreaSize, ConquestProb, HurryCostModifier, 'TXT_KEY_BUILDING_3UC_MADRASAH_HELP', 'TXT_KEY_BUILDING_3UC_MADRASAH', 'TXT_KEY_BUILDING_3UC_MADRASAH_TEXT', 'TXT_KEY_BUILDING_3UC_MADRASAH_STRATEGY', 'EXPANSION_SCEN_BUILDING_ATLAS', 2
FROM Buildings WHERE Type = 'BUILDING_UNIVERSITY';	
------------------------------	
-- Building_Flavors
------------------------------		
INSERT INTO Building_Flavors 	
		(BuildingType, 				FlavorType, Flavor)
SELECT	'BUILDING_3UC_MADRASAH',	FlavorType, Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_UNIVERSITY';
------------------------------	
-- Building_ClassesNeededInCity
------------------------------		
INSERT INTO Building_ClassesNeededInCity 	
		(BuildingType, 				BuildingClassType)
SELECT	'BUILDING_3UC_MADRASAH',	BuildingClassType
FROM Building_ClassesNeededInCity WHERE BuildingType = 'BUILDING_UNIVERSITY';

------------------------------	
-- Building_FeatureYieldChanges
------------------------------
INSERT INTO Building_FeatureYieldChanges 	
			(BuildingType, FeatureType, YieldType, Yield)
SELECT	'BUILDING_3UC_MADRASAH',	FeatureType, YieldType, Yield
FROM Building_FeatureYieldChanges WHERE BuildingType = 'BUILDING_UNIVERSITY';

------------------------------	
-- Building_YieldChanges
------------------------------		
INSERT INTO Building_YieldChanges 	
		(BuildingType, 				YieldType, Yield)
VALUES	('BUILDING_3UC_MADRASAH',	'YIELD_FAITH', 4);

------------------------------	
-- Building_YieldModifiers
------------------------------
INSERT INTO Building_YieldModifiers 	
			(BuildingType, YieldType, Yield)
SELECT 'BUILDING_3UC_MADRASAH', YieldType, Yield
FROM Building_YieldModifiers WHERE BuildingType = 'BUILDING_UNIVERSITY';

--------------------------------	
-- Civilization_BuildingClassOverrides 
--------------------------------		
INSERT INTO Civilization_BuildingClassOverrides 
		(CivilizationType, 					BuildingClassType, 			BuildingType)
VALUES	('CIVILIZATION_ARABIA',	'BUILDINGCLASS_UNIVERSITY',	'BUILDING_3UC_MADRASAH');


