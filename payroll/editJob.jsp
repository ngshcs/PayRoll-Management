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
		String id = request.getParameter("id");

		if( id!=null && name!=null )
		{
			try
			{
				Connection con = dbConn.getConnection();
				Statement stmt = con.createStatement();

				String query = "select name from designation where id=" + id;
				ResultSet rs = stmt.executeQuery(query);
				rs.next();
				String old = rs.getString(1);

				query = "update designation set name='" + name + "' where id=" + id;
				stmt.executeUpdate(query);

				query = "update emp_job set designation='" + name + "' where designation='" + old + "'";
				stmt.executeUpdate(query);

				out.println("<tr>" + id + "</tr>");
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