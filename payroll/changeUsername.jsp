<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" %>
<jsp:useBean id="db" class="dbbean.DatabaseBean">
</jsp:useBean>
<%
	try{
	Connection con = db.getConnection();
	Statement st = con.createStatement();
	ResultSet rs1;
	
	String newuname = (String)request.getParameter("newuname");
	String pwd = (String)request.getParameter("pwd");
	String username = (String)session.getAttribute("username");
	String type = (String)session.getAttribute("type");
	
	System.out.println(pwd+username);
	
	
	if(type.equals("user")){
		rs1=st.executeQuery("select password from employee where login='"+ username +"' and admin='"+type+"'");
		if(rs1.next()){
			if(rs1.getString("password").equals(pwd)){
				System.out.print("in");
				int i=st.executeUpdate("update employee set login='"+ newuname +"' where login='"+ username +"'");
				out.print("Successfully username is changed");
			}else
			out.print("Error :Invalid username");
		}else
			out.print("Error :Invalid username");
		}
	}
	catch(Exception e){
		out.print("Error :Invalid username");
	}
%>