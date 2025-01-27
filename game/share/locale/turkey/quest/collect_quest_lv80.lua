----------------------------------------------------
--COLLECT maxmi
----------------------------------------------------
quest collect_quest_lv80  begin
        state start begin
        end
        state run begin
                when login or levelup with pc.level >= 80 and pc.level <= 106 and not pc.is_gm() begin
                        set_state(information)
                end
        end

        state information begin
                when letter begin
                        local v = find_npc_by_vnum(20084)
                        if v != 0 then
                                target.vid("__TARGET__", v, "Chaegirap")
                        end
                        send_letter("Chaegirab'�n iste�i")
                end

                when button or info begin
						say_title("Chaegirab'�n iste�i")
                        say("")
                        say("Uriel'in ��rencisi Biyolog Chaegirab'�n")
                        say("acil olarak yard�m�na ihtiyac� var.")
                        say("Haydi, onun yan�na git ve yard�m et.")
                        say("")
                end

                when __TARGET__.target.click or
                        20084.chat."Tugyis Tabelas� " begin
                        target.delete("__TARGET__")
                        say_title("Chaegirab:")
                        say("")
			---                                                   l
                    	say("Hey!!! Merhaba. Seni tekrar g�rd���me sevindim.")
                        say("Su aralar Y�lan Vadisi hakk�nda")
                        say("yaz�yorum. Asl�nda bunu kendim ba�armam")
                        say("gerekiyor, ama tek ba��ma ba�aramam....Benim i�in")
                        say("bunu yapar m�s�n? Tabii ki, yard�mlar�n")
                        say("kar��l���nda �ok iyi �d�llendirileceksin.")
                        wait()
                        say_title("Chaegirab:")
                        say("Gayretini takdir ediyorum. ")
                        say("Daha �nce Y�lan Vadisi'ni hi� duydun")
                        say("mu? Y�ksek da�lar ve ��llerden olu�an bir alan.")
                        say("Esrarengiz s�lahlar� ve z�rhlar� ile vadiyi")
                        say("koruyan ger�ekten korkun� hayaletler var.")
                        say("Bunlar dev gibi ve �ok g��l� hayaletler.")
                        say("Beni ilgilendir k�sm�, dogu�tan savas�� hayaleti")
                        say("olan�... L�tfen bana bu hayalet savas��")
                        say("hakk�nda bir kan�t getir.")
                        say("")
                        wait()
                        say_title("Chaegirab")
						say("")
                        say("Bu m�mk�n m�?")
                        say("Orada �u anda bir �ok sahte kan�t var. Sahteleri")
                        say("kullanamam...")
                        say("30 Savas�� Hayaleti deliline ihtiyac�m var...")
                        say("Iyi �anslar!")
                        say("")
                        set_state(go_to_disciple)
                        pc.setqf("duration",0)  
                        pc.setqf("collect_count",0)
                        pc.setqf("drink_drug",0)
			end
        end
        state go_to_disciple begin
                when letter begin
                        send_letter("Biyolo�un incelemesi")

                end
                when button or info begin
                        say_title("Devler Diyar�ndan Tugyis Tabelas� ")
                        ---                                                   l
                        say("")
                        say("Uriel'in ��ra�� Chaegirab, Y�lan " )
                        say("Vadisindeki Hayalet Savas��lar� inceliyor.")
                        say("Bu hayalet savas��lar kar�� konulmaz g��leriyle")
                        say("tan�n�yorlar. Bu hayaletlerden Chaegirab'a 30")
                        say("Tugyis Tabelas� getirmen gerekiyor.")
                        say("")
                        say_item_vnum(30166)
                        say_reward("�imdiye kadar ".." "..pc.getqf("collect_count").." tane tabela toplad�n.")
                        say("")
                end

                when 71035.use begin 
                        if get_time() < pc.getqf("duration") then
                                say("Mucize suyu kullanamazsin")
                                return
                        end
                        if pc.getqf("drink_drug")==1 then
                                say("Zaten kullandin.")
                                return
                        end
                        if pc.count_item(30166)==0 then
                                say_title("Chaegirab:")
								say("")
                                say("Savas�� hayaletlerini d�zenledi�in s�rece,")
                                say("mucize suyu kullanabilirsin.")
                                say("")
                                return
                        end

                        item.remove()
                        pc.setqf("drink_drug",1)
					end
					when kill begin
				if  npc.get_race() == 1401 or  npc.get_race() == 1402 or npc.get_race() == 1403 or npc.get_race() == 1601 or npc.get_race() == 1602 or 1603 then
						local s = number(1, 100)
							if s == 1  then
								pc.give_item2(30166)
								send_letter("Tugyis Tabelas� buldun")		
							end
						end
						end			
            when 20084.chat."Tugyis Tabelas� " with pc.count_item(30166) >0   begin
                        if get_time() > pc.getqf("duration") then
                                say_title("Chaegirab")
                                ---                                                   l
                                say("")
                                say("Oh!! Bana bir delil mi getirdin...")
                                say("Kontrol edece�im..")
                                say("Bir dakika l�tfen..")
                                say("")
                                pc.remove_item(30166, 1)
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

                                local s= number(1,30)
                                if s<= pass_percent  then
                                   if pc.getqf("collect_count")< 29 then     --weniger als 30
                                                local index =pc.getqf("collect_count")+1
                                                pc.setqf("collect_count",index)                                                     
												say("Chaegirab:")
                                                say("Ohh!! Muhte�em! Te�ekk�rler...")
                                                say("Geriye ".." "..30-pc.getqf("collect_count").. " tane kald�.")
                                                say("Bol �ans!")
                                                say("")
                                                pc.setqf("drink_drug",0)                                                         
												return
                                        end
                                        say_title("Chaegirab:")
                                        say("30 delili de toplad�n!!")
                                        say("Geriye sadece hayalet savas��lar�n�n Ruh")
                                        say("Ta��'n� almak kald�, bu anahtar g�revi yapacak.")
                                        say("Ruh Ta��'n� vadideki hayalet savas��lardan")
                                        say("kazanabilirsin. Bunu benim i�in")
                                        say("yapar misin?")
                                        say("")
                                        pc.setqf("collect_count",0)
                                        pc.setqf("drink_drug",0)
                                        pc.setqf("duration",0)
                                        set_state(key_item)
                                        return
                                else
                                say_title("Chaegirab:")
                                say("Hmm..Bu yanl��...")
                                say("�zg�n�m, bunu kullanamam.")
                                say("Bu ta��n i�inde farkl� g��ler olabilir.")
                                say("L�tfen, ba�ka bir tane bul.")
                                say("")
                                pc.setqf("drink_drug",0)                                         
								return
                                end
                  else
                  say_title("Chaegirab:")
				  say("")
				  ---                                                   l
                  say("Son derece �zg�n�m...")
                  say("Hen�z bana getirdi�in di�er tabelay� ")
                  say("incelemeyi bitirmedim.....")
                  say("Hmm, �ok �zg�n�m.... Di�erini daha sonra getirebilir misin?")
                  say("")
                  return
                end

