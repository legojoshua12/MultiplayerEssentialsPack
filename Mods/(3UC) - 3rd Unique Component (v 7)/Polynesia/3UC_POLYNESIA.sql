-- Buildings
------------------------------	
INSERT INTO Buildings 	
	(Type, BuildingClass,  Water,  AllowsRangeStrike, Defense, ExtraCityHitPoints,  GreatPeopleRateModifier, GreatWorkSlotType, GreatWorkCount, FreshWater, Cost, FreeStartEra, Happiness, NeverCapture, GoldMaintenance, PrereqTech, ArtDefineTag, SpecialistType, SpecialistCount, MinAreaSize, ConquestProb, HurryCostModifier, Help, Description, Civilopedia, Strategy, IconAtlas, PortraitIndex)
SELECT	'BUILDING_3UC_FISH_POND', BuildingClass, 'true', AllowsRangeStrike, Defense, ExtraCityHitPoints, GreatPeopleRateModifier, GreatWorkSlotType, GreatWorkCount, FreshWater, Cost, FreeStartEra, Happiness, NeverCapture, 0, 'TECH_ANIMAL_HUSBANDRY', ArtDefineTag, SpecialistType, SpecialistCount, MinAreaSize, ConquestProb, HurryCostModifier,  'TXT_KEY_BUILDING_3UC_FISH_POND_HELP','TXT_KEY_BUILDING_3UC_FISH_POND', 'TXT_KEY_BUILDING_3UC_FISH_POND_TEXT', 'TXT_KEY_BUILDING_3UC_FISH_POND_STRATEGY', 'ICON_ATLAS', 29
FROM Buildings WHERE Type = 'BUILDING_WATERMILL';	
------------------------------	
-- Building_Flavors
------------------------------		
INSERT INTO Building_Flavors 	
		(BuildingType, 				FlavorType, Flavor)
VALUES	('BUILDING_3UC_FISH_POND',	'FLAVOR_GROWTH',	25),
		('BUILDING_3UC_FISH_POND',	'FLAVOR_SCIENCE',	25);

------------------------------	
-- Building_ClassesNeededInCity
------------------------------		
INSERT INTO Building_ClassesNeededInCity 	
		(BuildingType, 				BuildingClassType)
SELECT	'BUILDING_3UC_FISH_POND',	BuildingClassType
FROM Building_ClassesNeededInCity WHERE BuildingType = 'BUILDING_WATERMILL';
------------------------------	
-- Building_YieldChanges
------------------------------		
INSERT INTO Building_YieldChanges 	
		(BuildingType, 				YieldType, Yield)
VALUES	('BUILDING_3UC_FISH_POND',	'YIELD_FOOD',	3);

------------------------------	
-- Building_ResourceYieldChanges
------------------------------		
INSERT INTO Building_ResourceYieldChanges 	
		(BuildingType, 		ResourceType,		YieldType, Yield)
VALUES	('BUILDING_3UC_FISH_POND',	'RESOURCE_FISH', 'YIELD_FOOD',	1);

------------------------------	
-- Building_ResourceQuantityRequirements
------------------------------
INSERT INTO Building_ResourceQuantityRequirements 	
			(BuildingType, ResourceType, Cost)
SELECT 'BUILDING_3UC_FISH_POND', ResourceType, Cost
FROM Building_ResourceQuantityRequirements WHERE BuildingType = 'BUILDING_WATERMILL';

------------------------------	
-- Building_YieldModifiers
------------------------------
INSERT INTO Building_YieldModifiers 	
			(BuildingType, YieldType, Yield)
SELECT 'BUILDING_3UC_FISH_POND', YieldType, Yield
FROM Building_YieldModifiers WHERE BuildingType = 'BUILDING_WATERMILL';


--------------------------------	
-- Civilization_BuildingClassOverrides 
--------------------------------		
INSERT INTO Civilization_BuildingClassOverrides 
		(CivilizationType, 					BuildingClassType, 			BuildingType)
VALUES	('CIVILIZATION_POLYNESIA',	'BUILDINGCLASS_WATERMILL',	'BUILDING_3UC_FISH_POND');


