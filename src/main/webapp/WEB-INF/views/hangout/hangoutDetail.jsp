<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모임게시판 상세보기</title>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<style>

#hangoutMovie {
	cursor: pointer;
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
	background-color: rgba(205, 92, 92, 0.1);
}

.myHover:hover {
	cursor: pointer;
	background-color: rgba(205, 92, 92, 0.1);
}

.addChildCommentButton {
	cursor: pointer;
}
.addChildCommentButton:hover {
	cursor: pointer;
	text-decoration: underline;
}

</style>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
</head>
<body>
	<jsp:include page="../common/top.jsp"/>
	<div class="container">
		<div id="hangoutDetail" class="mt-5 mb-5">
			<form id="modifyHangoutView" method="post">
				<input type="hidden" id="boardId" name="boardId" value="${h.boardId }">
				<input type="hidden" id="writer" name="writer" value="${h.boardWriter}">
				<table class="table table-borderless">
					<tr>
						<td scope="col" colspan="2">
							<i class="bi bi-person-fill" style="font-size: 2rem;"></i>
							<h5 style="display: inline;">${ h.nickName }</h5>
						</td>
					</tr>
					<tr>
						<td scope="col" colspan="2"><h2>${ h.boardTitle }</h2></td>
					</tr>
					<tr>
						<td scope="row" width="120px"><span class="text-muted">${ h.modifyDate }</span></td>
						<td scope="row" class="text-muted">
							<i class="bi bi-eye"></i>
							${ h.boardCount }
						</td>
					</tr>
					<tr>
						<td scope="row" colspan="2"><p>${ h.boardContent }</p></td>
					</tr>
					<tr>
						<td scope="col" colspan="2">
							<div class="hangoutDiv col mb-4" style="max-width:500px">
						        <div class="card card-cover h-100 overflow-hidden rounded-5">
									<div class="boardId" style="display:none">${h.boardId }</div>
									<div class="d-flex flex-column p-5">
										<div class="mb-auto">
											<h4 class="mb-2 lh-1 fw-bold">모임 정보</h4>
										</div>
										<table class="mt-4 md-auto">
											<tr>
												<td class="text-muted" width="70px">
													<i class="bi bi-geo-alt-fill"></i>
													지역
												</td>
												<td>
													${h.local }
												</td>
											</tr>
											<tr>
												<td class="text-muted">
													<i class="bi bi-gender-female"></i>
													성별
												</td>
												<td>
													${h.gender }
												</td>
											</tr>
											<tr>
												<td class="text-muted">
													<i class="bi bi-clipboard-fill"></i>
													연령
												</td>
												<td>
													${h.age }
												</td>
											</tr>
											<tr>
												<td class="text-muted">
													<i class="bi bi-person-fill"></i>
													인원
												</td>
												<td>
													현재 <span id="nowNumber">${h.nowNumber }명</span> / 최대 ${h.hangoutNumber }명
												</td>
											</tr>
											<tr>
												<td class="text-muted">
													<i class="bi bi-camera-reels-fill"></i>
													영화
												</td>
												<td id="hangoutMovie">
													<c:if test="${h.movieId==null }">
														없음
													</c:if>
													<c:if test="${h.movieId!=null }">
														<span id="movieId" style="display:none">${h.movieId }</span>
														${m.movieTitle }
														<c:if test="${m.genre!='' }">
														(${m.genre })
														</c:if>
													</c:if>
												</td>
											</tr>
										</table>
									</div>
						        </div>
							</div>
						</td>
					</tr>
				</table>
			</form>
				
			<table class="table border-top align-middle">
				<tr id="interestJoinBar">
					<c:if test="${loginUser.id == h.boardWriter && loginUser.isAdmin=='N'}">
						<c:if test="${h.isClose == 'N' }">
							<td id="modifyHangout" class="tdHover">
								수정하기
								<i class="bi bi-pencil-square" style="font-size: 2rem;" id="modifyHangout"></i>
							</td>
							<td class="tdHover" data-bs-toggle="modal" data-bs-target="#deleteHangoutModal">
								삭제하기
								<i class="bi bi-trash" style="font-size: 2rem"></i>
							</td>
						</c:if>
						<c:if test="${h.isClose == 'Y' }">
							<td id="isClose" class="tdHover">
								모집완료
								<i id="false" class="bi bi-heart-fill" style="font-size:2rem;"></i>
							</td>
						</c:if>
					</c:if>
					
					<c:if test="${ !empty loginUser && loginUser.id != h.boardWriter && loginUser.isAdmin=='N'}">
						<c:if test="${h.isClose=='N' }">
							<td id="interest" class="tdHover">
								관심
								<c:if test="${isInterest==0 }">
									<i id="false" class="bi bi-bookmark" style="font-size:2rem;"></i>
								</c:if>
								<c:if test="${isInterest>0 }">
									<i id="true" class="bi bi-bookmark-fill" style="font-size:2rem;"></i>
								</c:if>
							</td>
							<td id="join" class="tdHover">
								참여하기
								<c:if test="${h.isClose=='N' && isJoin==0 }">
									<i id="false" class="bi bi-heart" style="font-size:2rem;"></i>
								</c:if>
								<c:if test="${h.isClose=='N' && isJoin>0 }">
									<i id="true" class="bi bi-heart-fill" style="font-size:2rem;"></i>
								</c:if>
							</td>
							<c:if test="${ count == 0 }">
								<td class="tdHover" id="rcReport" data-bs-toggle="modal"
							data-bs-target="#hangOutReportModal">신고하기<i class="bi bi-exclamation-circle"
									style="font-size: 2rem;"></i></td>
							</c:if>
							<c:if test="${ count == 1 }">
								<td class="tdHover" id="rcReport" data-bs-toggle="modal"
							data-bs-target="#reportCancelModal">신고취소<i class="bi bi-exclamation-circle"
									style="font-size: 2rem;"></i></td>
							</c:if>
						</c:if>
						<c:if test="${h.isClose=='Y' }">
							<td id='isClose' class='tdHover'>
								모집완료
								<i class='bi bi-heart-fill' style='font-size:2rem;'></i>
							</td>
						</c:if>
					</c:if>
				</tr>
			</table>
		</div>
		
		
		<c:if test="${!empty loginUser }">
			<div class="mt-5 mb-3">
				<i class="bi bi-person-fill" style="font-size: 1rem;"></i>
				<h5 class="commentNickName" style="display: inline;">${loginUser.nickName }</h5>
			</div>
			<form class="col mb-5">
				<table class="parentCommentTable commentTable table table-borderless">
					<tr>
						<input type="hidden" name="boardId" value="${h.boardId }">
						<input type="hidden" name="commentCId" value="0">
						<td width="100%">
							<div><textarea class="form-control rounded-5 p-3 w-100" name="commentContent" placeholder="댓글을 입력하세요." rows="3" style="resize: none;" required></textarea></div>
						</td>
						<td class="myHover">
							<i class="insertCommentButton bi bi-send" style="font-size:1.5rem"></i>
						</td>
					</tr>
				</table>
			</form>
		</c:if>
			
		
		<div id="commentContainer" class="row row-cols-md-1 row-cols-sm-1 mt-5 mb-5 row-cols-lg-1 justify-content-start">
			
			<!-- 원댓글 틀 -->
			<div class="commentDiv col mt-3" style="display:none">
				<div class="mt-3 p-3 pt-0 pb-0">
					<table class="parentCommentTable commentTable table table-borderless">
						<tr>
							<td scope="col">
								<div class="commentId" style="display:none"></div>
								<i class="bi bi-person-fill" style="font-size: 1rem;"></i>
								<h5 class="commentNickName" style="display: inline;"></h5>
								<div class="commentCId" style="display:none"></div>
							</td>
							<td class="commentCreateDate text-muted" scope="row" align="right" width="100px"></td>
							<td class="modifyCommentButton myHover" width="1em" style="display:none"><i class="bi bi-clipboard"></i></td>
							<td class="deleteCommentButton myHover" width="1em" style="display:none"><i class="bi bi-trash"></i></td>
						</tr>
						<tr>
							<td class="commentContent" colspan="2" scope="row"></td>
							<td class="updateCommentForm" colspan="2" width="100%" style="display:none">
								<div><textarea class="form-control rounded-5 p-3 w-100" name="commentContent" placeholder="댓글을 수정하세요." rows="2" style="resize: none;" required></textarea></div>
							</td>
							<td class="updateCommentFormButton myHover" align="bottom" style="display:none">
								<i class="updateCommentButton bi bi-send" style="font-size:1em"></i>
							</td>
						</tr>
					</table>
					
					<!-- 대댓글 입력창 -->
					<c:if test="${!empty loginUser }">
						<small class="addChildCommentButton text-muted">답글달기</small><br>
						<table class="addChildCommentTable commentTable table table-borderless p-5" style="display:none">
							<tr>
								<td width="1em">
									<i class="bi bi-arrow-return-right" style="font-size:1em">
								</td>
								<td width="100%">
									<input type="hidden" name="boardId" value="${h.boardId }">     
									<input type="hidden" name="commentCId" value="${c.commentId }">
									<textarea class="form-control rounded-5 p-3 w-100" name="commentContent" placeholder="대댓글을 작성하세요." rows="2" style="resize: none;" required></textarea>
								</td>
								<td class="myHover" align="bottom">
									<i class="insertCommentButton bi bi-send" style="font-size:1em"></i>
								</td>
							</tr>
						</table>
					</c:if>
				</div>
			</div>
			
			
			<!-- 대댓글 틀 -->
			<div class="childCommentTable col p-3" style="display:none">
				<div class="p-3 pt-0 pb-0">
					<table class="table table-borderless">
						<tr>
							<td width="1em">
								<i class="bi bi-arrow-return-right" style="font-size:1em">
							</td>
							<td scope="col">
								<div class="commentId" style="display:none"></div>
