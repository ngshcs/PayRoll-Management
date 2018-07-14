<%@ page language="java" %>
<%@ page import="java.sql.*,java.io.*,org.w3c.dom.*,java.util.*,gui.ava.html.image.generator.*" %>
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
		int empid=0;
		
		if("admin".equals(type))
		{
			empid  = Integer.parseInt(eid);

		}

	//	String[] months = { "Jan", "Feb", "Mar", "April", "May", "June", "July", "Aug", "Sept", "Oct", "Nov", "Dec" };
	//	Calendar cal = Calendar.getInstance();

	//	String mon = months[ cal.get(Calendar.MONTH) ];
	//	String year = "" + cal.get(Calendar.YEAR);
	//	String rightNow = mon + " " + year;
		
	//	for(int t=0;t<months.length;t++)
	//	{
	//		int incomeTax_amount=0.0;
	//		if(t< cal.get(Calendar.MONTH))
	//		{
	//			String date= months[t]+" "+cal.get(Calendar.YEAR);
	//			ResultSet rs=stmt.executeQuery("select emp from payslips where id='"+date+"'and name='"+gid+"'");

	//			if(rs.next())
	//			{
	//				File dir = new File(config.getServletContext().getRealPath("/") + "/WEB-INF/xml/");
	//				File file = File.createTempFile("" + System.currentTimeMillis(), ".xml", dir);
	//				FileOutputStream fos = new FileOutputStream(file);
	//				fos.write( xml.getBytes(1,(int)xml.length()) );
	//				fos.close();
					File file=new File(config.getApplicationContext().getRealPath("/")+\webapps\payroll\data\pay8199842654686365830data.xml);
					myXml.setDocument(file);
					Document document = myXml.getDocument();
					Element root = myXml.getRoot();

					NodeList employees = root.getElementsByTagName("payslip");
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
					NodeList allowances = employee.getElementsByTagName("Employee");
					ELement allowance=employee.getElementsByTagName("Employee"); 
					NodeList x=allowance.getElementsByTagName("gross");
		

				/*	if(	allowance.hasChildNodes() )
					{
						NodeList list = allowance.getChildNodes();
						int count = list.getLength();
						for(int i=0;i<count;i++)
						{
							Node items= list.item(i);
							if(items.getNodeName().equals("net-pay"))
							{
								int pay=Integer.parseInt(list.item(i).getFirstChild().getNodeValue());
								incomeTax_amount+=pay;
							}
						}
			
					}	
	//			}
				else
				{
				out.pintln("Sorry record not found try after december");
				break;
				}*/
			}
		
		
	catch(Exception e)
	{out.println(e);}
%>
 