<%@page import="java.lang.reflect.Array"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "kr.co.tour.Tour" %>
<%@ page import = "kr.co.tour.TourDAO" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.util.List" %>
<!DOCTYPE html>
<html>
<head>

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script	src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src = "resources/js/auto3.js"></script>
<script src = "resources/js/map.js"></script>
<script type="text/javascript" src = "resources/js/mapedit.js"></script>
<script src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=l7xx0027c9071859472394ee1ff449ed1fdf"></script>
<link rel="stylesheet" type="text/css" href="resources/css/search.css">
<meta charset="UTF-8">
<title>출발지 검색창입니다</title>
<style type="text/css">
select.select {
	width:15%;
	border: 2px solid #ff7a00;
	height:30px;
	font-size: 15px;
}
input#inpKeyword {
	width:65%;
	margin:0 5px;
}
p.guide-msg { display: none; }
p.on { display: inline-block; }
</style>
</head>
<body>
<div class="mainDiv">
	<input type="hidden" id="inpPage" value="1">
	<input type="hidden" id="inpTotLimit" value="7">
	<input type="hidden" id="targetUrl" value="https://apis.openapi.sk.com/tmap/pois">
    <div id="divtop">
        <h3>
            <span class="ico_sch"></span>
            <span class="top_tit">관광지 통합 검색</span>
        </h3>
    </div>
    <div id="divcont">
        <div id="divSearch">
            <fieldset class="search_box">
                <legend class="blind">검색어 입력창</legend>
                <div class="inputGrp">
                    <button class="btn_sch" name="btn_sch" id="inpSearch">
                        <span class="ico_sch"></span>
                    </button>
                    <div class="input_sch">
						<select class="select" name="searchCondition" id="searchCondition">
							<option value="0">명칭</option>
							<option value="1">주소</option>
						</select>
                    
                        <input type="text" id="inpKeyword" title="검색" placeholder="예) 독산로, 맛집이야기">
                    </div>
                </div>
            </fieldset>
            <p class="guide-msg on">* 검색창에 찾으시는 장소 <b>명칭</b>을 입력해 주세요.</p>
            <p class="guide-msg">* 검색창에 찾으시는 <b>도로명+건물번호</b> 또는 <b>지역명+지번</b>을 입력해 주세요.</p>
        </div>
        <div id="divSearchlist">
           <div class="result">
               <p>검색결과 : 총 <strong id="spanTotCnt">0</strong>건</p>
           </div>
            <div class="tb_wrap">
                <table>
                    <caption class="blind">검색결과 리스트</caption>
                    <thead>
                        <tr>
                            <th>우편번호/도로명/지명</th>
                        </tr>
                    </thead>
                    <tbody id="tbodyResult">
                        
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div id="pageZone"></div>
</div>	
	
<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script>
function init(){
	$('#inpKeyword').focus();
}

function isValidate() {
	var keyword = $('#inpKeyword').val();
	var totLimit = $('#inpTotLimit').val();
	var page = $('#inpPage').val();
	
	if( $.trim( keyword ) == '' ) {
		alert('검색어를 입력해주세요.');
		return false;
	}
	
	if( $.trim( totLimit ) == '' || $.isNumeric( totLimit ) == false || totLimit <= 0 ) {
		$('#inpTotLimit').val('20');
	}
	
	if( $('#inpTotLimit').val() > 200 ) {
		$('#inpTotLimit').val('200');
		alert('200개 이상의 항목은 페이지번호를 이용해주세요.');
	}
	
	if( $.trim( page ) == '' || $.isNumeric( page ) == false || page <= 0 ) {
		$('#inpPage').val('1');
	}
	
	return true;
}

// 페이징 클릭
function goPage(movePage){
	$('#inpPage').val(movePage);
	$('.btn_sch').trigger('click');
}

// 검색 버튼
$('#inpSearch').click(function(){

	// 유효성 검사
	isValidate();
	
	var appKey='l7xxdc2398be8423441f817695db47fd1e32';
	// var url = 'https://apis.openapi.sk.com/tmap/pois';
	var url = $("#targetUrl").val();

	var params = {
		"appKey" : appKey,
		"page" : $('#inpPage').val(),
		"count" : $('#inpTotLimit').val()

	};
	var searchCondition = $("select[name=searchCondition]").val();
	if(searchCondition > 0) {
		params["coordType"] = "WGS84GEO";
		params["addr"] = $('#inpKeyword').val();
		params["addressFlag"] = "F00";
		params["format"] = "json";
	} else {
		params["version"] = "1";
		params["searchKeyword"] = $('#inpKeyword').val();

	}
	console.log(url);
	console.log(params);
	$.get(url, params, success)
	 .fail(fail);
});

