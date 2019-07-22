--==============================================================================================
-- UNITS
--==============================================================================================
INSERT INTO UnitClasses
			(Type,						Description,				DefaultUnit)
VALUES		('UNITCLASS_MED_SETTLER',	'TXT_KEY_UNIT_SETTLER',		'NONE');

INSERT INTO UnitClasses
			(Type,						Description,				DefaultUnit)
VALUES		('UNITCLASS_IND_SETTLER',	'TXT_KEY_UNIT_SETTLER',		'NONE');

INSERT INTO UnitClasses
			(Type,						Description,				DefaultUnit)
VALUES		('UNITCLASS_ATO_SETTLER',	'TXT_KEY_UNIT_SETTLER',		'NONE');

INSERT INTO Units
			(Class,						Type, 					PrereqTech,				Combat, RangedCombat,	Cost, 	Range,	Found,	FaithCost, 	RequiresFaithPurchaseEnabled, Moves, HurryCostModifier,	CombatClass,			Domain, DefaultUnitAI, Description, 					Civilopedia, 	Strategy, 	Help, MilitarySupport, MilitaryProduction, Pillage, ObsoleteTech,			AdvancedStartCost, GoodyHutUpgradeUnitClass, CombatLimit,	XPValueAttack,	XPValueDefense, Conscription, UnitArtInfo, 					UnitFlagAtlas, 		UnitFlagIconOffset, PortraitIndex, 	IconAtlas, 			MoveRate)
SELECT		('UNITCLASS_MED_SETTLER'), 	('UNIT_ORSETTLER_MED'), ('TECH_CIVIL_SERVICE'),	9,		15,				Cost, 	2,		Found,	FaithCost, 	RequiresFaithPurchaseEnabled, 3,	 HurryCostModifier,	('UNITCOMBAT_ARCHER'),	Domain, DefaultUnitAI, ('TXT_KEY_UNIT_SETTLER_MED'),	Civilopedia, 	Strategy,	Help, MilitarySupport, MilitaryProduction, Pillage, ('TECH_FERTILIZER'),	AdvancedStartCost, ('UNITCLASS_IND_SETTLER'), 100,			3,				3,				Conscription, ('ART_DEF_UNIT_ORSETTLER'), 	('OR_ALPHA_ATLAS'), 2,					2,				('OR_COLOR_ATLAS'),	MoveRate		
FROM Units WHERE (Type = 'UNIT_ORSETTLER');

INSERT INTO Units
			(Class,						Type, 					PrereqTech,				Combat, RangedCombat,	Cost, 	Range,	Found,	FaithCost, 	RequiresFaithPurchaseEnabled, Moves, HurryCostModifier,	CombatClass,			Domain, DefaultUnitAI, Description, 					Civilopedia, 	Strategy, 	Help, MilitarySupport, MilitaryProduction, Pillage, ObsoleteTech,			AdvancedStartCost, GoodyHutUpgradeUnitClass, CombatLimit,	XPValueAttack,	XPValueDefense, Conscription, UnitArtInfo, 					UnitFlagAtlas, 		UnitFlagIconOffset, PortraitIndex, 	IconAtlas, 			MoveRate)
SELECT		('UNITCLASS_IND_SETTLER'), 	('UNIT_ORSETTLER_IND'), ('TECH_FERTILIZER'),	16,		20,				Cost, 	2,		Found,	FaithCost, 	RequiresFaithPurchaseEnabled, 3,	 HurryCostModifier,	('UNITCOMBAT_ARCHER'),	Domain, DefaultUnitAI, ('TXT_KEY_UNIT_SETTLER_IND'),	Civilopedia, 	Strategy,	Help, MilitarySupport, MilitaryProduction, Pillage, ('TECH_ECOLOGY'),		AdvancedStartCost, ('UNITCLASS_ATO_SETTLER'), 100,			3,				3,				Conscription, ('ART_DEF_UNIT_ORSETTLER'), 	('OR_ALPHA_ATLAS'), 2,					2,				('OR_COLOR_ATLAS'),	MoveRate		
FROM Units WHERE (Type = 'UNIT_ORSETTLER');

