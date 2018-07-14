<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<%@ page isThreadSafe="true" %>

<jsp:useBean id="dbConn" class="dbbean.DatabaseBean">
</jsp:useBean>

<%
	String username = (String)session.getAttribute("user");
	String type = (String)session.getAttribute("type");

	if(username==null)
		response.sendRedirect("index.jsp");

	if("admin".equals(type))
		response.sendRedirect("employee.jsp");

	try
	{
		Connection con = dbConn.getConnection();
		Statement stmt = con.createStatement();
		ResultSet rs = stmt.executeQuery("select salutation,firstname,middlename,lastname from employee where login='" + username + "' and admin='" + type + "'");
		rs.next();
		String name = rs.getString(1) + " " + rs.getString(2) + " " + rs.getString(3) + " " + rs.getString(4);
		session.setAttribute("name",name);
%>

<html>
	<head>
		<style type="text/css">
			body {margin:0;padding:0; font-family: Tahoma, Helvetica, sans-serif, "Times New Roman"; }
			a:link, a:visited { text-decoration:none; color:white; }
			a:hover { text-decoration:underline; }
		</style>
	                  <script type="text/javascript">
	                            if(top.frames.length == 0)
	                                       top.location.href = "./home.jsp?homepage.jsp";
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
				&nbsp; &nbsp; You are logged in as <b style="color:orange;"> <%= name %> </b>
			</div>
		</div>

		<div style="width:100%;"> <div style="float:left;position:absolute;top:30px;padding-top:10px;">
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
%>
		</div> </div>
	</body>
</html>