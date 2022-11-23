<?xml version = "1.0"?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns = "http://www.w3.org/1999/xhtml">
<head>
<link href="lyric.css" rel="stylesheet" type="text/css" />
<!-- used this style for the search buttons to help with the look and feel -->
<style type="text/css"> 

.submit { 
  font: 0.71em Verdana, Tahoma, Helvetica, Sans-Serif; 
  width: 120px; 
  text-align: center; 
  padding: 0; 
}
</style>
<script>
function mp3(fname){
//needed to pass the file name through the applet
document.player.setFileName("/dkrenne/Innovative/Java/classes/WebKaraoke/MP3/" + fname);
//will play the currently set file
document.player.start();
//change the currently played file
document.getElementById('fileplay').innerHTML = fname;
document.getElementById('fileplay').innerText = fname;

}

function sing365(fname) {
//this function populates the hidden variables that contain artist name and song
//dashes and underscores prevent an eval on an object from running correctly
//still there are errors and bugs
//if an MP3 has numbers before it.... the input box wont load what is in the database
fname = replaceSubstring(fname, ".mp3", ""); 
fname = replaceSubstring(fname, ".MP3", ""); 
fname = replaceSubstring(fname, ".Mp3", ""); 
fname = replaceSubstring(fname, ".mP3", ""); 
fname = replaceSubstring(fname, "-", ""); 
fname = replaceSubstring(fname, "_", ""); 
begs = "document.artists.";
end = "song.value";
song = eval(begs + fname + end);
begs = "document.artists.";
end = "artist.value";
artist = eval(begs + fname + end);
total = artist + " " + song;
//dynamically populate whats in the database when the user clicks on a song
document.getElementById("query").value = total;
}
function openweb() {
first = "http://search.sing365.com/search.php?searchstr=";
search = document.getElementById("query").value;
search = replaceSubstring(search, " ", "+"); 
second = "&category=text&x=0&y=0";
URL = first + search + second;
window.open(URL,'Search365')

}

function openweb2() {
first = "http://search.lyrics.astraweb.com/?word=";
search = document.getElementById("query").value;
search = replaceSubstring(search, " ", "+"); 
URL = first + search;
window.open(URL,'Astraweb')

}

