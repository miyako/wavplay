---
layout: default
---

![version](https://img.shields.io/badge/version-20%2B-E23089)
![platform](https://img.shields.io/static/v1?label=platform&message=mac-intel%20|%20mac-arm%20|%20win-64&color=blue)
[![license](https://img.shields.io/github/license/miyako/wavplay)](LICENSE)
![downloads](https://img.shields.io/github/downloads/miyako/wavplay/total)

# Tool to play wav file

Pass in `file` one of the following:

- `Blob`
- `4D.Blob`
- `File`

The optional callback is invoked when the playback ends. You can pass in `data` a context object to identify the callee.

```4d
#DECLARE($params : Object)

If (Count parameters=0)
    
    //execute in a worker to process callbacks
    CALL WORKER(1; Current method name; {})
    
Else 
    
    $file:=File("/DATA/sample.wav")
    
    var $wavplay : cs.wavplay
    $wavplay:=cs.wavplay.new()
    
    $wavplay.play({file: $file}; Formula(onResponse))
    $wavplay.play({file: $file.getContent()}; Formula(onResponse))
    
End if 
```
