----------------------------------------------------
--COLLECT maxmi
----------------------------------------------------
quest collect_quest_lv30  begin
        state start begin
                when login or levelup with pc.level >= 30 and pc.level <= 105 and not pc.is_gm() begin
                        set_state(information)
                end
        end
        state information begin
                when letter begin
                        local v = find_npc_by_vnum(20084)
                        if v != 0 then
                                target.vid("__TARGET__", v, "Biologist Chaegirab")
                        end
                        send_letter("Biyolo�un Ricas� ")
                end
                when button or info begin
                        say_title("Biyolo�un Ricas� ")
                        say("")
                        say("Uriel'in ��rencisi Biyolog Chaegirab, ")
                        say("seni ar�yor.")
                        say("Git ve ona yard�m et.")
                        say("")
                end
                when __TARGET__.target.click or
                        20084.chat."Ork Di�i" begin
                        target.delete("__TARGET__")
                        say_title("Biyolog Chaegirab:")
                        ---                                                   l
                        say("")
                        say("Aman!!! Bana , l�tfen yard�m et...")
                        say("Burada ya�ayan canavarlar hakk�nda")
                        say("bilgi topluyorum..")
                        say("Bunu yanl�z yapamam..")
                        say("Asl�nda bilgileri kendim ")
                        say("toplamam laz�m..")
                        say("Tahmin edebilece�in gibi,")
                        say("Biyolog olarak b�y�k sorunlar�m var.")
                        say("Bana l�tfen yard�m et, l�tfen...")
                        say("�al��malar�n i�in tabi ki")
                        say("�d�llendirileceksin.")
                        say("")
                        wait()
                        say_title("Biyolog Chaegirab:")
                        say("")
                        say("Ejderha vadisinin canavarlar�n� inceliyorum.")
                        say("Ork'lar�n az� di�leri demiri bile ")
                        say("�i�neyebiliyor. Bu �zellikleri y�z�nden")
                        say("onlar benim i�in �ok ilgin�.")
                        say("Herhalde orklar ile bir derecede")
                        say("akrabay�z..")
                        say("Orklar�n az� di�leri evrimin ")
                        say("anahtar� olmas� gerek.")
                        say("")
                        wait()
                        say_title("Biyolog Chaegirab:")
                        say("")
                        say("Bana ork az� di�i getirebilir misin ?")
                        say("Ama bana �zel az� di� laz�m! Bana")
                        say("bir �zel di� getir, ama hep tek tek")
                        say("Onu muayene edebilmek i�in.")
                        say("Bol �anslar!")
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
                        send_letter("Biyolo�un ara�t�rmas� ")
                end
                when button or info begin
                        say_title("Ejderha Vadisi'nden Ork di�i")
                        ---                                                   l
                        say("")
                        say("Biyolog Chaegirab Ejderha Vadisi'ndeki")
                        say("Orklar�n az� di�ini inceliyor. Ejderha")
                        say("vadisinden getirilecek di�ler ara�t�rmalar")
                        say("i�in laz�m. Daha iyi inceleyebilmesi i�in,")
                        say("ona di�leri tek tek getirmelisin..")
                        say("")
                        say("")
                        say_item_vnum(30006)
                        say_reward("�imdiye kadar ".." "..pc.getqf("collect_count").." tane ork di�i toplad�n.")
                        say("")
                end
                when 71035.use begin
                        if get_time() < pc.getqf("duration") then
                                say("")
                                say("Hen�z b�y�l� suyu kullanamazs�n.")
                                say("")
                                return
                        end
                        if pc.getqf("drink_drug")==1 then
                                say("")
                                say("Yoksa kulland�n m�!")
                                say("")
                                return
                        end
                        if pc.count_item(30006)==0 then
                                say_title("Biyolog Chaegirab:")
                                say("")
                                say("Bana az� di� getirirsen,")
                                say("b�y�l� suyu kullanabilirsin.")
                                say("")
                                return
                        end
                        item.remove()
                        pc.setqf("drink_drug",1)
                end

		when 20084.chat."GM: collect_quest_lv30.skip_delay" with pc.count_item(30006) >0 and pc.is_gm() and get_time() <= pc.getqf("duration") begin
			say(mob_name(20084))
			say("You are GM, OK")
			pc.setqf("duration", get_time()-1)
			return
		end
            when 20084.chat."Ork di�i" with pc.count_item(30006) >0   begin
                        if get_time() > pc.getqf("duration") then
							if  pc.count_item(30006) >0 then
                                say_title("Biyolog Chaegirab")
                                ---                                                   l
                                say("")
                                say("Ah!! Bana bir az� di�i getirdin.")
                                say("�nce denemem laz�m...")
                                say("Bu biraz zaman alabilir. Belki bir ka� g�n.")
                                say("Daha sonra yine gel.")
                                say("")
								pc.remove_item("30006",1)
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
                                local s= number(1,10)
                                if s<= pass_percent  then
                                   if pc.getqf("collect_count")< 9 then
                                                local index =pc.getqf("collect_count")+1
                                                pc.setqf("collect_count",index)
                                                say_title("Biyolog Chaegirab")
                                                say("")
                                                say("M�thi�!! Sen bir harikas�n...")
                                                say("�imdi bana bu ara�t�rma i�in ".." "..10-pc.getqf("collect_count").. "tane ")
                                                say("daha di� laz�m.")
                                                say("Tamamlamak i�in")
                                                say("Bol �anslar!")
                                                say("")
                                                say("")
                                                pc.setqf("drink_drug",0)
                                                return
                                        end
                                        say_title("Biyolog Chaegirab:")
                                        say("")
                                        say("Bana az� di�lerini toplad�n !!")
                                        say("Ama �imdi bana �zel bir ta� ")
                                        say("laz�m.  Jinunggy'nin ruh ta��, onu")
                                        say("bana getirebilir misin?")
                                        say("Onu Orklarda bulabilirsin. ")
                                        say("")
                                        pc.setqf("collect_count",0)
                                        pc.setqf("drink_drug",0)
                                        pc.setqf("duration",0)
                                        set_state(key_item)
                                        return
                                else
                                say_title("Biyolog Chaegirab:")
                                say("Hmm.... Ne yaz�k ki bu k�r�k...")
                                say("Bunu kullanamam..")
                                say("Bana bir tane daha getir.")
                                say("")
                                pc.setqf("drink_drug",0)
                                return
                                end
				else
                    say_title("Biyolog Chaegirab:")
					say(""..item_name(30006).." 'ne sahip de�ilsin!")
					return
				end
            else
                  say_title("Biyolog Chaegirab:")
		  ---                                                   l
		  say("")
                  say("�ok �z�r dilerim....")
                  say("Son Analiz daha bitmedi ")
                  say("Kusura bakma..")
                  say("Sonra bir daha ..")
                  say("gelebilir misin?")
		  say("")
                  say("")
                  say("")
                  return
                end
        end
