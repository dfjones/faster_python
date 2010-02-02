(defvar *earth-radius* 6371)

(defun degree-to-radian (deg)
  (* deg (/ pi 180)))

(defun distance (lata lnga latb lngb)
  (let* ((lata-r (degree-to-radian lata))
	 (lnga-r (degree-to-radian lnga))
	 (latb-r (degree-to-radian latb))
	 (lngb-r (degree-to-radian lngb))
	 (delta-lat (- latb-r lata-r))
	 (delta-lng (- lngb-r lnga-r)))
    (* *earth-radius*
       2 
       (asin (sqrt (+ (expt (sin (/ delta-lat 2)) 2)
		      (* (cos lata-r)
			 (cos latb-r)
			 (expt (sin (/ delta-lng 2)) 2))))))))

(defun test ()
  (let ((increment 2.5))
    (time  (loop for lata from -90 to 90 by increment do
		(loop for lnga from -180 to 180 by increment do
		     (loop for latb from -90 to 90 by increment do
			  (loop for lngb from -180 to 180 by increment do
			       (distance lata lnga latb lngb))))))))