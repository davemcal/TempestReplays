<html> 

<body> 

<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" 

codebase="http://download.macromedia.com/pub/shockwave/
cabs/flash/swflash.cab#version=6,0,40,0" 
 
width="468" height="60" 
 id="mymoviename"> 

<param name="movie"  

value="tempestreplays.swf" /> 
 
<param name="quality" value="high" /> 

<param name="bgcolor" value="#ffffff" /> 

<param name="FlashVars" value="file=<?php echo htmlspecialchars($_GET["replay"]); ?>.xml">

<embed src="tempestreplays.swf" quality="high" bgcolor="#ffffff"

width="800" height="800" 

FlashVars="file=<?php echo htmlspecialchars($_GET["replay"]); ?>.xml"

name="mymoviename" align="" type="application/x-shockwave-flash" 

pluginspage="http://www.macromedia.com/go/getflashplayer"> 


</embed> 

</object> 

</body>

</html> 