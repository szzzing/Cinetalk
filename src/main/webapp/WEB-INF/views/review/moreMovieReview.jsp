<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<style>
.navbar {
	position: relative;
}

#reviews {
	margin: auto;
	margin-top: 30px;
	padding: 20px;
	width: 1100px;
	word-break:break-all;
}

#commentTop>.navbar {
	padding: 30px;
}

#commentTop>#container {
	padding: 30px;
}

.container {
	padding: 10px;
}
</style>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
</head>
<body>

	<jsp:include page="../common/top.jsp" />
	<div id="commentTop" style="position: fixed; width: 100%; z-index: 10">
		<nav class="navbar bg-light">
			<div class="container-fluid" id="container">
				<a class="navbar-brand" href="#"> <img
					src="resources/image/back.png" alt="뒤로가기" width="36" height="36"
					class="d-inline-block align-text-top"
					onclick="javascript:history.back();">
				</a> 
				<span class="navbar-text" style="font-size: 30px"> 리뷰 모아보기 </span>
			</div>
		</nav>
	</div>
	
	
	<div style="margin-top: 150px;" id="box">
		<c:forEach items="${ list }" var="b">
			<div id="reviews" style="margin-top: 20px;">
				<div class="card" style="width: 70rem;">
					<div class="card-body" style="cursor:pointer">
						<input type="hidden" class="boardId" name="boardId" value="${ b.boardId }">
						<input type="hidden" class="movieTitle" name="movieTitle" value="${ movieTitle }">
						<ul class="list-group list-group-flush">
							<li class="list-group-item">
								<i class="bi bi-person-fill"style="font-size: 2rem;"></i>
								<h2 class="card-title" style="display: inline;">${ b.nickName }</h2>
								<span class="badge badge rounded-pill text-bg-danger" style="font-size: 1rem; float: right">★${ b.movieRating }</span>
							</li>
						</ul>
					<ul class="list-group list-group-flush">
						<li class="list-group-item">
							<h3>${ b.boardTitle }</h3>${ b.boardContent }
						</li>
					</ul>
					</div>
					<div class="card-body">l
						<small class="mb-1 text-muted">${ b.modifyDate }</small>
						<small class="text-right" style="color: #CD5C5C;">좋아요 ${ b.likeCount }&nbsp;&nbsp;댓글 ${ b.commentCount }</small>
					</div>
				</div>
			</div>
		</c:forEach>
		<div id="last"></div>
	</div>
	<br><br><br>
	
	<jsp:include page="../common/footer.jsp" />

	<script>
	window.onload = () =>{
		
		
		const divCards = document.querySelectorAll('div.card');
		console.log(divCards);
		for(const divcard of divCards) {
			divcard.addEventListener('click', function(){
				const input = this.querySelectorAll('input');
				const boardId = input[0].value;
				const movieTitle = input[1].value;
				console.log(boardId);
				const head = this.querySelector('h2');
				const writer = head.innerText;
				console.log(writer);
				
				location.href='${contextPath}/movieReviewDetail.re?boardId=' + boardId + '&writer=' + writer + '&movieTitle=' + movieTitle; 
// 				location.href='${contextPath}/commentDetail.re'; 
			});
		}
	

	}
		

		
   </script>
</body>
</html>