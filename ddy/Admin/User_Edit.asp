<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<%dbdns="../"%>
<!--#include file="chk.asp"-->
<!--#include file="../AppCode/Class/Ok3w_User.asp"-->
<!--#include file="../AppCode/fun/function.asp"-->
<!--#include file="../AppCode/fun/md5.asp"-->
<%
Call CheckAdminFlag(5)

Set User = New Ok3w_User
action = Request.QueryString("action")
Id = Request.QueryString("Id")

action_ok = Request.Form("action_ok")
If action = "" Then action = "add"

Select Case action_ok
	Case "edit"
		Call User.AdminEdit()
		Call SaveAdminLog("修改会员：Id=" & User.Id)
		Call ActionOk("User_Edit.asp?action=edit&ID=" & ID)
End Select
If action="edit" Or action="copy" Then Call User.Load(Id)
If action="" Or action="copy" Then
	action = "add"
	Id = ""
End If
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>后台管理系统</title>
<link rel="stylesheet" type="text/css" href="images/Style.css">
<script language="javascript" src="../images/DatePicker/WdatePicker.js"></script>
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
                  <td 
                background="images/tab_active_bg.gif" class="tab"><strong class="mtitle">会员管理</strong></td>
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
                valign="top" bgcolor="#fffcf7"><table width="100%" border="0" cellpadding="5" cellspacing="1" bgcolor="#EBEBEB">
                      <form id="Form" name="Form" method="post" action="?action=<%=action%>&Id=<%=Id%>">
                        
                        <tr bgcolor="#FFFFFF">
                          <td align="right">用户名</td>
                          <td><input name="User_Name" type="text" id="User_Name" value="<%=User.User_Name%>" size="15" readonly="readonly"  /></td>
                          </tr>
                        
                        <tr bgcolor="#FFFFFF">
                          <td align="right">注册时间</td>
                          <td><strong><%=User.RegTime%></strong> 注册IP：<strong><%=User.RegIp%></strong> 最后登陆时间：<strong><%=User.LastLoginTime%></strong> 最后登陆IP：<strong><%=User.LastLoginIp%></strong> 登陆次数：<strong><%=User.LoginCount%></strong></td>
                        </tr>
                        <tr bgcolor="#FFFFFF">
                          <td align="right">积分</td>
                          <td><input name="Jifen" type="text" id="Jifen" value="<%=User.Jifen%>" size="10" /></td>
                          </tr>
                        <tr bgcolor="#FFFFFF">
                          <td align="right">存款</td>
                          <td><input name="Money" type="text" id="Money" value="<%=User.Money%>" size="10" /></td>
                          </tr>
                        <tr bgcolor="#FFFFFF">
                          <td align="right">密码</td>
                          <td><input name="User_Password" type="text" id="User_Password" <%if action<>"edit" then%>value="<%=User.User_Password%>"<%End If%> size="15" />
                            <%If action="edit" Then%>
                            <span class="red">不修改请留空</span>
                            <%End If%></td>
                          </tr>
                        <tr bgcolor="#FFFFFF">
                          <td align="right">邮箱</td>
                          <td><input name="Mail" type="text" id="Mail" value="<%=User.Mail%>" size="40" /></td>
                          </tr>
                        
                        <tr bgcolor="#FFFFFF">
                          <td align="right">真实姓名</td>
                          <td><input name="Name" type="text" id="Name" value="<%=User.Name%>" size="15" />
                            <input name="Sex" type="radio" value="男" <%If User.Sex="男" Then%>checked="checked"<%End If%> />
                            男
                            <input type="radio" name="Sex" value="女" <%If User.Sex="女" Then%>checked="checked"<%End If%> />
                            女 
                            <input type="radio" name="Sex" value="密密" <%If User.Sex="保密" Then%>checked="checked"<%End If%> />
                            保密</td>
                          </tr>
                        <tr bgcolor="#FFFFFF">
                          <td align="right">电话</td>
                          <td><input name="Tel" type="text" id="Tel" value="<%=User.Tel%>" size="15" /></td>
                          </tr>
                        <tr bgcolor="#FFFFFF">
                          <td align="right">QQ</td>
                          <td><input name="QQ" type="text" id="QQ" value="<%=User.QQ%>" size="10" /></td>
                          </tr>
                        <tr bgcolor="#FFFFFF">
                          <td align="right">出生年月日</td>
                          <td><input name="Birthday" type="text" id="Birthday" value="<%=User.Birthday%>" size="10" onClick="WdatePicker()" /></td>
                          </tr>
                        <tr bgcolor="#FFFFFF">
                          <td align="right">地址</td>
                          <td><input name="Address" type="text" id="Address" value="<%=User.Address%>" size="40" /></td>
                          </tr>
                        <tr bgcolor="#FFFFFF">
                          <td align="right">邮编</td>
                          <td><input name="Zip" type="text" id="Zip" value="<%=User.Zip%>" size="8" /></td>
                          </tr>
                        

                        <tr bgcolor="#FFFFFF">
                          <td align="right">简介</td>
                          <td><textarea name="Content" cols="80" rows="15" id="Content"><%=User.Content%></textarea></td>
                          </tr>
                        
                        <tr bgcolor="#FFFFFF">
                          <td align="right">&nbsp;</td>
                          <td><input name="action_ok" type="hidden" id="action_ok" value="<%=action%>" />
                            <input type="button" name="Submit2" value="保 存" onClick="javascript:submitform(forms[0]);"/>
                                <input type="button" name="Submit" value="取 消" onClick="javascript:document.URL='User_List.asp';" /></td>
                        </tr>
                      </form>
                    </table>
<script language="JavaScript" type="text/javascript">
function submitform(frm)
{
	if(frm.User_Name.value.trim()=="")
	{
		ShowErrMsg("会员名称不能为空，请输入");
		frm.User_Name.focus();
		return false;
	}

	frm.submit();
}
</script>
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
</body>
</html>
<%
Call CloseConn()
Set User = Nothing
Set Admin = Nothing
%>

