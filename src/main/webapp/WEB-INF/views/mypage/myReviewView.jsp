<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- CSS only -->
<style>
	.ttable {
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
.btn{
float: right;
}
.btn-danger {
    --bs-btn-bg: #CD5C5C !important;
}
.btn-outline-danger {
    --bs-btn-color: #CD5C5C !important;
    --bs-btn-border-color: #CD5C5C !important;
    --bs-btn-hover-color: #fff;
    --bs-btn-hover-bg: #CD5C5C !important;
    --bs-btn-hover-border-color: #CD5C5C !important;
    --bs-btn-focus-shadow-rgb: 220,53,69;
    --bs-btn-active-color: #fff;
    --bs-btn-active-bg: #CD5C5C !important;
    --bs-btn-active-border-color: #CD5C5C !important;
    --bs-btn-active-shadow: inset 0 3px 5pxrgba(0, 0, 0, 0.125);
    --bs-btn-disabled-color: #CD5C5C !important;
    --bs-btn-disabled-bg: transparent;
    --bs-btn-disabled-border-color: #CD5C5C !important;
    --bs-gradient: none;
}
</style>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
</head>
<body>
	<jsp:include page="../common/top.jsp" />
	<h3 class="ttable" style="color:#CD5C5C;">내가 쓴 리뷰</h3><br><br><br>
	<c:if test="${ empty list  }">

         <div class="alert alert-danger" role="alert" id="table">아직 작성된 리뷰가 없습니다.</div>

    </c:if>
      	
	<c:if test="${ !empty list }">
		<c:forEach items="${ list }" var="r" varStatus="t">
		<div class="ttable">
		<input type="hidden" name="boardId" value="${ r.boardId }">
		<input type="hidden" name="writer" value="${ r.boardWriter }">
			<div class="card flex-md-row mb-4 box-shadow h-md-250 like">
				<div class="card-body d-flex flex-column align-items-start">
					<input type="hidden" name="boardId" value="${ r.boardId }">
					<h5 class="mb-0">${ movieTitleList[t.index] }</h5><br>
					<small class="mb-1 text-muted">${ r.boardTitle }</small>
					<small class="mb-1 text-muted">${ loginUser.nickName }</small>
					<p class="mb-1 text-muted">평점 : ${ r.movieRating }</p><br>
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
	<script>
		const divs = document.getElementsByClassName("ttable");
		
		for( const div of divs){
			div.addEventListener('click', function(){
				const boardId = this.childNodes[1].value;
				const writer = this.childNodes[3].value;
				const boardTitle = this.childNodes[5].childNodes[1].childNodes[3].innerText;
				console.log(boardTitle);
				location.href="${contextPath}/movieReviewDetail.re?boardId="+boardId+"&writer="+writer+"&movieTitle="+boardTitle;
				
			});
		}
	</script>
	
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
		crossorigin="anonymous">
	</script>
</body>
</html>