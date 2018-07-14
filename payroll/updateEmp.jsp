<%@ page language="java" %>
<%@ page import="java.sql.*,java.io.*,org.w3c.dom.*" %>
<%@ page isThreadSafe="true" %>

<jsp:useBean id="dbConn" class="dbbean.DatabaseBean">
</jsp:useBean>

<jsp:useBean id="myXml" class="myxml.MyXML">
</jsp:useBean>

<%!
	public String change(String str)
	{
		if( str==null )
			return "\' \'";
		else
			return "\'" +  str + "\'";
	}

	public boolean isTextNode(Node node)
	{
		return node.getNodeName().equals("#text");
	}
%>

<%
	String username = (String)session.getAttribute("user");
	String type = (String)session.getAttribute("type");

	if(username==null)
		response.sendRedirect("index.jsp");

	if("admin".equals(type))
	{
		Connection con = null;
		File file = null;
		File file1 = null;

		try
		{
			int empid = Integer.parseInt(request.getParameter("empid"));
			String title = "\'" + request.getParameter("title") + "\'";
			String firstname = "\'" + request.getParameter("first") + "\'";
			String middlename = change(request.getParameter("middle"));
			String lastname = "\'" + request.getParameter("last") + "\'";
			String dob = "\'" + request.getParameter("dob") + "\'";
			String gender = "\'" + request.getParameter("gender") + "\'";
			String marital = "\'" + request.getParameter("marital") + "\'";


			con = dbConn.getConnection();
			Statement stmt = con.createStatement();
			String query = "update employee set salutation=" + title + ", firstname=" + firstname + ", middlename=" + middlename +
					", lastname=" + lastname + ", dob=" + dob + ", gender=" + gender + ", marital=" + marital +
					" where empid=" + empid;
			stmt.executeUpdate(query);


			String addr1 = change(request.getParameter("addr1"));
			String addr2 = change(request.getParameter("addr2"));
			String street = change(request.getParameter("street"));
			String city = change(request.getParameter("city"));
			String state = change(request.getParameter("state"));
			String country = change(request.getParameter("country"));
			String zipcode = change(request.getParameter("zipcode"));
			String homephone = change(request.getParameter("homephone"));
			String mobile = change(request.getParameter("mobile"));
			String email = change(request.getParameter("email"));

			query = "update emp_addr set addr1=" + addr1 + ", addr2=" + addr2 + ", street=" + street + ", city=" + city +
					", state=" + state + ", country=" + country + ", zipcode=" + zipcode + ", homephone=" + homephone +
					", mobile=" + mobile + ", email= " + email + " where id=" + empid;
			stmt.executeUpdate(query);



			String joining = "\'" + request.getParameter("joining") + "\'";
			String leaving = "\'" + request.getParameter("leaving") + "\'";
			String branch = "\'" + request.getParameter("branch") + "\'";
			String job = "\'" + request.getParameter("job") + "\'";
			String group = "\'" + request.getParameter("group") + "\'";
			int basic = Integer.parseInt(request.getParameter("basic"));

			query = "select * from groups where name = " + group;
			ResultSet rs = stmt.executeQuery(query);
			rs.next();
			int groupid = rs.getInt(1);
			Blob xml = rs.getBlob(4);

			query = "update emp_job  set joining=" + joining + ", leaving=" + leaving + ", branch=" + branch +
				", designation=" + job + ", groupid=" + groupid + ", basic=" + basic + " where id=" + empid;
			stmt.executeUpdate(query);


			File dir = new File(config.getServletContext().getRealPath("/") + "/WEB-INF/xml/");
			file = File.createTempFile("" + System.currentTimeMillis(), ".xml", dir);
			FileOutputStream fos = new FileOutputStream(file);
			fos.write( xml.getBytes(1,(int)xml.length()) );
			fos.close();

			myXml.setDocument(file);
			Element root = myXml.getRoot();

			NodeList employees = root.getElementsByTagName("employee");
			int c = employees.getLength();
			Element employee = null;

			for(int i=0; i<c; i++)
			{
				employee = (Element)employees.item(i);
				if( isTextNode(employee) )
					continue;
				int id = Integer.parseInt(employee.getAttribute("empid"));
				if(empid == id)
					break;
			}


			NodeList allowances = employee.getElementsByTagName("allowances");
			Node allowance= allowances.item(0);

			if( allowance.hasChildNodes() )
			{
				NodeList list = allowance.getChildNodes();
				int count = list.getLength();

				for(int i=0 ; i<count; i++)
				{
					Node items = list.item(i);

					if( isTextNode(items) )
						continue;

					String name1 = items.getNodeName();
					String value1 = request.getParameter(name1);
					String type1 = request.getParameter(name1 + "type");

					NodeList nodes = items.getChildNodes();
					nodes.item(1).getFirstChild().setNodeValue(type1);
					nodes.item(2).getFirstChild().setNodeValue(value1);
				}
			}


			NodeList deductions = employee.getElementsByTagName("deductions");
			Node deduction= deductions.item(0);

			if( deduction.hasChildNodes() )
			{
				NodeList list = deduction.getChildNodes();
				int count = list.getLength();

				for(int i=0 ; i<count; i++)
				{
					Node items = list.item(i);

					if( isTextNode(items) )
						continue;

					String name1 = items.getNodeName();
					String value1 = request.getParameter(name1);
					String type1 = request.getParameter(name1 + "type");

					NodeList nodes = items.getChildNodes();
					nodes.item(1).getFirstChild().setNodeValue(type1);
					nodes.item(2).getFirstChild().setNodeValue(value1);
				}
			}


			NodeList loans = employee.getElementsByTagName("loans");
			Node loan= loans.item(0);

			if( loan.hasChildNodes() )
			{
				NodeList list = loan.getChildNodes();
				int count = list.getLength();

				for(int i=0 ; i<count; i++)
				{
					Node items = list.item(i);

					if( isTextNode(items) )
						continue;

					String name1 = items.getNodeName();
					String value1 = request.getParameter(name1);
					String type1 = request.getParameter(name1 + "type");
					String curr1 = request.getParameter(name1 + "curr");
					String tot1 = request.getParameter(name1 + "tot");

					NodeList nodes = items.getChildNodes();
					nodes.item(1).getFirstChild().setNodeValue(type1);
					nodes.item(2).getFirstChild().setNodeValue(value1);
					nodes.item(3).getFirstChild().setNodeValue(curr1);
					nodes.item(4).getFirstChild().setNodeValue(tot1);
				}
			}

			myXml.updateXML();

			PreparedStatement ps = con.prepareStatement("update groups set emp=? where id=" + groupid);
			FileInputStream fis = new FileInputStream(file);
			ps.setBinaryStream(1, fis, (int)file.length());
			ps.executeUpdate();
			fis.close();

			file.delete();
%>
			<script language="javascript">
				var targetURL = "./employee.jsp";
				alert("Successfully updated the employee...");
				setTimeout( "window.location.href = targetURL", 1000);
			</script>
<%
		}
		catch(Exception e)
		{
			try
			{
				file.delete();
			}
			catch(Exception ee)
			{
			}
%>
			<script language="javascript">
				var targetURL = "./homepage.jsp";
				alert("Error: <%= e.getMessage() %>... Redirecting to homepage...");
				setTimeout( "window.location.href = targetURL", 1000);
			</script>
<%
		}
	}
	else
	{
%>
			<script language="javascript">
				var targetURL = "./homepage.jsp";
				alert("Unauthorised - Access Denied... Redirecting to homepage...");
				setTimeout( "window.location.href = targetURL", 1000);
			</script>
<%
	}
%>