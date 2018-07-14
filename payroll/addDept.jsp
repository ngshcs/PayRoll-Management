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
		String code = request.getParameter("code");
		String name = request.getParameter("name");
		String hod = request.getParameter("hod");

		if( code!=null && name!=null && hod!=null )
		{
			try
			{
				Connection con = dbConn.getConnection();
				Statement stmt = con.createStatement();
				String query = "insert into department(code,name,hod) values('" + code + "','" + name + "','" + hod + "')";
				stmt.executeUpdate(query);
				ResultSet rs = stmt.executeQuery("select id from department where code = '" + code + "'");
				rs.next();

				out.println("<tr>" +
						"<td align=\"center\"> " + rs.getString(1) + " </td>" +
						"<td align=\"center\"> " + code + " </td>" +
						"<td align=\"center\"> " + name + " </td>" +
						"<td align=\"center\"> " + hod + " </td>" +
						"<td align=\"center\" id=\"" + rs.getString(1) + "\"> " +
						"        <img class=\"edit\" src=\"./images/edit.png\" title=\"Edit\" width=\"16px\" height=\"16px\" />" +
						"</td>" +
						"<td align=\"center\">" +
						"        <img class=\"delete\" src=\"./images/delete.png\" title=\"Delete\" width=\"16px\" height=\"16px\" />" +
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