INSERT INTO Units
			(Class,						Type, 					PrereqTech,				Combat, RangedCombat,	Cost, 	Range,	Found,	FaithCost, 	RequiresFaithPurchaseEnabled, Moves, HurryCostModifier,	CombatClass,			Domain, DefaultUnitAI, Description, 					Civilopedia, 	Strategy, 	Help, MilitarySupport, MilitaryProduction, Pillage, ObsoleteTech,			AdvancedStartCost, GoodyHutUpgradeUnitClass, CombatLimit,	XPValueAttack,	XPValueDefense, Conscription, UnitArtInfo, 					UnitFlagAtlas, 		UnitFlagIconOffset, PortraitIndex, 	IconAtlas, 			MoveRate)
SELECT		('UNITCLASS_ATO_SETTLER'), 	('UNIT_ORSETTLER_ATO'), ('TECH_ECOLOGY'),		24,		26,				Cost, 	2,		Found,	FaithCost, 	RequiresFaithPurchaseEnabled, 4,	 HurryCostModifier,	('UNITCOMBAT_ARCHER'),	Domain, DefaultUnitAI, ('TXT_KEY_UNIT_SETTLER_ATO'),	Civilopedia, 	Strategy,	Help, MilitarySupport, MilitaryProduction, Pillage, ObsoleteTech,			AdvancedStartCost, GoodyHutUpgradeUnitClass, 100,			3,				3,				Conscription, ('ART_DEF_UNIT_ORSETTLER'), 	('OR_ALPHA_ATLAS'), 2,					2,				('OR_COLOR_ATLAS'),	MoveRate		
FROM Units WHERE (Type = 'UNIT_ORSETTLER');


--------------------------------
-- UnitGameplay2DScripts
--------------------------------	
INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 					SelectionSound, FirstSelectionSound)
SELECT		('UNIT_ORSETTLER_MED'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_SETTLER');

INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 					SelectionSound, FirstSelectionSound)
SELECT		('UNIT_ORSETTLER_IND'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_SETTLER');	

INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 					SelectionSound, FirstSelectionSound)
SELECT		('UNIT_ORSETTLER_ATO'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_SETTLER');

	
--------------------------------
-- Unit_AITypes
--------------------------------	
INSERT INTO Unit_AITypes 	
			(UnitType, 				UnitAIType)
VALUES		('UNIT_ORSETTLER_MED', 'UNITAI_SETTLE'),
			('UNIT_ORSETTLER_IND', 'UNITAI_SETTLE'),
			('UNIT_ORSETTLER_ATO', 'UNITAI_SETTLE');

--------------------------------
-- Unit_Flavors
--------------------------------	
INSERT INTO Unit_Flavors 	
			(UnitType, 				FlavorType,	Flavor)
SELECT		('UNIT_ORSETTLER_MED'), FlavorType,	Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_SETTLER');	

INSERT INTO Unit_Flavors 	
			(UnitType, 				FlavorType,	Flavor)
SELECT		('UNIT_ORSETTLER_IND'), FlavorType,	Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_SETTLER');

INSERT INTO Unit_Flavors 	
			(UnitType, 				FlavorType,	Flavor)
SELECT		('UNIT_ORSETTLER_ATO'), FlavorType,	Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_SETTLER');

--------------------------------
-- Unit_FreePromotions
--------------------------------	
	
INSERT INTO Unit_FreePromotions 
			(UnitType, 				PromotionType)
VALUES		('UNIT_ORSETTLER_MED',	'PROMOTION_WITHDRAW_BEFORE_MELEE'),
			('UNIT_ORSETTLER_MED', 	'PROMOTION_ONLY_DEFENSIVE'),
			('UNIT_ORSETTLER_IND',	'PROMOTION_WITHDRAW_BEFORE_MELEE'),
			('UNIT_ORSETTLER_IND', 	'PROMOTION_ONLY_DEFENSIVE'),
			('UNIT_ORSETTLER_IND', 	'PROMOTION_ACCURACY_1'),
			('UNIT_ORSETTLER_ATO',	'PROMOTION_WITHDRAW_BEFORE_MELEE'),
			('UNIT_ORSETTLER_ATO', 	'PROMOTION_ONLY_DEFENSIVE'),
			('UNIT_ORSETTLER_ATO', 	'PROMOTION_ACCURACY_1'),
			('UNIT_ORSETTLER_ATO', 	'PROMOTION_BARRAGE_1');

--------------------------------
-- Unit_ClassUpgrades
--------------------------------	

INSERT INTO Unit_ClassUpgrades
			(UnitType, 				UnitClassType)
VALUES		('UNIT_ORSETTLER_MED',	'UNITCLASS_IND_SETTLER'),
			('UNIT_ORSETTLER_IND',	'UNITCLASS_ATO_SETTLER');
