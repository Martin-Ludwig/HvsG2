load= true
newgame()
newgegner()

test = 0
while true do
screen:clear()
pad = Controls.read()


--INTERFACE----
--Gegner Anzeige/Statistik ------------------------------------------------------------------------------------------------------------------
if not fraktal_mode then
	screen:print(1,1, dungeon,gelb)
else
	screen:print(1,1, "Fraktal "..dungeon,gelb)
end

next_event= math.random(1,table.getn(dungeons))

gegner_dmg= math.random( gegner_dmg_min, gegner_dmg_max ) - held_def
if gegner_dmg < 0 then
	gegner_dmg = 0
end
gegner_lebensbalken= ((gegner_leben/gegner_maxleben)*100) --*(pixelbreite/100)

screen:fillRect(190, 176, gegner_lebensbalken, 5, rot) --screen:fillRect(x, y, breite, hoehe, farbe)
screen:drawLine(188, 174, 291, 174, orange) -- x1,y1,x2,y2
screen:drawLine(188, 182, 291, 182, orange)
screen:drawLine(188, 174, 188, 182, orange)
screen:drawLine(291, 182, 291, 174, orange)
screen:print(190,166,gegner_leben.."/"..gegner_maxleben,rot)

screen:print(190,157,gegnername,rot)
--Held interface----
held_dmg= math.random( held_dmg_min, held_dmg_max )
held_lebensbalken= ((held_leben/held_maxleben)*100)-- *(pixelbreite/100)

screen:print(190,81,"Held",gruen)
screen:print(190,90,held_leben.."/"..held_maxleben,gruen)
screen:fillRect(190, 100, held_lebensbalken, 5, gruen)
screen:drawLine(188, 98, 291, 98, hell_gruen) 
screen:drawLine(188, 106, 291, 106, hell_gruen) 
screen:drawLine(188, 98, 188, 106, hell_gruen)
screen:drawLine(291, 98, 291, 106, hell_gruen)

letzter_dmg()

--Kraft------
if 	held_kraft > 15 then
	held_kraft = 15
end
if 	gegner_kraft > 15 then
	gegner_kraft = 15
end
held_kraftbalken= ((held_kraft/15)*100)*(40/100)
screen:drawLine(180, 119, 180, 119-held_kraftbalken, hellblau)
y=119
for i=1,6 do
screen:drawLine(179, y, 181, y, grau)
y=y-8
end

--Elite
if elite_kraft_reserve then
	elite_farbe= blau
	held_elitebalken= 40-(((kraft_reserve_zeit/kraft_reserve_maxzeit)*100)*(40/100))
elseif held_elite_bluttrinker then
	elite_farbe= blau
	held_elitebalken= 40-(((bluttrinker_zeit/bluttrinker_maxzeit)*100)*(40/100))
elseif elite_panik then
	elite_farbe= blau
	held_elitebalken= 40-(((panik_zeit/panik_maxzeit)*100)*(40/100))
elseif elite_genesung then
	elite_farbe= blau
	held_elitebalken= 40-(((genesung_zeit/genesung_maxzeit)*100)*(40/100))
elseif elite_vergeltung then
	elite_farbe= blau
	held_elitebalken= 40-(((vergeltung_zeit/vergeltung_maxzeit)*100)*(40/100))
else
	elite_farbe= grau
	held_elitebalken= ((elite_cooldown/elite_maxzeit)*100)*(40/100)
end

if elite_cooldown < elite_maxzeit then
	elite_cooldown= elite_cooldown + 1
else
	elite_farbe= hellblau
end
screen:drawLine(176, 119, 176, 119-held_elitebalken, elite_farbe)
screen:drawLine(175, 119, 181, 119, grau)
screen:drawLine(175, 79, 181, 79, grau)

