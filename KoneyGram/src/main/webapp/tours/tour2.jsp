<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.text.ParseException"%>
<%@page import="java.lang.reflect.Array"%>
<%@ page import = "kr.co.city.City" %>
<%@ page import = "kr.co.city.CityDAO" %>
<%@ page import = "kr.co.tour.TourDAO" %>
<%@ page import = "kr.co.tour.Tour" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<script	src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<link rel="stylesheet" href="/resources/css/style_auto2.css">
<link rel="stylesheet" href="/resources/css/layout.css">
 <script src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=l7xx0027c9071859472394ee1ff449ed1fdf"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<meta charset="UTF-8">
<title>Insert title here</title>

	<style>
      .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        user-select: none;
      }

      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }
    </style>
</head>
<body onload="initTmap()">
	<%
		String cityname = request.getParameter("c_name");
		String ny = null;
		ny = request.getParameter("c_ny");
		String nx = null;
		nx = request.getParameter("c_nx");
		
		double m_ny = Double.parseDouble(ny);
		double m_nx = Double.parseDouble(nx);
	%>
<header>
  <div class="collapse bg-dark" id="navbarHeader">
    <div class="container">
      <div class="row">
        <div class="col-sm-8 col-md-7 py-4">
          <h4 class="text-white">About</h4>
          <p class="text-muted">Add some information about the album below, the author, or any other background context. Make it a few sentences long so folks can pick up some informative tidbits. Then, link them off to some social networking sites or contact information.</p>
        </div>
        <div class="col-sm-4 offset-md-1 py-4">
          <h4 class="text-white">Contact</h4>
          <ul class="list-unstyled">
            <li><a href="#" class="text-white">Follow on Twitter</a></li>
            <li><a href="#" class="text-white">Like on Facebook</a></li>
            <li><a href="#" class="text-white">Email me</a></li>
          </ul>
        </div>
      </div>
    </div>
  </div>
  <div class="navbar navbar-dark bg-dark shadow-sm">
    <div class="container">
      <a href="#" class="navbar-brand d-flex align-items-center">
        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" aria-hidden="true" class="me-2" viewBox="0 0 24 24"><path d="M23 19a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h4l2-3h6l2 3h4a2 2 0 0 1 2 2z"/><circle cx="12" cy="13" r="4"/></svg>
        <strong>Album</strong>
      </a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarHeader" aria-controls="navbarHeader" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
    </div>
  </div>
