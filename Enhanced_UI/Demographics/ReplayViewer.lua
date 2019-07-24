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
local tostring = tostring

local ContextPtr = ContextPtr
local Controls = Controls
local Game = Game
local GameDefines = GameDefines
local GameInfo = EUI and EUI.GameInfoCache or GameInfo -- warning! use iterator ONLY with table field conditions, NOT string SQL query
local LocaleCompare = Locale.Compare
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
local g_ReplayMessageInstanceManager = StackInstanceManager( "ReplayMessageInstance", "Base", Controls.ReplayMessageStack )
local g_GraphLegendInstanceManager = StackInstanceManager( "GraphLegendInstance", "GraphLegend", Controls.GraphLegendStack )
local g_LineSegmentInstanceManager = StackInstanceManager( "GraphLineInstance","LineSegment", Controls.GraphCanvas )
local g_LineSegmentInstanceManager2 = StackInstanceManager( "GraphLineInstance","LineSegment", Controls.GraphCanvas )
local g_LabelInstanceManager = StackInstanceManager( "Label","Label", Controls.GraphCanvas )
local g_LabelInstanceManager2 = StackInstanceManager( "Label","Label", Controls.GraphCanvas )
local g_ReplayInfo
local g_ReplayMapTurn
local g_GraphPanelDataSetType = GameInfo.ReplayDataSets()().Type
local g_MessageTypesAllowed = {true, false, true, true, true, true}
--	REPLAY_MESSAGE_MAJOR_EVENT,	REPLAY_MESSAGE_CITY_FOUNDED, REPLAY_MESSAGE_PLOT_OWNER_CHANGE, REPLAY_MESSAGE_CITY_CAPTURED, REPLAY_MESSAGE_CITY_DESTROYED, REPLAY_MESSAGE_RELIGION_FOUNDED, REPLAY_MESSAGE_PANTHEON_FOUNDED
local g_ColorBlack = {Type = "COLOR_BLACK", Red = 0, Green = 0, Blue = 0, Alpha = 1,}
--local g_ColorWhite = {Type = "COLOR_WHITE", Red = 1, Green = 1, Blue = 1, Alpha = 1,}


-------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------
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

