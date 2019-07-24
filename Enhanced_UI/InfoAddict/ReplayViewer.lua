do
include( "IconSupport" )
local IconHookup = IconHookup
include( "GameCalendarUtilities.lua" )
local GetShortDateString = GetShortDateString
include( "InstanceManager" )

---------------------------------------------------------------
-- Optimizations
----------------------------------------------------------------
local collectgarbage = collectgarbage
local ipairs = ipairs
local math = math
local pairs = pairs
local print = print
local concat = table.concat
local insert = table.insert
local sort = table.sort
local tostring = tostring

local ContextPtr = ContextPtr
local Controls = Controls
local Game = Game
local GameDefines = GameDefines
local GameInfo = EUI and EUI.GameInfoCache or GameInfo -- warning! use iterator ONLY with table field conditions, NOT string SQL query
local Compare = Locale.Compare
local L = Locale.Lookup
local Map = Map
local Mouse = Mouse
local Players = Players
local Teams = Teams
local UI = UI
local UIManager = UIManager

----------------------------------------------------------------
-- Globals
----------------------------------------------------------------
local g_ReplayMessageInstanceManager = InstanceManager:new( "ReplayMessageInstance", "Base", Controls.ReplayMessageStack )
local g_GraphLegendInstanceManager = InstanceManager:new( "GraphLegendInstance", "GraphLegend", Controls.GraphLegendStack )
local g_LineSegmentInstanceManager = InstanceManager:new( "GraphLineInstance","LineSegment", Controls.GraphCanvas )
local g_LineSegmentInstanceManager2 = InstanceManager:new( "GraphLineInstance","LineSegment", Controls.GraphCanvas )
local g_LabelInstanceManager = InstanceManager:new( "Label","Label", Controls.GraphCanvas )
local g_LabelInstanceManager2 = InstanceManager:new( "Label","Label", Controls.GraphCanvas )
local g_ReplayInfo
local g_GraphPanelDataSetType = GameInfo.ReplayDataSets()().Type
local g_MessageAllowed = {true, false, true, true, true, true}
--	REPLAY_MESSAGE_MAJOR_EVENT,	REPLAY_MESSAGE_CITY_FOUNDED, REPLAY_MESSAGE_PLOT_OWNER_CHANGE, REPLAY_MESSAGE_CITY_CAPTURED, REPLAY_MESSAGE_CITY_DESTROYED, REPLAY_MESSAGE_RELIGION_FOUNDED, REPLAY_MESSAGE_PANTHEON_FOUNDED
local g_ColorBlack = {Type = "COLOR_BLACK", Red = 0, Green = 0, Blue = 0, Alpha = 1,}
local g_ColorWhite = {Type = "COLOR_WHITE", Red = 1, Green = 1, Blue = 1, Alpha = 1,}


-------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------

local function ColorIsWhite(color)
	return color.Red == 1 and color.Blue == 1 and color.Green == 1
end

local function ColorIsBlack(color)
	return color.Red == 0 and color.Blue == 0 and color.Green == 0
end

----------------
-- RGB : %
-- Hue: degrees
-- Saturation: %
-- Luminance: %
local function RGBtoHSL( r, g, b )
	local minV = math.min(r,g,b)
	local maxV = math.max(r,g,b)
	local l = maxV + minV
	local delta = maxV - minV

	if delta == 0 then
		return 0, 0, l*.5
	else
		local h,s
		if l > 1 then
			s = delta / (2 - l)
		else
			s = delta / l
		end
		if r == maxV then
			h = (g - b)/delta
		elseif g == maxV then
			h = 2 + (b - r)/delta
		elseif b == maxV then
			h = 4 + (r - g)/delta
		end
		return h*60, s, l*.5
	end
end
----------------
-- Hue: degrees
-- Saturation: %
-- Luminance: %
-- RGB : %
local function HSLtoRGB( h, s, l )
	if s == 0 then
		return l, l, l
	end
	local x
	if l < .5 then
		x = l * (1+s)
	else
		x = l + s - l*s
	end
	local y = 2*l - x
	local function f(r)
		r = (r/360)%1
		if 6*r < 1 then
			return y + (x-y)*6*r
		elseif 2*r < 1 then
			return x
		elseif 3*r < 2 then
			return y + (x-y)*(4-6*r)
		else
			return y
		end
	end
	return f(h+120), f(h), f(h-120)
