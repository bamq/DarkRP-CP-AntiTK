
--[[-----------------------------------------------------------------------//
* 
* Created by bamq. (https://steamcommunity.com/id/bamq)
* DarkRP CP AntiTK
* A Civil Protection anti-teamkill addon for Garry's Mod DarkRP.
* Updated 26 March 2017
* 
* Features:
* - Any damage dealt from one Civil Protection job to another will be
* completely negated.
* - Log to console when this happens.
* 
* https://github.com/bamq/DarkRP-CP-AntiTK
* 
//-----------------------------------------------------------------------]]--

CPAntiTK = CPAntiTK or {}
CPAntiTK.VERSION = "1.2"
CPAntiTK.Config = CPAntiTK.Config or {}

-- /// CONFIG /// --

-- CPAntiTK.Config.LogToConsole:
--	Should a message be printed in console when this event occurs?
CPAntiTK.Config.LogToConsole			= true

-- /// CONFIG /// --

MsgN( "DarkRP CP AntiTK v" .. CPAntiTK.VERSION .. " initialized. Created by bamq." )

hook.Add( "PlayerShouldTakeDamage", "CPAntiTK_PlayerShouldTakeDamage", function( vict, att )
	if IsValid( vict ) and vict:IsPlayer() and vict:isCP() and IsValid( att ) and att:IsPlayer() and att:isCP() and vict ~= att then
		if CPAntiTK.Config.LogToConsole then
			MsgN( "[DarkRP CP AntiTK] CP " .. att:Nick() .. " (" .. att:SteamID() .. ") attempted to damage CP " .. vict:Nick() .. " (" .. vict:SteamID() .. "), negating." )
		end
		return false
	end
end )

-- Created by bamq.
