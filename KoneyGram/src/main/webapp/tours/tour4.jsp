<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.text.ParseException"%>
<%@page import="java.lang.reflect.Array"%>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
 <script src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=l7xx0027c9071859472394ee1ff449ed1fdf"></script>
<title>Insert title here</title>

</head>

<body onload="initTmap()">
	<div id="map_div">
	</div>
<script>

function initTmap(){
	// map 생성
	// Tmap.map을 이용하여, 지도가 들어갈 div, 넓이, 높이를 설정합니다.
			map = new Tmapv2.Map("map_div", {
			center: new Tmapv2.LatLng(37.52084364186228,127.058908811749),
			width: "800px",
			height: "400px"
		});
	}
	

</script>
				
</body>
</html>
