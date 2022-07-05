// JavaScript Document


 
/*-----------------------------------------------------------------*/
// GNB
/*-----------------------------------------------------------------*/

$(function(){
					 
	// Common
	var gnb_root = $('#gnb');
	var gnb_a = $('#gnb>li>a');
	var gnb_div = $('#gnb>li>div');
	var gnb_bg = $('.gnb_bg');
	gnb_div.addClass("transition");
	gnb_bg.addClass("transition");

	
	// Show
	function show_div() {
		$(this).parents('ul:first').children('li').removeClass('open');
		$(this).parents('li:first').addClass('open'); //자식 메뉴만 오픈
	 
	}
	
	// Hide
	function hide_div() {
		setTimeout(function(){
			$('#gnb>li').removeClass('open');
		}, 1);
		
	}
	
	gnb_a.hover(show_div).focus(show_div);
	gnb_div.hover(show_div);
	$(".gnb_wrap").mouseleave(hide_div);
	$('*').not($('#gnb a')).focus(hide_div);
	
});
 /*-----------------------------------------------------------------*/
// 
/*-----------------------------------------------------------------*/
$(function(){
	var hdOffset = $( '#header').offset();
	// console.log(hdOffset);
	var scrollTop = 100;
	$( window ).scroll( function() {
	  //if ( $( document ).scrollTop() > hdOffset.top ) {
	  if ( $( document ).scrollTop() > scrollTop ) {
		$("#header").addClass('scroll transit');
	  }
	  else {
		$("#header").removeClass('scroll transit');
	  }
	 
	});
	
	 if($("#wrap").hasClass("pop_ly") == false) {
		  $("#header").addClass('transit pop');
	  }else {
		$("#header").removeClass('transit pop');
	  }
	
});  


 /*-----------------------------------------------------------------*/
// SNB
/*-----------------------------------------------------------------*/

	
//<![CDATA[
$(function() {
	
	// 텝메뉴 토글처리	
	$(".tabmenu > a").on("click", function() {
		$(this).next("ul").toggle();
		$(this).toggleClass("on");
	});
	
	$(window).on('resize', function() {
		if ($(window).width() < 768) {
			$(".tabmenu > ul").hide();
		}else{
			$(".tabmenu > ul").show();
		}
	});
	
});	



//]]>


/*-----------------------------------------------------------------*/
// LNB
/*-----------------------------------------------------------------*/
//<![CDATA[
$(function() {
	
	$("#lnb a").next("div").hide(); // 모두 접기
	
	// 토글처리	
	$("#lnb li > div").prev("a").on("click", function() {
		
		$(this).parent().siblings().find(">a").removeClass("on").end().find("div").hide();
		// 현재 메뉴 토글
		$(this).toggleClass("on");
		$(this).next("div").slideToggle();

		return false;
	});
	
	$("#lnb").mouseleave(function(){
		$("#lnb > li > a").removeClass("on").next("div").slideUp();
	});
	
});
//]]>


/*-----------------------------------------------------------------*/
// smoothWheel
/*-----------------------------------------------------------------*/
$(function(){
   //$("html").smoothWheel();
   // init controller
   
   /*
var controller = new ScrollMagic.Controller();

// create a scene
new ScrollMagic.Scene({
		duration: 200,	// the scene should last for a scroll distance of 100px
		offset: 0	// start this scene after scrolling for 50px
	})
	.setPin("#wrap") // pins the element for the the scene's duration
	.addTo(controller); // assign the scene to the controller
	*/
});







//]]>



