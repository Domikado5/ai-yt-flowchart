(deftemplate UI-state
   (slot id (default-dynamic (gensym*)))
   (slot display)
   (slot relation-asserted (default none))
   (slot response (default none))
   (multislot valid-answers)
   (slot state (default middle)))
   
(deftemplate state-list
   (slot current)
   (multislot sequence))
  
(deffacts startup
   (state-list))
   
;;; Startup
(defrule system-banner ""

  =>
  
  (assert (UI-state (display "Welcome! Press Next to continue.")
                    (relation-asserted start)
                    (state initial)
                    (valid-answers))))

;;; So you want to watch YouTube?
(defrule determine-yt-type ""

   (logical (start))

   =>

   (assert (UI-state (display "So you want to watch YouTube?")
                     (relation-asserted yt-type)
                     (response Vlogger)
                     (valid-answers Vlogger))))
;;; Do you want a collab or single channel?
(defrule determine-collab-single ""

   (logical (yt-type Vlogger))

   =>

   (assert (UI-state (display "Do you want a collab or single channel?")
                     (relation-asserted collab-single)
                     (response Collab)
                     (valid-answers Collab Single))))
;;; Do you want to watch new video or two year old videos?   
(defrule determine-old-new ""

   (logical (collab-single Collab))

   =>

   (assert (UI-state (display "Do you want to watch new video or two year old videos?")
                     (relation-asserted new-old)
                     (response New)
                     (valid-answers New Old))))
;;; People in relationships make you...   
(defrule determine-relationships ""

   (logical (new-old New))

   =>

   (assert (UI-state (display "People in relationships make you...")
                     (relation-asserted relationships)
                     (response Happy)
                     (valid-answers Happy Sick))))

;;; leaf vloglovers
(defrule vloglovers-conclusions ""

   (logical (relationships Happy))
   
   =>

   (assert (UI-state (display vloglovers)
                     (state final))))
;;; Are you obsessed with doctor who?
(defrule determine-doctor-who ""

   (logical (relationships Sick))

   =>

   (assert (UI-state (display "Are you obsessed with doctor who?")
                     (relation-asserted doctor-who)
                     (response Absolutely)
                     (valid-answers Absolutely WhatsThat))))

;;; leaf tardistacular
(defrule tardistacular-conclusions ""

   (logical (doctor-who Absolutely))
   
   =>

   (assert (UI-state (display tardistacular)
                     (state final))))
;;; How many people do you want to watch?
(defrule determine-how-many ""

   (logical (doctor-who WhatsThat))

   =>

   (assert (UI-state (display "How many people do you want to watch?")
                     (relation-asserted how-many-people)
                     (response Five)
                     (valid-answers Five Two))))
;;; leaf fiveawesomegirls
(defrule fiveawesomegirls-conclusions ""

   (logical (how-many-people Five))
   
   =>

   (assert (UI-state (display fiveawesomegirls)
                     (state final))))
;;; Do you want to watch short or tall people?
(defrule determine-short-tall ""

   (logical (how-many-people Two))

   =>

   (assert (UI-state (display "Do you want to watch short or tall people?")
                     (relation-asserted short-tall)
                     (response Short)
                     (valid-answers Short Tall))))

;;; leaf shortsisters756
(defrule shortsisters-conclusions ""

   (logical (short-tall Short))
   
   =>

   (assert (UI-state (display shortsisters756)
                     (state final))))
;;; Girls Or Boys?
(defrule determine-girls-boys ""
  
   (logical (short-tall Tall))

   =>
   
   (assert (UI-state (display "Girls Or Boys?")
                     (relation-asserted girls-boys)
                     (response Girls)
                     (valid-answers Girls Boys))))
;;; leaf sistersalad
(defrule sistersalad-conclusions ""

   (logical (girls-boys Girls))
   
   =>

   (assert (UI-state (display sistersalad)
                     (state final))))
                
;;; leaf vlogbrothers
(defrule vlogbrothers-conclusions ""

   (logical (girls-boys Boys))
   
   =>

   (assert (UI-state (display vlogbrothers)
                     (state final))))

;;; leaf fiveawesomeguys
(defrule fiveawesomeguys-conclusions ""

   (logical (new-old Old))
   
   =>

   (assert (UI-state (display fiveawesomeguys)
                     (state final))))

