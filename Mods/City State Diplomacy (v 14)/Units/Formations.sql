-- Multi Unit Formations for Diplomatic Units

DELETE FROM MultiUnitFormation_SlotEntries
WHERE MultiUnitPositionType = 'MUPOSITION_FRONT_LINE' AND MultiUnitFormationType = 'MUFORMATION_MERCHANT_ESCORT';

DELETE FROM MultiUnitFormation_SlotEntries
WHERE MultiUnitPositionType = 'UNITAI_DEFENSE' AND MultiUnitFormationType = 'MUFORMATION_MERCHANT_ESCORT';

DELETE FROM MultiUnitFormation_SlotEntries
WHERE MultiUnitPositionType = 'UNITAI_COUNTER' AND MultiUnitFormationType = 'MUFORMATION_MERCHANT_ESCORT';