end

local function DrawGraph()
	local dataSetType = g_GraphPanelDataSetType
	local replayInfo = g_ReplayInfo

	g_LineSegmentInstanceManager:ResetInstances()
	g_LabelInstanceManager:ResetInstances()

	-- Determine the maximum score for displayed players
	local maxScore = -math.huge
	local minScore = math.huge
	local scores
	for _, playerInfo in pairs(replayInfo.PlayerInfo) do
		if playerInfo.GraphLegendCheck:IsChecked() then
			scores = playerInfo.Scores
			for _, s in pairs(scores or (playerInfo.ReplayData and playerInfo.ReplayData[dataSetType]) or {} ) do
				if scores then
					s = s[dataSetType]
				end
				if s then
					if s > maxScore then
						maxScore = s
					end
					if s < minScore then
						minScore = s
					end
				end
			end
		end
	end
	--print("Drawing graphs for", dataSetType, "min score", minScore, "max score", maxScore )

	Controls.NoGraphData:SetHide( minScore )
	if maxScore > minScore then	-- this usually means that there were no values for that dataset.

		local range = maxScore - minScore
		local power10 = math.ceil( math.log(range)/math.log(10) )
		local increment = 1
		if power10 > 1 then		-- we only want increments >= 1
			increment = 10^(power10-1)
			while range/increment < 5 and increment%2==0 do	-- we want at least 5 increments, but whole
				increment = increment/2
			end
		end
		minScore = math.floor( minScore/increment ) * increment
		maxScore = math.ceil( maxScore/increment ) * increment
		range = maxScore - minScore

		local minTurn = replayInfo.InitialTurn
		local maxTurn = replayInfo.FinalTurn
		local graphWidth, graphHeight = Controls.GraphCanvas:GetSizeVal()
		local xScale = graphWidth / math.max(maxTurn - minTurn, 1)
		local yScale = graphHeight / range
		local label, y1, y2, lineSegment, lineWidth, color, r, g, b, a, scores, replayData
		local x0 = graphWidth
		local x1 = x0+5
		local y0 = minScore * yScale
		Controls.Negative:SetHide( y0>=0 )
		Controls.Negative:SetSizeY( -y0 )
		y0 = y0 + graphHeight

		for i = 0, range/increment do
			y1 = graphHeight - i*increment*yScale
			lineSegment = g_LineSegmentInstanceManager:GetInstance()
			lineSegment = lineSegment.LineSegment
			lineSegment:SetStartVal( x0, y1 )
			lineSegment:SetEndVal( x1, y1 )
			lineSegment:SetColorVal( 1, 1, 1, 0.5 )
			lineSegment:SetWidth( 1 )
			label = g_LabelInstanceManager:GetInstance()
			label = label.Label
			label:SetText( i*increment + minScore )
			label:SetOffsetVal( x1+5, y1-5 )
		end

		-- Draw graph
		x0 = -minTurn * xScale
		for playerID, playerInfo in pairs(replayInfo.PlayerInfo) do
			--print("Drawing graph for player ID", playerID, playerInfo.CivShortDescription or civ.ShortDescription )
			scores = playerInfo.Scores
			replayData = scores or (playerInfo.ReplayData and playerInfo.ReplayData[dataSetType])
			if replayData and playerInfo.GraphLegendCheck:IsChecked() then
				color = playerInfo.ReplayColor
				r, g, b, a = color.Red, color.Green, color.Blue, color.Alpha
				y1 = nil
				lineWidth = replayInfo.ActivePlayer == playerID and 2 or 1
				for turn = minTurn, maxTurn do
					y2 = replayData[turn]
					if scores and y2 then
						y2 = y2[dataSetType]
					end
					if y1 and y2 then
						lineSegment = g_LineSegmentInstanceManager:GetInstance()
						lineSegment = lineSegment.LineSegment
						lineSegment:SetStartVal( (turn-1)*xScale + x0, y0 - y1*yScale )
						lineSegment:SetEndVal( turn*xScale + x0, y0 - y2*yScale )
						lineSegment:SetColorVal( r, g, b, a )
						lineSegment:SetWidth( lineWidth )
					end
					y1 = y2
				end
			end
		end
	end
