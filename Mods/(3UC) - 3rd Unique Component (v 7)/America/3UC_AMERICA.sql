-- Buildings
------------------------------	
INSERT INTO Buildings 	
	(Type, BuildingClass, Cost, GoldMaintenance, PrereqTech, ArtDefineTag, XBuiltTriggersIdeologyChoice, SpecialistType, SpecialistCount, MinAreaSize, ConquestProb, HurryCostModifier, Help, Description, Civilopedia, Strategy, IconAtlas, PortraitIndex)
SELECT	'BUILDING_3UC_STEEL_MILL', BuildingClass, Cost, GoldMaintenance, PrereqTech, ArtDefineTag, XBuiltTriggersIdeologyChoice, SpecialistType, SpecialistCount, MinAreaSize, ConquestProb, HurryCostModifier, 'TXT_KEY_BUILDING_3UC_STEEL_MILL_HELP', 'TXT_KEY_BUILDING_3UC_STEEL_MILL', 'TXT_KEY_CIV5_BUILDINGS_3UC_STEEL_MILL_TEXT', 'TXT_KEY_BUILDING_3UC_STEEL_MILL_STRATEGY', 'MEGA_TECH_ATLAS', 9
FROM Buildings WHERE Type = 'BUILDING_FACTORY';	
------------------------------	
-- Building_Flavors
------------------------------		
INSERT INTO Building_Flavors 	
		(BuildingType, 				FlavorType, Flavor)
SELECT	'BUILDING_3UC_STEEL_MILL',	FlavorType, Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_FACTORY';
------------------------------	
-- Building_ClassesNeededInCity
------------------------------		
INSERT INTO Building_ClassesNeededInCity 	
		(BuildingType, 				BuildingClassType)
SELECT	'BUILDING_3UC_STEEL_MILL',	BuildingClassType
FROM Building_ClassesNeededInCity WHERE BuildingType = 'BUILDING_FACTORY';
------------------------------	
-- Building_YieldChanges
------------------------------		
INSERT INTO Building_YieldChanges 	
		(BuildingType, 				YieldType, Yield)
SELECT	'BUILDING_3UC_STEEL_MILL',	YieldType, Yield
FROM Building_YieldChanges WHERE BuildingType = 'BUILDING_FACTORY';
------------------------------	
-- Building_DomainProductionModifiers
------------------------------
INSERT INTO Building_DomainProductionModifiers 	
			(BuildingType, DomainType, Modifier)
VALUES ('BUILDING_3UC_STEEL_MILL', 'DOMAIN_SEA', 15);

------------------------------	
-- Building_UnitCombatProductionModifiers
------------------------------
INSERT INTO Building_UnitCombatProductionModifiers 	
			(BuildingType, UnitCombatType, Modifier)
VALUES ('BUILDING_3UC_STEEL_MILL', 'UNITCOMBAT_ARMOR', 15);

------------------------------	
-- Building_ResourceQuantityRequirements
------------------------------
INSERT INTO Building_ResourceQuantityRequirements 	
			(BuildingType, ResourceType, Cost)
SELECT 'BUILDING_3UC_STEEL_MILL', ResourceType, Cost
FROM Building_ResourceQuantityRequirements WHERE BuildingType = 'BUILDING_FACTORY';

------------------------------	
-- Building_YieldModifiers
------------------------------
INSERT INTO Building_YieldModifiers 	
			(BuildingType, YieldType, Yield)
SELECT 'BUILDING_3UC_STEEL_MILL', YieldType, Yield
FROM Building_YieldModifiers WHERE BuildingType = 'BUILDING_FACTORY';

------------------------------	
-- Building_ResourceYieldChanges
------------------------------
INSERT INTO Building_ResourceYieldChanges 	
			(BuildingType, ResourceType, YieldType, Yield)
VALUES ('BUILDING_3UC_STEEL_MILL', 'RESOURCE_IRON', 'YIELD_PRODUCTION', 2),
	   ('BUILDING_3UC_STEEL_MILL', 'RESOURCE_COAL', 'YIELD_PRODUCTION', 2);

--------------------------------	
-- Civilization_BuildingClassOverrides 
--------------------------------		
INSERT INTO Civilization_BuildingClassOverrides 
		(CivilizationType, 					BuildingClassType, 			BuildingType)
VALUES	('CIVILIZATION_AMERICA',	'BUILDINGCLASS_FACTORY',	'BUILDING_3UC_STEEL_MILL');


