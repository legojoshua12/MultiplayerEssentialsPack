-- modified by bc1 from 1.0.3.142 code
-- allow game load even when missing mod: by default "saved games" is checked but is actually rarely required
-- allow click to load game directly

do
	local ipairs = ipairs
	local pairs = pairs
	local print = print
	local format = string.format
	local tostring = tostring

	include( "InstanceManager" )
	include( "IconSupport" )
	include( "SupportFunctions" )
	include( "UniqueBonuses" )
	include( "MapUtilities" )
	local GameInfo = EUI.GameInfoCache

	local ContextPtr = ContextPtr
	local Controls = Controls
	local Events = Events
	local Game = Game
	local CIV5_GS_MAINGAMEVIEW = GameStateTypes.CIV5_GS_MAINGAMEVIEW
	local GameTypes = GameTypes
	local IconHookup = IconHookup
	local KeyDown = KeyEvents.KeyDown
	local VK_ESCAPE = Keys.VK_ESCAPE
	local Compare = Locale.Compare
	local L = Locale.ConvertTextKey
	local MapUtilitiesGetBasicInfo = MapUtilities.GetBasicInfo
	local Matchmaking = Matchmaking
	local Modding = Modding
	local Mouse = Mouse
	local IsDedicatedServer = Network.IsDedicatedServer
	local GetFileNameWithoutExtension = Path.GetFileNameWithoutExtension
	local PreGame = PreGame
	local Steam = Steam
	local TruncateString = TruncateString
	local UI = UI
	local UIManager = UIManager

	local g_InstanceManager = InstanceManager:new( "LoadButton", "InstanceRoot", Controls.LoadFileButtonStack )
	local g_ShowCloudSaves, g_ShowAutoSaves
	local g_CloudSaves = {}
	local g_FileList = {}
	local g_SortTable = {}
	local g_InstanceList = {}
	local g_ContextID = ContextPtr:LookUpControl(".."):GetID()
	local g_IsInGame = g_ContextID == "GameMenu"
