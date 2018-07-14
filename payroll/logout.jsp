<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<%@ page isThreadSafe="true" %>

<%
	String username = (String)session.getAttribute("user");

	if(username!=null)
		session.invalidate();
%>

<script language="javascript">
	top.location.href = "index.jsp";
</script>