local function getReplayInfo()
	local replayInfo = g_ReplayInfo
	if not replayInfo then
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

		replayInfo = {
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
		print( "Generated replay info from current game" )
		g_ReplayInfo = replayInfo
	end

	if not replayInfo.HasReplayColors then
		local playerReplayColors = {}
		local function SumSquares( x, y, z )
			return x*x + y*y + z*z
		end
		local function ColorDistanceToBlack( color )
			return SumSquares( color.Red,  color.Green, color.Blue )
		end
		local function ColorDistance( color1, color2 )
			return SumSquares( color1.Red - color2.Red, color1.Green - color2.Green, color1.Blue - color2.Blue )
		end
		local function ColorDelta( color )
			local r, g, b  = color.Red, color.Green, color.Blue
			local a = (r+g+b)/3
			return math.max( (r-a)*2, (g-a), (b-a)*.5 )
		end
		local function IsUniqueColor( playerColor )
			-- Distance against black
			if ColorDistanceToBlack( playerColor ) < .1 then
				return false
			else
				for _, color in pairs( playerReplayColors ) do
					if ColorDistance( playerColor, color ) < .05 then
						return false
					end
				end
				return true
			end
		end

		local playerInfos = replayInfo.PlayerInfo
		local color, color1, playerColors, s, s1, _
		for playerID = 0, GameDefines.MAX_CIV_PLAYERS do
			local playerInfo = playerInfos[playerID]
			if playerInfo then
				playerColors = GameInfo.PlayerColors[playerInfo.PlayerColor]
				color1 = GameInfo.Colors[ playerColors.PrimaryColor ]
				color = GameInfo.Colors[ playerColors.SecondaryColor ]
--				_, s1 = RGBtoHSL( color1.Red, color1.Green, color1.Blue )
--				_, s = RGBtoHSL( color.Red, color.Green, color.Blue )
				if ColorDelta( color1 ) >= ColorDelta( color ) then
					color, color1 = color1, color
				end
--[[
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
--]]
				playerReplayColors[ playerID ] = color
				playerInfo.ReplayColor = color
			end
		end

		replayInfo.HasReplayColors = true
	end
	return replayInfo
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
	local range = maxScore - minScore
	local minTurn = replayInfo.InitialTurn
	local maxTurn = replayInfo.FinalTurn
	-- Sample data to prevent too many segments
	local step = math.ceil((maxTurn-minTurn)/70)
	if range > 0 and step > 0 then	-- this usually means that there were no values for that dataset.

		Controls.NoGraphData:SetHide( true )
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

		local graphWidth, graphHeight = Controls.GraphCanvas:GetSizeVal()
		local scaleX = graphWidth / math.max(maxTurn - minTurn, 1)
		local scaleY = graphHeight / range
		local label, y1, y2, lineSegment, lineWidth, color, r, g, b, a, scores, replayData
		local x0 = graphWidth
		local x1 = x0+5
		local y0 = minScore * scaleY
		Controls.Negative:SetHide( y0>=0 )
		Controls.Negative:SetSizeY( -y0 )
		y0 = y0 + graphHeight

		for i = 0, range/increment do
			y1 = graphHeight - i*increment*scaleY
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

		x0 = -minTurn * scaleX
		-- Sample data until stopTurn, then full data until maxTurn
		local stopTurn = maxTurn - (step>1 and 30 or 0)
		local dt, turn1, turn2, x1, x2
		for playerID, playerInfo in pairs(replayInfo.PlayerInfo) do
			scores = playerInfo.Scores
			replayData = playerInfo.GraphLegendCheck:IsChecked() and ( scores or (playerInfo.ReplayData and playerInfo.ReplayData[dataSetType]) )
			--print("Drawing graph for player ID", playerID, playerInfo.CivShortDescription or civ.ShortDescription, replayData, step )
			if replayData then
				color = playerInfo.ReplayColor
				r, g, b, a = color.Red, color.Green, color.Blue, color.Alpha
				y1 = nil
				lineWidth = replayInfo.ActivePlayer == playerID and 3 or 1
				dt = step
				turn1 = minTurn
				turn2 = stopTurn
				repeat
					for turn = turn1, turn2, dt do
						y2 = replayData[turn]
						if scores and y2 then
							y2 = y2[dataSetType]
						end
						if y2 then
							x2 = turn*scaleX + x0
							if y1 then
								lineSegment = g_LineSegmentInstanceManager:GetInstance()
								lineSegment = lineSegment.LineSegment
								lineSegment:SetStartVal( x1, y0 - y1*scaleY )
								lineSegment:SetEndVal( x2, y0 - y2*scaleY )
								lineSegment:SetColorVal( r, g, b, a )
								lineSegment:SetWidth( lineWidth )
							end
							x1 = x2
						end
						y1 = y2
					end
					if dt>1 then
						dt = 1
						turn1 = turn2 + dt
						turn2 = maxTurn
					else
						break
					end
				until false
			end
		end
	else
		Controls.NoGraphData:SetHide( false )
	end
end

local function DrawGraphDataSet( dataSetIndex )
	local dataSet = GameInfo.ReplayDataSets[ dataSetIndex ]
	Controls.GraphDataSetPulldown:GetButton():LocalizeAndSetText( dataSet.Description )
	g_GraphPanelDataSetType = dataSet.Type
	DrawGraph()
end

local Panels = {
-- Messages Panel
{
	Title = L"TXT_KEY_REPLAY_VIEWER_MESSAGES_TITLE",
	Tooltip = L"TXT_KEY_REPLAY_VIEWER_MESSAGES_TT",
	Panel = Controls.MessagesPanel,

	Refresh = function()
		local replayInfo = getReplayInfo()
		local playerInfos = replayInfo.PlayerInfo
		local messageInstance, playerInfo, color

		g_ReplayMessageInstanceManager:ResetInstances()

		for _,message in ipairs(replayInfo.Messages) do
			if message.Text and #message.Text > 0 and (not replayInfo.GameNotWon or (g_MessageTypesAllowed[message.Type]) and replayInfo.PlayerInfo[message.Player]) then
				playerInfo = playerInfos[message.Player]
				if playerInfo then
					messageInstance = g_ReplayMessageInstanceManager:GetInstance()
					messageInstance.MessageText:SetText( tostring(message.Turn) .. " - " .. message.Text )
					messageInstance.Base:SetSizeY( messageInstance.MessageText:GetSizeY() + 10 )
					color = playerInfo.ReplayColor
					messageInstance.MessageText:SetColor({ x = color.Red, y = color.Green, z = color.Blue, w = 1 }, 0)
				end
			end
		end
		Controls.ReplayMessageStack:CalculateSize()
		Controls.ReplayMessageStack:ReprocessAnchoring()
		Controls.ReplayMessageScrollPanel:CalculateInternalSize()
	end
},
-- Graphs Panel
{
	Title = L"TXT_KEY_REPLAY_VIEWER_GRAPHS_TITLE",
	Tooltip = L"TXT_KEY_REPLAY_VIEWER_GRAPHS_TT",
	Panel = Controls.GraphsPanel,

	Refresh = function()
		local replayInfo = getReplayInfo()
		local startYear = replayInfo.StartYear
		local calendarType = GameInfo.Calendars[replayInfo.Calendar].Type
		local gameSpeedType = GameInfo.GameSpeeds[replayInfo.GameSpeed].Type

		g_GraphLegendInstanceManager:ResetInstances()
		local playerInfos = replayInfo.PlayerInfo
		local color, civ, isNotMinorCiv, instance

		for playerID = 0, GameDefines.MAX_CIV_PLAYERS do
			local playerInfo = playerInfos[playerID]
			if playerInfo then
				instance = g_GraphLegendInstanceManager:GetInstance()
				civ = GameInfo.Civilizations[playerInfo.Civilization]
				isNotMinorCiv = civ and civ.Type ~= "CIVILIZATION_MINOR"
				playerInfo.GraphLegendCheck = instance.ShowHide
				IconHookup( civ.PortraitIndex, 32, civ.IconAtlas, instance.LegendIcon )
				color = playerInfo.ReplayColor
				instance.LegendLine:SetColorVal( color.Red, color.Green, color.Blue, color.Alpha )
				instance.LegendName:LocalizeAndSetText( playerInfo.CivShortDescription or civ.ShortDescription )
				instance.ShowHide:SetCheck( isNotMinorCiv )
				instance.ShowHide:RegisterCheckHandler( DrawGraph )
				--print("Graph legend for player ID", playerID, playerInfo.CivShortDescription or civ.ShortDescription, playerInfo.GraphLegendCheck )
			end
		end

		-- Refresh HorizontalScales
		local graphWidth, graphHeight = Controls.GraphCanvas:GetSizeVal()
		local initialTurn = replayInfo.InitialTurn
		local finalTurn = replayInfo.FinalTurn
		local minTurn = initialTurn
		local maxTurn = finalTurn

		local range = math.max(maxTurn - minTurn,1)
		local scaleX = graphWidth / range

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
		local x0 = -i0*scaleX
		local y0 = graphHeight
		local y1 = y0+5
		local y2 = y1+5

		local x1, label, lineSegment
		for i = i0, range/increment do
			x1 = x0 + i*increment*scaleX
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
		DrawGraphDataSet( g_GraphPanelDataSetType )
	end
},
-- Map Panel
{
	Title = L"TXT_KEY_REPLAY_VIEWER_MAP_TITLE",
	Tooltip = L"TXT_KEY_REPLAY_VIEWER_MAP_TT",
	Panel = Controls.MapPanel,
	Refresh = function()
		local replayInfo = getReplayInfo()
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

		-- SetReplayMapTurn function
		local function SetReplayMapTurn( currentTurn )

			local mapWidth = replayInfo.MapWidth
			local mapHeight = replayInfo.MapHeight
			local initialTurn = replayInfo.InitialTurn
			local finalTurn = replayInfo.FinalTurn
			if not currentTurn or currentTurn > finalTurn or currentTurn < initialTurn then
				currentTurn = initialTurn
			end
			g_ReplayMapTurn = currentTurn

			local plotOwners = {}
			local plotCities = {}
			local messages = {}
			-- Iterate replay info messages until current turn to determine plot owners and cities
			for _, message in ipairs(replayInfo.Messages) do
				local messageType = message.Type
				if message.Turn >= currentTurn then
					if message.Turn == currentTurn then
						if message.Text~="" and (not replayInfo.GameNotWon or (g_MessageTypesAllowed[messageType]) and primaryPlayerColors[message.Player]) then
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

			local ReplayMap = Controls.ReplayMap
			local SetPlot = ReplayMap.SetPlot

			local _, plot, plotColor, plotTerrainID
			local replayInfoPlots = replayInfo.Plots
			local iceFeatureID = GameInfo.Features.FEATURE_ICE.ID
			local snowTerrainID = GameInfo.Terrains.TERRAIN_SNOW.ID
			local coastTerrainID = GameInfo.Terrains.TERRAIN_COAST.ID
			local oceanTerrainID = GameInfo.Terrains.TERRAIN_OCEAN.ID

			local GetPlotByIndex, GetTerrainType, GetFeatureType, team
			local x1 = 0
			local y1 = 0
			local w = mapWidth
			local h = mapHeight
			local x2 = w-1
			local y2 = h-1
			local x3, x4
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
					-- We need to resize the map to the area the player has seen
					IsRevealed = GetPlotByIndex(0).IsRevealed
					local GetPlot = Map.GetPlot
					local player = Players[ Game.GetActivePlayer() ]
					local startPlot = player:GetStartingPlot()
					local rX = {}
					local rY = {}
					x4 = x2
					x1 = startPlot:GetX()
					x2 = x1
					y1 = startPlot:GetY()
					y2 = y1
					-- Project revealed plots along X and Y axis
					for y = 0, mapHeight - 1 do
						for x = 0, mapWidth - 1 do
							if IsRevealed( GetPlot( x, y ), team ) then
								rX[x] = true
								rY[y] = true
							end
						end
					end
					-- Determine the extent of exploration from starting plot
					-- Do only map X wrap cases... nobody lives on donut planet
					while rX[x1-1] do x1=x1-1 end	-- base case	__███S███__
					while rX[x2+1] do x2=x2+1 end
					w = x2-x1+1
					if x1>1 and rX[0] then			-- wrap case 1	█____███S██
						x3, x4 = 0, 0
						while rX[x4+1] do x4=x4+1 end
						w = w+x4+1
					elseif x2<x4 and rX[x4] then	-- wrap case 2	██S███____█
						x1, x2, x3, x4 = x4, x4, x1, x2
						while rX[x1-1] do x1=x1-1 end
						w = w+x2-x1+1
					end
					while rY[y1-1] do y1=y1-1 end
					while rY[y2+1] do y2=y2+1 end
					h = y2-y1+1
				end
			else
				print("Error: could not find map replay data")
				return
			end
			ReplayMap:SetMapSize(w, h, 0, -1)
			local x, cx1, cx2, cx3
			local bias = y1%2 --adjust for odd starting row
			local idx = (y1-1)*mapWidth
			for y = 0, h-1 do
				x = 0
				idx = idx+mapWidth - bias
				bias = -bias
				cx1, cx2, cx3 = x1, x2, x3
				repeat -- once for base case (x3 is nil), twice for wrap cases 1 & 2
					for idx = idx+cx1, idx+cx2 do
						plot = GetPlotByIndex( idx )
						if IsRevealed( plot, team ) then
							plotTerrainID = GetTerrainType( plot )
							-- ice looks like sh*t, change to snow
							if GetFeatureType( plot ) == iceFeatureID then
								plotTerrainID = snowTerrainID
							-- coast is too bright, change to ocean
							elseif plotTerrainID == coastTerrainID then
								plotTerrainID = oceanTerrainID
							end
							-- do we have a city here or does this plot belong to someone
							plotColor = primaryPlayerColors[plotCities[idx]] or secondaryPlayerColors[plotOwners[idx]]
							if plotColor then
								-- city or plot owner
								SetPlot( ReplayMap, x, y, plotTerrainID, plotColor.Red, plotColor.Green, plotColor.Blue, plotTerrainID == oceanTerrainID and .75 or 1 ) -- dim ocean/coast ownership a bit
							else
								-- vacant unowned plot
								SetPlot( ReplayMap, x, y, plotTerrainID )
							end
						else
							-- unrevealed plot
							SetPlot( ReplayMap, x, y, -1 )
						end
						x = x+1
					end
					-- cx3 is nil'ed so we exit next time
					cx1, cx2, cx3 = cx3, x4
				until not cx1
			end
		end
		SetReplayMapTurn()
		Controls.MapTimer:RegisterAnimCallback( function()
			SetReplayMapTurn( g_ReplayMapTurn + 1 )
		end)
		Controls.TurnSlider:RegisterSliderCallback( function(percent)
			SetReplayMapTurn( math.floor((replayInfo.FinalTurn - replayInfo.InitialTurn)*percent) + replayInfo.InitialTurn )
		end)
	end,
},
-- Demographics Panel
Game and {
	Title = L"TXT_KEY_DEMOGRAPHICS",
	Tooltip = L"TXT_KEY_DEMOGRAPHICS",
	Panel = LookUpControl( "/InGame/Demographics/BigStack" ),
	Refresh = function() end,
}
}

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
local g_CurrentPanelIndex = 4 -- demographics
local g_ReplayInfoPulldownButton = Controls.ReplayInfoPulldown:GetButton()

local function SetCurrentPanel( panelIndex )
	if panelIndex then
		g_CurrentPanelIndex = panelIndex
	else
		panelIndex = g_CurrentPanelIndex
	end
	ContextPtr:ClearUpdate()
	Controls.MapTimer:Stop()
	for i, panel in pairs(Panels) do
		if i==panelIndex then
			g_ReplayInfoPulldownButton:SetText( panel.Title )
			g_ReplayInfoPulldownButton:SetToolTipString( panel.ToolTip )
			panel.Panel:SetHide( false )
			panel.Refresh()
		else
			panel.Panel:SetHide(true)
		end
	end
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
	elseif Game then
		SetCurrentPanel()
	end
end)