end

local function DrawGraphDataSet( dataSetIndex )
	local dataSet = GameInfo.ReplayDataSets[ dataSetIndex ]
	Controls.GraphDataSetPulldown:GetButton():LocalizeAndSetText( dataSet.Description )
	g_GraphPanelDataSetType = dataSet.Type
	DrawGraph()
end

local demographicsPanel = Game and {
	Title = L"TXT_KEY_DEMOGRAPHICS",
	Tooltip = L"TXT_KEY_DEMOGRAPHICS",
	Panel = LookUpControl( "/InGame/Demographics/BigStack" ),
	Refresh = function() end,
}

local messagesPanel = {
	Title = L"TXT_KEY_REPLAY_VIEWER_MESSAGES_TITLE",
	Tooltip = L"TXT_KEY_REPLAY_VIEWER_MESSAGES_TT",
	Panel = Controls.MessagesPanel,
	Refresh = function( replayInfo )

		g_ReplayMessageInstanceManager:ResetInstances()

		local playerInfos = replayInfo.PlayerInfo
		local minorCivType = GameInfo.Civilizations.CIVILIZATION_MINOR.Type
		local messageInstance, playerInfo, playerColors, color, secondaryColor, l1, l2
		for _,message in ipairs(replayInfo.Messages) do
			if message.Text and #message.Text > 0 and (not replayInfo.GameNotWon or (g_MessageAllowed[message.Type]) and replayInfo.PlayerInfo[message.Player]) then
				playerInfo = playerInfos[message.Player]
				if playerInfo then
					messageInstance = g_ReplayMessageInstanceManager:GetInstance()
					messageInstance.MessageText:SetText( tostring(message.Turn) .. " - " .. message.Text )
					messageInstance.Base:SetSizeY( messageInstance.MessageText:GetSizeY() + 10 )
--[[
					playerColors = GameInfo.PlayerColors[playerInfo.PlayerColor]
					if playerColors then
						color = GameInfo.Colors[playerColors.PrimaryColor]
						secondaryColor = GameInfo.Colors[playerColors.SecondaryColor]
						l1 = math.max( color.Red, color.Green, color.Blue*.5 )
						l2 = math.max( secondaryColor.Red, secondaryColor.Green, secondaryColor.Blue*.5 )
						if l1 < l2 then
							color, secondaryColor = secondaryColor, color
							l1, l2 = l2, l1
						end
					else
						color = g_ColorWhite
						secondaryColor = g_ColorBlack
					end
--]]
					color = playerInfo.ReplayColor
					messageInstance.MessageText:SetColor({ x = color.Red, y = color.Green, z = color.Blue, w = 1 }, 0)
--					messageInstance.MessageText:SetColor({ x = secondaryColor.Red, y = secondaryColor.Green, z = secondaryColor.Blue, w = (1.5-l2)*.75 }, 1)
				end
			end
		end

		Controls.ReplayMessageStack:CalculateSize()
		Controls.ReplayMessageStack:ReprocessAnchoring()
		Controls.ReplayMessageScrollPanel:CalculateInternalSize()
	end
}