-------KAMPF-Aktionen-Fertigkeiten-------------------------------------------------------------------------------------------------------------
if not load then
if gegner_leben > 0 and held_leben > 0 and ebene <= bossebene then
		screen:print(360,0,"x:Angreifen",weiss)
		screen:print(360,10,"o:Heilen",weiss)
		screen:blit(360,21,dreieck,false) screen:print(368,20,":Vampirbiss",weiss)
		screen:blit(360,31,viereck,false) screen:print(368,30,":Toxin",weiss)
		screen:drawLine(355, 0, 355, 50, grau)
		screen:drawLine(355, 50, 480, 50, grau)	
		screen:print(360,40,"R:"..fertigkeiten[elite],weiss)

	if oldpad~=pad and pad:cross() then
		held_angriff=true
		 held_heilung=false
		 held_vampirbiss=false
		 held_toxin=false
	end
	if oldpad~=pad and pad:circle() and held_kraft>2 then
		 held_angriff=false
		held_heilung=true
		 held_vampirbiss=false
		 held_toxin=false
	end
	if oldpad~=pad and pad:triangle() and held_kraft>2 then
		 held_angriff=false
		 held_heilung=false
		held_vampirbiss=true
		 held_toxin=false
	end
	if oldpad~=pad and pad:square() and held_kraft>2 then
		 held_angriff=false
		 held_heilung=false
		 held_vampirbiss=false
		held_toxin=true
	end

---Kraft reserve
	if pad:r() and elite==2 and elite_cooldown == elite_maxzeit then
		kraft_reserve_zeit= 0
		kraft_reserve_wirkung= 1
		elite_cooldown= 0
		elite_kraft_reserve=true
	end	
	if elite_kraft_reserve then
		if kraft_reserve_zeit == 0+(kraft_reserve_wirkung-1)*25 then
			held_kraft= held_kraft + 1
			kraft_reserve_wirkung= kraft_reserve_wirkung + 1
		end
		kraft_reserve_zeit= kraft_reserve_zeit + 1
		if kraft_reserve_zeit == kraft_reserve_maxzeit then
			held_kraft= held_kraft + 1
			kraft_reserve_zeit= 0
			elite_cooldown= 0
			elite_kraft_reserve=false			
		end
	end
---Panik
	if pad:r() and elite==3 and elite_cooldown == elite_maxzeit then
		panik_zeit= 0
		elite_panik= true
		elite_cooldown= 0
	end
	if elite_panik then
		if panik_zeit < panik_maxzeit then
			panik_zeit= panik_zeit + 1
			gegner_angriff=false
			gegner_ang_zeit= 0
			gegner_vampirbiss=false
			gegner_vamp_zeit= 0
			gegner_toxin=false
			gegner_tox_zeit= 0
			else
			elite_cooldown= 0
			elite_panik=false
		end
	end
---Genesung
	if pad:r() and elite==4 and elite_cooldown == elite_maxzeit then
		genesung_zeit= 0
		elite_genesung= true
		elite_cooldown= 0
	end
	if elite_genesung then
		genesung_zeit= genesung_zeit + 1
		if genesung_zeit== 1 then
			held_leben= held_leben + math.floor((held_maxleben*held_heilkraft)/4)
			maxleben()
		elseif genesung_zeit== 25 then
			held_leben= held_leben + math.floor((held_maxleben*held_heilkraft)/4)
			maxleben()
		elseif genesung_zeit== 50 then
			held_leben= held_leben + math.floor((held_maxleben*held_heilkraft)/4)
			maxleben()
		elseif genesung_zeit== 75 then
			held_leben= held_leben + math.floor((held_maxleben*held_heilkraft)/4)
			maxleben()
		elseif genesung_zeit== genesung_maxzeit then
			held_leben= held_leben + math.floor((held_maxleben*held_heilkraft)/4)
			maxleben()
			elite_cooldown= 0
			elite_genesung= false
		end
	end

