-- Vanilla - National Wonder Building Requirements
INSERT INTO Building_PrereqBuildingClasses (
  BuildingType, BuildingClassType, NumBuildingNeeded)
SELECT 'BUILDING_GUTENBERG_PRESS', 'BUILDINGCLASS_SCRIBE', '-1'
WHERE NOT EXISTS (SELECT * FROM sqlite_master WHERE name='Building_PrereqBuildingClassesPercentage');

INSERT INTO Building_PrereqBuildingClasses (
  BuildingType, BuildingClassType, NumBuildingNeeded)
SELECT 'BUILDING_FOREIGN_OFFICE', 'BUILDINGCLASS_POSTOFFICE', '-1'
WHERE NOT EXISTS (SELECT * FROM sqlite_master WHERE name='Building_PrereqBuildingClassesPercentage');

-- TBC Compatibility - National Wonder Building Requirements
CREATE TABLE IF NOT EXISTS Building_PrereqBuildingClassesPercentage (
  BuildingType text,
  BuildingClassType text,
  PercentBuildingNeeded integer default 0 );

INSERT INTO Building_PrereqBuildingClassesPercentage (
  BuildingType, BuildingClassType, PercentBuildingNeeded)
SELECT 'BUILDING_GUTENBERG_PRESS', 'BUILDINGCLASS_SCRIBE', '75'
WHERE EXISTS (SELECT * FROM CSD WHERE Type='USING_CEP' AND Value = 2 );

INSERT INTO Building_PrereqBuildingClassesPercentage (
  BuildingType, BuildingClassType, PercentBuildingNeeded)
SELECT 'BUILDING_FOREIGN_OFFICE', 'BUILDINGCLASS_POSTOFFICE', '75'
WHERE EXISTS (SELECT * FROM CSD WHERE Type='USING_CEP' AND Value = 2 );

--Halicarnassus Fix
UPDATE Language_en_US
SET Text = 'Empire enters a [ICON_GOLDEN_AGE] Golden Age. Gain 20 [ICON_GOLD] Gold each time a Great Person is expended. Each source of [ICON_RES_MARBLE] Marble or [ICON_RES_STONE] Stone worked by this City produces +2 [ICON_GOLD] Gold.'
WHERE Tag = 'TXT_KEY_WONDER_MAUSOLEUM_HALICARNASSUS_HELP'
AND EXISTS (SELECT * FROM CSD WHERE Type='ANCIENT_WONDERS' AND Value= 1 );

UPDATE Buildings
SET GreatPersonExpendGold = 20
WHERE BuildingClass = 'BUILDINGCLASS_MAUSOLEUM_HALICARNASSUS'
AND EXISTS (SELECT * FROM CSD WHERE Type='ANCIENT_WONDERS' AND Value= 1 );

UPDATE Buildings
SET GoldenAge = 'true'
WHERE BuildingClass= 'BUILDINGCLASS_MAUSOLEUM_HALICARNASSUS' 
AND EXISTS (SELECT * FROM CSD WHERE Type='ANCIENT_WONDERS' AND Value= 1 );