; Ελένη Ευαγγελία Κούμπου (4065)
; Μαρία Μακρή (4225)
;_______________________________
; Ορισμός template για το Adder
(deftemplate Adder
   (multislot hasInput)
   (slot hasOutput))

; Ορισμός template για το Multiplier
(deftemplate Multiplier
   (multislot hasInput)
   (slot hasOutput))

; Ορισμός template για τον Κύκλο Λειτουργίας
(deftemplate OperationCycle
   (slot hasInput1)
   (slot hasInput2)
   (slot hasInput3)
   (slot hasInput4)
   (slot hasSensorM1)
   (slot hasSensorM2)
   (slot hasSensorM3)
   (slot hasoutput))

; Ορισμός κλάσης OperationCycle
(defclass OperationCycle
  	(is-a USER)  
  	(slot hasSensorM1 
  		(type INTEGER) 
  		(create-accessor read-write))
  	(slot hasSensorM2 
  		(type INTEGER) 
  		(create-accessor read-write))
  	(slot hasoutput 
  		(type INTEGER) 
  		(create-accessor read-write))
  	(slot hasSensorM3 
  		(type INTEGER) 
  		(create-accessor read-write))
  	(slot hasInput1 
  		(type INTEGER) 
  		(create-accessor read-write))
  	(slot hasInput3 
  		(type INTEGER) 
  		(create-accessor read-write))
  	(slot hasInput2 
  		(type INTEGER) 
  		(create-accessor read-write))
  	(slot hasInput4 
  		(type INTEGER) 
  		(create-accessor read-write)))

; Ορισμός κλάσης ElectronicComponent
(defclass ElectronicComponent
  	(is-a USER)
  	(multislot ComponentTo 
  		(type INSTANCE) 
  		(allowed-classes System) 
  		(cardinality 1 ?VARIABLE)
  		(create-accessor read-write))
  	(multislot hasOutput 
  		(type INSTANCE) 
  		(allowed-classes Output Sensor) 
  		(cardinality 1 ?VARIABLE)
  		(create-accessor read-write))
  	(multislot hasInput 
  		(type INSTANCE) 
  		(allowed-classes Input Sensor)
  		(cardinality 1 ?VARIABLE)
  		(create-accessor read-write))
  	(multislot MonitoredBy 
  		(type INSTANCE) 
  		(allowed-classes Sensor Output) 
  		(cardinality 1 ?VARIABLE)
  		(create-accessor read-write)))

; Ορισμός κλάσης Adder
(defclass Adder
	(is-a ElectronicComponent))

; Ορισμός κλάσης Multiplier
(defclass Multiplier
	(is-a ElectronicComponent))

; Ορισμός κλάσης System για το συνολικό σύστημα
(defclass System
	(is-a USER)
	(multislot hasComponent
		(type INSTANCE)
		(allowed-classes ElectronicComponent)
		(cardinality 1 ?VARIABLE)
		(create-accessor read-write))
	(multislot hasOutput
		(type INSTANCE)
		(allowed-classes Output Sensor)
		(cardinality 1 ?VARIABLE)
		(create-accessor read-write))
	(multislot hasSensor
		(type INSTANCE)
		(allowed-classes Sensor)
		(cardinality 1 ?VARIABLE)
		(create-accessor read-write))
	(multislot hasInput
		(type INSTANCE)
		(allowed-classes Input Sensor)
		(cardinality 1 ?VARIABLE)
		(create-accessor read-write)))

; Αρχικά δεδομένα (initial facts)
(deffacts initial-data
   (OperationCycle (hasInput1 21) (hasInput2 28) (hasInput3 10) (hasInput4 25)
                   (hasSensorM1 10) (hasSensorM2 24) (hasSensorM3 26) (hasoutput 18))
   (OperationCycle (hasInput1 7) (hasInput2 25) (hasInput3 13) (hasInput4 15)
                   (hasSensorM1 0) (hasSensorM2 0) (hasSensorM3 3) (hasoutput 3))
   (OperationCycle (hasInput1 11) (hasInput2 17) (hasInput3 24) (hasInput4 31)
                   (hasSensorM1 22) (hasSensorM2 6) (hasSensorM3 8) (hasoutput 14))
   (OperationCycle (hasInput1 18) (hasInput2 11) (hasInput3 28) (hasInput4 21)
                   (hasSensorM1 4) (hasSensorM2 12) (hasSensorM3 12) (hasoutput 0))
   (OperationCycle (hasInput1 25) (hasInput2 24) (hasInput3 30) (hasInput4 10)
                   (hasSensorM1 18) (hasSensorM2 16) (hasSensorM3 12) (hasoutput 12))
   (OperationCycle (hasInput1 12) (hasInput2 19) (hasInput3 11) (hasInput4 19)
                   (hasSensorM1 8) (hasSensorM2 24) (hasSensorM3 17) (hasoutput 9))
   (OperationCycle (hasInput1 1) (hasInput2 31) (hasInput3 7) (hasInput4 22)
                   (hasSensorM1 2) (hasSensorM2 0) (hasSensorM3 26) (hasoutput 26))
   (OperationCycle (hasInput1 0) (hasInput2 31) (hasInput3 3) (hasInput4 23)
                   (hasSensorM1 0) (hasSensorM2 0) (hasSensorM3 0) (hasoutput 0))
   (OperationCycle (hasInput1 31) (hasInput2 1) (hasInput3 6) (hasInput4 8)
                   (hasSensorM1 30) (hasSensorM2 30) (hasSensorM3 0) (hasoutput 30))
   (OperationCycle (hasInput1 6) (hasInput2 4) (hasInput3 25) (hasInput4 12)
                   (hasSensorM1 12) (hasSensorM2 31) (hasSensorM3 12) (hasoutput 28)))

