function grune_wiese()
	gegnertyp= gegnerwahl
	if ebene==bossebene then
		gegnertyp=1
	end
	if gegnertyp==1 then
		schwarzer_grashupper()
	elseif gegnertyp==2 then
		gruner_grashupper()
	elseif gegnertyp==3 then
		gruner_grashupper()
	elseif gegnertyp==4 then
		blauer_grashupper()
	end
end

function blaue_wiese()
	gegnertyp= gegnerwahl
	if ebene==bossebene then
		gegnertyp=1
	end
	if gegnertyp==1 then
		schwarzer_grashupper()
	elseif gegnertyp==2 then
		gruner_grashupper()
	elseif gegnertyp==3 then
		blauer_grashupper()
	elseif gegnertyp==4 then
		schwarzer_grashupper()
	end
end

function schwarze_wiese()
	gegnertyp= gegnerwahl
	if ebene==bossebene then
		gegnertyp=1
	end
	if gegnertyp==1 then
		Heuschrecke()
	elseif gegnertyp==2 then
		schwarzer_grashupper()
	elseif gegnertyp==3 then
		schwarzer_grashupper()
	elseif gegnertyp==4 then
		blauer_grashupper()
	end
end

function friedhof()
	gegnertyp= gegnerwahl
	if ebene==bossebene then
		gegnertyp=1
	end
	if gegnertyp==1 then
		Lich()
	elseif gegnertyp==2 then
		Ghul()
	elseif gegnertyp==3 then
		Zombie()
	elseif gegnertyp==4 then
		Vampir()
	elseif gegnertyp==5 then
		Phantom()
	elseif gegnertyp==6 then
		Imp()
	end
end

function unterwelt()
	gegnertyp= gegnerwahl
	if ebene==bossebene then
		gegnertyp=1
	end
	if gegnertyp==1 then
		Teufel()
	elseif gegnertyp==2 then
		Banshee()
	elseif gegnertyp==3 then
		Imp()
	elseif gegnertyp==4 then
		Hexer()
	elseif gegnertyp==5 then
		Phantom()
	end
end

function exil()
	gegnertyp= gegnerwahl
	if ebene==bossebene then
		gegnertyp=1
	end
	if gegnertyp==1 then
		Duncan_der_Schwarze()
	elseif gegnertyp==2 then
		Justiziar_Thommis()
	elseif gegnertyp==3 then
		Rand_Sturmweber() 
	elseif gegnertyp==4 then
		Selvetarm()
	elseif gegnertyp==5 then
		Schmiedewicht()
	end
end

function banditen_lager()
	gegnertyp= gegnerwahl
	if ebene==bossebene then
		gegnertyp=1
	end
	if gegnertyp==1 then
		Bonnetti()
	elseif gegnertyp==2 then
		Plunderer()
	elseif gegnertyp==3 then
		Pyromane()
	elseif gegnertyp==4 then
		Abtrunniger()
	end
end

function atlantis()
	gegnertyp= gegnerwahl
	if ebene==bossebene then
		gegnertyp=1
	end
	if gegnertyp==1 then
		Neptun()
	elseif gegnertyp==2 then
		Kraken()
	elseif gegnertyp==3 then
		Qualle()
	elseif gegnertyp==4 then
		Leviathan()
	end
end

function pirateninsel()
	gegnertyp= gegnerwahl
	if ebene==bossebene then
		gegnertyp=1
	end
	if gegnertyp==1 then
		Captain_CAPS()
	elseif gegnertyp==2 then
		Arzt()
	elseif gegnertyp==3 then
		Schuetze()
	elseif gegnertyp==4 then
		Koch()
	elseif gegnertyp==5 then
		Navigator()
	elseif gegnertyp==6 then
		Zimmermann()
	end
end

function jungle()
	gegnertyp= gegnerwahl
	if ebene==bossebene then
		gegnertyp=1
	end
	if gegnertyp==1 then
		Heuschrecke()
	elseif gegnertyp==2 then
		Affe()
	elseif gegnertyp==3 then
		Spinne()
	elseif gegnertyp==4 then
		Troll()
	end
end

function inferno()
	gegnertyp= gegnerwahl
	if ebene==bossebene then
		gegnertyp=1
	end
	if gegnertyp==1 then
		Armageddon_Lord()
	elseif gegnertyp==2 then
		Feuer_Kobold()
	elseif gegnertyp==3 then
		Hydra()
	elseif gegnertyp==4 then
		Feuerfunke()
	end
end

function fabrik()
	gegnertyp= gegnerwahl
	if ebene==bossebene then
		gegnertyp=1
	end
	if gegnertyp==1 then
		Cyber_End_Drache()
	elseif gegnertyp==2 then
		Spielautomat()
	elseif gegnertyp==3 then
		Panzerkern()
	elseif gegnertyp==4 then
		Oelmann()
	elseif gegnertyp==5 then
		Jinzo()
	end
end