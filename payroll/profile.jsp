<%@ page language="java" %>
<%@ page import="java.sql.*,java.io.*,org.w3c.dom.*,java.util.*" %>
<%@ page isThreadSafe="true" %>

<jsp:useBean id="dbConn" class="dbbean.DatabaseBean">
</jsp:useBean>
<%!
	ResultSet rs ;
	String firstname,middlename, lastname ,dob ,gender, marital;
	String name;
	
%>

<%
	String username = (String)session.getAttribute("user");
	String type = (String)session.getAttribute("type");
	if(username==null)
		response.sendRedirect("index.jsp");
		
		
	try
	{
		Connection con = dbConn.getConnection();
		Statement stmt = con.createStatement();
		System.out.println(username+type);
		rs = stmt.executeQuery("select firstname,middlename,lastname,dob,gender,marital from employee where login='" + username + "' and admin='" + type + "'");
		rs.next();
		System.out.print("in profile");
		firstname = rs.getString(1);
		middlename= rs.getString(2);
		lastname =  rs.getString(3);
		dob = rs.getString(4);
		gender = rs.getString(5);
		marital = rs.getString(6);
		name=firstname+" "+middlename+" "+lastname;
		session.setAttribute("name",firstname+" "+middlename+" "+lastname);
		
%>

<!DOCTYPE HTML>
<html>
<head>
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

	<script>
	        if(top.frames.length == 0)
	              top.location.href = "./home.jsp?homepage.jsp";
	 </script>
</head>

	<body background="./images/background.png" onUnload="">
		<div style="float:left;position:fixed;width:100%;height:30px;top:0px;background:navy;
							z-index:10;color:white;font-size:18px;">
			<div style="float:right;position:relative;top:4px;">
				<a href="homepage.jsp">Home</a>&nbsp; &nbsp;
				<a href="changePwd.jsp">Change Password</a>&nbsp; &nbsp;
				<a href="logout.jsp">Logout</a>&nbsp; &nbsp; &nbsp; &nbsp;
			</div>
			<div style="float:left;position:relative;top:4px;">
				&nbsp; &nbsp; You are logged in as <b style="color:orange;"> <%= name %> </b>
			</div>
		</div>

		<div style="width:100%;"> <div style="position:absolute;top:30px;padding-top:10px;">
<%
	}
	catch(Exception e)
	{
%>
		<script language="javascript">
			var targetURL = "./logout.jsp";
			alert("Error: <%= e %>... Please login again...");
			setTimeout( "window.location.href = targetURL", 1000);
		</script>
<%
	}
	finally{
%>
<center>
		   <table class="mytable" align="center" style="margin:10px auto;width:80%;position:relative;top:100px;left:100px;">
            	<tr><th width="150px"> Firstname </th><td style="min-width:150px;"><%= firstname %></td></tr>
            	<tr><th> Middlename </th><td><%= middlename %></td></tr>
            	<tr><th> Lastname </th><td><%= lastname %></td></tr>
            	<tr><th> Date of Birth </th><td><%= dob %></td></tr>
            	<tr><th> Gender </th><td><%= gender %></td></tr>
              	<tr><th> Marital </th><td><%= marital %></td></tr>
            </table>
</center>
<%
	}
%>
		</div> </div>
	</body>
</html>