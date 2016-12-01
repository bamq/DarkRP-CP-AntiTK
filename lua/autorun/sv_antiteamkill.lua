
if CLIENT then return end

print( "[CP AntiTK] Enabled\n" )

-- Anti-TeamKill for Civil Protection jobs.
function CPAntiTK( vict, att )

	if vict:IsPlayer() and att:IsPlayer() and IsValid( vict ) and IsValid( att ) then
	
		if ( vict:isCP() ) and ( att:isCP() ) and not ( vict == att ) then
		
			print( "[CP AntiTK] CP " .. att:Nick() .. " (" .. att:SteamID() .. ") attempted to damage CP " .. vict:Nick() .. " (" .. vict:SteamID() .. "), negating.\n" )
			return false
			
		end
	end
end
hook.Add("PlayerShouldTakeDamage", "cpantiteamkill", CPAntiTK )
