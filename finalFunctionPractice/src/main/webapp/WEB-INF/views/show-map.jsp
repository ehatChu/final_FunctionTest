<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=	6793ff7b973d605c93d751f8288336a5"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=APIKEY&libraries=services"></script>
<style>
	.custom-context-menu {
		position: absolute;
		z-index: 100000;
		box-sizing: border-box;
		border-radius: 10px;
		min-height: 30px;
		min-width: 200px;
		background-color: #ffffffc6;
	}
	.custom-context-menu ul {
		list-style: none;
		padding: 20px;
		background-color: transparent;
	}

	.custom-context-menu li {
		cursor: pointer;
	}
	input {
		position: absolute;
		z-index: 100;
		top: 30px;
		left: 10px;
	}
</style>
</head>
<body>
	<!-- 검색해서 눌렀을 때에만 즉, 마커를 눌렀을 때에만  -->
	<div id="map" style="width:100vwpx;height:100vh;"></div>
	<!-- 검색창만들기 -->
	<input type="text" name="map-nick" placeholder="지역을 입력하세요">
	<div id="dochi_context_menu" class="custom-context-menu" style="display: none;">
		<ul>
			<li>평가등록하기</li>
		</ul>
	</div>
	<!-- 클릭한 위치에 마커 생성하기 -->
	<script type="text/javascript">
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new kakao.maps.LatLng(37.58934, 126.82917), // 지도의 중심좌표
	        level: 7, // 지도의 확대 레벨
	        mapTypeId : kakao.maps.MapTypeId.ROADMAP // 지도종류
	    }; 
		
		// 지도를 생성한다 
		var map = new kakao.maps.Map(mapContainer, mapOption); 
		

		// 장소 검색 객체를 생성합니다
		var ps = new kakao.maps.services.Places(); 

		// 키워드로 장소를 검색합니다
		//input의 value값을 가져오자

		ps.keywordSearch('이태원 맛집', placesSearchCB); 

		// 키워드 검색 완료 시 호출되는 콜백함수 입니다
		function placesSearchCB (data, status, pagination) {
			if (status === kakao.maps.services.Status.OK) {

				// 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
				// LatLngBounds 객체에 좌표를 추가합니다
				var bounds = new kakao.maps.LatLngBounds();

				for (var i=0; i<data.length; i++) {
					displayMarker(data[i]);    
					bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
				}       

				// 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
				map.setBounds(bounds);
			} 
		}

		// 지도에 마커를 생성하고 표시한다
		// 오른쪽마우스를 하면 선택지가 뜨게끔
		// 지도검색기능
		var marker = new kakao.maps.Marker({
		    position: new kakao.maps.LatLng(37.62636, 126.47619), // 마커의 좌표
		    map: map // 마커를 표시할 지도 객체
		});
		


		// 마커에 클릭 이벤트를 등록한다 (우클릭 : rightclick)
		kakao.maps.event.addListener(marker, 'click', function() {
		    alert('마커를 클릭했습니다!');
		});	
		
		// 지도 좌클릭시 작은..버튼뜨게하기
		function handlerCreateContextMenu(event){
			event.preventDefault();

			const ctxMenu = document.querySelector('#dochi_context_menu');
			ctxMenu.style.display = 'block';

			ctxMenu.style.top = event.pageY+'px';
			ctxMenu.style.left = event.pageX+'px';
		}

		function handlerClearContextMenu(event){

			const ctxMenu = document.querySelector('#dochi_context_menu');
			ctxMenu.style.display = 'none';

			ctxMenu.style.top = null;
			ctxMenu.style.left = null;
		}
		document.addEventListener('contextmenu',handlerCreateContextMenu,false);
		document.addEventListener('click',handlerClearContextMenu,false);
	</script>
	<!-- 마커를 누르면 모달창 띠우기(마커에 클릭이벤트 등록) -->
</body>
</html>