--Settler Art Defines
INSERT INTO ArtDefine_UnitInfos(Type, DamageStates, Formation)
  VALUES ('ART_DEF_UNIT_ORSETTLER', 1, 'ChariotElephant');

INSERT INTO ArtDefine_UnitInfoMemberInfos(UnitInfoType, UnitMemberInfoType, NumMembers)
  VALUES ('ART_DEF_UNIT_ORSETTLER', 'ART_DEF_UNIT_MEMBER_ORSETTLER', 2);

INSERT INTO ArtDefine_UnitMemberInfos(Type, Scale, Model, MaterialTypeTag, MaterialTypeSoundOverrideTag)
  VALUES ('ART_DEF_UNIT_MEMBER_ORSETTLER', 0.12, 'Art/UnitArt/SupplyTrain.fxsxml', 'CLOTH', 'WOODSM');

INSERT INTO ArtDefine_UnitMemberCombats(UnitMemberType, EnableActions, ShortMoveRadius, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasStationaryMelee, HasRefaceAfterCombat, ReformBeforeCombat, OnlyTurnInMovementActions)
  VALUES ('ART_DEF_UNIT_MEMBER_ORSETTLER', 'Idle Attack RunCharge AttackCity Bombard Death BombardDefend Run Fortify CombatReady Walk', 24.0, 0.349999994039536, 0.5, 0.75, 15.0, 20.0, 12.0, 1, 1, 1, 1, 1, 1);

INSERT INTO ArtDefine_UnitMemberCombatWeapons(UnitMemberType, "Index", SubIndex, WeaponTypeTag, WeaponTypeSoundOverrideTag, MissTargetSlopRadius)
  VALUES ('ART_DEF_UNIT_MEMBER_ORSETTLER', 0, 0, 'ARROW', 'ARROW', 10.0);

INSERT INTO ArtDefine_UnitMemberCombatWeapons(UnitMemberType, "Index", SubIndex, VisKillStrengthMin, VisKillStrengthMax, WeaponTypeTag, MissTargetSlopRadius)
  VALUES ('ART_DEF_UNIT_MEMBER_ORSETTLER', 1, 0, 10.0, 20.0, 'FLAMING_ARROW', 10.0);

INSERT INTO ArtDefine_StrategicView(StrategicViewType, TileType, Asset)
  VALUES ('ART_DEF_UNIT_ORSETTLER', 'Unit', 'SV_ORsettler.dds');