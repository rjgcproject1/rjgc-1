<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<%dbdns="../"%>
<!--#include file="chk.asp"-->
<!--#include file="../AppCode/Class/Ok3w_SiteConfig.asp"-->
<!--#include file="../AppCode/fun/function.asp"-->
<%
Call CheckAdminFlag(5)

Select Case Trim(Request.Form("action"))
	Case "SiteUserDengji"
		Set SiteConfig = New Ok3w_SiteConfig
		Call SiteConfig.SiteUserDengji()
		Call SaveAdminLog("编辑系统设置")
		Call CloseConn()
		Call ActionOk("Sys_ConfigSiteUserDengji.asp")
End Select
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>后台管理系统</title>
<link rel="stylesheet" type="text/css" href="images/Style.css"></head>

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
                background="images/tab_active_bg.gif" class="tab"><strong class="mtitle">会员等级与积分管理</strong></td>
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
                valign="top" bgcolor="#fffcf7"><table border="0" cellpadding="5" cellspacing="1" bgcolor="#CCCCCC">
                      <form id="form1" name="form1" method="post" action="">
                        
                        
                        <tr>
                          <td align="right" bgcolor="#EBEBEB">等级序号</td>
                          <td bgcolor="#EBEBEB">自定义名称</td>
                          <td bgcolor="#EBEBEB">达到该级别所需最低积分</td>
                          <td bgcolor="#EBEBEB">等级图片</td>
                          </tr>
<%For i=1 To 12%>						  
                        <tr>
                          <td align="right" bgcolor="#FFFFFF">第<strong><%=i%></strong>级</td>
                          <td bgcolor="#FFFFFF"><input name="name" type="text" id="name" value="<%=GetUserDengjiValue(0,i)%>"></td>
                          <td bgcolor="#FFFFFF"><input name="jifen" type="text" id="jifen" size="8" value="<%=GetUserDengjiValue(1,i)%>"></td>
                          <td bgcolor="#FFFFFF"><input name="pic" type="text" id="pic" value="<%=GetUserDengjiValue(2,i)%>"></td>
                          </tr>
<%Next%>
                        <tr>
                          <td align="right" bgcolor="#FFFFFF">备注</td>
                          <td colspan="3" bgcolor="#FFFFFF">默认十二个级别，不启用的，名称处留空即可；积分要按从小到大的输入。</td>
                          </tr>
                        <tr>
                          <td colspan="4" align="center" bgcolor="#FFFFFF"><input name="action" type="hidden" id="action" value="SiteUserDengji">
                            <input type="submit" name="Submit" value="保存"></td>
                          </tr>
                      </form>
                    </table></td>
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
Set Admin = Nothing
Set SiteConfig = Nothing
%>

