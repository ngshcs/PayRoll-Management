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
			a.style1:link, a:visited { text-decoration:none; color:blue; }
			a.style1:hover { text-decoration:underline; }
			select { border: 1px groove #5f5f5f; }
			.focus { border: 2px solid #AA88FF; background-color: #FFEEAA; }
		</style>

		<script type="text/javascript" src="./js/jquery-1.4.2.min.js"> </script>
		<script language="javascript">
			$(document).ready(function()
			{
				$('input[type="text"]').focus(function() {
					$(this).addClass("focus");
				});

				$('input[type="text"]').blur(function() {
					$(this).removeClass("focus");
				});

				$("#payslip").click(function()
				{
					var month = $("select").val();
					var year = $("#year").val();
					var ck_digit=/^\d{4}$/;

					if( !ck_digit.test(year))
					{
						alert("Enter a valid year");
						return false;
					}

					var id = month + " " + year;

					this.timer = setTimeout(function()
					{
					         $.ajax({
						url: 'listPayslip.jsp',
						data: 'id=' + id,
						type: 'post',
						success: function(msg)
						{
							msg = msg.substring(msg.indexOf('<table>'),msg.indexOf('</table>')+8);
							if( msg.indexOf('Unauthorised access') != -1 )
							{
								top.location.href = "index.jsp";
							}
							else if( msg.indexOf('Error') == -1 )
							{
								$("#info").html(msg);
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

	                  <script type="text/javascript">
	                            if(top.frames.length == 0)
	                                       top.location.href = "./home.jsp?payslip.jsp";
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
<%
		if( "admin".equals(type) )
		{
%>
			<table border="0"> <tr>
				<td align="right"> <b style="color:navy;"> Select : </b> </td>
				<td> <select name="month">
					<option> Jan </option>
					<option> Feb </option>
					<option> Mar </option>
					<option> April </option>
					<option> May </option>
					<option> June </option>
					<option> July </option>
					<option> Aug </option>
					<option> Sept </option>
					<option> Oct </option>
					<option> Nov </option>
					<option> Dec</option>
				</select> </td>
				<td>  &nbsp; <input type="text" id="year" name="year" size="6" />
				<span style="color:#888;font-size:14px;"> <i> Eg: 2012 </i> </span> </td>
				<td> &nbsp; &nbsp; <input id="payslip" type="button" value="Payslip" /> </td> <tr> <td colspan="4"> <hr /> </td>
			</tr> </table> <br />
			<div id="info"> </div>
<%
		}
		else
		{
%>
			<script language="javascript">
				var targetURL = "./homepage.jsp";
				alert("Unauthorised - Access Denied... Redirecting to homepage...");
				setTimeout( "window.location.href = targetURL", 1000);
			</script>
<%
		}
%>
		</div> </div>
	</body>
</html>