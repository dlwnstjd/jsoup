<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.jsoup.Jsoup"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>JSON 데이터 처리하기</title>
<style type="text/css">
	table, td, th {border: 1px solid grey; border-collapse: collapse;}
</style>
</head>
<body>
<% 
	String kebhana = Jsoup.connect("http://fx.kebhana.com/FER1101M.web").get().select("body").text();
	String strJson = kebhana.substring(kebhana.indexOf("{"));	
	System.out.println(strJson);
	//JSONParser: JSON을 번역하는 역활을 해줌 
	JSONParser jsonParser = new JSONParser();
	JSONObject json = (JSONObject)jsonParser.parse(strJson.trim());	//JSON객체변경
	String html = "<table><caption>" + json.get("날짜").toString() + "</caption>"
	+ "<tr><th rowspan='2'>통화명</th><th rowspan='2'>매매기준율</th>"
	+ "<th colspan='2'>현찰</th><th colspan='2'>전신환송금</th></tr>"
	+ "<tr><th>파실때</th><th>사실때</th><th>보내실때</th><th>받으실때</th>";
	
	JSONArray array = (JSONArray)json.get("리스트");
	for(int i=0;i<array.size();i++){
		JSONObject obj = (JSONObject)array.get(i);
		html += "<tr><td>" + obj.get("통화명") + "</td>"
				+ "<td>" + obj.get("매매기준율") + "</td>"
				+ "<td>" + obj.get("현찰파실때") + "</td>"
				+ "<td>" + obj.get("현찰사실때") + "</td>"
				+ "<td>" + obj.get("송금_전신환보내실때") + "</td>"
				+ "<td>" + obj.get("송금_전신환받으실때") + "</td></tr>";
	}
	html += "</table>";
%>
<%=html %>
</body>
</html>