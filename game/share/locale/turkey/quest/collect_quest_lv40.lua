----------------------------------------------------
--COLLECT maxmi
----------------------------------------------------
quest collect_quest_lv40  begin
        state start begin
        end
        state run begin
                when login or levelup with pc.level >= 40 and pc.level <= 106 and not pc.is_gm() begin
                        set_state(information)
                end
        end
        state information begin
                when letter begin
                        local v = find_npc_by_vnum(20084)
                        if v != 0 then
                                target.vid("__TARGET__", v, "Biologist Chaegirab")
                        end
                        send_letter("Chaegirab'�n Ricas� ")
                end
                when button or info begin
                        say_title("Chaegirab'�n Ricas� ")
                        say("")
                        say("Uriel'in ��rencisi Biyolog Chaegirab")
                        say("seni ar�yor.")
                        say("Onun yan�na git ve yard�m et.")
                        say("")
                end
                when __TARGET__.target.click or
                        20084.chat."Lanet Kitab� " begin
                        target.delete("__TARGET__")
                        say_title("Biyolog Chaegirab:")
                        say("")
                        ---                                                   l
                        say("Oh Merhaba! Yaln�z canavarlar �zerine,")
                        say("bilgi toplam�yorum, de�i�ik ")
                        say("b�y�lerlede ilgileniyorum.")
                        say("Ama bunu yaln�z yapamam..")
                        say("Asl�nda bunu kendi ba��ma yapmam laz�m")
                        say("ama ne yaz�k ki m�mk�n de�il.")
                        say("Sen benim i�in bunu yapabilir misin? ")
                        say("�ok iyi �d�llendirileceksin!")
                        say("")
                        say("")
                        wait()
                        say_title("Biyolog Chaegirab:")
                        say("")
                        ---                                                   l
                        say("Ejderha vadisinin gizli bilgilerini ")
                        say("��renmek istiyorum..")
                        say("Bence onlar eski zaman�n b�y�lerini ")
                        say("iyi biliyorlar, onlarda lanet")
                        say("kitab� da var. Bu kitaplar bana")
                        say("eksik olan anahtar.")
                        say("Onlar� incelemem i�in")
                        say("her seferinde bir tane getir.")
						say("")
						say("")
                        wait()
                        say_title("Biyolog Chaegirab:")
                        say("")
                        say("Bana eski veya y�rt�k kitap getirme.")
                        say("Onlar de�ersiz.")
                        say("�nceleme i�in 15 kitap laz�m.")
                        say("")
                        say("Ama hep bir tane. Bol �anslar!")
                        say("")
                        set_state(go_to_disciple)
                        pc.setqf("duration",0) 
                        pc.setqf("collect_count",0)                        pc.setqf("drink_drug",0) 
                end
        end
        state go_to_disciple begin
                when letter begin
                        send_letter("Biyolo�un Ara�t�rmas� ")
                end
                when button or info begin
                        say_title("Ejderha Vadisinden Lanet Kitab� ")
                        ---                                                   l
                        say("")
                        say("Uriel'in ��rencisi Chaegirab Ejderha Vadisinin")
                        say("b�y�lerini ara�t�r�yor.")
                        say("Orada Lanet Kitaplar� da var.")
                        say("Chaegirab'a 15 Lanet kitab� getir.")
                        say("Ama tek tek.")
                        say("")
                        say_item_vnum(30047)
                        say_reward("�u anda ".." "..pc.getqf("collect_count").." Lanet Kitab� toplad�n.")
                        say("")
                end
				when 71035.use begin 
				if get_time() < pc.getqf("duration") then
				say("")
				say("Hen�z sihirli suyu kullanamazs�n.")
				say("")
				return
				end
                        if pc.getqf("drink_drug")==1 then
                                say("")
                                say("Yoksa kulland�n m�!")
                                say("")
                                return
                        end
                        if pc.count_item(30047)==0 then
                                say_title("Biyolog Chaegirab:")
                                say("")
                                say("Lanet Kitaplar�n� getirdi�in")
                                say("m�ddet�e sihirli suyu kulanabilirsin.")
                                say("")
                                return
                        end
                        item.remove()
                        pc.setqf("drink_drug",1)
                end

		when 20084.chat."GM: collect_quest_lv40.skip_delay" with pc.count_item(30047) >0 and pc.is_gm() and get_time() <= pc.getqf("duration") begin
			say(mob_name(20084))
			say("You are GM, OK")
			pc.setqf("duration", get_time()-1)
			return
		end
            when 20084.chat."Birle�mi� lanetlerin kitaplar� " with pc.count_item(30047) >0   begin
                        if get_time() > pc.getqf("duration") then
							if  pc.count_item(30047) >0 then
                                say_title("Biyolog Chaegirab:")
                                say("")
                                ---                                                   l
                                say("Oh!! Bana kitap getirdin...")
                                say("Incelemem laz�m...")
                                say("Bir dakika...")
                                say("")
                                pc.remove_item(30047, 1)
								if  is_test_server()  then 
									pc.setqf("duration",get_time()+2) 
								else
									pc.setqf("duration",get_time()+1) -----------------------------------22�ð�
				end
				wait()
				
                                local pass_percent
                                if pc.getqf("drink_drug")==0 then
                                        pass_percent=60
                                else
                                        pass_percent=90
                                end
                                local s= number(1,15)
                                if s<= pass_percent  then
								if pc.getqf("collect_count")< 14 then         
								 	local index =pc.getqf("collect_count")+1
									pc.setqf("collect_count",index)     
                                                     say_title("Chaegirab:")
						say("")
                                                	say("Ohh!! Harika! Te�ekk�r ederim...")
									say("".." "..15-pc.getqf("collect_count").. " tane kald�!")
									say("Bol �anslar!")
                                                say("")
                                                pc.setqf("drink_drug",0)         
                                                return
                                        end
                                        say_title("Biyolog Chaegirab:")
                                        say("")
                                        say("15 Kitap toplad�n!!")
                                        say("Yaln�z bir de tap�nak ruh ta�� laz�m,")
                                        say("onu anahtar olarak kullanaca��z.")
                                        say("Tap�na��n ruh ta��n�, tap�naktaki canavarlar�n")
                                        say("yan�nda bulacaks�n.")
                                        say("Bana bir tane getirecek misin?")
                                        say("")

                                        say("")
                                        pc.setqf("collect_count",0)
                                        pc.setqf("drink_drug",0)
                                        pc.setqf("duration",0)
                                        set_state(key_item)
                                        return
                                else
                                say_title("Biyolog Chaegirab:")
                                say("")
                                say("Hmm.... Bu y�rt�lm��...")
                                say("Kusura bakma. Bunu kullanamam.")
                                say("En �nemli par�a y�rt�k!")
                                say("L�tfen, yenisini getirir misin?")
                                say("")
                                pc.setqf("drink_drug",0)         
                                return
                        end
				else
                    say_title("Biyolog Chaegirab:")
					say(""..item_name(30047).." 'na sahip de�ilsin!")
					return
				end
                else
                  say_title("Biyolog Chaegirab:")
                  say("")
		  ---                                                   l
                  say("Kusura bakma....")
                  say("Getirdi�in ")
                  say("Kitab� hen�z incelemedim..")
                  say("�z�r dilerim.... Bana yenisini")
                  say("daha sonra getirebilir misin?")
                  say("")
                  return
                end
        end