local graphPanel = {
	Title = L"TXT_KEY_REPLAY_VIEWER_GRAPHS_TITLE",
	Tooltip = L"TXT_KEY_REPLAY_VIEWER_GRAPHS_TT",
	Panel = Controls.GraphsPanel,

	Refresh = function( replayInfo )

		local startYear = replayInfo.StartYear
		local calendarType = GameInfo.Calendars[replayInfo.Calendar].Type
		local gameSpeedType = GameInfo.GameSpeeds[replayInfo.GameSpeed].Type

		g_GraphLegendInstanceManager:ResetInstances()
		local playerInfos = replayInfo.PlayerInfo
		local color

		for playerID = 0, GameDefines.MAX_CIV_PLAYERS do
			local playerInfo = playerInfos[playerID]
--			for playerID, playerInfo in pairs(replayInfo.PlayerInfo) do
			if playerInfo then
				--print("Graph legend for player ID", playerID, playerInfo.CivShortDescription or civ.ShortDescription )
				local civ = GameInfo.Civilizations[playerInfo.Civilization]
				local graphLegendInstance = g_GraphLegendInstanceManager:GetInstance()
				playerInfo.GraphLegendCheck = graphLegendInstance.ShowHide
				IconHookup( civ.PortraitIndex, 32, civ.IconAtlas, graphLegendInstance.LegendIcon )
				color = playerInfo.ReplayColor
				graphLegendInstance.LegendLine:SetColorVal( color.Red, color.Green, color.Blue, color.Alpha )
				graphLegendInstance.LegendName:LocalizeAndSetText( playerInfo.CivShortDescription or civ.ShortDescription )
				graphLegendInstance.ShowHide:SetCheck(civ.Type ~= "CIVILIZATION_MINOR")
				graphLegendInstance.ShowHide:RegisterCheckHandler( DrawGraph )
			end
		end

		-- Refresh HorizontalScales
		local graphWidth, graphHeight = Controls.GraphCanvas:GetSizeVal()
		local initialTurn = replayInfo.InitialTurn
		local finalTurn = replayInfo.FinalTurn
		local minTurn = initialTurn
		local maxTurn = finalTurn

		local range = math.max(maxTurn - minTurn,1)
		local xScale = graphWidth / range

		local power10 = math.ceil( math.log(range)/math.log(10) )
		local increment = 1
		if power10 > 1 then		-- we don't want increments < 1
			increment = 10^(power10-1)
			if range/increment < 6 then
				increment = increment/2
			end
		end
		minTurn = math.floor( minTurn/increment ) * increment
		maxTurn = math.ceil( maxTurn/increment ) * increment

		g_LineSegmentInstanceManager2:ResetInstances()
		g_LabelInstanceManager2:ResetInstances()
		local i0 = initialTurn - minTurn
		local x0 = -i0*xScale
		local y0 = graphHeight
		local y1 = y0+5
		local y2 = y1+5

		local x1, label, lineSegment
		for i = i0, range/increment do
			x1 = x0 + i*increment*xScale
			lineSegment = g_LineSegmentInstanceManager2:GetInstance()
			lineSegment = lineSegment.LineSegment
			lineSegment:SetStartVal( x1, y0 )
			lineSegment:SetEndVal( x1, y1 )
			lineSegment:SetColorVal( 1, 1, 1, 0.5 )
			lineSegment:SetWidth( 1 )
			label = g_LabelInstanceManager2:GetInstance()
			label = label.Label
--				label:SetText( i*increment + minTurn )
			label:SetText(GetShortDateString(i*increment + minTurn, calendarType, gameSpeedType, startYear))
			label:SetOffsetVal( x1-label:GetSizeX()/2, y2 )
		end

		Controls.GraphLegendStack:CalculateSize()
		Controls.GraphLegendStack:ReprocessAnchoring()
		Controls.GraphLegendScrollPanel:CalculateInternalSize()
	end
}

