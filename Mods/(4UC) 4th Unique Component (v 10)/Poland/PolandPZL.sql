--==========================================================================================================================
-- ARTDEFINES
--==========================================================================================================================	
-- ArtDefine_StrategicView
------------------------------
INSERT INTO ArtDefine_StrategicView 
			(StrategicViewType, 			TileType,	Asset)
VALUES		('ART_DEF_UNIT_3_PZL23', 		'Unit', 	'3UC_sv_PZL23.dds');
------------------------------
-- ArtDefine_UnitInfos
------------------------------		
INSERT INTO ArtDefine_UnitInfos 
			(Type, 							DamageStates,	Formation)
SELECT		('ART_DEF_UNIT_3_PZL23'), 	DamageStates, 	Formation
FROM ArtDefine_UnitInfos WHERE (Type = 'ART_DEF_UNIT_FIGHTER');
------------------------------
-- ArtDefine_UnitInfoMemberInfos
------------------------------
INSERT INTO ArtDefine_UnitInfoMemberInfos 	
			(UnitInfoType,					UnitMemberInfoType,					NumMembers)
SELECT		('ART_DEF_UNIT_3_PZL23'), 	('ART_DEF_UNIT_MEMBER_3_PZL23'), 	NumMembers
FROM ArtDefine_UnitInfoMemberInfos WHERE (UnitInfoType = 'ART_DEF_UNIT_FIGHTER');
------------------------------
-- ArtDefine_UnitMemberCombats
------------------------------
INSERT INTO ArtDefine_UnitMemberCombats 
			(UnitMemberType,					EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
SELECT		('ART_DEF_UNIT_MEMBER_3_PZL23'),	EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_FIGHTER');
------------------------------
-- ArtDefine_UnitMemberCombatWeapons
------------------------------
INSERT INTO ArtDefine_UnitMemberCombatWeapons	
			(UnitMemberType,					"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
SELECT		('ART_DEF_UNIT_MEMBER_3_PZL23'),	"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
FROM ArtDefine_UnitMemberCombatWeapons WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_FIGHTER');

------------------------------
-- ArtDefine_UnitMemberInfos
------------------------------
INSERT INTO ArtDefine_UnitMemberInfos 	
		(Type, 								Scale, ZOffset, Domain, Model, 						MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT	('ART_DEF_UNIT_MEMBER_3_PZL23'),	Scale, ZOffset, Domain, ('PZL_P.23_Karas.fxsxml'),	MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE (Type = 'ART_DEF_UNIT_MEMBER_FIGHTER');
------------------------------
-- IconTextureAtlasesa
------------------------------
INSERT INTO IconTextureAtlases 
			(Atlas, 									IconSize, 	Filename, 									IconsPerRow, 	IconsPerColumn)
VALUES		('3_POLAND_PILSUDSKI_ATLAS', 				256, 		'3UC_PolandPilsudskiAtlas_256.dds',			2, 				2),
			('3_POLAND_PILSUDSKI_ATLAS', 				128, 		'3UC_PolandPilsudskiAtlas_128.dds',			2, 				2),
			('3_POLAND_PILSUDSKI_ATLAS', 				80, 		'3UC_PolandPilsudskiAtlas_80.dds',			2, 				2),
			('3_POLAND_PILSUDSKI_ATLAS', 				45, 		'3UC_PolandPilsudskiAtlas_45.dds',			2, 				2),
			('3_POLAND_PILSUDSKI_ATLAS', 				64, 		'3UC_PolandPilsudskiAtlas_64.dds',			2, 				2),
			('3_PZL23_FLAG_ART_ATLAS', 				32, 		'3UC_PZL23UnitFlag_32.dds',					1, 				1);
--==========================================================================================================================	

--==========================================================================================================================	
-- PROMOTIONS
--==========================================================================================================================	
-- UnitPromotions
------------------------------
INSERT INTO UnitPromotions 
			(Type, 								Description, 								Help, 											Sound, 				MovesChange,	AttackMod,	DefenseMod, ExperiencePercent,	IgnoreZOC,	LostWithUpgrade,	CannotBeChosen, PortraitIndex, 	IconAtlas, 			PediaType, 			PediaEntry)
VALUES		('PROMOTION_3_PZL23', 			'TXT_KEY_PROMOTION_3_PZL23', 				'TXT_KEY_PROMOTION_3_PZL23_HELP', 			'AS2D_IF_LEVELUP',	0,				0,			0,			0,					0,			0,					1, 				59, 			'ABILITY_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_3_PZL23');
------------------------------
-- UnitPromotions_Domains
------------------------------
INSERT INTO UnitPromotions_Domains
			(PromotionType,					DomainType,					Modifier)
VALUES		('PROMOTION_3_PZL23',			'DOMAIN_LAND',				20);

--==========================================================================================================================	
-- UNITS
--==========================================================================================================================
-- Units
--------------------------------	
INSERT INTO Units 	
			(Class, 	Type, 				PrereqTech, RangedCombat, Range,	AirInterceptRange, Special, Combat, Cost,	FaithCost, RequiresFaithPurchaseEnabled, Moves, Immobile, CombatClass, Domain, DefaultUnitAI, Description, 					Civilopedia, 						Strategy, 								Help, 							 Pillage, MilitarySupport, MilitaryProduction, IgnoreBuildingDefense, Mechanized, AirUnitCap, AdvancedStartCost, RangedCombatLimit, CombatLimit, XPValueDefense, UnitArtInfo, 					UnitFlagIconOffset, UnitFlagAtlas,					PortraitIndex, 	IconAtlas,						MoveRate)
SELECT		Class,		('UNIT_3_PZL23'), PrereqTech, RangedCombat, Range+2,	AirInterceptRange, Special, Combat, Cost,	FaithCost, RequiresFaithPurchaseEnabled, Moves, Immobile, CombatClass, Domain, DefaultUnitAI, ('TXT_KEY_UNIT_3_PZL23'), 	('TXT_KEY_CIV5_3_PZL23_TEXT'), 	('TXT_KEY_UNIT_3_PZL23_STRATEGY'), 	('TXT_KEY_UNIT_HELP_3_PZL23'), Pillage, MilitarySupport, MilitaryProduction, IgnoreBuildingDefense, Mechanized, AirUnitCap, AdvancedStartCost, RangedCombatLimit, CombatLimit, XPValueDefense, ('ART_DEF_UNIT_3_PZL23'), 	0,					('3_PZL23_FLAG_ART_ATLAS'),	3, 				('3_POLAND_PILSUDSKI_ATLAS'),	MoveRate
FROM Units WHERE (Type = 'UNIT_FIGHTER');

--------------------------------	
-- UnitGameplay2DScripts
--------------------------------		
INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 						SelectionSound, FirstSelectionSound)
SELECT		('UNIT_3_PZL23'), 			SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_FIGHTER');	
	
--------------------------------	
-- Unit_AITypes
--------------------------------		
INSERT INTO Unit_AITypes 	
			(UnitType, 					UnitAIType)
SELECT		('UNIT_3_PZL23'), 		UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_FIGHTER');
	
--------------------------------	
-- Unit_ResourceQuantityRequirements
--------------------------------		
INSERT INTO Unit_ResourceQuantityRequirements 	
			(UnitType, 					ResourceType)
SELECT		('UNIT_3_PZL23'), 		ResourceType
FROM Unit_ResourceQuantityRequirements WHERE (UnitType = 'UNIT_FIGHTER');

--------------------------------	
-- Unit_ClassUpgrades
--------------------------------		
INSERT INTO Unit_ClassUpgrades 	
			(UnitType, 					UnitClassType)
SELECT		('UNIT_3_PZL23'), 		UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_FIGHTER');

--------------------------------	
-- Unit_Flavors
--------------------------------		
INSERT INTO Unit_Flavors 	
			(UnitType, 					FlavorType, Flavor)
SELECT		('UNIT_3_PZL23'), 		FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_FIGHTER');

--------------------------------
-- Unit_FreePromotions
--------------------------------
INSERT INTO Unit_FreePromotions 	
			(UnitType, 					PromotionType)
SELECT		('UNIT_3_PZL23'), 		PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_FIGHTER');

INSERT INTO Unit_FreePromotions
			(UnitType, 					PromotionType)
VALUES		('UNIT_3_PZL23', 			'PROMOTION_3_PZL23');

--==========================================================================================================================	
-- CIVILIZATIONS
--==========================================================================================================================	

--------------------------------	
-- Civilization_UnitClassOverrides 
--------------------------------		
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 						UnitClassType, 			UnitType)
VALUES		('CIVILIZATION_POLAND', 	'UNITCLASS_FIGHTER', 	'UNIT_3_PZL23');
--==========================================================================================================================
--==========================================================================================================================