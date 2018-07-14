<%@ page language="java" %>
<%@ page import="java.sql.*,java.io.*,org.w3c.dom.*" %>
<%@ page isThreadSafe="true" %>

<jsp:useBean id="dbConn" class="dbbean.DatabaseBean">
</jsp:useBean>

<jsp:useBean id="myXml" class="myxml.MyXML">
</jsp:useBean>

<jsp:useBean id="myXml1" class="myxml.MyXML">
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
		int empid = 1234;

		try
		{
			String login, pwd;
			String title = "\'" + request.getParameter("title") + "\'";
			String firstname = request.getParameter("first");

			if(firstname.length()>=4)
				login = firstname.substring(0,3);
			else
				login = firstname;

			firstname = "\'" + firstname + "\'";
			String middlename = change(request.getParameter("middle"));
			String lastname = "\'" + request.getParameter("last") + "\'";
			String dob = "\'" + request.getParameter("dob") + "\'";
			String gender = "\'" + request.getParameter("gender") + "\'";
			String marital = "\'" + request.getParameter("marital") + "\'";


			con = dbConn.getConnection();
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery("select max(empid) from employee");

			if( rs.next() )
			{
				try
				{
					empid = Integer.parseInt(rs.getString(1));
					if(empid==0)
						empid = 1234;
					else
						empid = empid +1;
				}
				catch(Exception ex)
				{
					empid = 1234;
				}
			}

			login = "\'" + login + empid + "\'";
			login = login.replaceAll(" ", "-");
			login = login.replaceAll("a", "@");
			login = login.replaceAll("b", "6");
			login = login.replaceAll("c", "(");
			login = login.replaceAll("f", "t");
			login = login.replaceAll("g", "9");
			login = login.replaceAll("i", "!");
			login = login.replaceAll("l", "1");
			login = login.replaceAll("m", "w");
			login = login.replaceAll("n", "u");
			login = login.replaceAll("o", "0");
			login = login.replaceAll("s", "5");
			login = login.replaceAll("u", "n");
			login = login.replaceAll("w", "m");

			pwd = login;

			String query = "insert into employee(empid, salutation, firstname, middlename, lastname, dob, gender, marital, login, password) " + 
					"values(" + empid + "," + title + "," + firstname + "," + middlename + "," + lastname + "," + dob + "," + gender + "," + marital + "," + login + "," + pwd + ")";
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

			query = "insert into emp_addr(id, addr1, addr2, street, city, state, country, zipcode, homephone, mobile, email) " +
				"values(" + empid + "," + addr1 + "," + addr2 + "," + street + "," + city + "," + state + "," + country + "," + zipcode + "," + homephone + "," + mobile + "," + email + ")";
			stmt.executeUpdate(query);



			String joining = "\'" + request.getParameter("joining") + "\'";
			String leaving = "\'" + request.getParameter("leaving") + "\'";
			String branch = "\'" + request.getParameter("branch") + "\'";
			String job = "\'" + request.getParameter("job") + "\'";
			String group = "\'" + request.getParameter("group") + "\'";
			int basic = Integer.parseInt(request.getParameter("basic"));

			query = "select * from groups where name = " + group;
			rs = stmt.executeQuery(query);
			rs.next();
			int groupid = rs.getInt(1);
			Blob xml = rs.getBlob(3);
			Blob emp = rs.getBlob(4);

			query = "insert into emp_job(id, joining, leaving, branch, designation, groupid, basic) " +
				"values(" + empid + "," + joining + "," + leaving + "," + branch + "," + job + "," + groupid + "," + basic + ")";
			stmt.executeUpdate(query);


			File dir = new File(config.getServletContext().getRealPath("/") + "/WEB-INF/xml/");
			file = File.createTempFile("" + System.currentTimeMillis(), ".xml", dir);
			FileOutputStream fos = new FileOutputStream(file);
			fos.write( xml.getBytes(1,(int)xml.length()) );
			fos.close();


			file1 = File.createTempFile("" + System.currentTimeMillis(), ".xml", dir);
			fos = new FileOutputStream(file1);
			if(emp==null)
			{
				String data = "<employeelist></employeelist>";
				fos.write( data.getBytes() );
			}
			else
				fos.write( emp.getBytes(1,(int)emp.length()) );
			fos.close();


			myXml.setDocument(file);
			Element root = myXml.getRoot();

			myXml1.setDocument(file1);
			Element root1 = myXml1.getRoot();


			Document document = myXml1.getDocument();
			Element employee = document.createElement("employee");
			employee.setAttribute("empid",""+empid);
			Element empA = document.createElement("allowances");

			NodeList allowances = root.getElementsByTagName("allowances");
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

					Element ele = document.createElement(name1);
						Element ele1 = document.createElement("name");
						ele1.setTextContent(name1);
						Element ele2 = document.createElement("type");
						ele2.setTextContent(type1);
						Element ele3 = document.createElement("value");
						ele3.setTextContent(value1);
					ele.appendChild(ele1);
					ele.appendChild(ele2);
					ele.appendChild(ele3);

					empA.appendChild(ele);
				}
			}

			employee.appendChild(empA);
			Element empB = document.createElement("deductions");

			NodeList deductions = root.getElementsByTagName("deductions");
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

					Element ele = document.createElement(name1);
						Element ele1 = document.createElement("name");
						ele1.setTextContent(name1);
						Element ele2 = document.createElement("type");
						ele2.setTextContent(type1);
						Element ele3 = document.createElement("value");
						ele3.setTextContent(value1);
					ele.appendChild(ele1);
					ele.appendChild(ele2);
					ele.appendChild(ele3);

					empB.appendChild(ele);
				}
			}

			employee.appendChild(empB);
			Element empC = document.createElement("loans");

			NodeList loans = root.getElementsByTagName("loans");
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

					Element ele = document.createElement(name1);
						Element ele1 = document.createElement("name");
						ele1.setTextContent(name1);
						Element ele2 = document.createElement("type");
						ele2.setTextContent(type1);
						Element ele3 = document.createElement("value");
						ele3.setTextContent(value1);
						Element ele4 = document.createElement("current");
						ele4.setTextContent(curr1);
						Element ele5 = document.createElement("total");
						ele5.setTextContent(tot1);
					ele.appendChild(ele1);
					ele.appendChild(ele2);
					ele.appendChild(ele3);
					ele.appendChild(ele4);
					ele.appendChild(ele5);

					empC.appendChild(ele);
				}
			}

			employee.appendChild(empC);

			root1.appendChild(employee);
			myXml1.updateXML();

			PreparedStatement ps = con.prepareStatement("update groups set emp=? where id=" + groupid);
			FileInputStream fis = new FileInputStream(file1);
			ps.setBinaryStream(1, fis, (int)file1.length());
			ps.executeUpdate();
			fis.close();

			file.delete();
			file1.delete();
%>
			<script language="javascript">
				var targetURL = "./employee.jsp";
				alert("Successfully registered the employee...");
				setTimeout( "window.location.href = targetURL", 1000);
			</script>
<%
		}
		catch(Exception e)
		{
			try
			{
				Statement stmt = con.createStatement();
				stmt.executeUpdate("delete from employee where empid = " + empid);
				stmt.executeUpdate("delete from emp_addr where id = " + empid);
				stmt.executeUpdate("delete from emp_job where id = " + empid);

				file.delete();
				file1.delete();
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