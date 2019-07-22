-- Lua Script1
-- Author: Machiavelli
-- DateCreated: 9/21/2013 9:30:12 PM
--------------------------------------------------------------
function GreatMerchantBorn(playerID, unitID, hexVec, unitType, cultureType, civID, primaryColor, secondaryColor, unitFlagIndex, fogState, selected, military, notInvisible)
	local player = Players[playerID];
	local unit = player:GetUnitByID(unitID);

	-- Only continue if the unit is a great merchant
	if(unit:GetUnitClassType() == GameInfoTypes["UNITCLASS_MERCHANT"]) then
		-- Get promotion for the era
		local promotionID = GetGreatMerchantPromotionForEra(player:GetCurrentEra());
		-- Give the promotion to the merchant
		unit:SetHasPromotion(promotionID, true);
	end
end
LuaEvents.SerialEventUnitCreatedGood.Add(GreatMerchantBorn);

function EraChanged(era, playerID)
	local player = Players[playerID];

	-- Only continue if the player a major civ
	if(player:IsAlive() and not player:IsMinorCiv() and not player:IsBarbarian()) then
		-- Get the promotion for the current era
		local promotionID = GetGreatMerchantPromotionForEra(era);

		-- Loop over all the units the player has
		for unit in player:Units() do
			if(unit:GetUnitClassType() == GameInfoTypes["UNITCLASS_MERCHANT"]) then
				-- Give the current era promotion
				unit:SetHasPromotion(promotionID, true);

				for index = 0, era - 1, 1 do
					unit:SetHasPromotion(GetGreatMerchantPromotionForEra(index), false);
				end
			end
		end

	end
end
Events.SerialEventEraChanged.Add(EraChanged);

-- Helper function
function GetGreatMerchantPromotionForEra(era)
	-- Default: assume era == 0
	local promotionID = GameInfoTypes["PROMOTION_SCALING_MERCHANT_ANCIENT"];

	if(era == 1) then
		promotionID = GameInfoTypes["PROMOTION_SCALING_MERCHANT_CLASSICAL"];
	elseif(era == 2) then
		promotionID = GameInfoTypes["PROMOTION_SCALING_MERCHANT_MEDIEVAL"];
	elseif(era == 3) then
		promotionID = GameInfoTypes["PROMOTION_SCALING_MERCHANT_RENAISSANCE"];
	elseif(era == 4) then
		promotionID = GameInfoTypes["PROMOTION_SCALING_MERCHANT_INDUSTRIAL"];
	elseif(era == 5) then
		promotionID = GameInfoTypes["PROMOTION_SCALING_MERCHANT_MODERN"];
	elseif(era == 6) then
		promotionID = GameInfoTypes["PROMOTION_SCALING_MERCHANT_POSTMODERN"];
	elseif(era >= 7) then
		promotionID = GameInfoTypes["PROMOTION_SCALING_MERCHANT_FUTURE"];
	end

	return promotionID;
end