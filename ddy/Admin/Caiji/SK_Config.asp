
<!--#include file="inc/setup.asp"-->

<link rel="stylesheet" type="text/css" href="css/Admin_Style.css">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script src="inc/common.js" language="javascript"></script>
<%
Action=Trim(Request("Action"))
if action="save" then
	call SaveEdit()
else
	call Main()'��ʾҳ��
end if

'�ر����ݿ�����
Call CloseConnItem()

'����
Sub SaveEdit()
		ConnItem.Execute("Update Sk_cj Set Dir='"& Trim(Request.Form("ArticleDir")) &"' Where Id=1")
		ConnItem.Execute("Update Sk_cj Set Dir='"& Trim(Request.Form("photoDir")) &"' Where Id=2")
		ConnItem.Execute("Update Sk_cj Set Dir='"& Trim(Request.Form("DownDir")) &"' Where Id=3")
		SqlItem="select top 1 * from SK_Config"
     	Set Rs=server.CreateObject("adodb.recordset")
     	Rs.Open SqlItem,ConnItem,3,3
		rs("WebName")=Request.Form("WebName")
		rs("WebUrl")=Request.Form("WebUrl")
		rs("WebLogo")=Request.Form("WebLogo")
		rs("Webabout")=Request.Form("Webabout")
			Response.Flush()
			If G("RateTF") = "" Then
				RS("RateTF") = 0
			Else
				RS("RateTF") = G("RateTF")
			End If
			If G("ThumbWidth") = "" Then
				RS("ThumbWidth") = 0
			Else
				RS("ThumbWidth") = G("ThumbWidth")
			End If
			If G("ThumbHeight") = "" Then
				RS("ThumbHeight") = 0
			Else
				RS("ThumbHeight") = G("ThumbHeight")
			End If
			If G("ThumbRate") = "" Then
				RS("ThumbRate") = 0
			Else
				RS("ThumbRate") = G("ThumbRate")
			End If
			If G("MarkComponent") = "" Then
				RS("MarkComponent") = 0
			Else
				RS("MarkComponent") = G("MarkComponent")
			End If
			RS("MarkType") = G("MarkType")
			If G("MarkText") = "" Then
				RS("MarkText") = " "
			Else
				RS("MarkText") = G("MarkText")
			End If
			If G("MarkFontSize") = "" Then
				RS("MarkFontSize") = 12
			Else
				RS("MarkFontSize") = G("MarkFontSize")
			End If
			If G("MarkFontColor") = "" Then
				RS("MarkFontColor") = " "
			Else
				RS("MarkFontColor") = G("MarkFontColor")
			End If
			RS("MarkFontName") = G("MarkFontName")
			RS("MarkFontBond") = G("MarkFontBond")
			If G("MarkPicture") = "" Then
			RS("MarkPicture") = " "
			Else
			RS("MarkPicture") = G("MarkPicture")
			End If
			If G("MarkOpacity") = "" Then
				RS("MarkOpacity") = 0
			Else
				RS("MarkOpacity") = CSng(G("MarkOpacity"))
			End If
			If G("MarkWidth") = "" Then
				RS("MarkWidth") = 0
			Else
				RS("MarkWidth") = G("MarkWidth")
			End If
			If G("MarkHeight") = "" Then
				RS("MarkHeight") = 0
			Else
				RS("MarkHeight") = G("MarkHeight")
			End If
			If G("MarkTranspColor") = "" Then
				RS("MarkTranspColor") = " "
			Else
				RS("MarkTranspColor") = G("MarkTranspColor")
			End If
		
			RS("ThumbComponent") = G("ThumbComponent")
			RS("MarkPosition") = G("MarkPosition")
		Rs.UpDate
      	Rs.Close	
	  	set rs=nothing 
		response.write "<script>alert('�޸����óɹ�!');location.href='sk_config.asp';</script>"'�رմ���
    	call Main()
end sub
%>



<%Sub Main()
		SqlStr = "select * from SK_Config"
		Set RS = Server.CreateObject("adodb.recordset")
		RS.Open SqlStr, ConnItem, 1, 3
