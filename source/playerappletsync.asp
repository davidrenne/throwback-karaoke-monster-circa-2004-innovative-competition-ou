<?xml version = "1.0"?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns = "http://www.w3.org/1999/xhtml">

<head>
<link href="lyric.css" rel="stylesheet" type="text/css" />
<script>
function indexload() {
var indeces = document.indexs.indexval.value;
document.getElementById("mp3").selectedIndex = indeces;

}

function mp3(fname){

document.player.setFileName("/dkrenne/Innovative/Java/classes/WebKaraoke/MP3/" + fname);
document.player.start();
document.getElementById('fileplay').innerHTML = fname;
document.getElementById('fileplay').innerText = fname;

}
</script>
<title>MP3 Player</title>
<%

   'Create our filesystem object
	Set objFS = Server.CreateObject("Scripting.FileSystemObject")
	'Get this folder
	FolderPath=Request.ServerVariables("APPL_PHYSICAL_PATH") & "dkrenne/Innovative/Java/classes/WebKaraoke/MP3" 
	Set objFolder = objFS.GetFolder(FolderPath)
	Set objFiles = objFolder.Files
	index = request.queryString("index")

	%>
</head>
<body bgcolor="#FFFFFF" onLoad="indexload()">
<form name='indexs'>
<%response.write "<input type='hidden' name='indexval' id='indexval' value='" & index & "'>"%>
</form>
<div align="center">
  <table border="1" cellpadding="0" cellspacing="0" bordercolor="#111111" width="100%" id="AutoNumber1">
    <tr>
      <td width="50%"  bgcolor='#A91905'>
      <p align="center"><font color="#FFFFFF">Sync'in Station</font></td>
    </tr>
    <tr>
      <td width="50%">
<div align="center">

  <font face="Verdana, Arial, Helvetica, sans-serif" size="-1"><p><font face="Verdana, Arial, Helvetica, sans-serif" size="-1" color="#0000CC"><u><font color="#0000FF">Now Playing</font></u><font color="#0000FF">:
 <div name='fileplay' id='fileplay'></div>
</font></font>
  <p></p>
  <p>

<EMBED name='player' id='player' type="application/x-java-applet;version=1.3" CODE="javazoom.jl.player.PlayerApplet" scriptable='true' ARCHIVE = "jl0.4.jar" width='1' 
 height='1' audioURL ="<%
filename = request.QueryString("file")
response.write "MP3/" & filename
%>" pluginspage="http://java.sun.com/products/plugin/1.3/plugin-install.html"></EMBED></div>
<center>  

<p><font color="#000080"><b>Sync</b></font><b><font color="#000080"> Another 
File on Your Account</font></b></p>
<p>  


<select name="mp3" id='mp3' size='20'>
 <% For Each objFile In objFiles %>
<option value= '<%=objFile.Name%>' onclick='parent.lyric.location = "sync.asp?FID=" + document.getElementById("mp3").value' onDblClick='mp3(document.getElementById("mp3").value)'><%=objFile.Name%><%'=objFile.Size%></option>
  <% Next %>
<p></select></p>
</font>
<p></p>
      <p>&nbsp;</td>
      <td>
      <b>STEP 1</b><br>
<font size="2" color="#FF0000">Start Sync</font><br>
<INPUT TYPE=image  onclick='mp3(document.getElementById("mp3").value); var Stuff = new Date();var dateStuff = Stuff.getTime();parent.lyric.document.savesync.initdelay.value = dateStuff;' SRC="images/play_Synch.gif" BORDER=0>
<INPUT TYPE=image onclick='parent.content.document.player.stopPlayer();' SRC="images/Stop_Synch.gif" BORDER=0>
<br><b>STEP 2</b><font size="2" color="#FF0000"><br>Sync Words(Until End)</font><br>
<INPUT TYPE=image accesskey='S' onclick='parent.lyric.updatehidden()' SRC="images/Sync_Synch.gif" BORDER=0>
<br>
<font size="2" color="#FFFF00">(ALT + S)</font></p>

      </td>
    </tr>
  </table>
</font>
</div>
</body>
</html>