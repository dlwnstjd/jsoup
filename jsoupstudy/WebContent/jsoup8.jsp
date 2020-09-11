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
<title>XML 데이터 처리하기: 공공데이터에서 데이터 수집</title>
<style type="text/css">
	table, td, th {border: 1px solid grey; border-collapse: collapse;}
</style>
</head>
<body>
<%
	String url = "http://openapi.airport.kr/openapi/service/StatusOfPassengerFlights/getPassengerArrivals?serviceKey=3va1bu02bHpx%2FG%2B3xl3Zq2hbaiQ%2FFwvMuwpPnPPoH%2FNTkXlpbP9VPqDetIyUw7bRUE4plR0gq3Cy9SFOPui%2FMg%3D%3D";
	URL u = new URL(url);	//java.net 패키지의 클래스
	//URLConnection: 추상클래스
	//HttpURLConnection: URLConnection 클래스의 하위 클래스
	HttpURLConnection urlcon = (HttpURLConnection)u.openConnection();	//url에 접속 객체 리턴.
	//접속된 객체의 format 설정.
	urlcon.setRequestProperty("Accept", "application/xml");
	
	String line = "";
	String title = "";
	Document doc = null;
	//StringBuilder, StringBuffer: 동적문자열.
	StringBuilder sb = new StringBuilder();
	try{
		//urlcon.getInputStream(): 바이트형 입력스트림. url로 부터 데이터 입력받음.
		//InputStreamReader: InputStream 형태를 Reader로 변환. 
		//문자형 입력스트림으로 변경시 인코딩 방식을 "UTF-8"로 설정.
		BufferedReader in = new BufferedReader
				(new InputStreamReader(urlcon.getInputStream(),"UTF-8"));
		int len = 0;
		char[] buf = new char[8096];
		while((len = in.read(buf)) != -1){
			//sb에 정보가 담김.
			sb.append(new String(buf,0,len));
		}
		System.out.println(new String(sb.toString().getBytes(),"UTF-8"));
		doc = Jsoup.parse(sb.toString());	//xml 데이터 분석
		Elements items = doc.select("item");		
		line += "<table><caption>항공기도착정보</caption><tr><th>항공사</th><th>출발항공</th><th>비행기코드</th><th>예정시간</th><th>변경시간</th><th>비고</th></tr>";
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