;;; What kind of accent do you like?
(defrule determine-accent ""
  
   (logical (collab-single Single))

   =>
   
   (assert (UI-state (display "What kind of accent do you like?")
                     (relation-asserted accent-like)
                     (response SthElse)
                     (valid-answers SthElse British American))))
;;; Canada's cool, right?
(defrule determine-canada ""
  
   (logical (accent-like SthElse))

   =>
   
   (assert (UI-state (display "Canada's cool, right?")
                     (relation-asserted canada-cool)
                     (response Yeah!)
                     (valid-answers Yeah! CanadaSucks))))
;;; leaf Gunarolla
(defrule gunarolla-conclusions ""

   (logical (canada-cool Yeah!))
   
   =>

   (assert (UI-state (display gunarolla)
                     (state final))))
;;; Which is funnier?
(defrule determine-funnier ""
  
   (logical (canada-cool CanadaSucks))

   =>
   
   (assert (UI-state (display "Which is funnier?")
                     (relation-asserted funnier-which)
                     (response JokesAboutChickens)
                     (valid-answers JokesAboutChickens SelfDepricatingHumor))))
;;; leaf robofillet
(defrule robofillet-conclusions ""

   (logical (funnier-which JokesAboutChickens))
   
   =>

   (assert (UI-state (display robofillet)
                     (state final))))
;;; leaf communitychannel
(defrule communitychannel-conclusions ""

   (logical (funnier-which SelfDepricatingHumor))
   
   =>

   (assert (UI-state (display communitychannel)
                     (state final))))
;;; Do you find David Tennant attractive?
(defrule determine-david-tennant ""
  
   (logical (accent-like British))

   =>
   
   (assert (UI-state (display "Do you find David Tennant attractive?")
                     (relation-asserted david-attractive)
                     (response Duh)
                     (valid-answers Duh No))))
;;; leaf littleradge
(defrule littleradge-conclusions ""

   (logical (david-attractive Duh))
   
   =>

   (assert (UI-state (display littleradge)
                     (state final))))
;;; Well then, are boys who play an instrument hot?
(defrule determine-boys-instrument ""
  
   (logical (david-attractive No))

   =>
   
   (assert (UI-state (display "Well then, are boys who play an instrument hot?")
                     (relation-asserted instrument-boys-hot)
                     (response No)
                     (valid-answers No Yes))))
;;; Do you prefer scripted or spontaneous videos?
(defrule determine-scripted-spontaneous ""
  
   (logical (instrument-boys-hot No))

   =>
   
   (assert (UI-state (display "Do you prefer scripted or spontaneous videos?")
                     (relation-asserted scripted-spontaneous)
                     (response Scripted)
                     (valid-answers Scripted Spontaneous))))
;;; leaf electricfaeriedust
(defrule electricfaeriedust-conclusions ""

   (logical (scripted-spontaneous Scripted))
   
   =>

   (assert (UI-state (display electricfaeriedust)
                     (state final))))
;;; leaf missxrojas
(defrule missxrojas-conclusions ""

   (logical (scripted-spontaneous Spontaneous))
   
   =>

   (assert (UI-state (display missxrojas)
                     (state final))))
