-- Buildings
------------------------------	
INSERT INTO Buildings 	
	(Type, BuildingClass, TrainedFreePromotion, NeverCapture, AllowsRangeStrike, Defense, ExtraCityHitPoints, CityWall, Cost, GoldMaintenance, PrereqTech, ArtDefineTag, XBuiltTriggersIdeologyChoice, SpecialistType, SpecialistCount, MinAreaSize, ConquestProb, HurryCostModifier, Help, Description, Civilopedia, Strategy, IconAtlas, PortraitIndex)
SELECT	'BUILDING_3OTTOBOMB', BuildingClass, 'PROMOTION_VOLLEY', NeverCapture, AllowsRangeStrike, Defense, ExtraCityHitPoints,CityWall,  Cost, GoldMaintenance, PrereqTech, ArtDefineTag, XBuiltTriggersIdeologyChoice, SpecialistType, SpecialistCount, MinAreaSize, ConquestProb, HurryCostModifier, 'TXT_KEY_BUILDING_3OTTOBOMB_HELP', 'TXT_KEY_BUILDING_3OTTOBOMB', 'TXT_KEY_BUILDING_3OTTOBOMB_TEXT', 'TXT_KEY_BUILDING_3OTTOBOMB_STRATEGY', '3OTTOBOMB_ATLAS', 0
FROM Buildings WHERE Type = 'BUILDING_ARMORY';	
------------------------------	
-- Building_Flavors
------------------------------		
INSERT INTO Building_Flavors 	
		(BuildingType, 				FlavorType, Flavor)
SELECT	'BUILDING_3OTTOBOMB',	FlavorType, Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_ARMORY';


------------------------------	
-- Building_YieldChanges
------------------------------		
INSERT INTO Building_YieldChanges 	
		(BuildingType, 				YieldType, Yield)
SELECT	'BUILDING_3OTTOBOMB',	YieldType, Yield
FROM Building_YieldChanges WHERE BuildingType = 'BUILDING_ARMORY';

INSERT INTO  Building_YieldChanges
		(BuildingType, 		YieldType, Yield)
VALUES	('BUILDING_3OTTOBOMB', 	'YIELD_PRODUCTION', 2);

------------------------------	
-- Building_DomainProductionModifiers
------------------------------
INSERT INTO Building_DomainProductionModifiers 	
			(BuildingType, DomainType, Modifier)
SELECT	'BUILDING_3OTTOBOMB',	DomainType, Modifier
FROM Building_DomainProductionModifiers WHERE BuildingType = 'BUILDING_ARMORY';

------------------------------	
-- Building_DomainFreeExperiences
------------------------------
INSERT INTO Building_DomainFreeExperiences 	
			(BuildingType, DomainType, Experience)
SELECT	'BUILDING_3OTTOBOMB',	DomainType, Experience
FROM Building_DomainFreeExperiences WHERE BuildingType = 'BUILDING_ARMORY';

------------------------------	
-- Building_ClassesNeededInCity
------------------------------
INSERT INTO Building_ClassesNeededInCity 	
			(BuildingType, BuildingClassType)
SELECT	'BUILDING_3OTTOBOMB',	BuildingClassType
FROM Building_ClassesNeededInCity WHERE BuildingType = 'BUILDING_ARMORY';

------------------------------	
-- Building_UnitCombatProductionModifiers
------------------------------
INSERT INTO Building_UnitCombatProductionModifiers 	
			(BuildingType, UnitCombatType, Modifier)
SELECT	'BUILDING_3OTTOBOMB',	 UnitCombatType, Modifier
FROM Building_UnitCombatProductionModifiers WHERE BuildingType = 'BUILDING_ARMORY';

------------------------------	
-- Building_ResourceQuantityRequirements
------------------------------
INSERT INTO Building_ResourceQuantityRequirements 	
			(BuildingType, ResourceType, Cost)
SELECT 'BUILDING_3OTTOBOMB', ResourceType, Cost
FROM Building_ResourceQuantityRequirements WHERE BuildingType = 'BUILDING_ARMORY';

------------------------------	
-- Building_YieldModifiers
------------------------------
INSERT INTO Building_YieldModifiers 	
			(BuildingType, YieldType, Yield)
SELECT 'BUILDING_3OTTOBOMB', YieldType, Yield
FROM Building_YieldModifiers WHERE BuildingType = 'BUILDING_ARMORY';

------------------------------	
-- Building_ResourceYieldChanges
------------------------------
INSERT INTO Building_ResourceYieldChanges 	
			(BuildingType, ResourceType, YieldType, Yield)
SELECT 'BUILDING_3OTTOBOMB', ResourceType, YieldType, Yield
FROM Building_ResourceYieldChanges  WHERE BuildingType = 'BUILDING_ARMORY';

--------------------------------	
-- Civilization_BuildingClassOverrides 
--------------------------------		
INSERT INTO Civilization_BuildingClassOverrides 
		(CivilizationType, 					BuildingClassType, 			BuildingType)
VALUES	('CIVILIZATION_OTTOMAN',	'BUILDINGCLASS_ARMORY',	'BUILDING_3OTTOBOMB');


