----------------------------------------------------
--COLLECT maxmi
----------------------------------------------------
quest collect_quest_lv50  begin
        state start begin
        end
        state run begin
                when login or levelup with pc.level >= 50 and pc.level <= 106 and not pc.is_gm() begin
                        set_state(information)
                end
        end
        state information begin
                when letter begin
                        local v = find_npc_by_vnum(20084)
                        if v != 0 then
                                target.vid("__TARGET__", v, "Chaegirap")
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
                        20084.chat."�eytan Hat�ras� " begin
                        target.delete("__TARGET__")
                        say_title("Chaegirab:")
                        say("")
			---                                                   l
                    	say("Hey!!")
                        say("Bu kez de�i�ik canavarlarla ")
                        say("ilgileniyorum...")
                        say("G�rd���n gibi, bunu yaln�z")
                    	say("yapmam m�mk�n de�il.")
                        say("E�er onlarla u�ra��rsam, burdaki incelemelerimi")
                        say("yapamam.. Bana yard�m et, l�tfen...")
                        say("�abalar�n en iyi �ekilde �d�llendirilecektir.")
			say("")
                        wait()
			say_title("Chaegirab:")
			say("")
                        say("Bu defa �eytan Kulesindeki �eytan Hat�ralar�n� ")
                        say("inceliyorum.. Bir g�z atmak bile")
                        say("onlar�n ne kadar k�t� oldu�unu anlamak i�in")
                        say("yeterli. �nceleme i�in bana �eytan hat�ralar�ndan")
                        say("�rnekler laz�m.")
                        say("")
                        wait()
			say_title("Chaegirab:")
			say("")
                        say("Bana �eytan hat�ralar�ndan")
                        say("�rnek getirmek i�in ne kadar zamana ihtiyac�n")
                        say("var? �eytan Hat�ralar�n�n de�i�ik dereceleri var,")
                        say("alt derecede olanlar�n kalitesi k�t�, bana")
                        say("yaln�z y�ksek dereceli �eytan hat�ras� �rnekleri ")
                        say("getir.. Bana 15 tane numune getir... ")
                        say("Bol �anslar!")
                        say("")
                        set_state(go_to_disciple)
                        pc.setqf("duration",0)
                        pc.setqf("collect_count",0)
                        pc.setqf("drink_drug",0) 
                end
        end
        state go_to_disciple begin
                when letter begin
                        send_letter("Biyolo�un Ara�t�rmas� ")
                end
                when button or info begin
                        say_title("�eytan Kulesinden �eytan Hat�ras� ")
                        ---                                                   l
                        say("")
                        say("Uriel'in ��rencisi Chaegirab,")
                        say("�eytan Kulesi'ndeki �eytan Hat�ralar�n� inceliyor.")
                        say("�nceleme i�in �eytan Hat�ralar�ndan �rnekler laz�m.")
                        say("Ona 15 tane �eytan Hat�ras� numunesi getirmelisin.")
                        say("")
                        say_item_vnum(30015)
                        say_reward("�u ana kadar ".." "..pc.getqf("collect_count").." tane toplad�n.")
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
                        if pc.count_item(30015)==0 then
                                say_title("Chaegirab:")
				say("")
				---                                                   l
                                say("�eytan Kulesindeki �eytan Hat�ralar�n� ")
                                say("toplad�ktan sonra sihirli ")
                                say("suyu kullanabilirsin.")
                                say("")
                                return
                        end
                        item.remove()
                        pc.setqf("drink_drug",1)
                end
		when 20084.chat."GM: collect_quest_lv50.skip_delay" with pc.count_item(30015) >0 and pc.is_gm() and get_time() <= pc.getqf("duration") begin
			say(mob_name(20084))
			say("You are GM, OK")
			pc.setqf("duration", get_time()-1)
			return
		end
            when 20084.chat."�eytan Hat�ras� " with
		pc.count_item(30015) >0   begin
                        if get_time() > pc.getqf("duration") then
                                say_title("Chaegirab:")
				say("")
                                ---                                                   l
                                say("Oh!! Getirdin mi?...")
                                say("�ncelemem laz�m...")
                                say("Bir dakika...")
                                say("")
                                pc.remove_item(30015, 1)
                                pc.setqf("duration",get_time()+1) 
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
                                                say("Ohh!! Harika! Sa�ol...")
                                                say("Ve ".." "..15-pc.getqf("collect_count").. " tane daha laz�m!")
                                                say("Bol �ans!")
                                                say("")
                                                pc.setqf("drink_drug",0)        
                                                return
                                        end
                                        say_title("Chaegirab:")
					say("")
					---                                                   l
                                        say("15 tane toplad�n!!")
                                        say("Hepsini �rnek olarak kulanabiliriz.")
                                        say("Yaln�z, Sagyinin Ruh Ta�� laz�m.")
                                        say("Bunu yapabilir misin?")
                                        say("�eytan Kulesindeki yarat�klardan")
                                        say("Sagyinin Ruh Ta��'n� kazanabilirsin.")
                                        say("")
                                        pc.setqf("collect_count",0)
                                        pc.setqf("drink_drug",0)
                                        pc.setqf("duration",0)
                                        set_state(key_item)
                                        return
                                else
                                say_title("Chaegirab:")
				say("")
                                say("Hmm.... �ok �izik var...")
                                say("Kusura bakma ama. Bu art�k i�e yaramaz.")
                                say("Bir tane daha getirmelisin.")
                                say("")
                                pc.setqf("drink_drug",0)                                         return
                                end
                else
                  say_title("Chaegirab:")
		  say("")
		  ---                                                   l
                  say("Kusura bakma..")
                  say("Son analiz,")
                  say("daha bitmedi...")
                  say("�z�r dilerim. Sonra")
                  say("tekrar getirebilir misin?")
                  say("")
                  return
                end
        end