/*-----------------------------------------------------------------*/
// Content TabMenu
/*-----------------------------------------------------------------*/
$(function(){
	//최초설정
	var index =0;
	$(".tab_mn > ul > li > a").eq(index).addClass("on");
	//$(".cssSelect").hide();
	//$(".cssSelect").eq(index).show();
	
	//상단 이미지 클릭시 처리	
	$(".cssSelect").prev("a").click(function(){
		//console.log($(".cssSelect").prev("a").index($(this)));
		index = $(".cssSelect").prev("a").index($(this));
		
		//이미지 표시
		$(".tab_mn > ul > li > a").removeClass("on");
		$(".tab_mn > ul > li > a").eq(index).addClass("on");
		
		//$(".cssSelect").eq(index).toggleClass("on");
		
		//아래쪽 목록표시
		$(".cssSelect").hide();
		$(".cssSelect").eq(index).show();
		
		//css표출
		$(".cssSelect").removeClass("on");
		//$(".cssSelect").eq(index).addClass("on");
	});
	
	$(".cssSelect").find("button").click(function(){
		$(".cssSelect").eq(index).toggleClass("on");
	});
	
	
	/*var contTab = $('.tab_mn');
	function onSelectContTab(e){
		e.preventDefault();
		var t = $(this);
		var myclass = t.parents('li:first').attr('class');
		contTab.find('>ul>li>a').removeClass('on');
		t.addClass('on');
		
		t.parents('.tab_mn:first').attr('class','tab_mn '+myclass);
	}
	contTab.find('>li>a').click(onSelectContTab);*/
});

/*-----------------------------------------------------------------*/
// mobile header
/*-----------------------------------------------------------------*/

$(function(){
	var headSearch = $('#header .search');
	headSearch.on("click", ".btn_open, .btn_close", function(){
		headSearch.toggleClass("open");
	//$('.search button ').click(function(){
		//$('#header .srch_area').toggleClass('open');
	});
});

/*-----------------------------------------------------------------*/
//전체메뉴보기
/*-----------------------------------------------------------------*/