-- Key Down Processing
do
	local VK_RETURN = Keys.VK_RETURN
	local VK_ESCAPE = Keys.VK_ESCAPE
	local VK_SPACE = Keys.VK_SPACE
	local KeyDown = KeyEvents.KeyDown
	ContextPtr:SetInputHandler( function( uiMsg, wParam )
		if uiMsg == KeyDown then
			if wParam == VK_SPACE then
				OnPausePlay()
				return true
			elseif not Game and ( wParam == VK_ESCAPE or wParam == VK_RETURN ) then
				OnBack()
				return true
			end
		end
	end)
end

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
	controlTable.Button:SetText( panel.Title )
	controlTable.Button:SetToolTipString( panel.ToolTip )
	controlTable.Button:RegisterCallback( Mouse.eLClick, SetCurrentPanel )
	controlTable.Button:SetVoid1( i )
end
replayInfoPulldown:CalculateInternals()

-- Build graph data set pulldown
local graphDataSetPulldown = Controls.GraphDataSetPulldown
--	graphDataSetPulldown:ClearEntries()
--local graphEntries = {}
for replayDataSet in GameInfo.ReplayDataSets() do
--	insert(graphEntries, replayDataSet)
--end
--table.sort( graphEntries, function(a,b) return LocaleCompare(a.Description, b.Description) == -1 end )
--for _, replayDataSet in ipairs(graphEntries) do
	--print(replayDataSet.Description)
	local controlTable = {}
	graphDataSetPulldown:BuildEntry( "InstanceOne", controlTable )
	controlTable.Button:LocalizeAndSetText( replayDataSet.Description )
	controlTable.Button:SetVoid1( replayDataSet.ID )
	controlTable.Button:RegisterCallback( Mouse.eLClick, DrawGraphDataSet )
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
LuaEvents.ReplayViewer_LoadReplay.Add( function( replayFile )
	g_ReplayInfo = UI.GetReplayInfo( replayFile )
	print( "Loaded replay info from file:", replayFile )
	SetCurrentPanel( 2 ) -- graph
end)
end
