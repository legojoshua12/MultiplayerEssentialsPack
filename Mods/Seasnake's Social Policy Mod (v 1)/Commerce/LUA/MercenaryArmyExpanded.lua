-- MercenaryArmyExpanded
-- Author: Stephen
-- DateCreated: 3/15/2014 5:03:27 PM
--------------------------------------------------------------

-- Adds a negative promotion to former mercenary units when they are upgraded to infantry
function AddForeignFighterPromotion(iPlayer, iUnitID, iX, iY)
	local pPlayer = Players[iPlayer];
	local pUnit = pPlayer:GetUnitByID(iUnitID);
	if pUnit:GetUnitClassType() == GameInfoTypes["UNITCLASS_INFANTRY"] then
		print("Infantry identified");
		local iPromotionID1 = GameInfoTypes["PROMOTION_FOREIGN_LANDS"];
		local iPromotionID2 = GameInfoTypes["PROMOTION_FOREIGN_FIGHTER"];
		if (pUnit:IsHasPromotion(iPromotionID1) == true) then
			print("Is a former mercenary");
			if (pUnit:IsHasPromotion(iPromotionID2) == false) then
				print("Doesn't have promotion");
				pUnit:SetHasPromotion(iPromotionID2, true);
				print("Promotion added");
			end
		end
	end
end

GameEvents.UnitSetXY.Add(AddForeignFighterPromotion);