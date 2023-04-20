<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<style>
.movieInfo {
	margin: auto;
	margin-top: 30px;
	padding: 20px;
	width: 1300px;
}

#movieComment {
	margin: auto;
	margin-top: 30px;
	padding: 20px;
	width: 1300px;
}

#moreComment {
	float: right;
}

#moreComment:hover {
	cursor: pointer;
	text-decoration: underline;
	font-weight: bold;
}

#commentCard{
	cursor : pointer;
}

ul li {
	list-style: none;
	float: left;
	padding: 10px;
}

#trComment td {
	padding: 40px;
	text-align: center;
	height: 100px;
	font-size: 25px;
}

#movieCommentHead h3 {
	display: inline;
}

#avgRating {
	padding: 25px;
	font-size: 20px;
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
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
</head>
<body>
	<jsp:include page="../common/top.jsp" />
	<div class="movieInfo">
		<table class="table">
			<tr>
				<td rowspan="3" scope="col" width="300">
					<img src="https://image.tmdb.org/t/p/w300/${ m.movieImg }" style="margin-left: auto; margin-right: auto; display: block;">
				</td>
				<td colspan="3" height="200">
					<h1>${ m.movieTitle }</h1><br>
					<c:set var="yyyy" value="${ fn:split(m.releaseDate, '-')[0] }" />
					<h4>${ yyyy }•${ m.genre }</h4>
				</td>
			</tr>
			<tr>
				<td scope="row" colspan="2" id="avgRating"></td>
			</tr>
			<tr id="trComment" height="200">
				<c:if test="${ !empty loginUser }">
					<td scope="row" width="200">좋아요&nbsp;
						<small id="movieLikeCounting">${ allHeartCount }개</small><br> 
						<c:if test="${ movieLikeCount == 1}">
							<div>
								<i class="heart-click bi-heart-fill" style="font-size: 3rem; color: #CD5C5C; cursor: pointer;"id="movieLikeCancel"></i>
							</div>
						</c:if>
						<c:if test="${ movieLikeCount == 0}">
							<div>
								<i class="heart-click bi-heart" style="font-size: 3rem; color: #CD5C5C; cursor: pointer;"id="movieLike"></i>
							</div>
						</c:if>
					</td>
				</c:if>	
				<c:if test="${ empty loginUser }">
					<td scope="row" width="200" >좋아요&nbsp;
						<small>${ allHeartCount }개</small><br>
						<i class="bi-heart" style="font-size: 3rem; color: #CD5C5C; cursor: pointer;" data-bs-toggle="modal" data-bs-target="#loginModal"></i>
					</td>
				</c:if>
				<c:if test="${ !empty loginUser }">
					<td scope="row" width="200">
						<span>코멘트</span> <br> 
						<c:if test="${ already }">
							<i class="bi bi-pencil" style="font-size: 3rem; color: #CD5C5C;" id="already"></i>
								<div id="liveAlertPlaceholder"></div>
						</c:if> 
						<c:if test="${ !already }">
							<i class="bi bi-pencil" style="font-size: 3rem; color: #CD5C5C; cursor: pointer;" id="comment" data-bs-toggle="modal" data-bs-target="#exampleModal"></i>
						</c:if>
					</td>
				</c:if>
				<c:if test="${ empty loginUser }">
					<td scope="row" width="200">
						<span>코멘트</span><br> 
						<i class="bi bi-pencil" style="font-size: 3rem; color: #CD5C5C; cursor: pointer;" data-bs-toggle="modal" data-bs-target="#loginModal"></i>
					</td>
				</c:if>
			</tr>
		</table>
	</div>
	
	
	<div class="movieInfo">
		<input type="hidden" id="movieId2" name="movieId2" value="${ m.movieId }">
		<table class="table">
			<tr>
				<th scope="col" colspan="2" style="font-size: 25px;">기본정보</th>
			</tr>
			<tr>
				<th width="150">영화제목</th>
				<td id="movieTitle">${ m.movieTitle }</td>
			</tr>
			<tr>
				<th>감독</th>
				<td>${ m.director }</td>
			</tr>
			<tr>
				<th>출연배우</th>
				<td>${ m.actor }</td>
			</tr>
			<tr>
				<th>제작년도 • 장르</th>
				<td>${ yyyy } • ${ m.genre }</td>
			</tr>
			<tr>
				<th>상영시간</th>
				<td>${ m.runtime }분</td>
			</tr>
			<tr>
				<th>줄거리</th>
				<td>${ m.overview }</td>
			</tr>
		</table>
	</div>
	
	
	<div id="movieComment">
		<div id="movieCommentHead">
			<h3 style="color: #CD5C5C;">여러분의 소중한 리뷰입니다.</h3>
			<c:if test="${ !empty list  }">
				<span id="moreComment">리뷰 더보기</span>
			</c:if>
			<br> <br>
		</div>
		<c:if test="${ !empty list  }">
			<c:forEach items="${ list }" var="r" begin="0" end="5">
				<div id="commentCard">
					<ul>
						<li>
							<div class="card" style="width: 20rem;">
								<div class="card-body" >
									<input type="hidden" id="boardId" name="boardId" value="${ r.boardId }">
									<h6 class="mb-0">${ m.movieTitle }</h6>
									<br><small class="mb-1 text-muted">${ r.nickName }</small>
									<p class="mb-1 text-muted">★${ r.movieRating }</p>
									<br>
									<c:set var="title" value='${ r.boardTitle }' />
									<h5 class="mb-0">${fn:substring(title,0,20) }
										<c:if test="${fn:length(title) gt 20 }">...</c:if>
									</h5>
									<br>
									<c:set var="content" value='${ r.boardContent }' />
									<p class="card-text">${fn:substring(content,0,25) }
										<c:if test="${fn:length(content) gt 25 }">...</c:if>
									</p>
									<small class="mb-1 text-muted">${ r.modifyDate }&nbsp;&nbsp;</small>
									<small class="text-right" style="color: #CD5C5C;">좋아요
										${ r.likeCount }&nbsp;&nbsp;댓글 ${ r.commentCount }</small>
								</div>
							</div>
						</li>
					</ul>
				</div>
			</c:forEach>
		</c:if>
		
		<c:if test="${ empty list  }">
			<div class="alert alert-danger" role="alert">아직 작성된 리뷰가 없습니다. 여러분이 이 영화의 첫 번째 작성자가 되어주세요!</div>
		</c:if>
		<br clear="all">
		
		<!-- Modal -->
		<c:if test="${ !empty loginUser  }">
			<div class="modal fade" id="exampleModal" tabindex="-1"
				aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-lg modal-dialog-centered">
					<div class="modal-content">
						<form name="myform" id="myform" action="${ contextPath }/insertMovieReview.re" method="post">
							<div class="modal-header">
								<h3 style="color: #CD5C5C;">여러분의 리뷰를 작성해주세요</h3>
								<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
							</div>
							<div class="modal-body">
								<div class="star-input">
									<h4>별점을 입력해주세요.</h4>
									<span class="input">
										<input type="radio" name="star-input" value="1" id="p1">
										<label for="p1">1</label>
										<input type="radio" name="star-input" value="0.5" id="p1_2">
										<label for="p1_2">0.5</label>
										<input type="radio" name="star-input" value="2" id="p2">
										<label for="p2">2</label>
										<input type="radio" name="star-input" value="1.5" id="p2_2">
										<label for="p2_2">1.5</label>
										<input type="radio" name="star-input" value="3" id="p3">
										<label for="p3">3</label>
										<input type="radio" name="star-input" value="2.5" id="p3_2">
										<label for="p3_2">2.5</label>
										<input type="radio" name="star-input" value="4" id="p4">
										<label for="p4">4</label>
										<input type="radio" name="star-input" value="3.5" id="p4_2">
										<label for="p4_2">3.5</label>
										<input type="radio" name="star-input" value="5" id="p5">
										<label for="p5">5</label>
										<input type="radio" name="star-input" value="4.5" id="p5_2">
										<label for="p5_2">4.5</label>
									</span>
									<output for="star-input">
										<b id="rating" name="rating">0</b>점
									</output>
									<input type="hidden" id="movieId" name="movieId" value="${ m.movieId }">
									<input type="hidden" id="movieRating" name="movieRating" value="0">
								</div>
								<div>
									<input type="text" class="form-control" id="boardTitle" name="boardTitle" placeholder="제목을 적어주세요."><br>
									<textarea class="form-control" placeholder="여러분의 리뷰를 작성해주세요." id="boardContent" name="boardContent" style="height: 300px;"></textarea>
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-light" data-bs-dismiss="modal">창 닫기</button>
								<button type="submit" class="btn btn-outline-light" style="background-color: #CD5C5C;" id="reviewSubmit">리뷰 작성하기</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</c:if>
		<c:if test="${ empty loginUser  }">
			<div class="modal fade" id="loginModal" tabindex="-1"
				aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-lg modal-dialog-centered">
					<div class="modal-content">
						<div class="modal-header">
							<h3 style="color: #CD5C5C;">로그인 후 이용해주세요.</h3>
							<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-danger" data-bs-dismiss="modal" style="background-color: #CD5C5C;">창 닫기</button>
						</div>
					</div>
				</div>
			</div>
		</c:if>
	</div>
	<jsp:include page="../common/footer.jsp" />
