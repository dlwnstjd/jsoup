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
<title>한화이글스 선수 이미지 수집하기</title>
</head>
<body>
<%
	String url = "http://www.hanwhaeagles.co.kr/html/players/player/pitcher_view.asp?sGubunCd=PLPPPC&sMSId=P514";
	String line = "";
	String title = "";
	try{
		Document doc = Jsoup.connect(url).get();
		//클래스속성이 personAreaInner의 하위의 이미지값을 찾아감
		Elements body = doc.select(".personAreaInner > .img");
		for(Element src : body){
			out.println(src.toString());
		}
		
	}catch(IOException e){
		e.printStackTrace();
	}
%>
</body>
</html>