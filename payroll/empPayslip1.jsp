<%@ page import="java.sql.*,java.io.*,org.w3c.dom.*,java.util.*" %>
<%@ page isThreadSafe="true" %>
<%@ page contentType="text/html; charset=utf-8" language="java" errorPage="" %>
<%@ page import="java.io.File,java.util.HashMap,java.util.Locale,java.util.Map" %>


<%!
	public boolean isTextNode(Node node)
	{
		return node.getNodeName().equals("#text");
	}
%>

<jsp:useBean id="dbConn" class="dbbean.DatabaseBean">
</jsp:useBean>

<jsp:useBean id="myXml" class="myxml.MyXML">
</jsp:useBean>

<jsp:useBean id="myXml1" class="myxml.MyXML">
</jsp:useBean>

<%

	String result = null;

	String username = (String)session.getAttribute("user");
	String type = (String)session.getAttribute("type");

	if(username==null)
		response.sendRedirect("index.jsp");

	try
	{
		Connection con = dbConn.getConnection();
		Statement stmt = con.createStatement();

		String eid = request.getParameter("id");
		int empid;


		if("admin".equals(type))
		{
			empid  = Integer.parseInt(eid);
		}
		else
		{
			ResultSet rs = stmt.executeQuery("select empid from employee where login='" + username + "' and admin='" + type + "'");
			rs.next();

			eid = rs.getString(1);
			empid = Integer.parseInt(eid);
		}

			String query = "select salutation, firstname, middlename, lastname from employee where empid=" + empid;
			ResultSet rs = stmt.executeQuery(query);
			rs.next();
			String name = rs.getString(1) + " " + rs.getString(2) + " " + rs.getString(3) + " " + rs.getString(4);

			query = "select designation, branch, basic, groupid from emp_job where id=" + empid;
			rs = stmt.executeQuery(query);
			rs.next();
			String job = rs.getString(1).toString();

			String branch = rs.getString(2);
			int basic = Integer.parseInt(rs.getString(3));
			int gid = Integer.parseInt(rs.getString(4));

			query = "select name, emp from groups where id=" + gid;
			rs = stmt.executeQuery(query);
			rs.next();
			String grpname = rs.getString(1);
			Blob xml = rs.getBlob(2);

			File dir = new File(config.getServletContext().getRealPath("/") + "/WEB-INF/xml/");
			File file = File.createTempFile("" + System.currentTimeMillis(), ".xml", dir);
			FileOutputStream fos = new FileOutputStream(file);
			fos.write( xml.getBytes(1,(int)xml.length()) );
			fos.close();

			myXml.setDocument(file);
			Document document = myXml.getDocument();
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

			String[][] empA = null;
			float gross = basic;

			if( allowance.hasChildNodes() )
			{
				NodeList list = allowance.getChildNodes();
				int count = list.getLength();
				empA = new String[count][2];

				for(int i=0 ; i<count; i++)
				{
					Node items = list.item(i);
					if( isTextNode(items) )
						continue;

					NodeList nodes = items.getChildNodes();
					empA[i][0] = nodes.item(0).getFirstChild().getNodeValue();
					String type1 = nodes.item(1).getFirstChild().getNodeValue();
					if(type1.indexOf("fixed")!=-1)
					{
						empA[i][1] = nodes.item(2).getFirstChild().getNodeValue();
						float f = Float.parseFloat(empA[i][1]);
						gross += f;
					}
					else
					{
						float f = ( basic * Float.parseFloat(nodes.item(2).getFirstChild().getNodeValue()) ) / 100;
						empA[i][1] = "" + f;
						gross += f;
					}
				}
			}


			NodeList deductions = employee.getElementsByTagName("deductions");
			Node deduction= deductions.item(0);

			String[][] empD = null;
			float ded = 0.0f;

			if( deduction.hasChildNodes() )
			{
				NodeList list = deduction.getChildNodes();
				int count = list.getLength();
				empD = new String[count][2];

				for(int i=0 ; i<count; i++)
				{
					Node items = list.item(i);
					if( isTextNode(items) )
						continue;

					NodeList nodes = items.getChildNodes();
					empD[i][0] = nodes.item(0).getFirstChild().getNodeValue();
					String type1 = nodes.item(1).getFirstChild().getNodeValue();
					if(type1.indexOf("fixed")!=-1)
					{
						empD[i][1] = nodes.item(2).getFirstChild().getNodeValue();
						float f = Float.parseFloat(empD[i][1]);
						ded += f;
					}
					else
					{
						float f = ( basic * Float.parseFloat(nodes.item(2).getFirstChild().getNodeValue()) ) / 100;
						empD[i][1] = "" + f;
						ded += f;
					}
				}
			}

			NodeList loans = employee.getElementsByTagName("loans");
			Node loan= loans.item(0);

			String[][] empL = null;

			if( loan.hasChildNodes() )
			{
				NodeList list = loan.getChildNodes();
				int count = list.getLength();
				empL = new String[count][4];

				for(int i=0 ; i<count; i++)
				{
					Node items = list.item(i);
					if( isTextNode(items) )
						continue;

					NodeList nodes = items.getChildNodes();
					empL[i][0] = nodes.item(0).getFirstChild().getNodeValue();
					String type1 = nodes.item(1).getFirstChild().getNodeValue();
					if(type1.indexOf("fixed")!=-1)
					{
						empL[i][1] = nodes.item(2).getFirstChild().getNodeValue();
						float f = Float.parseFloat(empL[i][1]);
						ded += f;
					}
					else
					{
						float f = ( basic * Float.parseFloat(nodes.item(2).getFirstChild().getNodeValue()) ) / 100;
						empL[i][1] = "" + f;
						ded += f;
					}

					empL[i][2] = nodes.item(3).getFirstChild().getNodeValue();
					empL[i][3] = nodes.item(4).getFirstChild().getNodeValue();
				}
			}

			//file.delete();
			File dir1 = new File(config.getServletContext().getRealPath("/") + "/data/");
			File file1 = File.createTempFile("pay", "data.xml", dir1);
			System.out.println(file1.getName());
			String filename=file1.getName();
			
			FileOutputStream fos1 = new FileOutputStream(file1);

			String str = "<payslips><payslip></payslip></payslips>";
			fos1.write(str.getBytes());
			fos1.close();
				
			myXml1.setDocument(file1);
			root = myXml1.getRoot();
			Document document1 = myXml1.getDocument();
			NodeList adls=root.getElementsByTagName("payslip");
			Node adl=adls.item(0);
			//out.println(root+""+adl);
			Element eleEmp= document1.createElement("Employee");
			Element name1 = document1.createElement("Name");
			name1.setTextContent(name); 
			eleEmp.appendChild(name1);

			Element name2 = document1.createElement("Desg");
			name2.setTextContent(job);
			System.out.println(job+": job");
			eleEmp.appendChild(name2);

			Element name3 = document1.createElement("basic");
			name3.setTextContent(Float.toString(basic)); 
			eleEmp.appendChild(name3);
			
			Element name4 = document1.createElement("LIC-PEN");
			name4.setTextContent("0"); 
			eleEmp.appendChild(name4);
			
			Element name5 = document1.createElement("Teach-Assoc");
			name5.setTextContent("0"); 
			eleEmp.appendChild(name5);

			//out.println("HI");
			for(int i=0; i<empA.length;i++){
					Element eleName = document1.createElement(empA[i][0]);
					eleName.setTextContent(empA[i][1] ); 
					eleEmp.appendChild(eleName);
					//out.println(empA[i][0]+""+empA[i][1]);
				}
			for(int i=0; i<empD.length;i++){
					Element eleName = document1.createElement(empD[i][0]);
					eleName.setTextContent(empD[i][1] ); 
					eleEmp.appendChild(eleName);
				}
			for(int i=0; i<empL.length;i++){
					Element eleName = document1.createElement(empL[i][0]);
					eleName.setTextContent( empL[i][1] + " (" + empL[i][2] + "/" + empL[i][3] +")"); 
					eleEmp.appendChild(eleName);
					//out.println(empL[i][1]);
				}
				Float net_pay=gross-ded;
				System.out.println(net_pay);
			//out.println("HI");
			Element eleG = document1.createElement("Gross-pay");
			eleG.setTextContent(Float.toString(gross));
			eleEmp.appendChild(eleG);

			Element eleDed = document1.createElement("Total-Deduction");
			eleDed.setTextContent(Float.toString(ded));
			eleEmp.appendChild(eleDed);
			//out.println("HI");
			Element eleNet = document1.createElement("Net-pay");
			eleNet.setTextContent(Float.toString(net_pay));
			eleEmp.appendChild(eleNet);
			//out.println("HI");
			
			adl.appendChild(eleEmp);
			myXml1.updateXML();
			//out.println("HIiiiiiii");
			//file1.delete();
			out.println("<center><b><blink>Loading ...</blink></b></center>");
			if(true){
%>
		<script src="js/jquery-1.4.2.min.js"></script>
		<script language="javascript">
			$.ajax({
				url:'./../payslip/genPayslip.jsp',
				data:'filename=<%=filename%>',
				success:function(msg){
						window.location=msg;
					}
			});
		</script>
<%
			}
	}
	catch(Exception e)
	{
%>
		<script language="javascript">
			var targetURL = "./homepage.jsp";
			alert("Error: <%= e.getMessage() %>... Redirecting to homepage...");
			setTimeout( "window.location.href = targetURL", 1000);
		</script>
<%
	}
		
%>