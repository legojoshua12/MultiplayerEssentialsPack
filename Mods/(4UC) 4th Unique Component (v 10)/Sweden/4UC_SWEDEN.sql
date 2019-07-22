-- Buildings
------------------------------	
INSERT INTO Buildings 	
	(Type, BuildingClass, FaithCost, UnlockedByBelief, ExtraCityHitPoints, CityWall, Cost, GoldMaintenance, PrereqTech, ArtDefineTag, XBuiltTriggersIdeologyChoice, SpecialistType, SpecialistCount, MinAreaSize, ConquestProb, HurryCostModifier, Help, Description, Civilopedia, Strategy, IconAtlas, PortraitIndex)
SELECT	'BUILDING_3SKOLA', BuildingClass, FaithCost, UnlockedByBelief, ExtraCityHitPoints,CityWall,  Cost, GoldMaintenance, PrereqTech, ArtDefineTag, XBuiltTriggersIdeologyChoice, SpecialistType, SpecialistCount, MinAreaSize, ConquestProb, HurryCostModifier, 'TXT_KEY_BUILDING_3SKOLA_HELP', 'TXT_KEY_BUILDING_3SKOLA', 'TXT_KEY_BUILDING_3SKOLA_TEXT', 'TXT_KEY_BUILDING_3SKOLA_STRATEGY', '3SKOLA_ATLAS', 0
FROM Buildings WHERE Type = 'BUILDING_UNIVERSITY';	
------------------------------	
-- Building_Flavors
------------------------------		
INSERT INTO Building_Flavors 	
		(BuildingType, 				FlavorType, Flavor)
SELECT	'BUILDING_3SKOLA',	FlavorType, Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_UNIVERSITY';
------------------------------	
-- Building_ClassesNeededInCity
------------------------------		
INSERT INTO Building_ClassesNeededInCity 	
		(BuildingType, 				BuildingClassType)
SELECT	'BUILDING_3SKOLA',	BuildingClassType
FROM Building_ClassesNeededInCity WHERE BuildingType = 'BUILDING_UNIVERSITY';
------------------------------	
-- Building_YieldChanges
------------------------------		
INSERT INTO Building_YieldChanges 	
		(BuildingType, 				YieldType, Yield)
SELECT	'BUILDING_3SKOLA',	YieldType, Yield
FROM Building_YieldChanges WHERE BuildingType = 'BUILDING_UNIVERSITY';
------------------------------	
-- Building_DomainProductionModifiers
------------------------------
INSERT INTO Building_DomainProductionModifiers 	
			(BuildingType, DomainType, Modifier)
SELECT	'BUILDING_3SKOLA',	DomainType, Modifier
FROM Building_DomainProductionModifiers WHERE BuildingType = 'BUILDING_UNIVERSITY';

------------------------------	
-- Building_UnitCombatProductionModifiers
------------------------------
INSERT INTO Building_UnitCombatProductionModifiers 	
			(BuildingType, UnitCombatType, Modifier)
SELECT	'BUILDING_3SKOLA',	 UnitCombatType, Modifier
FROM Building_UnitCombatProductionModifiers WHERE BuildingType = 'BUILDING_UNIVERSITY';

------------------------------	
-- Building_ResourceQuantityRequirements
------------------------------
INSERT INTO Building_ResourceQuantityRequirements 	
			(BuildingType, ResourceType, Cost)
SELECT 'BUILDING_3SKOLA', ResourceType, Cost
FROM Building_ResourceQuantityRequirements WHERE BuildingType = 'BUILDING_UNIVERSITY';

------------------------------	
-- Building_FeatureYieldChanges
------------------------------
INSERT INTO Building_FeatureYieldChanges	
			(BuildingType, FeatureType, YieldType, Yield)
SELECT 'BUILDING_3SKOLA', FeatureType, YieldType, Yield
FROM Building_FeatureYieldChanges WHERE BuildingType = 'BUILDING_UNIVERSITY';

------------------------------	
-- Building_TerrainYieldChanges
------------------------------
INSERT INTO Building_TerrainYieldChanges	
			(BuildingType, TerrainType, YieldType, Yield)
VALUES ('BUILDING_3SKOLA', 'TERRAIN_TUNDRA', 'YIELD_SCIENCE', 2);

------------------------------	
-- Building_YieldModifiers
------------------------------
INSERT INTO Building_YieldModifiers 	
			(BuildingType, YieldType, Yield)
SELECT 'BUILDING_3SKOLA', YieldType, Yield
FROM Building_YieldModifiers WHERE BuildingType = 'BUILDING_UNIVERSITY';

------------------------------	
-- Building_ResourceYieldChanges
------------------------------
INSERT INTO Building_ResourceYieldChanges 	
			(BuildingType, ResourceType, YieldType, Yield)
SELECT 'BUILDING_3SKOLA', ResourceType, YieldType, Yield
FROM Building_ResourceYieldChanges  WHERE BuildingType = 'BUILDING_UNIVERSITY';

--------------------------------	
-- Civilization_BuildingClassOverrides 
--------------------------------		
INSERT INTO Civilization_BuildingClassOverrides 
		(CivilizationType, 					BuildingClassType, 			BuildingType)
VALUES	('CIVILIZATION_SWEDEN',	'BUILDINGCLASS_UNIVERSITY',	'BUILDING_3SKOLA');


