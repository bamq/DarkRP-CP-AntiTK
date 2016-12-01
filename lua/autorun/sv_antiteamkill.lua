
if CLIENT then return end

MsgN( "[CP AntiTK] Active - created by bamq." )

-- Output to console when a Civil Protection attempts to damage another Civil Protection.
local should_notify = true

-- Anti-TeamKill for Civil Protection jobs.
hook.Add( "PlayerShouldTakeDamage", "CPAntiTK_PlayerShouldTakeDamage", function( vict, att )

	if vict:IsPlayer() and att:IsPlayer() and IsValid( vict ) and IsValid( att ) then
	
		if vict:isCP() and att:isCP() and not vict == att then
			if should_notify then
				MsgN( "[CP AntiTK] CP " .. att:Nick() .. " (" .. att:SteamID() .. ") attempted to damage CP " .. vict:Nick() .. " (" .. vict:SteamID() .. "), negating." )
			end
			return false
		end

	end

end )
