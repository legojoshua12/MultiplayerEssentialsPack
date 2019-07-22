-- OR Events and Decisions Support

INSERT INTO DecisionsAddin_Support (FileName) VALUES ('EDSupport.lua');

---------------------------------------------------------------
--WAR BONUS
---------------------------------------------------------------
INSERT INTO BuildingClasses 
			(Type,									DefaultBuilding,						Description) 
VALUES		('BUILDINGCLASS_DECISIONS_ORCIVILWAR',	'BUILDING_DECISIONS_ORCIVILWAR',		'TXT_KEY_BUILDING_DECISIONS_ORCIVILWAR_DESC');

INSERT INTO Buildings
			(Type,								BuildingClass,							NeverCapture,	Cost,	FaithCost,	GreatWorkCount,	IconAtlas,				PortraitIndex,	Description,									MinAreaSize) 
VALUES		('BUILDING_DECISIONS_ORCIVILWAR',	'BUILDINGCLASS_DECISIONS_ORCIVILWAR',	1,				-1,		-1,			-1,				'OR_COLOR_ATLAS',		1,				'TXT_KEY_BUILDING_DECISIONS_ORCIVILWAR_DESC',	-1);

INSERT INTO Building_ResourceQuantity 
			(BuildingType,						ResourceType,		Quantity)
VALUES		('BUILDING_DECISIONS_ORCIVILWAR',	'RESOURCE_HORSE',	2);

---------------------------------------------------------------
--ENACT ECOLOGY
---------------------------------------------------------------
INSERT INTO Policies
			(Type,					Description)
VALUES		('POLICY_ORECOLOGY',	'TXT_KEY_POLICY_ORECOLOGY');

INSERT INTO Policy_ImprovementYieldChanges
			(PolicyType,			ImprovementType,				YieldType,			Yield)
VALUES		('POLICY_ORECOLOGY',	'IMPROVEMENT_LUMBERMILL',		'YIELD_CULTURE',	2),
			('POLICY_ORECOLOGY',	'IMPROVEMENT_FISHING_BOATS',	'YIELD_CULTURE',	2);