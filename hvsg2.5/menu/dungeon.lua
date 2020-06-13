if event==nil then
	event= 0
end

schwierigkeit= {"leicht","mittel","schwer"}
schwierigkeit_select= 2

farbe_init(dungeons,255,255,255)

select=1	
load= true
while true do
screen:clear()
pad = Controls.read()


if schwierigkeit_select == 1 then
	epkosten= math.floor(dungeons[select].ep_kosten/2)
	tpkosten= math.floor(dungeons[select].tp_kosten/2)
elseif schwierigkeit_select == 2 then
	epkosten= dungeons[select].ep_kosten
	tpkosten= dungeons[select].tp_kosten
elseif schwierigkeit_select == 3 then
	epkosten= math.floor(dungeons[select].ep_kosten*1.5)
	tpkosten= math.floor(dungeons[select].tp_kosten*1.5)
end

ebenen= math.random(dungeons[select].ebenen_min,dungeons[select].ebenen_max)
gegnerwahl= math.random(2,dungeons[select].maxgegner)
screen:blit(430,3,dreieck,false) screen:print(438,1,":Menu",weiss)
screen:print(1,1,"Dungeon",gelb)

screen:fillRect(190, 125, 135, 110, d_grau)--Heldhintergrund
screen:print(200,130,"Held",gruen)
screen:print(205,140,"Rang "..rang,weiss)
screen:print(205,150,"Ep: "..ep, weiss)
screen:print(205,160,"Tp: "..tp, weiss)
screen:print(205,180,"Angriff "..((ang_buff-1)*100).."%", weiss)
screen:print(205,190,"Leben   "..((hp_buff-1)*100).."%", weiss)
screen:print(205,200,"Tempo   "..((1-tempo_buff)*100).."%", weiss)
screen:print(205,210,"Heilung "..((heil_buff-1)*100).."%",weiss)
screen:print(205,220,"Schutz  "..held_def, weiss)

screen:fillRect(190, 10, 135, 85, d_grau)--Dungeonstats
screen:fillRect(10, 10, 155, 18+(table.getn(dungeons)*10), grau)--Dungeonliste
for k, n in pairs(dungeons) do
	if select == k then
		farbe(dungeons,k,0,255,0,10)
		screen:print(25, 10+k*10, n.name, menufarbe)
		
		screen:print(200, 20, dungeons[select].name, gruen)
		screen:print(205, 30, "Ebenen "..dungeons[select].ebenen_min.."-"..dungeons[select].ebenen_max, weiss)
		if rang >= dungeons[select].rang then
			screen:print(205, 40, "Rang "..dungeons[select].rang, weiss)
		else
			screen:print(205, 40, "Rang "..dungeons[select].rang, rot)
		end
		if (ep - epkosten) >= 0 then
			screen:print(205, 50, "Ep Kosten "..epkosten, weiss)
		else
			screen:print(205, 50, "Ep Kosten "..epkosten, rot)
		end
		if (tp - tpkosten) >= 0 then
			screen:print(205, 60, "Tp Kosten "..tpkosten, grau)
		else
			screen:print(205, 60, "Tp Kosten "..tpkosten, rot)	
		end
		if select==event then
			screen:print(200,100,"Event! +50% Ep+Tp!",gelb)
			screen:print(210,110," starke Gegner!",gelb)
		end
	elseif k==event and dungeons[k].rang > rang then
		farbe(dungeons,k,255,100,0,5)
		screen:print(25, 10+k*10, n.name, menufarbe)
	elseif event==k then
		farbe(dungeons,k,255,255,0,5)
		screen:print(25, 10+k*10, n.name, menufarbe)
	elseif dungeons[k].rang > rang then
		if not load then
			farbe(dungeons,k,30,30,30,5)
			screen:print(25, 10+k*10, n.name, menufarbe)
			else
			dungeons[k].r= 30
			dungeons[k].g= 30
			dungeons[k].b= 30
		end
	else
		farbe(dungeons,k,255,255,255,5)
		screen:print(25, 10+k*10, n.name, menufarbe)
	end
end

screen:print(200,80,schwierigkeit[schwierigkeit_select],weiss)

if not load then
	if pad:triangle() and pad~=oldpad then
		dofile("index.lua")
	end
	
	if pad:r() and pad~=oldpad and table.getn(schwierigkeit) > schwierigkeit_select then
		schwierigkeit_select= schwierigkeit_select + 1
	end
	
	if pad:l() and pad~=oldpad and schwierigkeit_select > 1 then
		schwierigkeit_select= schwierigkeit_select - 1
	end
	
	if pad:down() and pad~=oldpad and (select < table.getn(dungeons)) then
		select= select+1
	end

	if pad:up() and pad~=oldpad and select > 1 then
		select= select-1
	end

	if pad:cross() and pad~=oldpad and (ep >= epkosten) and (tp >= tpkosten) and rang >= dungeons[select].rang then
		fraktal_mode=false
		gegnerwahl= math.random(2,dungeons[select].maxgegner)
		ebenen= math.random(dungeons[select].ebenen_min,dungeons[select].ebenen_max)
		bossebene = ebenen
		dungeon= dungeons[select].name
		maxgegner= dungeons[select].maxgegner
		ep= ep - epkosten
		tp= tp - tpkosten
		
		--Gegnerstärke
		if schwierigkeit_select == 1 then
			gegnerbuff_ang= ang_buff - 0.03
			gegnerbuff_hp= hp_buff - 0.03
			gegnerbuff_tempo= tempo_buff + 0.03
		elseif schwierigkeit_select == 2 then
			gegnerbuff_ang= ang_buff 
			gegnerbuff_hp= hp_buff
			gegnerbuff_tempo= tempo_buff
		elseif schwierigkeit_select == 3 then
			gegnerbuff_ang= ang_buff + 0.03
			gegnerbuff_hp= hp_buff + 0.03
			gegnerbuff_tempo= tempo_buff - 0.03
		end
		if select==event then
			gegnerbuff_ang= gegnerbuff_ang + 0.03
			gegnerbuff_hp= gegnerbuff_hp + 0.03
			gegnerbuff_tempo= gegnerbuff_tempo - 0.03
		end
		
		save_daten()
		dofile("menu/kampf.lua")
	end
end

screen:print(430,264,"Zensoc",d_grau)
screen:print(1,264,"HvsG 2.5",d_grau)
oldpad = pad
screen.flip()
screen.waitVblankStart()
load=false
end