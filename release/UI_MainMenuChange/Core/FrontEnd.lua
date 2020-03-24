-- modified by Temudjin from 1.0.3.142 code
-------------------------------------------------
-- FrontEnd
-------------------------------------------------

local tValidBGs = {
    "Angkor.dds",
    "Borobudur.dds",
    "BusyStreet.dds",
    "Djenne.dds",
    "FasilGhebbi.dds",
    "Galileo.dds",
    "Himeiji.dds",
    "Hubble.dds",
    "Ideology.dds",
    "Kronborg.dds",
    "Maps.dds",
    "MotherlandCall.dds",
    "OverviewEarth.dds",
    "Parthenon.dds",
    "Petra.dds",
    "Pharos.dds",
    "RedFort.dds",
    "RedSquare.dds",
    "Sistine.dds",
    "Smithsonian.dds",
    "Topkapi.dds",
    "Torre.dds",
    "UN.dds",
    "WarsFought.dds",
}

local iCurrentBG = math.random(#tValidBGs)
local bRandomWallpaperOnLoad = Modding.GetSystemProperty("bRandomWallpaperOnLoad") == "1"
if bRandomWallpaperOnLoad then

    local sBG = Modding.GetSystemProperty("CurrentBG")
    if not sBG or sBG == "" then sBG = "1" end
    iCurrentBG = tonumber(sBG)

    if not tValidBGs[iCurrentBG] then iCurrentBG = 1; sBG = "1" end

    Modding.SetSystemProperty("CurrentBG", sBG)

else
    Modding.SetSystemProperty("CurrentBG", tostring(iCurrentBG))
end

-------------------------------------------------
-- Suk_ChangeBackground
-------------------------------------------------
LuaEvents.Suk_ChangeBackground.Add(function(iDelta)

    Controls.AtlasLogo:SetTexture(tValidBGs[iCurrentBG])

    iCurrentBG = iCurrentBG + iDelta
    if iCurrentBG > #tValidBGs then iCurrentBG = 1 end
    if iCurrentBG < 1 then iCurrentBG = #tValidBGs end

    Modding.SetSystemProperty("CurrentBG", tostring(iCurrentBG))

    Controls.AtlasAnim:SetToBeginning()
    Controls.AtlasLogo2:SetTexture(tValidBGs[iCurrentBG])
    Controls.AtlasAnim:Play()
end)

function ShowHideHandler( bIsHide, bIsInit )

        -- Check for game invites first.  If we have a game invite, we will have flipped
        -- the Civ5App::eHasShownLegal and not show the legal/touch screens.
        UI:CheckForCommandLineInvitation();

---------- Temudjin START
--    if not UI:HasShownLegal() then
--        UIManager:QueuePopup( Controls.LegalScreen, PopupPriority.LegalScreen );
--    end
---------- Temudjin END

    if not bIsHide then
        Controls.AtlasLogo:SetTexture(tValidBGs[iCurrentBG])
        Controls.AtlasLogo2:SetTexture(tValidBGs[iCurrentBG])

        UIManager:QueuePopup( Controls.MainMenu, PopupPriority.MainMenu );
        UIManager:SetUICursor( 0 );
    else
        Controls.AtlasLogo:UnloadTexture();
    end
end
ContextPtr:SetShowHideHandler( ShowHideHandler );