function success(data) {
	console.log(data); //return;

	var searchCondition = $("select[name=searchCondition]").val();
	var arrResult = {};
	var totalCnt = 0;

	if(searchCondition > 0) {
		arrResult = data.coordinateInfo.coordinate;
		totalCnt = data.coordinateInfo.totalCount;
	} else {
		arrResult = data.searchPoiInfo.pois.poi;
		totalCnt = data.searchPoiInfo.totalCount;
	}

	var error = data.error;
	var strHtml = '';
	
	// 전체 검색 수
	$('#spanTotCnt').html( totalCnt );
	
	//페이징 처리
	setPagination(totalCnt);
	
	for( var i in arrResult ) {

		if(searchCondition > 0) {
			strHtml += setAddrResultEl(arrResult[i]);
		} else {
			strHtml += setPoiResultEl(arrResult[i]);
		}		
	}

	if( error || arrResult.length <= 0 ) {
		strHtml+='<tr>';
		strHtml+='	<td colspan="2">';
		strHtml+='		<span>검색결과가 없습니다.</span>';
		strHtml+='	</td>';
		strHtml+='</tr>';
	}
	
	$('#tbodyResult').html(strHtml);
}

function setAddrResultEl(arrResultArr) {

	var jibunAddr = '';
	var newRoadAddr = '';
	var strHtml = '';
	
	//법정동 마지막 문자 
	var lastLegal = arrResultArr.legalDong.charAt(arrResultArr.legalDong.length-1);
	
	// 새주소 
	newRoadAddr = arrResultArr.city_do + ' ' + arrResultArr.gu_gun + ' '; 
	
	if(arrResultArr.eup_myun == '' && (lastLegal=="읍"||lastLegal=="면")){//읍면
		newRoadAddr +=  arrResultArr.legalDong;	
	}else{
		newRoadAddr +=  arrResultArr.eup_myun;
	}
	newRoadAddr += ' ' +arrResultArr.newRoadName + ' ' + arrResultArr.newBuildingIndex;
	
	// 새주소 법정동& 건물명 체크
	if(arrResultArr.legalDong != '' && (lastLegal!="읍"&&lastLegal!="면")){//법정동과 읍면이 같은 경우
		
		if(arrResultArr.buildingName != ''){//빌딩명 존재하는 경우
			newRoadAddr +=  (' (' + arrResultArr.legalDong + ', ' +arrResultArr.buildingName +') ');
		}else{
			newRoadAddr += (' (' + arrResultArr.legalDong + ')');
		}
	}else if(arrResultArr.buildingName != ''){//빌딩명만 존재하는 경우
		newRoadAddr +=  (' (' + arrResultArr.buildingName +') ');
	}
	
	// 구주소
	jibunAddr = arrResultArr.city_do + ' ' + arrResultArr.gu_gun + ' ' + arrResultArr.legalDong + ' '+ arrResultArr.ri + ' ' + arrResultArr.bunji;
	//구주소 빌딩명 존재
	if(arrResultArr.buildingName != ''){//빌딩명만 존재하는 경우
		jibunAddr +=  (' '+arrResultArr.buildingName);
	}
	
	var latitude = arrResultArr.lat;
	var longitude = arrResultArr.lon;
	
	strHtml+='<tr>';
	strHtml+='	<td>';
	strHtml+='		<ul class="tb1">';
	strHtml+='			<li class="row">';
	strHtml+='				<div class="th blind">우편번호</div>';
	strHtml+='				<div class="post">'+ arrResultArr.zipcode +'</div>';
	strHtml+='			</li>';
	strHtml+='			<li class="row">';
	strHtml+='				<div class="th"><span class="label st">도로명</span></div>';
	strHtml+='				<div>' + newRoadAddr + '</div>';
	strHtml+='				<div class="th"><span class="label sel" onclick="getaddressInfo(\''+ newRoadAddr +'\', \''+ latitude +'\', \''+ longitude +'\');">선택</span></div>';
	strHtml+='			</li>';
	strHtml+='			<li class="row">';
	strHtml+='				<div class="th"><span class="label num">지번</span></div>';
	strHtml+='				<div>' + jibunAddr + '</div>';
	strHtml+='				<div class="th"><span class="label sel" onclick="getaddressInfo(\''+ newRoadAddr +'\', \''+ latitude +'\', \''+ longitude +'\');">선택</span></div>';
	strHtml+='			</li>';
	strHtml+='		</ul>';
	strHtml+='	</td>';
	strHtml+='</tr>';

	return strHtml;
}

