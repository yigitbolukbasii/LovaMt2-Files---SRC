----------------------------------------------------
--COLLECT maxmi
----------------------------------------------------
quest collect_quest_lv70  begin
        state start begin
        end
        state run begin
                when login or levelup with pc.level >= 70 and pc.level <= 106 and not pc.is_gm() begin
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
                        say("Uriel'in ��ra�� Biyolog Chaegirab'�n,")
                        say("acil olarak yard�m�na ihtiyac� var.")
                        say("�abuk ol ve ona yard�m et.")
                        say("")
                end

                when __TARGET__.target.click or
                        20084.chat."Zelkova Dal� " begin
                        target.delete("__TARGET__")
                        say_title("Chaegirap:")
			say("")
                        ---                                                   l
                    say("Hey! Tekrar merhaba!")
                        say("Yard�mlar�n i�in minnettar�m.")
                        say("Hayalet Orman hakk�nda yaz�yorum..")
                        say("Asl�nda bunu kendim denemem gerekiyor ,")
                    say("ama bu m�mk�n de�il. Bu i�i benim i�in ")
                        say("yapabilir misin? Tabii ki bana yard�m etti�in")
                        say("i�in iyi bir �d�l alacaks�n..")
                        say("")
                        say("")
                        wait()
			say_title("Chaegirab:")
			say("")
                        say("Bana Hayalet Orman hakk�nda bildiklerini anlat.")
                        say("Hayalet Orman hakk�nda daha fazla �ey bilmek")
                        say("istiyorum.. Oras�, meteorlar d��meden �nce k�t� ")
                        say("enerjiyle dolu b�y�k b�y�k bir a�a�l�kt�.")
                        say("Eski zamanlarda bir k�t� hayaletin y�netimi")
                        say("alt�ndayd�. Benim i�in hayalet ormandan Zelkova")
                        say("Dal� getirebilir misin?..")
                        say("")
                        wait()
                        say_title("Chaegirab:")
			say("")
                        say("Dallar� bana getirebilmek i�in ne kadar zamana")
                        say("ihtiyac�n var? Bana k�r�k ya da �ok ince")
                        say("dallar� getirme!. �yle dallar� kullanamam....")
                        say("Ara�t�rmam i�in bana tam olarak 25 dal laz�m.")
                        say("Bol �anslar.")
                        say("")
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
                        say_title("Hayalet Ormandan Zelkova Dal� ")
                        ---                                                   l
                        say("")
                        say("Uriel'in ��ra�� Chaegirab, Hayalet Orman'� ")
                        say("inceliyor. Bu inceleme i�in hayalet ormandan")
                        say("gelecek Zelkova dallar�na ihtiyac� var. Ormana")
                        say("giri�, �ok �zel yetenekleri olan a�a�lar")
                        say("taraf�ndan engellenmi� durumda. Chaegirab'a")
                        say("birer birer 25 tane dal getir.")
                        say_item_vnum(30165)
                        say_reward("Zaten toplad���n "..pc.getqf("collect_count").." dal var.")
                        say("")
                end

                when 71035.use begin --DasVerwirrungswasser
                        if get_time() < pc.getqf("duration") then
                                say("Karga�a suyunu kullanamazsin.")
                                return
                        end
                        if pc.getqf("drink_drug")==1 then
                                say("Zaten kulland�m.")
                                return
                        end
                        if pc.count_item(30165)==0 then
                                say_title("Chaegirab:")
				say("")
				-----                                                   l
                                say("Hayalet orman�n dallar�n� d�zenledi�in s�rece,")
                                say("karga�a suyunu kullanabilirsin.")
                                say("")
                                return
                        end

                        item.remove()
                        pc.setqf("drink_drug",1)
                end
				when kill begin
			if  npc.get_race() == 2302 or  npc.get_race() == 2303 or 2304 then
					local s = number(1, 200)
						if s == 1  then
							pc.give_item2(30165)
							send_letter("Zelkova Dal� buldun")		
						end
					end
					end

		when 20084.chat."GM: collect_quest_lv70.skip_delay" with pc.count_item(30165) >0 and pc.is_gm() and get_time() <= pc.getqf("duration") begin
			say(mob_name(20084))
			say("You are GM, OK")
			pc.setqf("duration", get_time()-1)
			return
		end
         when 20084.chat."Dallar� getirdin mi? " with pc.count_item(30165) >0   begin
                        if get_time() > pc.getqf("duration") then
                                say("Chaegirab")
                                ---                                                   l
                                say("Oh!! Bana bir dal getirdin..")
                                say("Kontrol edece�im...")
                                say("Bir dakika l�tfen...")
                                say("")
                                pc.remove_item(30165, 1)
                                pc.setqf("duration",get_time()+1)                             
								wait()
                                local pass_percent
                                if pc.getqf("drink_drug")==0 then
                                        pass_percent=60
                                else
                                        pass_percent=90
                                end

								local s= number(1,25)
                                if s<= pass_percent  then
                                   if pc.getqf("collect_count")< 24 then                                                     
									   local index =pc.getqf("collect_count")+1
                                       pc.setqf("collect_count",index)     
                                       say_title("Chaegirab:")
                                                say("Ohh!! Muhte�em! Te�ekk�r ederim..")
                                                say("Geriye sadece ".." "..25-pc.getqf("collect_count").. " dal kald�.")
                                                say("Bol �ans!")
                                                say("")
                                                pc.setqf("drink_drug",0)        
                                                return
                                        end
                                        say_title("Chaegirab:")
										say("")
                                        ---                                                   l
                                        say("25 dal�n tamam�n� toplad�n!!")
                                        say("Geriye sadece hayalet aga�lardan al�nacak")
                                        say("ruh ta�� kald�. Bu anahtar vazifesi g�recek.")
                                        say("Ruh ta�� hayalet a�a�lardan elde edilebilir.")
                                        say("Benim i�in bir tane temin edebilir misin??")
                                        say("")
                                        pc.setqf("collect_count",0)
                                        pc.setqf("drink_drug",0)
                                        pc.setqf("duration",0)
                                        set_state(key_item)
                                        return
                                else
                                say_title("Chaegirab:")
				say("")
                                say("Hmm...")
                                say("�zg�n�m. Bunu kullanamam..")
                                say("�ok ince ve bir ka� yerinden k�r�lm��..")
                                say("L�tfen ba�ka bir tane bul.")
                                say("")
                                pc.setqf("drink_drug",0)                                       
						      	return
                                end
            				    else
			                  say_title("Chaegirab:")
		  say("")
		  ---                                                   l
                  say("Son derece �zg�n�m....")
                  say("Getirdi�in dal� hen�z incelemedim ...")
                  say("�ok �zg�n�m....Bana di�erini daha sonra")
                  say("getirebilir misin?")
                  say("")
                  say("")
                  return
                end

        end
