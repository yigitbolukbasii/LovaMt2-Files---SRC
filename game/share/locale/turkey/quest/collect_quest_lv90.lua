----------------------------------------------------
--COLLECT maxmi
----------------------------------------------------
quest collect_quest_lv90  begin
	state start begin
	end
	state run begin
		when login or levelup with pc.level >= 90 and pc.level <= 106 and not pc.is_gm() begin
			set_state(information)
		end	
	end

	state information begin
		when letter begin
			local v = find_npc_by_vnum(20084)
			if v != 0 then
				target.vid("__TARGET__", v, "Chaegirab")
			end
			send_letter("Chaegirab'�n iste�i")
		end

		when button or info begin
			say_title("Chaegirab'�n iste�i")
			say("Uriel'in ��rencisi Chaegirab seni")
			say("ar�yor. Yan�na git ve ne istedi�ini ��ren.")
			say("")
		end
		
		when __TARGET__.target.click or
			20084.chat."Dinle" begin
			target.delete("__TARGET__")
			---                                                   l
			say_title("Chaegirab:")
			say("Benim i�in �imdiye kadar yapt���n")
			say("yard�mlar i�in minnettar�m.�ok iyi i� ")
			say("��kard�n.Senin gibi kahramanlar sayesinde")
			say("ara�t�rmalar�m� neredeyse bitirdim.")
			say("Bu benim senden son iste�im olacak.")
			say("Emin olabilirsin.")
			wait()
			say_title("Chaegirab:")
			say("Liderlerin Notlar�'na ihtiyac�m var!")
			say("L�tfen hayat�m�n en �nemli ara�t�rmas� ")
			say("i�in yard�m et. Fakat sahte olanlar� ")
			say("alamam. Ara�t�rmam i�in bana 50 adet")
			say("Liderlerin Notlar� getirmelisin. Bunu kar��l���n� ")
			say("alacaks�n. Bol �anslar.")
			say("")																																						  
			set_state(go_to_disciple)
			pc.setqf("duration",0)  -- Time limit
			pc.setqf("collect_count",0)--Items collected
			pc.setqf("drink_drug",0) --quest potion 1
		end
	end

	state go_to_disciple begin
		when letter begin
			send_letter("Biyolo�un incelemesi")
			
		end
		when button or info begin
			say_title("Patron yarat�klar� bul")
			---                                                   l
			say("")
			say("Uriel'in ��rencisi Cheagirab, patron canavarlar")
		    say("�zerinde �al���y�yor. Ona 50 adet Liderlerin Notlar� ")
			say("g�t�rmelisin. Notlar� g�rd���n b�t�n")
			say("patron yarat�klardan elde edebilirsin. ")
			say("")
			say_item_vnum(30168) 
			say_reward("  �imdiye kadar ".." "..pc.getqf("collect_count").." Liderlerin Notlar� toplad�n.")
			say("")
		end
		
		when 71035.use begin --Quest potion
			if get_time() < pc.getqf("duration") then
				say("�imdi kullanamazs�n.")
				return
			end
			if pc.getqf("drink_drug")==1 then
				say("Zaten kulland�n.")
				return
			end
			if pc.count_item(30168)==0 then
				say_title("Chaegirab:")
				say("Bu iksiri Liderlerin Notlar� elde")
				say("ettikten sonra kullanabilirsin.")
				say("")
				return
			end

			item.remove()	
			pc.setqf("drink_drug",1)
		end

		when kill begin
			if npc.get_race() == 691 or  npc.get_race() == 792 or  npc.get_race() == 791 or  npc.get_race() == 1092 or  npc.get_race() == 1093 or  npc.get_race() == 1304 or  npc.get_race() == 2091 or  npc.get_race() == 2206 or  npc.get_race() == 1901 then
			local s = number(1, 100)
			if s <= 30 and pc.count_item(30168)==0 then
				pc.give_item2(30168, 1)
				send_letter("Bir not buldun")		
			end	
		end
		end

		
    	when 20084.chat."Liderlerin Notlar� " with pc.count_item(30168) >0   begin
			if get_time() > pc.getqf("duration") then
				if  pc.count_item(30168) >0 then
				say("Chaegirab")
				---                                                   l
				say("Ah! Bir tane getirmi�sin.")
				say("Kontrol edece�im.")
				say("Biraz bekle...")
				say("")
				pc.remove_item(30168, 1)
				if  is_test_server()  then 
					pc.setqf("duration",get_time()+2) 
				elseif game.get_event_flag("iade") == 1 then
					pc.setqf("duration",get_time()+30*60*1) -----------------------------------22hours
				else
					pc.setqf("duration",get_time()+60*60*1) -----------------------------------22hours
				end
				wait()
				
				local pass_percent
				if pc.getqf("drink_drug")==0 then
					pass_percent=60
				else		
					pass_percent=90
				end
				
				local s= number(1,50)
				if s<= pass_percent  then
				   if pc.getqf("collect_count")< 49 then     --less than 50 
						local index =pc.getqf("collect_count")+1 
						pc.setqf("collect_count",index) 
						say("Chaegirab:")
						say("M�kemmel! Harika bir i� ba�ard�n.")
						say("�imdi bana ".." "..50-pc.getqf("collect_count").. " not daha getirmelisin.")
						say("Te�ekk�rler!")
						say("")
						pc.setqf("drink_drug",0)	 --Potion reset

						return
					end
					say_title("Chaegirab:")
					say("B�t�n notlar� toplad�n!")
					say("�imdi Liderlerin Ruh Ta��'na ihtiyac�m var.")
					say("Bana sadece bir tane getir.")
					say("Ara�t�rmam� bu sayede bitirmi� olaca��m.")
					say("")
					pc.setqf("collect_count",0)
					pc.setqf("drink_drug",0)	
					pc.setqf("duration",0) 
					set_state(key_item)
					return
				else								
				say_title("Chaegirab:")
				say("�zg�n�m ama bu notlar sahte.")
				say("Daha sonra ba�ka bir tane getir.")
				say("")				
				pc.setqf("drink_drug",0)	 --Potion reset
				return
				end
				else
					say_title("Chaegirab:")
					say(""..item_name(30168).." buldu�unda tekrar gel.")
					return
				end
		  else
		  say_title("Chaegirab:")
		  say("�zg�n�m.")
		  say("Son getirdi�in not �zerindeki incelemem ")
		  say("hen�z bitmedi.")
		  say("Sonra gelsen olur mu?")
		  say("")
		  return
		end

	end
