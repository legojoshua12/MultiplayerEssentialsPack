-- Buildings
------------------------------	
INSERT INTO Buildings 	
	(Type, BuildingClass, GreatWorkSlotType, GreatWorkCount, Cost, GoldMaintenance, PrereqTech, ArtDefineTag, XBuiltTriggersIdeologyChoice, SpecialistType, SpecialistCount, MinAreaSize, ConquestProb, HurryCostModifier, Help, Description, Civilopedia, Strategy, IconAtlas, PortraitIndex)
SELECT	'BUILDING_4UC_OPERA_HOUSE', BuildingClass,  GreatWorkSlotType, GreatWorkCount,  Cost, GoldMaintenance, PrereqTech, ArtDefineTag, XBuiltTriggersIdeologyChoice, SpecialistType, SpecialistCount, MinAreaSize, ConquestProb, HurryCostModifier, 'TXT_KEY_BUILDING_4UC_OPERA_HOUSE_HELP', 'TXT_KEY_BUILDING_4UC_OPERA_HOUSE', 'TXT_KEY_BUILDING_4UC_OPERA_HOUSE_TEXT', 'TXT_KEY_BUILDING_4UC_OPERA_HOUSE_STRATEGY', 'AUSTRIA_OPERA_HOUSE_ATLAS', 0
FROM Buildings WHERE Type = 'BUILDING_OPERA_HOUSE';	
------------------------------	
-- Building_Flavors
------------------------------		
INSERT INTO Building_Flavors 	
		(BuildingType, 				FlavorType, Flavor)
SELECT	'BUILDING_4UC_OPERA_HOUSE',	FlavorType, Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_OPERA_HOUSE';
------------------------------	
-- Building_ClassesNeededInCity
------------------------------		
INSERT INTO Building_ClassesNeededInCity 	
		(BuildingType, 				BuildingClassType)
SELECT	'BUILDING_4UC_OPERA_HOUSE',	BuildingClassType
FROM Building_ClassesNeededInCity WHERE BuildingType = 'BUILDING_OPERA_HOUSE';
------------------------------	
-- Building_YieldChanges
------------------------------		
INSERT INTO Building_YieldChanges 		
			(BuildingType, 				YieldType, Yield)
VALUES ('BUILDING_4UC_OPERA_HOUSE', 'YIELD_CULTURE', 4);
------------------------------	
-- Building_DomainProductionModifiers
------------------------------
INSERT INTO Building_DomainProductionModifiers 	
			(BuildingType, DomainType, Modifier)
SELECT	'BUILDING_4UC_OPERA_HOUSE',	DomainType, Modifier
FROM Building_DomainProductionModifiers WHERE BuildingType = 'BUILDING_OPERA_HOUSE';

------------------------------	
-- Building_UnitCombatProductionModifiers
------------------------------
INSERT INTO Building_UnitCombatProductionModifiers 	
			(BuildingType, UnitCombatType, Modifier)
SELECT	'BUILDING_4UC_OPERA_HOUSE',	 UnitCombatType, Modifier
FROM Building_UnitCombatProductionModifiers WHERE BuildingType = 'BUILDING_OPERA_HOUSE';

------------------------------	
-- Building_ResourceQuantityRequirements
------------------------------
INSERT INTO Building_ResourceQuantityRequirements 	
			(BuildingType, ResourceType, Cost)
SELECT 'BUILDING_4UC_OPERA_HOUSE', ResourceType, Cost
FROM Building_ResourceQuantityRequirements WHERE BuildingType = 'BUILDING_OPERA_HOUSE';

------------------------------	
-- Building_YieldModifiers
------------------------------
INSERT INTO Building_YieldModifiers 	
			(BuildingType, YieldType, Yield)
SELECT 'BUILDING_4UC_OPERA_HOUSE', YieldType, Yield
FROM Building_YieldModifiers WHERE BuildingType = 'BUILDING_OPERA_HOUSE';

------------------------------	
-- Building_ResourceYieldChanges
------------------------------
INSERT INTO Building_ResourceYieldChanges 	
			(BuildingType, ResourceType, YieldType, Yield)
SELECT 'BUILDING_4UC_OPERA_HOUSE', ResourceType, YieldType, Yield
FROM Building_ResourceYieldChanges  WHERE BuildingType = 'BUILDING_OPERA_HOUSE';

--------------------------------	
-- Civilization_BuildingClassOverrides 
--------------------------------		
INSERT INTO Civilization_BuildingClassOverrides 
		(CivilizationType, 					BuildingClassType, 			BuildingType)
VALUES	('CIVILIZATION_AUSTRIA',	'BUILDINGCLASS_OPERA_HOUSE',	'BUILDING_4UC_OPERA_HOUSE');


