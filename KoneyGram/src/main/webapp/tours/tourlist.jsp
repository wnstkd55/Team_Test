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
.responsive-table {
  width: 100%;
  margin-bottom: 1.5em;
}
.responsive-table thead {
  position: absolute;
  clip: rect(1px 1px 1px 1px);
  /* IE6, IE7 */
  clip: rect(1px, 1px, 1px, 1px);
  padding: 0;
  border: 0;
  height: 1px;
  width: 1px;
  overflow: hidden;
}
.responsive-table thead th {
  background-color: #1d96b2;
  border: 1px solid #1d96b2;
  font-weight: normal;
  text-align: center;
  color: white;
}
.responsive-table thead th:first-of-type {
  text-align: left;
}
.responsive-table tbody,
.responsive-table tr,
.responsive-table th,
.responsive-table td {
  display: block;
  padding: 0;
  text-align: left;
  white-space: normal;
}
.responsive-table th,
.responsive-table td {
  padding: .5em;
  vertical-align: middle;
}
.responsive-table caption {
  margin-bottom: 1em;
  font-size: 1em;
  font-weight: bold;
  text-align: center;
}
.responsive-table tfoot {
  font-size: .8em;
  font-style: italic;
}
.responsive-table tbody tr {
  margin-bottom: 1em;
  border: 2px solid #1d96b2;
}
.responsive-table tbody tr:last-of-type {
  margin-bottom: 0;
}
.responsive-table tbody th[scope="row"] {
  background-color: #1d96b2;
  color: white;
}
.responsive-table tbody td[data-type=currency] {
  text-align: right;
}
.responsive-table tbody td[data-title]:before {
  content: attr(data-title);
  float: left;
  font-size: .8em;
  color: rgba(94, 93, 82, 0.75);
}
.responsive-table tbody td {
  text-align: right;
  border-bottom: 1px solid #1d96b2;
}


@media (min-width: 52em) {
  .responsive-table {
    font-size: .9em;
  }
  .responsive-table thead {
    position: relative;
    clip: auto;
    height: auto;
    width: auto;
    overflow: auto;
  }
  .responsive-table tr {
    display: table-row;
  }
  .responsive-table th,
  .responsive-table td {
    display: table-cell;
    padding: .5em;
  }

  .responsive-table caption {
    font-size: 1.5em;
  }
  .responsive-table tbody {
    display: table-row-group;
  }
  .responsive-table tbody tr {
    display: table-row;
    border-width: 1px;
  }
  .responsive-table tbody tr:nth-of-type(even) {
    background-color: rgba(94, 93, 82, 0.1);
  }
  .responsive-table tbody th[scope="row"] {
    background-color: transparent;
    color: #5e5d52;
    text-align: left;
  }
  .responsive-table tbody td {
    text-align: center;
  }
  .responsive-table tbody td[data-title]:before {
    content: none;
  }
}
@media (min-width: 62em) {
  .responsive-table {
    font-size: 1em;
  }
  .responsive-table th,
  .responsive-table td {
    padding: .75em .5em;
  }
  .responsive-table tfoot {
    font-size: .9em;
  }
}

@media (min-width: 75em) {
  .responsive-table th,
  .responsive-table td {
    padding: .75em;
  }
}
</style>
</head>
<body>
	<%
		String cityname = request.getParameter("c_name");
		String tag = request.getParameter("tag");
	%>
	<br>
	<h5 style="text-align: center;">지역 관광지 리스트</h5>
 	<br>
 <table class="responsive-table">
    <thead>
      <tr>
      	<th scope="col">관광지명</th>
        <th scope="col">관광지사진</th>
        <th scope="col">관광지명주소(도로명)</th>
        <th scope="col">관광지명주소(지번)</th>
        <th scope="col">관광지 소개</th>
        <th scope="col">전화 번호</th>
        <th scope="col">관광루트로 지정</th>
        <th scope="col" style="display:none">dd</th>
        <th scope="col" style="display:none">dd</th>
      </tr>
    </thead>
    <tbody>
   	 <%
      	TourDAO tourdao = new TourDAO();
      	ArrayList<Tour> tlist = tourdao.SelectCity_T(cityname);
      	
      	for(int i=0; i<tlist.size(); i++){
      %>
	      <tr>
	        <th scope="row" id="t_name"><%=tlist.get(i).getT_name() %></th>
	        <td data-title="사진"><img src="/resources/images/tour_pic/<%=tlist.get(i).getT_photo() %>" width=100 height=100></td>
	        <td data-title="도로명주소"><%=tlist.get(i).getT_loadaddress() %></td>
	        <td data-title="지번 주소" data-type="currency"><%=tlist.get(i).getT_gnumaddress() %></td>
	        <td data-title="간단소개" data-type="currency"><%=tlist.get(i).getT_intro() %></td>
	        <td data-title="전화번호" data-type="currency"><%=tlist.get(i).getT_tel() %></td>
	      	<td data-title="관광지로 지정"><button onclick="selectTour('<%=tlist.get(i).getT_name() %>',<%=tlist.get(i).getT_ny() %>,<%=tlist.get(i).getT_nx() %>);">추가하기</button></td>
	      	<td data-title="관광지 위도" id="t_ny" style="display:none"><%=tlist.get(i).getT_ny() %></td>
	      	<td data-title="관광지 경도" id="t_nx" style="display:none"><%=tlist.get(i).getT_nx() %></td>
	      </tr>
      <%
      	}
      %>
    </tbody>
  </table>	



    <script>
    
    var tag = <%=tag%>;
    
	function selectTour(tourname,latitude,longitude){
		
		if(tag == '1'){
		
			window.opener.document.getElementById('t_name1').value = tourname;
			window.opener.document.getElementById('t_ny1').value = latitude;	//위도
			window.opener.document.getElementById('t_nx1').value = longitude;	//경도
			
			window.opener.TourMarker1(longitude,latitude);
			
			window.close();
			
		}else if(tag == '2'){
			window.opener.document.getElementById('t_name2').value = tourname;
			window.opener.document.getElementById('t_ny2').value = latitude;	//위도
			window.opener.document.getElementById('t_nx2').value = longitude;	//경도
			
			window.opener.TourMarker2(longitude,latitude);
			
			window.close();
		}
		
		window.opener.TourMarker(longitude,latitude);
		
		window.close();
	}
	
	
    </script>
 </body>
</html>