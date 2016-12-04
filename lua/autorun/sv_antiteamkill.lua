
if CLIENT then return end

local cpantitk_version = "1.1"

MsgN( "[CP AntiTK] v" .. cpantitk_version .. " Active - created by bamq." )

-- Output to console when a Civil Protection attempts to damage another Civil Protection.
local should_notify = true

-- Anti-TeamKill for Civil Protection jobs.
hook.Add( "PlayerShouldTakeDamage", "CPAntiTK_PlayerShouldTakeDamage", function( vict, att )

	if IsValid( vict ) and vict:IsPlayer() and vict:isCP() and IsValid( att ) and att:IsPlayer() and att:isCP() and vict ~= att then

		if should_notify then
			MsgN( "[CP AntiTK] CP " .. att:Nick() .. " (" .. att:SteamID() .. ") attempted to damage CP " .. vict:Nick() .. " (" .. vict:SteamID() .. "), negating." )
		end
		return false

	end

end )
