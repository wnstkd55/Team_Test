/**
 * 
 */
 
function initTmap(){
	// map 생성
	// Tmap.map을 이용하여, 지도가 들어갈 div, 넓이, 높이를 설정합니다.
	map = new Tmap.Map({div:'map_div', // map을 표시해줄 div
							width:'100%',  // map의 width 설정
							height:'400px' // map의 height 설정
	}); 
} 
// 맵 생성 실행
initTmap();