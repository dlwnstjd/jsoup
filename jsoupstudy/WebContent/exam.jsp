<%@page import="org.jsoup.Jsoup"%>
<%@page import="java.io.IOException"%>
<%@page import="org.jsoup.nodes.Element"%>
<%@page import="org.jsoup.select.Elements"%>
<%@page import="org.jsoup.nodes.Document"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style type="text/css">
	table, td, th {border: 1px solid grey; border-collapse: collapse;}
</style>
<%
	String url = "http://biz.heraldcorp.com/"; 
	String line = "";
	Document doc = null;
	try{
		doc = Jsoup.connect(url).get();		
		Elements e1 = doc.select(".c_r_top.mb25");
		line = "<h1>헤럴드 경제 신문</h1><table><caption>많이 본 기사리스트</caption>";
		for(Element ele : e1){
			Elements e2 = ele.select("tr");
			for(Element ele2 : e2){
				String temp = ele2.html();
				System.out.println("==============");
				System.out.println(temp + " / ");	
				line += "<tr>" + temp + "</tr>";	
			}			
		}		
		line += "</table>";
	}catch(IOException e){
		e.printStackTrace();
	}
%>
</head>
<body>
<%=line %>
</body>
</html>