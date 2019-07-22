-- UnitArtInfo --

INSERT INTO ArtDefine_UnitInfos (
	Type, DamageStates, Formation)
SELECT 'ART_DEF_UNIT_MESSENGER', '1','UnFormed';

INSERT INTO ArtDefine_UnitInfos (
	Type, DamageStates, Formation)
SELECT 'ART_DEF_UNIT_ENVOY', '1','UnFormed';

INSERT INTO ArtDefine_UnitInfos (
	Type, DamageStates, Formation)
SELECT 'ART_DEF_UNIT_DIPLOMAT', '1','UnFormed';

INSERT INTO ArtDefine_UnitInfos (
	Type, DamageStates, Formation)
SELECT 'ART_DEF_UNIT_AMBASSADOR', '1','UnFormed';

-- Unit Members --

INSERT INTO ArtDefine_UnitInfoMemberInfos (
	UnitInfoType, UnitMemberInfoType, NumMembers)
SELECT 'ART_DEF_UNIT_MESSENGER','ART_DEF_UNIT_MEMBER_MISSIONARY_01', '1';

INSERT INTO ArtDefine_UnitInfoMemberInfos (
	UnitInfoType, UnitMemberInfoType, NumMembers)
SELECT 'ART_DEF_UNIT_ENVOY','ART_DEF_UNIT_MEMBER_EUROFEMALE18', '1';

INSERT INTO ArtDefine_UnitInfoMemberInfos (
	UnitInfoType, UnitMemberInfoType, NumMembers)
SELECT 'ART_DEF_UNIT_DIPLOMAT','ART_DEF_UNIT_MEMBER_SETTLERS_ASIAN_F2', '1';

INSERT INTO ArtDefine_UnitInfoMemberInfos (
	UnitInfoType, UnitMemberInfoType, NumMembers)
SELECT 'ART_DEF_UNIT_AMBASSADOR','ART_DEF_UNIT_MEMBER_ARCHAEOLOGIST', '1';