; Define behavior of Adder
(defmessage-handler Adder normal-operation (?in1 ?in2)
  (return (mod (+ ?in1 ?in2) 32)))

(defmessage-handler Adder faulty-operation-short-circuit ()
  (return 0))

(defmessage-handler Adder faulty-operation-msb-off (?in1 ?in2)
  (return (mod (+ ?in1 ?in2) 16)))

; Define behavior of Multiplier
(defmessage-handler Multiplier normal-operation (?in1 ?in2)
  (return (mod (* ?in1 ?in2) 32)))

(defmessage-handler Multiplier faulty-operation-short-circuit ()
  (return 0))

(defmessage-handler Multiplier faulty-operation-msb-off (?in1 ?in2)
  (return (mod (* ?in1 ?in2) 16)))

; Rule for Adder 1 fault detection
(defrule monitor-adder1
  ?cycle <- (OperationCycle (hasInput1 ?in1) (hasSensorM1 ?m1))
  =>
  (if (not (= ?m1 (mod (+ ?in1 ?in1) 32)))
      then
      (progn
        (if (= ?m1 0)
            then
            (printout t "Time: " (fact-index ?cycle) " --> adder a1 error: Short-circuit!" crlf))
        
        (if (= ?m1 (mod (+ ?in1 ?in1) 16))
            then
            (printout t "Time: " (fact-index ?cycle) " --> adder a1 error: Most Significant Bit is off!" crlf))
        
        (if (and (not (= ?m1 0)) 
                 (not (= ?m1 (mod (+ ?in1 ?in1) 16))))
            then
            (printout t "Time: " (fact-index ?cycle) " --> sensor m1 error: Short-circuit!!" crlf)))))

; Rule for Adder 2 fault detection
(defrule monitor-adder2
  ?cycle <- (OperationCycle (hasSensorM2 ?m2) (hasSensorM3 ?m3) (hasoutput ?out))
  =>
  (if (not (= ?out (mod (+ ?m2 ?m3) 32)))
      then
      (progn
        (if (= ?out 0)
            then
            (printout t "Time: " (fact-index ?cycle) " --> adder a2 error: Short-circuit!" crlf))
        
        (if (= ?out (mod (+ ?m2 ?m3) 16))
            then
            (printout t "Time: " (fact-index ?cycle) " --> adder a2 error: Most Significant Bit is off!" crlf))
        
        (if (and (not (= ?out 0)) 
                 (not (= ?out (mod (+ ?m2 ?m3) 16))))
            then
            (printout t "Time: " (fact-index ?cycle) " --> sensor out error: Short-circuit!" crlf)))))

; Rule for Multiplier 1 fault detection
(defrule monitor-multiplier1
  ?cycle <- (OperationCycle (hasInput2 ?in2) (hasSensorM1 ?m1) (hasSensorM2 ?m2))
  =>
  (if (not (= ?m2 (mod (* ?in2 ?m1) 32)))
      then
      (progn
        (if (= ?m2 0)
            then
            (printout t "Time: " (fact-index ?cycle) " --> multiplier p1 error: Short-circuit!" crlf))
        
        (if (= ?m2 (mod (* ?in2 ?m1) 16))
            then
            (printout t "Time: " (fact-index ?cycle)" --> multiplier p1 error: Most Significant Bit is off!" crlf))
        
        (if (and (not (= ?m2 0)) 
                 (not (= ?m2 (mod (* ?in2 ?m1) 16))))
            then
            (printout t "Time: " (fact-index ?cycle) " --> sensor m2 error: Short-circuit!" crlf))))) 

; Rule for Multiplier 2 fault detection
(defrule monitor-multiplier2
  ?cycle <- (OperationCycle (hasInput3 ?in3) (hasInput4 ?in4) (hasSensorM3 ?m3))
  =>
  (if (not (= ?m3 (mod (* ?in3 ?in4) 32)))
      then
      (progn
        (if (= ?m3 0)
            then
            (printout t "Time: " (fact-index ?cycle) " --> multiplier p2 error: Short-circuit!" crlf))
        (if (= ?m3 (mod (* ?in3 ?in4) 16))
            then
            (printout t "Time: " (fact-index ?cycle) " --> multiplier p2 error: Most Significant Bit is off!" crlf))
        (if (and (not (= ?m3 0)) 
                 (not (= ?m3 (mod (* ?in3 ?in4) 16))))
            then
            (printout t "Time: " (fact-index ?cycle) " --> sensor m3 error: Short-circuit!" crlf)))))

; Rule for normal operation
(defrule normal-operation
  ?cycle <- (OperationCycle (hasInput1 ?in1) (hasInput2 ?in2) 
                            (hasInput3 ?in3) (hasInput4 ?in4)
                            (hasSensorM1 ?m1) (hasSensorM2 ?m2) 
                            (hasSensorM3 ?m3) (hasoutput ?out))
  (test (and 
          (= ?m1 (mod (+ ?in1 ?in1) 32)) ; Adder 1 normal
          (= ?out (mod (+ ?m2 ?m3) 32)) ; Adder 2 normal
          (= ?m2 (mod (* ?in2 ?m1) 32)) ; Multiplier 1 normal
          (= ?m3 (mod (* ?in3 ?in4) 32)))) ; Multiplier 2 normal
  =>
  (printout t "Time: " (fact-index ?cycle)" ----> Normal Operation!" crlf))