<!-- 								<div class="commentId text-muted"></div> -->
								<i class="bi bi-person-fill" style="font-size: 1rem;"></i>
								<h5 class="commentNickName" style="display: inline;"></h5>
								<div class="commentCId" style="display:none"></div>
							</td>
							<td class="commentCreateDate text-muted" scope="row" width="100px" align="right"></td>
							<td class="modifyCommentButton myHover" width="1em" style="display:none"><i class="bi bi-clipboard"></i></td>
							<td class="deleteCommentButton myHover" width="1em" style="display:none"><i class="bi bi-trash"></i></td>
						</tr>
						<tr>
							<td></td>
							<td class="commentContent" colspan="2" scope="row"></td>
							<td class="updateCommentForm" colspan="2" width="100%" style="display:none">
								<div><textarea class="form-control rounded-5 p-3 w-100" name="commentContent" placeholder="내용을 입력하세요." rows="2" style="resize: none;" required></textarea></div>
							</td>
							<td class="updateCommentFormButton myHover" align="bottom" style="display:none">
								<i class="updateCommentButton bi bi-send" style="font-size:1em"></i>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
	
	
	
	<!--  행아웃 신고 모달 -->
	<div class="modal fade" id="hangOutReportModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg modal-dialog-centered">
			<form action="${ contextPath }/insertHangoutReport.rp" method="POST">
				<div class="modal-content">
					<div class="modal-header">
						<h1 class="modal-title fs-5" id="exampleModalLabel" style="color: #CD5C5C;">모임 신고하기</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body" style="width:800px;">
						<input type="hidden" name="reportContentCategory" id="reportContentCategory" value="h">
						<input type="hidden" name="reportWriter" id="reportWriter" value="${ loginUser.id }">
						<input type="hidden" name="reportContentId" id="reportContentId" value="${h.boardId }">
						<input type="hidden" name="boardId" id="boardId" value="${h.boardId }">
						<input type="hidden" name="writer" id="writer" value="${h.boardWriter}">
						<select class="form-select form-select-lg mb-3" aria-label=".form-select-lg example" id="reportCategory" name="reportCategory">
							<option selected>신고 이유 선택</option>
							<option value="욕설">욕설</option>
							<option value="혐오">혐오발언</option>
							<option value="비방">비방성 컨텐츠</option>
							<option value="광고">광고 컨텐츠</option>
							<option value="허위">허위 컨텐츠</option>
							<option value="음란">음란성 컨텐츠</option>
							<option value="기타">기타</option>
						</select>
						<div class="mb-3">
							<textarea class="form-control" id="exampleFormControlTextarea1"
								rows="3" placeholder="기타를 선택하신 경우 입력해주세요." style="resize:none;" id="reportContent" name="reportContent"></textarea>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Close</button>
						<button type="submit" class="btn btn-outline-danger">모임 신고</button>
					</div>
				</div>
			</form>
		</div>
	</div>
	
	<!-- 행아웃 신고 삭제 모달 -->
		<!-- Modal -->
	<div class="modal fade" id="reportCancelModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg modal-dialog-centered">
					<div class="modal-content">
						<div class="modal-header">
							<h1 class="modal-title fs-5" id="exampleModalLabel" style="color: #CD5C5C;">신고 취소</h1>
							<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						</div>
						<div class="modal-body">신고를 취소하시겠습니까?</div>
						<form action="${ contextPath }/deleteHangoutReport.rp" method="POST">
							<div class="modal-footer">
								<button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Close</button>
								<input type="hidden" name="reportContentCategory" value="h">
								<input type="hidden" name="reportContentId" value="${h.boardId}">
								<input type="hidden" name="reportWriter" value="${ loginUser.id }">
								<input type="hidden" name="boardId" id="boardId" value="${h.boardId }">
								<input type="hidden" name="writer" id="writer" value="${h.boardWriter}">
								<button type="submit" class="btn btn-outline-danger" id="deleteReviewReport">신고 취소</button>
							</div>
						</form>
					</div>
			</div>
	</div>
	
	
	
	<script>
		$(document).ready(function(){
			
			// 	ajax로 전체 댓글 뽑아오기
			var commentDiv = $(".commentDiv").clone(true);
			var childCommentTable = $(".childCommentTable").clone();
			
			$.ajax({
				url: "${contextPath }/selectAllCommentList.ha",
				data: {
					boardId: ${h.boardId}
				},
				success: (data)=>{
					
					for(c of data) {
						if(c.commentCId==0) {
							var div = commentDiv;
							div.css("display", "block");
							div.find(".commentId").text(c.commentId);
							div.find(".commentNickName").text(c.nickName);
							div.find(".commentCreateDate").text(c.commentCreateDate);
							div.find(".commentContent").text(c.commentContent);
							div.find(".commentCId").text(c.commentCId);
							div.find("input[name=boardId]").val(c.boardId);
							div.find("input[name=commentCId]").val(c.commentId);
							if(c.userId=="${loginUser.id}") {
								div.find(".modifyCommentButton").prop("style").removeProperty("display");
								div.find(".deleteCommentButton").prop("style").removeProperty("display");
							} else {
								div.find(".modifyCommentButton").css("display", "none");
								div.find(".deleteCommentButton").css("display", "none");
							}
							$("#commentContainer").append(div.html());
						} else {
							var div = childCommentTable;
							div.css("display", "block");
							div.find(".commentId").text(c.commentId);
							div.find(".commentNickName").text(c.nickName);
							div.find(".commentCreateDate").text(c.commentCreateDate);
							div.find(".commentContent").text(c.commentContent);
							div.find(".commentCId").text(c.commentCId);
							if(c.userId=="${loginUser.id}") {
								div.find(".modifyCommentButton").prop("style").removeProperty("display");
								div.find(".deleteCommentButton").prop("style").removeProperty("display");
							} else {
								div.find(".modifyCommentButton").css("display", "none");
								div.find(".deleteCommentButton").css("display", "none");
							}
							$("#commentContainer").append(div.html());
						}
					}
				},
				error: (data)=>{
					console.log(data);
				}
			});
		});
		