</header>	
  <section class="py-5 text-center container">
    <div class="row py-lg-5">
      <div class="col-lg-6 col-md-8 mx-auto">
        <h1 class="fw-light"><%=cityname %>지역에서 선택해 주세요!</h1>
        <p class="lead text-muted">관광지를 보여드립니다!</p>
      </div>
    </div>
  </section>
  <div class="container">
		<div class="contents">
			<div class = "left_items" style="width:100%;">
				<h4>일정만들기</h4>
				<div class ="make_sche">
				
					<input type="text" name="title" value="" placeholder="일정의 제목을 입력해주세요" >
					<br>
					<br>
					<h5>출발지 입력하기</h5>
					<input type = "text" id="dp_name" name="dp_name" value="" placeholder="출발지 입력을 위해 클릭해주세요" onclick="searchAddressd('S');">
					<input type = "hidden" id="dp_ny" name="dp_ny" value="">
					<input type = "hidden" id="dp_nx" name="dp_nx" value="">
					<button id = "dpointcheck" onclick="geoLocation('S')">현재내위치 찍기</button>
					<h5>관광지 입력하기</h5>
						<input type = "text" id="t_name1" name = "tourname" value="" placeholder="관광지를 입력하세요">
						<a href="tourlist.jsp?c_name=<%=cityname %>" 
							onclick="window.open(this.href, '_blank', 'width=650, height=600'); return false;">
							관광리스트 보러가기
						</a>
						<input type = "hidden" id="t_ny1" name="t_ny" value="">
						<input type = "hidden" id="t_nx1" name="t_nx" value="">
					<h5>관광지 입력하기</h5>
						<input type = "text" id="t_name" name = "tourname" value="" placeholder="관광지를 입력하세요">
						<a href="tourlist.jsp?c_name=<%=cityname %>" 
							onclick="window.open(this.href, '_blank', 'width=650, height=600'); return false;">
							관광리스트 보러가기
						</a>
						<input type = "hidden" id="t_ny" name="t_ny" value="">
						<input type = "hidden" id="t_nx" name="t_nx" value="">
					<h5>관광지 입력하기</h5>
						<input type = "text" id="t_name" name = "tourname" value="" placeholder="관광지를 입력하세요">
							<a href="tourlist.jsp?c_name=<%=cityname %>" 
								onclick="window.open(this.href, '_blank', 'width=650, height=600'); return false;">
								관광리스트 보러가기
							</a>
							<input type = "hidden" id="t_ny" name="t_ny" value="">
							<input type = "hidden" id="t_nx" name="t_nx" value="">
					<h5>관광지 입력하기</h5>
						<input type = "text" id="t_name" name = "tourname" value="" placeholder="관광지를 입력하세요">
							<a href="tourlist.jsp?c_name=<%=cityname %>" 
								onclick="window.open(this.href, '_blank', 'width=650, height=600'); return false;">
								관광리스트 보러가기
							</a>
						<input type = "hidden" id="t_ny" name="t_ny" value="">
						<input type = "hidden" id="t_nx" name="t_nx" value="">
					<h5>관광지 입력하기</h5>
						<input type = "text" id="t_name" name = "tourname" value="" placeholder="관광지를 입력하세요">
							<a href="tourlist.jsp?c_name=<%=cityname %>" 
								onclick="window.open(this.href, '_blank', 'width=650, height=600'); return false;">
								관광리스트 보러가기
							</a>
						<input type = "hidden" id="t_ny" name="t_ny" value="">
						<input type = "hidden" id="t_nx" name="t_nx" value="">
					<h5>도착지 입력하기</h5>
					<input type = "text" id="ep_name" name="ep_name" value="" placeholder="도착지를 입력을 위해 클릭해주세요" onclick="searchAddresse('E');">
					<input type = "hidden" id="ep_ny" name="ep_ny" value="">
					<input type = "hidden" id="ep_nx" name="ep_nx" value="">
					<br>
					<br>
					<br>
					<br>
					<textarea name="memo" placeholder="메모를 입력해주세요"></textarea>
					<button onclick="markerInfo();">마커정보 보기</button>
					<button onclick="removeMarker();"> 마커 지우기</button>
					
				</div>
			</div>
			<div class = "map">
				<%-- <jsp:include page="tour3.jsp" flush="false"></jsp:include> --%>
				<div id = "map_div"></div>
			</div>
		</div>
	</div>
 	<script type="text/javascript">
 	
 		let m_ny = <%=ny%>;
		let m_nx = <%=nx%>;
		
		var start_markerList = [];
		var pass_markerList = [];
		var end_markerList = [];
		
		var pointArray = [];
		
		var st_x;
		var st_y;
		var en_x;
		var en_y;
		
	 	var map;
		/*지도 실행하기(시작)*/
		function initTmap(){
			map = new Tmapv2.Map("map_div",{
				center:	 new Tmapv2.LatLng(m_ny, m_nx),
				width : "800px",
				height : "942px",
				zoom: 10
			});
		};
		/*지도 실행하기(끝)*/
		
		/*나의 위치찍기(시작)*/
		function geoLocation(location) {
		    navigator.geolocation.getCurrentPosition(function(position){
		        // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
		        lat = position.coords.latitude; // 위도
		        lon = position.coords.longitude; // 경도

		        console.log(lat);
		        console.log(lon);
		        
		        if(location == "S"){
		        	removeMarker_s();
		        	addMarker_s('S', lon, lat,1);
		        	map.setCenter(new Tmapv2.LatLng(lat,lon));
		        	st_x = lon;
		        	st_y = lat;
		        	
		        }
		        else if(location == "E"){
		        	removeMarker_e();
		        	addMarker_e("E",lon,lat,2);
		        	map.setCenter(new Tmapv2.LatLng(lat,lon));
		        	en_x = lon;
		        	en_y = lat;
		        }
		    });
		};
		/*나의 위치찍기(끝)*/
		
		/*주소 팝업창에서 마크찍기(시작)*/
		function popAddress(status,lon,lat){
			if(status == "S"){
				removeMarker_s();
	        	addMarker_s('S', lon, lat,1);
	        	map.setCenter(new Tmapv2.LatLng(lat,lon));
	        	st_x = lon;
	        	st_y = lat;
	        	console.log(st_x);
	        	console.log(st_y);
	        }
	        else if(status == "E"){
	        	removeMarker_e();
	        	addMarker_e('E',lon,lat,2);
	        	map.setCenter(new Tmapv2.LatLng(lat,lon));
	        	en_x = lon;
	        	en_y = lat;
	        	console.log(en_x);
	        	console.log(en_y);
	        }else{
	        	alert("오류가 발생했습니다.")
	        }
		}
		
		/*주소 팝업창에서 마크찍기(끝)*/
		
		/*관광지 마커 찍기 시작*/
		function TourMarker(lon, lat){
			console.log(lon);
			console.log(lat);
			addMarker_p('P', lon, lat, 3);
			map.setCenter(new Tmapv2.LatLng(lat,lon));
		};
		/*관광지 마커 찍기 끝*/
		
		
		/*마커 찍기(시작)*/
		function addMarker_s(status, lon, lat, tag) {
			//출도착경유구분
			//이미지 파일 변경.
			
			var marker_s = new Tmapv2.Marker({
				position: new Tmapv2.LatLng(lat,lon),
				icon: 'http://tmapapi.sktelecom.com/upload/tmap/marker/pin_r_m_s.png',
				map: map
			});
			
			start_markerList[tag] = marker_s;
		}
		
		function addMarker_p(status, lon, lat, tag) {
				//출도착경유구분
				//이미지 파일 변경.
				
				var marker_p = new Tmapv2.Marker({
					position: new Tmapv2.LatLng(lat,lon),
					icon: 'http://tmapapi.sktelecom.com/upload/tmap/marker/pin_b_m_p.png',
					map: map
				});
				pass_markerList[tag] = marker_p;
		}
		
		function addMarker_e(status, lon, lat, tag) {
					//출도착경유구분
				
					var marker_e = new Tmapv2.Marker({
						position: new Tmapv2.LatLng(lat,lon),
						icon: 'http://tmapapi.sktelecom.com/upload/tmap/marker/pin_r_m_e.png',
						map: map
			});
		/* 	// 마커 드래그 설정
			marker.tag = tag;
			marker.addListener("dragend", function (evt) {
			markerListenerEvent(evt);
		    });
		    marker.addListener("drag", function (evt) {    	
		    	markerObject = markerList[tag];
		    });
		    markerList[tag] = marker;
			return marker; */
			end_markerList[tag] = marker_e;
		}
		
		
		/*주소 찾기 팝업창*/
		/*시작점 주소찾기*/
		function searchAddressd(status){
			var pop1 = window.open("searchaddress_d.jsp","pop1","width=600,height=670, scrollbars=yes, resizable=yes");
			
		}
		/*도착점 주소찾기*/
		function searchAddresse(status){
			var pop2 = window.open("searchaddress_e.jsp","pop2","width=600,height=670, scrollbars=yes, resizable=yes");

			}
		
		function removeMarker_s(){
			if(start_markerList.length>0){
				for(var i in start_markerList){
					start_markerList[i].setMap(null);
				}
				
				start_markerList = [];
			}
		}
		
		function removeMarker_p(){
			if(pass_markerList.length>0){
				for(var i in pass_markerList){
					pass_markerList[i].setMap(null);
				}
				pass_markerList=[];
			
			}
		}
		
		function removeMarker_e(){
			if(end_markerList.length>0){
				for(var i in end_markerList){
					end_markerList[i].setMap(null);
				}
				end_markerList=[];
			}
		}
		
		function markerInfo(){
			for(var i=0; i<start_markerList.legth; i++){
				console.log(start_markerList[i]);
			}
		}
		
		function removeMarker(){
			if(markerList.length>0){
				for(var i in markerList){
					markerList[i].setMap(null);
				}
				document.getElementById('dp_name').value = null;
				document.getElementById('dp_ny').value = null;
				document.getElementById('dp_nx').value = null;
				
			}
		}
		
	</script>

</body>
</html>