end


	state key_item begin
		when letter begin
			send_letter("Chaegirab'in iste�i")
			
			if pc.count_item(30227)>0 then	
				local v = find_npc_by_vnum(20084)
				if v != 0 then
					target.vid("__TARGET__", v, "Chaegirab")
				end
			end

		end
		when button or info begin
			if pc.count_item(30227) >0 then
				say_title("Liderlerin Ruh Ta��'n� buldun")
				say("")
				---                                                   l
				say("Liderlerin Ruh Ta��'n� buldum.")
				say("Chaegirab'a geri d�nmeliyim.")
				say("")
				return
			end

			say_title("Liderlerin Ruh Ta��'n� bul")
			say("")
			---                                                   l
			say("Uriel'in ��rencisi Chaegirab i�in, ")
			say("50 adet Liderlerin Notlar� toplad�m.")
			say("Son olarak Liderlerin Ruh Ta��'na ihtiyac�m var!")
			say_item_vnum(30227)----------The plague king soul stone
			say("�u yarat�klardan onu bulabilirim: "..mob_name(1092)..","..mob_name(1093)..",")
			say(""..mob_name(1304)..","..mob_name(1901)..","..mob_name(2206).." ")
			say(""..mob_name(2206).."")
			say("")
		end
		when kill begin
		if npc.get_race() == 1092 or npc.get_race() == 1093 or npc.get_race() == 1304 or npc.get_race() == 2206 or npc.get_race() == 2091 or npc.get_race() == 1901 then
			local s = number(1, 100)
			if s <= 60 and pc.count_item(30227)==0 then
				pc.give_item2(30227, 1)
				send_letter("Liderlerin Ruh Ta��'n� buldun")		
			end	
		end
		end



		
		when __TARGET__.target.click  or
			20084.chat."Liderlerin Ruh Ta��'n� buldum" with pc.count_item(30227) > 0  begin
		    target.delete("__TARGET__")
			if pc.count_item(30227) > 0 then 
			say("Chaegirab")
			say("Ah! �yi �al��ma. Te�ekk�r ederim sayende")
			say("ara�t�rmalar�m� tamamlad�m!")
			say("�d�l olarak sana bu gizli re�eteyi veriyorum.")
			say("Baek-Go senin i�in iksiri yapacak. Tekrar")
			say("te�ekk�rler ve iyi g�nler!")
			say("")
			pc.remove_item(30227,1)
			set_state(__reward)
			else
				say("Chaegirab")
				say(""..item_name(30227).." buldu�unda tekrar gel!")
				say("")
				return
			end
		end
		
	end
	
	state __reward begin
		when letter begin
			send_letter("Chaegirab'�n �d�l� ")
			
			local v = find_npc_by_vnum(20018)
			if v != 0 then
				target.vid("__TARGET__", v, "Baek-go")
			end

		end
		when button or info begin
			say_title("Chaegirab'�n �d�l� ")
			say("Liderlerin Notlar� ve ruh ta��n�n �d�l� olarak")
            say("biyolog Chaegirab sana gizli bir re�ete verdi.")
            say("�imdi Baek-Go'ya git, senin i�in mucizevi bir ")
            say("iksir yapacak.")
		end
		
		when __TARGET__.target.click  or
			20018.chat."Re�eteyi ver"  begin
		    target.delete("__TARGET__")
			say_title("Baek-go:")
			say("Ah, bu biyolog Chaegirab'�n gizli re�etesi mi?")
			say("Hm, bu di�er kahramanlarla sava��rken sald�r� ")
			say("de�erini art�racak. ��te iksirin!")
			wait()
			say_title("Baek-go:")
			say("Ayn� zamanda sana bu Mavi Abanoz Sand��� ")
			say("da vermeliyim. Ona iyi bak.")
			say_reward("Bu �d�l Chaegirab'�n iste�ini k�rmad���n i�in.")
			say_reward("Chaegirab'�n ricas�n� yerine getirdi�in i�in ")
			say_reward("di�er oyuncularla sava��rken(PvP) sald�r� de�erin")
			say_reward("kal�c� olarak %10 art�yor.")
			say_reward("Bu art�� kal�c�d�r.")
			affect.add_collect_point(POINT_ATTBONUS_WARRIOR,10,60*60*24*365*60) --60years	
			affect.add_collect_point(POINT_ATTBONUS_ASSASSIN,10,60*60*24*365*60) --60years	
			affect.add_collect_point(POINT_ATTBONUS_SURA,10,60*60*24*365*60) --60years	
			affect.add_collect_point(POINT_ATTBONUS_SHAMAN,10,60*60*24*365*60) --60years
			pc.give_item2("50114",1)
			pc.delqf("collect_count")
			clear_letter()
			set_quest_state("collect_quest_lv92", "run")
			set_state(__complete)
		end
			
	end

	
	state __complete begin
	end
end

