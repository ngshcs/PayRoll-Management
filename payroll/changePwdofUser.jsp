<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" %>
<jsp:useBean id="db" class="dbbean.DatabaseBean">
</jsp:useBean>
<%
	try{
	Connection con = db.getConnection();
	Statement st = con.createStatement();
	ResultSet rs1;
	
	String pwd = (String)request.getParameter("pwd");
	String npwd = (String)request.getParameter("npwd");
	String cpwd = (String)request.getParameter("cpwd");
	String username = (String)session.getAttribute("username");
	String type = (String)session.getAttribute("type");
	
	System.out.println(pwd+cpwd);
	
	
	if(type.equals("user")&& npwd.equals(cpwd)){
		rs1=st.executeQuery("select password from employee where login='"+ username +"' and admin='"+type+"'");
		if(rs1.next()){
			if(rs1.getString("password").equals(pwd)){
				System.out.println("in");
		
				int i=st.executeUpdate("update employee set password='"+ cpwd +"' where login='"+ username +"'");
					out.print("Successfully password is changed");
			}else
				out.print("Error :Invalid password");
		}
	}
	}
	catch(Exception e){
		out.print("Error :Invalid password");
	}
%>