//		 ajax로 댓글 달기
		$(document).on('click', ".insertCommentButton", function(){
			var commentDiv = $(".commentDiv").clone(true);
			var childCommentTable = $(".childCommentTable").clone();
			
			var boardId = ${h.boardId};
			var commentCId = $(this).parent().parent().parent().find("input[name=commentCId]").val();
			var commentContent = $(this).parent().parent().parent().find("textarea").val();
			console.log(boardId);
			console.log(commentCId);
			console.log(commentContent);
			
			$.ajax({
				url: "${contextPath }/insertComment.ha",
				data: {
					boardId: boardId,
					commentContent: commentContent,
					commentCId: commentCId
				},
				success: (data)=>{
					if(data.commentCId==0) {
						var div = commentDiv;
						div.css("display", "block");
						div.find(".commentId").text(data.commentId);
						div.find(".commentNickName").text(data.nickName);
						div.find(".commentCreateDate").text(data.commentCreateDate);
						div.find(".commentContent").text(data.commentContent);
						div.find(".commentCId").text(data.commentCId);
						div.find("input[name=boardId]").val(data.boardId);
						div.find("input[name=commentCId]").val(data.commentId);
						
						div.find(".modifyCommentButton").prop("style").removeProperty("display");
						div.find(".deleteCommentButton").prop("style").removeProperty("display");
						
						$("#commentContainer").prepend(div.html());
						$(this).parent().parent().parent().find("textarea").val("");
					} else {
						var div = childCommentTable;
						div.css("display", "block");
						div.find(".commentId").text(data.commentId);
						div.find(".commentNickName").text(data.nickName);
						div.find(".commentCreateDate").text(data.commentCreateDate);
						div.find(".commentContent").text(data.commentContent);
						div.find(".commentCId").text(data.commentCId);
						
						div.find(".modifyCommentButton").prop("style").removeProperty("display");
						div.find(".deleteCommentButton").prop("style").removeProperty("display");
						

						$(this).parent().parent().parent().parent().parent().after(div.html());
						$(this).parent().parent().parent().find("textarea").val("");
					}
				},
				error: (data)=>{
					console.log(data);
				}
			});
		});
		
		// 대댓글 작성창
		$(document).on("click", ".addChildCommentButton", function(){
			if($(this).parent().find(".addChildCommentTable").css("display")=="none") {
				console.log("숨겨짐");
				$(this).parent().find(".addChildCommentTable").prop("style").removeProperty("display");
			} else {
				$(this).parent().find(".addChildCommentTable").css("display", "none");
			}
		});
		
		//	댓글 수정창
		var isModifyComment = true;
		$(document).on('click', ".modifyCommentButton", function(){
			
			if($(this).parent().parent().find(".commentContent").css("display")!="none") {
				var originalComment = $(this).parent().parent().find(".commentContent").text();
				$(this).parent().parent().find(".commentContent").css("display", "none");
				$(this).parent().parent().find(".updateCommentForm textarea").val(originalComment);
				$(this).parent().parent().find(".updateCommentForm").prop("style").removeProperty("display");
				$(this).parent().parent().find(".updateCommentFormButton").prop("style").removeProperty("display");
				isModifyComment = false;
			} else {
				console.log("댓글창");
				$(this).parent().parent().find(".commentContent").prop("style").removeProperty("display");
				$(this).parent().parent().find(".updateCommentForm").css("display", "none");
				$(this).parent().parent().find(".updateCommentFormButton").css("display", "none");
				isModifyComment = true;
			}
		});
		
		// 댓글 수정
		$(document).on('click', ".updateCommentFormButton", function(){
			console.log("수정하기");
			var commentId = $(this).parent().parent().parent().parent().find(".commentId").text();
			var commentContent = $(this).parent().parent().parent().find(".updateCommentForm textarea").val();

			$.ajax({
				url: "${contextPath }/updateComment.ha",
				data: {
					commentId: commentId,
					commentContent: commentContent
				},
				success: (data)=>{
					$(this).parent().parent().find(".commentContent").text(commentContent);
					$(this).parent().parent().find(".commentContent").prop("style").removeProperty("display");
					$(this).parent().parent().find(".updateCommentForm").css("display", "none");
					$(this).parent().parent().find(".updateCommentFormButton").css("display", "none");
				},
				error: (data)=>{
					console.log(data);
				}
			});
		});
		
		// 댓글 삭제
		$(document).on('click', ".deleteCommentButton", function(){
			var commentId = $(this).parent().parent().parent().parent().find(".commentId").text();
			var commentCId = $(this).parent().parent().parent().parent().find(".commentCId").text();
			console.log("id : "+commentId);
			console.log("cId : "+commentCId);
			
			var arr = new Array();
			var div = $(this).parent().parent().parent().parent();
			arr.push(div);
			
			div = div.next();
			arr.push(div);
			
			div = div.next();
			arr.push(div);
			
			console.log(arr);
			
			
			$.ajax({
				url: "${contextPath }/deleteComment.ha",
				data: {
					commentId: commentId,
					commentCId: commentCId
				},
				success: (data)=>{
					var arr = new Array();
					var div = $(this).parent().parent().parent().parent();
					arr.push(div);
					
					for(var i=0 ; i<data-1 ; i++) {
						div = div.next();
						arr.push(div);
					}
					for(var c of arr) {
						c.remove();
					}
				},
				error: (data)=>{
					console.log(data);
				}
			});
		});
	</script>
	


	<!--  삭제 모달 -->
	<!-- Modal -->
	<div class="modal fade" id="deleteHangoutModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="exampleModalLabel">게시물 삭제</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">정말로 삭제하시겠습니까?</div>
				<div class="modal-footer">
					<button type="button" id="deleteHangoutButton" class="btn btn-sm btn-outline-danger" data-bs-dismiss="modal" aria-label="Close">삭제하기</button>
				</div>
			</div>
		</div>
	</div>

	<script>
	
		$("#modifyHangout").on("click", function(){
			$("form").prop("action", "${contextPath}/modifyHangout.ha");
			$("form").submit();
		});
		
		$("#deleteHangoutButton").on("click", function(){
			$("form").prop("action", "${contextPath}/deleteHangout.ha");
			$("form").submit();
		});
		
		$("#hangoutMovie").on("click", function(){
			const movieId = $("#movieId").text();
			console.log(movieId);
			location.href='${contextPath}/movieDetail.re?movieId='+movieId;
		});
		
		$("#interest").on("click", function(){
			if($("#interest").find("i").prop("class")=="bi bi-bookmark") {
				$.ajax({
					url: "${contextPath }/insertInterest.ha",
					data: {
						boardId: "${h.boardId}",
						id: "${loginUser.id}"
					},
					success: (data)=>{
						$("#interest").find("i").attr("class", "bi bi-bookmark-fill");
					},
					error: (data)=>{
					}
				});
			} else {
				$.ajax({
					url: "${contextPath }/deleteInterest.ha",
					data: {
						boardId: "${h.boardId}",
						id: "${loginUser.id}"
					},
					success: (data)=>{
						$("#interest").find("i").attr("class", "bi bi-bookmark");
					},
					error: (data)=>{
					}
				});
			}
		});
		
		$("#join").on("click", function(){
			if($("#join").find("i").prop("class")=="bi bi-heart") {
				$.ajax({
					url: "${contextPath }/insertJoin.ha",
					data: {
						boardId: "${h.boardId}",
						id: "${loginUser.id}"
					},
					success: (data)=>{
						$("#join").find("i").attr("class", "bi bi-heart-fill");
						$("#nowNumber").html(data.nowNumber+"명");
						
						if(data.isClose=='Y') {
							console.log("모집종료");
							$("#interest").remove();
							$("#join").remove();
							$("#interestJoinBar").append("<td id='isClose' class='tdHover'>"
									+"모집완료\n"
									+"<i class='bi bi-heart-fill' style='font-size:2rem;'></i></td>");
						}
					},
					error: (data)=>{
					}
				});
			} else {
				$.ajax({
					url: "${contextPath }/deleteJoin.ha",
					data: {
						boardId: "${h.boardId}",
						id: "${loginUser.id}"
					},
					success: (data)=>{
						console.log("참여 삭제");
						$("#nowNumber").html(data.nowNumber+"명");
						$("#join").find("i").attr("class", "bi bi-heart");
					},
					error: (data)=>{
					}
				});
			}
		});
	</script>
	<jsp:include page="../common/footer.jsp" />
</body>
</html>