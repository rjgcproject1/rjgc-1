<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<%Const dbdns="../"%>
<!--#include file="chk.asp"-->
<!--#include file="../AppCode/Class/Ok3w_Class.asp"-->
<!--#include file="../AppCode/fun/function.asp"-->
<%
ChannelID = Request.QueryString("ChannelID")
Select Case ChannelID
	Case 1
		Call CheckAdminFlag(3)
	Case 2
		Call CheckAdminFlag(2)
	Case 3
		Call CheckAdminFlag(6)
	Case Else
		Response.End()
End Select
Set myClass = New Ok3w_Class
ParentID = Request.QueryString("ParentID")
SortPath = Request.QueryString("SortPath")
If SortPath="" Then SortPath = "0,"

Select Case Request.Form("action")
	Case "add"
		Call myClass.Add()
		Call ActionOk("Class_Manage.asp?ChannelID=" & ChannelID & "&ParentID=" & ParentID & "&SortPath=" & SortPath)
	Case "edit"
		Call myClass.Edit()
		Call ActionOk("Class_Manage.asp?ChannelID=" & ChannelID & "&ParentID=" & ParentID & "&SortPath=" & SortPath)
	Case "del"
		Call myClass.Del()
		Call ActionOk("Class_Manage.asp?ChannelID=" & ChannelID & "&ParentID=" & ParentID & "&SortPath=" & SortPath)
End Select
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>��̨����ϵͳ</title>
<link rel="stylesheet" type="text/css" href="images/Style.css">
</head>

<body>
<!--#include file="top.asp"-->
<br />
<table cellspacing="0" cellpadding="0" width="98%" align="center" border="0">
  <tbody>
    <tr>
      <td style="PADDING-LEFT: 2px; HEIGHT: 22px" 
    background="images/tab_top_bg.gif"><table cellspacing="0" cellpadding="0" width="477" border="0">
        <tbody>
          <tr>
            <td width="147"><table height="22" cellspacing="0" cellpadding="0" border="0">
              <tbody>
                <tr>
                  <td width="3"><img id="tabImgLeft__0" height="22" 
                  src="images/tab_active_left.gif" width="3" /></td>
                  <td class="mtitle" 
                background="images/tab_active_bg.gif">�������</td>
                  <td width="3"><img id="tabImgRight__0" height="22" 
                  src="images/tab_active_right.gif" 
            width="3" /></td>
                </tr>
              </tbody>
            </table></td>
          </tr>
        </tbody>
      </table></td>
    </tr>
    <tr>
      <td bgcolor="#ffffff"><table cellspacing="0" cellpadding="0" width="100%" border="0">
        <tbody>
          <tr>
            <td width="1" background="images/tab_bg.gif"><img height="1" 
            src="images/tab_bg.gif" width="1" /></td>
            <td 
          style="PADDING-RIGHT: 10px; PADDING-LEFT: 10px; PADDING-BOTTOM: 10px; PADDING-TOP: 10px" 
          valign="top"><div id="tabContent__0" style="DISPLAY: block; VISIBILITY: visible">
              <table cellspacing="1" cellpadding="1" width="100%" align="center" 
            bgcolor="#8ccebd" border="0">
                <tbody>
                  <tr>
                    <td 
                style="PADDING-RIGHT: 10px; PADDING-LEFT: 10px; PADDING-BOTTOM: 10px; PADDING-TOP: 10px" 
                valign="top" bgcolor="#fffcf7">��ǰλ�ã�<a href="?ChannelID=<%=ChannelID%>&ParentID=0"><%=GetChannelName(ChannelID)%></a>
                            <%
	Tmp = Split(SortPath,",")
	For i=1 To Ubound(Tmp)-1
		Sql="select * from Ok3w_Class where ID=" & Tmp(i)
		Set oRs = Conn.Execute(Sql)
	%>
                          &gt;&gt; <a href="?ChannelID=<%=ChannelID%>&ParentID=<%=oRs("ID")%>&amp;SortPath=<%=oRs("SortPath")%>"><%=oRs("SortName")%></a>
       <%
		oRs.Close
		Set oRs = Nothing
	Next	
	%>
	   <br /><br />
       <table border="0" cellpadding="5" cellspacing="1" bgcolor="#CCCCCC">
         <tr>
           <td bgcolor="#EBEBEB">��������</td>
           <td bgcolor="#EBEBEB">������ʾ</td>
           <td bgcolor="#EBEBEB">ͼƬ�б�</td>
           <td bgcolor="#EBEBEB">ÿҳ����</td>
           <td bgcolor="#EBEBEB">�ⲿ����</td>
           <td bgcolor="#EBEBEB">��ʾ˳��</td>
           <td bgcolor="#EBEBEB">����</td>
           </tr>
		   <form action="" method="post" onSubmit="return chkform(this);">
         <tr>
           <td bgcolor="#FFFFFF"><input name="SortName" type="text" id="SortName" size="15" maxlength="50" /></td>
           <td bgcolor="#FFFFFF"><input name="IsNav" type="checkbox" id="IsNav" value="1" checked></td>
           <td bgcolor="#FFFFFF"><input name="IsPic" type="checkbox" id="IsPic" value="1" /></td>
           <td bgcolor="#FFFFFF"><input name="PageSize" type="text" id="PageSize" value="20" size="4" maxlength="2"></td>
           <td bgcolor="#FFFFFF"><input name="gotoURL" type="text" id="gotoURL" size="25" maxlength="50" /></td>
           <td bgcolor="#FFFFFF"><input name="OrderID" type="text" id="OrderID" value="<%=myClass.GetMaxClassOrder(ParentID)+1%>" size="4" maxlength="4" /></td>
           <td bgcolor="#FFFFFF"><input name="Submit3" type="submit" class="bntStyle" value="�� ��" />
             <input name="ChannelID" type="hidden" id="ChannelID" value="<%=ChannelID%>" />
             <input name="SortPath" type="hidden" id="SortPath" value="<%=SortPath%>" />
             <input name="ParentID" type="hidden" id="ParentID" value="<%=ParentID%>" />
             <input name="action" type="hidden" id="action" value="add" /></td>
           </tr>
		   </form>
       </table>

       <br>
       <table border="0" cellpadding="5" cellspacing="1" bgcolor="#CCCCCC">
                      <tr bgcolor="#EBEBEB">
                        <td>��������</td>
                        <td>����ID</td>
                        <td>��������</td>
                        <td>����</td>
                        <td>ͼƬ</td>
                        <td>ÿҳ����</td>
                        <td>�ⲿ����</td>
                        <td>����</td>
                        <td>С����</td>
                        <td>����</td>
                      </tr>
                      <%
