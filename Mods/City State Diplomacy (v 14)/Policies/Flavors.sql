-- Technology Flavors

INSERT INTO Technology_Flavors
(TechType, FlavorType, Flavor)
SELECT 'TECH_PHILOSOPHY', 'FLAVOR_DIPLOMACY', '5'
WHERE EXISTS (SELECT * FROM CSD WHERE Type='CSD_AI' AND Value= 1 );

INSERT INTO Technology_Flavors
(TechType, FlavorType, Flavor)
SELECT 'TECH_MATHEMATICS', 'FLAVOR_DIPLOMACY', '5'
WHERE EXISTS (SELECT * FROM CSD WHERE Type='CSD_AI' AND Value= 1 );

INSERT INTO Technology_Flavors
(TechType, FlavorType, Flavor)
SELECT 'TECH_CURRENCY', 'FLAVOR_DIPLOMACY', '5'
WHERE EXISTS (SELECT * FROM CSD WHERE Type='CSD_AI' AND Value= 1 );

INSERT INTO Technology_Flavors
(TechType, FlavorType, Flavor)
SELECT 'TECH_ASTRONOMY', 'FLAVOR_DIPLOMACY', '5'
WHERE EXISTS (SELECT * FROM CSD WHERE Type='CSD_AI' AND Value= 1 );

INSERT INTO Technology_Flavors
(TechType, FlavorType, Flavor)
SELECT 'TECH_RAILROAD', 'FLAVOR_DIPLOMACY', '5'
WHERE EXISTS (SELECT * FROM CSD WHERE Type='CSD_AI' AND Value= 1 );

INSERT INTO Technology_Flavors
(TechType, FlavorType, Flavor)
SELECT 'TECH_GUNPOWDER', 'FLAVOR_DIPLOMACY', '5'
WHERE EXISTS (SELECT * FROM CSD WHERE Type='CSD_AI' AND Value= 1 );

INSERT INTO Technology_Flavors
(TechType, FlavorType, Flavor)
SELECT 'TECH_PRINTING_PRESS', 'FLAVOR_DIPLOMACY', '10'
WHERE EXISTS (SELECT * FROM CSD WHERE Type='CSD_AI' AND Value= 1 );

INSERT INTO Technology_Flavors
(TechType, FlavorType, Flavor)
SELECT 'TECH_RIFLING', 'FLAVOR_DIPLOMACY', '10'
WHERE EXISTS (SELECT * FROM CSD WHERE Type='CSD_AI' AND Value= 1 );

INSERT INTO Technology_Flavors
(TechType, FlavorType, Flavor)
SELECT 'TECH_STEAM_POWER', 'FLAVOR_DIPLOMACY', '10'
WHERE EXISTS (SELECT * FROM CSD WHERE Type='CSD_AI' AND Value= 1 );

INSERT INTO Technology_Flavors
(TechType, FlavorType, Flavor)
SELECT 'TECH_ATOMIC_THEORY', 'FLAVOR_DIPLOMACY', '10'
WHERE EXISTS (SELECT * FROM CSD WHERE Type='CSD_AI' AND Value= 1 );

INSERT INTO Technology_Flavors
(TechType, FlavorType, Flavor)
SELECT 'TECH_NUCLEAR_FISSION', 'FLAVOR_DIPLOMACY', '10'
WHERE EXISTS (SELECT * FROM CSD WHERE Type='CSD_AI' AND Value= 1 );