%>
<table width="97%" border="0" align="center" cellpadding="3" cellspacing="1" class="tableBorder">
<form   name="form"  action="?action=save" method="post">
  <tr>
    <td height="33" colspan="3" class="title"><div align="center"><span style="font-weight: bold">��վ��������</span></div></td>
  </tr>
  <tr>
    <td colspan="3" class="title2">&nbsp;����������վ�Ļ�����Ϣ��</td>
    </tr>
  
  <tr>
    <td width="18%" class="table">&nbsp;��վȫ��</td>
    <td colspan="2" class="table"><input name="WebName"  type="text" id="WebName" class="lostfocus" gf="0" onmouseover='this.className="getfocus"' onmouseout='if (this.gf=="0") this.className="lostfocus"' onblur='this.className="lostfocus";this.gf="0"' onfocus='this.className="getfocus";this.gf="1"'  value="<% =rs("WebName") %>" >
      ����ʾ����ҳ���磺���ɼ�ϵͳ����</td>
  </tr>
  

  

  <tr>
    <td colspan="3" class="title2">&nbsp;</td>
  </tr>
  
  
  
  <tr>
    <td colspan="3" class="title"><span style="font-weight: bold">����ͼˮӡ����</span></td>
  </tr>
  <tr>
    <td colspan="3" class="table">
	<%
			Response.Write "<body bgcolor=""#FFFFFF"" scroll=yes onLoad=""SetTypeArea(" & RS("MarkType") & ");ShowInfo(" & RS("MarkComponent") & ");ShowThumbInfo(" & RS("ThumbComponent") & ");ShowThumbSetting(" & RS("RateTF") & ")"" >"
		Response.Write "    <tr bgcolor=""#F5F5F5"" >"
		Response.Write "      <td width=""257"" height=""40"" align=""right"" class=""table""><STRONG>��������ͼ�����</STRONG><BR>"
		Response.Write "      <span class=""STYLE1"">��һ��Ҫѡ����������Ѱ�װ�����</span></td>"
		Response.Write "      <td width=""677"" class=""table"">"
		Response.Write "       <select name=""ThumbComponent"" id=""ThumbComponent"" onChange=""ShowThumbInfo(this.value)"" style=""width:50%"">"
		Response.Write "          <option value=0 "
		If RS("ThumbComponent") = "0" Then Response.Write ("selected")
		Response.Write ">�ر� </option>"
		Response.Write "          <option value=1 "
		If RS("ThumbComponent") = "1" Then Response.Write ("selected")
		Response.Write ">AspJpeg��� " & ExpiredStr(0) & "</option>"
		Response.Write "          <option value=2 "
		If RS("ThumbComponent") = "2" Then Response.Write ("selected")
		Response.Write ">wsImage��� " & ExpiredStr(1) & "</option>"
		Response.Write "          <option value=3 "
		If RS("ThumbComponent") = "3" Then Response.Write ("selected")
		Response.Write ">SA-ImgWriter��� " & ExpiredStr(2) & "</option>"
		Response.Write "        </select>"
		Response.Write "      <span id=""ThumbComponentInfo""></span></td>"
		Response.Write "    </tr>"
		Response.Write "    <tr bgcolor=""#F5F5F5"" id =""ThumbSetting"" style=""display:none"">"
		 Response.Write "     <td height=""23"" align=""right"" class=""table""> <input type=""radio"" name=""RateTF"" value=""1"" onClick=""ShowThumbSetting(1);"" "
		 If RS("RateTF") = "1" Then Response.Write ("checked")
		 Response.Write ">"
		 Response.Write "       ������"
		 Response.Write "       <input type=""radio"" name=""RateTF"" value=""0"" onClick=""ShowThumbSetting(0);"" "
		 If RS("RateTF") = "0" Then Response.Write ("checked")
		 Response.Write ">"
		 Response.Write "     ����С </td>"
		 Response.Write "     <td width=""677"" height=""50"" class=""table""> <div id =""ThumbSetting0"" style=""display:none"">&nbsp;����ͼ���ȣ�"
		Response.Write "          <input type=""text"" name=""ThumbWidth"" size=10 value=""" & RS("ThumbWidth") & """>"
		Response.Write "          ����<br>&nbsp;����ͼ�߶ȣ�"
		Response.Write "          <input type=""text"" name=""ThumbHeight"" size=10 value=""" & RS("ThumbHeight") & """>"
		Response.Write "          ����</div>"
		Response.Write "        <div id =""ThumbSetting1"" style=""display:none"">&nbsp;������"
		Response.Write "          <input type=""text"" name=""ThumbRate"" size=10 value="""
		If Left(RS("ThumbRate"), 1) = "." Then Response.Write ("0" & RS("ThumbRate")) Else Response.Write (RS("ThumbRate"))
		Response.Write """>"
		Response.Write "      <br>&nbsp;����Сԭͼ��50%,������0.5 </div></td>"
		Response.Write "    </tr>"
		Response.Write "    <tr bgcolor=""#F5F5F5"" >"
		Response.Write "      <td height=""40"" align=""right"" class=""table""><strong>ͼƬˮӡ�����</strong><BR>"
		Response.Write "      <span class=""STYLE1"">��һ��Ҫѡ����������Ѱ�װ�����</span></td>"
		Response.Write "      <td width=""677"" class=""table""> <select name=""MarkComponent"" id=""MarkComponent"" onChange=""ShowInfo(this.value)"" style=""width:50%"">"
		Response.Write "          <option value=0 "
		If RS("MarkComponent") = "0" Then Response.Write ("selected")
		Response.Write ">�ر�"
		Response.Write "          <option value=1 "
		If RS("MarkComponent") = "1" Then Response.Write ("selected")
		Response.Write ">AspJpeg��� " & ExpiredStr(0) & "</option>"
		Response.Write "          <option value=2 "
		If RS("MarkComponent") = "2" Then Response.Write ("selected")
		Response.Write ">wsImage��� " & ExpiredStr(1) & "</option>"
		Response.Write "          <option value=3 "
		If RS("MarkComponent") = "3" Then Response.Write ("selected")
		Response.Write ">SA-ImgWriter��� " & ExpiredStr(2) & "</option>"
		Response.Write "      </select>  </td>"
		Response.Write "    </tr>"
		Response.Write "    <tr align=""left"" valign=""top"" bgcolor=""#F5F5F5"" id=""WaterMarkSetting"" style=""display:none"" cellpadding=""0"" cellspacing=""0"">"
		Response.Write "      <td colspan=2 class=""table""> <table width=100% border=""0"" cellpadding=""0"" cellspacing=""1""  bordercolor=""e6e6e6"" bgcolor=""#efefef"">"
		Response.Write "          <tr bgcolor=""#FFFFFF"">"
		Response.Write "            <td width=262 height=""26"" align=""right"" class=""table"">ˮӡ����</td>"
		Response.Write "            <td width=""648"" class=""table""> <SELECT name=""MarkType"" id=""MarkType"" onChange=""SetTypeArea(this.value)"">"
		Response.Write "                <OPTION value=""1"" "
		If RS("MarkType") = "1" Then Response.Write ("selected")
		Response.Write ">����Ч��</OPTION>"
		Response.Write "                <OPTION value=""2"" "
		If RS("MarkType") = "2" Then Response.Write ("selected")
		Response.Write ">ͼƬЧ��</OPTION>"
		Response.Write "            </SELECT> </td>"
		Response.Write "          </tr>"
		Response.Write "          <tr bgcolor=""#FFFFFF"">"
		Response.Write "            <td height=""26"" align=""right"" class=""table"">�������λ��</td>"
		Response.Write "            <td class=""table""> <SELECT NAME=""MarkPosition"" id=""MarkPosition"">"
		Response.Write "                <option value=""1"" "
		If RS("MarkPosition") = "1" Then Response.Write ("selected")
		Response.Write ">����</option>"
		Response.Write "                <option value=""2"" "
		If RS("MarkPosition") = "2" Then Response.Write ("selected")
		Response.Write ">����</option>"
		Response.Write "                <option value=""3"" "
		If RS("MarkPosition") = "3" Then Response.Write ("selected")
		Response.Write ">����</option>"
		Response.Write "                <option value=""4"" "
		If RS("MarkPosition") = "4" Then Response.Write ("selected")
		Response.Write ">����</option>"
		Response.Write "                <option value=""5"" "
		If RS("MarkPosition") = "5" Then Response.Write ("selected")
		Response.Write ">����</option>"
		Response.Write "            </SELECT> </td>"
		Response.Write "          </tr>"
		Response.Write "          <tr>"
		Response.Write "           <td colspan=""2"">"
		Response.Write "           <table width=""100%"" border=""0"" cellpadding=""0"" cellspacing=""1"" bgcolor=""#efefef"" id=""textarea"">"
		Response.Write "          <tr bgcolor=""#FFFFFF"">"
		Response.Write "            <td width=""27%"" height=""26"" align=""right"" class=""table"">ˮӡ������Ϣ:</td>"
		Response.Write "            <td width=""70%"" class=""table""> <INPUT TYPE=""text"" NAME=""MarkText"" size=40 value=""" & RS("MarkText") & """>            </td>"
		Response.Write "          </tr>"
		Response.Write "          <tr bgcolor=""#FFFFFF"">"
		Response.Write "            <td height=""26"" align=""right"" class=""table"">�����С:</td>"
		Response.Write "            <td class=""table""> <INPUT TYPE=""text"" NAME=""MarkFontSize"" size=10 value=""" & RS("MarkFontSize") & """>"
		Response.Write "            <b>px</b> </td>"
		Response.Write "          </tr>"
		Response.Write "          <tr bgcolor=""#FFFFFF"">"
		Response.Write "            <td height=""26"" align=""right"" class=""table"">������ɫ:</td>"
		Response.Write "            <td class=""table""><input  type=""text"" name=""MarkFontColor"" maxlength = 7 size = 7 id=""MarkFontColor"" value=""" & RS("MarkFontColor") & """ readonly>"
		Response.Write "            <input type=""button"" name=""button12"" value=""ѡ����ɫ..."" onClick=""OpenThenSetValue('inc/SelectColor.asp',230,190,window,document.form.MarkFontColor);document.form.MarkFontColor.style.color=document.form.MarkFontColor.value;""></td>"
		Response.Write "          </tr>"
		Response.Write "          <tr bgcolor=""#FFFFFF"">"
		Response.Write "            <td height=""26"" align=""right"" class=""table"">��������:</td>"
		Response.Write "            <td class=""table""> <SELECT name=""MarkFontName"" id=""MarkFontName"">"
		Response.Write "                <option value=""����"" "
		If RS("MarkFontName") = "����" Then Response.Write ("selected")
		Response.Write ">����</option>"
		Response.Write "                <option value=""����_GB2312"" "
		If RS("MarkFontName") = "����_GB2312" Then Response.Write ("selected")
		Response.Write ">����</option>"
		Response.Write "                <option value=""������"" "
		If RS("MarkFontName") = "������" Then Response.Write ("selected")
		Response.Write ">������</option>"
		Response.Write "                <option value=""����"" "
		If RS("MarkFontName") = "����" Then Response.Write ("selected")
		Response.Write ">����</option>"
		Response.Write "                <option value=""����"" "
		If RS("MarkFontName") = "����" Then Response.Write ("selected")
		Response.Write ">����</option>"
		Response.Write "                <OPTION value=""Andale Mono"" "
		If RS("MarkFontName") = "Andale Mono" Then Response.Write ("selected")
		Response.Write ">Andale"
		Response.Write "                Mono</OPTION>"
		Response.Write "                <OPTION value=""Arial"" "
		If RS("MarkFontName") = "Arial" Then Response.Write ("selected")
		Response.Write ">Arial</OPTION>"
		Response.Write "                <OPTION value=""Arial Black"" "
		If RS("MarkFontName") = "Arial Black" Then Response.Write ("selected")
		Response.Write ">Arial"
		Response.Write "                Black</OPTION>"
		Response.Write "                <OPTION value=""Book Antiqua"" "
		If RS("MarkFontName") = "Book Antiqua" Then Response.Write ("selected")
		Response.Write ">Book"
		Response.Write "                Antiqua</OPTION>"
		Response.Write "                <OPTION value=""Century Gothic"" "
		If RS("MarkFontName") = "Century Gothic" Then Response.Write ("selected")
		Response.Write ">Century"
		Response.Write "                Gothic</OPTION>"
		Response.Write "                <OPTION value=""Comic Sans MS"" "
		If RS("MarkFontName") = "Comic Sans MS" Then Response.Write ("selected")
		Response.Write ">Comic"
		Response.Write "                Sans MS</OPTION>"
		Response.Write "                <OPTION value=""Courier New"" "
		If RS("MarkFontName") = "Courier New" Then Response.Write ("selected")
		Response.Write ">Courier"
		Response.Write "                New</OPTION>"
		Response.Write "                <OPTION value=""Georgia"" "
		If RS("MarkFontName") = "Georgia" Then Response.Write ("selected")
		Response.Write ">Georgia</OPTION>"
		Response.Write "                <OPTION value=""Impact"" "
		If RS("MarkFontName") = "Impact" Then Response.Write ("selected")
		Response.Write ">Impact</OPTION>"
		Response.Write "                <OPTION value=""Tahoma"" "
		If RS("MarkFontName") = "Tahoma" Then Response.Write ("selected")
		Response.Write ">Tahoma</OPTION>"
		Response.Write "                <OPTION value=""Times New Roman"" "
		If RS("MarkFontName") = "Times New Roman" Then Response.Write ("selected")
		Response.Write ">Times"
		Response.Write "                New Roman</OPTION>"
		Response.Write "                <OPTION value=""Trebuchet MS"" "
		If RS("MarkFontName") = "Trebuchet MS" Then Response.Write ("selected")
		Response.Write ">Trebuchet"
		Response.Write "                MS</OPTION>"
		Response.Write "                <OPTION value=""Script MT Bold"" "
		If RS("MarkFontName") = "Script MT Bold" Then Response.Write ("selected")
		Response.Write ">Script"
		Response.Write "                MT Bold</OPTION>"
		Response.Write "                <OPTION value=""Stencil"" "
		If RS("MarkFontName") = "Stencil" Then Response.Write ("selected")
		Response.Write ">Stencil</OPTION>"
		Response.Write "                <OPTION value=""Verdana"" "
		If RS("MarkFontName") = "Verdana" Then Response.Write ("selected")
		Response.Write ">Verdana</OPTION>"
		Response.Write "                <OPTION value=""Lucida Console"" "
		If RS("MarkFontName") = "Lucida Console" Then Response.Write ("selected")
		Response.Write ">Lucida"
		Response.Write "                Console</OPTION>"
		Response.Write "            </SELECT> </td>"
		Response.Write "          </tr>"
		Response.Write "          <tr bgcolor=""#FFFFFF"">"
		Response.Write "            <td height=""26"" align=""right"" class=""table"">�����Ƿ����:</td>"
		Response.Write "            <td class=""table""> <SELECT name=""MarkFontBond"" id=""MarkFontBond"">"
		Response.Write "                <OPTION value=0 "
		If RS("MarkFontBond") = "0" Then Response.Write ("selected")
		Response.Write ">��</OPTION>"
		Response.Write "                <OPTION value=1 "
		If RS("MarkFontBond") = "1" Then Response.Write ("selected")
		Response.Write ">��</OPTION>"
		Response.Write "            </SELECT> </td>"
		Response.Write "          </tr>"
		Response.Write "          </table>"
		Response.Write "          </td>"
		Response.Write "          </tr>"
		Response.Write "          <tr>"
		Response.Write "           <td colspan=""2"">"
		Response.Write "           <table width=""100%"" border=""0"" cellpadding=""0"" cellspacing=""1"" bgcolor=""#efefef"" id=""picarea"">"
		Response.Write "          <tr bgcolor=""#FFFFFF"">"
		Response.Write "            <td width=""27%"" height=""26"" align=""right"" class=""table"">LOGOͼƬ:<br> </td>"
		Response.Write "            <td width=""70%"" class=""table""> <INPUT TYPE=""text"" NAME=""MarkPicture"" size=40 value=""" & RS("MarkPicture") & """>"
		Response.Write "           <font color=""#FF0000"">����:/images/logo.gif</font></td>"
		Response.Write "          </tr>"
		Response.Write "          <tr bgcolor=""#FFFFFF"">"
		Response.Write "            <td height=""26"" align=""right"" class=""table"">LOGOͼƬ͸����:</td>"
		Response.Write "            <td class=""table""> <INPUT TYPE=""text"" NAME=""MarkOpacity"" size=10 value="""
		If Left(RS("MarkOpacity"), 1) = "." Then Response.Write ("0" & RS("MarkOpacity")) Else Response.Write (RS("MarkOpacity"))
		Response.Write """>"
		Response.Write "            ��50%����д0.5 </td>"
		Response.Write "          </tr>"
		Response.Write "          <tr bgcolor=""#FFFFFF"">"
		Response.Write "            <td height=""26"" align=""right"" class=""table"">ͼƬȥ����ɫ:</td>"
		Response.Write "            <td class=""table""> <INPUT TYPE=""text"" NAME=""MarkTranspColor"" ID=""MarkTranspColor"" maxlength = 7 size = 7 value=""" & RS("MarkTranspColor") & """ >"
		Response.Write "              <input type=""button"" name=""button1"" value=""ѡ����ɫ..."" onClick=""OpenThenSetValue('inc/SelectColor.asp',230,190,window,document.form.MarkTranspColor);document.form.MarkTranspColor.style.color=document.form.MarkTranspColor.value;"">"
		Response.Write "            ����Ϊ����ˮӡͼƬ��ȥ����ɫ�� </td>"
		Response.Write "          </tr>"
		Response.Write "          <tr bgcolor=""#FFFFFF"">"
		Response.Write "            <td height=""26"" align=""right"" class=""table"">ͼƬ����λ��:<br> </td>"
		Response.Write "            <td class=""table""> ��X��"
		Response.Write "              <INPUT TYPE=""text"" NAME=""MarkWidth"" size=10 value=""" & RS("MarkWidth") & """>"
		Response.Write "              ����<br>"
		Response.Write "Y:"
		Response.Write "              <INPUT TYPE=""text"" NAME=""MarkHeight"" size=10 value=""" & RS("MarkHeight") & """>"
		Response.Write "            ����  </td>"
		Response.Write "          </tr>"
		Response.Write "          </table>"
		Response.Write "          </td>"
		Response.Write "          </tr>"
				  
		Response.Write "      </table></td>"
		Response.Write "    </tr>"
		Response.Write "</body>"
		
		Response.Write "<script language=""javascript"">"
		Response.Write "if (document.all.MarkFontColor.value!='')"
		Response.Write " document.all.MarkFontColor.style.color=document.all.MarkFontColor.value;"
		Response.Write "if (document.all.MarkTranspColor.value!='')"
		Response.Write " document.all.MarkTranspColor.style.color=document.all.MarkTranspColor.value;"
		Response.Write "function SetTypeArea(TypeID)"
		Response.Write "{"
		Response.Write " if (TypeID==1)"
		Response.Write "  {"
		Response.Write "   document.all.textarea.style.display='';"
		Response.Write "   document.all.picarea.style.display='none';"
		Response.Write "  }"
		Response.Write " else"
		Response.Write "  {"
		Response.Write "   document.all.textarea.style.display='none';"
		Response.Write "   document.all.picarea.style.display='';"
		Response.Write "  }"
		
		Response.Write "}"
		Response.Write "function ShowInfo(ComponentID)"
		Response.Write "{"
		Response.Write "    if(ComponentID == 0)"
		Response.Write "    {"
		Response.Write "        document.all.WaterMarkSetting.style.display = ""none"";"
		Response.Write "    }"
		Response.Write "    else"
		Response.Write "    {"
		Response.Write "        document.all.WaterMarkSetting.style.display = """";"
		Response.Write "    }"
		Response.Write "}"
		Response.Write "function ShowThumbInfo(ThumbComponentID)"
		Response.Write "{"
		Response.Write "    if(ThumbComponentID == 0)"
		Response.Write "    {"
		Response.Write "        document.all.ThumbSetting.style.display = ""none"";"
		Response.Write "    }"
		Response.Write "    else"
		Response.Write "    {"
		Response.Write "        document.all.ThumbSetting.style.display = """";"
		Response.Write "    }"
		Response.Write "}"
		Response.Write "function ShowThumbSetting(ThumbSettingid)"
		Response.Write "{"
		Response.Write "    if(ThumbSettingid == 0)"
		Response.Write "    {"
		Response.Write "        document.all.ThumbSetting1.style.display = ""none"";"
		 Response.Write "       document.all.ThumbSetting0.style.display = """";"
		 Response.Write "   }"
		 Response.Write "   else"
		Response.Write "    {"
		Response.Write "        document.all.ThumbSetting1.style.display = """";"
		Response.Write "        document.all.ThumbSetting0.style.display = ""none"";"
		Response.Write "    }"
		Response.Write "}"
		Response.Write "function CheckForm()"
		Response.Write "{"
		Response.Write "document.form.submit();"
		Response.Write "}"
		
		Response.Write "</script>"
		
	%>	
	</td>
  </tr>
  <tr>
    <td colspan="3" class="title2">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="3" class="title"><div align="center" style="font-weight: bold">Ŀ¼����</div></td>
	
    </tr>
  <tr>
    <td colspan="3" class="title2">&nbsp;������Ӧ����Զ�̱����ļ�Ŀ¼��ַ��<span class="table"></span></td>
    </tr>
  <tr>
    <td class="table">&nbsp;���Ųɼ�Ŀ¼</td>
	<%
	Dim rs1
	Set rs1 = ConnItem.execute("Select top 1 Dir,MaxFileSize,FileExtName,Timeout from SK_Cj where ID=1")
	%>
    <td colspan="2" class="table"><input name="ArticleDir" type="text" class="lostfocus" id="ArticleDir" onfocus='this.className="getfocus";this.gf="1"' onblur='this.className="lostfocus";this.gf="0"' onmouseover='this.className="getfocus"' onmouseout='if (this.gf=="0") this.className="lostfocus"' value="<% =rs1("Dir") %>" gf="0">      
      <font class="alert">&nbsp;��������"/"����</font></td>
  </tr>
  
  <tr>
    <td height="50" colspan="3" class="title3"><div align="center">
      <input type="submit" name="Submit" value="�ύ">
    </div></td>
    </tr>
</form>
</table>
<%
rs.close
set rs=nothing
end sub
	Public Function ExpiredStr(I)
		   Dim ComponentName(3)
			ComponentName(0) = "Persits.Jpeg"
			ComponentName(1) = "wsImage.Resize"
			ComponentName(2) = "SoftArtisans.ImageGen"
			ComponentName(3) = "CreatePreviewImage.cGvbox"
			If IsObjInstalled(ComponentName(I)) Then
				If IsExpired(ComponentName(I)) Then
					ExpiredStr = "�����ѹ���"
				Else
					ExpiredStr = ""
				End If
			  ExpiredStr = " ��֧��" & ExpiredStr
			Else
			  ExpiredStr = "����֧��"
			End If
	End Function
		Public Function IsObjInstalled(strClassString)
		On Error Resume Next
		IsObjInstalled = False
		Err = 0
		Dim xTestObj:Set xTestObj = Server.CreateObject(strClassString)
		If 0 = Err Then IsObjInstalled = True
		Set xTestObj = Nothing
		Err = 0
	End Function
	Public Function IsExpired(strClassString)
		On Error Resume Next
		IsExpired = True
		Err = 0
		Dim xTestObj:Set xTestObj = Server.CreateObject(strClassString)
	
		If 0 = Err Then
			Select Case strClassString
				Case "Persits.Jpeg"
					If xTestObjResponse.Expires > Now Then
						IsExpired = False
					End If
				Case "wsImage.Resize"
					If InStr(xTestObj.errorinfo, "�Ѿ�����") = 0 Then
						IsExpired = False
					End If
				Case "SoftArtisans.ImageGen"
					xTestObj.CreateImage 500, 500, RGB(255, 255, 255)
					If Err = 0 Then
						IsExpired = False
					End If
			End Select
		End If
		Set xTestObj = Nothing
		Err = 0
	End Function
		'ȡ��Request.Querystring �� Request.Form ��ֵ
	Public Function G(Str)
	 G = Replace(Replace(Request(Str), "'", ""), """", "")
	End Function
%>
