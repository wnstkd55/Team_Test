<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.text.ParseException"%>
<%@page import="java.lang.reflect.Array"%>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://apis.openapi.sk.com/tmap/js?version=1&format=javascript&appKey=l7xx8273ff92f5154745bb4d862b64138e57"></script>
<title>Insert title here</title>

</head>

<body onload="initTmap()">


	<div id="map_div">
		    	
    
</div>
		
		
<script>

function initTmap(){
	// map 생성
	// Tmap.map을 이용하여, 지도가 들어갈 div, 넓이, 높이를 설정합니다.
	map = new Tmap.Map({div:'map_div', // map을 표시해줄 div
							width:'800px',  // map의 width 설정
							height:'400px' // map의 height 설정
	}); 
} 

</script>
				
</body>
</html>
