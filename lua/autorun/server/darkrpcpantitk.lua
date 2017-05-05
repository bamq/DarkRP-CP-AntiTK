
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

-------------------------------------------------------------------------
* 
* Updated 03 April 2017
* Update by Taxin2012. (http://steamcommunity.com/id/Taxin2012/)
* 
* Features:
* - Added demote system for CP's.
* - Added setting CanDamage. Now you can choose can one CP damage other CP.
* - Added the ability to change the language.
* - Added Russian and English languages.
* 
//-----------------------------------------------------------------------]]--

CPAntiTK = CPAntiTK or {}
CPAntiTK.VERSION = "1.2 [Edited by Taxin2012]"
CPAntiTK.Config = CPAntiTK.Config or {}

-- /// CONFIG /// --

CPAntiTK.Config.LogToConsole			= true --Should a message be printed in console when this event occurs? / Показывать сообщение в консоли?
CPAntiTK.Config.CanDamage				= false --Can CP damaged other CP? / Сможет ли нанести урон один CP другому CP?
CPAntiTK.Config.Notify					= true	 --Make a notification for all CPs on server when CP attack other CP? / Сделать уведомление для всех CP на сервере, когда CP атакует другого CP?
CPAntiTK.Config.cpjobs = { "TEAM_POLICE" , "TEAM_CHIEF" , "TEAM_MAYOR"  } --What kind of jobs will be banned? / Какие работы будут забанены?
CPAntiTK.Config.bantime = 300 --Demote time / Время Разбана профессии
CPAntiTK.demote = 10 --Number of hits / Кол-во попаданий

-- /// CONFIG /// --

-- /// LANGUAGE /// --
CPAntiTK.lang = {}
CPAntiTK.lang.select ={}
CPAntiTK.lang.select = 1		--Change this number to change language / Измените это значение для смены языка
CPAntiTK.lang[1] = {}			--English / Английский
CPAntiTK.lang[2] = {}			--Russian / Русский

CPAntiTK.lang[1] = {	--ENGLISH / Английский
	
	attacked = " attacked an ally ",
	warned = "You are issued a warning for shooting on allies! ",
	willbedemote = "You will be fired for shooting at the Allies.",
	demoted = " was fired!  Reason: Shooting on Allies.",
		
}

CPAntiTK.lang[2] = {	--Russian / Русский

	attacked = " атаковал союзника ",
	warned = "Вам выдано предупреждение за стрельбу по союзникам! ",
	willbedemote = "Вы будете уволены за стрельбу по союзникам.",
	demoted = " был уволен!  Причина: Стрельба по союзникам.",
		
}

-- /// LANGUAGE /// --

MsgN( "DarkRP CP AntiTK v" .. CPAntiTK.VERSION .. " initialized. Created by bamq." )

hook.Add( "PlayerShouldTakeDamage", "CPAntiTK_PlayerShouldTakeDamage", function( vict, att )
	if IsValid( vict ) and vict:IsPlayer() and vict:isCP() and IsValid( att ) and att:IsPlayer() and att:isCP() and vict ~= att then
				att:SetNWInt( "cpantitk_hits", att:GetNWInt( "cpantitk_hits" ) + 1 )
		if CPAntiTK.Config.Notify then
			for k,v in pairs( player.GetAll() ) do
			if IsValid( v ) and v:IsPlayer() and v:isCP() then
				DarkRP.notify(v, 1, 4, att:Nick()..CPAntiTK.lang[CPAntiTK.lang.select].attacked..vict:Nick().."!")
			end
		end
			end
				DarkRP.notify(att, 1, 4, CPAntiTK.lang[CPAntiTK.lang.select].warned..att:GetNWInt( "cpantitk_hits" ).."/"..CPAntiTK.demote)
		   if att:GetNWInt( "cpantitk_hits" ) >= CPAntiTK.demote then
							att:StripWeapons()
							att:teamBan(table.HasValue(CPAntiTK.Config.cpjobs,att:Team()), CPAntiTK.Config.bantime)
						timer.Simple(5,function() DarkRP.notify(att, 1, 4, CPAntiTK.lang[CPAntiTK.lang.select].willbedemote) end)
						timer.Simple(7,function()
							att:changeTeam( GAMEMODE.DefaultTeam, true )
							att:SetNWInt( "cpantitk_hits" )
							for k,v in pairs( player.GetAll() ) do
							DarkRP.notify(v, 1, 4, att:Nick()..CPAntiTK.lang[CPAntiTK.lang.select].demoted)
							end
						end)
		    end
				if CPAntiTK.Config.LogToConsole then
					MsgN( "[DarkRP CP AntiTK] CP " .. att:Nick() .. " (" .. att:SteamID() .. ") attempted to damage CP " .. vict:Nick() .. " (" .. vict:SteamID() .. "), negating." )
				end
				if not CPAntiTK.Config.CanDamage then 
				return false
				else
				return true
				end
	end
end )

-- Created by bamq. Edited by Taxin2012
