--------------------------------------------------------------------------------------------------
--Improvements 
--------------------------------------------------------------------------------------------------
INSERT INTO Improvements (Type,		DestroyedWhenPillaged,	OutsideBorders,	Description,						Help,											Civilopedia,									ArtDefineTag,						IconAtlas,			PortraitIndex,	 SpecificCivRequired,	 CivilizationType)
SELECT 'IMPROVEMENT_PLANT_FOREST_3UC',	1,						0,				'TXT_KEY_IMPROVEMENT_PLANT_FOREST_3UC',	'TXT_KEY_CIV5_IMPROVEMENTS_PLANT_FOREST_HELP_3UC',	'TXT_KEY_CIV5_IMPROVEMENTS_PLANT_FOREST_TEXT_3UC',	'ART_DEF_IMPROVEMENT_PLANT_FOREST_3UC',	'REFOREST_ATLAS_3UC',	0,				'true',					 'CIVILIZATION_IROQUOIS';

--------------------------------------------------------------------------------------------------
--Improvement Yields
--------------------------------------------------------------------------------------------------
INSERT INTO Improvement_Yields (ImprovementType,		YieldType,				Yield)
SELECT 'IMPROVEMENT_PLANT_FOREST_3UC',						'YIELD_PRODUCTION',		1;

--------------------------------------------------------------------------------------------------
--Improvement Terrains
--------------------------------------------------------------------------------------------------
INSERT INTO Improvement_ValidTerrains (ImprovementType,	TerrainType)
SELECT 'IMPROVEMENT_PLANT_FOREST_3UC',						'TERRAIN_PLAINS' UNION ALL
SELECT 'IMPROVEMENT_PLANT_FOREST_3UC',						'TERRAIN_GRASS' UNION ALL
SELECT 'IMPROVEMENT_PLANT_FOREST_3UC',						'TERRAIN_TUNDRA';

--------------------------------------------------------------------------------------------------
--Improvement Features
--------------------------------------------------------------------------------------------------
INSERT INTO Improvement_ValidFeatures (ImprovementType,	FeatureType)
SELECT 'IMPROVEMENT_PLANT_FOREST_3UC',						'FEATURE_MARSH';

--------------------------------------------------------------------------------------------------
--Improvement Features
--------------------------------------------------------------------------------------------------
INSERT INTO Improvement_Flavors (ImprovementType,		FlavorType,				Flavor)
SELECT 'IMPROVEMENT_PLANT_FOREST_3UC',						'FLAVOR_PRODUCTION',	20;

--------------------------------------------------------------------------------------------------
--Builds 
--------------------------------------------------------------------------------------------------
INSERT INTO Builds (Type,	PrereqTech,				Time,	ImprovementType,			Description,			Help,							Recommendation,				EntityEvent,				HotKey,		OrderPriority,	IconAtlas,						IconIndex)
SELECT 'BUILD_FOREST_3UC',		'TECH_AGRICULTURE',		900,	'IMPROVEMENT_PLANT_FOREST_3UC',	'TXT_KEY_BUILD_FOREST_3UC',	'TXT_KEY_BUILD_FOREST_HELP_3UC',	'TXT_KEY_BUILD_FOREST_REC_3UC',	'ENTITY_EVENT_IRRIGATE',	'KB_F',		37,				'UNIT_ACTION_REFOREST_ATLAS_3UC',	0;

--------------------------------------------------------------------------------------------------
--Build Features 
--------------------------------------------------------------------------------------------------
INSERT INTO BuildFeatures (BuildType,	FeatureType,		PrereqTech,				Time,   Production,	Remove)
SELECT 'BUILD_FOREST_3UC',					'FEATURE_FOREST',	'TECH_FUTURE_TECH',		9900,	40,			1 UNION ALL
SELECT 'BUILD_FOREST_3UC',					'FEATURE_MARSH',	'TECH_MASONRY',		900,	0,			1 UNION ALL
SELECT 'BUILD_FOREST_3UC',					'FEATURE_JUNGLE',	'TECH_FUTURE_TECH',		9900,	0,			1;

--------------------------------------------------------------------------------------------------
--Unit Builds 
--------------------------------------------------------------------------------------------------
INSERT INTO Unit_Builds (UnitType,	BuildType) 
SELECT	Type, 'BUILD_FOREST_3UC'
FROM Units WHERE Class = 'UNITCLASS_WORKER';

--------------------------------------------------------------------------------------------------
--Icon Atlas 
--------------------------------------------------------------------------------------------------
INSERT INTO IconTextureAtlases (Atlas,	IconSize,	IconsPerRow,	IconsPerColumn,	Filename)
SELECT 'REFOREST_ATLAS_3UC',				256,		1,				1,				'ForestAtlas256.dds' UNION ALL
SELECT 'REFOREST_ATLAS_3UC',				64,			1,				1,				'ForestAtlas64.dds' UNION ALL
SELECT 'UNIT_ACTION_REFOREST_ATLAS_3UC',	64,			1,				1,				'UnitAction64_Forest.dds' UNION ALL
SELECT 'UNIT_ACTION_REFOREST_ATLAS_3UC',	45,			1,				1,				'UnitAction45_Forest.dds';

--------------------------------------------------------------------------------------------------
--Artdefines
-------------------------------------------------------------------------------------------------- 
INSERT INTO ArtDefine_StrategicView (StrategicViewType, TileType,			Asset)
SELECT 'ART_DEF_IMPROVEMENT_PLANT_FOREST_3UC',				'Improvement',		'SV_PlantForest.dds';

INSERT INTO ArtDefine_LandmarkTypes (Type,				LandmarkType,		FriendlyName)
SELECT 'ART_DEF_IMPROVEMENT_PLANT_FOREST_3UC',				'Improvement',		'PlantForest';

INSERT INTO ArtDefine_Landmarks (Era,	State,					Scale,	ImprovementType,					LayoutHandler,	ResourceType,				Model,								TerrainContour)
SELECT 'Any',							'UnderConstruction',	0.86,	'ART_DEF_IMPROVEMENT_PLANT_FOREST_3UC', 'SNAPSHOT',		'ART_DEF_RESOURCE_NONE',	'HB_Plantation_MID_Incense.fxsxml', 1 UNION ALL
SELECT 'Any',							'Constructed',			0.86,	'ART_DEF_IMPROVEMENT_PLANT_FOREST_3UC', 'SNAPSHOT',		'ART_DEF_RESOURCE_NONE',	'Plantation_MID_Incense.fxsxml',	1 UNION ALL
SELECT 'Any',							'Pillaged',				0.86,	'ART_DEF_IMPROVEMENT_PLANT_FOREST_3UC', 'SNAPSHOT',		'ART_DEF_RESOURCE_NONE',	'PL_Plantation_MID_Incense.fxsxml', 1;

-------------------------------------------------------------------------------------------------- 
--Compatibility
-------------------------------------------------------------------------------------------------- 
CREATE TRIGGER ReforestationMod_01
AFTER INSERT ON Units
WHEN NEW.Class = 'UNITCLASS_WORKER' 
BEGIN
	INSERT INTO Unit_Builds (NEW.Type,	'BUILD_FOREST_3UC')
END;