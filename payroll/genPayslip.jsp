<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.io.File,java.util.HashMap,java.util.Locale,java.util.Map" %>
<%@ page import="net.sf.jasperreports.engine.JRException,net.sf.jasperreports.engine.JRExporterParameter,net.sf.jasperreports.engine.JRParameter,net.sf.jasperreports.engine.JasperExportManager,net.sf.jasperreports.engine.JasperFillManager,net.sf.jasperreports.engine.JasperPrint,net.sf.jasperreports.engine.JasperPrintManager,net.sf.jasperreports.engine.export.JExcelApiExporter,net.sf.jasperreports.engine.export.JRCsvExporter,net.sf.jasperreports.engine.export.JRRtfExporter,net.sf.jasperreports.engine.export.JRXhtmlExporter,net.sf.jasperreports.engine.export.JRXlsExporter,net.sf.jasperreports.engine.export.JRXlsExporterParameter,net.sf.jasperreports.engine.export.oasis.JROdsExporter,net.sf.jasperreports.engine.export.oasis.JROdtExporter,net.sf.jasperreports.engine.export.ooxml.JRDocxExporter,net.sf.jasperreports.engine.export.ooxml.JRPptxExporter,net.sf.jasperreports.engine.export.ooxml.JRXlsxExporter,net.sf.jasperreports.engine.query.JRXPathQueryExecuterFactory,net.sf.jasperreports.engine.util.AbstractSampleApp,net.sf.jasperreports.engine.util.JRLoader,net.sf.jasperreports.engine.util.JRXmlUtils,org.w3c.dom.Document" %>

<%
		try
		{
		long start = System.currentTimeMillis();
		Map params = new HashMap();
		Document document = JRXmlUtils.parse(JRLoader.getLocationInputStream(application.getRealPath("/data/payslip.xml")));
		params.put(JRXPathQueryExecuterFactory.PARAMETER_XML_DATA_DOCUMENT, document);
		params.put(JRXPathQueryExecuterFactory.XML_DATE_PATTERN, "yyyy-MM-dd");
		params.put(JRXPathQueryExecuterFactory.XML_NUMBER_PATTERN, "#,##0.##");
		params.put(JRXPathQueryExecuterFactory.XML_LOCALE, Locale.ENGLISH);
		params.put(JRParameter.REPORT_LOCALE, Locale.US);
		
		JasperFillManager.fillReportToFile(application.getRealPath("/reports/payslipf.jasper"), params);
		System.err.println("Filling time : " + (System.currentTimeMillis() - start));
		
		
		JasperExportManager.exportReportToPdfFile(application.getRealPath("/reports/payslipf.jrprint"));
		System.err.println("PDF creation time : " + (System.currentTimeMillis() - start));
%>
        <jsp:forward page="/reports/payslip.pdf" />
<%
		}
		catch(Exception e)
		{
			System.out.println(e);
		} finally {
			
		}
%>