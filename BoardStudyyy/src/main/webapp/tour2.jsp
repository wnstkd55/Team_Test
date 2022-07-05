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
<link rel="stylesheet" href="resources/css/style_auto2.css">
<script src = "resources/js/auto3.js"></script>
<script src = "resources/js/map.js"></script>
<script src = "resources/js/mapedit.js"></script>
 <script src="https://apis.openapi.sk.com/tmap/js?version=1&format=javascript&appKey=l7xx0027c9071859472394ee1ff449ed1fdf"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
<link rel='stylesheet' href="https://cdn.datatables.net/responsive/1.0.4/css/dataTables.responsive.css">
<link rel='stylesheet' href="https://https://cdn.datatables.net/1.12.1/css/dataTables.bootstrap5.min.css">
<script src='https://cdn.datatables.net/1.10.5/js/jquery.dataTables.min.js'></script>
<script src='https://cdn.datatables.net/plug-ins/f2c75b7247b/integration/bootstrap/3/dataTables.bootstrap.js'></script>
<script src='https://cdn.datatables.net/responsive/1.0.4/js/dataTables.responsive.js'></script>
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
					<input type = "text" id="dp_name" name="start_point" value="" placeholder="출발지 입력을 위해 클릭해주세요" onclick="searchAddress('S','1');">
					<input type = "hidden" id="dp_ny" value="">
					<input type = "hidden" id="dp_nx" value="">
					<br>
					<br>
					<h5>관광지 입력하기</h5>
					<input type = "text" name = "tourname" value="" placeholder="관광지를 입력하세요">
					<a href="tourlist.jsp?c_name=<%=cityname %>" 
						onclick="window.open(this.href, '_blank', 'width=800, height=600'); return false;">
						관광리스트 보러가기
					</a>
						<h5>관광지 입력하기</h5>
					<input type = "text" name = "tourname" value="" placeholder="관광지를 입력하세요">
					<a href="tourlist.jsp?c_name=<%=cityname %>" 
						onclick="window.open(this.href, '_blank', 'width=800, height=600'); return false;">
						관광리스트 보러가기
					</a>
						<h5>관광지 입력하기</h5>
					<input type = "text" name = "tourname" value="" placeholder="관광지를 입력하세요">
					<a href="tourlist.jsp?c_name=<%=cityname %>" 
						onclick="window.open(this.href, '_blank', 'width=800, height=600'); return false;">
						관광리스트 보러가기
					</a>
						<h5>관광지 입력하기</h5>
					<input type = "text" name = "tourname" value="" placeholder="관광지를 입력하세요">
					<a href="tourlist.jsp?c_name=<%=cityname %>" 
						onclick="window.open(this.href, '_blank', 'width=800, height=600'); return false;">
						관광리스트 보러가기
					</a>
						<h5>관광지 입력하기</h5>
					<input type = "text" name = "tourname" value="" placeholder="관광지를 입력하세요">
					<a href="tourlist.jsp?c_name=<%=cityname %>" 
						onclick="window.open(this.href, '_blank', 'width=800, height=600'); return false;">
						관광리스트 보러가기
					</a>
					<br>
					<br>
					<h5>도착지 입력하기</h5>
					<input type = "text" name="start_point" value="" placeholder="도착지를 입력을 위해 클릭해주세요" onclick="searchAddress('S','1');">
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
		var map;

		function initTmap(){
			map = new Tmap.Map({
				div:'map_div',
				width : "800px",
				height : "942px"
			});
			
			map.setCenter(new Tmap.LonLat(m_nx, m_ny).transform("EPSG:4326", "EPSG:3857"), 10);
		}
		
		function getaddressInfo(roadFullAddr, latitude, longitude){
			document.getElementById(roadFullAddr).value
		}
		
	</script>

</body>
</html>
