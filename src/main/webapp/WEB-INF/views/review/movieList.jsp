<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>

<title>리뷰게시판</title>
<style>
	#card {
		cursor: pointer;
	}
	
	.form-control-dark {
		color: #fff;
		background-color: rgba(255, 255, 255, .1);
		border-color: rgba(255, 255, 255, .1);
	}
	
	.form-control-dark:focus {
		border-color: transparent;
		box-shadow: 0 0 0 3px rgba(255, 255, 255, .25);
	}
</style>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
	crossorigin="anonymous">
</head>
<body>
	<c:set value="${ reviewCount }" var="allReviewCount" scope="application"/>
	<jsp:include page="../common/top.jsp" />
	<div id="reviewBoardView" class="container">
		<div class="align-items-center pt-3 pb-2 mb-3">
			<h1 style="color:#CD5C5C">리뷰게시판</h1>
			<h5 id="resultCount" class="text-muted">${reviewCount }개의 리뷰가 등록되어 있어요.</h5>
			<div id="searchMovieForm" style="margin-top:30px; margin-bottom:30px">
				<input id="searchValue" class="form-control form-control-lg" type="text" placeholder="찾고싶은 영화를 검색하세요." aria-label="Search">
			</div>
		</div>
		
		
		<div id="movieList" class="row row-cols-1 row-cols-sm-2 row-cols-lg-4 justify-content-start">
		</div>
		
		<!-- 영화 객체 -->
			<div id="movieDiv" class="col" style="display:none;">
				<div id="card" class="card card-cover h-100 overflow-hidden rounded-5">
					<div id="mId" style="display: none;"></div>
					<img id="movieImg" class="card-img-top" src="#" style="background:lightgray; border-top-left-radius:30px; border-top-right-radius:30px">
					<div class="card-body p-4 mb-auto">
						<h4 id="movieTitle" class="card-title lh-1 fw-bold"></h4>
						<div id="genre" class="card-text text-muted"></div>
						<div id="releaseDate" class="card-text text-muted"></div>
					</div>
					<div class="m-4">
						<span id="reviewCount" class="card-text text-muted"></span>
						<span id="avgRating" class="badge badge rounded-pill text-bg-danger" style="font-size:1em; float:right;"></span>
					</div>
				</div>
			</div>
		
	</div>
	
	<div id="movieScrollerFooter"></div>	<!-- 무한스크롤 감지 -->
	<div id="searchScrollerFooter"></div>	<!-- 무한스크롤 감지 -->
	
	<jsp:include page="../common/footer.jsp"/>


	<script>
		window.onload=()=>{
			var page = 1;	// 페이지
			var isSearch = false;	// 영화를 검색해야하는지 아니면 영화 목록을 보여줘야 하는지..?
			
			// 영화 목록 보여주기
			function moreReviewList() {
				$.ajax({
					url: "${contextPath}/moreMovieList.re",
					data: {page: page},
					success: (data)=>{
// 						console.log("영화보여주기"+page);
						for(const m of data) {
							var div = $('#movieDiv').clone();
							div.css("display", "block");
							div.find('#mId').text(m.movieId);
							div.find('#movieImg').attr("src", "https://image.tmdb.org/t/p/w300/"+m.movieImg);
							div.find('#movieTitle').text(m.movieTitle);
							div.find('#genre').text(m.genre);
							div.find('#releaseDate').text(m.releaseDate);
							div.find('#avgRating').html("<i class='bi bi-star-fill'></i>"+m.avgRating);
							div.find('#reviewCount').text(m.reviewCount+"개의 리뷰");
							
							$("#movieList").append('<div id="movieDiv" class="col mb-4">'+div.html()+"</div>");
						}
						
						const reviews = document.getElementsByClassName("card");

						for(const r of reviews) {
							r.addEventListener('click', function(){
								const movieId=this.querySelector("#mId").innerText;
								location.href='${contextPath}/movieDetail.re?movieId='+movieId;
							});
						}
						page = page+1;
					},
					error: (data)=>{
						console.log(data);
					}
				});
			}
			
			
			// 영화 리스트 무한스크롤
			const mio = new IntersectionObserver((entries, observer)=>{
				entries.forEach(entry=>{
					if(!entry.isIntersecting) {
						return; 
					}
					if(isSearch) {
						return;
					}
// 					console.log("영화스크롤");
					observer.observe(document.getElementById('movieScrollerFooter'));
					moreReviewList();
				});
			});
			mio.observe(document.getElementById('movieScrollerFooter'));
			
			// 영화 검색 무한스크롤
			const sio = new IntersectionObserver((entries, observer)=>{
				entries.forEach(entry=>{
					if(!entry.isIntersecting) {
						return; 
					}
					if(isSearch) {
// 						console.log("검색스크롤");
						observer.observe(document.getElementById('searchScrollerFooter'));
						searchMovie(search);
					}
				});
			});
			sio.observe(document.getElementById('searchScrollerFooter'));
			
			
			// 검색
			var currVal = "";
			var search = "";
			$("#searchValue").keyup(function() {
				search = $("#searchValue").val();
				search = search.replace(/ /gi, "%20");
				if(currVal=="") {
					currVal = search;
				}
				if(search!=currVal) {
					console.log(search);
					if(search.trim()!='') {
// 						console.log("search.trim() : "+search);
// 						console.log("currVal.trim() : "+currVal);
						isSearch = true;
						page = 1;
						$("#movieList").html("");
						searchMovie(search);
						currVal = search;
					} else {
						page=1;
						isSearch=false;
						$("#resultCount").text("${reviewCount}개의 리뷰가 등록되어 있어요.");
						$("#movieList").html("");
						moreReviewList();
					}
				}
			});
			
			function searchMovie(search) {
				$.ajax({
					url: "${contextPath }/searchMovie.re",
					data: {
						search: search,
						page: page
					},
					success: (data)=>{
						if(page<=data[0].totalPages) {
							console.log("영화검색하기"+page+search);
							console.log(data);
							$("#resultCount").text("'"+search.replace(/%20/gi, " ")+"'에 대한 "+data[0].totalResults+"개의 검색결과");
							console.log(data[0]);
							for(var i=1;i<data.length;i++) {
								var div = $('#movieDiv').clone();
								div.css("display", "block");
								div.find('#mId').text(data[i].movieId);
								if(data[i].movieImg!=null) {
									div.find('#movieImg').attr("src", "https://image.tmdb.org/t/p/w300/"+data[i].movieImg);
								}
								div.find('#movieTitle').text(data[i].movieTitle);
								div.find('#genre').text(data[i].genre);
								div.find('#releaseDate').text(data[i].releaseDate);
								div.find('#avgRating').html("<i class='bi bi-star-fill'></i>"+data[i].avgRating);
								div.find('#reviewCount').text(data[i].reviewCount+"개의 리뷰");
								
								$("#movieList").append('<div id="movieDiv" class="col mb-4">'+div.html()+"</div>");
							}
							
							const reviews = document.getElementsByClassName("card");
	
							for(const r of reviews) {
								r.addEventListener('click', function(){
									const movieId=this.querySelector("#mId").innerText;
									location.href='${contextPath}/movieDetail.re?movieId='+movieId;
								});
							}
							page = page+1;
						} else {
							$("#resultCount").text("'"+search.replace(/%20/gi, " ")+"'에 대한 "+data[0].totalResults+"개의 검색결과");
							console.log("검색실패 : else");
						}
					},
					error: (data)=>{
					}
				});
			}
		}
	</script>
	
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
		crossorigin="anonymous">
	</script>
	
</body>
</html>