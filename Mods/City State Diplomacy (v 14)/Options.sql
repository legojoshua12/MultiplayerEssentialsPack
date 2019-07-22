CREATE TABLE IF NOT EXISTS CSD (
Type text,
Value variant default 0
);

/*

_______________OPTIONS FOR CSD____________________
Thank you for downloading City-State Diplomacy Mod!
All options below are preset to the default values of this mod.

Thanks:
-Thalassicus for help with SQL
-Seek for artwork and consulation
-The denizens of Civfanatics for supporting CSD and offering sage advice
-Putmalk for the great AI DLL work

Enjoy,
Gazebo
*/

--IMPORTANT!! PLEASE READ THE FOLLOWING:
 
--To edit the Options.SQL file, do the following steps:
--Scroll down until you see the following text:

/*
Gold Gifting and Gold-Related Quests with City-States On/Off
1 = Gold Gifts Enabled
2 = Gold Gifts Disabled (Default)
*/

--INSERT INTO CSD (Type, Value)
--VALUES ('GIFT_OPTION', 2);

--To enable gold gifts, change the integer after GIFT_OPTION to '1'
--The final code should look like this: 

--Code:
/*
Gold Gifting and Gold-Related Quests with City-States On/Off
1 = Gold Gifts Enabled
2 = Gold Gifts Disabled (Default)
*/

--INSERT INTO CSD (Type, Value)
--VALUES ('GIFT_OPTION', 1);
--Save the file and launch the game!




-- OPTIONS --
-- If you have not read the instructions above, please do so now!



/*
Gold Gifting and Gold-Related Quests with City-States On/Off
1 = Gold Gifts Enabled
2 = Gold Gifts Disabled (Default)
*/

INSERT INTO CSD (Type, Value)
VALUES ('GIFT_OPTION', 2);

/*
Compatibility - CEP
1 = Not using CEP (Default)
2 = Using CEP 
*/

INSERT INTO CSD (Type, Value)
VALUES ('USING_CEP', 1);

/*
Using Whoward Dll
1 = Using Whoward Dll (Default)
2 = Not Using Whoward DLL
*/

INSERT INTO CSD (Type, Value)
VALUES ('USING_DLL', 2);

/*
CSD Unit Gold Hurrying Cost
1 = +40% of Production Value (Default)
2 = +60% of Production Value
3 = +80% of Production Value
4 = Gold Hurrying Disabled
*/

INSERT INTO CSD (Type, Value)
VALUES ('CSD_GOLDHURRY', 1);

/*
CSD Patronage Policy Modifications
1 = Modified Patronage Policies Enabled (Default)
0 = Modified Patronage Policies Disabled
*/

INSERT INTO CSD (Type, Value)
VALUES ('CSD_POLICIES', 1);

/*
CSD AI (not the DLL!)
1 = Core AI Tweaks Enabled (Default)
2 = Core AI Tweaks Disabled
*/

INSERT INTO CSD (Type, Value)
VALUES ('CSD_AI', 1);

/*
CSD Gameplay Text
1 = Core Gameplay Text Enabled (Default)
2 = Core Gameplay Text Disabled
*/

INSERT INTO CSD (Type, Value)
VALUES ('CSD_TEXT', 1);

/*
CSD Beliefs and Traits
1 = Beliefs and Traits Enabled (Default)
2 = Beliefs and Traits Disabled
*/

INSERT INTO CSD (Type, Value)
VALUES ('CSD_BONUSES', 1);

/*
Fix for Mausoleum of Halicarnassus (Wonders of the Ancient World DLC)
1 = Fix Enabled (Default)
2 = Fix Disabled 
*/

INSERT INTO CSD (Type, Value)
VALUES ('ANCIENT_WONDERS', 1);

/*
Sweden Trait Modification (G&K + Brave New World)
To compensate, Swedish Diplomatic Units have the Nobel Laureate Promotion which grants 20% more Influence from Diplomatic Missions.
3 = 40 Influence When Gifting Great People (Very Easy)
2 = 20 Influence When Gifting Great People (Easy)
1 = 0 Influence When Gifting Great People (Normal, Default)
0 = 90 Influence Per Mission (Vanilla- Not Recommended)
*/

INSERT INTO CSD (Type, Value)
VALUES ('SWEDEN_TRAIT', 1);

/*
Diplomatic Unit Influence - Base Gain (Brave New World)
3 = 60 Influence Per Great Merchant Mission (Easy)
2 = 50 Influence Per Great Merchant Mission (Normal, Default)
1 = 40 Influence Per Great Merchant Mission (Hard)
0 = 30 Influence Per Great Merchant Mission (Vanilla)
*/

INSERT INTO CSD (Type, Value)
VALUES ('TRADE_MISSION', 2);

/*
City-State Gold Gifting Gold:Influence Ratio
Note: The higher the number, the less influence you will earn per gold gift as the game progresses. 
3 = 24 (Hard)
2 = 18 (Normal, Default)
1 = 12 Influence Per Mission (Easy)
0 = 6.3 Influence Per Mission (Very Easy, Vanilla)
*/

INSERT INTO CSD (Type, Value)
VALUES ('INFLUENCE_RATIO', 2);

/*
Small Gold Gift Cost
3 = 800 Gold (Higher)
2 = 600 Gold (Normal, Default)
1 = 400 Gold (Lower)
0 = 250 Gold (Vanilla)
*/

INSERT INTO CSD (Type, Value)
VALUES ('GIFT_SMALL', 2);

/*
Medium Gold Gift Cost
3 = 1300 Gold (Higher)
2 = 1000 Gold (Normal, Default)
1 = 700 Gold (Lower)
0 = 500 Gold (Vanilla)
*/

INSERT INTO CSD (Type, Value)
VALUES ('GIFT_MEDIUM', 2);

/*
Large Gold Gift Cost
3 = 2500 Gold (Higher)
2 = 2000 Gold (Normal, Default)
1 = 1500 Gold (Lower)
0 = 1000 Gold (Vanilla)
*/

INSERT INTO CSD (Type, Value)
VALUES ('GIFT_LARGE', 2);














---------------------- DO NOT MODIFY THESE ----------------------------



/*
Gods and Kings and Brave New World Expansion Compatibility - DO NOT MODIFY THIS VALUE
1 = Using Gods and Kings Expansion (default)
0 = DO NOT USE
*/

INSERT INTO CSD (Type, Value)
VALUES ('USING_GAK', 1);

/*
Diplomatic Unit Influence Gain (Vanilla Civ V - DO NOT MODIFY)
3 = 60 Influence Per Mission (Easy)
2 = 50 Influence Per Mission (Normal, Default)
1 = 40 Influence Per Mission (Hard)
0 = 30 Influence Per Mission (Vanilla)
*/

INSERT INTO CSD (Type, Value)
VALUES ('TRADE_MISSION_VANILLA', 2);