function setPoiResultEl(arrResultArr) {
	
	var strHtml = '';
	strHtml+='<tr>';
	strHtml+='	<td>';
	strHtml+='		<ul class="tb1">';
	strHtml+='			<li class="row">';
	strHtml+='				<div class="th"><span class="label nm">'+ arrResultArr.name +'</span></div>';
	strHtml+='				<div> ' + arrResultArr.upperAddrName + arrResultArr.middleAddrName + arrResultArr.lowerAddrName + '</div>';
	strHtml+='				<div class="th"><span class="label sel" onclick="getaddressInfo(\''+ arrResultArr.name +'\', \''+ arrResultArr.frontLat +'\', \''+ arrResultArr.frontLon +'\');">선택</span></div>';
	strHtml+='			</li>';
	strHtml+='		</ul>';
	strHtml+='	</td>';
	strHtml+='</tr>';

	return strHtml;
}

function getaddressInfo(roadFullAddr, latitude, longitude){
	alert(roadFullAddr);
	alert(latitude);
	alert(longitude);
	opener.document.getElementById('dp_name').value = roadFullAddr;
	opener.document.getElementById('dp_ny').value = latitude;
	opener.document.getElementById('dp_nx').value = longitude;
	window.close();
}

function fail(){
	var strHtml="";
	strHtml+='<tr>';
	strHtml+='	<td>';
	strHtml+='		<span>검색결과가 없습니다.</span>';
	strHtml+='	</td>';
	strHtml+='</tr>';
	
	$('#spanTotCnt').html('0');
	$('#tbodyResult').html(strHtml);
}

function setPagination(totalCnt) {
	// var totalCnt = data.searchPoiInfo.totalCount; //전체 검색 건수
		console.log("totalCnt", totalCnt);
	var totalPage = Math.ceil(totalCnt/$('#inpTotLimit').val());//페이지 수
		console.log("totalPage", totalPage);
	var curentPage = $('#inpPage').val();//현재 페이지
		console.log("curentPage", curentPage);
	var pageHtml; //페이지 리스트
	
	var pageGroup = Math.ceil(curentPage/10);    //페이지 그룹 넘버링

	var next = pageGroup*10;
	var prev = next-9;            
	
	var goNext = next+1;
	if(prev-1<=0){
		var goPrev = 1;
	}else{
		var goPrev = prev-1;
	}    
	
	if(next>totalPage){
		var goNext = totalPage;
		next = totalPage;
	}else{
		var goNext = next+1;
	}
	
	if(totalPage>1){
		var prevStep = " <a class='btn_pre btn_pageNum' href='javascript:goPage("+goPrev+");'>◀</a> ";
		var nextStep = " <a class='btn_nxt btn_pageNum' href='javascript:goPage("+goNext+");'>▶</a> ";
	}
	
	$("#pageZone").empty();
	$("#pageZone").append(prevStep);
	for(var i=prev; i<=next;i++){
		if(curentPage == i){
			PageHtml = "<strong><a class='btn_pageNum btn_pageNum_active' href='javascript:goPage("+i+");'>"+i+"</a></strong> ";
		}else{
			PageHtml = "<strong><a class='btn_pageNum' href='javascript:goPage("+i+");'>"+i+"</a></strong> ";
		}
		$("#pageZone").append(PageHtml);
	}    
	$("#pageZone").append(nextStep);
}
/*
function setAddress(roadFullAddr, latitude, longitude) {
	if(typeof(window.opener) != "undefined") {
		window.opener.addrCallBack(roadFullAddr, latitude, longitude, 'S', '1');
		window.self.close();
	}
}
*/

// 검색어 입력 창
$('#inpKeyword').on("keydown", function(e){
	if(e.keyCode == 13) {
		$('.btn_sch').trigger('click');
	}
});

// 페이지 수 입력 창
$('#inpPage').on("keydown", function(e){
	if(e.keyCode == 13) {
		$('.btn_sch').trigger('click');
	}
});

// 검색 결과 제한 수 입력 창
$('#inpTotLimit').on("keydown", function(e){
	if(e.keyCode == 13) {
		$('.btn_sch').trigger('click');
	}
});

$("#searchCondition").on("change", function() {
	var targetUrl = 'https://apis.openapi.sk.com/tmap/';
	if($(this).val() > 0) {
		$("#inpKeyword").attr('placeholder', '예) 온화로, 온화로83번길 16-5');
		targetUrl += 'geo/postcode';
	} else {
		$("#inpKeyword").attr('placeholder', '예) 독산로, 지역이름');
		targetUrl += 'pois';
	}
	$("p.guide-msg").toggleClass("on");
	$("#targetUrl").val(targetUrl);

	$('#inpPage').val('1');//검색조건 변경에 대비 페이지 초기화
});


$(function(){
	init();
	
});
</script>

</html>