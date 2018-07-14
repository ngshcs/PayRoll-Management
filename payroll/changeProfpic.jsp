<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" %>
<%@ page import="java.io.*" %>
<jsp:useBean id="db" class="dbbean.DatabaseBean">
</jsp:useBean>
<%
	String pwd = (String)request.getParameter("pwd");
	String path = (String)request.getParameter("path");
	String username = (String)session.getAttribute("username");
	String type = (String)session.getAttribute("type");
	
	try{
	Connection con = db.getConnection();
	Statement st = con.createStatement();
	PreparedStatement pst = con.prepareStatement("update employee set pic=? where login='"+ username +"'");
	ResultSet rs1,rs = null;
	
	System.out.println(pwd+"  "+path);
	
	if(type.equals("user")){
		rs1=st.executeQuery("select password from employee where login='"+ username +"' and admin='"+type+"'");
		if(rs1.next()){
			if(rs1.getString("password").equals(pwd)){
				System.out.println("in");
				File pic = new File("E:/"+path);
				FileInputStream fis = new FileInputStream(pic);
				pst.setBinaryStream(1,fis,(int)pic.length());
		
				int i=pst.executeUpdate();
				if(i>0){
					out.print("Successfully pic is changed");
				} else
					out.print("Error :");
			}else
				out.print("Error :Invalid password");
			pst.close();
		}
	}
	}
	catch(Exception e){
		out.print("Error :occured");
		e.printStackTrace();
	}
%>