<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.text.ParseException"%>
<%@page import="java.lang.reflect.Array"%>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.util.List" %>
<%@ page import = "kr.co.city.City" %>
<%@ page import = "kr.co.city.CityDAO" %>
<%@ page import = "kr.co.tour.TourDAO" %>
<%@ page import = "kr.co.tour.Tour" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://apis.openapi.sk.com/tmap/js?version=1&format=javascript&appKey=l7xx0027c9071859472394ee1ff449ed1fdf"></script>
<title>Insert title here</title>

</head>

<body onload="initTmap()">
	<%
		String cityname = request.getParameter("c_name");
		String ny = null;
		ny = request.getParameter("c_ny");
		String nx = null;
		nx = request.getParameter("c_nx");
		
	%>

	<div id="map_div">
	</div>
		
		
<script>

function initTmap(){
	
	let m_ny = <%=ny%>;
	let m_nx = <%=nx%>;
	
	// 1. 지도 띄우기
	map = new Tmapv2.Map("map_div", {
		center: new Tmapv2.LatLng(m_ny,m_nx),
		width: "800px",
		height: "942px",
		zoom: 10
	});


	// 2. 시작, 도착 심볼찍기

	var markerList = [];
	var pointArray = [];

		// 시작
		addMarker("llStart",127.02810900563199,37.519892712436906,1);
		// 도착 
		addMarker("llEnd",127.11971717230388,37.49288934463672,2);
		function addMarker(status, lon, lat, tag) {
		//출도착경유구분
		//이미지 파일 변경.
		var markerLayer;
		switch (status) {
			case "llStart":
				imgURL = 'http://tmapapi.sktelecom.com/upload/tmap/marker/pin_r_m_s.png';
				break;
			case "llPass":
				imgURL = 'http://tmapapi.sktelecom.com/upload/tmap/marker/pin_b_m_p.png';
				break;
			case "llEnd":
				imgURL = 'http://tmapapi.sktelecom.com/upload/tmap/marker/pin_r_m_e.png';
				break;
			default:
		};
		var marker = new Tmapv2.Marker({
			position: new Tmapv2.LatLng(lat,lon),
			icon: imgURL,
			map: map
		});
		// 마커 드래그 설정
		marker.tag = tag;
		marker.addListener("dragend", function (evt) {
		markerListenerEvent(evt);
	    });
	    marker.addListener("drag", function (evt) {    	
	    	markerObject = markerList[tag];
	    });
	    markerList[tag] = marker;
		return marker;
	}

}

	</script>
					
				
</body>
</html>