end
        state key_item begin
                when letter begin
                        send_letter("Biyolo�un  Ara�t�rmas� ")
                        if pc.count_item(30222)>0 then
                                local v = find_npc_by_vnum(20084)
                                if v != 0 then
                                        target.vid("__TARGET__", v, "Chaegirap")
                                end
                        end
                end
                when button or info begin
                        if pc.count_item(30222) >0 then
                                say_title("Sagyinin Ruh Ta��'n� kazand�n.")
                                say("")
                                ---                                                   l
                                say("Nihayet! Sagyinin Ruh Ta��'n� ald�k.")
                                say("Onu Chaegirab'a g�t�relim.")
                                say("")
                                return
                        end
                        say_title("Bana Sagyinin Ruh Ta�� laz�m")
                        say("")
                        ---                                                   l
                        say("Chaegirab'�n incelemesi i�in, 15 tane")
				say("�eytan Hat�ras� ")
                        say("numunesi buldun. Son olarak")
                        say("Sagyinin Ruh Ta�� laz�m.")
			say("")
                        say_item_vnum(30222)
                        say("Ruh ta��n� bulup,")
                        say("Chaegirab'a g�t�r.")
                        say("")
                end
                when kill begin
				if npc.get_race() == 1001 or npc.get_race() == 1002 or npc.get_race() == 1003 or npc.get_race() == 1004 then
                        local s = number(1,300)
                        if s==1 then
                                pc.give_item2(30222,1)
                                send_letter("Sagyinin Ruh Ta��'n� kazand�n.")
                        end
                end
				end
                when __TARGET__.target.click  or
                        20084.chat."Sagyinin Ruh Ta��'n� yan�mda getirdim" with
		pc.count_item(30222) > 0  begin
                    target.delete("__TARGET__")
                        say_title("Chaegirab")
			say("")
			---                                                   l
                        say("Ohh!!! Te�ekk�r ederim..")
                        say("�d�l olarak g�c�n� y�kseltiyorum..")
                        say("Sana vermi� oldu�um")
                        say("gizli bir re�ete...")
                        say("Baek-Go sana mucize ilac� yapacak..")
                        say("Iyi e�lenceler!")
                        say("Senin yard�m�nla �imdi �eytan Kulesinin")
                        say("s�rlar�n� ��reniyorum!")
                        say("")
                        pc.remove_item(30222,1)
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
                        say("�eytan Hat�ralar� ve Ruh Ta��n�n �d�l� olarak")
                        say("Biyolog Chaegirab sana gizli bir re�ete verdi.")
                        say("Baek-Go'ya git, sana mucizevi bir iksir yapacak.")
                end
                when __TARGET__.target.click  or
                        20018.chat."Gizli re�ete"  begin
	                target.delete("__TARGET__")
                        say_title("Baek Go:")                                            
                        say("Ah, bu biyolog Chaegirab'�n gizli re�etesi mi?")
                        say("Hm, bu defans�n� 60 puan art�racak. ��te")
                        say("iksirin! Ayn� zamanda sana bu sand��� da")
                        say("vermeliyim. Ona iyi bak.")
			-----------                                                   l
                        say_reward("Chaegirab'�n iste�ini yerine getirdi�in i�in")
                        say_reward("defans�n kal�c� olarak 60 puan artt�.")
                        affect.add_collect(apply.DEF_GRADE_BONUS,60,60*60*24*365*60) 
                        pc.give_item2("50111",1)
						pc.delqf("collect_count")
                        clear_letter()
                        set_quest_state("collect_quest_lv60", "run")
                        set_state(__complete)
                end
        end
        state __complete begin
        end
end