$(function(){
					 
	// Common
	var wholeview = $('#header .wholeview');

	//Close 버튼 추가
	$(".nav_wholeview").append("<button type='button' class='btn_close' title='전체메뉴'><span>Menu Close</span></button>");
	$(".overlay").hide().css("height",$('body').height());
	//Open,Close
	wholeview.on("click", ".btn_open, .btn_close", function(){
		wholeview.toggleClass("open");
		$(".overlay").toggle();
		// Div 높이
		var max_whole = 0; // 최고높이값 저장
		var whole_index = 0; // 최고높이값을 가진 아이템 저장	
		$(".nav_wholeview>ul>li").each(function(i) {
			var whole_height = $(this).find("div").height();
			if (whole_height > max_whole) {		
				max_whole = whole_height;
				whole_index = i;
			}		
		});
		var whole_height = $(".nav_wholeview>ul>li").eq(whole_index).find("div").height();
		$(".nav_wholeview>ul>li>div").height(whole_height);
	});
	
});
/*-----------------------------------------------------------------*/
// 전체메뉴
/*-----------------------------------------------------------------*/
$(function() {
	$("#wholeView").removeClass("open");
	
	$(".btn_wv").on("click", function(){
		var navHeight = $('#wholeView .wv_wrap .nav').height();
		var windowHeight = $(window).height();
		$("#wholeView").addClass("open");
		$("#wrap").css({'height':navHeight + 'px', 'overflow':'hidden'});
	});

	$("body").on("click", "#wholeView .btn_close, .wvBg", function(event){
		event.preventDefault();
		$("#wholeView").removeClass("open");
		$("#wrap").css({'height':'auto', 'overflow':'auto'});
	});
	
	//<? foreach ($history_no as $value) { // on ?>
	//	$("li.<?=intval($value)?> > a").addClass("on");
	//<? } ?>
	
	//try {			
	//	var cid = $("body").attr("class").replace("c", "");
	//	$("#gnb_mobile a[href*=" + cid + "]").addClass("on");
	//}
	//catch (e) {		
		
	//}
	
	// Default
	$("#gnb_mobile li div").prev("a").append("<span class='unfd'> 펼치기</span>"); // 폴딩 아이콘 펼치기
	$("#gnb_mobile li ul").prev("a").append("<span class='unfd'> 펼치기</span>"); // 폴딩 아이콘 펼치기
	$("#gnb_mobile li ul").prev("a").addClass("parent"); 
	$("#gnb_mobile li a.on").find(".unfd").text(" 접기"); // 폴딩 아이콘 접기
	//$("#gnb_mobile a[target='_blank']").append("<span class='blank'> 새창</span>"); // 새창 아이콘 활성
	$("#gnb_mobile a.on").parents("li").addClass("open"); // 메뉴 활성화
	$("#gnb_mobile li.open>a").addClass("on");
	$("#gnb_mobile li.open > ul").show();
	
	// 토글처리
	
	$("#gnb_mobile li ul").prev("a").click(function() {	
		// 다른 메뉴 닫기
		$(this).parent().siblings().find(">ul").slideUp();
		$(this).parent().siblings().find(">a").removeClass("on");

		// 현재 메뉴 토글
		$(this).toggleClass("on");
		$(this).parent("li:first").toggleClass("open");
		$(this).next().slideToggle();
		$("#gnb_mobile li > ul").prev("a").find(".unfd").text(" 펼치기"); // 폴딩 아이콘 펼치기
		$("#gnb_mobile li.open > ul").prev("a").find(".unfd").text(" 접기"); // 폴딩 아이콘 접기	

		return false;

	});

	// 외국어 토글처리	
	$("#wholeView").on("click", ".language_area > li > a", function() {

		$(this).parent().toggleClass("open");
		$(this).next("ul").slideToggle();

		return false;
		
	});


	
});
/*-----------------------------------------------------------------*/
//Skip Top
/*-----------------------------------------------------------------*/
$(document).ready(function(){
					
	$(".skip_top").hide(); // 탑 버튼 숨김
	$(function () {
			 
		$(window).scroll(function () {
			if ($(this).scrollTop() > 200) { // 스크롤 내릴 표시
				$('.skip_top').fadeIn();
			} else {
				$('.skip_top').fadeOut();
			}
			var scHeight = $(document).scrollTop();
			//console.log("scHeight: ", scHeight);
			if(scHeight > 1500 ){
					$('.skip_top').css('bottom','25%');

			}else{
				
				$('.skip_top').css('bottom','5%');
			}


		});
				
		$('.skip_top').click(function () {
			$('body,html').animate({
				scrollTop: 0
			}, 300);  // 탑 이동 스크롤 속도
			return false;
		});
		
		
		
	});
 
});
/*-----------------------------------------------------------------*/
// Select Menu
/*-----------------------------------------------------------------*/
//  CSS셀렉트
$(function(){
	var sltRelatedContainer = $(".cssSelect");
	var sltRelatedButton = sltRelatedContainer.find("button");
	var sltRelatedList = sltRelatedContainer.find(".lst");
	var sltRelated_a = sltRelatedList.find(">li>a");	
	
	// Show
	/*sltRelatedButton.click(function() {
		$(this).parents(".cssSelect:first").toggleClass("on");
	});
	// Hide
	sltRelatedContainer.mouseleave(function() {
		$(this).removeClass("on");
	});
	sltRelated_a.click(function() {
		$(this).parents(".cssSelect:first").removeClass("on");
	});
	// Focus,Hover
	sltRelated_a.bind("focus hover", function() {
		sltRelated_a.removeClass("hover");
		$(this).toggleClass("hover");
	});*/
});

/*-----------------------------------------------------------------*/
// Box Slider
/*-----------------------------------------------------------------*/
$(function(){

	//rolling img
	$('.rollingzone .lst').bxSlider({
			mode: 'fade',//슬라이드 효과설정
			slideZIndex: 30,//
			auto: true,
			autoHover: true,
			autoControls: false,//paly, stop, puase 슬라이드 컨트롤 버튼
			controls: true,
			//autoStart: false,
			pager: false
		});
	
	
	$(".bx-controls-auto").click(function() { $(this).find("a").focus(); }); // 시작,정지 토글 키보드 접근시 포커스
});

/*-----------------------------------------------------------------*/
// btn_up
/*-----------------------------------------------------------------*/
$(function(){

	$(".btn_up a").click(function(){
		$(".detail_cont").stop(true,false).slideUp();
	});




});