-- Buildings
------------------------------	
INSERT INTO Buildings 	
	(Type, BuildingClass, PlotCultureCostModifier, GreatWorkSlotType, GreatWorkCount, Cost, FreeStartEra, Happiness, NeverCapture, GoldMaintenance, PrereqTech, ArtDefineTag, SpecialistType, SpecialistCount, MinAreaSize, ConquestProb, HurryCostModifier, Help, Description, Civilopedia, Strategy, IconAtlas, PortraitIndex)
SELECT	'BUILDING_3UC_YURT', BuildingClass, -25, GreatWorkSlotType, GreatWorkCount, Cost, FreeStartEra, Happiness, NeverCapture, GoldMaintenance, PrereqTech, ArtDefineTag, SpecialistType, SpecialistCount, MinAreaSize, ConquestProb, HurryCostModifier,  'TXT_KEY_BUILDING_3UC_YURT_HELP', 'TXT_KEY_BUILDING_3UC_YURT', 'TXT_KEY_BUILDING_3UC_YURT_TEXT', 'TXT_KEY_BUILDING_3UC_YURT_STRATEGY', 'YURT_ICON_ATLAS', 0
FROM Buildings WHERE Type = 'BUILDING_CIRCUS';	
------------------------------	
-- Building_Flavors
------------------------------		
INSERT INTO Building_Flavors 	
		(BuildingType, 				FlavorType, Flavor)
SELECT	'BUILDING_3UC_YURT',	FlavorType, Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_CIRCUS';
------------------------------	
-- Building_ClassesNeededInCity
------------------------------		
INSERT INTO Building_ClassesNeededInCity 	
		(BuildingType, 				BuildingClassType)
SELECT	'BUILDING_3UC_YURT',	BuildingClassType
FROM Building_ClassesNeededInCity WHERE BuildingType = 'BUILDING_CIRCUS';

------------------------------	
-- Building_YieldModifiers
------------------------------
INSERT INTO Building_YieldModifiers 	
			(BuildingType, YieldType, Yield)
SELECT 'BUILDING_3UC_YURT', YieldType, Yield
FROM Building_YieldModifiers WHERE BuildingType = 'BUILDING_CIRCUS';


--------------------------------	
-- Civilization_BuildingClassOverrides 
--------------------------------		
INSERT INTO Civilization_BuildingClassOverrides 
		(CivilizationType, 					BuildingClassType, 			BuildingType)
VALUES	('CIVILIZATION_HUNS',	'BUILDINGCLASS_CIRCUS',	'BUILDING_3UC_YURT');


