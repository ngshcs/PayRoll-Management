<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<%@ page isThreadSafe="true" %>

<jsp:useBean id="dbConn" class="dbbean.DatabaseBean">
</jsp:useBean>

<%
	String username = (String)session.getAttribute("user");
	if( username!=null )
		out.print("<tr>" + username + "</tr>");
	else
	{
		username = request.getParameter("user");
		String password = request.getParameter("pwd");
		String type = request.getParameter("type");
		try
		{
			Connection con = dbConn.getConnection();
			Statement stmt=con.createStatement();
			ResultSet rs = stmt.executeQuery("select password,admin from employee where login=\'" + username + "\'");
			if(rs.next())
			{
				if( password.equals(rs.getString(1)) && type.equals(rs.getString(2)) )
				{
					session.setAttribute("user",username);
					session.setAttribute("pwd",password);
					session.setAttribute("type",type);
					stmt.close();
					con.close();
					out.print("<tr>" + username + "</tr>");
				}
				else
				{
					stmt.close();
					con.close();
					out.print("<tr>Error: Unauthorised</tr>");
				}
			}
			else
			{
				stmt.close();
				con.close();
				out.print("<tr>Error: Unauthorised</tr>");
			}
		}
		catch(Exception e)
		{
			out.print("<tr>Error: " + e.getMessage() + "</tr>");
		}
	}
%>