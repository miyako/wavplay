property threads : Integer

Class constructor()
	
	var $systemInfo : Object
	$systemInfo:=System info:C1571
	//var $cpuThreads : Integer
	//$cpuThreads:=$systemInfo.cpuThreads
	var $cores : Integer
	$cores:=$systemInfo.cores\2
	
	This:C1470.threads:=$cores