<%@ page import="java.sql.*" %>
<%@ page import="java.io.*,
java.util.*,
net.sf.jasperreports.engine.*,
net.sf.jasperreports.engine.design.*,
net.sf.jasperreports.engine.xml.JRXmlLoader.*,
net.sf.jasperreports.view.*,net.sf.jasperreports.engine.util.JRXmlUtils"
%>
<%@ page import="net.sf.jasperreports.engine.util.*" %>
<%@ page import="net.sf.jasperreports.engine.export.*" %>
<%@ page import="net.sf.jasperreports.j2ee.servlets.*" %>
<%@ page import="datasource.*" %>

<%

	System.out.println("in genPlayslip");
%>

<jsp:useBean id="db" class="dbbean.DatabaseBean"></jsp:useBean>


<%
Connection conn = null;
JasperReport jasperReport;
JasperPrint jasperPrint;
JasperDesign jasperDesign;
String username =  session.getAttribute("username").toString();

try{
	conn=db.getConnection();
	System.out.println("after connection");
//	jasperReport = JasperCompileManager.compileReport((application.getRealPath("/reports/WebappReport.jrxml");

	JasperCompileManager.compileReportToFile(application.getRealPath("/reports/payslip.jrxml"));
	
	String reportFileName = application.getRealPath("/reports/xmlas.jasper");
	File reportFile = new File(reportFileName);
    if (!reportFile.exists())
		throw new JRRuntimeException("File WebappReport.jasper not found. The report design must be compiled first.");

	Map parameters = new HashMap();
	//parameters.put("ReportTitle", "Address Report");
	//parameters.put("BaseDir", reportFile.getParentFile());
				
	jasperPrint = 
		JasperFillManager.fillReport(
			reportFileName, 
			parameters,
			new WebappDataSource()
			);
				
	session.setAttribute(BaseHttpServlet.DEFAULT_JASPER_PRINT_SESSION_ATTRIBUTE, jasperPrint);
	
	jasperReport = (JasperReport)JRLoader.loadObject(reportFile.getPath());

	JRXhtmlExporter exporter = new JRXhtmlExporter();

		//generates PDF
	JasperExportManager.exportReportToPdfFile(jasperPrint,application.getRealPath("/pdf/xxx.pdf"));
	out.print("./pdf/"+ username +".pdf");
	//JasperViewer.viewReport(jasperPrint);
/*	//generates HTML
	JasperExportManager.exportReportToHtmlFile(jasperPrint, "Simple_Report.html");
	//generates XML
	//JasperExportManager.exportReportToXmlFile(jasperPrint, "Simple_Report.xml",true);
*/
%>
	<jsp:forward page="pdf/xxx.pdf" />
<%
	}catch(JRException jrException){
		jrException.printStackTrace();
	}catch (Exception e){
		e.printStackTrace();
	} finally {
		System.out.println("in finally");
	}

%>