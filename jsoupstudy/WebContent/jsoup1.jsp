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
<title>��ȭ�̱۽� ���� �̹��� �����ϱ�</title>
</head>
<body>
<%
	String url = "http://www.hanwhaeagles.co.kr/html/players/player/pitcher_view.asp?sGubunCd=PLPPPC&sMSId=P514";
	String line = "";
	String title = "";
	try{
		Document doc = Jsoup.connect(url).get();
		//Ŭ�����Ӽ��� personAreaInner�� ������ �̹������� ã�ư�
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