<?xml version = "1.0"?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns = "http://www.w3.org/1999/xhtml">
<!-- needed this page in order to accomodate users coming from the wizard -->
<head>
<script language="Javascript">
function replaceSubstring(inputString, fromString, toString) {
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
 

function updatehidden() {
//check if 1st click
var check = document.savesync.stclick.value;
if (check >= 1) {

//1st click
document.savesync.stclick.value = 0;
  var Stuff = new Date();

  var tempold = parseInt(document.savesync.initdelay.value);
  
  var dateStuff = Stuff.getTime();
  //record to temp
  document.savesync.temptime.value = dateStuff;
//subtract duration
subdate = parseInt(dateStuff);

var val = document.savesync.initdelay.value;
  val =  subdate - val;
document.savesync.initdelay.value = val;

document.savesync.subtime.value = subdate;


duration = subdate - tempold

var num = document.synced.currentWord.value;

blah = num - 1;

document.synced.currentWord.value = blah;
var divs = "Sync" + num;
divs = replaceSubstring(divs, "-", ""); 
var beg = "document.savesync.";
var end = ".value";
var complete = eval(beg + divs + end + "= '" + duration + "';");
//var test = parseInt(document.savesync.temptime.value);
//alert("test" + (test - parseInt(document.savesync.subtime.value)));


switchword(num)

}else{ 
  var Stuff = new Date();
  
  var tempold = parseInt(document.savesync.temptime.value);
  
  var dateStuff = Stuff.getTime();
  //record to temp
  document.savesync.temptime.value = dateStuff;
//subtract duration
subdate = parseInt(dateStuff);
//trying to debug thius peice of crap
duration = subdate - tempold;
var num = document.synced.currentWord.value;

blah = num - 1;

document.synced.currentWord.value = blah;
var divs = "Sync" + num;
divs = replaceSubstring(divs, "-", "");
//alert(divs);
var beg = "document.savesync.";
var end = ".value";
var complete = eval(beg + divs + end + " = " + duration + ";");

switchword(num)



}
}
function switchword(hidval) {
var num = document.synced.currentWord.value;
var divs = "Word" + num;
var redivs = "Word" + (parseInt(num) + 1);
var beg = "document.getElementById('";
var end = "').style.fontWeight";
var complete = eval(beg + divs + end + "= 'bolder'");
var complete = eval(beg + divs + "').style.color" + "= '#A91905'");
var complete = eval(beg + divs + "').style.background" + "= '#99CCFF'");
var complete = eval(beg + redivs + "').style.fontWeight" + "= 'lighter'");
var complete = eval(beg + redivs + "').style.fontStyle" + "= 'italic'");
var complete = eval(beg + redivs + "').style.color" + "= 'black'");
var complete = eval(beg + redivs + "').style.background " + "= '#FFFFFF'");
check = eval("document.getElementById('" + divs + "').innerHTML;");
//alert(check);
if (check == "") {
num = num - 1;
document.synced.currentWord.value = num;
var complete = eval(beg + "Word" + num + end + "= 'bolder'");
var complete = eval(beg + "Word" + num + "').style.color" + "= '#A91905'");
var complete = eval(beg + "Word" + num + "').style.background" + "= '#99CCFF'");

}


}
//function mp3pars(fname){

//parent.content.mp3(fname);var Stuff = new Date();var dateStuff = Stuff.getTime();document.savesync.initdelay.value = dateStuff;
//}

</script>

<title>Sync Your MP3</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="lyric.css" rel="stylesheet" type="text/css" />

</head>
<body>
<table border="1" cellpadding="0" cellspacing="0" bordercolor="#111111" width="100%" height="403" >
<form name='synced' id='synced' >

  <tr>
      <td bgcolor='#A91905' width="85%%" height="24"><p align="center">
      <font color="#FFFFFF">Sync'in Station</font></td>

<tr>
<td bgcolor='#FFFFFF' height="1">

<%
FID = request.queryString("FID")
set conn= Server.CreateObject("ADODB.Connection")
Conn.Open "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=D://Inetpub/wwwroot/dkrenne/db/WebKaraoke.mdb;"
Set objRecordset = Server.CreateObject("ADODB.Recordset")
parse= "SELECT * FROM wordparse WHERE Fname='" & FID & "';" 
objRecordset.Open parse,conn,3,3
count=objRecordset.recordcount
if count < 1 then
response.write "<br><br><br><font color='red'>You havent yet saved any lyrics.  Please go back and save them.</font>"
else
set rs = conn.Execute(parse)
for i= 1 to 250
buildrsstr = "Word" & i
duh=rs(buildrsstr)
if duh = "<tr>" then
response.write "<br>"
response.write "<span id='Word-" & i & "'></span>&nbsp;" & vbcrlf

else
response.write "<span id='Word-" & i & "'><font size='2'>" & duh & "</font></span>&nbsp;" & vbcrlf
end if
next
end if
 conn.Close 
  set conn= nothing
  

%>
<input type='hidden' value='-1' name='currentWord' id='currentWord'>

</form>
<td>      
      <b>STEP 1</b><br>
<font size="2" color="#FF0000">Start Sync</font><br>
<INPUT TYPE=image  onclick='parent.content.mp3("<% response.write FID %>");var Stuff = new Date();var dateStuff = Stuff.getTime();document.savesync.initdelay.value = dateStuff;' SRC="images/play_Synch.gif" BORDER=0>
<INPUT TYPE=image onclick='parent.content.document.player.stopPlayer();' SRC="images/Stop_Synch.gif" BORDER=0>
<br><b>STEP 2</b><font size="2" color="#FF0000"><br>&nbsp;Sync Words(Until End)</font><br>
<INPUT TYPE=image accesskey='S' onclick='updatehidden()' SRC="images/Sync_Synch.gif" BORDER=0> 

<form name='savesync' id='savesync' method="post" action="savesync.asp">
<%
for i = 1 to 250
response.write "<input type='hidden' id='Sync" & i & "' name='Sync" & i & "'>" & vbcrlf
next
%>

<input type='hidden' name='FNAME' id='FNAME' value='<% response.write FID %>'>
<input type='hidden' name='subtime' id='subtime'>
<input type='hidden' name='temptime' id='temptime'>
<input type='hidden' name='initdelay' id='initdelay'>

<input type='hidden' name='stclick' id='stclick' value='1'>
<p>
<b>STEP 3</b><br>
<font size="2" color="#FF0000">Save Sync</font><br>

<INPUT TYPE=image SRC="images/Save_Synch.gif" BORDER=0></p>
</td>
</table>
   </form>
</body>
</html>