local mapPanel = {
	Title = L"TXT_KEY_REPLAY_VIEWER_MAP_TITLE",
	Tooltip = L"TXT_KEY_REPLAY_VIEWER_MAP_TT",
	Panel = Controls.MapPanel,
	Refresh = function( replayInfo )
		local startYear = replayInfo.StartYear
		local calendarType = GameInfo.Calendars[replayInfo.Calendar].Type
		local gameSpeedType = GameInfo.GameSpeeds[replayInfo.GameSpeed].Type
		-- Cache the player colors
		local primaryPlayerColors = {}
		local secondaryPlayerColors = {}
		local minorCivType = GameInfo.Civilizations.CIVILIZATION_MINOR.Type
		for playerID, playerInfo in pairs(replayInfo.PlayerInfo) do
			local playerColors = GameInfo.PlayerColors[playerInfo.PlayerColor]
			local primaryColor = GameInfo.Colors[playerColors.PrimaryColor]
			local secondaryColor = GameInfo.Colors[playerColors.SecondaryColor]
			-- Reverse colors for minor civs.
			if GameInfo.Civilizations[playerInfo.Civilization].Type == minorCivType then
				primaryColor = secondaryColor
				secondaryPlayerColors[playerID] = {
						Red = secondaryColor.Red *.5,
						Green = secondaryColor.Green *.5,
						Blue = secondaryColor.Blue *.5,
						Alpha = 1.0
				}
			else
				secondaryPlayerColors[playerID] = {
						Red = secondaryColor.Red,
						Green = secondaryColor.Green,
						Blue = secondaryColor.Blue,
						Alpha = 1.0
				}
			end
			primaryPlayerColors[playerID] = {
					Red = primaryColor.Red,
					Green = primaryColor.Green,
					Blue = primaryColor.Blue,
					Alpha = 0.8
			}
		end

		-- SetCurrentTurn function
		local CurrentTurn
		local function SetCurrentTurn( currentTurn )

			local mapWidth = replayInfo.MapWidth
			local mapHeight = replayInfo.MapHeight
			local initialTurn = replayInfo.InitialTurn
			local finalTurn = replayInfo.FinalTurn
			if not currentTurn or currentTurn > finalTurn or currentTurn < initialTurn then
				currentTurn = initialTurn
			end
			local plotOwners = {}
			local plotCities = {}
			local messages = {}
			for _, message in ipairs(replayInfo.Messages) do
				local messageType = message.Type
				if message.Turn >= currentTurn then
					if message.Turn == currentTurn then
						if message.Text~="" and (not replayInfo.GameNotWon or (g_MessageAllowed[messageType]) and primaryPlayerColors[message.Player]) then
							insert( messages, message.Text )
						end
					else
						break
					end
				end
				if messageType == 1 or	-- REPLAY_MESSAGE_CITY_FOUNDED
					messageType == 3 then -- REPLAY_MESSAGE_CITY_CAPTURED
					for _, plot in pairs(message.Plots) do
						plotCities[plot.Y * mapWidth + plot.X] = message.Player
					end

				elseif messageType == 4 then -- REPLAY_MESSAGE_CITY_DESTROYED
					for _, plot in pairs(message.Plots) do
						plotCities[plot.Y * mapWidth + plot.X] = nil
					end

				elseif messageType == 2 then	-- REPLAY_MESSAGE_PLOT_OWNER_CHANGE
					for _, plot in pairs(message.Plots) do
						plotOwners[plot.Y * mapWidth + plot.X] = message.Player
					end
				end
			end

			--print("Drawing Map at Turn ", currentTurn)
			Controls.TurnMessages:SetText( concat(messages,"[NEWLINE]") )
--			Controls.MapScrollPanel:CalculateInternalSize()
			Controls.TurnLabel:SetText( L("TXT_KEY_TP_TURN_COUNTER", currentTurn) .. "  " .. GetShortDateString(currentTurn, calendarType, gameSpeedType, startYear) )
			Controls.TurnSlider:SetValue( (currentTurn - initialTurn)/(finalTurn - initialTurn) )
			CurrentTurn = currentTurn

			local ReplayMap = Controls.ReplayMap
			local SetPlot = ReplayMap.SetPlot

			local _, plot, plotColor, plotTerrainID
			local replayInfoPlots = replayInfo.Plots
			local iceFeatureID = GameInfo.Features.FEATURE_ICE.ID
			local snowTerrainID = GameInfo.Terrains.TERRAIN_SNOW.ID
			local coastTerrainID = GameInfo.Terrains.TERRAIN_COAST.ID
			local oceanTerrainID = GameInfo.Terrains.TERRAIN_OCEAN.ID

			local GetPlotByIndex, GetTerrainType, GetFeatureType, team
			local minX = 0
			local minY = 0
			local maxX = mapWidth-1
			local maxY = mapHeight-1
			local IsRevealed = function() return true end
			if replayInfoPlots then
				GetPlotByIndex = function(idx)
					for _, plot in pairs(replayInfoPlots[idx+1]) do
						return plot
					end
				end
				--{ TerrainType, NEOfRiver, WOfRiver, PlotType, FeatureType, NWOfRiver }
				GetTerrainType = function( plot ) return plot.TerrainType end
				GetFeatureType = function( plot ) return plot.FeatureType end
			elseif Map then
				GetPlotByIndex = Map.GetPlotByIndex
				GetTerrainType = GetPlotByIndex(0).GetTerrainType
				GetFeatureType = GetPlotByIndex(0).GetFeatureType
				team = Game.GetActiveTeam()
				if replayInfo.GameNotWon then
					IsRevealed = GetPlotByIndex(0).IsRevealed
					minX = mapWidth; minY = mapHeight; maxX = 0; maxY = 0
					local GetPlot = Map.GetPlot
					for y = 0, mapHeight - 1 do
						for x = 0, mapWidth - 1 do
							if IsRevealed( GetPlot( x, y ), team ) then
								if maxX < x then maxX = x end
								if maxY < y then maxY = y end
								if minX > x then minX = x end
								if minY > y then minY = y end
							end
						end
					end
				end
			else
				print("Error: could not find map replay data")
				return
			end
			--print( "mapWidth", mapWidth, minX, maxX, "mapHeight", mapHeight, minY, maxY )
			local w = maxX-minX
			local h = maxY-minY
			ReplayMap:SetMapSize(w+1, h+1, 0, -1)
			local idx
			for y = 0, h do
				idx = (y+minY)*mapWidth+minX - (y+1)*minY%2	--adjust for odd starting minY
				for x = 0, w do
					plot = GetPlotByIndex( idx )
					if IsRevealed( plot, team ) then
						plotTerrainID = GetTerrainType( plot )
						if GetFeatureType( plot ) == iceFeatureID then
							plotTerrainID = snowTerrainID
						elseif plotTerrainID == coastTerrainID then
							plotTerrainID = oceanTerrainID
						end
						plotColor = primaryPlayerColors[plotCities[idx]] or secondaryPlayerColors[plotOwners[idx]]
						if plotColor then
							SetPlot( ReplayMap, x, y, plotTerrainID, plotColor.Red, plotColor.Green, plotColor.Blue, plotTerrainID == oceanTerrainID and .75 or 1 ) --plotColor.Alpha )
						else
							SetPlot( ReplayMap, x, y, plotTerrainID )
						end
					else
						SetPlot( ReplayMap, x, y, -1 )
					end
					idx = idx + 1
				end
			end
		end
		SetCurrentTurn()
		Controls.MapTimer:RegisterAnimCallback( function()
			SetCurrentTurn( CurrentTurn + 1 )
		end)
		Controls.TurnSlider:RegisterSliderCallback( function(percent)
			SetCurrentTurn( math.floor((replayInfo.FinalTurn - replayInfo.InitialTurn)*percent) + replayInfo.InitialTurn )
		end)
	end,
}

