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
		<title> Home - Payroll System </title>

		<script type="text/javascript">
			var topic = "homepage.jsp";
			if( top.location.href.lastIndexOf("?") > 0 )
				topic = top.location.href.substring(top.location.href.lastIndexOf("?") + 1, top.location.href.length);

			document.write('<frameset cols="250px,*" border="0">');
			document.write('<frame src="toc.jsp" name="toc">');
			document.write('<frame src="' + topic + '" name="main">');
			document.write('</frameset>');
		</script>
	</head>
	<body style="overflow:hidden;"></body>
</html>