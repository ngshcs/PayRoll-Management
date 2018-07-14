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
	else
	{
		String oldpwd = request.getParameter("oldpwd");
		String newpwd = request.getParameter("newpwd");

		if( oldpwd!=null && newpwd!=null )
		{
			if(oldpwd.equals((String)session.getAttribute("pwd")))
			{
			        try
			        {
				Connection con = dbConn.getConnection();
				Statement stmt = con.createStatement();
				stmt.executeUpdate("update employee set password='" + newpwd + "' where login='" + username + "' and admin='" + type + "'");
				session.setAttribute("pwd",newpwd);
				out.println("<tr>Updated Successfully</tr>");
			        }
			        catch(Exception e)
			        {
				out.println("<tr>Error: " + e + "</tr>");
			        }
			}
			else
			{
				out.println("<tr>Error: Wrong password. Enter correct password</tr>");
			}
		}
		else
		{
			out.println("<tr>Error: null</tr>");
		}
	}
%>