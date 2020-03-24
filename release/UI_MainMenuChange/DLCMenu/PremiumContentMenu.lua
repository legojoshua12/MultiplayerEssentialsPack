-------------------------------------------------
-- Premium Content Menu
-------------------------------------------------
include( "InstanceManager" );

g_InstanceManager = InstanceManager:new( "ListingButtonInstance", "Base", Controls.ListingStack );

g_DLCState = {};
--------------------------------------------------
-- Explicit Event Handlers
--------------------------------------------------
function InputHandler( uiMsg, wParam, lParam )

	if(uiMsg == KeyEvents.KeyDown) then

		if wParam == Keys.VK_ESCAPE then
			OnCancel();
		end
	end

	return true;
end
ContextPtr:SetInputHandler(InputHandler);

function OnCancel()
	UIManager:DequeuePopup(ContextPtr);
end
Controls.BackButton:RegisterCallback(Mouse.eLClick, OnCancel);

function OnOK()

	local packages = {}
	for i, v in ipairs(g_DLCState) do
		if(v.Active ~= v.InitiallyActive) then
			table.insert(packages, {
				v.ID,
				ContentType.GAMEPLAY,
				v.Active
			});
		end
    end

    if(#packages > 0) then
		UIManager:SetUICursor(1);
		ContentManager.SetActive(packages);
		UIManager:SetUICursor(0);
    end

    UIManager:DequeuePopup(ContextPtr);
end
Controls.LargeButton:RegisterCallback(Mouse.eLClick, OnOK);

function RefreshDLC()

	g_InstanceManager:ResetInstances();

	g_DLCState = {};
	local packageIDs = ContentManager.GetAllPackageIDs();
	table.insert(packageIDs, "B5932AE4-0F4F-498F-9333-E2D31B20E095")

	for i, v in ipairs(packageIDs) do

		if(not ContentManager.IsUpgrade(v)) then

			local bActive = ContentManager.IsActive(v, ContentType.GAMEPLAY);
			table.insert(g_DLCState, {
				ID = v,
				Description = Locale.Lookup(ContentManager.GetPackageDescription(v)),
				InitiallyActive = bActive,
				Active = bActive
			});
		end
    end

    table.sort(g_DLCState, function(a,b)
		return Locale.Compare(a.Description, b.Description) == -1;
    end);

    local bHasExpansion1 = false;
    local bHasExpansion2 = false;
    local bHasExpansion3 = false;

    for i,v in ipairs(g_DLCState) do

		if(v.ID == "0E3751A1-F840-4E1B-9706-519BF484E59D") then
			bHasExpansion1 = true;

			Controls.Expansion1Title:SetText(v.Description);
			Controls.EnableExpansion1:SetHide(v.Active);
			Controls.DisableExpansion1:SetHide(not v.Active);

			function ToggleExpansion1()
				v.Active = not v.Active;
				Controls.EnableExpansion1:SetHide(v.Active);
				Controls.DisableExpansion1:SetHide(not v.Active);
			end

		else
			if(v.ID == "6DA07636-4123-4018-B643-6575B4EC336B") then
				bHasExpansion2 = true;

				Controls.Expansion2Title:SetText(v.Description);
				Controls.EnableExpansion2:SetHide(v.Active);
				Controls.DisableExpansion2:SetHide(not v.Active);

				function ToggleExpansion2()
					v.Active = not v.Active;
					Controls.EnableExpansion2:SetHide(v.Active);
					Controls.DisableExpansion2:SetHide(not v.Active);
				end

			else
				if(v.ID == "B5932AE4-0F4F-498F-9333-E2D31B20E095") then
					bHasExpansion3 = true;
					v.Active = bHasExpansion3;

					Controls.Expansion3Title:SetText(v.Description);
					Controls.EnableExpansion3:SetHide(v.Active);
					Controls.DisableExpansion3:SetHide(not v.Active);

					function ToggleExpansion3()
						v.Active = not v.Active;
						Controls.EnableExpansion3:SetHide(v.Active);
						Controls.DisableExpansion3:SetHide(not v.Active);
					end

				else
					local controlTable = g_InstanceManager:GetInstance();
					controlTable.PackageName:SetText(v.Description);

					controlTable.EnableDLC:SetHide(v.Active);
					controlTable.DisableDLC:SetHide(not v.Active);

					function ToggleDLC()
						v.Active = not v.Active;
						controlTable.EnableDLC:SetHide(v.Active);
						controlTable.DisableDLC:SetHide(not v.Active);
					end
				end
			end
		end
    end

    Controls.Expansion1Panel:SetHide(not bHasExpansion1);
    Controls.Expansion2Panel:SetHide(not bHasExpansion2);
    Controls.Expansion3Panel:SetHide(not bHasExpansion3);

	Controls.ListingStack:CalculateSize();
	Controls.ListingStack:ReprocessAnchoring();
	Controls.ListingScrollPanel:CalculateInternalSize();
end

function ShowHideHandler( bIsHide, bIsInit )
    if( not bIsHide ) then
		RefreshDLC();
	end
end
ContextPtr:SetShowHideHandler( ShowHideHandler );

RefreshDLC();
