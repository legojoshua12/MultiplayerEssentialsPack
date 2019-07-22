-- Buildings
------------------------------	
INSERT INTO Buildings 	
	(Type, BuildingClass, TradeRouteRecipientBonus, TradeRouteTargetBonus, ExtraCityHitPoints, CityWall, Cost, GoldMaintenance, PrereqTech, ArtDefineTag, XBuiltTriggersIdeologyChoice, SpecialistType, SpecialistCount, MinAreaSize, ConquestProb, HurryCostModifier, Help, Description, Civilopedia, Strategy, IconAtlas, PortraitIndex)
SELECT	'BUILDING_3MINTPLUS', BuildingClass, TradeRouteRecipientBonus, TradeRouteTargetBonus, ExtraCityHitPoints,CityWall,  Cost, GoldMaintenance, PrereqTech, ArtDefineTag, XBuiltTriggersIdeologyChoice, SpecialistType, SpecialistCount, MinAreaSize, ConquestProb, HurryCostModifier, 'TXT_KEY_BUILDING_3MINTPLUS_HELP', 'TXT_KEY_BUILDING_3MINTPLUS', 'TXT_KEY_BUILDING_3MINTPLUS_TEXT', 'TXT_KEY_BUILDING_3MINTPLUS_STRATEGY', '3MUDPALACE_ATLAS', 0
FROM Buildings WHERE Type = 'BUILDING_MARKET';	
------------------------------	
-- Building_Flavors
------------------------------		
INSERT INTO Building_Flavors 	
		(BuildingType, 				FlavorType, Flavor)
SELECT	'BUILDING_3MINTPLUS',	FlavorType, Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_MARKET';
------------------------------	
-- Building_ClassesNeededInCity
------------------------------		
INSERT INTO Building_ClassesNeededInCity 	
		(BuildingType, 				BuildingClassType)
SELECT	'BUILDING_3MINTPLUS',	BuildingClassType
FROM Building_ClassesNeededInCity WHERE BuildingType = 'BUILDING_MARKET';
------------------------------	
-- Building_YieldChanges
------------------------------		
INSERT INTO Building_BuildingClassYieldChanges
		(BuildingType, 		BuildingClassType,		YieldType, YieldChange)
VALUES	('BUILDING_3MINTPLUS', 'BUILDINGCLASS_PALACE',	'YIELD_GOLD', 2);

------------------------------	
-- Building_DomainProductionModifiers
------------------------------
INSERT INTO Building_DomainProductionModifiers 	
			(BuildingType, DomainType, Modifier)
SELECT	'BUILDING_3MINTPLUS',	DomainType, Modifier
FROM Building_DomainProductionModifiers WHERE BuildingType = 'BUILDING_MARKET';

------------------------------	
-- Building_UnitCombatProductionModifiers
------------------------------
INSERT INTO Building_UnitCombatProductionModifiers 	
			(BuildingType, UnitCombatType, Modifier)
SELECT	'BUILDING_3MINTPLUS',	 UnitCombatType, Modifier
FROM Building_UnitCombatProductionModifiers WHERE BuildingType = 'BUILDING_MARKET';

------------------------------	
-- Building_ResourceQuantityRequirements
------------------------------
INSERT INTO Building_ResourceQuantityRequirements 	
			(BuildingType, ResourceType, Cost)
SELECT 'BUILDING_3MINTPLUS', ResourceType, Cost
FROM Building_ResourceQuantityRequirements WHERE BuildingType = 'BUILDING_MARKET';

------------------------------	
-- Building_YieldModifiers
------------------------------
INSERT INTO Building_YieldModifiers 	
			(BuildingType, YieldType, Yield)
SELECT 'BUILDING_3MINTPLUS', YieldType, Yield
FROM Building_YieldModifiers WHERE BuildingType = 'BUILDING_MARKET';

------------------------------	
-- Building_ResourceYieldChanges
------------------------------
INSERT INTO Building_ResourceYieldChanges 	
			(BuildingType, ResourceType, YieldType, Yield)
SELECT 'BUILDING_3MINTPLUS', ResourceType, YieldType, Yield
FROM Building_ResourceYieldChanges  WHERE BuildingType = 'BUILDING_MARKET';

--------------------------------	
-- Civilization_BuildingClassOverrides 
--------------------------------		
INSERT INTO Civilization_BuildingClassOverrides 
		(CivilizationType, 					BuildingClassType, 			BuildingType)
VALUES	('CIVILIZATION_SONGHAI',	'BUILDINGCLASS_MARKET',	'BUILDING_3MINTPLUS');


