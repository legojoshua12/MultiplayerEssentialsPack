-- Buildings
------------------------------	
INSERT INTO Buildings 	
	(Type, BuildingClass, River, Defense, ExtraCityHitPoints, FoodKept, Cost, GoldMaintenance, PrereqTech, ArtDefineTag, XBuiltTriggersIdeologyChoice, SpecialistType, SpecialistCount, MinAreaSize, ConquestProb, HurryCostModifier, Help, Description, Civilopedia, Strategy, IconAtlas, PortraitIndex)
SELECT	'BUILDING_3UC_NILOMETER', BuildingClass, River, Defense, ExtraCityHitPoints, 15,  Cost, 1, PrereqTech, ArtDefineTag, XBuiltTriggersIdeologyChoice, SpecialistType, SpecialistCount, MinAreaSize, ConquestProb, HurryCostModifier, 'TXT_KEY_BUILDING_3UC_NILOMETER_HELP', 'TXT_KEY_BUILDING_3UC_NILOMETER', 'TXT_KEY_BUILDING_3UC_NILOMETER_TEXT', 'TXT_KEY_BUILDING_3UC_NILOMETER_STRATEGY', '3UC_NILOMETER', 0
FROM Buildings WHERE Type = 'BUILDING_WATERMILL';	
------------------------------	
-- Building_Flavors
------------------------------		
INSERT INTO Building_Flavors 	
		(BuildingType, 				FlavorType, Flavor)
SELECT	'BUILDING_3UC_NILOMETER',	FlavorType, Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_WATERMILL';
------------------------------	
-- Building_ClassesNeededInCity
------------------------------		
INSERT INTO Building_ClassesNeededInCity 	
		(BuildingType, 				BuildingClassType)
SELECT	'BUILDING_3UC_NILOMETER',	BuildingClassType
FROM Building_ClassesNeededInCity WHERE BuildingType = 'BUILDING_WATERMILL';
------------------------------	
-- Building_YieldChanges
------------------------------		
INSERT INTO Building_YieldChanges 	
		(BuildingType, 				YieldType, Yield)
SELECT	'BUILDING_3UC_NILOMETER',	YieldType, Yield
FROM Building_YieldChanges WHERE BuildingType = 'BUILDING_WATERMILL';

------------------------------	
-- Building_YieldChanges
------------------------------		
INSERT INTO Building_FeatureYieldChanges
		(BuildingType, 				FeatureType, YieldType, Yield)
VALUES ('BUILDING_3UC_NILOMETER',	'FEATURE_FLOOD_PLAINS', 'YIELD_GOLD', 1);

------------------------------	
-- Building_DomainProductionModifiers
------------------------------
INSERT INTO Building_DomainProductionModifiers 	
			(BuildingType, DomainType, Modifier)
SELECT	'BUILDING_3UC_NILOMETER',	DomainType, Modifier
FROM Building_DomainProductionModifiers WHERE BuildingType = 'BUILDING_WATERMILL';

------------------------------	
-- Building_UnitCombatProductionModifiers
------------------------------
INSERT INTO Building_UnitCombatProductionModifiers 	
			(BuildingType, UnitCombatType, Modifier)
SELECT	'BUILDING_3UC_NILOMETER',	 UnitCombatType, Modifier
FROM Building_UnitCombatProductionModifiers WHERE BuildingType = 'BUILDING_WATERMILL';

------------------------------	
-- Building_ResourceQuantityRequirements
------------------------------
INSERT INTO Building_ResourceQuantityRequirements 	
			(BuildingType, ResourceType, Cost)
SELECT 'BUILDING_3UC_NILOMETER', ResourceType, Cost
FROM Building_ResourceQuantityRequirements WHERE BuildingType = 'BUILDING_WATERMILL';

------------------------------	
-- Building_YieldModifiers
------------------------------
INSERT INTO Building_YieldModifiers 	
			(BuildingType, YieldType, Yield)
SELECT 'BUILDING_3UC_NILOMETER', YieldType, Yield
FROM Building_YieldModifiers WHERE BuildingType = 'BUILDING_WATERMILL';

------------------------------	
-- Building_ResourceYieldChanges
------------------------------
INSERT INTO Building_ResourceYieldChanges 	
			(BuildingType, ResourceType, YieldType, Yield)
SELECT 'BUILDING_3UC_NILOMETER', ResourceType, YieldType, Yield
FROM Building_ResourceYieldChanges  WHERE BuildingType = 'BUILDING_WATERMILL';

--------------------------------	
-- Civilization_BuildingClassOverrides 
--------------------------------		
INSERT INTO Civilization_BuildingClassOverrides 
		(CivilizationType, 					BuildingClassType, 			BuildingType)
VALUES	('CIVILIZATION_EGYPT',	'BUILDINGCLASS_WATERMILL',	'BUILDING_3UC_NILOMETER');


