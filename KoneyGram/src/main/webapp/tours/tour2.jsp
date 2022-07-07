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
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script	src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<link rel="stylesheet" href="/resources/css/style_auto2.css">
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
			<div class = "left_items">
				<h4>일정만들기</h4>
				<form name="make_sche" method="post">
					<input type="text" name="title" value="" placeholder="일정의 제목을 입력해주세요" >
					<br>
					<br>
					<h5>출발지 입력하기</h5>
					<input type = "text" id="dp_name" name="dp_name" value="" placeholder="출발지 입력을 위해 클릭해주세요" onclick="searchAddressd('S','1');">
					<input type = "hidden" id="dp_ny" name="dp_ny" value="">
					<input type = "hidden" id="dp_nx" name="dp_nx" value="">
					<button id = "dpointcheck" onclick="dpointCheck();">마커찍기</button>
					<button onClick="getRP()">경로요청 실행</button>
					<br>
					<br>
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
					<h5>관광지 입력하기</h5>
						<input type = "text" id="t_name" name = "tourname" value="" placeholder="관광지를 입력하세요">
							<a href="tourlist.jsp?c_name=<%=cityname %>" 
								onclick="window.open(this.href, '_blank', 'width=650, height=600'); return false;">
								관광리스트 보러가기
							</a>
						<input type = "hidden" id="t_ny" name="t_ny" value="">
						<input type = "hidden" id="t_nx" name="t_nx" value="">
					<br>
					<br>
					<h5>도착지 입력하기</h5>
					<input type = "text" id="ep_name" name="ep_name" value="" placeholder="도착지를 입력을 위해 클릭해주세요" onclick="searchAddresse('E','1');">
					<input type = "hidden" id="ep_ny" name="ep_ny" value="">
					<input type = "hidden" id="ep_nx" name="ep_nx" value="">
					<br>
					<br>
					<br>
					<br>
					<input type="textarea" name="memo" value="" placeholder="메모를 입력해주세요">
				</form>
			</div>
			<div class = "map">
				<div id = "map_div"></div>
			</div>
		</div>
	</div>
 	<script type="text/javascript">
 	
		let m_ny = <%=ny%>;
		let m_nx = <%=nx%>;
		
		
		/*
		
		$("#dp_ny").val();	<== 출발지점 위도
		$("#dp_nx").val();	<== 출발지점 경도
		
		$("#ep_ny").val();	<== 도착지점 위도
		$("#ep_nx").val();	<== 도착지점 경도
		
		*/
		
		var map;

		function initTmap(){
			map = new Tmapv2.Map("map_div",{
				center: new Tmapv2.LatLng(m_ny, m_nx),
				width : "800px",
				height : "942px",
				zoom: 10
			});
			
		};
		
		// 2. 시작, 도착 심볼찍기

		var markerList = [];
		var pointArray = [];
		
		function dpointCheck(){
			var st_ny = $("#dp_ny").val();
			var st_nx = $("#dp_nx").val();
			
			$.ajax({
				url: '/tour2.jsp',
				data: 'st_ny='+st_ny+'st_nx='+st_nx,
				type:'GET',
				dataType:'json',
				success:function(data){
					addMarker("llStart",st_nx,st_nx,1);
				},error:function(st_ny,st_nx){
					console.log(st_ny,st_nx);
				}
			});
		}
		
	/* 	function dpointCheck(){
			alert($("#dp_ny").val());
			alert($("#dp_nx").val());
			alert($("#t_ny").val());
			alert($("#t_nx").val());
			alert($("#ep_ny").val());
			alert($("#ep_nx").val());	
		} */
		
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
		
		
		/*주소 찾기 팝업창*/
		/*시작점 주소찾기*/
		function searchAddressd(status, idx){
			var pop1 = window.open("searchaddress_d.jsp?status="+status+"&idx="+idx,"pop1","width=600,height=670, scrollbars=yes, resizable=yes");
		
		
		}
		/*도착점 주소찾기*/
		function searchAddresse(status, idx){
			var pop2 = window.open("searchaddress_e.jsp?status="+status+"&idx="+idx,"pop2","width=600,height=670, scrollbars=yes, resizable=yes");
		}
		
	</script>

</body>
</html>
