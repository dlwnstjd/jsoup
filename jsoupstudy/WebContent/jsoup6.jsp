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
	String strJson = kebhana.replaceAll("}, ] }", "} ]");
	strJson = strJson.substring(strJson.indexOf("["));	
	System.out.println(strJson);
	//JSONParser: JSON을 번역하는 역활을 해줌 
	JSONParser jsonParser = new JSONParser();
	JSONArray array = (JSONArray)jsonParser.parse(strJson);	//JSON객체변경
	float usd = 0f;
	float jpy = 0f;
	float eur = 0f;
	float cny = 0f;
	
	//JSONObject: json 형태의 객체. {"키":"value", ...}
	for(int i=0; i<array.size(); i++){
		JSONObject obj = (JSONObject)array.get(i);	//array의 요소 1개 리턴
		//obj.get("통화명"): json 형태의 key값으로 value 리턴
		if(obj.get("통화명").toString().equals("미국 USD")){	
			usd = Float.parseFloat(obj.get("매매기준율").toString());
			out.println("미국 USD:" + usd + "<br>");
		}
		else if(obj.get("통화명").toString().equals("일본 JPY 100")){
			jpy = Float.parseFloat(obj.get("매매기준율").toString());
			out.println("일본 JPY 100:" + jpy + "<br>");			
		}
		else if(obj.get("통화명").toString().equals("유로 EUR")){
			eur = Float.parseFloat(obj.get("매매기준율").toString());
			out.println("유로 EUR:" + eur + "<br>");			
		}
		else if(obj.get("통화명").toString().equals("중국 CNY")){
			cny = Float.parseFloat(obj.get("매매기준율").toString());
			out.println("중국 CNY:" + cny + "<br>");			
		}
	}
%>
</body>
</html>