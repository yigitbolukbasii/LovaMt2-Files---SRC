----------------------------------------------------
--COLLECT maxmi
----------------------------------------------------
quest collect_quest_lv94  begin
	state start begin
	end
	state run begin
		when login or levelup with pc.level >= 94 and pc.level <= 106 and not pc.is_gm() begin
			set_state(information)
		end	
	end

	state information begin
		when letter begin
			local v = find_npc_by_vnum(20091)
			if v != 0 then
				target.vid("__TARGET__", v, "Seon-Pyeong")
			end
			send_letter("Seon-Pyeong'un Ricas� ")
		end

		when button or info begin
		say_title("Seon-Pyeong'un Ricas� ")
			say("")
			say("Seon-Pyeong seni ar�yor.")
			say("Onu Ejderha Vadisinde bulabilirsin.")
			say("Git ve neler oldu�unu ��ren.")
			say("")
		end
		
		when __TARGET__.target.click or
			20091.chat."Silah koleksiyoncusu Seon-Pyeong" begin
			target.delete("__TARGET__")
			---                                                   l
			say_title("Seon-Pyeong")
			say("Tekrar merhaba. Son yard�m�n i�in minnettar�m.")
		      say("Ancak tekrar yard�m�na ihtiyac�m var.")
			say("Bu kez daha zor olacak ama ")
			say("senin bunun �stesinden gelece�inden ")
			say("eminim.")
			say("")
			wait()
			say_title("Seon-Pyeong")
			say("Bilgelik M�cevheri'ne ihtiyac�m var.")
			say("E�er bana bu m�cevherlerden 20 tane")
			say("getirirsen kar��l���n� alacaks�n.")
			say("Bol �anslar.")
			say("")
			set_state(go_to_disciple)
			pc.setqf("duration",0)  -- Time limit
			pc.setqf("collect_count",0)--Items collected
			pc.setqf("drink_drug",0) --quest potion 1
		end
	end

	state go_to_disciple begin
		when letter begin
			send_letter("Seon-Pyeong'un Ricas� ")

		end
		when button or info begin
			say_title("Seon-Pyeong i�in m�cevher")
			---                                                   l
			say("Seon-Pyeong'un ara�t�rmas� i�in")
			say("20 adet Bilgelik M�cevheri toplamal�s�n!")
			say("M�cevherleri Setaou Ok�usu ve Setaou Yarg�c�'nda")
			say("bulabilirsin.")
			say_item_vnum(30252)
			say_reward("�u ana kadar ".." "..pc.getqf("collect_count").." m�cevher g�t�rd�n.")
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
			if pc.count_item(30252)==0 then
				say_title("Seon-Pyeong")
				say("Bu iksiri m�cevher elde")
				say("ettikten sonra kullanabilirsin.")
				say("")
				return
			end

			item.remove()	
			pc.setqf("drink_drug",1)
		end

		when kill begin
		if npc.get_race() == 2412 or npc.get_race() == 2413 then
			local a = number(1, 200)
			if a <= 5 and pc.count_item(30252)==0 then
				pc.give_item2(30252, 1)
				send_letter("Bir m�cevher buldun")		
			end	
		end
		end

		
    	when 20091.chat."Ara�t�rma i�in m�cevher" with pc.count_item(30252) >0	begin
			if get_time() > pc.getqf("duration") then
				if  pc.count_item(30252) >0 then
				say_title("Seon-Pyeong")
				---                                                   l
				say("Bir m�cevher mi buldun? Harikas�n! Bir dakika")
				say("bekle, bundan emin olmam laz�m...")
				say("")
				pc.remove_item(30252, 1)
				if  is_test_server()  then 
					pc.setqf("duration",get_time()+2) 
				elseif game.get_event_flag("iade") == 1 then
				pc.setqf("duration",get_time()+30*60*1) -----------------------------------6hours
				else
					pc.setqf("duration",get_time()+60*60*1) -----------------------------------6hours
				end
				wait()
				
				local pass_percent
				if pc.getqf("drink_drug")==0 then
					pass_percent=30
				else
					pass_percent=60
				end
				
				local s= number(1,20)
				if s<= pass_percent  then
				   if pc.getqf("collect_count")< 19 then     --less than 20
						local index =pc.getqf("collect_count")+1 
						pc.setqf("collect_count",index)
						say_title("Seon-Pyeong:")
						say("Harika! Bu m�cevher tam istedi�im gibi.")
						say("�imdi bana ".." "..20-pc.getqf("collect_count").. " tane daha getirmelisin.")
						say("Bol �anslar!")
						say("")
						pc.setqf("drink_drug",0)	 --Potion reset
						return
			end
					say_title("Seon-Pyeong")
			say("Bu en sonuncu m�cevherdi. �imdi bana Beran-Setaou  ")
			say("Ruh Ta�� gerekli. E�er onu da getirirsen  ")
			say("ara�t�rmam� tamamlayabilirim. Yaln�zca bir tane ")
			say("getirmelisin. Ruh ta��n� Beran-Setaou ve ")
			say("Generallerde bulabilirsin.")
			
					pc.setqf("collect_count",0)
					pc.setqf("drink_drug",0)	
					pc.setqf("duration",0) 
					set_state(drachenstein)
					return
				else								
				say_title("Seon-Pyeong")
				say("�zg�n�m ama bu m�cevher zarar g�rm��.")
				say("Daha sonra ba�ka bir tane getir.")
				say("")				
				pc.setqf("drink_drug",0)	 --Potion reset
				return
				end
				else
					say_title("Seon-Pyeong")
					say(""..item_name(30252).." buldu�unda tekrar gel.")
					return
				end
		  else
		  say_title("Seon-Pyeong")
		  say("�zg�n�m.")
		  say("Son getirdi�in m�cevher �zerindeki incelemem ")
		  say("hen�z bitmedi.")
		  say("Sonra gelsen olur mu?")
		  say("")
		  return
		end

	end
