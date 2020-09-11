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
<title>JSON ������ ó���ϱ�</title>
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
	//JSONParser: JSON�� �����ϴ� ��Ȱ�� ���� 
	JSONParser jsonParser = new JSONParser();
	JSONArray array = (JSONArray)jsonParser.parse(strJson);	//JSON��ü����
	float usd = 0f;
	float jpy = 0f;
	float eur = 0f;
	float cny = 0f;
	
	//JSONObject: json ������ ��ü. {"Ű":"value", ...}
	for(int i=0; i<array.size(); i++){
		JSONObject obj = (JSONObject)array.get(i);	//array�� ��� 1�� ����
		//obj.get("��ȭ��"): json ������ key������ value ����
		if(obj.get("��ȭ��").toString().equals("�̱� USD")){	
			usd = Float.parseFloat(obj.get("�Ÿű�����").toString());
			out.println("�̱� USD:" + usd + "<br>");
		}
		else if(obj.get("��ȭ��").toString().equals("�Ϻ� JPY 100")){
			jpy = Float.parseFloat(obj.get("�Ÿű�����").toString());
			out.println("�Ϻ� JPY 100:" + jpy + "<br>");			
		}
		else if(obj.get("��ȭ��").toString().equals("���� EUR")){
			eur = Float.parseFloat(obj.get("�Ÿű�����").toString());
			out.println("���� EUR:" + eur + "<br>");			
		}
		else if(obj.get("��ȭ��").toString().equals("�߱� CNY")){
			cny = Float.parseFloat(obj.get("�Ÿű�����").toString());
			out.println("�߱� CNY:" + cny + "<br>");			
		}
	}
%>
</body>
</html>