
<!--#include file="inc/setup.asp"-->

<%
Dim cmsrs,Rs,Sql,SqlItem,RsItem,Action,FoundErr,Num,SuccNum,ErrNum,Frs,RSNum,Inum,ii
Dim HistrolyID,ItemID,ChannelID,ClassID,SpecialID,ArticleID,Title,CollecDate,NewsUrl,Result
Dim  Arr_Histroly,Arr_ArticleID,i_Arr,Del,Flag,NewsID,DelFlag
Dim MaxPerPage,CurrentPage,AllPage,HistrolyNum,i_His,lx,radiobutton,lb,rslb
'----�Ƿ��½
%>
<html>
<head>
<title>�ɼ�ϵͳ</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" type="text/css" href="css/Admin_Style.css">
<style type="text/css">
.ButtonList {
	BORDER-RIGHT: #000000 2px solid; BORDER-TOP: #ffffff 2px solid; BORDER-LEFT: #ffffff 2px solid; CURSOR: default; BORDER-BOTTOM: #999999 2px solid; BACKGROUND-COLOR: #e6e6e6
}
</style>
<%

SuccNum=Trim(Request("SuccNum"))
ErrNum=Trim(Request("ErrNum"))
RSNum=Trim(Request("RSNum"))
Inum=Trim(Request("INum"))
HistrolyID=Trim(Request("HistrolyID"))
DelFlag=Trim(Request("DelFlag"))
if SuccNum="" or ErrNum="" or RSNum="" or Inum="" then
SuccNum=0 : ErrNum=0 : RSNum=0 : Inum=0
end if
MaxPerPage=20
FoundErr=False
Action=LCase(Trim(Request("Action")))
lx=Request("radiobutton")
if lx="" or lx=0 then lx=1
'���ͼƬ��ַ
if Trim(Request("Urlsc"))="ok" then
	if lx=3 then Set FRS = ConnItem.execute("select * from SK_photo")
	if lx=5 then Set FRS = ConnItem.execute("select * from SK_DownLoad")
	if lx=3  then
		while not FRS.eof
		   PhotoUrl= PhotoUrl & vbcrlf & frs("PhotoUrl")
			PicUrls=Split(frs("PicUrls"),"|||")
			for i=0 to Ubound(PicUrls)
			 pic_temp=Replace(PicUrls(i),"ͼƬ" & i+1 &"|","")
			 pic_1 = pic_1 & vbcrlf & pic_temp
			next 
			pic_2 = pic_2 & vbcrlf & pic_1
			pic_1=""
			Frs.movenext
			SuccNum=SuccNum+1
		wend
	end if
	if lx=5  then
		while not FRS.eof
		PhotoUrl= PhotoUrl & vbcrlf & frs("PhotoUrl")
			PicUrls=Split(frs("DownUrls"),"|||")
			for i=0 to Ubound(PicUrls)
			 pic_temp=Replace(PicUrls(i),"���ص�ַ" & i+1 &"|","")
			 pic_1 = pic_1 & vbcrlf & pic_temp
			next 
			pic_2 = pic_2 & vbcrlf & pic_1
			pic_1=""
			Frs.movenext
			SuccNum=SuccNum+1
		wend
	end if
	Response.Write PhotoUrl
	Response.Write pic_2
	if lx =3 then call FSOSaveFile(PhotoUrl & pic_2,"photo.txt")
	if lx =5 then call FSOSaveFile(PhotoUrl & pic_2,"soft.txt")
	Frs.close
	set frs=nothing
	response.write  "<script>alert('��ʾ:���ι���� " & SuccNum &  " ����ַ;');location.href='sk_checkdatabase.asp?radiobutton="& lx &"'</script>"  
		