--	local g_IsModVersion = g_ContextID == "ModdingSinglePlayer"
	local g_GameType
	if g_ContextID == "ModdingSinglePlayer" or g_ContextID == "SinglePlayerScreen" then
		g_GameType = GameTypes.GAME_SINGLE_PLAYER
	elseif PreGame.IsHotSeatGame() then
		g_GameType = GameTypes.GAME_HOTSEAT_MULTIPLAYER
	else
		g_GameType = GameTypes.GAME_NETWORK_MULTIPLAYER
	end
	local g_iSelected = -1
	local g_SavedGameModsRequired	-- The required mods for the currently selected save.
	local g_SavedGameDLCRequired	-- The required DLC for the currently selected save.
	local g_CurrentSort	-- The current sorting technique.
	local g_moddingErrorString = { nil,--1
					"TXT_KEY_MODDING_ERROR_SAVE_MISSING_DLC",--2
					"TXT_KEY_MODDING_ERROR_SAVE_DLC_NOT_PURCHASED",--3
					"TXT_KEY_MODDING_ERROR_SAVE_MISSING_MODS",--4
					"TXT_KEY_MODDING_ERROR_SAVE_INCOMPATIBLE_MODS",--5
					}
	local g_gameTypeString = {
					[GameTypes.GAME_HOTSEAT_MULTIPLAYER] = L"TXT_KEY_MULTIPLAYER_HOTSEAT_GAME",
					[GameTypes.GAME_NETWORK_MULTIPLAYER] = L"TXT_KEY_MULTIPLAYER_STRING",
					[GameTypes.GAME_SINGLE_PLAYER] = L"TXT_KEY_SINGLE_PLAYER",
					}
	local g_gameTypeIsLocal = {
					[GameTypes.GAME_HOTSEAT_MULTIPLAYER] = true,
					[GameTypes.GAME_SINGLE_PLAYER] = true,
					}
	local g_IconInfos = { MapType = false, PlayerCivilization = GameInfo.Civilizations, WorldSize = GameInfo.Worlds, Difficulty = GameInfo.HandicapInfos, GameSpeed = GameInfo.GameSpeeds }

	----------------------------------------------------------------
	local function OnDelete()
		Controls.DeleteConfirm:SetHide(false)
	end

	local function OnNoDelete()
		Controls.DeleteConfirm:SetHide(true)
	end

	local function OnBack()
		UIManager:DequeuePopup( ContextPtr )
	end

	----------------------------------------------------------------
	local function CloudSaveSort( a, b )

		local aOrder = g_SortTable[ tostring( a ) ]
		local bOrder = g_SortTable[ tostring( b ) ]

		if aOrder == nil then
			return true
		elseif bOrder == nil then
			return false
		end

		return aOrder < bOrder
	end

	----------------------------------------------------------------
	local function AlphabeticalSort( a, b )
		local oa = g_SortTable[ tostring( a ) ]
		local ob = g_SortTable[ tostring( b ) ]

		if oa == nil then
			return true
		elseif ob == nil then
			return false
		end

		return Compare(oa.Title, ob.Title) == -1
	end

	----------------------------------------------------------------
	local function ReverseAlphabeticalSort( a, b )
		local oa = g_SortTable[ tostring( a ) ]
		local ob = g_SortTable[ tostring( b ) ]

		if oa == nil then
			return false
		elseif ob == nil then
			return true
		end

		return Compare(ob.Title, oa.Title) == -1
	end

	----------------------------------------------------------------
	local function SortByName(a, b)
		if g_ShowAutoSaves then
			return ReverseAlphabeticalSort(a,b)
		else
			return AlphabeticalSort(a,b)
		end
	end

	----------------------------------------------------------------
	local function SortByLastModified(a, b)
		local oa = g_SortTable[tostring(a)]
		local ob = g_SortTable[tostring(b)]

		if oa == nil then
			return false
		elseif ob == nil then
			return true
		end

		local result = UI.CompareFileTime(oa.LastModified.High, oa.LastModified.Low, ob.LastModified.High, ob.LastModified.Low)
		return result == 1
	end

	----------------------------------------------------------------
	local function StartSelected( index )--, _, button )
		local thisLoadFile, header
		if index == -1 then
		elseif g_ShowCloudSaves then
			thisLoadFile = Steam.GetCloudSaveFileName(index)
		else
			thisLoadFile = g_FileList[ index ]
		end
		if thisLoadFile then
			if g_gameTypeIsLocal[g_GameType] then
--				UIManager:DequeuePopup( ContextPtr )
				UIManager:SetUICursor( 1 )
				Events.PlayerChoseToLoadGame( thisLoadFile, g_ShowCloudSaves )
				print( "loading saved game", GetFileNameWithoutExtension( thisLoadFile ) )
			else
				-- Multiplayer
				if g_ShowCloudSaves then
					PreGame.SetLoadFileName( thisLoadFile, true )
					header = PreGame.GetFileHeader( thisLoadFile, true )
				else
					PreGame.SetLoadFileName( thisLoadFile )
					header = PreGame.GetFileHeader( thisLoadFile )
				end
				local worldInfo = header and GameInfo.Worlds[ header.WorldSize ]
				if worldInfo then
					PreGame.SetWorldSize( worldInfo.ID )
					local strGameName = "" -- TODO
