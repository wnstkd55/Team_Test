/*
	lon => 경도(X)
	lat => 위도(Y)

*/

var map;	//지도
var markerInfo;	//마커 정보

var drawInfoArr = [];		
var drawInfoArr2 = [];

var chktraffic = [];
var resultdrawArr = [];
var resultMarkerArr = [];
var infoWindowArr = []; 

/*지도 띄우기*/
function initTmap() {
	map = new Tmapv2.Map("map_div", {
		center : new Tmapv2.LatLng(37.49241689559544, 127.03171389453507),
		width : "800px",
		height : "100%",
		zoom : 12,
		zoomControl : true,
		scrollwheel : true
	});
	
}

/* 관광지 지정*/
function setDestination(destAxisY, destAxisX, destTitle) {	//정보 받기
	var infoObj = {};
	infoObj.lon = destAxisX;		//정보창의 지도 경도x값
	infoObj.lat = destAxisY;		//정보창의 지도 위도 y값
	infoObj.pointNum = "0";			
	infoObj.infoWinTitle = destTitle;
	setPointSticky(infoObj);
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

/*관광지 리스트 보기*/
function tourlist(cityname){
	var pop = window.open("tourlist.jsp?c_name="+cityname,"pop","width=600, height=670, scrollbars=yes, resizable=yes");
}

/* 팝업창에서 콜백하기*/
function addrCallBack(roadFullAddr, latitude, longitude, status, idx){
   	var obj = $("#day_lst");
   	if($("#callpage").css('display') != "none") {
   		obj = $("dl.day_sc");
   	}

	var addrObj;
	if (status == "E") {
		addrObj = $(obj).find("input.arrival_word").eq(idx-1);
	} else {
		addrObj = $(obj).find("input.start_word").eq(idx-1);
	}
	addrObj.val(roadFullAddr);
	addrObj.attr('data-lat', latitude);
	addrObj.attr('data-lon', longitude);
	
   	if($("#callpage").css('display') == "none") {
		setPointAndDrawRoutes(latitude, longitude, status, idx);
	}
}

function setPointAndDrawRoutes(lat, lon, status, idx) {
	// console.log("setPointAndDrawRoutes.....");
	addMarkers({
		lng : lon,
		lat : lat,
		pointType : status
	});

	var startAddr = $("input.start_word").eq(idx-1).val();
	var endAddr = $("input.arrival_word").eq(idx-1).val();

	var axisObj = {};
	axisObj['startX'] = $("input.start_word").eq(idx-1).data('lon');
	axisObj['startY'] = $("input.start_word").eq(idx-1).data('lat');
	axisObj['endX'] = $("input.arrival_word").eq(idx-1).data('lon');
	axisObj['endY'] = $("input.arrival_word").eq(idx-1).data('lat');

	// if (status != "S" && startAxis && destAxis) {
	if (status == "E" && startAddr && endAddr) {

		var viaPoints = [];		
		var tab_con = $("#day_lst li div.tab_con").eq(idx-1);
		// tab_con.css("border", "1px solid red");
		// var item = tab_con.find('ul.tab_list li:not(.list-group-item)');
		var item = tab_con.find('ul.tab_list li:not(.list-group-item):not(.way-point-info)');
	    item.each(function(index) {
	    	var viaObj = {};
			var lat = $(this).data('lat');
			var lon = $(this).data('lon');

			var pointId = $(this).data('destid');

			viaObj['viaX'] = String(lon);
			viaObj['viaY'] = String(lat);
			viaObj['viaPointId'] = pointId;
			viaObj['viaPointName'] = pointId;

			viaPoints.push(viaObj);
	    });

		if(item.length > 0) {
			getRouteUsingViaPoints(axisObj, viaPoints, "Y"); 
		}

	} else {
		map.setCenter(new Tmapv2.LatLng(lat,lon));
		// map.setZoom(13);
	}
}

function setPointSticky(infoObj) {
	var lon = infoObj.lon;
	var lat = infoObj.lat;
	var pointType = infoObj.pointType;
	var pointNum = infoObj.pointNum;
	var infoWinTitle = infoObj.infoWinTitle;

	var markerParam = {
		lng : lon,
		lat : lat
	};
	if(pointNum) {
		markerParam.pointNum = pointNum;
	} else {
		markerParam.pointType = pointType;
	}
	
	addMarkers(markerParam);

	var tit = infoWinTitle;
	var content = "<div style='position: relative; border-bottom: 1px solid #dcdcdc; "+
				  "line-height: 18px; padding: 3px; width: 150px; height: auto; text-align:center;'>"+
				  "<span style='font-size: 12px; line-height: 15px;'>"+tit+"</span>"+
				  "</div>";
	//Popup
	var infoWindow = new Tmapv2.InfoWindow({
		position: new Tmapv2.LatLng(lat,lon), //
		content: content, //
		type: 2, //
		map: map //
	});
	infoWindowArr.push(infoWindow);

	map.setCenter(new Tmapv2.LatLng(lat,lon));
	
}