;;; Do you hate twilight?
(defrule determine-twilight-hate ""
  
   (logical (instrument-boys-hot Yes))

   =>
   
   (assert (UI-state (display "Do you hate twilight?")
                     (relation-asserted twilight-hate)
                     (response Yes)
                     (valid-answers Yes No Don'tCare))))
;;; leaf nerimon
(defrule nerimon-conclusions ""

   (logical (twilight-hate Yes))
   
   =>

   (assert (UI-state (display nerimon)
                     (state final))))
;;; leaf getoutofmyflowchart
(defrule getoutofmyflowchart-conclusions ""

   (logical (twilight-hate No))
   
   =>

   (assert (UI-state (display getoutofmyflowchart)
                     (state final))))
;;; leaf charlieissocoollike
(defrule charlieissocoollike-conclusions ""

   (logical (twilight-hate Don'tCare))
   
   =>

   (assert (UI-state (display charlieissocoollike)
                     (state final))))
;;; Someone who sometimes sings or never sings?
(defrule determine-singing ""
   (logical (accent-like American))
   =>
   (assert (UI-state (display "Someone who sometimes sings or never sings?")
                     (relation-asserted does-sing)
                     (response NeverSings)
                     (valid-answers NeverSings SometimesSings)))
)
;;; Do you like rapping?
(defrule determine-rapping ""
   (logical (does-sing SometimesSings))
   =>
   (assert (UI-state (display "Do you like rapping?")
                     (relation-asserted likes-rapping)
                     (response Yes)
                     (valid-answers Yes No)))
)
;;; leaf HayleyGhoover
(defrule hayleyghoover-conclusions ""
   (logical (likes-rapping Yes))
   =>
   (assert (UI-state (display hayleyghoover)
                     (state final)))
)
;;; Do you only like songs about breakfast?
(defrule determine-likes-breakfast-songs ""
   (logical (likes-rapping No))
   =>
   (assert (UI-state (display "Do you only like songs about breakfast?")
                     (relation-asserted likes-breakfast)
                     (response OfCourse)
                     (valid-answers OfCourse UmNo)))
)
;;; leaf wheezywaiter
(defrule wheezywaiter-conclusions ""
   (logical (likes-breakfast OfCourse))
   =>
   (assert (UI-state (display WheezyWaiter)
                     (state final)))
)
;;; Do you really like charts and graphs?
(defrule determine-likes-graphs ""
   (logical (likes-breakfast UmNo))
   =>
   (assert (UI-state (display "Do you really like charts and graphs?")
                     (relation-asserted likes-charts)
                     (response Yes)
                     (valid-answers Yes NotReally)))
)
;;; leaf mickeleh
(defrule mickeleh-conclusions ""
   (logical (likes-charts Yes))
   =>
   (assert (UI-state (display Mickeleh)
                     (state final)))
)
;;; Do you love all caps?
(defrule determine-loves-all-caps ""
   (logical (likes-charts NotReally))
   =>
   (assert (UI-state (display "Do you love all caps?")
                     (relation-asserted loves-caps)
                     (response Yes)
                     (valid-answers Yes NotMyStyle)))
)
;;; Do girls or boys rule?
(defrule determine-likes-charts-graphs ""
   (logical (loves-caps Yes))
   =>
   (assert (UI-state (display "Do girls or boys rule?")
                     (relation-asserted girls-boys-rule)
                     (response Girls)
                     (valid-answers Girls Boys)))
)
;;; leaf italktosnakes
(defrule italktosnakes-conclusions ""
   (logical (girls-boys-rule Girls))
   =>
   (assert (UI-state (display ITalkToSnakes)
                     (state final)))
)
;;; leaf lukeconard
(defrule lukeconard-conclusions ""
   (logical (girls-boys-rule Boys))
   =>
   (assert (UI-state (display LukeConard)
                     (state final)))
)
;;; Do you insist on watching a fiveawesomegirl?
(defrule determine-insists-watching-fiveawesomegirl ""
   (logical (loves-caps NotMyStyle))
   =>
   (assert (UI-state (display "Do you insist on watching a fiveawesomegirl?")
                     (relation-asserted insists-fiveawesomegirl)
                     (response Yes)
                     (valid-answers Yes No)))
)
;;; leaf devilishlypure
(defrule devilishlypure-conclusions ""
   (logical (insists-fiveawesomegirl Yes))
   =>
   (assert (UI-state (display devilishlypure)
                     (state final)))
)
;;; Do you like really, really happy people?
(defrule determine-like-really-happy-people ""
   (logical (insists-fiveawesomegirl No))
   =>
   (assert (UI-state (display "Do you like really, really happy people?")
                     (relation-asserted likes-really-happy-people)
                     (response =[)
                     (valid-answers =[ =D)))
)
;;; leaf hopeonatenspeed
(defrule devilshilypure-conclusions ""
   (logical (likes-really-happy-people =D))
   =>
   (assert (UI-state (display HopeOnAtenSpeed)
                     (state final)))
)
;;; When not singing, you want your vlogger to..
(defrule determine-you-want-your-vlogger-to ""
   (logical (likes-really-happy-people =[))
   =>
   (assert (UI-state (display "When not singing, you want your vlogger to..")
                     (relation-asserted wants-vlogger-to)
                     (response TalkFast)
                     (valid-answers TalkFast TalkSlow)))
)
;;; leaf fizzylimon
(defrule fizzylimon-conclusions ""
   (logical (wants-vlogger-to TalkFast))
   =>
   (assert (UI-state (display FizzyLimon)
                     (state final)))
)
;;; You prefer your vlogger to review..
(defrule determine-you-prefer-your-vlogger-to ""
   (logical (wants-vlogger-to TalkSlow))
   =>
   (assert (UI-state (display "You prefer your vlogger to review..")
                     (relation-asserted prefers-vlogger-to)
                     (response Technology)
                     (valid-answers Technology Books)))
)
;;; leaf ijustine
(defrule ijustine-conclusions ""
   (logical (prefers-vlogger-to Technology))
   =>
   (assert (UI-state (display IJustine)
                     (state final)))
)
;;; leaf bandgeek8408
(defrule bandgeek8408-conclusions ""
   (logical (prefers-vlogger-to Books))
   =>
   (assert (UI-state (display BandGeek8408)
                     (state final)))
)
;;; Do you want daily videos?
(defrule determine-daily ""
   (logical (does-sing NeverSings))
   =>
   (assert (UI-state (display "Do you want daily videos?")
                     (relation-asserted want-daily)
                     (response Yes)
                     (valid-answers Yes No)))
)
;;; leaf breakingnyc
(defrule breakingnyc-conclusions ""
   (logical (want-daily Yes))
   =>
   (assert (UI-state (display breakingnyc)
                     (state final)))
)
;;; Do you need avice?
(defrule determine-avice ""
   (logical (want-daily No))
   =>
   (assert (UI-state (display "Do you need avice?")
                     (relation-asserted need-avice)
                     (response YesPlease)
                     (valid-answers YesPlease No)))
)
;;; leaf peron75
(defrule peron75-conclusions ""
   (logical (need-avice YesPlease))
   =>
   (assert (UI-state (display peron75)
                     (state final)))
)
;;; Do you like seeing people play different versions of themselves?
(defrule determine-versions ""
   (logical (need-avice No))
   =>
   (assert (UI-state (display "Do you like seeing people play different versions of themselves?")
                     (relation-asserted like-versions)
                     (response Yes)
                     (valid-answers Yes NoThat'sWeird)))
)
;;; leaf elmify
(defrule elmify-conclusions ""
   (logical (like-versions Yes))
   =>
   (assert (UI-state (display elmify)
                     (state final)))
)
;;; Hom many subscribers do you prefer to have?
(defrule determine-subscribers ""
   (logical (like-versions NoThat'sWeird))
   =>
   (assert (UI-state (display "Hom many subscribers do you prefer to have?")
                     (relation-asserted many-subscribers)
                     (response MoreThan100,000)
                     (valid-answers MoreThan100,000 LessThan100,000)))
)
;;; Do you want to watch someone...
(defrule determine-watch-someone ""
   (logical (many-subscribers MoreThan100,000))
   =>
   (assert (UI-state (display "Do you want to watch someone...")
                     (relation-asserted want-watch)
                     (response TalkWorldIssues)
                     (valid-answers TalkWorldIssues PutOnMake-Up RantAndBeAdorable)))
)
;;; leaf pogobat
(defrule pogobat-conclusions ""
   (logical (want-watch TalkWorldIssues))
   =>
   (assert (UI-state (display pogobat)
                     (state final)))
)
;;; leaf michellephan
(defrule michellephan-conclusions ""
   (logical (want-watch PutOnMake-Up))
   =>
   (assert (UI-state (display michellephan)
                     (state final)))
)
;;; leaf meekakitty
(defrule meekakitty-conclusions ""
   (logical (want-watch RantAndBeAdorable))
   =>
   (assert (UI-state (display meekakitty)
                     (state final)))
)
;;; Typography is cool.
(defrule determine-typography ""
   (logical (many-subscribers LessThan100,000))
   =>
   (assert (UI-state (display "Typography is cool.")
                     (relation-asserted typography-cool)
                     (response Agreed.)
                     (valid-answers Agreed. What'sTypography)))
)
;;; leaf xperpetualmotion
(defrule xperpetualmotion-conclusions ""
   (logical (typography-cool Agreed.))
   =>
   (assert (UI-state (display xperpetualmotion)
                     (state final)))
)
;;; Do you only watch fiveawesomes?
(defrule determine-fiveawesomes ""
   (logical (typography-cool What'sTypography))
   =>
   (assert (UI-state (display "Do you only watch fiveawesomes?")
                     (relation-asserted only-fiveawesomes)
                     (response Yes)
                     (valid-answers Yes WhoAreThey)))
)
;;; Girls or Boys?
(defrule determine-sex ""
   (logical (only-fiveawesomes Yes))
   =>
   (assert (UI-state (display "Girls or Boys?")
                     (relation-asserted girls-boys-2)
                     (response Boys)
                     (valid-answers Boys Girls)))
)
;;; leaf alanvlogs
(defrule alanvlogs-conclusions ""
   (logical (girls-boys-2 Boys))
   =>
   (assert (UI-state (display alanvlogs)
                     (state final)))
)
;;; leaf owlssayhoot
(defrule owlssayhoot-conclusions ""
   (logical (girls-boys-2 Girls))
   =>
   (assert (UI-state (display owlssayhoot)
                     (state final)))
)
;;; You Sure are picky.
(defrule determine-picky ""
   (logical (only-fiveawesomes WhoAreThey))
   =>
   (assert (UI-state (display "You Sure are picky.")
                     (relation-asserted picky)
                     (response Yup.)
                     (valid-answers Yup.)))
)
;;; leaf thatzak
(defrule owlssayhoot-conclusions ""
   (logical (picky Yup.))
   =>
   (assert (UI-state (display "Try thatzak. Everyone likes him")
                     (state final)))
)

;;; Ask Question:
;;; If current UI-state is not in state-list: sequence 
;;; than add UI-state to state list and change current to UI-state id
(defrule ask-question
   
   (UI-state (id ?id))
   
   ?f <- (state-list (sequence $?s&:(not (member$ ?id ?s))))
             
   =>
   
   (modify ?f (current ?id)
              (sequence ?id ?s))
   
   (halt))

;;; Next question without response no change
(defrule handle-next-no-change-none-middle-of-chain
   
   ?f1 <- (next ?id)

   ?f2 <- (state-list (current ?id) (sequence $? ?nid ?id $?))
                      
   =>
      
   (retract ?f1)
   
   (modify ?f2 (current ?nid))
   
   (halt))

;;; Next Question Without Response:\
;;; If user send (next ?id) without the response
;;; and id is in UI-state and state-list sequence
;;; than remove (next id) and assert (add-response id)
(defrule handle-next-response-none-end-of-chain
   
   ?f <- (next ?id)

   (state-list (sequence ?id $?))
   
   (UI-state (id ?id)
             (relation-asserted ?relation))
                   
   =>
      
   (retract ?f)

   (assert (add-response ?id)))   

;;; Next 
(defrule handle-next-no-change-middle-of-chain
   
   ?f1 <- (next ?id ?response)

   ?f2 <- (state-list (current ?id) (sequence $? ?nid ?id $?))
     
   (UI-state (id ?id) (response ?response))
   
   =>
      
   (retract ?f1)
   
   (modify ?f2 (current ?nid))
   
   (halt))

;;; Next question with response
;;; 
(defrule handle-next-change-middle-of-chain
   
   (next ?id ?response)

   ?f1 <- (state-list (current ?id) (sequence ?nid $?b ?id $?e))
     
   (UI-state (id ?id) (response ~?response))
   
   ?f2 <- (UI-state (id ?nid))
   
   =>
         
   (modify ?f1 (sequence ?b ?id ?e))
   
   (retract ?f2))

;;; next question with response - leaf/end of chain/state final
;;; 
(defrule handle-next-response-end-of-chain
   
   ?f1 <- (next ?id ?response)
   
   (state-list (sequence ?id $?))
   
   ?f2 <- (UI-state (id ?id)
                    (response ?expected)
                    (relation-asserted ?relation))
                
   =>
      
   (retract ?f1)

   (if (neq ?response ?expected)
      then
      (modify ?f2 (response ?response)))
      
   (assert (add-response ?id ?response)))   

;;; add response
;;; assert new relation and response
;;; retract add-response
(defrule handle-add-response
   
   (logical (UI-state (id ?id)
                      (relation-asserted ?relation)))
   
   ?f1 <- (add-response ?id ?response)
                
   =>
      
   (str-assert (str-cat "(" ?relation " " ?response ")"))
   
   (retract ?f1))   

;;; add response none
;;; assert relation only (without response)
;;; retract add response
(defrule handle-add-response-none
   
   (logical (UI-state (id ?id)
                      (relation-asserted ?relation)))
   
   ?f1 <- (add-response ?id)
                
   =>
      
   (str-assert (str-cat "(" ?relation ")"))
   
   (retract ?f1))   

;;; previous 
;;; retract f1
;;; change state-list current to previous one
(defrule handle-prev
      
   ?f1 <- (prev ?id)
   
   ?f2 <- (state-list (sequence $?b ?id ?p $?e))
                
   =>
   
   (retract ?f1)
   
   (modify ?f2 (current ?p))
   
   (halt))
   
