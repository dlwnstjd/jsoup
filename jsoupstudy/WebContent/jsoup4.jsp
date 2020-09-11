<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.jsoup.nodes.Element"%>
<%@page import="org.jsoup.select.Elements"%>
<%@page import="org.jsoup.nodes.Document"%>
<%@page import="org.jsoup.Jsoup"%>
<%@page import="java.io.IOException"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>class 속성으로 조회하기</title>
<style type="text/css">
	table, td, th {border: 1px solid grey; border-collapse: collapse;}
</style>
</head>
<body>
<%
	String url = "https://www.koreaexim.go.kr/site/program/financial/exchange?menuid=001001004002001";
	String line = "";
	Document doc = null;
	List<String> list = new ArrayList<String>();
	try{
		doc = Jsoup.connect(url).get();
		Elements e1 = doc.select(".tc");	//클래스 속성이 tc인 모든 태그들을 다 가져옴.
		for(Element ele : e1){
			list.add(ele.html());
		}		
	}catch(IOException e){
		e.printStackTrace();
	}
	pageContext.setAttribute("list", list);
%>
<table>
<c:forEach items="${list}" var="v" varStatus="stat">
	<c:choose>
		<c:when test="${stat.index % 7 == 0}">	<%--통화코드--%>
			<tr><td rowspan="6">${v}</td>
		</c:when>
		<c:when test="${stat.index % 7 == 1}">	<%--환율코드 첫번째--%>
			<td>${v}</td></tr>
		</c:when>
		<c:otherwise>
			<tr><td>${v}</td></tr>
		</c:otherwise>
	</c:choose>
</c:forEach>
</table>
</body>
</html>