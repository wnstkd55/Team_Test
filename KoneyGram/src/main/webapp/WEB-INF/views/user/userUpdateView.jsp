<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
	<head>
		<!-- 합쳐지고 최소화된 최신 CSS -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
		<!-- 부가적인 테마 -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
	 	
	 	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
		<title>회원가입</title>
	</head>
	<script type="text/javascript">
		$(document).ready(function(){
			// 취소
			$(".cencle").on("click", function(){
				
				location.href = "/";
						    
			})
		
			$("#submit").on("click", function(){
				if($("#userPwd").val()==""){
					alert("비밀번호를 입력해주세요.");
					$("#userPwd").focus();
					return false;
				}
				if($("#userName").val()==""){
					alert("성명을 입력해주세요.");
					$("#userName").focus();
					return false;
				}
				if($("#userAge").val()==""){
					alert("나이를 입력해주세요.");
					$("#userAge").focus();
					return false;
				}
				if($("#userEmail").val()==""){
					alert("이메일을 입력해주세요.");
					$("#userEmail").focus();
					return false;
				}
				if($("#userIntro").val()==""){
					alert("자기소개를 입력해주세요.");
					$("#userIntro").focus();
					return false;
				}
				
			});
			
				
			
		})
	</script>
	<body>
		<section id="container">
			<form action="/user/userUpdate" method="post">
				<div class="form-group has-feedback">
					<label class="control-label" for="userId">아이디</label>
					<input class="form-control" type="text" id="userId" name="userId" value="${user.userId}" readonly="readonly"/>
				</div>
				<div class="form-group has-feedback">
					<label class="control-label" for="userPwd">패스워드</label>
					<input class="form-control" type="password" id="userPwd" name="userPwd" />
				</div>
				<div class="form-group has-feedback">
					<label class="control-label" for="userName">성명</label>
					<input class="form-control" type="text" id="userName" name="userName" value="${user.userName}"/>
				</div>
				<div class="form-group has-feedback">
					<label class="control-label" for="userAge">나이</label>
					<input class="form-control" type="text" id="userAge" name="userAge" value="${user.userAge}"/>
				</div>
				<div class="form-group has-feedback">
					<label class="control-label" for="userEmail">이메일</label>
					<input class="form-control" type="text" id="userEmail" name="userEmail" value="${user.userEmail}"/>
				</div>
				<div class="form-group has-feedback">
					<label class="control-label" for="userIntro">자기소개</label>
					<input class="form-control" type="text" id="userIntro" name="userIntro" value="${user.userIntro}"/>
				</div>
				<div class="form-group has-feedback">
					<button class="btn btn-success" type="submit" id="submit">회원정보수정</button>
					<button class="cencle btn btn-danger" type="button">취소</button>
				</div>
			</form>
		</section>
		
	</body>
	
</html>