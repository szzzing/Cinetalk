<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모임게시판 글쓰기</title>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<style>
.main {
	margin: auto;
	margin-top: 30px;
	padding: 20px;
	width: 1200px;
}
#review{
	margin: auto;
	margin-top: 30px;
	padding: 20px;
	width: 1200px;
	word-break:break-all;
}

.tdHover {
	text-align: center;
	width: 600px;
	height: 50px;
	border-top-left-radius: 10px;
	border-top-right-radius: 10px;
	border-bottom-left-radius: 10px;
	border-bottom-right-radius: 10px;
}

.tdHover:hover {
	cursor: pointer;
	background-color: rgba(205, 92, 92, 0.1);;
}


.star-input {
	padding: 25px 15px;
}

.star-input>.input {
	text-align: center;
	margin-top: 10px;
}

.star-input>.input, .star-input>.input>label:hover, .star-input>.input>input:focus+label,
	.star-input>.input>input:checked+label {
	display: inline-block;
	vertical-align: middle;
	background: url('resources/image/grade.png') no-repeat;
}

.star-input {
	width: 100%;
	text-align: center;
}

.score {
	font-size: 18px;
	line-height: 25px;
	color: #fc4c4e;
	font-weight: bold;
	text-align: center;
}
/* .star-input{display:inline-block; white-space:nowrap;width:225px;height:40px;padding:25px;line-height:30px;} */
.star-input>.input {
	display: inline-block;
	width: 150px;
	background-size: 150px;
	height: 28px;
	white-space: nowrap;
	overflow: hidden;
	position: relative;
}

.star-input>.input>input {
	position: absolute;
	width: 1px;
	height: 1px;
	opacity: 0;
}

star-input>.input.focus {
	outline: 1px dotted #ddd;
}

.star-input>.input>label {
	width: 30px;
	height: 0;
	padding: 28px 0 0 0;
	overflow: hidden;
	float: left;
	cursor: pointer;
	position: absolute;
	top: 0;
	left: 0;
}

.star-input>.input>label:hover, .star-input>.input>input:focus+label,
	.star-input>.input>input:checked+label {
	background-size: 150px;
	background-position: 0 bottom;
}

.star-input>.input>label:hover ~label {
	background-image: none;
}

.star-input>.input>label[for="p1_2"] {
	width: 15px;
	z-index: 10;
}

.star-input>.input>label[for="p1"] {
	width: 30px;
	z-index: 9;
}

.star-input>.input>label[for="p2_2"] {
	width: 45px;
	z-index: 8;
}

.star-input>.input>label[for="p2"] {
	width: 60px;
	z-index: 7;
}

.star-input>.input>label[for="p3_2"] {
	width: 75px;
	z-index: 6;
}

.star-input>.input>label[for="p3"] {
	width: 90px;
	z-index: 5;
}

.star-input>.input>label[for="p4_2"] {
	width: 105px;
	z-index: 4;
}

.star-input>.input>label[for="p4"] {
	width: 120px;
	z-index: 3;
}

.star-input>.input>label[for="p5_2"] {
	width: 135px;
	z-index: 2;
}

.star-input>.input>label[for="p5"] {
	width: 150px;
	z-index: 1;
}