end if 
select case Action
case "ok"
	select case DelFlag
	case "��������ѡ��¼"
	If HistrolyID="" Then
      FoundErr=True
      ErrMsg=ErrMsg & "<br><li>��ѡ��Ҫ�����ļ�¼</li>"
	Else
		Call OpenConn()
      HistrolyID=Replace(HistrolyID," ","")
	  	 if lx=1 then	
			 Set FRS = Server.CreateObject("ADODB.RECORDSET")
			  FRS.Open "select * from SK_Article Where ArticleID in(" & HistrolyID & ")", ConnItem, 1, 3
			  If Not FRS.EOF Then
				  while not FRS.eof
				  InsertIntoBase 1,FRS
				  FRS.movenext
				  wend
			  End if
			  ConnItem.execute("Delete From SK_Article Where ArticleID in(" & HistrolyID & ")")
			  FRS.close
			  set FRS=nothing
		 end if
		 if lx=3 then
		 	  Set FRS = Server.CreateObject("ADODB.RECORDSET")
			  FRS.Open "select * from SK_photo Where ID in(" & HistrolyID & ")", ConnItem, 1, 3
			  If Not FRS.EOF Then
				  while not FRS.eof
				  InsertIntoBase_photo FRS
				  FRS.movenext
				  wend
			  End if
			 ConnItem.execute("Delete From SK_photo Where ID in(" & HistrolyID & ")")
			  FRS.close
			  set FRS=nothing
		 end if
		 if lx=5 then
		 	  Set FRS = Server.CreateObject("ADODB.RECORDSET")
			  FRS.Open "select * from SK_download Where ID in(" & HistrolyID & ")", ConnItem, 1, 3
			  If Not FRS.EOF Then
				  while not FRS.eof
				  InsertIntoBase_down FRS
				  FRS.movenext
				  wend
			  End if
			  ConnItem.execute("Delete From SK_download Where ID in(" & HistrolyID & ")")
			  FRS.close
			  set FRS=nothing
		 end if
		Call CloseConn()
		  Call NumMsg()
	End if 
	case "������ȫ����¼"
		Call OpenConn()
		select case lx
		case 1
			SQLstr="select * from SK_Article order by ArticleID DESC"
		case 3
			SQLstr="select  * from SK_photo order by ID DESC"
		case 5
			SQLstr="select * from SK_download order by ID DESC"
		end select
		if SQLstr<>"" then
			Set FRS = Server.CreateObject("ADODB.RECORDSET")
			FRS.Open SQLstr, ConnItem, 1, 3
			  If Not FRS.EOF Then
				  while not FRS.eof
				  	if lx=1 then InsertIntoBase 1,FRS
					if lx=3 then InsertIntoBase_photo FRS 
					if lx=5 then InsertIntoBase_down FRS
					FRS.movenext
				  wend 
		 	  end if	  
				if lx=1 then ConnItem.execute("Delete From SK_Article")
				if lx=3 then ConnItem.execute("Delete From sk_photo")
				if lx=5 then ConnItem.execute("Delete From sk_download")
		 	  FRS.close
		 	  set FRS=nothing
		End if
		
		Call CloseConn()
		
		Response.Write  "<script>alert('��ʾ:���ι����� " & SuccNum + ErrNum & " ƪ����\n���гɹ���� " & SuccNum & " ƪ,�ظ������������ "&ErrNum & " ƪ;');location.href='sk_checkdatabase.asp?radiobutton="& lx &"'</script>"  
	case "ɾ����ѡ��¼"
		if HistrolyID<>""  then 
			if lx=1 then ConnItem.execute("Delete From SK_Article Where ArticleID in(" & HistrolyID & ")")
 			if lx=2 then ConnItem.execute("Delete From SK_photo Where ID in(" & HistrolyID & ")")
			if lx=3 then ConnItem.execute("Delete From SK_download Where ID in(" & HistrolyID & ")")
			if lx=4 then ConnItem.execute("Delete From SK_Flash Where ID in(" & HistrolyID & ")")
		end if
		If Request("page")<>"" then
			CurrentPage=Cint(Request("Page"))
		Else
			CurrentPage=1
		End if 
		If CurrentPage=0 then CurrentPage=1
		response.write "<meta http-equiv=""refresh"" content=""0;url=sk_checkdatabase.asp?radiobutton="& lx &"&page="& CurrentPage &""">"
	case "ɾ��ȫ����¼"
		if lx=1 then ConnItem.execute("Delete From SK_Article")
		if lx=2 then ConnItem.execute("Delete From sk_photo")
		if lx=3 then ConnItem.execute("Delete From sk_download")
		if lx=4 then ConnItem.execute("Delete From SK_Flash")
		response.write "<meta http-equiv=""refresh"" content=""0;url=sk_checkdatabase.asp?radiobutton="& lx &""">"
		response.end
	case "ͼƬ��ַ�滻"
	    picurl_th=Trim(Request("picurl_th"))
	    Set FRS = Server.CreateObject("ADODB.RECORDSET")
		FRS.Open "select * from SK_photo", ConnItem, 1, 3
			while not FRS.eof
			PhotoUrl=Split(frs("PhotoUrl"),"/")
			Photo_Url=picurl_th & PhotoUrl(Ubound(PhotoUrl))
			'PhotoUrl= PhotoUrl & vbcrlf & frs("PhotoUrl")
			PicUrls=Split(frs("PicUrls"),"|||")
			for i=0 to Ubound(PicUrls)
			 pic_temp=Replace(PicUrls(i),"ͼƬ" & i+1 &"|","")
			 pic_temp=Split(pic_temp,"/")
			 pic_temp1=picurl_th & pic_temp(Ubound(pic_temp))
			 
			 If i=0 then
				PicUrls_i="ͼƬ1|" & pic_temp1
			 Else
			   PicUrls_i= PicUrls_i & "|||" & "ͼƬ" & i  & "|" & pic_temp1
			 End if
			next 
		    frs("PhotoUrl")=Photo_Url
			frs("PicUrls")=PicUrls_i
			PicUrls_i=""
			Frs.update
			Frs.movenext
			SuccNum=SuccNum+1
		wend
		Frs.close
		set frs=nothing
		response.write  "<script>alert('��ʾ:���ι��滻 " & SuccNum &  " ����ַ;');location.href='sk_checkdatabase.asp?radiobutton=3'</script>"
	case "������ַ�滻"	
		picurl_th=Trim(Request("picurl_th"))
		if picurl_th<>"" then
	    Set FRS = Server.CreateObject("ADODB.RECORDSET")
		FRS.Open "select * from SK_DownLoad", ConnItem, 1, 3
			while not FRS.eof
			if frs("PhotoUrl")<>"" then
			PhotoUrl=Split(frs("PhotoUrl"),"/")
			Photo_Url= picurl_th & PhotoUrl(Ubound(PhotoUrl))
			end if
			PicUrls=Split(frs("DownUrls"),"|||")
			for i=0 to Ubound(PicUrls)
			 pic_temp=Replace(PicUrls(i),"���ص�ַ" & i+1 &"|","")
			 pic_temp=Split(pic_temp,"/")
			 pic_temp1=picurl_th & pic_temp(Ubound(pic_temp))
			 
			 If i=0 then
				PicUrls_i="���ص�ַ1|" & pic_temp1
			 Else
			   PicUrls_i= PicUrls_i & "|||" & "���ص�ַ" & i  & "|" & pic_temp1
			 End if
			next 
		    frs("PhotoUrl")=Photo_Url
			frs("DownUrls")=PicUrls_i
			PicUrls_i=""
			Frs.update
			Frs.movenext
			SuccNum=SuccNum+1
		wend
		Frs.close
		set frs=nothing
		end if
		response.write  "<script>alert('��ʾ:���ι��滻 " & SuccNum &  " ����ַ;');location.href='sk_checkdatabase.asp?radiobutton=5'</script>"
	end select
