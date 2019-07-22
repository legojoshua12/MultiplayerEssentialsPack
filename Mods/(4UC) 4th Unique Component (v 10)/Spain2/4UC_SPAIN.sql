-- Buildings
------------------------------	
INSERT INTO Buildings 	
	(Type, BuildingClass, ReligiousPressureModifier, GreatPeopleRateModifier,  AllowsRangeStrike, Defense, ExtraCityHitPoints, CityWall, Cost, GoldMaintenance, PrereqTech, ArtDefineTag, XBuiltTriggersIdeologyChoice, SpecialistType, SpecialistCount, MinAreaSize, ConquestProb, HurryCostModifier, Help, Description, Civilopedia, Strategy, IconAtlas, PortraitIndex)
SELECT	'BUILDING_4UC_MISSION', BuildingClass, 25, GreatPeopleRateModifier, AllowsRangeStrike, Defense, ExtraCityHitPoints,CityWall,  Cost, GoldMaintenance, PrereqTech, ArtDefineTag, XBuiltTriggersIdeologyChoice, SpecialistType, SpecialistCount, MinAreaSize, ConquestProb, HurryCostModifier, 'TXT_KEY_BUILDING_4UC_MISSION_HELP', 'TXT_KEY_BUILDING_4UC_MISSION', 'TXT_KEY_BUILDING_4UC_MISSION_TEXT', 'TXT_KEY_BUILDING_4UC_MISSION_STRATEGY', 'BUILDING_4UC_MISSION_ATLAS', 0
FROM Buildings WHERE Type = 'BUILDING_GARDEN';	
------------------------------	
-- Building_Flavors
------------------------------		
INSERT INTO Building_Flavors 	
		(BuildingType, 				FlavorType, Flavor)
SELECT	'BUILDING_4UC_MISSION',	FlavorType, Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_GARDEN';

INSERT INTO Building_Flavors 	
		(BuildingType, 				FlavorType, Flavor)
VALUES ('BUILDING_4UC_MISSION',	'FLAVOR_RELIGION', 15);
------------------------------	
-- Building_ClassesNeededInCity
------------------------------		
INSERT INTO Building_ClassesNeededInCity 	
		(BuildingType, 				BuildingClassType)
SELECT	'BUILDING_4UC_MISSION',	BuildingClassType
FROM Building_ClassesNeededInCity WHERE BuildingType = 'BUILDING_GARDEN';
------------------------------	
-- Building_YieldChanges
------------------------------		
INSERT INTO Building_YieldChanges 	
		(BuildingType, 				YieldType, Yield)
SELECT	'BUILDING_4UC_MISSION',	YieldType, Yield
FROM Building_YieldChanges WHERE BuildingType = 'BUILDING_GARDEN';

------------------------------	
-- Building_DomainProductionModifiers
------------------------------
INSERT INTO Building_DomainProductionModifiers 	
			(BuildingType, DomainType, Modifier)
SELECT	'BUILDING_4UC_MISSION',	DomainType, Modifier
FROM Building_DomainProductionModifiers WHERE BuildingType = 'BUILDING_GARDEN';

------------------------------	
-- Building_UnitCombatProductionModifiers
------------------------------
INSERT INTO Building_UnitCombatProductionModifiers 	
			(BuildingType, UnitCombatType, Modifier)
SELECT	'BUILDING_4UC_MISSION',	 UnitCombatType, Modifier
FROM Building_UnitCombatProductionModifiers WHERE BuildingType = 'BUILDING_GARDEN';

------------------------------	
-- Building_ResourceQuantityRequirements
------------------------------
INSERT INTO Building_ResourceQuantityRequirements 	
			(BuildingType, ResourceType, Cost)
SELECT 'BUILDING_4UC_MISSION', ResourceType, Cost
FROM Building_ResourceQuantityRequirements WHERE BuildingType = 'BUILDING_GARDEN';

------------------------------	
-- Building_YieldModifiers
------------------------------
INSERT INTO Building_YieldModifiers 	
			(BuildingType, YieldType, Yield)
SELECT 'BUILDING_4UC_MISSION', YieldType, Yield
FROM Building_YieldModifiers WHERE BuildingType = 'BUILDING_GARDEN';

------------------------------	
-- Building_ResourceYieldChanges
------------------------------
INSERT INTO Building_ResourceYieldChanges 	
			(BuildingType, ResourceType, YieldType, Yield)
SELECT 'BUILDING_4UC_MISSION', ResourceType, YieldType, Yield
FROM Building_ResourceYieldChanges  WHERE BuildingType = 'BUILDING_GARDEN';

--------------------------------	
-- Civilization_BuildingClassOverrides 
--------------------------------		
INSERT INTO Civilization_BuildingClassOverrides 
		(CivilizationType, 					BuildingClassType, 			BuildingType)
VALUES	('CIVILIZATION_SPAIN',	'BUILDINGCLASS_GARDEN',	'BUILDING_4UC_MISSION');


