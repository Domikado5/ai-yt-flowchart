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
   
;;;****************
;;;* STARTUP RULE *
;;;****************

(defrule system-banner ""

  =>
  
  (assert (UI-state (display WelcomeMessage)
                    (relation-asserted start)
                    (state initial)
                    (valid-answers))))

;;;***************
;;;* QUERY RULES *
;;;***************
;;; So you want to watch YouTube?
(defrule determine-yt-type ""

   (logical (start))

   =>

   (assert (UI-state (display StartQuestion)
                     (relation-asserted yt-type)
                     (response Vlogger)
                     (valid-answers Vlogger))))
;;; Do you want a collab or single channel?
(defrule determine-collab-single ""

   (logical (yt-type Vlogger))

   =>

   (assert (UI-state (display CollabSingleQuestion)
                     (relation-asserted collab-single)
                     (response Collab)
                     (valid-answers Collab Single))))
;;; Do you want to watch new video or two year old videos?   
(defrule determine-old-new ""

   (logical (collab-single Collab))

   =>

   (assert (UI-state (display NewOldVideosQuestion)
                     (relation-asserted new-old)
                     (response New)
                     (valid-answers New Old))))
;;; People in relationships make you...   
(defrule determine-relationships ""

   (logical (new-old New))

   =>

   (assert (UI-state (display RelationshipsQuestion)
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

   (assert (UI-state (display DoctorWhoQuestion)
                     (relation-asserted doctor-who)
                     (response Absolutely)
                     (valid-answers Absolutely WhatsThat))))

;;; leaf
(defrule tardistacular-conclusions ""

   (logical (doctor-who Absolutely))
   
   =>

   (assert (UI-state (display tardistacular)
                     (state final))))
;;; How many people do you want to watch?
(defrule determine-how-many ""

   (logical (doctor-who WhatsThat))

   =>

   (assert (UI-state (display HowManyPeopleQuestion)
                     (relation-asserted how-many-people)
                     (response Five)
                     (valid-answers Five Two))))
;;; leaf
(defrule fiveawesomegirls-conclusions ""

   (logical (how-many-people Five))
   
   =>

   (assert (UI-state (display fiveawesomegirls)
                     (state final))))
;;; Do you want to watch short or tall people?
(defrule determine-short-tall ""

   (logical (how-many-people Two))

   =>

   (assert (UI-state (display ShortTallQuestion)
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
   
   (assert (UI-state (display GirlsBoysQuestion)
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
   
   (assert (UI-state (display AccentQuestion)
                     (relation-asserted accent-like)
                     (response SthElse)
                     (valid-answers SthElse British American))))
;;; Canada's cool, right?
(defrule determine-canada ""
  
   (logical (accent-like SthElse))

   =>
   
   (assert (UI-state (display CanadaQuestion)
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
   
   (assert (UI-state (display FunnierQuestion)
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
   
   (assert (UI-state (display DavidTennantQuestion)
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
   
   (assert (UI-state (display InstrumentBoysQuestion)
                     (relation-asserted instrument-boys-hot)
                     (response No)
                     (valid-answers No Yes))))
;;; Do you prefer scripted or spontaneous videos?
(defrule determine-scripted-spontaneous ""
  
   (logical (instrument-boys-hot No))

   =>
   
   (assert (UI-state (display ScriptedSpontaneousQuestion)
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
   
   (assert (UI-state (display TwilightQuestion)
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
;;; someone who sometimes sings or never sings?
(defrule determine-singing ""
   (logical (accent-like American))
   =>
   (assert (UI-state (display SingingQuestion)
                     (relation-asserted does-sing)
                     (response NeverSings)
                     (valid-answers NeverSings SometimesSings)))
)
;;; do you like rapping?
(defrule determine-rapping ""
   (logical (does-sing SometimesSings))
   =>
   (assert (UI-state (display RappingQuestion)
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
;;; do you only like songs about breakfast?
(defrule likes-breakfast-songs ""
   (logical (likes-rapping No))
   =>
   (assert (UI-state (display LikesBreakfast)
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
;;; do you really like charts and graphs?
(defrule likes-charts-graphs ""
   (logical (likes-breakfast UmNo))
   =>
   (assert (UI-state (display LikesCharts)
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
;;; do you love all caps?
(defrule loves-all-caps ""
   (logical (likes-charts NotReally))
   =>
   (assert (UI-state (display LovesCaps)
                     (relation-asserted loves-caps)
                     (response Yes)
                     (valid-answers Yes NotMyStyle)))
)
;;; do girls or boys rule?
(defrule likes-charts-graphs ""
   (logical (loves-caps Yes))
   =>
   (assert (UI-state (display GirlsBoysRule)
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
;;; do you insist on watching a fiveawesomegirl?
(defrule insists-watching-fiveawesomegirl ""
   (logical (loves-caps NotMyStyle))
   =>
   (assert (UI-state (display InsistWatchingFiveawesomegirl)
                     (relation-asserted insists-fiveawesomegirl)
                     (response Yes)
                     (valid-answers Yes No)))
)
;;; leaf devilishlypure
(defrule devilshilypure-conclusions ""
   (logical (insists-fiveawesomegirl Yes))
   =>
   (assert (UI-state (display DevilishLypure)
                     (state final)))
)
;;; do you like really, really happy people?
(defrule like-really-happy-people ""
   (logical (insists-fiveawesomegirl No))
   =>
   (assert (UI-state (display LikeReallyHappyPeople)
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
;;; when not singing, you want your vlogger to..
(defrule you-want-your-vlogger-to ""
   (logical (likes-really-happy-people =[))
   =>
   (assert (UI-state (display YouWantYourVloggerTo)
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
;;; you prefer your vlogger to review..
(defrule you-prefer-your-vlogger-to ""
   (logical (wants-vlogger-to TalkSlow))
   =>
   (assert (UI-state (display YouPreferYourVloggerTo)
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
;;; leaf no answers
(defrule no-answer ""

   (declare (salience -10))
  
   (logical (UI-state (id ?id)))
   
   (state-list (current ?id))
     
   =>
  
   (assert (UI-state (display NoAnswer)
                     (state final))))
                     
;;;*************************
;;;* GUI INTERACTION RULES *
;;;*************************

(defrule ask-question

   (declare (salience 5))
   
   (UI-state (id ?id))
   
   ?f <- (state-list (sequence $?s&:(not (member$ ?id ?s))))
             
   =>
   
   (modify ?f (current ?id)
              (sequence ?id ?s))
   
   (halt))

(defrule handle-next-no-change-none-middle-of-chain

   (declare (salience 10))
   
   ?f1 <- (next ?id)

   ?f2 <- (state-list (current ?id) (sequence $? ?nid ?id $?))
                      
   =>
      
   (retract ?f1)
   
   (modify ?f2 (current ?nid))
   
   (halt))

(defrule handle-next-response-none-end-of-chain

   (declare (salience 10))
   
   ?f <- (next ?id)

   (state-list (sequence ?id $?))
   
   (UI-state (id ?id)
             (relation-asserted ?relation))
                   
   =>
      
   (retract ?f)

   (assert (add-response ?id)))   

(defrule handle-next-no-change-middle-of-chain

   (declare (salience 10))
   
   ?f1 <- (next ?id ?response)

   ?f2 <- (state-list (current ?id) (sequence $? ?nid ?id $?))
     
   (UI-state (id ?id) (response ?response))
   
   =>
      
   (retract ?f1)
   
   (modify ?f2 (current ?nid))
   
   (halt))

(defrule handle-next-change-middle-of-chain

   (declare (salience 10))
   
   (next ?id ?response)

   ?f1 <- (state-list (current ?id) (sequence ?nid $?b ?id $?e))
     
   (UI-state (id ?id) (response ~?response))
   
   ?f2 <- (UI-state (id ?nid))
   
   =>
         
   (modify ?f1 (sequence ?b ?id ?e))
   
   (retract ?f2))
   
(defrule handle-next-response-end-of-chain

   (declare (salience 10))
   
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

(defrule handle-add-response

   (declare (salience 10))
   
   (logical (UI-state (id ?id)
                      (relation-asserted ?relation)))
   
   ?f1 <- (add-response ?id ?response)
                
   =>
      
   (str-assert (str-cat "(" ?relation " " ?response ")"))
   
   (retract ?f1))   

(defrule handle-add-response-none

   (declare (salience 10))
   
   (logical (UI-state (id ?id)
                      (relation-asserted ?relation)))
   
   ?f1 <- (add-response ?id)
                
   =>
      
   (str-assert (str-cat "(" ?relation ")"))
   
   (retract ?f1))   

(defrule handle-prev

   (declare (salience 10))
      
   ?f1 <- (prev ?id)
   
   ?f2 <- (state-list (sequence $?b ?id ?p $?e))
                
   =>
   
   (retract ?f1)
   
   (modify ?f2 (current ?p))
   
   (halt))
   
