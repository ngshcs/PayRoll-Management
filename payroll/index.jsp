<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<%@ page isThreadSafe="true" %>

<%
	String username = (String)session.getAttribute("user");
	if( username!=null )
		response.sendRedirect("home.jsp");
 %>

<html>
        <head>
	<link href="css/style.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="js/jquery-1.4.2.min.js"> </script>

	<style type="text/css">
		.style1
		{
			width:200px;
			height:25px;
			font-size:16px;
			border: 1px solid #ababab;
		}
		.style2
		{
			width:100px;
			height:22px;
			font-size:16px;
			border: 1px solid #ababab;
		}

		.focus { border: 2px solid #AA88FF; background-color: #FFEEAA; }
	</style>

	<script type="text/javascript">
	        $(document).ready(function()
	        {
		$('input[type="text"]').focus(function() {
			$(this).addClass("focus");
		});

		$('input[type="text"]').blur(function() {
			$(this).removeClass("focus");
		});

		$('input[type="password"]').focus(function() {
			$(this).addClass("focus");
		});

		$('input[type="password"]').blur(function() {
			$(this).removeClass("focus");
		});


		$("#login_form").submit(function()
		{
		        var uname = $('#user').val();
		        var pass = $('#pwd').val();

		        if( uname.length==0 )
		        {
			alert("Enter a valid username");
			$('#user').focus();
			return false;
		        }

		        if( pass.length==0 )
		        {
			alert("Enter a valid password");
			$('#pwd').focus();
			return false;
		        }

		        $("#msgbox").removeClass().addClass('myinfo').text('Validating Your Login....').fadeIn(1000);

		        this.timer = setTimeout(function ()
		        {
			$.ajax({
				url: 'validate.jsp',
				data: 'user=' + $('#user').val() + '&pwd=' + $('#pwd').val() + '&type=' + $('#type').val(),
				type: 'post',
				success: function(msg)
				{
				     var start = msg.indexOf('<tr>');
				     var end = msg.indexOf('</tr>');
				     msg = msg.substring(start+4,end);
				     if( msg.indexOf('Error') == -1 )
				     {
				           $("#msgbox").html('Login Verified, Logging in.....').addClass('myinfo').fadeTo(900,1,function()
				           {
							   	var type = $('#type').val();
								if(type=="admin")
									window.location.href='home.jsp';
								if(type=="user")
									window.location.href='user.jsp';
				           });
				      }
				      else
				      {
				           $("#msgbox").fadeTo(200,0.1,function()
				           {
					$(this).html('Sorry, Wrong Combination Of Username And Password').removeClass().addClass('myerror').fadeTo(900,1);
				           });
				      }
				}
			         });
		        }, 200);

		        return false;
		});
	        });
	 </script>  
        </head>

        <body background="./images/background.png" onUnload="">
	<div id="main">
		<div id="header" style="background:#4B8EFB;"> <br/>
			<div style="float:left;position:relative;width:1000px;">
				<center> <font style="font-size:26px;color:#3B5998;">
					Payroll Management System 
				</font> </center>
			</div>
			<br/>   <br/>   <br/>
		</div>

		<div id="body">
			<div id="content">
				<br /> <br /> <br />
				<center> <font style="font-size:22px;color:#DA4A38;">  Sign in to work with the Pay Roll System  </font> </center>
				<br /> <br />
				<form id="login_form" method="post" action="">   <table align="center">
					<tr>
						<td align="right">  <font size="4" color="#82C300"> Type : &nbsp; </font> </td>
						<td> <select class="style2" id="type" name="type">
							<option> admin </option>
							<option> user </option>
						</select> </td>
					</tr>
					<tr>  </tr>     <tr>  </tr>     <tr>  </tr>
					<tr>
						<td align="right"> <font size="4" color="#82C300"> User Name : &nbsp; </font> </td>
						<td>  <input class="style1" type="text" id="user" name="user" /> </td>
					</tr>
					<tr>  </tr>     <tr>  </tr>     <tr>  </tr>
					<tr>
						<td align="right"> <font size="4" color="#82C300"> Password : &nbsp; </font> </td>
						<td>  <input class="style1" type="password" id="pwd" name="pwd" />  </td>
					</tr>
					<tr>  </tr>     <tr>  </tr>     <tr>  </tr>
					<tr>  </tr>     <tr>  </tr>     <tr>  </tr>
					<tr>
						<td colspan="2" id="msgbox"></td>
					</tr>
					<tr>  </tr>     <tr>  </tr>     <tr>  </tr>
					<tr>
						<td colspan="2" align="right">
							<input type="image" src="./images/login.gif" />
						</td>
					</tr>
				</table> </form>
				<br /> <br />
			</div>
		</div>

		<div id="footer" style="background:#F9EDBE;">
			<div style="float:left;position:relative;top:5px;left:300px;">
				<font style="font-size:18px;"> &copy JNTUH College of Engineering, Nachupally - 505501 </font>
			</div>
		</div>
	</div>
         </body>
</html>