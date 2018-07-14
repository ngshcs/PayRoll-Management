<%@ page language="java" %>
<%@ page import="java.sql.*,java.io.*,org.w3c.dom.*,java.util.*" %>
<%@ page isThreadSafe="true" %>

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
	String username = (String)session.getAttribute("user");
	String type = (String)session.getAttribute("type");

	if(username==null)
		response.sendRedirect("index.jsp");


	if("admin".equals(type))
	{
		String eid = request.getParameter("id");
		String name = request.getParameter("name");
		
		System.out.println(eid+name);
	

		if(eid!=null && name!=null)
		{
		       try
		       {

			Connection con = dbConn.getConnection();
			Statement stmt = con.createStatement();

			String query = "select payslip from payslips where id='" + eid + "' and name='" + name + "'";
			ResultSet rs = stmt.executeQuery(query);
			rs.next();
			Blob xml = rs.getBlob(1);

			File dir1 = new File(config.getServletContext().getRealPath("/") + "/data/");
			File file1 = File.createTempFile("pay", "data.xml", dir1);
			FileOutputStream fos1 = new FileOutputStream(file1);
			String filename=file1.getName();

			String str1 = "<payslips></payslips>";
				fos1.write(str1.getBytes());
			
			fos1.close();

			File dir = new File(config.getServletContext().getRealPath("/") + "/WEB-INF/xml/");
			File file = File.createTempFile("" + System.currentTimeMillis(), ".xml", dir);
			FileOutputStream fos = new FileOutputStream(file);
			fos.write( xml.getBytes(1,(int)xml.length()) );
			fos.close();

			myXml.setDocument(file);
			Element root = myXml.getRoot();

			NodeList employees = root.getElementsByTagName("employee");
			int c = employees.getLength();
			int cols = 0;

			String[] A = null;
			int acols = 0;

			String[] D = null;
			int dcols = 0;

			String[] L = null;
			int lcols = 0;


			if(c>0)
			{
				Element employee = (Element)employees.item(0);

				NodeList allowances = employee.getElementsByTagName("allowances");
				Node allowance= allowances.item(0);
				if( allowance.hasChildNodes() )
				{
					NodeList list = allowance.getChildNodes();
					acols = list.getLength();
					A = new String[acols];

					for(int z=0 ; z<acols; z++)
					{
						Node items = list.item(z);
						if( isTextNode(items) )
							continue;

						NodeList nodes = items.getChildNodes();
						A[z] = nodes.item(0).getFirstChild().getNodeValue();
					}
				}

				NodeList deductions = employee.getElementsByTagName("deductions");
				Node deduction= deductions.item(0);
				if( deduction.hasChildNodes() )
				{
					NodeList list = deduction.getChildNodes();
					dcols = list.getLength();
					D = new String[dcols];

					for(int z=0 ; z<dcols; z++)
					{
						Node items = list.item(z);
						if( isTextNode(items) )
							continue;

						NodeList nodes = items.getChildNodes();
						D[z] = nodes.item(0).getFirstChild().getNodeValue();
					}
				}

				NodeList loans = employee.getElementsByTagName("loans");
				Node loan= loans.item(0);
				if( loan.hasChildNodes() )
				{
					NodeList list = loan.getChildNodes();
					lcols = list.getLength();
					L = new String[lcols];

					for(int z=0 ; z<lcols; z++)
					{
						Node items = list.item(z);
						if( isTextNode(items) )
							continue;

						NodeList nodes = items.getChildNodes();
						L[z] = nodes.item(0).getFirstChild().getNodeValue();
					}
				}

				cols = acols + dcols + lcols;
			}


			float totalBasic = 0.0f;
			float[] totalAllowances = null;
			float[] totalDeductions = null;
			float[] totalLoans = null;
			float totalGross = 0.0f;
			float totalDed = 0.0f;
			int sno = 0;


			cols += 7;
			myXml1.setDocument(file1);
			root = myXml1.getRoot();
			Document document1 = myXml1.getDocument();
%>
			
<%
			for(int ii=0; ii<c; ii++)
			{
				Element employee = (Element)employees.item(ii);
				if( isTextNode(employee) )
					continue;
				int id = Integer.parseInt(employee.getAttribute("empid"));
				sno++;
				System.out.println("qwerty"+id);

				query = "select salutation, firstname, middlename, lastname from employee where empid=" + id;
				Statement stmt1 = con.createStatement();
				ResultSet rs1 = stmt.executeQuery(query);
				if(rs1.next())
				{
				String name1 = rs1.getString(1) + " " + rs1.getString(2) + " " + rs1.getString(3) + " " + rs1.getString(4);

				query = "select designation, branch, basic from emp_job where id=" + id;
				rs1 = stmt1.executeQuery(query);
				rs1.next();
				String job = rs1.getString(1);
				String branch = rs1.getString(2);
				int basic = Integer.parseInt(rs1.getString(3));
				totalBasic += basic;


				NodeList allowances = employee.getElementsByTagName("allowances");
				Node allowance= allowances.item(0);

				String[] empA = null;
				float gross = basic;

				if( allowance.hasChildNodes() )
				{
					NodeList list = allowance.getChildNodes();
					int count = list.getLength();
					empA = new String[count];

					if(totalAllowances==null)
					{
						totalAllowances = new float[count];
						for(int x=0; x<count; x++)
							totalAllowances[x] = 0.0f;
					}

					for(int i=0 ; i<count; i++)
					{
						Node items = list.item(i);
						if( isTextNode(items) )
							continue;

						NodeList nodes = items.getChildNodes();
						String type1 = nodes.item(1).getFirstChild().getNodeValue();
						if(type1.indexOf("fixed")!=-1)
						{
							empA[i] = nodes.item(2).getFirstChild().getNodeValue();
							float f = Float.parseFloat(empA[i]);
							totalAllowances[i] += f;
							gross += f;
						}
						else
						{
							float f = ( basic * Float.parseFloat(nodes.item(2).getFirstChild().getNodeValue()) ) / 100;
							System.out.println(Float.parseFloat(nodes.item(2).getFirstChild().getNodeValue()));
							empA[i] = "" + f;
							totalAllowances[i] += f;
							gross += f;
						}
					}
				}

				totalGross += gross;


				NodeList deductions = employee.getElementsByTagName("deductions");
				Node deduction= deductions.item(0);

				String[] empD = null;
				float ded = 0.0f;

				if( deduction.hasChildNodes() )
				{
					NodeList list = deduction.getChildNodes();
					int count = list.getLength();
					empD = new String[count];

					if(totalDeductions==null)
					{
						totalDeductions = new float[count];
						for(int x=0; x<count; x++)
							totalDeductions[x] = 0.0f;
					}

					for(int i=0 ; i<count; i++)
					{
						Node items = list.item(i);
						if( isTextNode(items) )
							continue;

						NodeList nodes = items.getChildNodes();
						String type1 = nodes.item(1).getFirstChild().getNodeValue();
						if(type1.indexOf("fixed")!=-1)
						{
							empD[i] = nodes.item(2).getFirstChild().getNodeValue();
							float f = Float.parseFloat(empD[i]);
							totalDeductions[i] += f;
							ded += f;
						}
						else
						{
							float f = ( basic * Float.parseFloat(nodes.item(2).getFirstChild().getNodeValue()) ) / 100;
							empD[i] = "" + f;
							totalDeductions[i] += f;
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
					empL = new String[count][3];

					if(totalLoans==null)
					{
						totalLoans = new float[count];
						for(int x=0; x<count; x++)
							totalLoans[x] = 0.0f;
					}

					for(int i=0 ; i<count; i++)
					{
						Node items = list.item(i);
						if( isTextNode(items) )
							continue;

						NodeList nodes = items.getChildNodes();
						String type1 = nodes.item(1).getFirstChild().getNodeValue();
						if(type1.indexOf("fixed")!=-1)
						{
							empL[i][0] = nodes.item(2).getFirstChild().getNodeValue();
							float f = Float.parseFloat(empL[i][0]);
							totalLoans[i] += f;
							ded += f;
						}
						else
						{
							float f = ( basic * Float.parseFloat(nodes.item(2).getFirstChild().getNodeValue()) ) / 100;
							empL[i][0] = "" + f;
							totalLoans[i] += f;
							ded += f;
						}

						empL[i][1] = nodes.item(3).getFirstChild().getNodeValue();
						empL[i][2] = nodes.item(4).getFirstChild().getNodeValue();
					}
				}

				totalDed += ded;

			Element elepay= document1.createElement("payslip");
			elepay.setAttribute("empid",""+id);
			Element eleEmp= document1.createElement("Employee");
			Element Name = document1.createElement("Name");
			Name.setTextContent(name1); 
			eleEmp.appendChild(Name);

			Element name2 = document1.createElement("Desg");
			name2.setTextContent(job + " " + branch); 
			eleEmp.appendChild(name2);

			Element elebasic = document1.createElement("basic");
			elebasic.setTextContent(Integer.toString(basic)); 
			eleEmp.appendChild(elebasic);
%>

<%
				for(int z=0; z<empA.length; z++)
				{
					Element eleAr = document1.createElement(A[z]);
					eleAr.setTextContent(empA[z]); 
					eleEmp.appendChild(eleAr);
				}	
				Element elegross = document1.createElement("gross");
				elegross.setTextContent(Float.toString(gross)); 
				eleEmp.appendChild(elegross);
					//out.println("<td>" +  empA[z] + "</td>");
				//out.println("<td> <b>" + gross + "</b> </td>");

				for(int z=0; z<empD.length; z++)
				{
					Element eleDe = document1.createElement(D[z]);
					eleDe.setTextContent(empD[z]); 
					eleEmp.appendChild(eleDe);
				}
					//out.println("<td>" +  empD[z] + "</td>");

				for(int z=0; z<empL.length; z++)
				{
					
					Element eleLoan = document1.createElement(L[z]);
					eleLoan.setTextContent(empL[z][0] + "(" + empL[z][1] + "/" + empL[z][2] + ")"); 
					eleEmp.appendChild(eleLoan);

				}
				//	out.println("<td>" +  empL[z][0] + "(" + empL[z][1] + "/" + empL[z][2] + ")" + "</td>");
				
				Element eleded = document1.createElement("ded");
				eleded.setTextContent(Float.toString(ded)); 
				eleEmp.appendChild(eleded);
					
				Element elenet = document1.createElement("net-pay");
				elenet.setTextContent(Float.toString(gross-ded)); 
				eleEmp.appendChild(elenet);
%>
<%
				elepay.appendChild(eleEmp);
				root.appendChild(elepay);
				myXml1.updateXML();
				}
				System.out.println("Hiii");
				session.setAttribute("filename",file.getName());
				session.setAttribute("month",System.currentTimeMillis());
				
				}
%>
	<script src="js/jquery-1.4.2.min.js"></script>
		<script language="javascript">
			$.ajax({
				url:'./../payslip/genPayslipLandNTS.jsp',
				data:'filename=<%=filename%>&name=NonTeachingStaff',
				success:function(msg){
						if(msg.indexOf("Error")!=-1){
							$(document).html("Something went wrong");
							setTimeout("window.location.href='./home.jsp'",500);
						}else{
							//alert(msg);
							//window.open(msg);
							window.location.href= msg;
						}
					}
			});
		</script>
<%
			//file.delete();
		       }
		       catch(Exception e)
		       {
%>
			<script language="javascript">
				var targetURL = "./homepage.jsp";
				alert("Error: <%= e %>... Redirecting to homepage...");
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
				alert("Error: null... Redirecting to homepage...");
				setTimeout( "window.location.href = targetURL", 1000);
			</script>
<%
		}
	}

%>