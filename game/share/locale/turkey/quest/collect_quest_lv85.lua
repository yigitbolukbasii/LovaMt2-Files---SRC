----------------------------------------------------
--COLLECT maxmi
----------------------------------------------------
quest collect_quest_lv85  begin
	state start begin
	end
	state run begin
		when login or levelup with pc.level >= 85 and pc.level <= 106 and not pc.is_gm() begin
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
                        say("")
                        say("Uriel'in ��rencisi Biyolog Chaegirab'�n,")
                        say("acil olarak yard�m�na ihtiyac� var.")
                        say("�abuk ol ve ona yard�m et.")
                        say("")
		end
		
		when __TARGET__.target.click or
			20084.chat."K�r. Hayalet A�ac� Dal� " begin
			target.delete("__TARGET__")
			say_title("Chaegirab:")
		    say("Hey! Tekrar merhaba!")
			say("Yard�mlar�n i�in minnettar�m.")
			say("K�z�l Orman hakk�nda yaz�yorum.")
			say("Asl�nda bunu kendim denemem gerekiyor")
		    say("ama bu m�mk�n de�il. Bu i�i benim i�in ")
			say("yapabilir misin? Tabi ki bana yard�m etti�in")
			say("i�in iyi bir �d�l alacaks�n.")
			wait()
			say_title("Chaegirab:")
			say("K�z�l Orman hakk�nda her �eyi bilmek istiyorum.")
			say("Daha �nceleri oras� harika bir ormand�. Fakat")
			say("�eytani g��ler ve metin ta�lar� oray� ")
			say("lanetli bir yer haline getirdi.")
			say("K�r. Hayalet A�ac� Dal� bulmal�s�n.")
			say("")
			wait()
			say_title("Chaegirab:")
			say("K�r. Hayalet A�ac� Dal�'n� bana getirebilir misin?")
			say("Bir ka� g�n i�inde halledece�inden eminim.")
			say("E�er dallar �ok ince ya da k�r�lm�� olursa")
			say("onlar� analiz edemem.")
			say("40 adet K�r. Hayalet A�ac� Dal�'na ihtiyac�m")
			say("var. Bol �anslar.")
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
			say_title("K�z�l Orman'dan K�r. Hayalet A�ac� Dal� ")
			say("")
			say("Chaegirab K�z�l Orman'� inceliyor.")
			say("Orada de�i�ik g��lere sahip b�y�k a�a�lar var.")
			say(" Chaegirab'�n K�r. Hayalet A�ac� Dal�'na ihtiyac� var.")
			say("Onun i�in  40 adet topla.")
			say("")
			say_item_vnum(30167) 
			say_reward(" Zaten toplad���n ".." "..pc.getqf("collect_count").." dal var.")
			say("")
		end
		
		when 71035.use begin --Quest Potion
			if get_time() < pc.getqf("duration") then
				say("Ara�t�rmac�n�n iksirini kullanamazs�n.")
				return
			end
			if pc.getqf("drink_drug")==1 then
				say("Zaten kulland�n.")
				return
			end
			if pc.count_item(30167)==0 then
				say_title("Chaegirab:")
				say("ara�t�rmac�n�n iksirini")
				say("dal bulduktan sonra kullanabilirsin.")
				say("")
				return
			end

			item.remove()	
			pc.setqf("drink_drug",1)
		end
		when kill begin 
		if  npc.get_race() == 2311 or npc.get_race() == 2312 or  npc.get_race() == 2313 or npc.get_race() == 2315 then
			local s = number(1, 200)
			if s == 1  then
				pc.give_item2(30167)
				send_letter("K�r. Hayalet A�ac� Dal� buldun")		
			end	
		end
		end


		
    	when 20084.chat."K�r. Hayalet A�ac� Dal� " with pc.count_item(30167) >0   begin
			if get_time() > pc.getqf("duration") then
				say_title("Chaegirab:")
				say("Ah!! Bana bir dal getirmi�sin.")
				say("Kontrol edece�im.")
				say("Biraz bekle...")
				say("")
				pc.remove_item(30167, 1)
				if  is_test_server()  then 
					pc.setqf("duration",get_time()+2) 
				elseif game.get_event_flag("iade") == 1 then
					pc.setqf("duration",get_time()+30*60*1) -----------------------------------22�ð�7
				else
					pc.setqf("duration",get_time()+60*60*1)
				end
				wait()
				
				local pass_percent
				if pc.getqf("drink_drug")==0 then
					pass_percent=60
				else		
					pass_percent=95
				end
				
				local s= number(1,40)
				if s<= pass_percent  then
				   if pc.getqf("collect_count")< 39 then     --Less than 40 
						local index =pc.getqf("collect_count")+1 
						pc.setqf("collect_count",index)
						say_title("Chaegirab:")
						say("Harika! G�zel i� ��kard�n.")
						say("�imdi bana ".." "..40-pc.getqf("collect_count").. " dal daha getirmelisin.")
						say("Te�ekk�rler!")
						say("")
						pc.setqf("drink_drug",0)	 --Potion reset
						return
					end
					say_title("Chaegirab:")
					say("B�t�n dallar� toplad�n!")
					say("�imdi bana Orman Ruhu Ta��'n� getirmelisin.")
					say("Yapabilirsin de�il mi?")
					say("Orman Ruhu Ta��'n�, K�rm�z� ")
					say("Hayalet A�a�lardan alabilirsin.")
					say("")
					pc.setqf("collect_count",0)
					pc.setqf("drink_drug",0)	
					pc.setqf("duration",0) 
					set_state(key_item)
					return
				else								
				say_title("Chaegirab:")
				say("Hmm...")
                say("�zg�n�m. Bunu kullanamam.")
                say("�ok ince ve bir ka� yerinden k�r�lm��. ")
                say("L�tfen ba�ka bir tane bul.")
                say("")
				pc.setqf("drink_drug",0)	 --Reset potion
				return
				end
		else
		  say_title("Chaegirab:")
		  say("�zg�n�m...")
		  say("�nceki getirdi�in dal� h�l� ")
		  say("inceliyorum. Sonra tekrar gelsen olur mu?")
		  say("")
		  return
		end

	end