end


        state key_item begin
                when letter begin
                        send_letter("Biyolo�un incelemesi")

                        if pc.count_item(30224)>0 then
                                local v = find_npc_by_vnum(20084)
                                if v != 0 then
                                        target.vid("__TARGET__", v, "Chaegirap")
                                end
                        end

                end
                when button or info begin
                        if pc.count_item(30224) >0 then
                                say_title("Gyimokun Ruh Ta��'n� buldun")
                                say("")
                                ---                                                   l
                                say("Sonunda Gyimokun Ruh Ta��'n� buldun.")
                                say("Onu Chaegirab'a g�t�r.")
                                say("")
                                return
                        end

                        say_title("Gyimokun Ruh Ta�� ")
                        say("")
                        ---                                                   l
                        say("Uriel'in ��ra��, Chaegirab'�n incemelesi i�in,")
                        say("Hayalet Orman'dan 25 tane Zelkova Dal� toplad�n,")
                        say("geriye Hayalet a�a�lardan al�nacak Ruh Ta�� kald�.")
                        say_item_vnum(30224)----------The Ghost��s Soul Stone
                        say("Onu temin edip,")
                        say("Chaegirab'a g�t�r.")
                        say("")
                end



		when kill begin
		if npc.get_race() == 2302 or npc.get_race() == 2303 or npc.get_race() == 2304 or npc.get_race() == 2305 then
                        local s = number(1,300)
                        if s==1 then
                                pc.give_item2(30224,1)
                                send_letter("Gyimokun Ruh Ta��'n� Hayalet a�a�lardan ald�n.")
                        end
                end
				end



                when __TARGET__.target.click  or
                        20084.chat."Ruh ta��n� buldun." with pc.count_item(30224) > 0  begin
                    target.delete("__TARGET__")
			say_title("Chaegirap:")
			say("")
		  	---                                                   l
                        say("Hey!!! �ok �ok te�ekk�r ederim...")
                        say("�d�l olarak senin i� g�c�n� art�raca��m ..")
                        say("Bu gizli re�ete, g�� hakkinda bilgi i�eriyor....")
                        say("Bunu Baek-Go'ya ver. Sana bu g�c� verecek")
                        say("olan iksiri haz�rlayacak.")
                        say("Iyi e�lenceler!")
                        say("Te�ekk�r ederim, Hayalet orman art�k ")
                        say("bildi�im bir yer.")
                        say("")
                        pc.remove_item(30224,1)
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
                        say("Zelkova dallar�n�n ve ruh ta��n�n �d�l� olarak")
                        say("biyolog Chaegiran sana gizli bir re�ete verdi.")
                        say("�imdi Baek-Go'ya git, senin i�in mucizevi bir ")
                        say("iksir yapacak.")
                end

                when __TARGET__.target.click  or
                        20018.chat."Gizli Re�ete"  begin
                    target.delete("__TARGET__")
                        say_title("Baek-Go:")                                          
                        say("Ah, bu biyolog Chaegirab'�n gizli re�etesi mi?")
                        say("Hm, bu senin dayan�kl�l���n� %10 ve hareket")
                        say("h�z�n� 11 puan art�racak. ��te iksirin!")
                        wait()
                        say_title("Baek-Go:")
                        say("Sana bu Ye�il Abanoz Sand��� da vermeliyim. Ona")
                        say("iyi bak.")
                        say_reward("Chagirab'�n iste�ini yerine getirdi�in i�in")
                        say_reward("kal�c� olarak")
                        say_reward("sald�r� dayan�kl�l���n %10 ve hareket h�z�n 11")
                        say_reward("puan artacak.")
						affect.remove_collect(apply.MOV_SPEED, 10, 60*60*24*365*60)
						affect.add_collect(apply.MOV_SPEED,21,60*60*24*365*60)	
						affect.add_collect_point(POINT_DEF_BONUS,10,60*60*24*365*60) --60��		
                        pc.give_item2("50113",1)
						pc.delqf("collect_count")
                        clear_letter()
                        set_quest_state("collect_quest_lv80", "run")
                        set_state(__complete)
                end

        end


        state __complete begin
        end
end
