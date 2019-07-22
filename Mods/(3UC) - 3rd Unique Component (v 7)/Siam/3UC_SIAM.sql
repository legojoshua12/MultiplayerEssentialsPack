-- Buildings
------------------------------	
INSERT INTO Buildings 	
	(Type, BuildingClass,  GreatPeopleRateModifier, GreatWorkSlotType, GreatWorkCount,  Cost, FreeStartEra, Happiness, NeverCapture, GoldMaintenance, PrereqTech, ArtDefineTag, SpecialistType, SpecialistCount, MinAreaSize, ConquestProb, HurryCostModifier, Help, Description, Civilopedia, Strategy, IconAtlas, PortraitIndex)
SELECT	'BUILDING_3UC_SALA', BuildingClass, 25, GreatWorkSlotType, GreatWorkCount,  Cost, FreeStartEra, Happiness, NeverCapture, 0, 'TECH_CONSTRUCTION', ArtDefineTag, SpecialistType, SpecialistCount, MinAreaSize, ConquestProb, HurryCostModifier,  'TXT_KEY_BUILDING_3UC_SALA_HELP','TXT_KEY_BUILDING_3UC_SALA', 'TXT_KEY_BUILDING_3UC_SALA_TEXT', 'TXT_KEY_BUILDING_3UC_SALA_STRATEGY', 'SALA_ICON_ATLAS', 0
FROM Buildings WHERE Type = 'BUILDING_GARDEN';	
------------------------------	
-- Building_Flavors
------------------------------		
INSERT INTO Building_Flavors 	
		(BuildingType, 				FlavorType, Flavor)
SELECT	'BUILDING_3UC_SALA',	FlavorType, Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_GARDEN';
------------------------------	
-- Building_ClassesNeededInCity
------------------------------		
INSERT INTO Building_ClassesNeededInCity 	
		(BuildingType, 				BuildingClassType)
SELECT	'BUILDING_3UC_SALA',	BuildingClassType
FROM Building_ClassesNeededInCity WHERE BuildingType = 'BUILDING_GARDEN';

------------------------------	
-- Building_ResourceQuantityRequirements
------------------------------
INSERT INTO Building_ResourceQuantityRequirements 	
			(BuildingType, ResourceType, Cost)
SELECT 'BUILDING_3UC_SALA', ResourceType, Cost
FROM Building_ResourceQuantityRequirements WHERE BuildingType = 'BUILDING_GARDEN';

------------------------------	
-- Building_YieldModifiers
------------------------------
INSERT INTO Building_YieldModifiers 	
			(BuildingType, YieldType, Yield)
SELECT 'BUILDING_3UC_SALA', YieldType, Yield
FROM Building_YieldModifiers WHERE BuildingType = 'BUILDING_GARDEN';


--------------------------------	
-- Civilization_BuildingClassOverrides 
--------------------------------		
INSERT INTO Civilization_BuildingClassOverrides 
		(CivilizationType, 					BuildingClassType, 			BuildingType)
VALUES	('CIVILIZATION_SIAM',	'BUILDINGCLASS_GARDEN',	'BUILDING_3UC_SALA');


