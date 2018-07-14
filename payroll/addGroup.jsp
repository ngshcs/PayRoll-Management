<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<%@ page isThreadSafe="true" %>

<jsp:useBean id="dbConn" class="dbbean.DatabaseBean">
</jsp:useBean>

<%
	String username = (String)session.getAttribute("user");
	String type = (String)session.getAttribute("type");

	if(username==null)
		out.print("<tr>Unauthorised access - Login to access this resource</tr>");

	else if("admin".equals(type))
	{
		String name = request.getParameter("name");

		if( name!=null)
		{
			try
			{
				Connection con = dbConn.getConnection();
				Statement stmt = con.createStatement();
				stmt.executeUpdate("insert into groups(name) values('" + name + "')");
				ResultSet rs = stmt.executeQuery("select id from groups where name='" + name + "'");
				rs.next();
				out.println("<tr><option id=\"" + rs.getString(1) +"\"> " + name + " </option></tr>");
			}
			catch(Exception e)
			{
				out.println("<tr>Error: " + e.getMessage() + "</tr>");
			}
		}
		else
		{
			out.println("<tr>Error: null</tr>");
		}
	}
	else
	{
		out.println("<tr>Error: Unauthorised - Access Denied</tr>");
	}
%>