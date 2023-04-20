<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모임게시판 글수정</title>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<style>
</style>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
</head>
<body>
	<jsp:include page="../common/top.jsp" />
	<div class="container">
		<div class="align-items-center pt-3 pb-2 mb-3">
			<h1 style="color:#CD5C5C">모임 수정하기</h1>
		</div>

		<form action="${contextPath }/updateHangout.ha" method="post">
			<input type="hidden" name="boardId" value=${h.boardId }>
			<div class="row">
				<div class="col">
					<div class="mb-3">
						<label for="boardTitle" class="form-label">제목</label>
						<input class="form-control" type="text" placeholder="제목을 입력하세요." name="boardTitle" value="${h.boardTitle }" required>
					</div>
					<div class="mb-3">
						<label for="boardContent" class="form-label">내용</label>
						<textarea class="form-control" name="boardContent" placeholder="내용을 입력하세요." rows="9" style="resize: none;" required>${h.boardContent }</textarea>
					</div>
				</div>
				<div class="col">
					<div class="row">
						<div class="col">
							<div class="mb-3">
								<label for="local" class="form-label">지역</label>
								<select class="form-select form-select-sm" name="local">
									<option <c:if test="${h.local=='무관' }">selected</c:if>>무관</option>
									<option <c:if test="${h.local=='서울' }">selected</c:if>>서울</option>
									<option <c:if test="${h.local=='경기' }">selected</c:if>>경기</option>
									<option <c:if test="${h.local=='인천' }">selected</c:if>>인천</option>
									<option <c:if test="${h.local=='대전' }">selected</c:if>>대전</option>
									<option <c:if test="${h.local=='대구' }">selected</c:if>>대구</option>
									<option <c:if test="${h.local=='광주' }">selected</c:if>>광주</option>
									<option <c:if test="${h.local=='부산' }">selected</c:if>>부산</option>
									<option <c:if test="${h.local=='울산' }">selected</c:if>>울산</option>
									<option <c:if test="${h.local=='충북' }">selected</c:if>>충북</option>
									<option <c:if test="${h.local=='충남' }">selected</c:if>>충남</option>
									<option <c:if test="${h.local=='전북' }">selected</c:if>>전북</option>
									<option <c:if test="${h.local=='전남' }">selected</c:if>>전남</option>
									<option <c:if test="${h.local=='경북' }">selected</c:if>>경북</option>
									<option <c:if test="${h.local=='경남' }">selected</c:if>>경남</option>
									<option <c:if test="${h.local=='강원' }">selected</c:if>>강원</option>
									<option <c:if test="${h.local=='제주' }">selected</c:if>>제주</option>
								</select>
							</div>
							<div class="col">
								<div class="mb-3">
									<label for="gender" class="form-label">성별</label>
									<select class="form-select form-select-sm" name="gender">
										<option <c:if test="${h.gender=='무관' }">selected</c:if>>무관</option>
										<option <c:if test="${h.gender=='남성' }">selected</c:if>>남성</option>
										<option <c:if test="${h.gender=='여성' }">selected</c:if>>여성</option>
									</select>
								</div>
							</div>
							<div class="col">
								<div class="mb-3">
									<label for="age" class="form-label">연령</label>
									<select class="form-select form-select-sm" name="age">
										<option <c:if test="${h.age=='무관' }">selected</c:if>>무관</option>
										<option <c:if test="${h.age=='10대' }">selected</c:if>>10대</option>
										<option <c:if test="${h.age=='20대' }">selected</c:if>>20대</option>
										<option <c:if test="${h.age=='30대' }">selected</c:if>>30대</option>
										<option <c:if test="${h.age=='40대' }">selected</c:if>>40대</option>
										<option <c:if test="${h.age=='50대' }">selected</c:if>>50대</option>
									</select>
								</div>
							</div>
							<div class="col">
								<div class="mb-3">
									<label for="hangoutNumber" class="form-label">인원</label>
									<select class="form-select form-select-sm" name="hangoutNumber">
										<c:if test="${h.nowNumber<=1 }"><option value="1" <c:if test="${h.hangoutNumber==1 }">selected</c:if>>1명</option></c:if>
										<c:if test="${h.nowNumber<=2 }"><option value="2" <c:if test="${h.hangoutNumber==2 }">selected</c:if>>2명</option></c:if>
										<c:if test="${h.nowNumber<=3 }"><option value="3" <c:if test="${h.hangoutNumber==3 }">selected</c:if>>3명</option></c:if>
										<c:if test="${h.nowNumber<=4 }"><option value="4" <c:if test="${h.hangoutNumber==4 }">selected</c:if>>4명</option></c:if>
										<c:if test="${h.nowNumber<=5 }"><option value="5" <c:if test="${h.hangoutNumber==5 }">selected</c:if>>5명</option></c:if>
										<c:if test="${h.nowNumber<=6 }"><option value="6" <c:if test="${h.hangoutNumber==6 }">selected</c:if>>6명</option></c:if>
										<c:if test="${h.nowNumber<=7 }"><option value="7" <c:if test="${h.hangoutNumber==7 }">selected</c:if>>7명</option></c:if>
										<c:if test="${h.nowNumber<=8 }"><option value="8" <c:if test="${h.hangoutNumber==8 }">selected</c:if>>8명</option></c:if>
										<c:if test="${h.nowNumber<=9 }"><option value="9" <c:if test="${h.hangoutNumber==9 }">selected</c:if>>9명</option></c:if>
										<c:if test="${h.nowNumber<=10 }"><option value="10" <c:if test="${h.hangoutNumber==10 }">selected</c:if>>10명</option></c:if>
									</select>
								</div>
							</div>
						</div>
						<div class="col">
							<div class="col">
								<div class="mb-3 d-grid gap-0">
									<label for="movie" class="form-label">영화</label>
									<input type="hidden" name="movieId" <c:if test="${h.movieId !=null }">value="${h.movieId }"</c:if>>
									<div class="row">
										<div class="col-md-auto">
											<input type="text" class="form-control" name="movieTitle" placeholder="영화를 선택하지 않았습니다." readonly data-bs-toggle="modal" data-bs-target="#selectMovieModal"
												<c:if test="${h.movieId !=null }">value="${m.movieTitle }"</c:if>
											>
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
				
						<h6 id="resultCount" class="text-muted">같이 보고싶은 영화를 선택하세요.</h6>
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
												const movieTitle = $(this).find("#movieTitle").text();
												const movieId = $(this).find("#movieId").text();
												
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
</html></body>
</html>