end
end


        state key_item begin
                when letter begin
                        send_letter("Chaegirab'�n ara�t�rmas� ")

                        if pc.count_item(30225)>0 then
                                local v = find_npc_by_vnum(20084)
                                if v != 0 then
                                        target.vid("__TARGET__", v, "Chaegirap")
                                end
                        end

                end
                when button or info begin
                        if pc.count_item(30225) >0 then
                                say_title("Tugyinin Ruh Ta�� ")
                                say("")
                                ---                                                   l
                                say("Sonunda Tugyinin Ruh Ta��'n� buldun.")
                                say("Onu Chaegirab'a g�t�r.")
                                say("")
                                return
                        end

                        say_title("Tugyinin Ruh Ta�� ")
                        say("")
                        ---                                                   l
                        say("Uriel'in ��ra�� Chaegirab'�n ara�t�rmas� i�in ")
                        say("hayalet savas��lara ait 30 Tugyis Tabelas� toplad�n.")
                        say("Son olarak ihtiya� duyulan Tugyinin")
                        say("Ruh Ta��.")
                        say_item_vnum(30225)
                        say("Onu Y�lan Vadisindeki hayalet savas��lardan ")
                        say("kazanabilirsin. Onu Chaegirab'a ver.")
                        say("")
                        say("")
                end


					when kill begin
					if npc.get_race() == 1401 or npc.get_race() == 1402 or npc.get_race() == 1403 or npc.get_race() == 1601 or npc.get_race() == 1602 or npc.get_race() == 1603 then
                        local s = number(1,200)
                        if s==1 then
                                pc.give_item2(30225,1)
                                send_letter("Tugyinin Ruh Ta��'n� kazand�n.")
                        end
                end
				end




                when __TARGET__.target.click  or
                        20084.chat."Ruh Ta��'n� buldun." with pc.count_item(30225) > 0  begin
                    target.delete("__TARGET__")
                        say_title("Chaegirab:")
			say("")
			---                                                   l
                        say("Ohh!!! Te�ekk�rler.. Te�ekk�rler..")
                        say("�d�l olarak senin i� g��lerini art�raca��m..")
                        say("Bu gizli bir re�ete, i�inde bu g��lerle ilgili")
                        say("gerekli bilgiler var...")
                        say("Bunu Baek-Go'ya ver. Sana bir g�� iksiri ")
                        say("haz�rlayacak. Iyi e�lenceler!")
                        say("Te�ekk�r ederim, sayende hayalet savas��lar� ")
                        say("art�k biliyorum!")
                        say("")
                        pc.remove_item(30225,1)
                        set_state(__reward)
                end

        end

        state __reward begin
                when letter begin
                        send_letter("Chaegirab'�n �d�l� ")

                        local v = find_npc_by_vnum(20018)
                        if v != 0 then
                                target.vid("__TARGET__", v, "Baek Go")
                        end

                end
                when button or info begin
                        say_title("Chaegirab'�n �d�l� ")
                        ---                                                   l
                        say("Tabelalar�n ve ruh ta��n�n �d�l� olarak")
                        say("biyolog Chaegirab sana gizli bir re�ete verdi.")
                        say("�imdi Baek-Go'ya git, senin i�in mucizevi bir ")
                        say("iksir yapacak.")
                end

                when __TARGET__.target.click  or
                        20018.chat."Gizli Re�ete"  begin
                    target.delete("__TARGET__")
                        say_title("Baek-Go:")
						say("Ah, bu biyolog Chaegirab'�n gizli re�etesi mi?")
                        say("Hm, bu sald�r� de�erini %10 ve sald�r� h�z�n� 6")
                        say("puan art�racak. ��te iksirin!")
                        wait()
                        say_title("Baek-Go:")
						say("Ayn� zamanda sana bu Mavi Abanoz Sand��� da")
                        say("vermeliyim. Ona iyi bak.")
                        say_reward("Chagirab'�n iste�ini tamamlad���n i�in kal�c� ")
                        say_reward("olarak sald�r� de�erin %10 ve sald�r� h�z�n 6")
                        say_reward("puan artt�.")
						affect.remove_collect(apply.ATT_SPEED, 5, 60*60*24*365*60)
                        affect.add_collect(apply.ATT_SPEED,11,60*60*24*365*60) --60Jahre
						affect.add_collect_point(POINT_ATT_BONUS,10,60*60*24*365*60) --60��	
                        pc.give_item2("50114",1)
						pc.delqf("collect_count")
                        clear_letter()
						set_quest_state("collect_quest_lv85", "run")
                        set_state(__complete)
                end

        end


        state __complete begin
        end
end