end


	state key_item begin
		when letter begin
			send_letter("Chaegirab'in iste�i")
			
			if pc.count_item(30226)>0 then	
				local v = find_npc_by_vnum(20084)
				if v != 0 then
					target.vid("__TARGET__", v, "Chaegirab")
				end
			end

		end
		when button or info begin
			if pc.count_item(30226) >0 then
				say_title("Orman Ruhu Ta��'n� buldun")
				say("")
				---                                                   l
				say("Orman Ruhu Ta��'n� buldum.")
				say("�imdi onu Chaegirab'a g�t�rmeliyim.")
				say("")
				return
			end

			say_title("Orman Ruhu Ta�� ")
			say("")
			---                                                   l
			say("Uriel'in ��rencisi Chaegirab'�n ara�t�rmas� i�in ")
			say("40 tane K�r. Hayalet A�a� Dal� toplad�m.")
			say("Son olarak Orman Ruhu Ta��'na ihtiyac�m var.")
			say_item_vnum(30226)
			say("Onu K�rm�z� Hayalet A�a�larda bulabilirim.")	
			say("")
			say("")
		end
		

	
		when kill begin
			if npc.get_race() == 2311 or npc.get_race() == 2312 or npc.get_race() == 2313 or npc.get_race() == 2314 or npc.get_race() == 2315 then
			local s = number(1, 200)
			if s == 1 and pc.count_item(30226)==0 then
				pc.give_item2(30226)
				send_letter("Orman Ruhu Ta��'n� buldun")		
			end	
		end
		end


		
		when __TARGET__.target.click  or
			20084.chat."Orman Ruhu Ta��'n� getirdim." with pc.count_item(30226) > 0  begin
		    target.delete("__TARGET__")
			say_title("Chaegirab:")
			say("Ah! �yi �al��ma. Te�ekk�r ederim sayende")
			say("K�z�l Orman hakk�ndaki her �eyi biliyorum!")
			say("�d�l olarak sana bu gizli re�eteyi veriyorum.")
			say("Baek-Go senin i�in iksiri yapacak. Tekrar")
			say("te�ekk�rler ve iyi g�nler!")
			say("")
			pc.remove_item(30226,1)
			set_state(__reward)
		end
		
	end
	
	state __reward begin
		when letter begin
			send_letter("Chaegirab'in �d�l� ")
			
			local v = find_npc_by_vnum(20018)
			if v != 0 then
				target.vid("__TARGET__", v, "Baek-go")
			end

		end
		when button or info begin
			say_title("Cheagirab'�n �d�l� ")
			say("K�rm�z� dallar�n�n ve ruh ta��n�n �d�l� olarak")
            say("biyolog Chaegirab sana gizli bir re�ete verdi.")
            say("�imdi Baek-Go'ya git, senin i�in mucizevi bir ")
            say("iksir yapacak.")
		end
		
		when __TARGET__.target.click  or
			20018.chat."Re�eteyi ver"  begin
		    target.delete("__TARGET__")
			say_title("Baek-Go:")
			say("Ah, bu biyolog Chaegirab'�n gizli re�etesi mi?")
			say("Hm, bu senin di�er kahramanlar�n sald�r�lar� ")
			say("kar��s�ndaki dayan�kl�l���n� %10 art�racak. ��te")
			say("iksirin!")
			wait()
			say_title("Baek-Go:")
			say("Ayn� zamanda sana bu Koyu K�rm�z� Abanoz Sand��� ")
			say("da vermeliyim. Ona iyi bak.")
			say_reward("Bu �d�l Chaegirab'�n iste�ini k�rmad���n i�in.")
			say_reward("Biyolog Chaegirab'�n ricas�n� yerine getirmenin")
			say_reward("�d�l� olarak sana kar�� yap�lan sald�r�lara(PvP)")
			say_reward("kar�� dayan�kl�l���n kal�c� olarak %10 art�yor.")
			say_reward("Bu art�� kal�c�d�r.")
			say("")
			pc.give_item2("50115",1)
			pc.delqf("collect_count")
			clear_letter()
			affect.add_collect_point(POINT_RESIST_WARRIOR,10,60*60*24*365*60) --60��	
			affect.add_collect_point(POINT_RESIST_ASSASSIN,10,60*60*24*365*60) --60��	
			affect.add_collect_point(POINT_RESIST_SURA,10,60*60*24*365*60) --60��	
			affect.add_collect_point(POINT_RESIST_SHAMAN,10,60*60*24*365*60) --60��	
			set_quest_state("collect_quest_lv90", "run")
			set_state(__complete)
		end
			
	end

	
	state __complete begin
	end
end