local Panels = { messagesPanel, graphPanel, mapPanel, demographicsPanel }

----------------------------------------------------------------
local function OnBack()
	if not Game then
		UIManager:SetUICursor(1)
		Modding.DeactivateMods()
		UIManager:SetUICursor(0)
	end
--	UIManager:DequeuePopup( ContextPtr )
	ContextPtr:SetHide( true )
end

local function OnPausePlay()
	if Controls.MapTimer:IsStopped() then
		Controls.MapTimer:Play()
	else
		Controls.MapTimer:Stop()
	end
end

----------------------------------------------------------------
local function SetCurrentPanel( panelIndex )
	ContextPtr:ClearUpdate()
	Controls.MapTimer:Stop()
	local replayInfoPulldownButton = Controls.ReplayInfoPulldown:GetButton()
	for i, panel in pairs(Panels) do
		if i==panelIndex then
			panel.Panel:SetHide(false)
			replayInfoPulldownButton:SetText(panel.Title)
			replayInfoPulldownButton:SetToolTipString(panel.ToolTip)
		else
			panel.Panel:SetHide(true)
		end
	end
end

local function RefreshAll()
	--print("Refreshing Replay Viewer")
	local playerReplayColors = {}
	local function IsUniqueColor( playerColor )
		local function ColorDistance(color1, color2)
			return (color1.Red - color2.Red)^2 + (color1.Green - color2.Green)^2 + (color1.Blue - color2.Blue)^2
		end
		local distanceAgainstBlack = ColorDistance( playerColor, g_ColorBlack )
		if distanceAgainstBlack > .1 then
			for _, color in pairs(playerReplayColors) do
				if ColorDistance( playerColor, color ) < .05 then
					return false
				end
			end
			return true
		else
			return false
		end
	end

	local replayInfo = g_ReplayInfo
	local playerInfos = replayInfo.PlayerInfo
	local color, color1, playerColors, s, s1

	for playerID = 0, GameDefines.MAX_CIV_PLAYERS do
		local playerInfo = playerInfos[playerID]
		if playerInfo then
			playerColors = GameInfo.PlayerColors[playerInfo.PlayerColor]
			color1 = GameInfo.Colors[ playerColors.PrimaryColor ]
			color = GameInfo.Colors[ playerColors.SecondaryColor ]
			_, s1 = RGBtoHSL( color1.Red, color1.Green, color1.Blue )
			_, s = RGBtoHSL( color.Red, color.Green, color.Blue )
			if s1 > s then
				color, color1 = color1, color
			end
			if not IsUniqueColor( color ) then
				if IsUniqueColor( color1 ) then
					color = color1
				else
					for color1 in GameInfo.Colors() do
						if IsUniqueColor( color1 ) then
							color = color1
							break
						end
					end
				end
			end
			playerReplayColors[ playerID ] = color
			playerInfo.ReplayColor = color
		end
	end
	for _, panel in pairs(Panels) do
		panel.Refresh( replayInfo )
	end
	DrawGraphDataSet( g_GraphPanelDataSetType )
	SetCurrentPanel(2)
