-- Buildings
------------------------------	
INSERT INTO Buildings 	
	(Type, BuildingClass,  GreatPeopleRateModifier, Defense, ExtraCityHitPoints,  Water, GreatWorkSlotType, GreatWorkCount,  Cost, FreeStartEra, Happiness, NeverCapture, GoldMaintenance, PrereqTech, ArtDefineTag, SpecialistType, SpecialistCount, MinAreaSize, ConquestProb, HurryCostModifier, Help, Description, Civilopedia, Strategy, IconAtlas, PortraitIndex)
SELECT	'BUILDING_3UC_CANALS', BuildingClass,  25, 400, 50, 'true', GreatWorkSlotType, GreatWorkCount,  Cost, FreeStartEra, Happiness, 'true', GoldMaintenance, 'TECH_CONSTRUCTION', ArtDefineTag, SpecialistType, SpecialistCount, MinAreaSize, ConquestProb, HurryCostModifier,  'TXT_KEY_BUILDING_3UC_CANALS_HELP','TXT_KEY_BUILDING_3UC_CANALS', 'TXT_KEY_BUILDING_3UC_CANALS_TEXT', 'TXT_KEY_BUILDING_3UC_CANALS_STRATEGY', 'ATLAS_VENICE_CALAL', 0
FROM Buildings WHERE Type = 'BUILDING_GARDEN';	

------------------------------	
-- Building_Flavors
------------------------------		
INSERT INTO Building_Flavors 	
		(BuildingType, 				FlavorType, Flavor)
SELECT	'BUILDING_3UC_CANALS',	FlavorType, Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_GARDEN';

------------------------------	
-- Building_ResourceQuantityRequirements
------------------------------
INSERT INTO Building_ResourceQuantityRequirements 	
			(BuildingType, ResourceType, Cost)
SELECT 'BUILDING_3UC_CANALS', ResourceType, Cost
FROM Building_ResourceQuantityRequirements WHERE BuildingType = 'BUILDING_GARDEN';

------------------------------	
-- Building_YieldModifiers
------------------------------
INSERT INTO Building_YieldModifiers 	
			(BuildingType, YieldType, Yield)
SELECT 'BUILDING_3UC_CANALS', YieldType, Yield
FROM Building_YieldModifiers WHERE BuildingType = 'BUILDING_GARDEN';


--------------------------------	
-- Civilization_BuildingClassOverrides 
--------------------------------		
INSERT INTO Civilization_BuildingClassOverrides 
		(CivilizationType, 					BuildingClassType, 			BuildingType)
VALUES	('CIVILIZATION_VENICE',	'BUILDINGCLASS_GARDEN',	'BUILDING_3UC_CANALS');


