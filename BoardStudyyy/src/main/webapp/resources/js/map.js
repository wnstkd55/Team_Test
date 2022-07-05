/******** t_map 자바스크립트 끌어쓰기 *********/

/*
	lon => 경도(X)
	lat => 위도(Y)

*/



/* 경로 추출*/
function getRouteUsingViaPoints(axisObj, viaPoints, trafficInfo) {

	var apiUrl = "https://apis.openapi.sk.com/tmap/routes?version=1&format=json&callback=result";
	var routeLayer; 

	var startX = axisObj.startX;
	var startY = axisObj.startY;
	var endX = axisObj.endX;
	var endY = axisObj.endY;

	var headers = {}; 
	headers["appKey"] = appKey;
	headers["Content-Type"] = "application/json";

	var searchOption = 0;	//경로 옵션

	// var trafficInfochk = "Y"; //(교통량 측정 - Y/N)
	var trafficInfochk = trafficInfo; //(교통량 측정 - Y/N)
	
	var passList = "";
	for (var i=0; i < viaPoints.length; i++) {
		if(i > 0) {
			passList += "_";
		}
		passList += viaPoints[i].viaX + "," + viaPoints[i].viaY;
	}
	// console.log(passList);

	var paramObj = {
		"startName" : "시작지점",
		"startX" : String(startX),
		"startY" : String(startY),
		"startTime" : "201708081103",
		"endName" : "도착지점",
		"endX" : String(endX),
		"endY" : String(endY),
		"passList" : passList,
		"reqCoordType" : "WGS84GEO",
		"resCoordType" : "EPSG3857",
		"searchOption" : searchOption,
		"trafficInfo" : trafficInfochk
	};
	paramObj.viaPoints = viaPoints;
	var param = JSON.stringify(paramObj);
	// console.dir(param);

	$.ajax({
		method:"POST",
		url : apiUrl,
		headers : headers,
		async:false,
		data:param,
		beforeSend: function() {
			// console.log("beforeSend....");
			if($('#wrap_loading').length > 0) {
				$('#wrap_loading').removeClass('display-none');
			}
		},
		success:function(response){
			// console.log("success....");
			// console.log(response);
			if(typeof response == "undefined") {
				return;
			}
			var resultData = response.properties;
			var resultFeatures = response.features;
			
			// 결과 출력
			var tDistance = "총 거리 : " + (resultFeatures[0].properties.totalDistance / 1000).toFixed(1) + "km";
			var tTime = "총 시간 : " + (resultFeatures[0].properties.totalTime / 60).toFixed(0) + "분";
			var tFare = "총 요금 : " + resultFeatures[0].properties.totalFare + "원";
			var taxiFare = "총 택시 요금 : " + resultFeatures[0].properties.taxiFare+ "원";
			
			// $("#result").text(tDistance+tTime+tFare);
			if($("#callpage").css('display') != "none") {
				var el = "<div class=\"routes-info-mobile\">"+"<span>"+tDistance+"</span>" + "<span>"+tTime+"</span>" + "<span>" +taxiFare+ "</span>" +"</li>";
				$("#map_mob_wrap").prepend(el);
			} else {
				var el = "<div class=\"routes-info\">"+"<span>"+tDistance+"</span>" + "<span>"+tTime+"</span>" + "<span>" +numberWithCommas(taxiFare)+ "</span>" +"</li>";
				$("#map_wrap").append(el);
			}
			//기존라인 초기화
			clearMap();
			
			if (trafficInfochk == "Y") {
				for ( var i in resultFeatures) { 
					var geometry = resultFeatures[i].geometry;
					var properties = resultFeatures[i].properties;

					if (geometry.type == "LineString") {
						checkTraffic.push(geometry.traffic);
						var sectionInfos = [];
						var trafficArr = geometry.traffic;

						for ( var j in geometry.coordinates) {
							// 경로들의 결과값(구간)들을 포인트 객체로 변환 
							var latlng = new Tmapv2.Point(geometry.coordinates[j][0],geometry.coordinates[j][1]);
							// 포인트 객체를 받아 좌표값으로 변환
							var convertPoint = new Tmapv2.Projection.convertEPSG3857ToWGS84GEO(latlng);
							// 포인트객체의 정보로 좌표값 변환 객체로 저장
							sectionInfos.push(convertPoint);
						}

						drawLine(sectionInfos,trafficArr);

					} else {
						// var markerImg = "";
						var pType = "";

						if (properties.pointType == "S") { //시작지점
							// markerImg = "http://tmapapis.sktelecom.com/upload/tmap/marker/pin_r_m_s.png";
							pType = "S";
						} else if (properties.pointType == "E") { //경유지
							// markerImg = "http://tmapapis.sktelecom.com/upload/tmap/marker/pin_r_m_e.png";
							pType = "E";
						} else { //도착지점
							// markerImg = "http://topopen.tmap.co.kr/imgs/point.png";
							pType = "P"
						}
						// 경로들의 결과값들을 포인트 객체로 변환 
						var latlon = new Tmapv2.Point(geometry.coordinates[0],geometry.coordinates[1]);
						// 포인트 객체를 받아 좌표값으로 다시 변환
						var convertPoint = new Tmapv2.Projection.convertEPSG3857ToWGS84GEO(latlon);

						// 마커생성
						addMarkers({
							// markerImage : markerImg,
							lng : convertPoint._lng,
							lat : convertPoint._lat,
							pointType : pType
						});
					}
				}//for 종료

			} else {

				for ( var i in resultFeatures) { //for 시작
					var geometry = resultFeatures[i].geometry;
					var properties = resultFeatures[i].properties;

					if (geometry.type == "LineString") {
						for ( var j in geometry.coordinates) {
							
							var latlng = new Tmapv2.Point(geometry.coordinates[j][0],geometry.coordinates[j][1]);
							// 경로들의 결과값(구간)들을 포인트 객체로 변환 
							var convertPoint = new Tmapv2.Projection.convertEPSG3857ToWGS84GEO(latlng);
							// 포인트 객체를 받아 좌표값으로 변환
							var convertChange = new Tmapv2.LatLng(convertPoint._lat,convertPoint._lng);
							// 포인트객체의 정보로 좌표값 변환 객체로 저장
							drawInfoArr.push(convertChange);
						}
						drawLine(drawInfoArr,"0");
					} else {
						// var markerImg = "";
						var pType = "";

						if (properties.pointType == "S") { //출발지점
							// markerImg = "http://tmapapis.sktelecom.com/upload/tmap/marker/pin_r_m_s.png";
							pType = "S";
						} else if (properties.pointType == "E") { //경유지점
							// markerImg = "http://tmapapis.sktelecom.com/upload/tmap/marker/pin_r_m_e.png";
							pType = "E";
						} else { //도착지점
							// markerImg = "http://topopen.tmap.co.kr/imgs/point.png";
							pType = "P"
						}

						// 경로들의 결과값들을 포인트 객체로 변환 
						var latlon = new Tmapv2.Point(geometry.coordinates[0],geometry.coordinates[1]);
						// 포인트 객체를 받아 좌표값으로 다시 변환
						var convertPoint = new Tmapv2.Projection.convertEPSG3857ToWGS84GEO(latlon);

						// Marker 추가
						addMarkers({
							// markerImage : markerImg,
							lng : convertPoint._lng,
							lat : convertPoint._lat,
							pointType : pType
						});
					}
				}//for臾� [E]
			}
			// 寃쎈줈 諛섏쁺 吏��� DP 理쒖쟻�� -- �대룞嫄곕━媛� 湲� 寃쎌슦 �쒓퀎媛� �덈떎.
			PTbounds = new Tmapv2.LatLngBounds();
			var startPt = new Tmapv2.LatLng(startY,startX);
			PTbounds.extend(startPt);
			//寃쎌쑀吏� 留덉빱 �덈줈 洹몃━湲�
			for (var i=0; i < viaPoints.length; i++) {
				// console.log("寃쎌쑀吏� " + (i+1) + " : "+ viaPoints[i].viaX + ", " + viaPoints[i].viaY);
				addMarkers({
					lng : viaPoints[i].viaX,
					lat : viaPoints[i].viaY,
					pointType : "P",
					pointNum : i + 1
				});
				PTbounds.extend(new Tmapv2.LatLng(viaPoints[i].viaY,viaPoints[i].viaX));
			}
			var endPt = new Tmapv2.LatLng(endY,endX);
			PTbounds.extend(endPt);
			map.fitBounds(PTbounds);
			// map.setCenter(new Tmapv2.LatLng(String(startY),String(startX)));
			// map.setZoom(12);
		},
		complete: function(){
			// console.log("complete....");
			if($('#wrap_loading').length > 0) {
				$('#wrap_loading').addClass('display-none');
			}
		},
		error:function(request,status,error){
			// console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});

}

/** �ㅼ쨷 寃쎌쑀吏� 30 - 臾대즺�쒕퉬�ㅼ뿉�� �쇱씪�몃옒�� 100嫄� �쒗븳 **/
function getRouteSequential(axisObj, viaPoints) {
	
	var apiUrl = "https://apis.openapi.sk.com/tmap/routes/routeSequential30?version=1&format=json";
	var routeLayer; 

	var startX = axisObj.startX;
	var startY = axisObj.startY;
	var endX = axisObj.endX;
	var endY = axisObj.endY;

	var headers = {}; 
	headers["appKey"] = appKey;
	headers["Content-Type"] = "application/json";
	
	var paramObj = {
		"startName" : "출발지점",
		"startX" : String(startX),
		"startY" : String(startY),
		"startTime" : "201708081103",
		"endName" : "도착지점",
		"endX" : String(endX),
		"endY" : String(endY),
		"reqCoordType" : "WGS84GEO",
		"resCoordType" : "EPSG3857",
		"searchOption": "0"
	};
	paramObj.viaPoints = viaPoints;
	var param = JSON.stringify(paramObj);
	// console.dir(param);

	$.ajax({
		method:"POST",
		url:apiUrl,
		headers : headers,
		async:false,
		data:param,
		success:function(response){

			var resultData = response.properties;
			var resultFeatures = response.features;
			
			// 경로 정보
			/*var tDistance = "珥� 嫄곕━ : " + resultData.totalDistance + "km,  ";
			var tTime = "珥� �쒓컙 : " + resultData.totalTime + "遺�,  ";
			var tFare = "珥� �붽툑 : " + resultData.totalFare + "��";
			
			$("#result").text(tDistance+tTime+tFare);*/
			
			//지도 초기화
			clearMap();
			
			for(var i in resultFeatures) {
				var geometry = resultFeatures[i].geometry;
				var properties = resultFeatures[i].properties;
				var polyline_;
				
				drawInfoArr = [];
				
				if(geometry.type == "LineString") {
					for(var j in geometry.coordinates){
						// 寃쎈줈�ㅼ쓽 寃곌낵媛�(援ш컙)�ㅼ쓣 �ъ씤�� 媛앹껜濡� 蹂��� 
						var latlng = new Tmapv2.Point(geometry.coordinates[j][0], geometry.coordinates[j][1]);
						// �ъ씤�� 媛앹껜瑜� 諛쏆븘 醫뚰몴媛믪쑝濡� 蹂���
						var convertPoint = new Tmapv2.Projection.convertEPSG3857ToWGS84GEO(latlng);
						// �ъ씤�멸컼泥댁쓽 �뺣낫濡� 醫뚰몴媛� 蹂��� 媛앹껜濡� ����
						var convertChange = new Tmapv2.LatLng(convertPoint._lat, convertPoint._lng);
						
						drawInfoArr.push(convertChange);
					}

					polyline_ = new Tmapv2.Polyline({
						path : drawInfoArr,
						strokeColor : "#FF0000",
						strokeWeight: 6,
						map : map
					});
					resultDrawArr.push(polyline_);
					
				}else{
					// console.log("geometry.type", geometry.type);
					
					// 寃쎈줈�ㅼ쓽 寃곌낵媛믩뱾�� �ъ씤�� 媛앹껜濡� 蹂��� 
					var latlon = new Tmapv2.Point(geometry.coordinates[0], geometry.coordinates[1]);
					// �ъ씤�� 媛앹껜瑜� 諛쏆븘 醫뚰몴媛믪쑝濡� �ㅼ떆 蹂���
					var convertPoint = new Tmapv2.Projection.convertEPSG3857ToWGS84GEO(latlon);
				  	
					addMarkers({
						lng : convertPoint._lng,
						lat : convertPoint._lat,
						pointType : properties.pointType
					});
				}
			}
			map.setZoom(12);

		},
		error:function(request,status,error){
			// console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});

}
/*3�먮━�섎쭏�� 肄ㅻ쭏 - �ㅼ���*/
function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}


function getDistance(axisObj, obj) {
	$.ajax({
		type : "POST",
		url : "https://apis.openapi.sk.com/tmap/routes?version=1&format=json&callback=result",
		async : false,
		data : {
			"appKey" : appKey,
			"startX" : String(axisObj.startX),
			"startY" : String(axisObj.startY),
			"endX" : String(axisObj.endX),
			"endY" : String(axisObj.endY),
			"reqCoordType" : "WGS84GEO",
			"resCoordType" : "EPSG3857",
			"searchOption" : "0",
			"trafficInfo" : "Y"
		},
		success : function(response) {

			var resultData = response.features;

			var tDistance = "珥� 嫄곕━ : " + (resultData[0].properties.totalDistance / 1000).toFixed(1) + "km";
			var tTime = " 珥� �쒓컙 : " + (resultData[0].properties.totalTime / 60).toFixed(0) + "遺�";
			var tFare = " 珥� �붽툑 : " + resultData[0].properties.totalFare + "��";
			var taxiFare = " �덉긽�앹떆�붽툑 : " + resultData[0].properties.taxiFare + "��";
			if(obj) {
				var el = "<li class=\"way-point-info\">"+"<span>"+tDistance+"</span>" + "<span>"+tTime+"</span>" + "<span>" +numberWithCommas(taxiFare)+ "</span>" +"</li>";
				$(obj).before(el);
			} else {
				// console.log(tDistance + tTime + taxiFare);
			}
		},
		error:function(request,status,error){
			// console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}

	});
}

/*경로선 그리기*/
function drawLine(arrPoint, traffic) {
	var polyline_;

	if (checkTraffic.length != 0) {

		var lineColor = "";
		// console.log(traffic);
		// if (traffic != "0") {
		if (typeof traffic != "undefined") {
			if (traffic.length == 0) { //length媛� 0�멸쾬�� 援먰넻�뺣낫媛� �놁쑝誘�濡� 寃����됱쑝濡� �쒖떆

				lineColor = "#06050D";
				//�쇱씤洹몃━湲�[S]
				polyline_ = new Tmapv2.Polyline({
					path : arrPoint,
					strokeColor : lineColor,
					strokeWeight : 6,
					map : map
				});
				resultDrawArr.push(polyline_);
				//�쇱씤洹몃━湲�[E]
			} else { //援먰넻�뺣낫媛� �덉쓬

				if (traffic[0][0] != 0) { //援먰넻�뺣낫 �쒖옉�몃뜳�ㅺ� 0�� �꾨땶寃쎌슦
					var trafficObject = "";
					var tInfo = [];

					for (var z = 0; z < traffic.length; z++) {
						trafficObject = {
							"startIndex" : traffic[z][0],
							"endIndex" : traffic[z][1],
							"trafficIndex" : traffic[z][2],
						};
						tInfo.push(trafficObject)
					}

					var noInfomationPoint = [];

					for (var p = 0; p < tInfo[0].startIndex; p++) {
						noInfomationPoint.push(arrPoint[p]);
					}

					//�쇱씤洹몃━湲�[S]
					polyline_ = new Tmapv2.Polyline({
						path : noInfomationPoint,
						strokeColor : "#06050D",
						strokeWeight : 6,
						map : map
					});
					//�쇱씤洹몃━湲�[E]
					resultDrawArr.push(polyline_);

					for (var x = 0; x < tInfo.length; x++) {
						var sectionPoint = []; //援ш컙�좎뼵

						for (var y = tInfo[x].startIndex; y <= tInfo[x].endIndex; y++) {
							sectionPoint.push(arrPoint[y]);
						}

						if (tInfo[x].trafficIndex == 0) {
							lineColor = "#06050D";
						} else if (tInfo[x].trafficIndex == 1) {
							lineColor = "#61AB25";
						} else if (tInfo[x].trafficIndex == 2) {
							lineColor = "#FFFF00";
						} else if (tInfo[x].trafficIndex == 3) {
							lineColor = "#E87506";
						} else if (tInfo[x].trafficIndex == 4) {
							lineColor = "#D61125";
						}

						//�쇱씤洹몃━湲�[S]
						polyline_ = new Tmapv2.Polyline({
							path : sectionPoint,
							strokeColor : lineColor,
							strokeWeight : 6,
							map : map
						});
						//�쇱씤洹몃━湲�[E]
						resultDrawArr.push(polyline_);
					}
				} else { //0遺��� �쒖옉�섎뒗 寃쎌슦

					var trafficObject = "";
					var tInfo = [];

					for (var z = 0; z < traffic.length; z++) {
						trafficObject = {
							"startIndex" : traffic[z][0],
							"endIndex" : traffic[z][1],
							"trafficIndex" : traffic[z][2],
						};
						tInfo.push(trafficObject)
					}

					for (var x = 0; x < tInfo.length; x++) {
						var sectionPoint = []; //援ш컙�좎뼵

						for (var y = tInfo[x].startIndex; y <= tInfo[x].endIndex; y++) {
							sectionPoint.push(arrPoint[y]);
						}

						if (tInfo[x].trafficIndex == 0) {
							lineColor = "#06050D";
						} else if (tInfo[x].trafficIndex == 1) {
							lineColor = "#61AB25";
						} else if (tInfo[x].trafficIndex == 2) {
							lineColor = "#FFFF00";
						} else if (tInfo[x].trafficIndex == 3) {
							lineColor = "#E87506";
						} else if (tInfo[x].trafficIndex == 4) {
							lineColor = "#D61125";
						}

						//폴리곤으로 경로 그리긴
						polyline_ = new Tmapv2.Polyline({
							path : sectionPoint,
							strokeColor : lineColor,
							strokeWeight : 6,
							map : map
						});
						//경로 그리기
						resultDrawArr.push(polyline_);
					}
				}
			}
		} /*else {

		}*/
	} else {
		polyline_ = new Tmapv2.Polyline({
			path : arrPoint,
			strokeColor : "#DD0000",
			strokeWeight : 6,
			map : map
		});
		resultDrawArr.push(polyline_);
	}

}

/*마커 찍기*/
function addMarkers(infoObj) {
	var size = new Tmapv2.Size(24, 38);
	if (infoObj.pointType == "P") size = new Tmapv2.Size(8, 8);

	var imgURL;
	if(infoObj.markerImage) {
		imgURL = infoObj.markerImage;
	} else {
		switch (infoObj.pointType) {
			case "S":
				// imgURL = 'http://tmapapis.sktelecom.com/upload/tmap/marker/pin_r_m_s.png';
				imgURL = 'http://topopen.tmap.co.kr/imgs/start.png';
				break;
			case "E":
				// imgURL = 'http://tmapapis.sktelecom.com/upload/tmap/marker/pin_r_m_e.png';
				imgURL = 'http://topopen.tmap.co.kr/imgs/arrival.png';
				break;
			case "P":
				// imgURL = 'http://tmapapis.sktelecom.com/upload/tmap/marker/pin_b_m_p.png';
				imgURL = 'http://topopen.tmap.co.kr/imgs/point.png';
				break;
			default:
				break;
		};
		// if(infoObj.pointType == "P" && infoObj.pointNum) {
		if(infoObj.pointNum) {
			if(infoObj.pointNum > 0) {
				imgURL = 'http://tmapapis.sktelecom.com/upload/tmap/marker/pin_b_m_'+infoObj.pointNum+'.png';
			} else {
				imgURL = 'http://tmapapis.sktelecom.com/upload/tmap/marker/pin_b_m_p.png';
			}
			size = new Tmapv2.Size(24, 38);
		}
	}

	var marker_p = new Tmapv2.Marker({
		position : new Tmapv2.LatLng(infoObj.lat, infoObj.lng),
		icon : imgURL,
		iconSize : size,
		map : map
	});

	resultMarkerArr.push(marker_p);
}

/** 맵 초기화 **/
function clearMap() {
	if(resultDrawArr.length>0){
		for(var i in resultDrawArr){
			resultDrawArr[i].setMap(null);
		}
		resultDrawArr=[];
	}
	if(resultMarkerArr.length>0){
		for(var i in resultMarkerArr){
			resultMarkerArr[i].setMap(null);
		}
		resultMarkerArr=[];
	}
	if(infoWindowArr.length>0){
		for(var i in infoWindowArr){
			infoWindowArr[i].setMap(null);
		}
		infoWindowArr=[];
	}
}
function goback(){
	window.history.back();
}