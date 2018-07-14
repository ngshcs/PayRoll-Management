<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<%@ page isThreadSafe="true" %>

<%
	String username = (String)session.getAttribute("user");
	String type = (String)session.getAttribute("type");

	if(username==null)
		response.sendRedirect("index.jsp");
%>

<html>
           <head>
	<link rel="stylesheet" href="./tree/dtree.css" type="text/css" />
	<script type="text/javascript" src="./tree/dtree.js"></script>

	<script type="text/javascript">
	         if(top.frames.length == 0)
	                 top.location.href = "./home.jsp?homepage.jsp";
	</script>
           </head>

           <body background="./images/background.png" onunload="">
<%
	if("admin".equals(type))
	{
%>
	<div class="dtree">
	         <script type="text/javascript">
		<!--
		        d = new dTree('d');
		        d.config.target = 'main';

		        d.add(0,-1,'<b>Payroll System</b>');
		        d.add(1,0,'General Administration');
		        d.add(2,0,'Account Administration');
		        d.add(3,0,'Payroll Administration');
		        d.add(4,0,'Payroll Maintainance');

		        d.add(5,1,'Deparments','department.jsp');
		        d.add(6,1,'Designations','designation.jsp');

		        d.add(7,2,'Employee','employee.jsp');

		        d.add(8,3,'Allowances','allowances.jsp');
		        d.add(9,3,'Deductions','deductions.jsp');
		        d.add(10,3,'Loans','loans.jsp');

		        d.add(11,4,'PaySlip','payslip.jsp');
				

		        document.write(d);
		-->
	         </script>
	</div>
<%
	}
	else
	{
%>
	<div class="dtree">
	         <script type="text/javascript">
		<!--
		        d = new dTree('d');
		        d.config.target = 'main';

		        d.add(0,-1,'<b>Payroll System</b>');
		        d.add(1,0,'Profile');
		        d.add(2,0,'Pay Slip');

		        d.add(3,1,'View Profile','profile.jsp');
		        d.add(4,1,'Change Username','change.jsp');
		        d.add(5,1,'Profile Picture','profilePic.jsp');

		        d.add(6,2,'View PaySlip','viewPayslip.jsp');

		        document.write(d);
		-->
	         </script>
	</div>
<%
	}
%>
          </body>
</html>