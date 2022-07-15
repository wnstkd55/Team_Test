
var start_markerList = [];
var pass_markerList = [];
var end_markerList = [];

var pointArray = [];

var st_x;
var st_y;
var en_x;
var en_y;

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