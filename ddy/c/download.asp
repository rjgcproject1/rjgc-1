<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<%Const dbdns="../"%>
<!--#include file="../AppCode/Conn.asp"-->
<!--#include file="../AppCode/Class/Ok3w_User.asp"-->
<!--#include file="../AppCode/fun/function.asp"-->
<%
SoftID = Cdbl(Request.QueryString("SoftID"))
SerID = Cdbl(Request.QueryString("SerID"))
UnionID = Cdbl(Request.QueryString("UnionID"))

Sql="update Ok3w_Soft set Hits=Hits+1 where ID=" & SoftID
Conn.Execute Sql

Sql="select Softdownloadurl,SoftName,vUserGroupID,vUserJifen,vUserMore from Ok3w_Soft where ID=" & SoftID & " and IsPass=1 and IsDelete=0"
Rs.Open Sql,Conn,0,1
If Rs.Eof And Rs.Bof Then
	Set Rs = Nothing
	Call CloseConn()
	Response.Write("资源不存在")
	Response.End()
End If
Softdownloadurl = Rs(0)
SoftName = Rs(1)
vUserGroupID = Rs(2)
vUserJifen = Rs(3)
vUserMore = Rs(4)
Rs.Close

If vUserGroupID=0 And vUserJifen=0 Then
	'无限制
Else
	Set User = New Ok3w_User
	User_Name = Replace(User.IsLogin(),"'","")
	If User_Name="" Then
		'未登陆
		Call Not_Download()
		Set Rs = Nothing
		Call CloseConn()
		Response.End()
	Else
		Jifen = Conn.Execute("select Jifen from Ok3w_User where User_Name='" & User_Name & "'")(0)
		GroupID = GetUserDengjiID(Jifen)
		If (Jifen>=vUserJifen And vUserJifen<>0) Or (GroupID=vUserGroupID Or (GroupID>vUserGroupID And vUserMore=1) And vUserGroupID<>0) Then
			'权限够
		Else
			'无权限
			Call Not_Download()
			Set Rs = Nothing
			Call CloseConn()
			Response.End()
		End If
	End If
End If

Set Rs = Nothing
Call CloseConn()

If Left(Softdownloadurl,7)="http://" Then
Else
	SevTmp = Split(Application("Ok3w_SiteSoftServer"),vbCrLf)
	sTmp = Split(SevTmp(SerID),"|")
	Serdns = sTmp(1)
	
	If Left(Serdns,7)="http://" Then
	Else
		SERVER_NAME = Request.ServerVariables("SERVER_NAME")
		SERVER_PORT = Request.ServerVariables("SERVER_PORT")
		PATH_INFO = Request.ServerVariables("PATH_INFO")
		PATH_TMP = Split(PATH_INFO,"/")
		PATH_INFO = Replace(PATH_INFO,PATH_TMP(Ubound(PATH_TMP)),"")
		If SERVER_PORT<>80 Then SERVER_NAME = SERVER_NAME & ":" & SERVER_PORT
		
		If Left(Serdns,1)="/" Then
			Serdns = "http://" & SERVER_NAME & Serdns
		Else
			Serdns = "http://" & SERVER_NAME & Replace(PATH_INFO,"/c/","/") & Serdns
		End If
	End If
		
	Softdownloadurl = Serdns & Softdownloadurl
End If

Select Case UnionID
	Case 0
		Response.Redirect(Softdownloadurl)
	Case 1
%>
<!--#include file="xunlei_base64.asp"-->
<SCRIPT src="http://pstatic.xunlei.com/js/webThunderDetect.js"></SCRIPT>
<%
Dim thunderUrl
thunderUrl = ThunderEncode(Softdownloadurl)
%>
<A id="aa" oncontextmenu=ThunderNetwork_SetHref(this) onclick="return OnDownloadClick_Simple(this,2,4)" href="#" thunderResTitle="<%=SoftName%>" thunderType="" thunderPid="<%=Application("Ok3w_SiteSoftXunlei")%>" thunderHref="<%=thunderUrl%>">如果迅雷没有自动下载，请点这里...</A>
<script language="javascript">OnDownloadClick_Simple(aa,2,4);</script>	
<%
	Case 2
%>
<!--#include file="Flashget_base64.asp"-->
<script src="http://ufile.kuaiche.com/Flashget_union.php?fg_uid=<%=Application("Ok3w_SiteSoftFlashget")%>"></script>
<%
Dim flashgetUrl,Url
Url = Softdownloadurl
flashgetUrl = FlashgetEncode(Url,Application("Ok3w_SiteSoftFlashget"))
%>
<a href="#" onClick="ConvertURL2FG('<%=flashgetUrl%>','<%= Url%>',<%=Application("Ok3w_SiteSoftFlashget")%>)" fg="<%=flashgetUrl%>" oncontextmenu="Flashget_SetHref(this)" >如果快车没有自动下载，请点这里...</a>
<script language="javascript">ConvertURL2FG('<%=flashgetUrl%>','<%= Url%>',<%=Application("Ok3w_SiteSoftFlashget")%>);</script>
<%
End Select
%>

<%Private Sub Not_Download()%>
提示：只有本站会员<%If vUserJifen<>0 Then%>，且积分大于<strong><%=vUserJifen%></strong><%End If%><%If vUserGroupID<>0 Then%>，且等级属于<strong><%=GetUserDengjiValue(0,vUserGroupID)%></strong><%If vUserMore=1 Then%>及以上<%End If%><%End If%>才能下载该软件。
<%If User_Name<>"" Then%>
<br /><br /><br />
你目前的积分是：<strong><%=Jifen%></strong> 等级为：<strong><%=GetUserDengjiValue(0,GroupID)%></strong>
<%End If%>
<%End Sub%>