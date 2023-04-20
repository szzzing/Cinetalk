<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<title>모임게시판</title>
<style>
	.form-control-dark {
		color: #fff;
		background-color: rgba(255, 255, 255, .1);
		border-color: rgba(255, 255, 255, .1);
	}
	.form-control-dark:focus {
		border-color: transparent;
		box-shadow: 0 0 0 3px rgba(255, 255, 255, .25);
	}
	.hangoutDiv {
		cursor: pointer;
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
	<jsp:include page="../common/top.jsp" />
	<div id="hangoutBoardView" class="container">
		<div class="align-items-center pt-3 pb-2 mb-3">
			<h1 style="color:#CD5C5C">모임게시판</h1>
			<h5 id="resultCount" class="text-muted">${hangoutCount }개의 모임이 등록되어 있어요.</h5>
			<c:if test="${!empty loginUser }">
				<button type="button" class="btn btn-outline-danger" onclick="location.href='${contextPath}/writeHangout.ha'">모임 만들기</button>
			</c:if>
			<div id="searchHangoutForm" style="margin-top:30px; margin-bottom:30px">
					<div class="row">
						<div class="col mb-3">
							<label for="local" class="form-label">지역</label>
							<select class="form-select form-select-sm" name="local">
								<option selected>전체</option>
								<option >무관</option>
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
						<div class="col mb-3">
							<label for="gender" class="form-label">성별</label>
							<select class="form-select form-select-sm" name="gender">
								<option selected>전체</option>
								<option >무관</option>
								<option>남성</option>
								<option>여성</option>
							</select>
						</div>
						<div class="col mb-3">
							<label for="age" class="form-label">연령</label>
							<select class="form-select form-select-sm" name="age">
								<option selected>전체</option>
								<option >무관</option>
								<option>10대</option>
								<option>20대</option>
								<option>30대</option>
								<option>40대</option>
								<option>50대</option>
							</select>
						</div>
						<div class="col mb-3">
							<label for="hangoutNumber" class="form-label">인원</label>
							<select class="form-select form-select-sm" name="hangoutNumber">
								<option selected value="0">전체</option>
								<option value="1">1명</option>
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
				<input id="searchValue" class="form-control form-control-lg" type="text" placeholder="찾고싶은 모임을 검색하세요." aria-label="Search">
			</div>
		</div>
		<div id="hangoutList" class="row row-cols-1 row-cols-sm-1 row-cols-md-1 row-cols-lg-3 justify-content-start">
			<div class="div" style="display:none">
				<div class="hangoutDiv col mb-4">
			        <div class="card card-cover h-100 overflow-hidden rounded-5">
						<div class="boardId" style="display:none">boardId</div>
						<div class="boardWriter" style="display:none">boardWriter</div>
						<div class="d-flex flex-column p-5">
							<div class="mb-auto">
								<h3 class="boardTitle mb-2 lh-1 fw-bold">boardTitle</h3>
								<p class="nickName card-text">nickName</p>
							</div>
							<table class="mt-4 mb-4">
								<tr>
									<td class="text-muted" width="70px">
										<i class="bi bi-geo-alt-fill"></i>
										지역
									</td>
									<td class="local">
										local
									</td>
								</tr>
								<tr>
									<td class="text-muted">
										<i class="bi bi-gender-female"></i>
										성별
									</td>
									<td class="gender">
										gender
									</td>
								</tr>
								<tr>
									<td class="text-muted">
										<i class="bi bi-clipboard-fill"></i>
										연령
									</td>
									<td class="age">
										age
									</td>
								</tr>
								<tr>
									<td class="text-muted">
										<i class="bi bi-person-fill"></i>
										인원
									</td>
									<td class="hangoutNumber">
										hangoutNumber
									</td>
								</tr>
								<tr>
									<td class="text-muted">
										<i class="bi bi-camera-reels-fill"></i>
										영화
									</td>
									<td class="movie">
										movieTitle(genre)
									</td>
								</tr>
							</table>
							<table class="text-muted mt-auto mb-0">
								<tr>
									<td class="createDate" colspan="3">createDate</td>
								</tr>
							</table>
							<table>
								<tr>
									<td class="boardCount" width="40px">
									</td>
									<td class="interestCount" width="40px">
									</td>
									<td class="joinCount" width="40px">
									</td>
								</tr>
							</table>
						</div>
			        </div>
				</div>
			</div>
		</div>
		
	</div>
	
	<div id="searchScrollerFooter"></div>	<!-- 무한스크롤 감지 -->
	
	<jsp:include page="../common/footer.jsp"/>
	
	<script>
		var page = 1;
		var div = $(".div").clone();
		
		// 검색 입력
		var currVal = "";
		var search = "";
		$("#searchValue").keyup(function() {
// 			search = $("#searchValue").val();
			page = 1;
			searchHangout();
			console.log("key");
// 			if(currVal=="") {
// 				currVal = search;
// 			}
// 			if(search!=currVal) {
// 				console.log(search);
// 				if(search.trim()!='') {
// 					console.log("search : "+search);
// 					console.log("currVal : "+currVal);
// 					page = 1;
// 					$("#hangoutList").html("");
// 					searchHangout();
// 					currVal = search;
// 					console.log(search);
// 				} else {
// 					page=1;
// 					$("#resultCount").text("${hangoutCount }개의 모임이 등록되어 있어요.");
// 					$("#hangoutList").html("");
// 					searchHangout();
// 				}
// 			}
		});
		
		function searchHangout() {
			$.ajax({
				url: "${contextPath }/searchHangout.ha",
				data: {
					page: page,
					search: $('#searchValue').val(),
					local: $('select[name=local]').val(),
					gender: $('select[name=gender]').val(),
					age: $('select[name=age]').val(),
					hangoutNumber: $('select[name=hangoutNumber]').val(),
				},
				success: (data)=>{
					if(page==1) {
						$("#hangoutList").html("");
					}
					console.log("최대 페이지 : "+data[0].maxPage);
					console.log("검색 결과수 : "+data[0].resultCount);
					if(page<=data[0].maxPage) {
						console.log("현재 페이지 : "+page)
						for(var i=1 ; i<data.length ; i++) {
							div.prop("style").removeProperty("display");
							div.find(".boardId").text(data[i].boardId);
							div.find(".boardWriter").text(data[i].boardWriter);
							div.find(".boardTitle").text(data[i].boardTitle);
							div.find(".nickName").text(data[i].nickName);
							div.find(".gender").text(data[i].gender);
							if(data[i].isClose=='Y') {
								var hangoutNumber = "모집완료";
							} else {
								var hangoutNumber = "현재 "+data[i].nowNumber+"명 / 최대 "+data[i].hangoutNumber+"명";
							}
							div.find(".hangoutNumber").text(hangoutNumber);
							if(data[i].isMovie==true) {
								var movie = data[i].movieTitle+"("+data[i].genre+")";
							} else {
								var movie = "없음";
							}
							div.find(".movie").text(movie);
							div.find(".age").text(data[i].age);
							div.find(".local").text(data[i].local);
							div.find(".createDate").text(data[i].createDate);
							div.find(".boardCount").html('<i class="bi bi-eye"></i>'+data[i].boardCount);
							div.find(".interestCount").html('<i class="bi bi-heart"></i>'+data[i].interestCount);
							div.find(".joinCount").html('<i class="bi bi-bookmark"></i>'+data[i].joinCount);
							
							$("#hangoutList").append(div.html());
						}
					}
					page = page+1;
				},
				error : (data)=>{
					console.log(data);
				}
			});
		}
		
		// 검색 무한스크롤
		const sio = new IntersectionObserver((entries, observer)=>{
			entries.forEach(entry=>{
				if(!entry.isIntersecting) {
					return; 
				}
				if(true) {
					console.log("검색스크롤");
					observer.observe(document.getElementById('searchScrollerFooter'));
					searchHangout();
				}
			});
		});
		sio.observe(document.getElementById('searchScrollerFooter'));
		
		$(document).on('click', ".hangoutDiv", function(){
			const boardId = $(this).find(".boardId").text();
			const boardWriter = $(this).find(".boardWriter").text();
			location.href="${contextPath }/hangoutDetail.ha?boardId="+boardId+"&writer="+boardWriter;
		});
		
		$("#searchHangoutForm").find("select").on("click", function(){
			page = 1;
			searchHangout();
		});
	</script>
	
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
		crossorigin="anonymous">
	</script>
</body>
</html>