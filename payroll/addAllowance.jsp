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
		String desc = request.getParameter("desc");

		if( name!=null && desc!=null )
		{
			try
			{
				Connection con = dbConn.getConnection();
				Statement stmt = con.createStatement();
				String query = "insert into allowance(name,description) values('" + name + "','" + desc + "')";
				stmt.executeUpdate(query);
				ResultSet rs = stmt.executeQuery("select id from allowance where name = '" + name + "'");
				rs.next();

				out.println("<tr>" +
						"<td align=\"center\"> " + rs.getString(1) + " </td>" +
						"<td align=\"center\"> " + name + " </td>" +
						"<td align=\"center\"> " + desc + " </td>" +
						"<td align=\"center\" id=\"" + rs.getString(1) + "\"> " +
						"        <img class=\"edit\" src=\"./images/edit.png\" title=\"Edit\" width=\"16px\" height=\"16px\" />" +
						"</td>" +
					"</tr>");
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