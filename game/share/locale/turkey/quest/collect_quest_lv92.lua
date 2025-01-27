----------------------------------------------------
--COLLECT maxmi
----------------------------------------------------
quest collect_quest_lv92  begin
	state start begin
	end
	state run begin
		when login or levelup with pc.level >= 92 and pc.level <= 106 and not pc.is_gm() begin
			set_state(information)
		end	
	end

	state information begin
		when letter begin
			local v = find_npc_by_vnum(20091)
			if v != 0 then
				target.vid("__TARGET__", v, "Seon-Pyeong")
			end
			send_letter("Seon-Pyeong'un ara�t�rmas� ")
		end

		when button or info begin
		say_title("Seon-Pyeong'un ara�t�rmas� ")
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
			say_title("Seon-Pyeong:")
			say("Hey! Cesur sava���! Tam da seni ar�yordum.")
			say("Yard�m�na ihtiyac�m var!")
			say("S�rg�n Ma�aras�'ndaki canavarlar� duydum.")
			say("Silahlar �zerindeki ara�t�rmam i�in")
			say("baz� m�cevherlere ihtiyac�m var.")
			wait()
			say_title("Seon-Pyeong:")
			say("M�cevherler kusursuz olmal�!")
			say("Onlar� bana getirirsen �zerinde")
			say("�al��aca��m. �htayac�m olan m�cevher,")
			say("Kem G�z M�cevheri. Onlardan 10 adet")
			say("getirmelisin.")
			say("")
			set_state(go_to_disciple)
			pc.setqf("duration",0)  -- Time limit
			pc.setqf("collect_count",0)--Items collected
			pc.setqf("drink_drug",0) --Quest Potion 1
		end
	end

	state go_to_disciple begin
		when letter begin
			send_letter("Seon-Pyeong'un ara�t�rmas� ")
			
		end
		when button or info begin
			say_title("Seon-Pyeong i�in m�cevher")
			---                                                   l
			say("Silah demircisi ve ara�t�rmac�s� Seon-Pyeong'un")
			say("10 tane Kem G�z M�cevheri'ne ihtiyac� var. O'na")
			say("bu m�cevherleri tek tek getir ki, O da daha iyi")
			say("inceleyebilsin.")
			say("Bu m�cevherleri Yeralt� Buz Adam� ve Yeralt� Buz Golemi'nde")
			say("bulabilirsin.")
			say_item_vnum(30251) 
			say_reward(" �u ana kadar ".." "..pc.getqf("collect_count").." tane m�cevher g�t�rd�n.")
			say("")
		end
		
		when 71035.use begin --dazzlement potion 
			if get_time() < pc.getqf("duration") then
				say("�imdi kullanamazs�n.")
				return
			end
			if pc.getqf("drink_drug")==1 then
				say("Zaten kulland�n.")
				return
			end
			if pc.count_item(30251)==0 then
				say_title("Chaegirab:")
				say("Bu iksiri")
				say("m�cevher bulduktan sonra kullanabilirsin.")
				say("")
				return
			end

			item.remove()	
			pc.setqf("drink_drug",1)
		end

		when kill begin
			if npc.get_race() == 1135 or npc.get_race() == 1137 then
			local s = number(1, 200)
			if s <= 5 then
				pc.give_item2(30251, 1)
				send_letter("Kem G�z M�cevheri buldun")		
			end	
		end
		end

		
    	when 20091.chat."Silah ara�t�rmas� i�in m�cevher" with pc.count_item(30251) >0   begin
			if get_time() > pc.getqf("duration") then
				if  pc.count_item(30251) >0 then
				say_title("Seon-Pyeong:")
				---                                                   l
				say("Bir m�cevher mi buldun? Harikas�n! Bir dakika")
				say("bekle, bundan emin olmam laz�m...")
				say("")
				pc.remove_item(30251, 1)
				if  pc.is_gm() then 
					pc.setqf("duration",get_time()+2) 
				else
					if game.get_event_flag("iade") == 1 then
					pc.setqf("duration",get_time()+30*60*1) -----------------------------------6hours
					else
					pc.setqf("duration",get_time()+60*60*1) -----------------------------------6hours
					end
				end
				wait()
				
				local pass_percent
				if pc.is_gm() then
				pass_percent =100
				else
					if pc.setf("collect_quest_luck","drink_drug")==0 then
					pass_percent=25
					else
					pass_percent=50
					end
				end
				
				local s= number(1,10)
				if s<= pass_percent  then
				   if pc.getqf("collect_count")< 9 and not pc.is_gm() then     --less than 10
						local index =pc.getqf("collect_count")+1 
						pc.setqf("collect_count",index)
						say_title("Seon-Pyeong:")
						say("Harika! Bu m�cevher tam istedi�im gibi.")
						say("�imdi bana "..10-pc.getqf("collect_count").." tane daha getirmelisin.")
						say("Bol �anslar!")
						say("")
						pc.setf("collect_quest_luck","drink_drug",0)	 --Potion reset
						return
					end
					say_title("Seon-Pyeong:")
					say("Bu en sonuncu m�cevherdi, 10 tanesini de")
					say("getirdin. Sana te�ekk�r� bor� bilirim. �d�l�n� ")
					say("vermede pinti davranmayaca��m. Diledi�ini se�!")
					pc.setqf("collect_count",10)
					local s=select("Hayat Puan� +1000","Savunma +120","Sald�r� +50")
					if 1== s then
					affect.add_collect(apply.MAX_HP,1000,60*60*24*365*60)					--hp+1000  Hp is 1
					pc.setqf("92hp",1)
					elseif 2== s then
					affect.add_collect(apply.DEF_GRADE_BONUS,120,60*60*24*365*60) 
					pc.setqf("92def",1)
					elseif 3==s then
					affect.remove_collect(apply.ATT_GRADE_BONUS, 50, 60*60*24*365*60)
					affect.add_collect(apply.ATT_GRADE_BONUS,100,60*60*24*365*60)--60years
					pc.setqf("92sd",1)
				    end
					pc.delqf("collect_count")
					pc.setf("collect_quest_luck","drink_drug",0)	
					pc.setqf("duration",0) 
					clear_letter()
					set_quest_state("collect_quest_lv94", "run")
					set_state(__complete)
					return
				else								
				say_title("Seon-Pyeong:")
				say("�zg�n�m. Bu m�cevher i�e yaramaz.")
				say("Ba�ka bir tane buldu�un da")
				say("tekrar gel.")				   
				pc.setf("collect_quest_luck","drink_drug",0)	 --Potion reset
				return
				end
				else
					say("Chaegirab:")
					say(""..item_name(30251).." buldu�unda tekrar gel.")
					return
				end
		  else
		  say_title("Seon-Pyeong:")
		  say("�zg�n�m.")
		  say("Son getirdi�in m�cevherin analizi ")
		  say("hen�z bitmedi. Sonra tekrar gelsen")
		  say("olur mu?")
		  say("")
		  return
		end

	end
end


	

	
	state __complete begin
	end
end


