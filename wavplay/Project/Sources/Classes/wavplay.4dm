property wavplay : cs:C1710._wavplay

Class constructor($class : 4D:C1709.Class)
	
	var $controller : 4D:C1709.Class
	var $superclass : 4D:C1709.Class
	$superclass:=$class.superclass
	$controller:=cs:C1710._CLI_Controller
	
	While ($superclass#Null:C1517)
		If ($superclass.name=$controller.name)
			$controller:=$class
			break
		End if 
		$superclass:=$superclass.superclass
	End while 
	
	This:C1470.wavplay:=cs:C1710._wavplay.new("wavplay"; $controller)
	
Function get worker() : 4D:C1709.SystemWorker
	
	return This:C1470.workers.first()
	
Function get workers() : Collection
	
	If (This:C1470.wavplay=Null:C1517)
		return 
	End if 
	
	return This:C1470.wavplay.controller.workers
	
Function terminate()
	
	If (This:C1470.wavplay=Null:C1517)
		return 
	End if 
	
	This:C1470.wavplay.controller.terminate()
	
Function play($option : Variant; $formula : 4D:C1709.Function)
	
	If (This:C1470.wavplay=Null:C1517)
		return 
	End if 
	
	var $isStream; $isAsync : Boolean
	var $options : Collection
	
	Case of 
		: (Value type:C1509($option)=Is object:K8:27)
			$options:=[$option]
		: (Value type:C1509($option)=Is collection:K8:32)
			$options:=$option
		Else 
			$options:=[]
	End case 
	
	var $commands : Collection
	$commands:=[]
	
	If (OB Instance of:C1731($formula; 4D:C1709.Function))
		$isAsync:=True:C214
		//once
		If (This:C1470.wavplay.controller._onResponse=Null:C1517)
			Use (This:C1470.wavplay.controller)
				This:C1470.wavplay.controller._onResponse:=$formula
			End use 
		End if 
	End if 
	
	For each ($option; $options)
		
		If ($option=Null:C1517) || (Value type:C1509($option)#Is object:K8:27)
			continue
		End if 
		
		$command:=This:C1470.wavplay.escape(This:C1470.wavplay.executablePath)
		Case of 
			: (Value type:C1509($option.file)=Is object:K8:27) && (OB Instance of:C1731($option.file; 4D:C1709.File)) && ($option.file.exists)
				$command+=" "
				$command+=This:C1470.wavplay.quote(This:C1470.wavplay.expand($option.file).path)
			: (Value type:C1509($option.file)=Is BLOB:K8:12) || ((Value type:C1509($option.file)=Is object:K8:27) && (OB Instance of:C1731($option.file; 4D:C1709.Blob)) && ($option.file.size#0))
				$command+=" - "
				$isStream:=True:C214
		End case 
		
		var $worker : 4D:C1709.SystemWorker
		$worker:=This:C1470.wavplay.controller.execute($command; $isStream ? $option.file : Null:C1517; $option.data).worker.worker
		
		If (Not:C34($isAsync))
			$worker.wait()
		End if 
		
	End for each 