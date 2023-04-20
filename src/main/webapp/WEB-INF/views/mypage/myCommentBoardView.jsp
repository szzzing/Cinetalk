<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
	#myCommentBoardView {
		margin: auto;
		margin-top: 50px;
		padding: 40px;
		width: 800px;
	}
	.alert {
		margin: auto;
		margin-top: 50px;
		padding: 40px;
		width: 800px;
	}
	#card {
		margin: auto;
		margin-top: 50px;
		padding: 40px;
		width: 800px;
	}	
	#link{
		text-decoration-line : none;
		font-weight: bold;
		color : black;
	}
</style>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
</head>
<body>
<jsp:include page="../common/top.jsp" />
<h3 id="card" style="color:#CD5C5C;">내가 쓴 댓글</h3>
	<div class="myCommentBoardView">
		<br> <br> <br>
		<c:if test="${ empty list  }">
        	<div class="alert alert-danger" role="alert" id="table">아직 작성된 댓글이 없습니다.</div>
    	</c:if>
    	
    	<c:if test="${ !empty list }">
    		<c:forEach items="${ list }" var="r" varStatus="t">
			<div id="card" class="card">
			<input type="hidden" name="boardId" value="${ r.boardId }">
				<div class="card-body">
					
						<small class="text-muted">${ r.boardTitle }</small>
					<p class="card-text">${ r.commentContent }</p>
					
					<small class="text-muted">${ r.commentCreateDate }</small>
				</div>
				
			</div><br>
			</c:forEach>
		</c:if>
	</div>
	
	<script>
		const divs = document.getElementsByClassName("card");
		console.log(divs);
		
		for( const div of divs){
			div.addEventListener('click', function(){
				const boardId = this.childNodes[1].value;
				const boardTitle = this.childNodes[1].childNodes[1];
				console.log(boardId);
				location.href="${contextPath}/hangoutDetail.ha?boardId="+boardId+"&writer="+writer;
			});
		}
	</script>
	
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
		integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"
		integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"
		integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
		crossorigin="anonymous"></script>
</body>
</html>