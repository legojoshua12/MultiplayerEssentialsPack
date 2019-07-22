
-- Buildings
------------------------------	
INSERT INTO Buildings 	
	(Type, BuildingClass, Happiness, AllowsRangeStrike, Defense,  ExtraCityHitPoints, CityWall, Cost, GoldMaintenance, PrereqTech, ArtDefineTag, XBuiltTriggersIdeologyChoice, SpecialistType, GreatWorkSlotType, GreatWorkCount, SpecialistCount, MinAreaSize, ConquestProb, HurryCostModifier, Help, Description, Civilopedia, Strategy, IconAtlas, PortraitIndex)
SELECT	'BUILDING_4UC_ODEON', BuildingClass, Happiness, AllowsRangeStrike, Defense, ExtraCityHitPoints,CityWall, Cost, 0, PrereqTech, ArtDefineTag, XBuiltTriggersIdeologyChoice, SpecialistType, GreatWorkSlotType, GreatWorkCount, SpecialistCount, MinAreaSize, ConquestProb, HurryCostModifier, 'TXT_KEY_BUILDING_4UC_ODEON_HELP', 'TXT_KEY_BUILDING_4UC_ODEON', 'TXT_KEY_BUILDING_4UC_ODEON_TEXT', 'TXT_KEY_BUILDING_4UC_ODEON_STRATEGY', '4UC_ODEON_ATLAS', 0
FROM Buildings WHERE Type = 'BUILDING_AMPHITHEATER';	
------------------------------	
-- Building_Flavors
------------------------------		
INSERT INTO Building_Flavors 	
		(BuildingType, 				FlavorType, Flavor)
SELECT	'BUILDING_4UC_ODEON',	FlavorType, Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_AMPHITHEATER';

INSERT INTO Building_Flavors 	
		(BuildingType, 				FlavorType, Flavor)
VALUES	('BUILDING_4UC_ODEON',	'FLAVOR_SCIENCE',	15);
------------------------------	
-- Building_ClassesNeededInCity
------------------------------		
INSERT INTO Building_ClassesNeededInCity 	
		(BuildingType, 				BuildingClassType)
SELECT	'BUILDING_4UC_ODEON',	BuildingClassType
FROM Building_ClassesNeededInCity WHERE BuildingType = 'BUILDING_AMPHITHEATER';
------------------------------	
-- Building_YieldChanges
------------------------------		
INSERT INTO Building_YieldChanges 	
		(BuildingType, 				YieldType, Yield)
SELECT	'BUILDING_4UC_ODEON',	YieldType, Yield
FROM Building_YieldChanges WHERE BuildingType = 'BUILDING_AMPHITHEATER';

INSERT INTO Building_YieldChanges 	
		(BuildingType, 				YieldType, Yield)
VALUES	('BUILDING_4UC_ODEON',	'YIELD_SCIENCE',	2);

------------------------------	
-- Building_DomainProductionModifiers
------------------------------
INSERT INTO Building_DomainProductionModifiers 	
			(BuildingType, DomainType, Modifier)
SELECT	'BUILDING_4UC_ODEON',	DomainType, Modifier
FROM Building_DomainProductionModifiers WHERE BuildingType = 'BUILDING_AMPHITHEATER';

------------------------------	
-- Building_UnitCombatProductionModifiers
------------------------------
INSERT INTO Building_UnitCombatProductionModifiers 	
			(BuildingType, UnitCombatType, Modifier)
SELECT	'BUILDING_4UC_ODEON',	 UnitCombatType, Modifier
FROM Building_UnitCombatProductionModifiers WHERE BuildingType = 'BUILDING_AMPHITHEATER';

------------------------------	
-- Building_ResourceQuantityRequirements
------------------------------
INSERT INTO Building_ResourceQuantityRequirements 	
			(BuildingType, ResourceType, Cost)
SELECT 'BUILDING_4UC_ODEON', ResourceType, Cost
FROM Building_ResourceQuantityRequirements WHERE BuildingType = 'BUILDING_AMPHITHEATER';

------------------------------	
-- Building_YieldModifiers
------------------------------
INSERT INTO Building_YieldModifiers 	
			(BuildingType, YieldType, Yield)
SELECT 'BUILDING_4UC_ODEON', YieldType, Yield
FROM Building_YieldModifiers WHERE BuildingType = 'BUILDING_AMPHITHEATER';

------------------------------	
-- Building_ResourceYieldChanges
------------------------------
INSERT INTO Building_ResourceYieldChanges 	
			(BuildingType, ResourceType, YieldType, Yield)
SELECT 'BUILDING_4UC_ODEON', ResourceType, YieldType, Yield
FROM Building_ResourceYieldChanges  WHERE BuildingType = 'BUILDING_AMPHITHEATER';
--------------------------------	
-- Civilization_BuildingClassOverrides 
--------------------------------		
INSERT INTO Civilization_BuildingClassOverrides 
		(CivilizationType, 					BuildingClassType, 			BuildingType)
VALUES	('CIVILIZATION_GREECE',	'BUILDINGCLASS_AMPHITHEATER',	'BUILDING_4UC_ODEON');


