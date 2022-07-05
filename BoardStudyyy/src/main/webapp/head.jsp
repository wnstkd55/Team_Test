<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import = "kr.co.user.User" %>
<%@ page import = "kr.co.user.UserDAO" %>
<jsp:useBean id="user" class="kr.co.user.User" scope="page" />
<jsp:setProperty name="user" property="userRole" />
<!DOCTYPE html>
<html>
<head>
<script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
<link rel="stylesheet" href="css/style.css">
 <script src='js/Style.js'></script>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
		<div class="navigation">
		<div class="menuToggle"></div>
		<ul>
			<li class = "list active" style="--clr:#f44336;">
				<a href="#">
					<span class ="icon"><ion-icon name="home-outline"></ion-icon></span>
					<span class="text">메인홈</span>
				</a>
			</li>
			<li class = "list" style="--clr:#ffa117;">
				<a href="#">
					<span class ="icon"><ion-icon name="airplane-outline"></ion-icon></span>
					<span class="text">일정짜기</span>
				</a>
			</li>
			<li class = "list" style="--clr:#0fc70f;">
				<a href="#">
					<span class ="icon"><ion-icon name="camera-outline"></ion-icon></span>
					<span class="text">일정 공유하기</span>
				</a>
			</li>
			<li class = "list" style="--clr:#2196f3;">
				<a href="#">
					<span class ="icon"><ion-icon name="people-outline"></ion-icon></span>
					<span class="text">고객 센터</span>
				</a>
			</li>
			<li class = "list" style="--clr:#b145e9;">
				<a href="#">
					<span class ="icon"><ion-icon name="person-outline"></ion-icon></span>
					<span class="text">회원 정보</span>
				</a>
			</li>
		</ul>
	</div>

	<script>
		const menuToggle = document.querySelector('.menuToggle');
		const navigation = document.querySelector('.navigation');
		menuToggle.onclick = function(){
			navigation.classList.toggle('open')
		}

		const list = document.querySelectorAll('.list');
		function activeLink(){
			list.forEach((item) =>
			item.classList.remove('active'));
			this.classList.add('active');
		}
		list.forEach((item)=>
		item.addEventListener('click',activeLink));
	</script>
</body>
</html>