case "del"
		Response.Flush()
		if HistrolyID<>""  then 
			Select Case lx
			Case 1
				ConnItem.execute("Delete From SK_Article Where ArticleID in(" & HistrolyID & ")")
			Case 2
				ConnItem.execute("Delete From SK_photo Where ID in(" & HistrolyID & ")")
			Case 3
				ConnItem.execute("Delete From SK_DownLoad Where ID in(" & HistrolyID & ")")
			Case 4
				ConnItem.execute("Delete From SK_Flash Where ID in(" & HistrolyID & ")")
			End Select	
		End if
		If Request("page")<>"" then
			CurrentPage=Cint(Request("Page"))
		Else
			CurrentPage=1
		End if 
		If CurrentPage=0 then CurrentPage=1
		response.write "<meta http-equiv=""refresh"" content=""0;url=sk_checkdatabase.asp?radiobutton="& lx &"&page="& CurrentPage &""">"
Case else
    call top()
	select case lx
	case 1
	   Call Main1()'����
	case 2
	   Call Main2()'ͼƬ
	Case 3
	   Call Main3()'����
	Case 4
	   Call Main4()'����
	case else
	   Call Main1()
	end select
end select

if FoundErr=True then  Call WriteErrMsg(ErrMsg)
sub NumMsg()
		   response.write  "<script>alert('��ʾ:���ι����� " & SuccNum + ErrNum & " ƪ����\n���гɹ���� " & SuccNum & " ƪ,�ظ������������ "&ErrNum & " ƪ;');</script>" 
		   response.write "<meta http-equiv=""refresh"" content=""0;url=sk_checkdatabase.asp?radiobutton="& lx &""">"	   
end sub
%>
<%sub top()%>
<SCRIPT language=javascript>
function unselectall(thisform)
{
    if(thisform.chkAll.checked)
	{
		thisform.chkAll.checked = thisform.chkAll.checked&0;
    } 	
}

function CheckAll(thisform)
{
	for (var i=0;i<thisform.elements.length;i++)
    {
	var e = thisform.elements[i];
	if (e.Name != "chkAll"&&e.disabled!=true)
		e.checked = thisform.chkAll.checked;
    }
}
//-->
</script>
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table cellpadding="0" cellspacing="1" border="0" width="100%" class="tableBorder" align=center>
  <tr class="topbg">
	<td height="22" colspan="2" align="center"><strong>�� �� �� �� �� ��</strong></td>
  </tr>
</table>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" class="tableBorder">
  <tr class="tdbg"> 
    <td height="30" width="65"><strong>����������</strong></td>  
    <td height="30"><a href="sk_checkDatabase.asp">������ҳ</a>&nbsp;&nbsp;|&nbsp;&nbsp;���ݲ鿴   </td>     
  </tr>         
</table>    
<table width="100%" align="center"  border="0" cellspacing="0" cellpadding="0" class="tableBorder">

  <tr>
    <td height=30 align="center">
