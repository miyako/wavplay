//%attributes = {"invisible":true}
#DECLARE($params : Object)

If (Count parameters:C259=0)
	
	//execute in a worker to process callbacks
	CALL WORKER:C1389(1; Current method name:C684; {})
	
Else 
	
	$file:=File:C1566("/DATA/sample.wav")
	
	var $wavplay : cs:C1710.wavplay
	$wavplay:=cs:C1710.wavplay.new()
	
	$wavplay.play({file: $file}; Formula:C1597(onResponse))
	$wavplay.play({file: $file.getContent()}; Formula:C1597(onResponse))
	
End if 