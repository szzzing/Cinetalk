<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내가 좋아하는 리뷰</title>
<!-- CSS only -->
<style>
	#myLikeBoardView {
		margin: auto;
		margin-top: 50px;
		padding: 40px;
		width:800px;
	}
		.alert {
		margin: auto;
		margin-top: 50px;
		padding: 40px;
		width: 800px;
	}
	#card {
		display: inline-block;
		margin-bottom: 1em;
	}
</style>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
	crossorigin="anonymous">
</head>
<body>
<jsp:include page="../common/top.jsp" />
	<div id="myLikeBoardView" class="container">
		<h3 style="color: #CD5C5C;">내가 좋아하는 리뷰</h3>
		<br>
		<br>
		<br>
		<c:if test="${ empty list  }">

         <div class="alert alert-danger" role="alert" id="table">아직 작성된 리뷰가 없습니다.</div>

    	</c:if>
      	
		<c:if test="${ !empty list }">
		<c:forEach items="${ list }" var="r" varStatus="t">
		<div>
			<div class="card flex-md-row mb-4 box-shadow h-md-250 like">
				<div class="card-body d-flex flex-column align-items-start">
					<input type="hidden" name="boardId" value="${ r.boardId }">
					<h5 class="mb-0">${ movieTitleList[t.index] }</h5><br>
					<small class="mb-1 text-muted">${ r.boardTitle }</small>
					<small class="mb-1 text-muted">${ loginUser.nickName }</small>
					<p class="mb-1 text-muted">${ r.movieRating }</p><br>
					<p class="card-text">
						${ r.boardContent }
					</p>
					<small class="mb-1 text-muted">${ r.modifyDate }</small>
					<small class="text-right" style="color: #CD5C5C;">좋아요 ${ r.likeCount }&nbsp;&nbsp;댓글 ${ r.commentCount }</small>
				</div>
			</div>
		</div>
		</c:forEach>
		</c:if>
	
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
		crossorigin="anonymous">
	</script>
	<script>
		const divs = document.getElementsByClassName("card flex-md-row mb-4 box-shadow h-md-250 like");
		console.log(divs);
		
		for( const div of divs){
			div.addEventListener('click', function(){
				const boardId = this.childNodes[1].childNodes[1].value;
				const movieTitle = this.childNodes[1].childNodes[3].innerText;
				const writer = this.childNodes[1].childNodes[8].innerText;
				console.log(writer);
				location.href="${contextPath}/movieReviewDetail.re?boardId="+boardId+"&writer="+writer+"&movieTitle="+movieTitle;
			});
		}
	</script>
</body>
</html>