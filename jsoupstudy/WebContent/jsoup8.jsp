<%@page import="org.jsoup.nodes.Element"%>
<%@page import="org.jsoup.select.Elements"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="org.jsoup.nodes.Document"%>
<%@page import="java.io.IOException"%>
<%@page import="java.net.URL"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="org.jsoup.Jsoup"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>XML ������ ó���ϱ�: ���������Ϳ��� ������ ����</title>
<style type="text/css">
	table, td, th {border: 1px solid grey; border-collapse: collapse;}
</style>
</head>
<body>
<%
	String url = "http://openapi.airport.kr/openapi/service/StatusOfPassengerFlights/getPassengerArrivals?serviceKey=3va1bu02bHpx%2FG%2B3xl3Zq2hbaiQ%2FFwvMuwpPnPPoH%2FNTkXlpbP9VPqDetIyUw7bRUE4plR0gq3Cy9SFOPui%2FMg%3D%3D";
	URL u = new URL(url);	//java.net ��Ű���� Ŭ����
	//URLConnection: �߻�Ŭ����
	//HttpURLConnection: URLConnection Ŭ������ ���� Ŭ����
	HttpURLConnection urlcon = (HttpURLConnection)u.openConnection();	//url�� ���� ��ü ����.
	//���ӵ� ��ü�� format ����.
	urlcon.setRequestProperty("Accept", "application/xml");
	
	String line = "";
	String title = "";
	Document doc = null;
	//StringBuilder, StringBuffer: �������ڿ�.
	StringBuilder sb = new StringBuilder();
	try{
		//urlcon.getInputStream(): ����Ʈ�� �Է½�Ʈ��. url�� ���� ������ �Է¹���.
		//InputStreamReader: InputStream ���¸� Reader�� ��ȯ. 
		//������ �Է½�Ʈ������ ����� ���ڵ� ����� "UTF-8"�� ����.
		BufferedReader in = new BufferedReader
				(new InputStreamReader(urlcon.getInputStream(),"UTF-8"));
		int len = 0;
		char[] buf = new char[8096];
		while((len = in.read(buf)) != -1){
			//sb�� ������ ���.
			sb.append(new String(buf,0,len));
		}
		System.out.println(new String(sb.toString().getBytes(),"UTF-8"));
		doc = Jsoup.parse(sb.toString());	//xml ������ �м�
		Elements items = doc.select("item");		
		line += "<table><caption>�װ��⵵������</caption><tr><th>�װ���</th><th>����װ�</th><th>������ڵ�</th><th>�����ð�</th><th>����ð�</th><th>���</th></tr>";
		for(Element src : items){
			Elements al = src.select("airline");
			Elements ap = src.select("airport");
			Elements fi = src.select("flightid");
			Elements sd = src.select("scheduledatetime");
			Elements sdt = src.select("estimateddatetime");
			Elements rm = src.select("remark");
			line += "<tr><td>" + al + "</td><td>" + ap + "</td><td>" + fi + "</td><td>" + sd + 
					"</td><td>" + sdt + "</td><td>" + rm + "</td></tr>";
		}
		line += "</table>";
		
	}catch(IOException e){
		e.printStackTrace();
	}
%>
<%=line %>
</body>
</html>