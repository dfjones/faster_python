(defvar *earth-radius* (the fixnum 6371))

(defun degree-to-radian (deg)
  (declare (type single-float deg)
	   (optimize (speed 3) (safety 0) (debug 0)))
  (the single-float (* deg (/ (coerce pi 'single-float) 180))))

(defun distance (lata lnga latb lngb)
  (declare (type single-float lata lnga latb lngb)
	   (optimize (speed 3) (safety 0) (debug 0)))
  (let* ((lata-r (the single-float (degree-to-radian lata)))
	 (lnga-r (the single-float (degree-to-radian lnga)))
	 (latb-r (the single-float (degree-to-radian latb)))
	 (lngb-r (the single-float (degree-to-radian lngb)))
	 (delta-lat (the single-float (- latb-r lata-r)))
	 (delta-lng (the single-float (- lngb-r lnga-r))))
    (* (the fixnum (* (the fixnum *earth-radius*) 
		      2))
       (the single-float
	 (asin (the single-float
		 (sqrt (+  (expt (sin (/ delta-lat 2)) 2)
			   (* (cos lata-r)
			      (cos latb-r)
			      (expt (sin (/ delta-lng 2)) 2))))))))))

(defun test ()
  (let ((increment 2.5))
    (time  (loop for lata from -90.0 to 90.0 by increment do
		(loop for lnga from -180.0 to 180.0 by increment do
		     (loop for latb from -90.0 to 90.0 by increment do
			  (loop for lngb from -180.0 to 180.0 by increment do
			       (distance lata lnga latb lngb))))))))