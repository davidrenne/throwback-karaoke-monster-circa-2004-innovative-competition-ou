<%
totwords = request.Form("totwords")
response.write totwords
set conn= Server.CreateObject("ADODB.Connection")
Conn.Open "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=D://Inetpub/wwwroot/dkrenne/db/WebKaraoke.mdb;"
sqlup2="UPDATE wordsync SET "
sqlup3="UPDATE wordsync SET "
sqlup1="UPDATE wordsync SET wordsync.InitDelay ='none', "

FID = request.Form("FNAME")
dim durat(250)
for i = 1 to 100 
frm = "text" & i
durat(i) = request.Form(frm)

if i = 100 then
'end update
response.write durat(i)
	sqlup1=sqlup1& "wordsync.Sync" & i & "='" & durat(i) & "' "
					else
					
	sqlup1=sqlup1& "wordsync.Sync" & i & "='" & durat(i) & "', "
			End if

  	
 
next
for i = 101 to 200 
frm = "text" & i
durat(i) = request.Form(frm)
if i = 200 then
'end update
		sqlup2=sqlup2& "wordsync.Sync" & i & "='" & durat(i) & "' "
					else
					
  		sqlup2=sqlup2 & "wordsync.Sync" & i & "='" & durat(i) & "', "
  					End if
  		
 
next

'batch 3
for i = 201 to 250 
frm = "text" & i
durat(i) = request.Form(frm)
if i = 250 then
'end update
		sqlup3=sqlup3& "wordsync.Sync" & i & "='" & durat(i) & "' "
					else
					
  		sqlup3=sqlup3& "wordsync.Sync" & i & "='" & durat(i) & "', "
  					End if

next

sqlup1 = sqlup1 & " WHERE (((wordsync.Fname)='" & FID & "'));"

sqlup2 = sqlup2 & " WHERE (((wordsync.Fname)='" & FID & "'));"

sqlup3 = sqlup3 & " WHERE (((wordsync.Fname)='" & FID & "'));"

set rs = conn.Execute(sqlup1) 
Set rs = Nothing
set rs = conn.Execute(sqlup2) 
Set rs = Nothing
set rs = conn.Execute(sqlup3) 
Set rs = Nothing

response.redirect("kara.asp?FID=" & FID)

conn.Close 
set conn= nothing
%>