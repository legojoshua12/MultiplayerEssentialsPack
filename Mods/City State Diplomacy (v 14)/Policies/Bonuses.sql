-- Beliefs
	
		-- Reliquary Tweak

UPDATE Beliefs
SET GreatPersonExpendedFaith = 15
WHERE Type = 'BELIEF_RELIQUARY' AND EXISTS (SELECT * FROM CSD WHERE Type='CSD_BONUSES' AND Value= 1 );
 
		-- Charitable Missions Tweak

UPDATE Beliefs
SET CityStateInfluenceModifier = 0
WHERE Type = 'BELIEF_CHARITABLE_MISSIONS' AND EXISTS (SELECT * FROM CSD WHERE Type='CSD_BONUSES' AND Value= 1 );
 
		-- Charitable Missions Tweak (2)

UPDATE Beliefs
SET CityStateMinimumInfluence = 15
WHERE Type = 'BELIEF_CHARITABLE_MISSIONS' AND EXISTS (SELECT * FROM CSD WHERE Type='CSD_BONUSES' AND Value= 1 );
 
		-- Belief Text Changes

UPDATE Language_en_US
SET Text = '+15 to [ICON_INFLUENCE] Influence resting point with City-States following this religion.'
WHERE Tag = 'TXT_KEY_BELIEF_CHARITABLE_MISSIONS' AND EXISTS (SELECT * FROM CSD WHERE Type='CSD_BONUSES' AND Value= 1 );

UPDATE Language_en_US
SET Text = 'Divine Right'
WHERE Tag = 'TXT_KEY_BELIEF_CHARITABLE_MISSIONS_SHORT' AND EXISTS (SELECT * FROM CSD WHERE Type='CSD_BONUSES' AND Value= 1 );

UPDATE Language_en_US
SET Text = 'Gain 15 [ICON_PEACE] Faith each time a Great Person is expended.'
WHERE Tag = 'TXT_KEY_BELIEF_RELIQUARY' AND EXISTS (SELECT * FROM CSD WHERE Type='CSD_BONUSES' AND Value= 1 );

--Sweden Trait (Bonus)

INSERT INTO Trait_FreePromotionUnitCombats 
(TraitType, UnitCombatType, PromotionType)
SELECT 'TRAIT_DIPLOMACY_GREAT_PEOPLE', 'UNITCOMBAT_DIPLOMACY', 'PROMOTION_NOBEL_LAUREATE'
WHERE EXISTS (SELECT * FROM CSD WHERE Type='SWEDEN_TRAIT' AND Value= 1);

--Sweden Trait (Bonus Text)
UPDATE Language_en_US
SET Text = 'Starts with the Nobel Laureate promotion, which grants +20% [ICON_INFLUENCE] Influence from Diplomatic Missions. When declaring friendship, Sweden and friend gain +10% Great Person generation.'
WHERE Tag = 'TXT_KEY_TRAIT_DIPLOMACY_GREAT_PEOPLE'
AND EXISTS (SELECT * FROM CSD WHERE Type='SWEDEN_TRAIT' AND Value = 1 );

--Sweden Trait (Very Easy)
UPDATE Traits
SET GreatPersonGiftInfluence = 40
WHERE Type = 'TRAIT_DIPLOMACY_GREAT_PEOPLE'
AND EXISTS (SELECT * FROM CSD WHERE Type='SWEDEN_TRAIT' AND Value= 3 ) AND EXISTS (SELECT * FROM CSD WHERE Type='USING_GAK' AND Value= 1) ;

--Sweden Trait (Easy)
UPDATE Traits
SET GreatPersonGiftInfluence = 20
WHERE Type = 'TRAIT_DIPLOMACY_GREAT_PEOPLE'
AND EXISTS (SELECT * FROM CSD WHERE Type='SWEDEN_TRAIT' AND Value= 2 ) AND EXISTS (SELECT * FROM CSD WHERE Type='USING_GAK' AND Value= 1);

--Sweden Trait (Normal, Default)
UPDATE Traits
SET GreatPersonGiftInfluence = 0
WHERE Type = 'TRAIT_DIPLOMACY_GREAT_PEOPLE'
AND EXISTS (SELECT * FROM CSD WHERE Type='SWEDEN_TRAIT' AND Value= 1 ) AND EXISTS (SELECT * FROM CSD WHERE Type='USING_GAK' AND Value= 1);