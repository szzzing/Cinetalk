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
	#myComunityBoardView {
		margin: auto;
		margin-top: 50px;
		padding: 40px;
		width:1400px;
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
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
</head>
<body>
<jsp:include page="../common/top.jsp" />
	<div id="myComunityBoardView" class="container">
		<h3 style="color:#CD5C5C;">내가 만든 커뮤니티</h3><br><br><br>
		<c:if test="${ empty list  }">
        	<div class="alert alert-danger" role="alert" id="table">아직 생성한 모임이 없습니다.</div>
    	</c:if>
    	<c:if test="${ !empty list }">
    	<div class="categoryDiv row row-cols-1 row-cols-sm-1 row-cols-md-1 row-cols-lg-3 justify-content-start">
         <c:forEach items="${ list }" var="r" varStatus="t">
            <div class="hangoutDiv col mb-4">
                 <div class="card card-cover h-100 overflow-hidden rounded-5">
                  <input type="hidden" name="boardId" value="${ r.boardId }">
                  <input type="hidden" name="writer" value="${ r.boardWriter }">
                  <div class="d-flex flex-column p-5">
                     <div class="mb-auto">
                        <h3 class="mb-2 lh-1 fw-bold">${r.boardTitle }</h3>
                        <p class="boardWriter card-text">${r.nickName }</p>
                     </div>
                     <table class="mt-4 md-auto">
                        <tr>
                           <td class="text-muted" width="70px">
                              <i class="bi bi-geo-alt-fill"></i>
                              지역
                           </td>
                           <td>
                              ${r.local }
                           </td>
                        </tr>
                        <tr>
                           <td class="text-muted">
                              <i class="bi bi-gender-female"></i>
                              성별
                           </td>
                           <td>
                              ${r.gender }
                           </td>
                        </tr>
                        <tr>
                           <td class="text-muted">
                              <i class="bi bi-clipboard-fill"></i>
                              연령
                           </td>
                           <td>
                              ${r.age }
                           </td>
                        </tr>
                        <tr>
                           <td class="text-muted">
                              <i class="bi bi-camera-reels-fill"></i>
                              영화
                           </td>
                           <td>
                              <c:if test="${r.movieId==null }">
                                 없음
                              </c:if>
                              <c:if test="${r.movieId!=null }">
                                 ${mList[t.index].movieTitle }
                                 <c:if test="${mList[t.index].genre!='' }">
                                 (${mList[t.index].genre })
                                 </c:if>
                              </c:if>
                           </td>
                        </tr>
                     </table>
                     <table class="text-muted mt-4">
                        <tr>
                           <td width="70px">
                              <i class="bi bi-eye"></i>
                              ${r.boardCount }
                           </td>
                           <td>
                              ${r.createDate }
                           </td>
                        </tr>
                     </table>
                  </div>
                 </div>
            </div>
         </c:forEach>
       	</div>
       	</c:if>
	</div>
	
	<script>
		const divs = document.getElementsByClassName("hangoutDiv");
		console.log(divs);
		
		for( const div of divs){
			div.addEventListener('click', function(){
				const boardId = this.childNodes[1].childNodes[1].value;
				const writer = this.childNodes[1].childNodes[3].value;
				console.log(boardId)
				location.href="${contextPath}/hangoutDetail.ha?boardId="+boardId+"&writer="+writer;
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