--					UIManager:DequeuePopup( ContextPtr )
					UIManager:SetUICursor( 1 )
					if IsDedicatedServer() then
						PreGame.SetGameOption("GAMEOPTION_PITBOSS", true)
						local bResult, bPending = Matchmaking.HostServerGame( strGameName, PreGame.ReadActiveSlotCountFromSaveGame(), false )
						print( "Hosting server game", GetFileNameWithoutExtension( thisLoadFile ) )
					elseif PreGame.IsInternetGame() then
						local bResult, bPending = Matchmaking.HostInternetGame( strGameName, PreGame.ReadActiveSlotCountFromSaveGame() )
						print( "Hosting server game", GetFileNameWithoutExtension( thisLoadFile ) )
					elseif PreGame.IsHotSeatGame() then
						local bResult, bPending = Matchmaking.HostHotSeatGame( strGameName, PreGame.ReadActiveSlotCountFromSaveGame() )
						print( "Hosting hot seat game", GetFileNameWithoutExtension( thisLoadFile ) )
					else
						local bResult, bPending = Matchmaking.HostLANGame( strGameName, PreGame.ReadActiveSlotCountFromSaveGame() )
						print( "Hosting LAN game", GetFileNameWithoutExtension( thisLoadFile ) )
					end
				end
			end
		end
	end

	----------------------------------------------------------------
	local function SetSelected( index )
		Controls.LargeMapImage:UnloadTexture()
		local isInvalid
		local instance = g_InstanceList[ g_iSelected ]
		if instance then
			instance.SelectHighlight:SetHide( true )
		end
		g_iSelected = index
		if index ~= -1 then
			instance = g_InstanceList[ index ]
			instance.SelectHighlight:SetHide( false )
			local header, file
			if g_ShowCloudSaves then
				header = g_CloudSaves[index]
			else
				file = g_FileList[index]
				header = PreGame.GetFileHeader( file )
			end
			if header then
--[[
CurrentEra	ERA_MEDIEVAL
StartEra	ERA_ANCIENT
LeaderName	
MapScript	Assets\Maps\Continents.lua
WorldSize	WORLDSIZE_STANDARD
Difficulty	HANDICAP_EMPEROR
ActivatedMods	table: 1577E980
CivilizationName	
TurnNumber	140
GameType	0
GameSpeed	GAMESPEED_STANDARD
PlayerColor	PLAYERCOLOR_AUSTRIA
PlayerCivilization	CIVILIZATION_AUSTRIA
--]]
				--Set Save File Text
				TruncateString( Controls.SaveFileName, Controls.DetailsBox:GetSizeX(), file and GetFileNameWithoutExtension( file ) or "" )

				local currentEra = GameInfo.Eras[ header.CurrentEra ]
				Controls.EraTurn:LocalizeAndSetText( "TXT_KEY_CUR_ERA_TURNS_FORMAT", currentEra and currentEra.Description or "TXT_KEY_MISC_UNKNOWN", header.TurnNumber )

				local startEra = GameInfo.Eras[ header.StartEra ]
				Controls.StartEra:LocalizeAndSetText( "TXT_KEY_START_ERA", startEra and startEra.Description or "TXT_KEY_MISC_UNKNOWN" )

				Controls.GameType:SetText( g_gameTypeString[ header.GameType ] )

				Controls.TimeSaved:SetText( file and UI.GetSavedGameModificationTime( file ) )

				for k, info in pairs( g_IconInfos ) do
					info = info==false and MapUtilitiesGetBasicInfo( header.MapScript ) or info[ header[k] ]
					local control = Controls[k]
					if info then
						IconHookup( info.PortraitIndex or info.IconIndex, 64, info.IconAtlas, control )
						control:LocalizeAndSetToolTip( info.Description )
					elseif questionOffset then
						control:SetTexture( questionTextureSheet )
						control:SetTextureOffset( questionOffset )
						control:SetToolTipString( unknownString )
					end
				end

				local civName = L"TXT_KEY_MISC_UNKNOWN"
				local leaderDescription = civName
				local leader
				local civ = GameInfo.Civilizations[ header.PlayerCivilization ]
				if civ then
					civName = L( civ.Description )
					-- Set Selected Civ Map
					Controls.LargeMapImage:SetTexture( civ.MapImage )
					leader = GameInfo.Leaders[GameInfo.Civilization_Leaders{ CivilizationType = civ.Type }().LeaderheadType]
				end

				if leader then
					leaderDescription = L( leader.Description )
					IconHookup( leader.PortraitIndex, 128, leader.IconAtlas, Controls.Portrait )
				else
					-- ? leader icon
					IconHookup( 22, 128, "LEADER_ATLAS", Controls.Portrait )
				end

				if (header.LeaderName or "") ~= "" then
					leaderDescription = header.LeaderName
				end

				if (header.CivilizationName or "") ~= "" then
					civName = header.CivilizationName
				end
				Controls.Title:LocalizeAndSetText("TXT_KEY_RANDOM_LEADER_CIV", leaderDescription, civName )

				-- Obtain all of the required mods for the save
				local canLoadSaveResult
				if g_ShowCloudSaves then
					canLoadSaveResult = Modding.CanLoadCloudSave( index )
					g_SavedGameDLCRequired, g_SavedGameModsRequired = Modding.GetCloudSaveRequirements( index )
				else
					canLoadSaveResult = Modding.CanLoadSavedGame( file )
					g_SavedGameDLCRequired, g_SavedGameModsRequired = Modding.GetSavedGameRequirements( file )
				end
				local control = Controls.ShowModsButton
				local t = g_SavedGameModsRequired
				local text = L"TXT_KEY_LOAD_MENU_REQUIRED_MODS"
				local pattern1 = "%s[NEWLINE][ICON_BULLET] %s (v. %i)"