ѡ��ɼ�ģ�飺
<%
Set Rs=server.createobject("adodb.recordset")
Rs.Open "select * from SK_cj where Flag=1 order by id asc", ConnItem, 1, 3
while not rs.eof
	If Skcj.ChkNumeric(rs("ID"))=Skcj.ChkNumeric(lx) then
		Response.Write "<input name=""radiobutton"" type=""radio"" value="""& rs("ID") &""" checked  onClick=""location.href='?radiobutton="& rs("ID") &"';"" >"
	Else
		Response.Write "<input name=""radiobutton"" type=""radio"" value="""& rs("ID") &""" onClick=""location.href='?radiobutton="& rs("ID") &"';"" >"
	End if
	Response.Write(Rs("CjName")&"�ɼ�")
	rs.movenext
wend
rs.close : Set rs=nothing
%> </td>
  </tr>
</table>
<%end sub %>
<%
'---------����------------------
Sub Main1
%>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" class="tableBorder" >
    <tr> 
      <td height="22" colspan="2" class="title"> <div align="center"><strong>�� �� �� ¼</strong></div></td>
    </tr>
</table>

 <!--�б�-->
 <table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" class="tableBorder">
  <form name="form1" method="POST" action="sk_checkDatabase.asp">
    <tr class="tdbg" style="padding: 0px 2px;"> 
      <td width="57" height="22" align="center" class=ButtonList>ѡ��</td>
      <td width="142" align="center" class=ButtonList>������Դ</td>
      <td width="358" align="center" class=ButtonList>���ű���</td>
      <td width="110" height="22" align="center" class=ButtonList>��Ŀ</td>
      <td width="90" height="22" align="center" class=ButtonList>����</td>
    </tr>
    <%                          
Set RsItem=server.createobject("adodb.recordset")
SqlItem="select * from SK_Article" 
If Request("page")<>"" then
    CurrentPage=Cint(Request("Page"))
Else
    CurrentPage=1
End if 

SqlItem=SqlItem  &  " order by ArticleID DESC"
RsItem.open SqlItem,ConnItem,1,1
If (Not RsItem.Eof) and (Not RsItem.Bof) then
   RsItem.PageSize=MaxPerPage
   Allpage=RsItem.PageCount
   If Currentpage>Allpage Then Currentpage=1
   HistrolyNum=RsItem.RecordCount
   RsItem.MoveFirst
   RsItem.AbsolutePage=CurrentPage
   i_His=0
   Do While not RsItem.Eof
%>
    <tr class="tdbg" onMouseOut="this.style.backgroundColor=''" onMouseOver="this.style.backgroundColor='#cccccc'" style="padding: 0px 2px;"> 
      <td width="57" align="center"> <input type="checkbox" value="<%=RsItem("ArticleID")%>" name="HistrolyID" onClick="unselectall(this.form)" style="border: 0px;background-color: #E1F4EE;">      </td>
      <td width="142" align="center"> <%=left(RsItem("CopyFrom"),8)%> </td>
      <td width="358" align="left"><a href="show.asp?id=<% = RsItem("ArticleID") %>&lx=1" target="_blank"><%=RsItem("Title")%></a></td>
      <td width="110" align="center"><%Call Admin_ShowClass_Name(RsItem("ChannelID"),RsItem("ClassID"))%></td>
      <td width="90" align="center"> <a href="sk_checkDatabase.asp?Action=Del&Page=<%= CurrentPage %>&HistrolyID=<%=RsItem("ArticleID")%>&radiobutton=<%=lx%>" onclick='return confirm("ȷ��Ҫɾ���˼�¼��");'>ɾ��</a>      </td>
    </tr>
    <%         
           i_His=i_His+1
           If i_His > MaxPerPage Then
              Exit Do
           End If
        RsItem.Movenext         
   Loop         
%>
    <tr class="tdbg"> 
      <td colspan=8 height="30">
        <input name="Action" type="hidden" id="Action" value="ok"> 
		<input name="radiobutton" type="hidden" id="Action" value="<%=lx%>"> 
		<input name="page" type="hidden" value="<%=CurrentPage %>"> 
        <input name="chkAll" type="checkbox" id="chkAll" onclick=CheckAll(this.form) value="checkbox" style="border: 0px;background-color: #E1F4EE;">
        ȫѡ </td>
    </tr>
    <tr class="tdbg"> 
      <td colspan=8 height="30" align=center><input name="DelFlag" type="submit" class="lostfocus" style="cursor: hand;background-color: #cccccc;" onclick='return confirm("ȷ��Ҫ��������ѡ��¼��");' value="��������ѡ��¼">
	  <input name="DelFlag" type="submit" class="lostfocus" style="cursor: hand;background-color: #cccccc;" onclick='return confirm("ȷ��Ҫ������ȫ����¼��");' value="������ȫ����¼">        
        &nbsp;&nbsp;&nbsp;&nbsp; <input name="DelFlag" type="submit" class="lostfocus" style="cursor: hand;background-color: #cccccc;"  onclick='return confirm("ȷ��Ҫɾ��ѡ�еļ�¼��");' value="ɾ����ѡ��¼"> 
        &nbsp;&nbsp;&nbsp;&nbsp; <input name="DelFlag" type="submit" class="lostfocus" style="cursor: hand;background-color: #cccccc;" onclick='return confirm("ȷ��Ҫɾ�����еļ�¼��");' value="ɾ��ȫ����¼"> 
      &nbsp;&nbsp;
	  </td></tr>
    <tr class="tdbg"> 
      <td colspan=8 height="30">ע�⣺����������Զ�ɾ���� </td>
    </tr>
    <%Else%>
    <tr class="tdbg"> 
      <td colspan='9' class="tdbg" align="center"><br>
        ϵͳ�����޼�¼��</td>
    </tr>
    <%End  If%>
    <%         
RsItem.Close         
Set RsItem=nothing           
%>
  </form>
</table>  
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" class="tableBorder" >
    <tr> 
      <td height="22" colspan="2" class="tdbg">
<%
Response.Write ShowPage("sk_checkDatabase.asp?Action="& Action,HistrolyNum,MaxPerPage,True,True," ����¼")
%>

      </td>
    </tr>
</table>

<!--�б�-->       
</body>         
</html>
<%End Sub
'---------����------------------
%>

<%
'-------------�����б�------------------
Sub Main3
%>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" class="tableBorder" >
    <tr> 
      <td height="22" colspan="2" class="title"> <div align="center"><strong>�� �� �� ¼</strong></div></td>
    </tr>
</table>

 <table class="tableBorder" border="0" align="center" cellspacing="1" width="100%" cellpadding="0">
  <form name="form1" method="POST" action="sk_checkDatabase.asp">
    <tr class="tdbg" style="padding: 0px 2px;"> 
      <td width="57" height="22" align="center" class=ButtonList>ѡ��</td>
      <td width="142" align="center" class=ButtonList>�ļ�����</td>
      <td width="358" align="center" class=ButtonList>��������</td>
      <td width="110" height="22" align="center" class=ButtonList>��Ŀ</td>
      <td width="90" height="22" align="center" class=ButtonList>����</td>
    </tr>
    <%                         
Set RsItem=server.createobject("adodb.recordset")
SqlItem="select * from SK_DownLoad" 
If Request("page")<>"" then
    CurrentPage=Cint(Request("Page"))
Else
    CurrentPage=1
End if 
SqlItem=SqlItem  &  " order by ID DESC"
RsItem.open SqlItem,ConnItem,1,1
If (Not RsItem.Eof) and (Not RsItem.Bof) then
   RsItem.PageSize=MaxPerPage
   Allpage=RsItem.PageCount
   If Currentpage>Allpage Then Currentpage=1
   HistrolyNum=RsItem.RecordCount
   RsItem.MoveFirst
   RsItem.AbsolutePage=CurrentPage
   i_His=0
   Do While not RsItem.Eof
%>
    <tr class="tdbg" onMouseOut="this.style.backgroundColor=''" onMouseOver="this.style.backgroundColor='#cccccc'" style="padding: 0px 2px;"> 
      <td width="57" align="center"> <input type="checkbox" value="<%=RsItem("ID")%>" name="HistrolyID" onClick="unselectall(this.form)" style="border: 0px;background-color: #E1F4EE;">      </td>
      <td width="142" align="center"> 

	 <% %> </td>
      <td width="358" align="left"><a href="show.asp?id=<% = RsItem("ID") %>&lx=3" target="_blank"><%=RsItem("Title")%></a></td>
      <td width="110" align="center"><% Call Admin_ShowClass_Name(3,RsItem("tID")) %></td>
      <td width="90" align="center"> <a href="sk_checkDatabase.asp?Action=Del&Page=<%= CurrentPage %>&HistrolyID=<%=RsItem("ID")%>&radiobutton=<%=lx%>" onclick='return confirm("ȷ��Ҫɾ���˼�¼��");'>ɾ��</a>      </td>
    </tr>
    <%         
           i_His=i_His+1
           If i_His > MaxPerPage Then
              Exit Do
           End If
        RsItem.Movenext         
   Loop         
%>
    <tr class="tdbg"> 
      <td colspan=8 height="30">
        <input name="Action" type="hidden" id="Action" value="ok"> 
		<input name="radiobutton" type="hidden" id="Action" value="<%=lx%>">
		<input name="page" type="hidden" value="<%=CurrentPage %>"> 
        <input name="chkAll" type="checkbox" id="chkAll" onclick=CheckAll(this.form) value="checkbox" style="border: 0px;background-color: #E1F4EE;">
        ȫѡ </td>
    </tr>
    <tr class="tdbg"> 
      <td colspan=8 height="30" align=center> 
     </td>
    </tr>
	<tr class="tdbg"> 
      <td colspan=8 height="30" align=center>
        &nbsp;&nbsp; <input type="submit"class="lostfocus" value="ɾ����ѡ��¼" name="DelFlag"  onclick='return confirm("ȷ��Ҫɾ��ѡ�еļ�¼��");' class="lostfocus" style="cursor: hand;background-color: #cccccc;"> 
		&nbsp;&nbsp; <input type="submit" value="ɾ��ȫ����¼" name="DelFlag" onclick='return confirm("ȷ��Ҫɾ�����еļ�¼��");' class="lostfocus" style="cursor: hand;background-color: #cccccc;"> 
       &nbsp;&nbsp; <input type="button" class="lostfocus" value="���ȫ��������ַ" name="DelFlag" onClick="window.location.href='SK_checkDatabase.asp?Urlsc=ok&radiobutton=5'" style="cursor: hand;background-color: #cccccc;">
	   <br>
	   <input name="picurl_th" type="text" class="lostfocus" value="" size="80" maxlength="150">
	   &nbsp;&nbsp; <input type="submit" class="lostfocus" value="������ַ�滻" name="DelFlag" onClick='return confirm("ȷ��Ҫ�滻�������ص�ַ��");' style="cursor: hand;background-color: #cccccc;">
    </tr>
    <tr class="tdbg"> 
      <td colspan=8 height="30"> </td>
    </tr>
    <%Else%>
    <tr class="tdbg"> 
      <td colspan='9' class="tdbg" align="center"><br>
        ϵͳ�����޼�¼��</td>
    </tr>
    <%End  If%>
    <%         
RsItem.Close         
Set RsItem=nothing           
%>
  </form>
</table>  
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" class="tableBorder" >
    <tr> 
      <td height="22" colspan="2" class="tdbg">
<%
Response.Write ShowPage("sk_checkDatabase.asp?Action="& Action &"&radiobutton="& lx,HistrolyNum,MaxPerPage,True,True," ����¼")
%>

      </td>
    </tr>
</table>

        
</body>         
</html>
<%End Sub%>
<%
'-------------�����б�------------------
Sub Main4
%>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" class="tableBorder" >
    <tr> 
      <td height="22" colspan="2" class="title"> <div align="center"><strong>�� �� �� ¼</strong></div></td>
    </tr>
</table>

 <table class="tableBorder" border="0" align="center" cellspacing="1" width="100%" cellpadding="0">
  <form name="form1" method="POST" action="sk_checkDatabase.asp">
    <tr class="tdbg" style="padding: 0px 2px;"> 
      <td width="57" height="22" align="center" class=ButtonList>ѡ��</td>
      <td width="142" align="center" class=ButtonList>�ļ�����</td>
      <td width="358" align="center" class=ButtonList>��������</td>
      <td width="110" height="22" align="center" class=ButtonList>��Ŀ</td>
      <td width="90" height="22" align="center" class=ButtonList>����</td>
    </tr>
    <%                         
Set RsItem=server.createobject("adodb.recordset")
SqlItem="select * from SK_Flash" 
If Request("page")<>"" then
    CurrentPage=Cint(Request("Page"))
Else
    CurrentPage=1
End if 
SqlItem=SqlItem  &  " order by ID DESC"
RsItem.open SqlItem,ConnItem,1,1
If (Not RsItem.Eof) and (Not RsItem.Bof) then
   RsItem.PageSize=MaxPerPage
   Allpage=RsItem.PageCount
   If Currentpage>Allpage Then Currentpage=1
   HistrolyNum=RsItem.RecordCount
   RsItem.MoveFirst
   RsItem.AbsolutePage=CurrentPage
   i_His=0
   Do While not RsItem.Eof
%>
    <tr class="tdbg" onMouseOut="this.style.backgroundColor=''" onMouseOver="this.style.backgroundColor='#cccccc'" style="padding: 0px 2px;"> 
      <td width="57" align="center"> <input type="checkbox" value="<%=RsItem("ID")%>" name="HistrolyID" onClick="unselectall(this.form)" style="border: 0px;background-color: #E1F4EE;">      </td>
      <td width="142" align="center"> 

	 <% %> </td>
      <td width="358" align="left"><a href="show.asp?id=<% = RsItem("ID") %>&lx=4" target="_blank"><%=RsItem("Title")%></a></td>
      <td width="110" align="center"><% Call Admin_ShowClass_Name(4,RsItem("tID")) %></td>
      <td width="90" align="center"> <a href="sk_checkDatabase.asp?Action=Del&Page=<%= CurrentPage %>&HistrolyID=<%=RsItem("ID")%>&radiobutton=<%=lx%>" onclick='return confirm("ȷ��Ҫɾ���˼�¼��");'>ɾ��</a>      </td>
    </tr>
    <%         
           i_His=i_His+1
           If i_His > MaxPerPage Then
              Exit Do
           End If
        RsItem.Movenext         
   Loop         
%>
    <tr class="tdbg"> 
      <td colspan=8 height="30">
        <input name="Action" type="hidden" id="Action" value="ok"> 
		<input name="radiobutton" type="hidden" id="Action" value="<%=lx%>">
		<input name="page" type="hidden" value="<%=CurrentPage %>"> 
        <input name="chkAll" type="checkbox" id="chkAll" onclick=CheckAll(this.form) value="checkbox" style="border: 0px;background-color: #E1F4EE;">
        ȫѡ </td>
    </tr>
    <tr class="tdbg"> 
      <td colspan=8 height="30" align=center> 
     </td>
    </tr>
	<tr class="tdbg"> 
      <td colspan=8 height="30" align=center>
        &nbsp;&nbsp; <input type="submit"class="lostfocus" value="ɾ����ѡ��¼" name="DelFlag"  onclick='return confirm("ȷ��Ҫɾ��ѡ�еļ�¼��");' class="lostfocus" style="cursor: hand;background-color: #cccccc;"> 
		&nbsp;&nbsp; <input type="submit" value="ɾ��ȫ����¼" name="DelFlag" onclick='return confirm("ȷ��Ҫɾ�����еļ�¼��");' class="lostfocus" style="cursor: hand;background-color: #cccccc;"> 
       &nbsp;&nbsp; <input type="button" class="lostfocus" value="���ȫ��������ַ" name="DelFlag" onClick="window.location.href='SK_checkDatabase.asp?Urlsc=ok&radiobutton=5'" style="cursor: hand;background-color: #cccccc;">
	   <br>
	   <input name="picurl_th" type="text" class="lostfocus" value="" size="80" maxlength="150">
	   &nbsp;&nbsp; <input type="submit" class="lostfocus" value="������ַ�滻" name="DelFlag" onClick='return confirm("ȷ��Ҫ�滻�������ص�ַ��");' style="cursor: hand;background-color: #cccccc;">
    </tr>
    <tr class="tdbg"> 
      <td colspan=8 height="30"> </td>
    </tr>
    <%Else%>
    <tr class="tdbg"> 
      <td colspan='9' class="tdbg" align="center"><br>
        ϵͳ�����޼�¼��</td>
    </tr>
    <%End  If%>
    <%         
RsItem.Close         
Set RsItem=nothing           
%>
  </form>
</table>  
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" class="tableBorder" >
    <tr> 
      <td height="22" colspan="2" class="tdbg">
<%

Response.Write ShowPage("sk_checkDatabase.asp?Action="& Action &"&radiobutton="& lx,HistrolyNum,MaxPerPage,True,True," ����¼")
%>

      </td>
    </tr>
</table>  
</body>         
</html>
<%End Sub%>

<%
'-------------ͼƬ�б�------------------
Sub Main2
%>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" class="tableBorder" >
    <tr> 
      <td height="22" colspan="2" class="title"> <div align="center"><strong>�� �� �� ¼</strong></div></td>
    </tr>
</table>
 <table   align="center"  class="tableBorder" border="0" cellspacing="1" width="100%" cellpadding="0">
  <form name="form1" method="POST" action="sk_checkDatabase.asp">
    <tr class="tdbg" style="padding: 0px 2px;"> 
      <td width="57" height="22" align="center" class=ButtonList>ѡ��</td>
      <td width="142" align="center" class=ButtonList>�ļ�����</td>
      <td width="358" align="center" class=ButtonList>ͼƬ����</td>
      <td width="110" height="22" align="center" class=ButtonList>��Ŀ</td>
      <td width="90" height="22" align="center" class=ButtonList>����</td>
    </tr>
    <%                          
Set RsItem=server.createobject("adodb.recordset")
SqlItem="select * from sk_photo" 
If Request("page")<>"" then
    CurrentPage=Cint(Request("Page"))
Else
    CurrentPage=1
End if 
SqlItem=SqlItem  &  " order by ID DESC"
RsItem.open SqlItem,ConnItem,1,1
If (Not RsItem.Eof) and (Not RsItem.Bof) then
   RsItem.PageSize=MaxPerPage
   Allpage=RsItem.PageCount
   If Currentpage>Allpage Then Currentpage=1
   HistrolyNum=RsItem.RecordCount
   RsItem.MoveFirst
   RsItem.AbsolutePage=CurrentPage
   i_His=0
   Do While not RsItem.Eof
%>
    <tr class="tdbg" onMouseOut="this.style.backgroundColor=''" onMouseOver="this.style.backgroundColor='#cccccc'" style="padding: 0px 2px;"> 
      <td width="57" align="center"> <input type="checkbox" value="<%=RsItem("ID")%>" name="HistrolyID" onClick="unselectall(this.form)" style="border: 0px;background-color: #E1F4EE;">      </td>
      <td width="142" align="center"> 
</td>
      <td width="358" align="left"><a href="show.asp?id=<% = RsItem("ID") %>&lx=2" target="_blank"><%=RsItem("Title")%></a></td>
      <td width="110" align="center"><%
	  set lb=ConnItem.execute("select top 1 * from SK_Class where ClassID="& RsItem("TID")&"") 
	  if not lb.eof then Response.Write lb("ClassName")
	  lb.close
	  set lb=nothing
	  %></td>
      <td width="90" align="center"> <a href="sk_checkDatabase.asp?Action=del&Page=<%= CurrentPage %>&HistrolyID=<%=RsItem("ID")%>&radiobutton=<%=lx%>" onclick='return confirm("ȷ��Ҫɾ���˼�¼��");'>ɾ��</a>      </td>
    </tr>
    <%         
           i_His=i_His+1
           If i_His > MaxPerPage Then
              Exit Do
           End If
        RsItem.Movenext         
   Loop         
%>
    <tr class="tdbg"> 
      <td colspan=8 height="30">
        <input name="Action" type="hidden" id="Action" value="ok"> 
		<input name="radiobutton" type="hidden" id="Action" value="<%=lx%>"> 
		<input name="page" type="hidden" value="<%=CurrentPage %>"> 
        <input name="chkAll" type="checkbox" id="chkAll" onclick=CheckAll(this.form) value="checkbox" style="border: 0px;background-color: #E1F4EE;">
        ȫѡ </td>
    </tr>
    <tr class="tdbg"> 
      <td colspan=8 height="30" align=center>
        &nbsp;&nbsp; <input type="submit" value="ɾ����ѡ��¼" name="DelFlag"  onclick='return confirm("ȷ��Ҫɾ��ѡ�еļ�¼��");' class="lostfocus" style="cursor: hand;background-color: #cccccc;"> 
		&nbsp;&nbsp; <input type="submit" value="ɾ��ȫ����¼" name="DelFlag" onclick='return confirm("ȷ��Ҫɾ�����еļ�¼��");' class="lostfocus" style="cursor: hand;background-color: #cccccc;"> 
       &nbsp;&nbsp; <input type="button" class="lostfocus" value="���ȫ��ͼƬ��ַ" name="DelFlag" onClick="window.location.href='SK_checkDatabase.asp?Urlsc=ok&radiobutton=2'" style="cursor: hand;background-color: #cccccc;">
	   <br>
	   <input name="picurl_th" type="text"  class="lostfocus" value="" size="80" maxlength="150">
	   &nbsp;&nbsp; <input type="submit" value="ͼƬ��ַ�滻" class="lostfocus" name="DelFlag" onClick="" style="cursor: hand;background-color: #cccccc;">
    </tr>
	
    <tr class="tdbg"> 
      <td colspan=8 height="30">
	  </td>
    </tr>
    <%Else%>
    <tr class="tdbg"> 
      <td colspan='9' class="tdbg" align="center"><br>
        ϵͳ�����޼�¼��</td>
    </tr>
    <%End  If%>
    <%         
RsItem.Close         
Set RsItem=nothing           
%>
  </form>
</table>  
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" class="tableBorder" >
    <tr> 
      <td height="22" colspan="2" class="tdbg">
<%
Response.Write ShowPage("sk_checkDatabase.asp?Action="& Action &"&radiobutton="& lx,HistrolyNum,MaxPerPage,True,True," ����¼")
%>

      </td>
    </tr>
</table>     
</body>         
</html>
<%End Sub
Sub InsertIntoBase(collectlx,FRS)
Response.Flush()
set rslb=Conn.Execute("select top 1 * from Ok3w_Class Where ID=" & FRS("ClassID")) 
if not rslb.eof then
	   Set CMSRS=Server.CreateObject("ADODB.RECORDSET")
	   CMSRS.Open "Select top 1 * From Ok3w_Article Where Title='" & FRS("Title") & "' And ClassID=" & FRS("ClassID") & "",Conn,1,3
	   If CMSRS.EOF Then
	   	   CMSRS.addnew
		   
		   	CMSRS("ID") =  Conn.Execute("select max(ID) from Ok3w_Article")(0)+1
			CMSRS("ChannelID") = 1
			CMSRS("ClassID") = FRS("ClassID")
			CMSRS("SortPath") = Conn.Execute("select SortPath from Ok3w_Class where ID=" & FRS("ClassID"))(0)
			CMSRS("Title") = FRS("Title")
			CMSRS("TitleColor") = ""
			CMSRS("TitleURL") = ""
			CMSRS("Content") = Replace(FRS("Content"), """../../upfiles/", """upfiles/")
			CMSRS("Author") = FRS("Author")
			CMSRS("ComeFrom") = FRS("CopyFrom")
			CMSRS("AddTime") = FRS("UpdateTime")
			CMSRS("Inputer") = Request.Cookies("Ok3w")("AdminName")
			CMSRS("IsPass") = 1
			CMSRS("IsPic") = 0
			CMSRS("PicFile") = ""
			CMSRS("IsTop") = 0
			CMSRS("IsCommend") = 0
			CMSRS("IsDelete") = 0
			CMSRS("IsMove") = 0
			CMSRS("IsPlay") = 0
			CMSRS("IsUserAdd") = 0
			CMSRS("GiveJifen") = 0
			CMSRS("vUserGroupID") = 0
			CMSRS("vUserMore") = 1
			CMSRS("vUserJifen") = 0
			CMSRS("Hits") = FRS("Hits")
		
		   CMSRS.update
		   SuccNum = SuccNum + 1
	   Else
	       ErrNum = ErrNum + 1
	   End if
	   Inum=Inum+1
	   CMSRS.close
	   Set CMSRS = Nothing