end

----------------------------------------------------------------
-- Initialization
----------------------------------------------------------------
ContextPtr:SetShowHideHandler( function( isHide )
	ContextPtr:ClearUpdate()
	Controls.MapTimer:Stop()
	if isHide then
		-- Free Instances
		g_ReplayMessageInstanceManager:ResetInstances()
		g_GraphLegendInstanceManager:ResetInstances()
		g_LineSegmentInstanceManager:ResetInstances()
		-- Dump tables
		g_ReplayInfo = nil
		collectgarbage()
	elseif Game and Map then
		local mapWidth, mapHeight = Map.GetGridSize()
		-- Populate Player Info
		local playerInfos = {}
		local activeTeam = Teams[Game.GetActiveTeam()]
		local isGameWon = Game.GetWinner() ~= -1

		for playerID, player in pairs(Players) do
			if player:IsEverAlive() and (isGameWon or activeTeam:IsHasMet( player:GetTeam() )) then
				local playerInfo = {
					Civilization = GameInfo.Civilizations[player:GetCivilizationType()].Type,
					Leader = GameInfo.Leaders[player:GetLeaderType()].Type,
					PlayerColor = GameInfo.PlayerColors[player:GetPlayerColor()].Type,
					Difficulty = GameInfo.HandicapInfos[player:GetHandicapType()].Type,
					LeaderName = player:GetName(),
					CivDescription = player:GetCivilizationDescription(),
					CivShortDescription = player:GetCivilizationShortDescription(),
					CivAdjective = player:GetCivilizationAdjective(),
					ReplayData = player:GetReplayData(),
				}
				playerInfos[playerID] = playerInfo
			end
		end

		g_ReplayInfo = {
			--MapScriptName = PreGame.GetMapScript(),
			--WorldSize = PreGame.GetWorldSize(),
			--Climate = Map.GetClimate(),
			--SeaLevel = Map.GetSeaLevel(),
			Era = Game.GetStartEra(),
			GameSpeed = Game.GetGameSpeedType(),
			--VictoryType = Game.GetVictory(),
			Calendar = Game.GetCalendar(),
			InitialTurn = Game.GetStartTurn(),
			FinalTurn = Game.GetGameTurn(),
			StartYear = Game.GetStartYear(),
			--GameType = PreGame.GetGameType(),
			--FinalDate = Game.GetTurnString(),
			MapWidth = mapWidth,
			MapHeight= mapHeight,
			PlayerInfo = playerInfos,
			ActivePlayer = Game.GetActivePlayer(),
			Messages = Game.GetReplayMessages(),
			GameNotWon = not isGameWon,
		}
		RefreshAll()
		print( "Generated replay info from current game" )
	end
end)

local Keys = Keys
local KeyDown = KeyEvents.KeyDown
ContextPtr:SetInputHandler(function(uiMsg, wParam)
	if uiMsg == KeyDown then
		if wParam == Keys.VK_SPACE then
			OnPausePlay()
		elseif Game then
			return
		elseif wParam == Keys.VK_ESCAPE or wParam == Keys.VK_RETURN then
			OnBack()
		end
		return true
	end
end)

