

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
* Update by Taxin2012. (http://steamcommunity.com/id/Taxin2012/)
* 
* Features:
* - Added demote system for CP's.
* - Added setting CanDamage. Now you can choose can one CP damage other CP.
* - Added the ability to change the language.
* - Added Russian and English languages.
* 
//-----------------------------------------------------------------------]]--

-- /// SOME TABLES /// --

CPAntiTK = CPAntiTK or {}
CPAntiTK.Config = CPAntiTK.Config or {}
CPAntiTK.lang = {}
CPAntiTK.lang.select ={}
CPAntiTK.lang[1] = {}			--English / Английский
CPAntiTK.lang[2] = {}			--Russian / Русский
CPAntiTK.VERSION = "2.0 [Edited by Taxin2012]"

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

-- /// END OF SOME TABLES /// --

-- /// CONFIG /// --

--Demote Config
CPAntiTK.Config.DemoteSystem			= false --Demote system / Система увольнения

CPAntiTK.Config.Notify					= true --Make a notification on server for all CPs when CP attack other CP? / Сделать уведомление на сервере для всех CP, когда CP атакует другого CP?
CPAntiTK.Config.JobsToBan 				= { TEAM_POLICE, TEAM_SWAT, TEAM_MAYOR } --Teams that will be banned / Работы, которые будут забанены
CPAntiTK.Config.BanTime 				= 1200 --Demote time / Время Разбана профессии
CPAntiTK.Hits 							= 10 --Number of hits / Кол-во попаданий

--Language Config
CPAntiTK.lang.select 					= 1	--Change this number to change language / Измените это значение для смены языка

--Other
CPAntiTK.Config.LogToConsole			= true --Should a message be printed in console when this event occurs? / Показывать сообщение в консоли?
CPAntiTK.Config.CanDamage				= false --Can CP damaged other CP? / Сможет ли нанести урон один CP другому CP?

-- /// END OF CONFIG /// --


MsgN( "DarkRP CP AntiTK v" .. CPAntiTK.VERSION .. " initialized. Created by bamq." )

hook.Add( "PlayerShouldTakeDamage", "CPAntiTK_PlayerShouldTakeDamage", function( vict, att )
	if IsValid( vict ) and vict:IsPlayer() and vict:isCP() and IsValid( att ) and att:IsPlayer() and att:isCP() and vict ~= att then
		if CPAntiTK.Config.DemoteSystem then
			att:SetNWInt( "cpantitk_hits", att:GetNWInt( "cpantitk_hits" ) + 1 )
			if CPAntiTK.Config.Notify then
				for k,v in pairs( player.GetAll() ) do
					if IsValid( v ) and v:IsPlayer() and v:isCP() then
						DarkRP.notify(v, 1, 4, att:Nick()..CPAntiTK.lang[CPAntiTK.lang.select].attacked..vict:Nick().."!")
					end
				end
			end
			DarkRP.notify(att, 1, 4, CPAntiTK.lang[CPAntiTK.lang.select].warned..att:GetNWInt( "cpantitk_hits" ).."/"..CPAntiTK.Hits)
		end
		if CPAntiTK.Config.DemoteSystem then
		   if att:GetNWInt( "cpantitk_hits" ) >= CPAntiTK.Hits then
				att:StripWeapons()
					for _, team in pairs( CPAntiTK.Config.JobsToBan ) do
						att:teamBan(team, CPAntiTK.Config.bantime)
					end
				timer.Simple(5,function() DarkRP.notify(att, 1, 4, CPAntiTK.lang[CPAntiTK.lang.select].willbedemote) end)
				timer.Simple(7,function()
					att:changeTeam( GAMEMODE.DefaultTeam, true )
					att:SetNWInt( "cpantitk_hits" )
						for k,v in pairs( player.GetAll() ) do
							DarkRP.notify(v, 1, 4, att:Nick()..CPAntiTK.lang[CPAntiTK.lang.select].demoted)
						end
				end)
		    end
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
end)

-- Created by bamq. Edited by Taxin2012
