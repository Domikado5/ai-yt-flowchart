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

(defrule determine-yt-type ""

   (logical (start))

   =>

   (assert (UI-state (display StartQuestion)
                     (relation-asserted yt-type)
                     (response Vlogger)
                     (valid-answers Vlogger))))
   
(defrule determine-collab-single ""

   (logical (yt-type Vlogger))

   =>

   (assert (UI-state (display CollabSingleQuestion)
                     (relation-asserted collab-single)
                     (response Collab)
                     (valid-answers Collab Single))))
   
(defrule determine-old-new ""

   (logical (collab-single Collab))

   =>

   (assert (UI-state (display NewOldVideosQuestion)
                     (relation-asserted new-old)
                     (response New)
                     (valid-answers New Old))))
   
(defrule determine-relationships ""

   (logical (new-old New))

   =>

   (assert (UI-state (display RelationshipsQuestion)
                     (relation-asserted relationships)
                     (response Happy)
                     (valid-answers Happy Sick))))

;;; leaf
(defrule vloglovers-conclusions ""

   (logical (relationships Happy))
   
   =>

   (assert (UI-state (display vloglovers)
                     (state final))))

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

(defrule determine-point-surface-state ""

   (or (logical (engine-starts No)  
   
                (engine-rotates Yes))
                     
       (logical (engine-output-low Yes)))

   =>

   (assert (UI-state (display PointsQuestion)
                     (relation-asserted point-surface-state)
                     (response Normal)
                     (valid-answers Normal Burned Contaminated))))

(defrule determine-conductivity-test ""
   
   (logical (engine-starts No)  
   
            (engine-rotates No)
            
            (battery-has-charge Yes))

   =>

   (assert (UI-state (display CoilQuestion)
                     (relation-asserted conductivity-test-positive)
                     (response No)
                     (valid-answers No Yes))))

;;;****************
;;;* REPAIR RULES *
;;;****************

(defrule normal-engine-state-conclusions ""

   (logical (runs-normally Yes))
   
   =>

   (assert (UI-state (display NoRepair)
                     (state final))))

(defrule engine-sluggish ""

   (logical (engine-sluggish Yes))
   
   =>

   (assert (UI-state (display FuelLineRepair)
                     (state final))))

(defrule engine-misfires ""

   (logical (engine-misfires Yes))

   =>

   (assert (UI-state (display PointGapRepair)
                     (state final))))

(defrule engine-knocks ""

   (logical (engine-knocks Yes))

   =>

   (assert (UI-state (display AdjustTimingRepair)
                     (state final))))

(defrule tank-out-of-gas ""

   (logical (tank-has-gas No))

   =>

   (assert (UI-state (display AddGasRepair)
                     (state final))))
   
(defrule battery-dead ""

   (logical (battery-has-charge No))
   
   =>

   (assert (UI-state (display ReplaceBatteryRepair)
                     (state final))))
   
(defrule point-surface-state-burned ""

   (logical (point-surface-state Burned))

   =>

   (assert (UI-state (display ReplacePointsRepair)
                     (state final))))
                     
(defrule point-surface-state-contaminated ""
   
   (logical (point-surface-state Contaminated))
   
   =>

   (assert (UI-state (display CleanPointsRepair)
                     (state final))))

(defrule conductivity-test-positive-yes ""

   (logical (conductivity-test-positive Yes))
   
   =>

   (assert (UI-state (display LeadWireRepair)
                     (state final))))
                     
(defrule conductivity-test-positive-no ""

   (logical (conductivity-test-positive No))
      
   =>

   (assert (UI-state (display CoilRepair)
                     (state final))))
                     
(defrule no-repairs ""

   (declare (salience -10))
  
   (logical (UI-state (id ?id)))
   
   (state-list (current ?id))
     
   =>
  
   (assert (UI-state (display MechanicRepair)
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
   