<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
		crossorigin="anonymous">
  </script>
<script>
 
	  // 별점 구현
	   var starRating = function(){
	      var $star = $(".star-input"),
	          $result = $star.find("output>b");
	         
	           $(document).on("focusin", ".star-input>.input",function(){
	                $(this).addClass("focus");
	          })
	             
	            .on("focusout", ".star-input>.input", function(){
	             var $this = $(this);
	             setTimeout(function(){
	                  if($this.find(":focus").length === 0){
	                      $this.removeClass("focus");
	                  }
	               }, 100);
	           })
	        
	          .on("change", ".star-input :radio", function(){
	             $result.text($(this).next().text());
	           })
	          .on("mouseover", ".star-input label", function(){
	             $result.text($(this).text());
	             document.getElementById("movieRating").value = $result.text();
	             console.log($result.text());
	          })
	         .on("mouseleave", ".star-input>.input", function(){
	             var $checked = $star.find(":checked");
	                if($checked.length === 0){
	                     $result.text("0");
	                   } else {
	                     $result.text($checked.next().text());
	                }
	           });
	      };
	      starRating();

	            
	            
	         // 리뷰 더보기로 이동
	      window.onload = () => {
	         document.getElementById("moreComment").addEventListener('click', ()=>{
	           const movieId = document.getElementById("movieId2").value;
	           const movieTitle = document.getElementById("movieTitle").innerText;
//	            console.log(movieTitle);
	            location.href='${contextPath}/movieReviewList.re?movieId='+movieId+'&movieTitle=' + movieTitle;
	         });
	      }
		      
		   // 평점 구하기
		//    console.log(${ review.movieRating });
		   
		   const avgRating = document.getElementById("avgRating");
		   const rating = '${ review.movieRating }';
