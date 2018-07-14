<%@ page language="java" errorPage="index.jsp" %>
<%@ page import="java.sql.*,java.io.*,org.w3c.dom.*,java.util.*,java.lang.* " %>
<%@ page isThreadSafe="true" %>



<%!
	public boolean isTextNode(Node node)
	{
		return node.getNodeName().equals("#text");
	}
%>

<jsp:useBean id="dbConn" class="dbbean.DatabaseBean">
</jsp:useBean>

<jsp:useBean id="myXml" class="myxml.MyXML"></jsp:useBean>
<jsp:useBean id="myXml1" class="myxml.MyXML"></jsp:useBean>
<jsp:useBean id="myXml2" class="myxml.MyXML"></jsp:useBean>

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
		Statement stmt1 = con.createStatement();
		Statement stmt2 = con.createStatement();
		ResultSet rs=null;

		String eid =  request.getParameter("id");
		String egrp=request.getParameter("id1");
		String edept=request.getParameter("id2");		
		String edesg=request.getParameter("id3");
		String[] months = { "Jan", "Feb", "Mar", "April", "May", "June", "July", "Aug", "Sept", "Oct", "Nov", "Dec" };
			Calendar cal = Calendar.getInstance();
			String mon = months[ cal.get(Calendar.MONTH) ];
			String year = "" + cal.get(Calendar.YEAR);
			String rightNow = mon + " " + year;
			
		if("admin".equals(type))
		{
			//response.setContentType("application/octet-stream");
			//response.setContentType("text/html");
			//empid  = Integer.parseInt(eid);
			System.out.println("qwerty");
			File dir1 = new File(config.getServletContext().getRealPath("/") + "/data/");
			File file1 = File.createTempFile("pay", "data.xml", dir1);
			FileOutputStream fos1 = new FileOutputStream(file1);
			String filename=file1.getName();

			String str1 = "<payslips></payslips>";
				fos1.write(str1.getBytes());
			
			fos1.close();
					
		StringTokenizer st=new StringTokenizer(eid);
		
		while(st.hasMoreTokens())
		{
			String str=st.nextToken();
			System.out.println(str);
			if(!str.equals("1"))
			{
			int empid=Integer.parseInt(str);
		
			String query = "select salutation, firstname, middlename, lastname from employee where empid=" + empid;
			 rs = stmt.executeQuery(query);
			rs.next();
			String name = rs.getString(1) + " " + rs.getString(2) + " " + rs.getString(3) + " " + rs.getString(4);
			//int account_num=Integer.parseInt(rs.getString(5));


			query = "select designation, branch, basic, groupid from emp_job where id=" + empid;
			rs = stmt.executeQuery(query);
			rs.next();
			String job = rs.getString(1);
			String branch = rs.getString(2);
			int basic = Integer.parseInt((String)rs.getString(3));
			int gid = Integer.parseInt((String)rs.getString(4));
			
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
			Element root = myXml.getRoot();
			
			NodeList nodes = null;

		
			NodeList employees = root.getElementsByTagName("employee");
			int c = employees.getLength();
			Element employee = null;

			for(int i=0; i<c; i++)
			{
				employee = (Element)employees.item(i);
				if( isTextNode(employee) )
					continue;
				int id = Integer.parseInt((String)employee.getAttribute("empid"));
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

					nodes = items.getChildNodes();
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
		gross=Math.round(gross);
			

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

					nodes = items.getChildNodes();
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

					nodes = items.getChildNodes();
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
				ded=Math.round(ded);
				file.delete();

			int net=Math.round(gross-ded);
			int net1=net;
			System.out.println("557"+net1);
			//String amount= new Integer(net).toString();
			//String str;
			int x=0;
			String word="";
			while(net1>0){
				 x=net1%10;
			System.out.println(x);
			
			switch (x)
			{  
			 case 0:
			 word+=" ZERO";
			 break;
			 case 1:
			 word+=" ONE";
			 break;
			 case 2:
			 word+=" TWO";
			 break;
			 case 3:
			 word+="THREE";
			 break;
			 case 4:
			  word+=" FOUR";
			  break;
			 case 5:
			  word+=" FIVE";
			  break;
			 case 6:
			  word+=" SIX";
			  break;
			 case 7:
			 word+=" SEVEN";
			 break;
			 case 8:
			 word+=" EIGHT";
			 break;
			 case 9:
			 word+=" NINE";
			 break;

			}
			net1=net1/10;
		
			}
			System.out.println(word);
			myXml1.setDocument(file1);
			root = myXml1.getRoot();
			Document document1 = myXml1.getDocument();
			//NodeList adls=root.getElementsByTagName("payslip");
			//Node adl=adls.item(0);
			//out.println(root+""+adl);
			Element elepay= document1.createElement("payslip");
			elepay.setAttribute("empid",""+empid);
			Element eleEmp= document1.createElement("Employee");
			Element name1 = document1.createElement("Name");
			name1.setTextContent(name); 
			eleEmp.appendChild(name1);

			Element name2 = document1.createElement("Desg");
			name2.setTextContent(job); 
			eleEmp.appendChild(name2);


			out.println("HI");
			for(int i=0; i<empA.length;i++)
				{
					Element eleName = document1.createElement(empA[i][0]);
					eleName.setTextContent(empA[i][1] ); 
					eleEmp.appendChild(eleName);
					out.println(empA[i][0]+""+empA[i][1]);
				}
			for(int i=0; i<empD.length;i++)
				{
					Element eleName = document1.createElement(empD[i][0]);
					eleName.setTextContent(empD[i][1] ); 
					eleEmp.appendChild(eleName);
				}

			for(int i=0; i<empL.length;i++)
				{
					Element eleName = document1.createElement(empL[i][0]);
					eleName.setTextContent( empL[i][1] + " (" + empL[i][2] + "/" + empL[i][3] +")"); 
					eleEmp.appendChild(eleName);
					out.println(empL[i][1]);
				}
				
			out.println("HI");
			Element eleG = document1.createElement("Gross-pay");
			eleG.setTextContent("0");
			eleEmp.appendChild(eleG);
		

			Element eleDed = document1.createElement("Total-Deduction");
			eleDed.setTextContent("0");
			eleEmp.appendChild(eleDed);
			out.println("HI");
			Element eleNet = document1.createElement("Net-Pay");
			eleNet.setTextContent("0");
			eleEmp.appendChild(eleNet);
			Element eleW = document1.createElement("word");
			eleW.setTextContent(word);
			eleEmp.appendChild(eleW);
			
			/*String query1="select * from arrear where pmonth= '"+cal.get(Calendar.MONTH)+"' and pyear='"+ cal.get(Calendar.YEAR)+"'";
			System.out.println(query1);
			ResultSet rs2=stmt1.executeQuery(query1);
			boolean flag=false;
			int arrear_value=0;

			while (rs2.next())
			{
				System.out.println(query1);
				String temp="Teaching Staff";
				int Nmonths=3;
				year=rs2.getString(4);
				int value=Integer.parseInt((String)rs2.getString(2));
				for(int i=0;i<3;i++)
				{
					if(Nmonths<12)
					{
						mon = months[Nmonths];
						rightNow = mon + " " + year;
						Nmonths++;
					}
					else
					{
						Nmonths=0;
						mon = months[Nmonths];
						//year =String.parse(Integer.parseInt(year)+1);
						rightNow = mon + " " + year;
						Nmonths++;
						
					}
				/*	ResultSet rs1=stmt2.executeQuery("select emp from payslips where id='"+rightNow +"'and name='"+ temp +"'" );
					System.out.println("qwert");
					if(rs1.next())
					{
					System.out.println("qwert");
					Blob arr = rs1.getBlob(1);
					File dir2 = new File(config.getServletContext().getRealPath("/") + "/WEB-INF/xml/");
					File file2 = File.createTempFile("" + System.currentTimeMillis(), ".xml", dir);
					FileOutputStream fos2 = new FileOutputStream(file2);
					fos2.write( arr.getBytes(1,(int)arr.length()) );
					fos2.close();
					
					myXml2.setDocument(file2);
					Element root2 = myXml2.getRoot();
					NodeList arrears = root2.getElementsByTagName("payslip");
					//Node arrear= arrpays.item(0);
					int ac = arrears.getLength();
					Element arrear = null;
					System.out.println("qwert");
					for(int q=0; q<ac; q++)
					{	
						arrear = (Element)arrears.item(i);
						if( isTextNode(arrear) )
						continue;
						int id = Integer.parseInt((String)arrear.getAttribute("empid"));
						if(empid == id)
						break;
					}
					NodeList arrpays = arrear.getElementsByTagName("Employee");
					Element arrpay=(Element)arrpays.item(0);
					//Node arrpay= arrpays.item(0);
					//nodes = arrpay.getChildNodes();
					int arrbasic=Integer.parseInt(nodes.item(10).getFirstChild().getNodeValue());
					arrear_value+=Math.round((value*arrbasic)/100);
											
				}
				}
				flag=true;
			}
				
			if(flag==true)
			{
				Element elearr = document1.createElement("arrear");
				elearr.setTextContent(Integer.parseInt(arrear_value));
				eleEmp.appendChild(elearr);
			}
			else
			{
			}
			*/
			elepay.appendChild(eleEmp);
			root.appendChild(elepay);
			myXml1.updateXML();
			
		}

			else
			continue;
		}
		out.println("<center><b><blink>Loading ...</blink></b></center>");
			if(true){
				String fina=egrp+""+rightNow;
				System.out.println(fina);
%>
		<script src="js/jquery-1.4.2.min.js"></script>
		<script language="javascript">
			$.ajax({
				url:'./../payslip/genPayslip.jsp',
				data:'filename=<%=filename%>'+ '&month=<%=fina%>',
				success:function(msg){
							window.open(msg);
							window.location="./../payroll/homepage.jsp";
						
					}
			});
		</script>
        <%
		}
			else
	{
		out.println("<tr>Error: Unauthorised - Access Denied</tr>");
	}
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
