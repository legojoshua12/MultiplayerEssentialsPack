-------------------------------------------------
-- Generic Popups
-------------------------------------------------

local pairs = pairs
local table = table
local print = print
local type = type

local UIManager = UIManager
local ContextPtr = ContextPtr
local Events = Events
local UI = UI
local Controls = Controls
local Mouse = Mouse
local PopupPriority = PopupPriority
local KeyEvents = KeyEvents
local Keys = Keys
local INTERFACEMODE_SELECTION = InterfaceModeTypes.INTERFACEMODE_SELECTION
local SetInterfaceMode = UI.SetInterfaceMode

include( "IconSupport.lua" )
local IconHookup = IconHookup

PopupLayouts = {}
PopupInputHandlers = {}
local PopupLayouts = PopupLayouts
local PopupInputHandlers = PopupInputHandlers
local mostRecentPopup
local specializedInputHandler
local buttonList = {}
local buttonIndex = 0
local canEscape
local MajorPopups = {}

LuaEvents.AddSerialEventGameMessagePopup.Add( function( p, func )
	if type(p)=="number" and type(func)=="function" then
		PopupLayouts[ p ] = func
		MajorPopups[ p ] = func
--[[
		local m
		for k, v in pairs(ButtonPopupTypes) do
			if p == v then
				m = k
				break
			end
		end
		print( m, p, tostring(func) )
--]]
	end
end)

-- Hide popup window
function HideWindow()
    UIManager:DequeuePopup( ContextPtr )
    Events.SerialEventGameMessagePopupProcessed.CallImmediate( mostRecentPopup, 0 )
	UI.decTurnTimerSemaphore()
	mostRecentPopup = nil	
	specializedInputHandler = nil
end

local function SetAnImage( image, a, b, atlas, offsetY )
	if atlas then
		image:SetSizeVal( a, a )
		image:SetTextureSizeVal( a, a )
		image:SetOffsetY( offsetY or 0 )
		image:SetHide( not IconHookup( b, a, atlas, image ) )
	elseif a then
		image:SetTextureOffsetVal( 0, 0 )
		image:SetTextureAndResize( a )
		image:SetOffsetY( b or 0 )
		image:SetHide( false )
	else
		image:SetHide( true )
	end
end

function SetTopIcon( ... )
	Controls.GenericAnim:SetHide( true )
	SetAnImage( Controls.Icon, ... )
end
function SetTopImage( ... )
	Controls.Icon:SetHide( true )
	Controls.GoldenAgeAnim:SetHide( true )
	return SetAnImage( Controls.TopImage, ... )
end
function SetImage( ... )
	return SetAnImage( Controls.Image, ... )
end
function SetBottomImage( ... )
	return SetAnImage( Controls.BottomImage, ... )
end

-- Set popup title
function SetPopupTitle( text, width )
	Controls.Title:SetText( text )
	Controls.Title:SetWrapWidth( width or 440 )
end

-- Set popup text
function SetPopupText( text, width )
	Controls.PopupText:SetText( text )
	Controls.PopupText:SetWrapWidth( width or 440 )
end

-- Add a button to popup
function AddButton( buttonText, buttonClickFunc, strToolTip, bPreventClose )
	buttonIndex = buttonIndex + 1
	local button = buttonList[ buttonIndex ]
	if button then
		button:SetHide( false )
	else
		button = {}
		ContextPtr:BuildInstanceForControl( "Button", button, Controls.Stack )
		button = button.Button
		buttonList[ buttonIndex ] = button
	end
	button:SetText( buttonText )
	button:SetToolTipString( strToolTip )
--	button:SetDisabled( false )
	-- By default, button clicks will hide the popup window after executing the click function
	-- This ugly kludge is only used in one case: when viewing a captured city (PuppetCityPopup)
	if not buttonClickFunc then
		button:RegisterCallback( Mouse.eLClick, HideWindow )
		canEscape = true
	elseif bPreventClose then
		button:RegisterCallback( Mouse.eLClick, buttonClickFunc )
	else
		button:RegisterCallback( Mouse.eLClick, function() buttonClickFunc() return HideWindow() end )
	end
	return button
end

-------------------------------------------------
-- Popup Initializers
local files = include( "InGame\\PopupsGeneric\\%w+%.lua$", true )
PopupLayouts[-1] = nil
PopupInputHandlers[-1] = nil
--table.sort( files )
--[[
do
	local m
	local n = 0
	for p, func in pairs( PopupLayouts ) do
		n=n+1
		for k, v in pairs( ButtonPopupTypes ) do
			if p == v then
				m = k
				break
			end
		end
		print( m, p, tostring(func) )
	end
	--print( "Loaded "..#files.." files for "..n.." popups\n", ("="):rep(80), "\n", table.concat( files, "\n\t" ), "\n", ("="):rep(80) )
end
--]]

-------------------------------------------------
-- Event Handlers
Events.SerialEventGameMessagePopup.Add( function( popupInfo )
	local func = PopupLayouts[ popupInfo.Type ]
	if func then
--		SetInterfaceMode( INTERFACEMODE_SELECTION )
		if MajorPopups[ popupInfo.Type ] then
			return func( popupInfo )
		elseif ContextPtr:IsHidden() then
			-- Clear popup
			for _, button in pairs( buttonList ) do
				button:SetHide( true )
			end
			buttonIndex = 0
			Controls.Title:SetText()
			Controls.PopupText:SetText()
			Controls.CloseButton:SetHide( true )
			Controls.Image:SetHide( true )
			Controls.BottomImage:SetHide( true )
			Controls.Editing:SetHide( true )
			SetTopImage( "Top512IconTrim.dds", -14 )
			SetTopIcon( "NotificationFrameBase.dds", -6 )
			Controls.GenericAnim:SetHide( false )
			canEscape = false
			-- Initialize popup
			if func( popupInfo ) ~= false then
				-- Resize popup
				Controls.Stack:CalculateSize()
				Controls.Grid:DoAutoSize()
				-- Show popup
				UIManager:QueuePopup( ContextPtr, PopupPriority.GenericPopup )
				Events.SerialEventGameMessagePopupShown( popupInfo )
				UI.incTurnTimerSemaphore()
				mostRecentPopup = popupInfo.Type
				specializedInputHandler = PopupInputHandlers[ mostRecentPopup ]
			end
		end
	end
end)

ContextPtr:SetInputHandler( function( uiMsg, wParam, lParam )
	if specializedInputHandler then
		specializedInputHandler( uiMsg, wParam, lParam )
	elseif canEscape and uiMsg == KeyEvents.KeyDown and (wParam == Keys.VK_ESCAPE or wParam == Keys.VK_RETURN) then
		HideWindow()
	end
	return true
end)

Controls.CloseButton:RegisterCallback( Mouse.eLClick, HideWindow )
Events.GameplaySetActivePlayer.Add( HideWindow )