// 		   console.log(rating);
		   
		   let print = '';
		   
		   if(rating >= 5 ){
		      print = '평균점수 '+ rating + '점 <i class="bi bi-star-fill"></i><i class="bi bi-star-fill"><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i>';
		   }else if(rating >= 4.5){
		      print = '평균점수 '+ rating + '점 <i class="bi bi-star-fill"></i><i class="bi bi-star-fill"><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-half"></i>';
		   } else if (rating >= 4.0) {
		      print = '평균점수 '+ rating + '점 <i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star"></i>';
		   } else if(rating >= 3.5){
		      print = '평균점수 '+ rating + '점 <i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-half"></i><i class="bi bi-star"></i>';
		   } else if(rating >= 3.0){
		      print = '평균점수 '+ rating + '점 <i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star"></i><i class="bi bi-star"></i>';
		   } else if(rating >= 2.5){
		      print = '평균점수 '+ rating + '점 <i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-half"></i><i class="bi bi-star"></i><i class="bi bi-star"></i>';
		   } else if(rating >= 2.0){
		      print = '평균점수 '+ rating + '점 <i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i>';
		   } else if(rating >= 1.5){
		      print = '평균점수 '+ rating + '점 <i class="bi bi-star-fill"><i class="bi bi-star-half"></i><i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i>';
		   }else if(rating >= 1.0){
		      print = '평균점수 '+ rating + '점 <i class="bi bi-star-fill"></i><i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i>';
		   } else if(rating >= 0.5){
		      print = '평균점수 '+ rating + '점 <i class="bi bi-star-half"></i><i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i>';
		   } else if(rating > 0){
		      print = '평균점수 '+ rating + '점 <i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i>';
		   } else{
			   print = '평균점수 0점 <i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i><i class="bi bi-star"></i>';
		   }
		   
		   avgRating.innerHTML = print;
	   
	      
	      //  코멘트 비활성화 클릭시
	      
			const alertPlaceholder = document.getElementById('liveAlertPlaceholder');
			
			const alreadyAlert = (message, type) => {
				alertPlaceholder.innerHTML="";
			  const wrapper = document.createElement('div');
			  wrapper.innerHTML = [
			    `<div class="alert alert-${type} alert-dismissible" role="alert">`,
			    `   <div>이미 리뷰를 작성하셨습니다!<div>`,
			    '   <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>',
			    '</div>'
			  ].join('');
			  alertPlaceholder.append(wrapper);
			}
			      
			const alertTrigger = document.getElementById('already');
			if (alertTrigger) {
			  alertTrigger.addEventListener('click', () => {
			     alreadyAlert('Nice, you triggered this alert message!', 'success')
			  });
			}

			
			
			
			// 좋아요 구현
			const heartClick = $(".heart-click");
			heartClick.click(function(){
				if($(this).attr("class") == "heart-click bi-heart"){
			         $.ajax({
				            url: '${contextPath}/insertMovieLike.re',
				            data: {movieId: ${ m.movieId }},
				            type: 'post',
				            success:(data)=>{
			   				 console.log(data);
			   				 $('#movieLikeCounting').text(data + "개");
				            },
				            error: (data)=>{
			    				console.log(data);
			    			}
				         });
					
			         $(this).attr("class","heart-click bi-heart-fill");
			         
				}else if($(this).attr("class") == "heart-click bi-heart-fill"){
			         $.ajax({
				            url: '${contextPath}/deleteMovieLike.re',
				            data: {movieId: ${ m.movieId }},
				            type: 'post',
				            success:(data)=>{
			   				 console.log(data);
			   				 $('#movieLikeCounting').text(data + "개");
				            },
				            error: (data)=>{
			    				console.log(data);
			    			}
				         });
			         
			         $(this).attr("class","heart-click bi-heart");
				}
			})
			
			
	     // 코멘트 클릭 시 코멘트 상세페이지로 넘어가기
	     
	     const divs = document.querySelectorAll('.card-body');
//	    		console.log(divs);
	   		
	   		for( const div of divs){
	   			div.addEventListener('click', function(){
	   				const input = this.querySelectorAll('input');
	   				const boardId = input[0].value;
	   				const small = this.querySelectorAll('small');
	   				const writer = small[0].innerText;
	   				const head = this.querySelectorAll('h6');
	   				const movieTitle = head[0].innerText;
	   				
	   				location.href='${contextPath}/movieReviewDetail.re?boardId=' + boardId + '&writer=' + writer + '&movieTitle=' + movieTitle; 
//	    				console.log(boardId);
	   			});
	   			
	   		}
	      
      
      
      
      
      
      
      
      
   
   </script>


</body>
</html>