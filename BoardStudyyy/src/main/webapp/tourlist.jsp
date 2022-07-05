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
<script src = "js/map.js"></script>
<script src = "js/mapedit.js"></script>
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
	body { 
	  font-size: 25px; 
	}
	
	h2 {
	  text-align: center;
	  padding: 20px 0;
	}
	
	table caption {
	  padding: .5em 0;
	}
	
	table.dataTable th,
	table.dataTable td {
	  white-space: nowrap;
	}
	
	.p {
	  text-align: center;
	  padding-top: 140px;
	  font-size: 14px;
	}
    </style>
</head>
<body>
	<%
		String cityname = request.getParameter("c_name");
	%>
	

<div class="container">
<h2>관광지 리스트</h2>
  <div class="row">
    <div class="col-xs-12">
      <table class="table table-bordered table-hover dt-responsive">
        <thead>
          <tr>
            <th>관광지명</th>
            <th>관광지사진</th>
            <th>관광지 전화번호</th>
            <th>버튼 추가</th>
            <th>관광지 설명</th>
          </tr>
        </thead>
        <tbody>
        <%
        
        	TourDAO tourdao = new TourDAO();
        	ArrayList<Tour> tlist = tourdao.SelectCity_T(cityname);
        	for(int i=0; i<tlist.size(); i++){
        		
        %>
          <tr>
            <td><%=tlist.get(i).getT_name() %></td>
            <td><img src="images/tour_pic/<%=tlist.get(i).getT_photo() %>" width=100 height=100></td>
            <td><%=tlist.get(i).getT_tel() %></td>
            <td><button type = "button" >+</button></td>
            <td><%=tlist.get(i).getT_intro() %></td>
          </tr>
		<%
        	}
		%>
      </table>
    </div>
  </div>
</div>

      <script id="rendered-js" >
	$('table').DataTable();

    </script>

</html>
