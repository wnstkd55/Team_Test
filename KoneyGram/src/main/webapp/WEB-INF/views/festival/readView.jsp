<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
	<head>
		<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	 	<title>게시판</title>
	</head>
	
	<script type="text/javascript">
		$(document).ready(function(){
			var formObj = $("form[name='readForm']");

			// 목록
			$(".list_btn").on("click", function(){
			
				location.href = "/festival/listf?page=${scri.page}"
							  +"&perPageNum=${scri.perPageNum}"
							  +"&searchType=${scri.searchType}&keyword=${scri.keyword}";
			})
			
		})
	</script>
	
	<body>
	
		<div id="root">
			<header>
				<h1>${read.f_name}</h1>
			</header>
			<hr />
			 

			
			<section id="container">
				<form name="readForm" role="form" method="post">
				  <input type="hidden" id="bno" name="bno" value="${read.f_code}" >
				  <input type="hidden" id="page" name="page" value="${scri.page}" > 
				  <input type="hidden" id="perPageNum" name="perPageNum" value="${scri.perPageNum}" > 
				  <input type="hidden" id="searchType" name="searchType" value="${scri.searchType}" > 
				  <input type="hidden" id="keyword" name="keyword" value="${scri.keyword}" > 
				</form>
				<table>
					<tbody>
						<tr>
							<td>
								<label for="f_startdate">축제시작일</label><textarea id="f_startdate" name="f_startdate" readonly="readonly"><c:out value="${read.f_startdate}" /></textarea>
							</td>
						</tr>
						<tr>
							<td>
								<label for="f_enddate">축제종료일</label><textarea id="f_enddate" name="f_enddate" readonly="readonly"><c:out value="${read.f_enddate}" /></textarea>
							</td>
						</tr>
						<tr>
							<td>
								<label for="f_mainc">주관기관</label><textarea id="f_mainc" name="f_mainc" readonly="readonly"><c:out value="${read.f_mainc}" /></textarea>
							</td>
						</tr>
						<tr>
							<td>
								<label for="f_tel">전화번호</label><textarea id="f_tel" name="f_tel" readonly="readonly"><c:out value="${read.f_tel}" /></textarea>
							</td>
						</tr>
						<tr>
							<td>
								<label for="f_home">홈페이지</label><textarea id="f_home" name="f_home" readonly="readonly"><c:out value="${read.f_home}" /></textarea>
							</td>
						</tr>
						<tr>
							<td>
								<label for="f_content">축제정보</label><textarea id="f_content" name="f_content" readonly="readonly"><c:out value="${read.f_content}" /></textarea>
							</td>
						</tr>							
					</tbody>			
				</table>
				<div>
					<button type="submit" class="list_btn">목록</button>	
				</div>
				
			</section>
			<hr />
			
			 <jsp:include page="festivalMap.jsp"></jsp:include>
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
		</div>
	</body>
</html>