end
        state key_item begin
                when letter begin
                        send_letter("Biyolo�un  Ara�t�rmas� ")
                        if pc.count_item(30221)>0 then
                                local v = find_npc_by_vnum(20084)
                                if v != 0 then
                                        target.vid("__TARGET__", v, "Chaegirap")
                                end
                        end
                end
                when button or info begin
                        if pc.count_item(30221) >0 then
                                say_title("Tap�na��n Ruh Ta�� ")
                                say("")
                                ---                                                   l
                                say("Nihayet! Ruh ta��n� ")
                                say("buldun, onu Chaegirab'a g�t�r.")
                                say("")
                                return
                        end
                        say_title("Tap�na��n Ruh ta�� ")
                        say("")
                        ---                                                   l
                        say("Uriel'in ��rencisi Chaegirab")
                        say("i�in 15 lanet kitab� ")
                        say("buldun, son olarak")
                        say("gizli mezhebin tap�na��ndan ruh ta�� laz�m.")
						say("")
						say_item_vnum(30221)
                        say("Onu bul ve Chaegirab'a g�t�r.")
						say("Ruh ta��n� "..mob_name(734).." , ")
						say(""..mob_name(735).." , "..mob_name(736).."")
						say("ve "..mob_name(737).." den alabilirsin.")
						say("")
                end
                when kill begin
				if npc.get_race() == 731 or npc.get_race() == 732 or npc.get_race() == 733 or npc.get_race() == 734 or npc.get_race() == 735 or npc.get_race() == 736 or npc.get_race() == 737 then
                        local s = number(1,300)
                        if s==1 then
                                pc.give_item2(30221,1)
                                send_letter("Gizli mezhebin tap�na��n�n ruh ta��'n� buldun.")
                        end
                end
				end
                when __TARGET__.target.click  or
                        20084.chat."Tap�na�'�n Ruh Ta��n� buldun" with pc.count_item(30221) > 0  begin
                        target.delete("__TARGET__")
						if pc.count_item(30221) > 0 then 
						say_title("Biyolog Chaegirab:")
						say("")
                        say("Ohh!!! Te�ekk�r ederim..")
                        say("�d�l olarak g�c�n� y�kseltiyorum ..")
						---                                                   l
                        say("Bu bir gizli re�ete, i�inde ")
                        say("g�� art�r�m� var...")
                        say("Onu Baek-Go'ya g�t�r. Sana bir i�ki yapacak.")
                        say("Iyi e�lenceler!")
                        say("Senin sayende �imdi eski b�y�leri tan�yorum .")
                        say("")
                        pc.remove_item(30221,1)
                        set_state(__reward)
			else
						say_title("Biyolog Chaegirab:")
				say(""..item_name(30221).." 'na sahip de�ilsin!")
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
                                target.vid("__TARGET__", v, "Baek-Go")
                        end
                end
                when button or info begin
                        say_title("Chaegirab'�n �d�l� ")
                        ---                                                   l
                        say("Lanet Kitaplar� ve Ruh Ta��n�n �d�l� olarak")
                        say("Biyolog Chaegirab sana gizli bir re�ete verdi.")
                        say("Baek-Go'ya g�t�r git, sana mucizevi bir iksir yapacak.")
                end
                when __TARGET__.target.click  or
                        20018.chat."Gizli re�ete"  begin
                    target.delete("__TARGET__")
                        say_title("Baek-Go:")
                        say("Ah bu Biyolog Chaegirab'�n re�etesi mi?")
                        say("Hm, bu sald�r� h�z�n� 5 puan art�racak. ��te")
                        say("iksirin! Ayn� zamanda sana bu sand��� da")
                        say("vermeliyim. Ona iyi bak.")                                             
                        say_reward("Chaegirab'�n iste�ini yerine getirmen")
                        say_reward("kar��l���nda, sald�r� h�z�n kal�c� olarak 5 puan")
                        say_reward("artt�.")
			affect.add_collect(apply.ATT_SPEED,5,60*60*24*365*60) --60��		
                        pc.give_item2("50110",1)
						pc.delqf("collect_count")
                        clear_letter()
                        set_quest_state("collect_quest_lv50", "run")
                        set_state(__complete)
                end
        end
        state __complete begin
        end
end