--				local pattern2 = "%s[NEWLINE][ICON_BULLET] [COLOR_RED]%s (v. %i)[/COLOR]"
--				local isInstalled = Modding.IsModInstalled
				for i = 0, 1 do
					if t and #t>0 then
						for i,v in ipairs(t) do
--[[
g_SavedGameDLCRequired:
	DescriptionKey	TXT_KEY_293C1EE3117644F6AC1F59663826DE74_DESCRIPTION
	Version	1
	Title	Mongolia
g_SavedGameModsRequired:
	ID	65793c73-65eb-47d1-822b-0d1ff3eeff3e
	Version	8
	Title	Acken's Minimalistic Balance
--]]
							text = format( pattern1, text, L(v.DescriptionKey or v.Title or "???"), v.Version or "?" )
							-- isInstalled(v.ID or "???", v.Version) and pattern1 or pattern2
						end
						control:SetToolTipString( text )
						control:SetHide( false )
					else
						control:SetHide( true )
					end
					control = Controls.ShowDLCButton
					t = g_SavedGameDLCRequired
					text = L"TXT_KEY_LOAD_MENU_REQUIRED_DLC"
					pattern1 = "%s[NEWLINE][ICON_BULLET] %s"
--					pattern2 = "%s[NEWLINE][ICON_BULLET] [COLOR_RED]%s[/COLOR]"
--					isInstalled = ContentManager.IsInstalled
				end

				local warning -- = "[COLOR_POSITIVE_TEXT]Save OK[ENDCOLOR]"
				if canLoadSaveResult > 0 or header.GameType ~= g_GameType then
					warning = "[COLOR_RED]"..L(g_moddingErrorString[canLoadSaveResult] or "TXT_KEY_MODDING_ERROR_GENERIC")
				end
				return Controls.Warning:SetText( warning )
			else
				-- invalid save is selected
				isInvalid = true
			end
		else
			-- No saves are selected
			isInvalid = false
		end

		Controls.ShowDLCButton:SetHide(true)
		Controls.ShowModsButton:SetHide(true)

		if g_ShowCloudSaves then
			Controls.Title:LocalizeAndSetText("TXT_KEY_STEAM_EMPTY_SAVE")
		elseif isInvalid then
			Controls.Title:LocalizeAndSetText("TXT_KEY_INVALID_SAVE_GAME")
		else
			Controls.Title:LocalizeAndSetText("TXT_KEY_SELECT_SAVE_GAME")
		end
		-- Empty all text fields
		Controls.NoGames:SetHide( isInvalid )
		Controls.SaveFileName:SetText()
		Controls.EraTurn:SetText()
		Controls.StartEra:SetText()
		Controls.GameType:SetText()
		Controls.TimeSaved:SetText()
		-- Set all icons to ?
		IconHookup( 22, 128, "LEADER_ATLAS", Controls.Portrait )
		if questionOffset then
			for k in pairs( g_IconInfos ) do
				local control = Controls[k]
				control:SetTexture( questionTextureSheet )
				control:SetTextureOffset( questionOffset )
				control:SetToolTipString( unknownString )
			end
		end
		Controls.LargeMapImage:SetTexture( "MapRandom512.dds" )
	end

	----------------------------------------------------------------
	local function SetupFileButtonList()
		Controls.SPcheck:SetCheck( g_GameType == GameTypes.GAME_SINGLE_PLAYER )
		Controls.HScheck:SetCheck( g_GameType == GameTypes.GAME_HOTSEAT_MULTIPLAYER )
		Controls.MPcheck:SetCheck( g_GameType == GameTypes.GAME_NETWORK_MULTIPLAYER )
		Controls.AutoCheck:SetCheck( g_ShowAutoSaves )
		Controls.CloudCheck:SetCheck( g_ShowCloudSaves )
		Controls.SortByPullDown:SetHide( g_ShowCloudSaves )

	--	Controls.Delete:SetHide(g_ShowCloudSaves)
		Controls.BGBlock:SetHide( UI.GetCurrentGameState() ~= CIV5_GS_MAINGAMEVIEW )

		SetSelected( -1 )
		g_InstanceManager:ResetInstances()

		-- build a table of all save file names that we found
		g_FileList = {}
		g_SortTable = {}
		g_InstanceList = {}

		if g_ShowCloudSaves then
			Controls.NoGames:SetHide( true )
			local strEmptyCloudSave = L("TXT_KEY_STEAM_EMPTY_SAVE")

			for i = 1, Steam.GetMaxCloudSaves(), 1 do
				local controlTable = g_InstanceManager:GetInstance()
				g_InstanceList[i] = controlTable

				local name = strEmptyCloudSave
				local saveData = g_CloudSaves[i]

				if saveData then

					local civName = L("TXT_KEY_MISC_UNKNOWN")
					local leaderDescription = L("TXT_KEY_MISC_UNKNOWN")

					local civ = GameInfo.Civilizations[ saveData.PlayerCivilization ]
					if civ then
						civName = L(civ.Description)
						local leader = GameInfo.Leaders[GameInfo.Civilization_Leaders{ CivilizationType = civ.Type }().LeaderheadType]
						if leader then
							leaderDescription = L(leader.Description)
						end
					end
					if (saveData.CivilizationName or "") ~= "" then
						civName = saveData.CivilizationName
					end
					if (saveData.LeaderName or "") ~= "" then
						leaderDescription = saveData.LeaderName
					end
					name = L("TXT_KEY_RANDOM_LEADER_CIV", leaderDescription, civName )
				end

				TruncateString( controlTable.ButtonText, controlTable.Button:GetSizeX(), L("TXT_KEY_STEAMCLOUD_SAVE", i, name) )

				controlTable.Button:SetVoid1( i )
				controlTable.Button:RegisterCallback( Mouse.eMouseEnter, SetSelected )
				controlTable.Button:RegisterCallback( Mouse.eLClick, StartSelected )
				controlTable.Delete:SetHide( true )
				controlTable.Delete:ClearCallback( Mouse.eLClick )
				g_SortTable[tostring(controlTable.InstanceRoot)] = i
			end

			Controls.LoadFileButtonStack:SortChildren( CloudSaveSort )

		else
			UI.SaveFileList( g_FileList, g_GameType, g_ShowAutoSaves, true)
			for index, file in ipairs(g_FileList) do
				local controlTable = g_InstanceManager:GetInstance()
				g_InstanceList[index] = controlTable

				local displayName = GetFileNameWithoutExtension(file)

				TruncateString(controlTable.ButtonText, controlTable.Button:GetSizeX(), displayName)

				controlTable.Button:SetVoid1( index )
				controlTable.Button:RegisterCallback( Mouse.eMouseEnter, SetSelected )
				controlTable.Button:RegisterCallback( Mouse.eLClick, StartSelected )
				controlTable.Delete:RegisterCallback( Mouse.eLClick, OnDelete )
				controlTable.Delete:SetHide( false )

				local high, low = UI.GetSavedGameModificationTimeRaw(file)
				g_SortTable[ tostring( controlTable.InstanceRoot ) ] = {Title = displayName, LastModified = {High = high, Low = low} }
				Controls.NoGames:SetHide( true )
			end

			Controls.LoadFileButtonStack:SortChildren( g_CurrentSort )
		end

		Controls.LoadFileButtonStack:CalculateSize()
		Controls.ScrollPanel:CalculateInternalSize()
		Controls.LoadFileButtonStack:ReprocessAnchoring()
	end

	----------------------------------------------------------------
	-- Events
	ContextPtr:SetInputHandler(
	function( uiMsg, wParam ) --, lParam )
		if uiMsg == KeyDown then
			if wParam == VK_ESCAPE then
				if Controls.DeleteConfirm:IsHidden() then
					OnBack()
				else
					OnNoDelete()
				end
			end
		end
		return true
	end)

	ContextPtr:SetShowHideHandler(
	function( isHide, isInit )
		if isInit then
		elseif isHide then
			Controls.LargeMapImage:UnloadTexture()
		else
			if g_IsInGame then
				if Game.IsGameMultiPlayer() then
					if Game.IsNetworkMultiPlayer() then
						g_GameType = GameTypes.GAME_NETWORK_MULTIPLAYER
					else
						g_GameType = GameTypes.GAME_HOTSEAT_MULTIPLAYER
					end
				else
					g_GameType = GameTypes.GAME_SINGLE_PLAYER
				end
			end
			g_CloudSaves = Steam.GetCloudSaves()
			SetupFileButtonList()
		end
	end)

	----------------------------------------------------------------
	-- Controls
	Controls.AutoCheck:RegisterCheckHandler( function(checked)
		g_ShowAutoSaves = checked
		if checked then
			g_ShowCloudSaves = false
		end
		SetupFileButtonList()
	end)
	Controls.CloudCheck:RegisterCheckHandler( function(checked)
		g_ShowCloudSaves = checked
		if checked then
			g_ShowAutoSaves = false
		end
		SetupFileButtonList()
	end)
	Controls.SPcheck:RegisterCheckHandler( function() g_GameType = GameTypes.GAME_SINGLE_PLAYER SetupFileButtonList() end )
	Controls.HScheck:RegisterCheckHandler( function() g_GameType = GameTypes.GAME_HOTSEAT_MULTIPLAYER SetupFileButtonList() end )
	Controls.MPcheck:RegisterCheckHandler( function() g_GameType = GameTypes.GAME_NETWORK_MULTIPLAYER SetupFileButtonList() end )

	Controls.BackButton:RegisterCallback( Mouse.eLClick, OnBack )
	Controls.No:RegisterCallback( Mouse.eLClick, OnNoDelete )
	Controls.Yes:RegisterCallback( Mouse.eLClick,
	function()
		Controls.DeleteConfirm:SetHide(true)
		UI.DeleteSavedGame( g_FileList[ g_iSelected ] )
		SetupFileButtonList()
	end)


	local g_SortOptions = {
		{"TXT_KEY_SORTBY_LASTMODIFIED", SortByLastModified},
		{"TXT_KEY_SORTBY_NAME", SortByName},
	}

	local sortByPulldown = Controls.SortByPullDown
	sortByPulldown:ClearEntries()
	for i, v in ipairs(g_SortOptions) do
		local controlTable = {}
		sortByPulldown:BuildEntry( "InstanceOne", controlTable )
		controlTable.Button:LocalizeAndSetText(v[1])

		controlTable.Button:RegisterCallback(Mouse.eLClick, function()
			sortByPulldown:GetButton():LocalizeAndSetText(v[1])
			Controls.LoadFileButtonStack:SortChildren( v[2] )

			g_CurrentSort = v[2]
		end)

	end
	sortByPulldown:CalculateInternals()

	sortByPulldown:GetButton():LocalizeAndSetText(g_SortOptions[1][1])
	g_CurrentSort = g_SortOptions[1][2]
end