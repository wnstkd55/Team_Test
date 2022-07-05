<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
	<head>
		<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	 	<title>게시판</title>
	</head>
	<script type="text/javascript">
		$(document).ready(function(){
			var formObj = $("form[name='updatForm']");
			
			$(".cancel_btn").on("click".function(){
				event.preventDefault();
				location.href = "/board/readView?bno=${update.bno}"
					   + "&page=${scri.page}"
					   + "&perPageNum=${scri.perPageNum}"
					   + "&searchType=${scri.searchType}"
					   + "&keyword=${scri.keyword}";
			})
			
			$(".update_btn").on("click", function(){
				if(fn_valChk()){
					return false;
				}
				formObj.attr("action","/board/update");
				fromObj.attr("method", "post");
				fromObj.submit();
			})
		})
		
		function fn_valiChk(){
			var updateForm = $("form[name='updateForm'] .chk").length;
			for(vat i =0; i<updateForm; i++){
				if($(".chk").eq(i).val() == "" || $(".chk").eq(i).val() == null) {
					alert($(".chk").eq(i).attr("title"));
					return true;
				}
			}
		}
	
	</script>
	<body>
		
		<div id = "root">
			<header>
				<h1>게시판</h1>
			</header>
		</div>
		<div>
			<%@include file = "nav.jsp" %>
		</div>
		<hr/>
		
		<section id = "container">
			<form name = "updateForm" role ="form" method = "post" action = "/board/update">
			<input type = "hidden" name = "bno" value = "${update.bno }" readonly="readonly"/>
			<table>
				<tbody>
					<tr>
						<td>
							<label for = "title">제목</label>
							<input type = "text" name = "title" class = "chk" title = "제목을 입력하세요" value = "${update.title }"/>
						</td>
					</tr>
					<tr>
						<td>
							<label for = "content">내용</label>
							<textarea id = "content" name = "content" class = "chk" title = "제목을 입력하세요">
								<c:out value="${update.content }"></c:out>
							</textarea>
						</td>
					</tr>
					<tr>
						<td>
							<label for = "writer">작성자</label><input type = "text" name = "writer" value = "${update.writer }"/>
						</td>
					</tr>
					<tr>
						<td>
							<label for = "regdate">작성날짜</label><fmt:formatDate value="${update.regdate }" pattern = "yyyy-MM-dd"/>
						</td>
					</tr>
				</tbody>
			</table>
			<div>
				<button type ="submit" class = "update_btn">저장</button>
				<button type ="submit" class = "cancel_btn">취소</button>
				
			
			</div>
			
			
			
			</form>
		
		</section>
		
		
	</body>
</html>