--Bluttrinker
	if pad:r() and elite==5 and elite_cooldown == elite_maxzeit then
		elite_bluttrinker= true
		elite_cooldown= 0
		bluttrinker_zeit= 0
	end
	if elite_bluttrinker then
		bluttrinker_zeit= bluttrinker_zeit + 1
		if bluttrinker_zeit == 1 then
			held_leben= held_leben + math.floor((held_maxleben*held_heilkraft)/8)
			gegner_leben= gegner_leben - math.floor((held_maxleben*held_heilkraft)/8)
			maxleben()
		elseif bluttrinker_zeit == 25 then
			held_leben= held_leben + math.floor((held_maxleben*held_heilkraft)/8)
			gegner_leben= gegner_leben - math.floor((held_maxleben*held_heilkraft)/8)
			maxleben()
		elseif bluttrinker_zeit == 50 then
			held_leben= held_leben + math.floor((held_maxleben*held_heilkraft)/8)
			gegner_leben= gegner_leben - math.floor((held_maxleben*held_heilkraft)/8)
			maxleben()
		elseif bluttrinker_zeit == 75 then
			held_leben= held_leben + math.floor((held_maxleben*held_heilkraft)/8)
			gegner_leben= gegner_leben - math.floor((held_maxleben*held_heilkraft)/8)
			maxleben()
		elseif bluttrinker_zeit == bluttrinker_maxzeit then		
			held_leben= held_leben + math.floor((held_maxleben*held_heilkraft)/8)
			gegner_leben= gegner_leben - math.floor((held_maxleben*held_heilkraft)/8)
			maxleben()
			elite_cooldown= 0
			elite_bluttrinker= false
		end
	end

--Vergeltung
	if pad:r() and elite==6 and elite_cooldown == elite_maxzeit then
		elite_vergeltung= true
		elite_cooldown= 0
		vergeltung_zeit= 0
	end
	if elite_vergeltung then
		vergeltung_zeit= vergeltung_zeit + 1
		if vergeltung_zeit==vergeltung_maxzeit then
			vergeltung_zeit= 0
			elite_cooldown= 0
			elite_vergeltung= false
		end
	end

-----Gegner--
	if not elite_panik then
		if not gegner_vampirbiss and not gegner_toxin then
			gegner_angriff=true
			else
			gegner_angriff=false
		end
		if not gegner_vampirbiss and not gegner_toxin_wirkung and (((held_leben/held_maxleben*100) <= (gegner_leben/gegner_maxleben*100)) or (gegner_leben >= held_leben)) and gegner_kraft>2 then
			gegner_toxin=true
			else
			gegner_toxin=false
		end
		if not gegner_toxin and ((held_leben/held_maxleben*100) > (gegner_leben/gegner_maxleben*100)) and (held_leben > gegner_leben) and gegner_kraft>2 then
			gegner_vampirbiss=true
			else
			gegner_vampirbiss=false
		end	
	end
--aufladebalken= ((zeit/maxzeit)*100)*(pixelbreite/100)
--screen:drawLine(10, 70, aufladebalken+10, 70, hell_gruen)
--HELD--
	if held_angriff then
		Held_Angriff()
		held_ladebalken=((held_ang_zeit/held_ang)*100)*(100/100)
		Held_Ladebalken()
		else
		held_ang_zeit= 0
	end

	if held_heilung then
		Held_Heilung()
		held_ladebalken=((held_heil_zeit/held_heil)*100)*(100/100)
		Held_Ladebalken()
		else
		held_heil_zeit= 0
	end

	if held_vampirbiss then
		Held_Vamp()
		held_ladebalken=((held_vamp_zeit/held_vamp)*100)*(100/100)
		Held_Ladebalken()
		else
		held_vamp_zeit= 0
	end

	if held_toxin then
		Held_Tox()
		held_ladebalken=((held_tox_zeit/held_tox)*100)*(100/100)
		Held_Ladebalken()
		else
		held_tox_zeit= 0
	end
	if held_toxin_wirkung then
		Held_Tox_Wirkung()
		else
		held_toxin_wirkzeit=0
	end


--Gegner--

	if gegner_angriff then
		Gegner_Angriff()
		gegner_ladebalken=((gegner_ang_zeit/gegner_ang)*100)*(100/100)
		Gegner_Ladebalken()
		else
		gegner_ang_zeit= 0
	end

	if gegner_vampirbiss then
		Gegner_Vampirbiss()
		gegner_ladebalken=((gegner_vamp_zeit/gegner_vamp)*100)*(100/100)
		Gegner_Ladebalken()
		else
		gegner_vamp_zeit= 0
	end

	if gegner_toxin then
		Gegner_Toxin()
		gegner_ladebalken=((gegner_tox_zeit/gegner_tox)*100)*(100/100)
		Gegner_Ladebalken()
		else
		gegner_tox_zeit= 0
	end
	if gegner_toxin_wirkung then
		Gegner_Toxin_Wirkung()
		else
		gegner_toxin_wirkzeit=0
	end