.star-input>output {
	display: inline-block;
	width: 60px;
	font-size: 18px;
	text-align: right;
	vertical-align: middle;
}
</style>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
</head>
<body>
	<jsp:include page="../common/top.jsp" />
	<div class="container">
		<div class="align-items-center pt-3 pb-2 mb-3">
			<h1 style="color:#CD5C5C">모임 만들기</h1>
		</div>

		<form action="${contextPath }/insertHangout.ha" method="post">
			<div class="row">
				<div class="col">
					<div class="mb-3">
						<label for="boardTitle" class="form-label">제목</label>
						<input class="form-control" type="text" placeholder="제목을 입력하세요." name="boardTitle" required>
					</div>
					<div class="mb-3">
						<label for="boardContent" class="form-label">내용</label>
						<textarea class="form-control" name="boardContent" placeholder="내용을 입력하세요." rows="9" style="resize: none;" required></textarea>
					</div>
				</div>
				<div class="col">
					<div class="row">
						<div class="col">
							<div class="mb-3">
								<label for="local" class="form-label">지역</label>
								<select class="form-select form-select-sm" name="local">
									<option selected>무관</option>
									<option>서울</option>
									<option>경기</option>
									<option>인천</option>
									<option>대전</option>
									<option>대구</option>
									<option>광주</option>
									<option>부산</option>
									<option>울산</option>
									<option>충북</option>
									<option>충남</option>
									<option>전북</option>
									<option>전남</option>
									<option>경북</option>
									<option>경남</option>
									<option>강원</option>
									<option>제주</option>
								</select>
							</div>
							<div class="col">
								<div class="mb-3">
									<label for="gender" class="form-label">성별</label>
									<select class="form-select form-select-sm" name="gender">
										<option selected>무관</option>
										<option>남성</option>
										<option>여성</option>
									</select>
								</div>
							</div>
							<div class="col">
								<div class="mb-3">
									<label for="age" class="form-label">연령</label>
									<select class="form-select form-select-sm" name="age">
										<option selected>무관</option>
										<option>10대</option>
										<option>20대</option>
										<option>30대</option>
										<option>40대</option>
										<option>50대</option>
									</select>
								</div>
							</div>
							<div class="col">
								<div class="mb-3">
									<label for="hangoutNumber" class="form-label">인원</label>
									<select class="form-select form-select-sm" name="hangoutNumber">
										<option selected value="1">1명</option>
										<option value="2">2명</option>
										<option value="3">3명</option>
										<option value="4">4명</option>
										<option value="5">5명</option>
										<option value="6">6명</option>
										<option value="7">7명</option>
										<option value="8">8명</option>
										<option value="9">9명</option>
										<option value="10">10명</option>
									</select>
								</div>
							</div>
						</div>
						<div class="col">
							<div class="col">
								<div class="mb-3 d-grid gap-0">
									<label for="movie" class="form-label">영화</label>
									<input type="hidden" name="movieId">
									<div class="row">
										<div class="col-md-auto">
											<input type="text" class="form-control" name="movieTitle" placeholder="영화를 선택하지 않았습니다." readonly data-bs-toggle="modal" data-bs-target="#selectMovieModal">
										</div>
										<div class="col-md-auto" style="padding-left:0px !important; padding-right:0px !important">
											<button type="button" class="deleteMovie btn-close" style="vertical-align:center"></button>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col">
						<div class="mb-3 d-grid gap-0">
							<button type="submit" id="submit" class="btn btn-sm btn-outline-danger" style="align:bottom !important">작성하기</button>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
	<script>
		$("#submit").on("click", function(){
			console.log("submit");
			var boardContent = $("textarea").val();
			boardContent = boardContent.replace(/(?:\r\n|\r|\n)/g, '<br/>');
			$("textarea").val(boardContent);
			if($("input[name=movieId]").val()=="") {
				$("input[name=movieId]").remove();
			}
		});
		
		$(".deleteMovie").on("click", function(){
			$("input[name=movieTitle]").val("");
			$("input[name=movieId]").val("");
		});
	</script>
	
	<!-- 모달 -->
	<div id="selectMovieModal" class="modal fade" tabindex="-1">
		<div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">영화 선택하기</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
				
					<h6 id="resultCount" class="text-muted">함께 보고싶은 영화를 선택하세요.</h6>
					<div class="align-items-center pt-3 pb-2 mb-3">
						<div id="searchMovieForm" style="margin-bottom:30px">
							<input id="searchValue" class="form-control form-control-lg" type="text" placeholder="찾고싶은 영화를 검색하세요." aria-label="Search">
						</div>
					</div>
						
					<div class="container">
						<div id="movieList">
						</div>
					</div>
					
					<div id="movieDiv" style="display:none;">
						<div style="margin-bottom:1em">
						<div class="card" data-bs-dismiss="modal" aria-label="Close">
							<div class="row">
								<div class="col-md-auto">
									<div id="movieId" style="display:none;"></div>
									<img id="movieImg" class="img-fluid rounded-start" src="#" width="70px" height="100px" style="background: lightgray">
									<span style="padding:1em">
										<h6 id="movieTitle" class="card-title" style="display:inline-block"></h6>
										<small id="genre" class="text-muted"></small>
									</span>
								</div>
							</div>
						</div>
						</div>
					</div>
						
					<div id="searchScrollerFooter"></div>	<!-- 무한스크롤 감지 -->
				
					<script>
						window.onload=()=>{
							var page = 1;	// 페이지
							var isSearch = false;
							
							// 영화 검색 무한스크롤
							const sio = new IntersectionObserver((entries, observer)=>{
								entries.forEach(entry=>{
									if(!entry.isIntersecting) {
										return; 
									}
									if(isSearch) {
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
										isSearch = true;
										page = 1;
										$("#movieList").html("");
										searchMovie(search);
										currVal = search;
									} else {
										page=1;
										isSearch=false;
										$("#resultCount").text("같이 보고싶은 영화를 선택하세요.");
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
											$("#resultCount").text("'"+search.replace(/%20/gi, " ")+"'에 대한 "+data[0].totalResults+"개의 검색결과");
											for(var i=1;i<data.length;i++) {
												var div = $('#movieDiv').clone();
												div.css("display", "block");
												div.find('#movieId').text(data[i].movieId);
												if(data[i].movieImg!=null) {
													div.find('#movieImg').attr("src", "https://image.tmdb.org/t/p/w300/"+data[i].movieImg);
												}
												div.find('#movieTitle').text(data[i].movieTitle);
												div.find('#genre').text(data[i].genre);
												div.find('#releaseDate').text(data[i].releaseDate);
												div.find('#avgRating').text("★"+data[i].avgRating);
												div.find('#reviewCount').text(data[i].reviewCount+"개의 리뷰");
												
												$("#movieList").append(div.html());
											}
											
											$(".card").on("click", function(){
												movieTitle = $(this).find("#movieTitle").text();
												movieId = $(this).find("#movieId").text();
												$("input[name=movieTitle]").val(movieTitle);
												$("input[name=movieId]").val(movieId);
											});
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
				</div>
				<div class="modal-footer">
				</div>
			</div>
		</div>
	</div>
</body>
</html>