function openweb3() {
first = "http://www.azlyrics.com/seek?q=";
search = document.getElementById("query").value;
search = replaceSubstring(search, " ", "+"); 
URL = first + search;
window.open(URL,'AZLyrics')

}
function replaceSubstring(inputString, fromString, toString) {
//public open source function used to parse strings out
      var temp = inputString;
   if (fromString == "") {
      return inputString;
   }
   if (toString.indexOf(fromString) == -1) { 
      while (temp.indexOf(fromString) != -1) {
         var toTheLeft = temp.substring(0, temp.indexOf(fromString));
         var toTheRight = temp.substring(temp.indexOf(fromString)+fromString.length, temp.length);
         temp = toTheLeft + toString + toTheRight;
      }
   } else { 
        var midStrings = new Array("~", "`", "_", "^", "#");
      var midStringLen = 1;
      var midString = "";
 
      while (midString == "") {
         for (var i=0; i < midStrings.length; i++) {
            var tempMidString = "";
            for (var j=0; j < midStringLen; j++) { tempMidString += midStrings[i]; }
            if (fromString.indexOf(tempMidString) == -1) {
               midString = tempMidString;
               i = midStrings.length + 1;
            }
         }
      } 
      while (temp.indexOf(fromString) != -1) {
         var toTheLeft = temp.substring(0, temp.indexOf(fromString));
         var toTheRight = temp.substring(temp.indexOf(fromString)+fromString.length, temp.length);
         temp = toTheLeft + midString + toTheRight;
      }
        while (temp.indexOf(midString) != -1) {
         var toTheLeft = temp.substring(0, temp.indexOf(midString));
         var toTheRight = temp.substring(temp.indexOf(midString)+midString.length, temp.length);
         temp = toTheLeft + toString + toTheRight;
      }
   } 
   return temp; 
   
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
	%>
</head>
<body bgcolor="#99CCFF">
<form name="indexs" id="indexs">
<% 
response.write "<input type='hidden' name='indexval' id='indexval' value='" & Session("file") & "'>"%></form>

<div align="center">
  <table border="1" cellpadding="0" cellspacing="0" bordercolor="#111111" width="100%" id="AutoNumber1">
    <tr>
      <td width="50%" bgcolor='#9999FF'>
      <p align="center">Listening Station</td>
    </tr>
    <tr>
      <td width="50%">
<div align="center">

  <font face="Verdana, Arial, Helvetica, sans-serif" size="-1"><p><font face="Verdana, Arial, Helvetica, sans-serif" size="-1" color="#000080"><u><font color="#FFFFFF">Now Playing</font></u><font color="#000080">:
 <br>
 <div name='fileplay' id='fileplay'>
</div>
</font></font>
<br><br>
<img src='images/back.gif' name='back' value="back" title='previous track' 
onClick='document.getElementById("mp3").selectedIndex = 
document.getElementById("mp3").selectedIndex - 1; mp3(document.getElementById("mp3").value);'>

<img src='http://atibweb.atiblab.sba.oakland.edu/dkrenne/Innovative/Java/classes/WebKaraoke/images/Stop.gif' name='stop' value="Stop" title='stop track' 
onClick="javascript:document.player.stopPlayer()">

<img src='http://atibweb.atiblab.sba.oakland.edu/dkrenne/Innovative/Java/classes/WebKaraoke/images/Play.gif' name='play' value="play" title='play track' 
onClick='mp3(document.getElementById("mp3").value)'>

<img src='images/Forward.gif' name='next' value="next" title='next track' 
onClick='document.getElementById("mp3").selectedIndex = 
document.getElementById("mp3").selectedIndex + 1; mp3(document.getElementById("mp3").value);'>

<EMBED name='player' id='player' type="application/x-java-applet;version=1.3" CODE="javazoom.jl.player.PlayerApplet" scriptable='true' ARCHIVE = "jl0.4.jar" width='1' 
 height='1' audioURL ="<%
filename = request.QueryString("file")
response.write "MP3/" & filename
%>" pluginspage="http://java.sun.com/products/plugin/1.3/plugin-install.html"></EMBED></div>
<center>  
<br>
&nbsp; <b><font color="#000080">Play Another File on Your Account</font></b><p>  

<select name="mp3" id='mp3' size='10'>
 <% For Each objFile In objFiles %>
<option value= '<%=objFile.Name%>' onclick='parent.lyric.location = 
"lyric.asp?file=" + document.getElementById("mp3").value; sing365(document.getElementById("mp3").value);'
 onDblClick='mp3(document.getElementById("mp3").value)'><%=objFile.Name%><%'=objFile.Size%></option>
  <% Next %>
</font>
</table>
<table cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%">
  <tr>
    <td width="56%">&nbsp;</td>
    <td border='1' width="50%">
<form name='artists' id='artists'>
<%
set conn= Server.CreateObject("ADODB.Connection")
Conn.Open "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=D://Inetpub/wwwroot/dkrenne/db/WebKaraoke.mdb;"
Strupd= "select * from artist;"
set rs = conn.Execute(Strupd) 
val = 1
do while not rs.eof
filename = rs("filename")
'response.write length & "<br>"
file = Replace(filename, "-","")
file = Replace(file, "_","")
file = Replace(file, ".MP3","")
file = Replace(file, ".mp3","")
file = Replace(file, ".Mp3","")
file = Replace(file, ".mP3","")
'if right(file
'response.write file
'prepare the hidden values to run the textbox populator
'response.write "<input type='hidden' name='" & rs("filename") & "' value='" & rs("filename") & "'>"
response.write "<input type='hidden' name='" & file & "song' value='" & rs("songname") & "'>"
response.write "<input type='hidden' name='" & file & "artist' value='" & rs("artist") & "'>"

val = val + 1
rs.movenext
  loop
Set rs = Nothing
%>

<p align="center">

<font color="#333399">Search</font></font></p>
    </td>
  </tr>
  <tr>
    <td width="56%"><font color="#333399"><u>Search for Lyrics</u></font></td>
    <td width="50%">

<p align="center">

<input type='submit' onClick='openweb()' class="submit" value='Sing365.com' style="float: right"></font></p>
    </td>
  </tr>
  <tr>
    <td width="56%">

  <p align="center">

<input name='query' id='query' size="29" style="float: right"></font></td>
    <td width="50%">

<input type='submit' onClick='openweb2()'  class="submit" value='Astraweb.com' style="float: right"></font></td>
  </tr>
  <tr>
    <td width="56%">&nbsp;</td>
    <td width="50%">

<input type='submit' onClick='openweb3()' class="submit" value='AZLyrics.com' style="float: right"></font></td>
  </tr>
</table>
</form>
<p></p>
      <p>&nbsp;</td>
    </tr>
  </table>
</font>
</div>

</body>
</html>