end


	state drachenstein begin
		when letter begin
			send_letter("Seon-Pyeong'un Ricas� ")
			
			if pc.count_item(30228)>0 then	
				local v = find_npc_by_vnum(20091)
				if v != 0 then
					target.vid("__TARGET__", v, "Chaegirab")
				end
			end

		end
		when button or info begin
			if pc.count_item(30228) >0 then
				say_title("Beran-Setaou Ruh Ta��'n� buldun")
				say("")
				---                                                   l
				say("Beran-Setaou Ruh Ta��'n� buldum.")
				say("Seon-Pyeong'a geri d�nmeliyim.")
				say("")
				return
			end

			say("Seon-Pyeong'un ara�t�rmas� i�in 20 tane")
			say("Bilgelik M�cevheri toplad�m.")
			say("�imdi Beran-Setaou Ruh Ta��'n� bulmam laz�m.")
			say("Beran-Setaou ve Generallerde bu ta�� bulabilirim.")
			say("")
			say_item_vnum(30228)
			say("")
		end
		when kill begin
			
		if npc.get_race() == 2493 or npc.get_race() == 2492 or npc.get_race() == 2495 then
			local s = number(1, 100)
			if s <= 40 and pc.count_item(30228)==0 then
				pc.give_item2("30228", 1)
				send_letter("Beran-Setaou Ruh Ta��'n� buldun")		
			end	
		end
		end



		
		when __TARGET__.target.click  or
			20091.chat."Beran-Setaou Ruh Ta��'n� buldum" with pc.count_item(30228) > 0  begin
		    target.delete("__TARGET__")
			if pc.count_item(30228) > 0 then 
			say_title("Seon-Pyeong:")
			say("Bu...�nan�lmaz bir �ey! Ejderha'n�n Ruh Ta��!")
			say("Senin bu yetene�ine son derece sayg� duyuyorum.")
			say("Ara�t�rmalar�m� yapmak i�in hi�bir engel yok")
			say("art�k. Sana da hak etti�in �d�l� verece�im. ��te")
			say("se�!")
			pc.remove_item(30228,1)
			local s = select ("Hayat Puan� +1100", "Savunma +140", "Sald�r� +60")
            
            if s == 3 then
                affect.add_collect(apply.ATT_GRADE_BONUS,60,60*60*24*365*60)
				pc.setqf("94sd",1)
				set_state(__complete)
				clear_letter()
			end
            if s == 2 then
                affect.add_collect(apply.DEF_GRADE_BONUS,140,60*60*24*365*60)
				pc.setqf("94def",1)
				set_state(__complete)
				clear_letter()
			end
            if s == 1 then
                affect.add_collect(apply.MAX_HP,1100,60*60*24*365*60)
				pc.setqf("94hp",1)
				set_state(__complete)
				clear_letter()
            end
			else
				say("Seon-Pyeong")
				say(""..item_name(30228).." buldu�unda tekrar gel!")
				say("")
				return
			end
		end
	end
	
	
	state __complete begin
	end
end