end
end
--System-------------------------------------------------------------------------------------------------------------------------------
---Gegner besiegt
gegnerwahl= math.random(2,maxgegner)
if gegner_leben < 1 and held_leben > 0 then	
	if epstop==1 then
		get_erfahrung= math.floor(held_leben/held_maxleben*100)
		allep= allep + get_erfahrung
		erfahrung = erfahrung + get_erfahrung
		while erfahrung > 69 do
			held_stufe = held_stufe + 1
			held_leben= held_leben + 10
			erfahrung= erfahrung - 70
		end
		epstop=0
	end
	if ebene < bossebene then
		newebene()
		newgegner()	
	end
	maxleben()
end

---Dungeon bezwungen
if ebene == bossebene and gegner_leben < 1 and held_leben > 0 then
	gegner_toxin_wirkung= false
	if not fraktal_mode then
		screen:print(170,10,dungeon.." bezwungen!",gelb)
	else
		screen:print(150,10,"Fraktal "..dungeon.." bezwungen!",gelb)
	end
	
	if elite==1 and event==select then-- Erfahrung und Tp ausrechnen
		get_ep= math.floor((allep/bossebene)*2)
		get_tp= math.floor(epkosten*2)
	elseif elite==1 or event==select then
		get_ep= math.floor((allep/bossebene)*1.5)
		get_tp= math.floor((epkosten)*1.5)
	else
		get_ep= math.floor(allep/bossebene)
		get_tp= math.floor(epkosten)	
	end
	if dungeons[select].name == "grune Wiese" and rang > 1 then
		get_ep= math.floor(get_ep / 2)
	end

	screen:print(160,30,"Du bekommst "..get_ep.." Erfahrung",gelb)
	screen:print(190,40,"und "..get_tp.." Talent!",gelb)

	screen:print(1,20,"start: Menu",weiss)
	screen:print(1,40,"Ebene: "..bossebene,weiss)
	screen:print(1,50,"Stufe: "..held_stufe,weiss)
	screen:blit(1,61,average_png,false) screen:print(9,60,math.floor(allep/bossebene).."ep",weiss)

	if pad:start() then
		ep= ep + get_ep
		tp = tp + get_tp
		rang_ep= rang_ep + get_ep
			
		while rang_ep > rang_next_stufe do
			if rang > 8 then
				rang_next_stufe= 1050
			else
				rang_next_stufe= (150+((rang-1)*125))
			end
			rang_ep= rang_ep - rang_next_stufe
			rang = rang + 1
		end
		
		if fraktal_mode then
			fraktal_stufe= fraktal_stufe + 1
		end
		if dungeon == "testdungeon" then
			botlvl = botlvl + 1
		end
		save_daten()
		event= next_event
		dofile("index.lua")
	end

--Im Kampf
elseif held_leben > 0 then
	screen:print(1,40,"Gegner: "..ebene.."/"..bossebene,weiss)
	screen:print(1,50,"Stufe: "..held_stufe,weiss)
end

---Niederlage----
if held_leben < 1 then
	screen:print(215,10,"Verloren",gelb)
	screen:print(1,20,"start: Menu",grau)
	screen:print(1,40,"Gegner: "..ebene.."/"..bossebene,weiss)
	screen:print(1,50,"Stufe: "..held_stufe,weiss)
	screen:blit(1,61,average_png,false) screen:print(9,60,math.floor(allep/bossebene).."ep",weiss)
	epstop=0
	
	if pad:start() then
		event= next_event
		dofile("index.lua")
	end
end

screen:print(430,264,"Zensoc",d_grau)
screen:print(1,264,"HvsG 2.5",d_grau)
oldpad = pad
screen.flip()
screen.waitVblankStart()
load=false
end