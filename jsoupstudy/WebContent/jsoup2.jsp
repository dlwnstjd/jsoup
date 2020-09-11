<%@page import="org.jsoup.nodes.Element"%>
<%@page import="org.jsoup.select.Elements"%>
<%@page import="org.jsoup.nodes.Document"%>
<%@page import="org.jsoup.Jsoup"%>
<%@page import="java.io.IOException"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Jsoup을 이용하여 크롤링으로 수출입은행 환율 정보 조회</title>
<style type="text/css">
	table, td, th {border: 1px solid grey; border-collapse: collapse;}
</style>
<%
	String url = "https://www.koreaexim.go.kr/site/program/financial/exchange?menuid=001001004002001";
	String line = "";
	Document doc = null;
	try{
		doc = Jsoup.connect(url).get();
		Elements e1 = doc.select("table");
		for(Element e : e1){
			String temp = e.html();
			System.out.println("==============");
			System.out.println(temp);
			line += temp;
		}		
	}catch(IOException e){
		e.printStackTrace();
	}
%>
</head>
<body>
<table>
<%=line %>
</table>
</body>
</html>