<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.io.*,org.w3c.dom.*,java.util.*" %>
<jsp:useBean id="dbConn" class="dbbean.DatabaseBean">
</jsp:useBean>

<jsp:useBean id="myXml" class="myxml.MyXML">
</jsp:useBean>

<%!
	String salutation,firstname,middlename,lastname,dob,gender,marital,name;
	ResultSet rs = null,rsa = null,rsd = null,rsl = null, xmlrs=null;
	int colcount=0;
%>

<%
	String username = (String)session.getAttribute("user");
	String type = (String)session.getAttribute("type");
	session.setAttribute("username",username);
	session.setAttribute("type",type);

	if(username==null)
		response.sendRedirect("index.jsp");
	
	try
	{
		Connection con = dbConn.getConnection();
		Statement stmt = con.createStatement();
		Statement stmta = con.createStatement();
		Statement stmtd = con.createStatement();
		Statement stmtl = con.createStatement();
		
		Statement xmlst = con.createStatement();
		System.out.println(username+type);
		rs = stmt.executeQuery("select firstname,middlename,lastname,dob,gender,marital,salutation from employee where login='" + username + "' and admin='" + type + "'");
		rs.next();
		System.out.print("in profile");
		firstname = rs.getString(1);
		middlename= rs.getString(2);
		lastname =  rs.getString(3);
		dob = rs.getString(4);
		gender = rs.getString(5);
		marital = rs.getString(6);
		salutation = rs.getString(7);
		name=firstname+" "+middlename+" "+lastname;
		session.setAttribute("name",name);
		
		//allowances
		rsa = stmta.executeQuery("select * from allowance");
		rsd = stmtd.executeQuery("select * from deduction");
		rsl = stmtl.executeQuery("select * from loan");
		
		xmlrs = xmlst.executeQuery("select payslip from payslips where id='April 2013' and name='Teaching Staff'");
		
		xmlrs.next();
		Blob xml = xmlrs.getBlob(1);
		
		File dir1 = new File(config.getServletContext().getRealPath("/") + "/data/");
		File file1 = File.createTempFile("pay", "data.xml", dir1);
		FileOutputStream fos1 = new FileOutputStream(file1);

		String filename=file1.getName();

		String str1 = "<payslips></payslips>";
		fos1.write(str1.getBytes());
	
		fos1.close();

		File dir = new File(config.getServletContext().getRealPath("/") + "/WEB-INF/xml/");
		File file = File.createTempFile("" + System.currentTimeMillis(), ".xml", dir);
		FileOutputStream fos = new FileOutputStream(file);
		fos.write( xml.getBytes(1,(int)xml.length()) );
		fos.close();

		myXml.setDocument(file);
		Element root = myXml.getRoot();

		NodeList employees = root.getElementsByTagName("employee");
		int c = employees.getLength();

%>

<%!
	public boolean isTextNode(Node node)
	{
		return node.getNodeName().equals("#text");
	}
%>

<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>User - PAYROLL</title>
<link rel="stylesheet" href="./js/jquery-ui.css" type="text/css">
<style type="text/css">
			body {margin:0;padding:0; font-family: Tahoma, Helvetica, sans-serif, "Times New Roman"; }
			a:link, a:visited { text-decoration:none; color:white; }
			a:hover { text-decoration:underline; }
			a.style3:link, a.style3:visited { text-decoration:none; color:blue; }
			a.style3:hover { text-decoration:underline; }
			a.style4:link, a.style4:visited { text-decoration:none; color:blue; }
			a.style4:hover { text-decoration:underline; }
			tr td img { cursor: pointer; }
			select { border: 1px groove #5f5f5f; width:160px; }
			.focus { border: 2px solid #AA88FF; background-color: #FFEEAA; }
			table.mytable 
			{
				font-family:arial;
				background-color: #CDCDCD;
				margin:10px 0pt 15px;
				font-size: 9pt;
				text-align: left;
				width:98%;
			}

			table.mytable tr th
			{
				background-color: #e6EEEE;
				border: 1px solid #FFF;
				font-size: 10pt;
				padding: 4px;
			}

			table.mytable tr td
			{
				color: #3D3D3D;
				padding: 4px;
				background-color: #FFF;
				vertical-align: top;
			}
			
</style>
<script type="text/javascript" src="./js/jquery-1.4.2.min.js"> </script>
<script type="text/javascript" src="./js/jquery-ui.js"> </script>
<script language="javascript">
			$(document).ready(function()
			{
				$("#tabs").tabs();
				$('#accordion').accordion({fillSpace:true});
				//$('#accordio').accordion();
				$('#accordion div').css({height:'200px'});
						
				$('button').button().css({width:'100%'});
				$('#changeuname').button();
				$('#changepwd').button();
				$('#dialog-link').button();
				
				$("#dialog").dialog({autoOpen: false},{title: 'Upload your picture'},{hide: 'slide'},{width:600},
						{closeOnEscape: true},{ resizable: false},{modal: true},{show: 'slide'});
				$("#change-uname").dialog({autoOpen: false},{title: 'Enter new username'},{hide: 'slide'},{width:300},
						{closeOnEscape: true},{ resizable: false},{modal: true},{show: 'slide'});
				$("#dbx-cpwd").dialog({autoOpen: false},{title: 'Change your password'},{hide: 'slide'},{width:300},
						{closeOnEscape: true},{ resizable: false},{modal: true},{show: 'slide'});
				
				// Link to open the dialog
				$( "#dialog-link" ).click(function( event ) {
					$('#upload-picture').val('');
					$("#pic-pwd").val('');
					$( "#dialog" ).dialog( "open" );
					$('#upload-msg').hide(500);
					event.preventDefault();
				});
				
				$( "#changeuname" ).click(function( event ) {
					$( "#change-uname" ).dialog( "open" );
					$('#cname-msg').hide();
					event.preventDefault();
				});
				
				$( "#changepwd" ).click(function( event ) {
					$( "#dbx-cpwd" ).dialog( "open" );
					$('#cpwd-msg').hide();
					event.preventDefault();
				});
					
			//Link to close the dialog
				$('#cancel').click(function(){
					$(this).parent().dialog("close");
				});
//function to handle ajax
//to change username
			$('#cname-msg').css({border:'1px solid red',borderRadius:'5px'});
			$('#changeusername').click(function(){
				$('#cname-msg').hide(500);
				if($('#newuname').val()=='' || $('#cuname-pwd').val()=='')
					$('#cname-msg').text('Field is empty').show(500);
				else {
					this.timer = setTimeout(function(){
						$.ajax({
							url:'./changeUsername.jsp',
							data:'newuname='+ $('#newuname').val() + '&pwd=' + $('#cuname-pwd').val() + '&username=<%=username%>',
							type: 'post',
							success:function(msg){
								if(msg.indexOf('Error') == -1){
									$('#change-uname').dialog('close');
									$('span').text($('#newuname').val());
									alert('Your username is updated');
								} else {
									$('#cname-msg').text('Invalid data').show(1000);
								}
							}
						});
					},200);
				}
			});
//to change password
			$('#cpwd-msg').css({border:'1px solid red',});
			$('#butcpwd').click(function(){
				$('#cpwd-msg').hide(500);
				if($('#pwd').val()=='' || $('#npwd').val()=='' || $('#cpwd').val()=='')
					$('#cpwd-msg').text('Fields are empty').show(500);
				else if($('#npwd').val()!=$('#cpwd').val())
					$('#cpwd-msg').text('does not match').show(500);
				else{
					this.timer = setTimeout(function(){
						$.ajax({
							url:'./changePwdofUser.jsp',
							data:'pwd='+ $('#pwd').val()+'&npwd='+ $('#npwd').val()+'&cpwd='+ $('#cpwd').val()+'&username=<%=username%>',
							type: 'post',
							success:function(msg){
								if(msg.indexOf('Error') == -1){
									$('#dbx-cpwd').dialog('close');
									alert('Your password is updated');
								} else {
									$('#cpwd-msg').text('Invalid password').show(1000);
								}
							}
						});
					},200);
				}
			});
			//to change profile pic
			$('#upload-but').click(function(){
				$('#upload-msg').hide(500);
				if($('#upload-picture').val()=='' || $("#pic-pwd").val() == '')
					$('#upload-msg').text('Field is empty').show(500);
				else if($('#upload-picture').val().indexOf('.jpg')== -1 && $('#upload-picture').val().indexOf('.JPG')== -1)
					$('#upload-msg').text('Choose a "jpg" format picture').show(500);
				else{
				alert($('#upload-picture').val());
				this.timer = setTimeout(function(){
					$.ajax({
						type:'POST',
						url:'changeProfpic.jsp',
						data:'path='+$('#upload-picture').val()+'&pwd='+$('#pic-pwd').val(),
						statusCode:{
								404: function(){
										alert('page not found');
									}
							},
						success:function(msg){
								if(msg.indexOf('password') != -1){
									$('#upload-msg').text('Invalid password').show(500);
								} else if(msg.indexOf('Error')== -1){
									window.location.reload();
									
									$( "#dialog" ).dialog( "close" );
									alert('successfully your picture is uploaded');
									//window.location="./display.jsp";
									//$('#profile-pic').attr({'src':$('#upload-picture').val()});
								}
								else
									alert('An error occured');
							}
					});
				},200);
				}
			});
			//generating playslip
			$("#genPlayslip").click(function(){
					//alert('generating playslip');
					this.timer = setTimeout(function(){
						$.ajax({
							type:'POST',
							url:'/payslip/genPlayslip.jsp',
							data:"",
							success:function(msg){
								if(msg.indexOf('Error')== -1){
									window.location="/payslip/payslippdf.pdf";
								}else
									alert('Try again, An error occured');
							}
						});
					},200);
			}
			);
	});
</script>
</head>

<body background="./images/background.png" onUnload="">
		<div style="float:left;position:fixed;width:100%;height:30px;top:0px;background:navy;z-index:10;color:white;font-size:18px;border-bottom:red solid 2px;">
			<div style="float:right;position:relative;top:4px;">
				<a href="logout.jsp"> Logout </a> &nbsp; &nbsp; &nbsp; &nbsp;
			</div>
			<div style="float:left;position:relative;top:4px;text-shadow:1px 1px 1px gray;">
				&nbsp; &nbsp; Hello , <b> <%= name %> </b>
			</div>
		</div>
<%	
	}catch(Exception e){
%>
		<script language="javascript">
			var targetURL = "./logout.jsp";
			alert("Error: <%= e %>... Please login again...");
			setTimeout( "window.location.href = targetURL", 1000);
		</script>
<%
	}
%>     
	<table>
    	<tr><td> 
		<div id="pic" style="float:left;position:relative;left:30px;top:100px;text-align:center;">
          	<img id="profile-pic" src="./display.jsp" alt="click me to change" style="width:240px;height:320px;box-shadow:0px 0px 10px navy;border-radius:10px;" />
            <br/><span><%= username %></span><br/>
            <a href="#" style="color:#0A0" id="dialog-link"> Change picture </a>
        </div></td><td>
        <div id="main" style="margin:10px;position:absolute;top:50px;width:70%;right:50px;">
        	  <div class="ui-tabs ui-widget ui-widget-content ui-corner-all" id="tabs" style="font-size:12px;padding:5px;margin:0px;">
				<ul class="ui-tabs-nav ui-helper-reset ui-helper-clearfix ui-widget-header ui-corner-all">
					<li class="ui-state-default ui-corner-top">
						<a href="#fragment-1">
							<span> Profile </span>
						</a>
					</li>
                    <li class="ui-state-default ui-corner-top">
						<a href="#fragment-2">
							<span> Payment-info </span>
						</a>
					</li>
                  </ul>
                 
                <div class="ui-tabs-panel ui-widget-content ui-corner-bottom" id="fragment-1">
                	<table class="mytable" align="center" style="margin:15px auto;">
                    	<tr><th width="50%"> Firstname </th><td style="min-width:150px;"><%= firstname %></td></tr>
                        <tr><th> Middlename </th><td><%= middlename %></td></tr>
		            	<tr><th> Lastname </th><td><%= lastname %></td></tr>
        		    	<tr><th> Date of Birth </th><td><%= dob %></td></tr>
            			<tr><th> Gender </th><td><%= gender %></td></tr>
		              	<tr><th> Marital </th><td><%= marital %></td></tr>
		              	<tr>
                        	<td colspan="2" align="center">
                            <a href="#" id="changeuname" style="color:#0A0"> Change Username </a>
                            <a href="#" id="changepwd" style="color:#0A0"> Change Password </a>
                            </td>
                        </tr>
        		    </table>
                    
                </div>
                <div class="ui-tabs-panel ui-widget-content ui-corner-bottom  ui-tabs-hide" id="fragment-2">
                
                	<div id="accordion" style="height:350px">
                    
                    	<h3><a href="#">General</a></h3>
                        <div style="height:100px">
                            <table class="mytable">
                                <tr><th width="50%">Basic</th><td>value</td></tr>
                                <tr><th>Gross</th><td>value</td></tr>
                                <tr><th>Net</th><td><em>value</em></td></tr>
                            </table>
                        </div>
                        
						<h3><a href="#">Allowances</a></h3>
						<div style="height:100px">
                        	<table class="mytable">
<%
							while(rsa.next()){
%>                          
								<tr><th width="50%"><%= rsa.getString(2) %></th><td>value</td></tr>
<%} %>  	
                            </table>
                        </div>
                        
						<h3><a href="#">Deductions</a></h3>
						<div style="height:100px">
                        <table class="mytable">
<%
							while(rsd.next()){
%>                          
								<tr><th width="50%"><%= rsd.getString(2) %></th><td>value</td></tr>
<%} %>  	
                            </table>
                        </div>
                        
						<h3><a href="#">Loans</a></h3>
						<div style="height:100px">
                        <table class="mytable">
<%
							while(rsl.next()){
%>                          
								<tr><th width="50%"><%= rsl.getString(2) %></th><td>value</td></tr>
<%} %>  	
                            </table></div>
					</div>
                </div>
              </div>
              <!--<div>
              	<a id="gePlayslip" href="genPayslip.jsp" target="_new" style="color:#0A0;padding-left:20px;">view Payslip</a>
              </div>-->
        </div>
        </td></tr></table>
        <div id="dialog" title="Upload your picture">
			<input id="upload-picture" type="file" /><br/>
            <label for="pic-pwd">Password :</label><input type="password" id="pic-pwd" placeholder="password" />
            <hr style="margin-top:5px"/>
            <p id="upload-msg" style="display:none;margin:3px 0px;text-align:center;border:1px red solid;border-radius:5px;"></p>
            <hr style="margin-botton:5px"/>
            <button id="upload-but" width="45%">change</button>
		</div>
        <div id="change-uname">
        	New username :<input id="newuname" type="text" placeholder="Enter new username"/><br/>
            Password :<input id="cuname-pwd" type="password" placeholder="your password"/>
            <hr style="margin-top:5px"/>
                        <p id="cname-msg" style="display:none;margin:3px 0px;"></p>
            <hr style="margin-bottom:5px"/>
            
            <button id="changeusername" width="45%">change</button>
        </div>
        <div id="dbx-cpwd" class="ui-widget-content" style="text-align:center">
        	Current Password : <input type="password" id="pwd" placeholder="Enter current password"/><br/>
        	New Password : <input type="password" id="npwd" placeholder="Enter  new password"/><br/>
        	Confirm Password : <input type="password" id="cpwd" placeholder="Confirm new password"/><br/>
            <hr/>
            <p id="cpwd-msg"></p>
            <hr/>
            <button id="butcpwd" >Change</button>
        </div>

<%  
%>

</body>
</html>