end if
rslb.close
set rslb=nothing
end sub

Sub InsertIntoBase_photo(FRS)
Response.Flush()
set rslb=Conn.Execute("select top 1 * from ks_Class Where ID='" & FRS("Tid") &"'")
if not rslb.eof then 
	    Set CMSRS=Server.CreateObject("ADODB.RECORDSET")
	   	CMSRS.Open "Select top 1 * From KS_Photo Where Title='" & FRS("Title") & "' And Tid='" & FRS("Tid") & "'",Conn,1,3
	   	If CMSRS.EOF Then
	   	   CMSRS.addnew
		   	NewsID=GetInfoID_CMS(2)
		    CMSRS("PicID")=NewsID
			CMSRS("Tid")=FRS("Tid")
			CMSRS("KeyWords")=FRS("KeyWords")
			CMSRS("Title")=FRS("Title")
			CMSRS("PhotoUrl")=FRS("PhotoUrl")
			CMSRS("PicUrls")=FRS("PicUrls")
			CMSRS("PictureContent")=FRS("PictureContent")
			CMSRS("Author")=FRS("Author")
			CMSRS("Origin")=FRS("Origin")
			CMSRS("Rank")="������"
			CMSRS("Hits")=FRS("Hits")
			CMSRS("HitsByDay")=MakeRandom(1)
			CMSRS("HitsByWeek")=MakeRandom(2)
			CMSRS("HitsByMonth")=MakeRandom(3)
			CMSRS("AddDate")=FRS("AddDate")
			CMSRS("TemplateID")=rslb("ArticleTemplateID")
			CMSRS("PictureFsoType")=rslb("ArticleFsoType")
			CMSRS("Fname")=NewsID & ".htm"
			CMSRS("PictureInput")=FRS("PictureInput")
			CMSRS("RefreshTF")=0
			CMSRS("Recommend")=0
			CMSRS("Rolls")=0
			CMSRS("Strip")=0
			CMSRS("Popular")=0
			CMSRS("Verific")=1
			CMSRS("Comment")=1
			CMSRS("Score")=MakeRandom(3)
			CMSRS("Slide")=0
			CMSRS("BeyondSavePic")=0
			CMSRS("DelTF")=0
			CMSRS("OrderID")=1
		   CMSRS.update
		   SuccNum = SuccNum + 1
	   	Else
	       ErrNum = ErrNum + 1
	   	End if
	   	CMSRS.close
	    Set CMSRS = Nothing