end
        state key_item begin
                when letter begin
                        send_letter("Biyolo�un Ara�t�rmas� ")
                        if pc.count_item(30220)>0 then
                                local v = find_npc_by_vnum(20084)
                                if v != 0 then
                                        target.vid("__TARGET__", v, "")
                                end
                        end
                end
                when button or info begin
                        if pc.count_item(30220) >0 then
                                say_title("�zel Ta� ")
                                say("")
                                ---                                                   l
                                say_reward("Nihayet ruh ta��n� buldun.")
                                say_reward("Bu ta�� Biyolog Chargirab'a g�t�r.")
                                say_reward("Seni bekliyor.")
                                say("")
                                return
                        end
                        say_title("�zel Ta� ")
                        say("")
                        ---                                                   l
                        say("Ara�t�rmas� i�in ona ")
                        say("10 ork az� di�i bulduktan sonra,")
                        say("Jinunggy'nin ruh ta�� laz�m.")
                        say_item_vnum(30220)
                        say("Ta�� Biyolog Chaegirab'a g�t�r.")
						say("Ruh Ta��n� "..mob_name(635).." , ")
						say(""..mob_name(636).." ve "..mob_name(637).."")
						say("den alabilirsin.")
                        say("")
                end
				when kill begin
                       if npc.get_race() == 365 or npc.get_race() == 636 or npc.get_race() == 637 then
                                pc.give_item2(30220,1)
                                send_letter("Jinunggy'nin ruh ta��n� buldun.")
                        end
                end
                when __TARGET__.target.click  or
                        20084.chat."Jinunggy'nin Ruh Ta��'n� buldum" with pc.count_item(30220) > 0  begin
                        target.delete("__TARGET__")
						if pc.count_item(30220) > 0 then 
                        say_title("Biyolog Chaegirab")
			---                                                   l
                        say("")
                        say("Ohh!!! �ok te�ek�r ederim..")
                        say("�d�l olarak g�c�n y�kseliyor..")
                        say("Bu bir gizli re�ete , i�inde g�� ")
                        say("art�r�m� var...")
                        say("Baek-Go sana bir g�� iksiri yapacak, ona git.")
                        say("Iyi e�lenceler!")
                        say("Senin sayende orklar�n hayat� hakk�nda �ok �eyi")
                        say("��rendim.")
                        say("")
                        say("")
                        pc.remove_item(30220,1)
                        set_state(__reward)
			else
                say_title("Biyolog Chaegirab")
				say(""..item_name(30220).." 'na sahip de�ilsin!")
				say("")
				return
                end
        end

		end
        state __reward begin
                when letter begin
                        send_letter("Biyolo�un �d�l� ")
                        local v = find_npc_by_vnum(20018)
                        if v != 0 then
                                target.vid("__TARGET__", v, "Baek-Go")
                        end
                end
                when button or info begin
                        say_title("Biyolo�un �d�l� ")
                        ---                                                   l
                        say("")
                        say("Jinunggy'nin ruh ta�� ve az� di�lerinin")
                        say("�d�l� olarak sana,")
                        say("Baek-Go'dan harika ilac� alman i�in")
                        say("Biyolog Chaegirab gizli bir re�ete verdi.")
                        say("")
                end
				when __TARGET__.target.click  or
						20018.chat."Gizli Re�ete"  begin
						target.delete("__TARGET__")
						say_title("Baek-Go:")
						say("Ah bu Biyolog Chaegirab'�n re�etesi mi? Hm bu")
						say("senin hareket h�z�n� 10 puan art�racak. ��te")
						say("iksirin! Ayn� zamanda sana bu y�z��� vermeliyim.")
                        say("De�erli g�r�n�yor, kaybetme.") 
                        say("Oh, i�te �d�l�n!")
                       	say_reward("Chaegirab'�n ricas�n� tamamlad���n i�in �d�l")
                        say_reward("olarak hareket h�z�n kal�c� olarak 10 puan")
                        say_reward("art�r�ld�.")
						affect.add_collect(apply.MOV_SPEED, 10, 60*60*24*365*60) -- 60Years
						pc.give_item2(71015)
						pc.give_item2(50109)
                        clear_letter()
                        set_quest_state("collect_quest_lv40", "run")
                        set_state(__complete)
                end
        end
        state __giveup__ begin
                when 20084.chat."Bir deneme daha." begin
                        say_title("Biyolog Chaegirab:")
                        say("")
                        say("Bir daha denemek istiyor musun?")
                        say("Hmm..�ok iyi")
                        say("�ok be�endim ama, ")
                        say("L�tfen bir daha dene.")
                        say("G�r��mek �zere.")
                        set_state(start)
             end
         end
        state __complete begin
        end
end
