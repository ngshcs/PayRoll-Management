<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<jsp:useBean id="db" class="dbbean.DatabaseBean" />

<%       Blob image = null;
		Connection con = null;
		byte[] imgData = null ;
		Statement stmt = null;
		ResultSet rs = null;
		String username = (String)session.getAttribute("username");
	String type = (String)session.getAttribute("type");
	
		try {
			
			con = db.getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery("select pic from employee where  login='"+username+"'" );
			if (rs.next()) {
				image = rs.getBlob(1);
				imgData = image.getBytes(1,(int)image.length());
			} else {
				out.println("/images/logo.gif");
				return;
			}

			// display the image
         response.setContentType("image/gif");
         OutputStream o = response.getOutputStream();
         o.write(imgData);
         o.flush();
         o.close();
		} catch (Exception e) {
			out.println("/images/logo.gif");
			return;
		} finally {
			try {
				rs.close();
				stmt.close();
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	%>
  