Controls.FrontEndReplayViewer:SetHide( Game )
Controls.BackButton:RegisterCallback(Mouse.eLClick, OnBack)
Controls.MapCloseButton:RegisterCallback(Mouse.eLClick, OnBack)
Controls.PlayPauseButton:RegisterCallback(Mouse.eLClick, OnPausePlay)

-- Build panel selection pulldown
local replayInfoPulldown = Controls.ReplayInfoPulldown
replayInfoPulldown:ClearEntries()
for i, panel in pairs(Panels) do
	local controlTable = {}
	replayInfoPulldown:BuildEntry( "InstanceOne", controlTable )
	controlTable.Button:SetText(panel.Title)
	controlTable.Button:SetToolTipString(panel.ToolTip)
	controlTable.Button:RegisterCallback(Mouse.eLClick, function()
		SetCurrentPanel(i)
	end)
end
replayInfoPulldown:CalculateInternals()

-- Build graph data set pulldown
local graphDataSetPulldown = Controls.GraphDataSetPulldown
--	graphDataSetPulldown:ClearEntries()
local graphEntries = {}
for row in GameInfo.ReplayDataSets() do
	insert(graphEntries, row)
end
sort( graphEntries, function(a,b) return Compare(a.Description, b.Description) == -1 end )
for _, row in ipairs(graphEntries) do
	local controlTable = {}
	graphDataSetPulldown:BuildEntry( "InstanceOne", controlTable )
	controlTable.Button:RegisterCallback( Mouse.eLClick, DrawGraphDataSet )
	controlTable.Button:LocalizeAndSetText( row.Description )
	controlTable.Button:SetVoid1(row.ID)
end
graphDataSetPulldown:CalculateInternals()

local screenX, screenY = UIManager:GetScreenSizeVal()
--	local screenX2, screenY2 = Controls.ReplayMap:GetSizeVal()
--	local offsetY, offsetY2 = 0, Controls.ReplayMap:GetOffsetX()

local xAbsoluteOffset = screenX * 0.5 - Controls.MainPanel:GetSizeX() * 0.5
						+ Controls.GraphsPanel:GetOffsetX() + Controls.GraphDisplay:GetOffsetX()
local yAbsoluteOffset = screenY * 0.5 - Controls.MainPanel:GetSizeY() * 0.5
						+ Controls.GraphsPanel:GetOffsetY() + Controls.GraphDisplay:GetOffsetY()
local horizontalMouseCrosshair = Controls.HorizontalMouseCrosshair
local verticalMouseCrosshair = Controls.VerticalMouseCrosshair

local function MoveMouseCrossHairs()
	local x, y = UIManager:GetMousePos()
	verticalMouseCrosshair:SetOffsetX( x - xAbsoluteOffset )
	horizontalMouseCrosshair:SetOffsetY( y - yAbsoluteOffset )
end
--[[
Controls.MapMinimize:RegisterCallback( Mouse.eLClick, function()
	Controls.ReplayMap:SetSizeVal( screenX, screenY )
	Controls.ReplayMap:SetOffsetY( offsetY )
	Controls.ReplayMap:SetMapSize( 1,1,1,1 )
--		Controls.TurnSlider:SetAndCall( Controls.TurnSlider:GetValue() )
	screenX, screenY, offsetY, screenX2, screenY2, offsetY2 = screenX2, screenY2, offsetY2, screenX, screenY, offsetY
end)
--]]
Controls.GraphCanvas:RegisterCallback( Mouse.eMouseEnter, function()
	ContextPtr:SetUpdate( MoveMouseCrossHairs )
	verticalMouseCrosshair:SetHide( false )
	horizontalMouseCrosshair:SetHide( false )
end)
Controls.GraphCanvas:RegisterCallback( Mouse.eMouseExit, function()
	verticalMouseCrosshair:SetHide( true )
	horizontalMouseCrosshair:SetHide( true )
	ContextPtr:ClearUpdate()
end)
LuaEvents.ReplayViewer_LoadReplay.Add(function(replayFile)
	g_ReplayInfo = UI.GetReplayInfo( replayFile )
	RefreshAll()
	print( "Loaded replay info from file:", replayFile )
end)
end
