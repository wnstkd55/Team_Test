<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.text.ParseException"%>
<%@page import="java.lang.reflect.Array"%>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script	src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<link rel="stylesheet" href="resources/css/style_auto2.css">
<script src = "resources/js/auto3.js"></script>
<script src = "resources/js/map.js"></script>
<script src = "resources/js/mapedit.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
<link rel='stylesheet' href="https://cdn.datatables.net/responsive/1.0.4/css/dataTables.responsive.css">
<link rel='stylesheet' href="https://https://cdn.datatables.net/1.12.1/css/dataTables.bootstrap5.min.css">
<script src='https://cdn.datatables.net/1.10.5/js/jquery.dataTables.min.js'></script>
<script src='https://cdn.datatables.net/plug-ins/f2c75b7247b/integration/bootstrap/3/dataTables.bootstrap.js'></script>
<script src='https://cdn.datatables.net/responsive/1.0.4/js/dataTables.responsive.js'></script>
<script src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=l7xx0027c9071859472394ee1ff449ed1fdf"></script><meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body onload="initTmap()">

	        <script type="text/javascript">
				
			var map;
			
			var marker_s, marekr_e, waypoint;
			var resultMarkerArr = [];
			//경로그림정보
			var drawInfoArr = [];
			var resultInfoArr = [];
			
			function initTmap(){
				resultMarkerArr = [];
				
			 	// 1. 지도 띄우기
				map = new Tmapv2.Map("map_div", {
					center: new Tmapv2.LatLng(37.405278291509404, 127.12074279785197),
					width : "100%",
					height : "400px",
					zoom : 14,
					zoomControl : true,
					scrollwheel : true
					
				});
		</script>
		
		<div id="map_div">
	    	
	    </div>
	    
	    
		
</body>
</html>