End if	   
rslb.close
set rslb=nothing
end sub

Sub InsertIntoBase_down(FRS)
Response.Flush()
	   set rslb=Conn.Execute("select top 1 * from ks_Class Where ID='" & FRS("Tid") &"'") 
	   if not rslb.eof then ArticleTemplateID=rslb("ArticleTemplateID") : ArticleFsoType=rslb("ArticleFsoType") 
	   Set CMSRS=Server.CreateObject("ADODB.RECORDSET")
	   CMSRS.Open "Select top 1 * From KS_download Where Title='" & FRS("Title") & "' And Tid='" & FRS("Tid") & "'",Conn,1,3
	   If CMSRS.EOF Then
	   	   CMSRS.addnew
		  	DownID=GetInfoID_CMS(3)
			CMSRS("DownID")=DownID
			CMSRS("Tid")=fRS("Tid")
			CMSRS("KeyWords")=fRS("KeyWords")
			CMSRS("Title")=fRS("Title")
			CMSRS("DownVersion")="" '�汾��Ϣ
			CMSRS("DownLB")="��������"  '�������
			CMSRS("DownYY")=""    '��������
			CMSRS("DownSQ")= "��Ѱ�"     '������Ȩ
			CMSRS("DownPT")= "Win9x/NT/2000/XP"     '����ƽ̨
			CMSRS("DownSize")="0KB"    '��С
			CMSRS("YSDZ")="http://"        '��ʾ��ַ
			CMSRS("ZCDZ")="http://"     'ע���ַ
			CMSRS("JYMM")=""       '��ѹ����
			CMSRS("PhotoUrl")=fRS("PhotoUrl")
			CMSRS("BigPhoto")=""   '������ͼ
			CMSRS("FlagUrl")=0            '0��Ĭ�Ϸ�ʽ 1�������������ʽ
			CMSRS("DownUrls")=fRS("DownUrls")   '���ص�ַ������Ĭ�Ϸ�ʽ������|||����
			CMSRS("DownContent")=fRS("DownContent") '���ؼ��
			CMSRS("Author")=fRS("Author")    '��������
			CMSRS("Origin")=fRS("Origin")    '������Դ
			CMSRS("Rank")="����"      '�Ķ��ȼ�
			CMSRS("Hits")=fRS("Hits")          '�������
			CMSRS("HitsByDay")=MakeRandom(1)  '�������
			CMSRS("HitsByWeek")=MakeRandom(2)  '�������
			CMSRS("HitsByMonth")=MakeRandom(3)  '�������
			CMSRS("AddDate")=fRS("AddDate")       '����ʱ��
			CMSRS("TemplateID")=ArticleTemplateID            'ģ��ID
			CMSRS("DownFsoType")=ArticleFsoType      '
			CMSRS("Fname")=DownID &".htm"
			if fRS("DownInput")<>"" then
			CMSRS("DownInput")=fRS("DownInput")
			else
			CMSRS("DownInput")=""
			end if
			CMSRS("RefreshTF")=0
			CMSRS("Recommend")=0
			CMSRS("Popular")=0
			CMSRS("Verific")=1
			CMSRS("Comment")=0
			CMSRS("DelTF")=0
			CMSRS("OrderID")=1
			CMSRS("InfoPurview")=0'�鿴Ȩ��0�̳���ĿȨ��,1���л�Ա,2ָ����Ա��
			CMSRS("ArrGroupID")="" 'ָ����Ա��Ĳ鿴Ȩ��
			CMSRS("ReadPoint")=0  '�Ķ�����
			CMSRS("ChargeType")=0  '�ظ��շѷ�ʽ
			CMSRS("PitchTime")=24   '�ظ��շ�Сʱ��
			CMSRS("ReadTimes")=10    '�ظ��շѲ鿴����
			CMSRS("DividePercent")=0   
		   CMSRS.update
		   SuccNum = SuccNum + 1
	   Else
	       ErrNum = ErrNum + 1
	   End if
	   rslb.close
	   set rslb=nothing
	   CMSRS.close
	   Set CMSRS = Nothing
end sub
'===============================================
'��������FSOSaveFile
'��  �ã������ļ�
'��  ���� Content����,·�� ע������Ŀ¼
'===============================================
Sub FSOSaveFile(Content, LocalFileName)
    Dim FSO, FileObj
    Set FSO = Server.CreateObject("Scripting.FileSystemObject")
    Set FileObj = FSO.CreateTextFile(Server.MapPath(LocalFileName), True) '�����ļ�
    FileObj.Write Content
    FileObj.Close     '�ͷŶ���
    Set FileObj = Nothing
    Set FSO = Nothing
End Sub
'Call CloseConn()
Call CloseConnItem()
%>
