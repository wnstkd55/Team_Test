<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <title>simpleMap</title>
        <script src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=l7xxdc2398be8423441f817695db47fd1e32"></script>
        <script type="text/javascript">
        function initTmap(){
        	var map = new Tmapv2.Map("map_div2",  
        	{
        		center: new Tmapv2.LatLng(${read.f_ny},${read.f_nx}), 
        		width: "890px",
        		height: "400px",
        		zoom: 15
        	});
        	 

        	var marker = new Tmapv2.Marker({
        		position: new Tmapv2.LatLng(${read.f_ny},${read.f_nx}),
        		map: map
        	});	
        }
		</script>
    </head>
    <body onload="initTmap()">
        <div id="map_div2">
        </div>        
    </body>
</html>	