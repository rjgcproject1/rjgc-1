<%
option explicit
response.buffer=true
%>
<!--#include file="inc/setup.asp"-->


<html>
<head>
<title>采集系统</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" type="text/css" href="css/Admin_Style.css">
<STYLE type=text/css>
BODY {
	SCROLLBAR-FACE-COLOR: #1F5AAA;
	BACKGROUND: #ffffff;
	MARGIN: 0px;
	FONT: 12px 宋体;
	SCROLLBAR-HIGHLIGHT-COLOR: #799ae1;
	SCROLLBAR-SHADOW-COLOR: #799ae1;
	SCROLLBAR-3DLIGHT-COLOR: #799ae1;
	SCROLLBAR-ARROW-COLOR: #ffffff;
	SCROLLBAR-TRACK-COLOR: #A6C2FF;
	SCROLLBAR-DARKSHADOW-COLOR: #799ae1;
	background-color: #619DE6;
}
TABLE {
	BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px
}
TD {
	FONT: 12px 宋体
}
IMG {
	BORDER-RIGHT: 0px; BORDER-TOP: 0px; VERTICAL-ALIGN: bottom; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px
}
A {
	FONT: 12px 宋体; 
}
A:hover {
	COLOR: #428eff; TEXT-DECORATION: underline
}
.sec_menu {
	BORDER-RIGHT: white 1px solid;
	OVERFLOW: hidden;
	BORDER-LEFT: white 1px solid;
	BORDER-BOTTOM: white 1px solid;
	background-color: #EBEBEB;
}
.menu_title {
background-image: url(css/images/menu-02.gif);
	height: 22px;
	font-family: "宋体";
	font-size: 12px;
	color: #FFFFFF;
}
.menu_title SPAN {
	FONT-WEIGHT: bold;
	LEFT: 8px;
	COLOR: #215dc6;
	POSITION: relative;
	TOP: 2px;
}
.menu_title2 {
	background-image: url(css/images/menu-02.gif);
	height: 22px;
	font-family: "宋体";
	font-size: 12px;
	font-weight: bold;

}
.menu_title2 SPAN {
	FONT-WEIGHT: bold; LEFT: 8px; COLOR: #428eff; POSITION: relative; TOP: 2px
}
.STYLE1 {color: #333333}
</STYLE>
<SCRIPT language=javascript1.2>
function showsubmenu(sid)
{
whichEl = eval("submenu" + sid);
if (whichEl.style.display == "none")
{
eval("submenu" + sid + ".style.display=\"\";");
}
else
{
eval("submenu" + sid + ".style.display=\"none\";");
}
}
</SCRIPT>

<SCRIPT language=javascript>
var itemp;
var tobj="";
itemp="";
function leftBgOver(obj){//菜单
	obj.style.background="url(images/left_bg02.gif) center no-repeat";
	//obj.style.position="center";
	//obj.style.repeat="no-repeat":
}

function leftBgOut(obj,sty){
	//alert( (sty)?"url(" + sty + ")":"");
if (tobj!="")
{
sty="images/left_bg01.gif";
obj.style.background= (sty)?"url(" + sty + ")":"";
}
else 
{
obj.style.background= (sty)?"url(" + sty + ")":"";
}
}

    function unselectall(thisform){
        if(thisform.chkAll.checked){
            thisform.chkAll.checked = thisform.chkAll.checked&0;
        }   
    }
    function CheckAll(thisform){
        for (var i=0;i<thisform.elements.length;i++){
            var e = thisform.elements[i];
            if (e.Name !="chkAll"&&e.disabled!=true)
                e.checked = thisform.chkAll.checked;
        }
    }
</script>
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<table width="40%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="5"></td>
  </tr>
</table>
<table width="180" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td>
      <TABLE  width="160" align=center cellPadding=0 cellSpacing=0  style="border:#003399 solid 1xp">
        <TBODY>
          <TR>
            <TD  height=22   id=menuTitle1 onclick=showsubmenu(0) onMouseOver="this.className='menu_title2';" onMouseOut="this.className='menu_title';"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr class="menu_title">
                <td width="84%">&nbsp;<strong>采集管理</strong></td>
                    <td width="16%"><img src="css/images/menu-03.gif" width="25" height="20"></td>
                </tr>
              </table></TD>
          </TR>
          <TR bgcolor="#FFFFFF">
            <TD id=submenu0><DIV style="WIDTH: 158px">
              <TABLE width=150 align=center cellPadding=0 cellSpacing=0 bgcolor="#FFFFFF">
                <TBODY>
                  <TR>
                    <TD></TD>
                    </TR>
					<TR>
                    <TD height=30 align="center" background="images/left_bg01.gif" style="cursor:hand"  onClick="javascript:parent.main.location.href='SK_Collect_Help.asp';" onMouseOver="leftBgOver(this);" onMouseOut="leftBgOut(this,'images/left_bg01.gif');">使用说明</TD>
                  </TR>
				  <TR>
                    <TD height=30 align="center" background="images/left_bg01.gif" style="cursor:hand"  onClick="javascript:parent.main.location.href='Sk_Config.asp';" onMouseOver="leftBgOver(this);" onMouseOut="leftBgOut(this,'images/left_bg01.gif');">系统设置</TD>
                  </TR>
					<TR>
                    <TD height=30 align="center" background="images/left_bg01.gif" style="cursor:hand"  onClick="javascript:parent.main.location.href='Sk_Channel.asp';" onMouseOver="leftBgOver(this);" onMouseOut="leftBgOut(this,'images/left_bg01.gif');">采集模块</TD>
                  </TR>
                  <% Response.Write Skcj.CjMenu() %>
                  <TR>
                    <TD height=30 align="center" background="images/left_bg01.gif" style="cursor:hand"  onClick="javascript:parent.main.location.href='sk_ItemFilters.asp';" onMouseOver="leftBgOver(this);" onMouseOut="leftBgOut(this,'images/left_bg01.gif');">数据过滤</TD>
                    </TR>
                  
                  <TR>
                    <TD height=30 align="center" background="images/left_bg01.gif" style="cursor:hand"  onClick="javascript:parent.main.location.href='sk_ItemHistroly.asp';" onMouseOver="leftBgOver(this);" onMouseOut="leftBgOut(this,'images/left_bg01.gif');">历史记录</TD>
                    </TR>
                  <TR>
                    <TD height=30 align="center" background="images/left_bg01.gif" style="cursor:hand"  onClick="javascript:parent.main.location.href='sk_checkDatabase.asp';" onMouseOver="leftBgOver(this);" onMouseOut="leftBgOut(this,'images/left_bg01.gif');">数据查看</TD>
                    </TR>
                  <TR>
                    <TD height=30 align="center" background="images/left_bg01.gif" style="cursor:hand"  onClick="javascript:parent.main.location.href='sk_ItemDatabase.asp';" onMouseOver="leftBgOver(this);" onMouseOut="leftBgOut(this,'images/left_bg01.gif');">数据维护</TD>
                    </TR>
                  <TR>
                    <TD height=30 align="center" background="images/left_bg01.gif" style="cursor:hand"  onClick="javascript:parent.close();" onMouseOver="leftBgOver(this);" onMouseOut="leftBgOut(this,'images/left_bg01.gif');">退出系统</TD>
                    </TR>
                  <TBODY>
                  </TBODY>
                </TABLE>
              </DIV>
                  <DIV style="WIDTH: 158px">
                    <TABLE width=135 border="0" align=center cellPadding=0 cellSpacing=0>
                      <TR>
                        <TD></TD>
                      </TR>
                    </TABLE>
                  </DIV></TD>
          </TR>
        </TBODY>
      </TABLE>
      <br></td>
  </tr>
</table>
</body>


