<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<%@ page isThreadSafe="true" %>

<%
	String username = (String)session.getAttribute("user");
	String type = (String)session.getAttribute("type");

	if(username==null)
		response.sendRedirect("index.jsp");
%>

<html>
	<head>
		<style type="text/css">
			body {margin:0;padding:0; font-family: Tahoma, Helvetica, sans-serif, "Times New Roman"; }
			a:link, a:visited { text-decoration:none; color:white; }
			a:hover { text-decoration:underline; }
			.focus { border: 2px solid #AA88FF; background-color: #FFEEAA; }
		</style>
	                  <script type="text/javascript">
	                            if(top.frames.length == 0)
	                                       top.location.href = "./home.jsp?changePwd.jsp";
	                  </script>

		<script type="text/javascript" src="js/jquery-1.4.2.min.js"> </script>

		<script type="text/javascript">
		        $(document).ready(function()
		        {
			$('input[type="password"]').focus(function()
			{
				$(this).addClass("focus");
			});

			$('input[type="password"]').blur(function()
			{
				$(this).removeClass("focus");
			});

			$("#change_pwd_form").submit(function()
			{
			        var oldpwd = $('#pwd1').val();
			        var newpwd = $('#pwd2').val();

			        if( newpwd.length==0 || oldpwd.length==0 )
			        {
				alert("Enter a valid password");
				return false;
			        }

			        this.timer = setTimeout(function ()
			        {
				$.ajax({
					url: 'pwdChange.jsp',
					data: 'oldpwd=' + oldpwd + '&newpwd=' + newpwd,
					type: 'post',
					success: function(msg)
					{
					       var start = msg.indexOf('<tr>');
					       var end = msg.indexOf('</tr>');
					       msg = msg.substring(start+4,end);

					       if( msg.indexOf('Error') == -1 )
					       {
						alert("Password changed successfully...");
						window.location.href='homepage.jsp';
					        }
					        else
						alert(msg);
					}
				         });
			        }, 200);

			        return false;
			});
		       });
		</script>
	</head>

	<body background="./images/background.png" onunload="">
		<div style="float:left;position:fixed;width:100%;height:30px;top:0px;background:navy;
							z-index:10;color:white;font-size:18px;">
			<div style="float:right;position:relative;top:4px;">
				<a href="homepage.jsp">Home</a>&nbsp; &nbsp;
				<a href="changePwd.jsp">Change Password</a>&nbsp; &nbsp;
				<a href="logout.jsp">Logout</a>&nbsp; &nbsp; &nbsp; &nbsp;
			</div>
			<div style="float:left;position:relative;top:4px;">
				&nbsp; &nbsp; You are logged in as <b style="color:orange;"> admin </b>
			</div>
		</div>

		<div style="width:100%;"> <div style="width:96%;left:2%;float:left;position:absolute;top:30px;padding-top:10px;font-size:16px;">
			<br /> <br />
			<form id="change_pwd_form" method="post" action="">  <table border="0">
				<tr>
					<th align="right"> Current Password : </th>
					<td> <input id="pwd1" type="password" name="oldpwd" /> </td>
				</tr>
				<tr> </tr>  <tr> </tr>  <tr> </tr>
				<tr>
					<th align="right"> New Password : </th>
					<td> <input id="pwd2" type="password" name="newpwd" /> </td>
				</tr>
				<tr> </tr>  <tr> </tr>  <tr> </tr>
				<tr> </tr>  <tr> </tr>  <tr> </tr>
				<tr> </tr>  <tr> </tr>  <tr> </tr>
				<tr>
					<td colspan="2" align="right">
						<input type="submit" value="  Change Password  " />
					</td>
				</tr>
			</table>  </form>
		</div> </div>
	</body>
</html>