Sql="select * from Ok3w_Class where ChannelID=" & ChannelID & " and ParentID=" & ParentID & " order by OrderID"
Rs.Open Sql,Conn,1,1
If Not(Rs.Eof And Rs.Bof) Then
Do While Not Rs.Eof
%>
                      <form action="" method="post" onSubmit="return chkform(this);">
                        <tr bgcolor="#FFFFFF">
                          <td><%=GetClassName(Rs("ParentID"))%></td>
                          <td><input name="ID" type="text" id="ID" value="<%=Rs("ID")%>" size="4" disabled="disabled" /></td>
                          <td><input name="SortName" type="text" id="SortName" value="<%= Rs("SortName")%>" size="15" /></td>
                          <td><input name="IsNav" type="checkbox" id="IsNav" value="1" <%If Rs("IsNav")=1 Then%>checked="checked"<%End If%> /></td>
                          <td><input name="IsPic" type="checkbox" id="IsPic" value="1" <%If Rs("IsPic")=1 Then%>checked="checked"<%End If%> /></td>
                          <td><input name="PageSize" type="text" id="PageSize" value="<%=Rs("PageSize")%>" size="4" maxlength="2"></td>
                          <td><input name="gotoURL" type="text" id="gotoURL" value="<%=Rs("gotoURL")%>" size="25" maxlength="50" /></td>
                          <td><input name="OrderID" type="text" id="OrderID" value="<%=Rs("OrderID")%>" size="4" maxlength="4" /></td>
                          <td><%If ChannelID=2 Or Rs("gotoURL")<>"" Then%><%Else%><a href="?ChannelID=<%=ChannelID%>&ParentID=<%=Rs("ID")%>&SortPath=<%=Rs("SortPath")%>">&gt;&gt;&gt;</a><%End If%></td>
                          <td><input name="Submit" type="submit" class="bntStyle" value="�� ��" />
                              <input name="Submit2" type="submit" class="bntStyle" value="ɾ ��" onClick="if(confirm('���Ҫɾ����')){this.form.action.value='del';}else{return false;}" <%If myClass.IsHaveNextClass(Rs("ID")) Then%>disabled="disabled"<%End If%>/>
                              <input name="SortPath" type="hidden" id="SortPath" value="<%=Rs("SortPath")%>" />
                              <input name="ParentID" type="hidden" id="ParentID" value="<%=Rs("ParentID")%>" />
							  <input name="ChannelID" type="hidden" id="ChannelID" value="<%=Rs("ChannelID")%>" />
							  <input name="action" type="hidden" id="action" value="edit" />
                              <input name="ID" type="hidden" id="ID" value="<%=Rs("ID")%>" /></td>
                        </tr>
                      </form>
                      <%
	Rs.MoveNext
Loop
Else
%>
                      <tr bgcolor="#FFFFFF">
                        <td colspan="10" align="center">������Ŀ����������</td>
                      </tr>
                      <%
End If
Rs.Close
%>
                    </table><br />
					
<div style="border:1px solid #CCCCCC; padding:5px;">
	   <strong>ʹ��ǰ�ض���</strong><br>
	   һ�����ѡ�С�ͼƬ�б�������÷�����б�ҳ��ͼƬ��ͼ����ʽ��ʾ����������ͨ������ʾ��<br />
	   ������������ⲿ���ӣ����ⲿ���ӡ���һ��Ҫ���գ�<br />
	   ��������㲻����ĳһ�����ڵ�������ʾ����ȡ����������ѡ�񼴿ɣ����������������أ������������ڸ�������أ���<br>
	   �ġ�ֻ����ɾ��С���࣬����ɾ�������
	   ��      </div>					
					
					</td>
                  </tr>
                </tbody>
              </table>
            </div></td>
            <td width="1" background="images/tab_bg.gif"><img height="1" 
            src="images/tab_bg.gif" width="1" /></td>
          </tr>
        </tbody>
      </table></td>
    </tr>
    <tr>
      <td background="images/tab_bg.gif" bgcolor="#ffffff"><img height="1" 
      src="images/tab_bg.gif" width="1" /></td>
    </tr>
  </tbody>
</table>
<script language="javascript">
function chkform(frm)
{
	if(frm.SortName.value=="")
	{
		alert("�������������")
		frm.SortName.focus();
		return false;
	}
}

<%If ChannelID=2 Then%>
parent.left.location.reload();
<%End If%>
</script>
</body>
</html>
<%
Set myClass = Nothing
Set Rs = Nothing
Call CloseConn()
%>
