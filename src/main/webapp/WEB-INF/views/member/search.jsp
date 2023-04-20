<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fn" uri = "http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

    <!-- Bootstrap core CSS -->
<link href="/docs/5.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

    <!-- Favicons -->
<link rel="apple-touch-icon" href="/docs/5.0/assets/img/favicons/apple-touch-icon.png" sizes="180x180">
<link rel="icon" href="/docs/5.0/assets/img/favicons/favicon-32x32.png" sizes="32x32" type="image/png">
<link rel="icon" href="/docs/5.0/assets/img/favicons/favicon-16x16.png" sizes="16x16" type="image/png">
<link rel="manifest" href="/docs/5.0/assets/img/favicons/manifest.json">
<link rel="mask-icon" href="/docs/5.0/assets/img/favicons/safari-pinned-tab.svg" color="#7952b3">
<link rel="icon" href="/docs/5.0/assets/img/favicons/favicon.ico">
<meta name="theme-color" content="#7952b3">
  <style>
      .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        user-select: none;
      }

      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }
      
      #hangoutUrl {
      	text-decoration: none;
      	color: white;
      }
      #hangoutUrl:hover {
      	text-decoration: underline;
      }
      #movieTitle {
      	text-shadow: -1px 0px white, 0px 1px white, 1px 0px white, 0px -1px white;
      	font-size: 13px;
      	font-weight: bold;
      	color: black;
      	
      }
      #movieURL {
      	text-decoration: none;
      	color: black;
      }
	
	#movieURL:hover {
		text-decoration: underline;
	}      
    </style>

    
    <!-- Custom styles for this template -->
    <link href="features.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="../common/top.jsp"/>
	
	
	<!-- 모임 검색 -->
	<div class="container px-4 py-5" id="custom-cards">
    <h2 class="pb-2 border-bottom" style="font-size: 20px; font-weight: bold;">모임 게시판 검색</h2>
	
	<c:if test = "${ empty list }">
		<font id = "nullList" size = "15px" style = "font-weight:bold;">일치하는 검색 결과가 없습니다.</font>
	</c:if>
	
	    <div class="row row-cols-1 row-cols-lg-3 align-items-stretch g-4 py-5" id = "hangoutCard">
	      <c:if test = "${ !empty list }">
		  <c:forEach items = "${ list }" var = "h">
	      <div class="col">
	        <div class="card card-cover h-100 overflow-hidden text-white bg-dark rounded-5 shadow-lg" style="background-image: url('unsplash-photo-1.jpg');">
	          <div class="d-flex flex-column h-100 p-5 pb-3 text-white text-shadow-1">
	            <h2 class="pt-5 mt-5 mb-4 display-6 lh-1 fw-bold"><a href = "<c:url value='/hangoutDetail.ha?boardId=${h.boardId}&writer=${h.boardWriter }'/>" id = "hangoutUrl">${ h.boardTitle }</a></h2>
	            <ul class="d-flex list-unstyled mt-auto">
	              <li class="d-flex align-items-center me-3">
	                <svg class="bi me-2" width="1em" height="1em"><use xlink:href="#geo-fill"/></svg>
	                <small>${ h.boardContent }</small>
	              </li>
	              <li class="d-flex align-items-center">
	                <svg class="bi me-2" width="1em" height="1em"><use xlink:href="#calendar3"/></svg>
	                <small>${ h.local }</small>
	              </li>
	            </ul>
	          </div>
	        </div>
	      </div>
	      </c:forEach>
		  </c:if>
	      </div>
	  </div>
      <br>
      <br>
      
      
    <!-- 영화 검색 -->
     <div class="container px-4 py-5" id="custom-cards">
    <h2 class="pb-2 border-bottom" style="font-size: 20px; font-weight: bold;">영화 검색</h2>
	
	<c:if test = "${ empty movieList }">
		<font id = "nullList" size = "15px" style = "font-weight:bold;">일치하는 검색 결과가 없습니다.</font>
	</c:if>
	
	    <div class="row row-cols-1 row-cols-lg-3 align-items-stretch g-4 py-5" id = "hangoutCard">
	      <c:if test = "${ !empty movieList }">
		  <c:forEach items = "${ movieList }" var = "m">
	      <div class="col">
	        <div class="card card-cover h-100 overflow-hidden text-white bg-dark rounded-5 shadow-lg" style="background-image: url('https://image.tmdb.org/t/p/w400/${ m.movieImg }'); width: 400px;">
	          <div class="d-flex flex-column h-100 p-5 pb-3 text-white text-shadow-1">
	            <h2 class="pt-5 mt-5 mb-4 display-6 lh-1 fw-bold"><a href = "<c:url value='/hangoutDetail.ha?boardId=${h.boardId}'/>" id = "hangoutUrl">${ h.boardTitle }</a></h2>
	            <ul class="d-flex list-unstyled mt-auto">
	              <li class="d-flex align-items-center me-3">
	                <svg class="bi me-2" width="1em" height="1em"><use xlink:href="#geo-fill"/></svg>
	                
	              </li>
	            </ul>
	          </div>
	        </div>
	        <font id = "movieTitle"><a href="<c:url value='/movieDetail.re?movieId=${m.movieId}'/>" id = "movieURL">${ m.movieTitle }</a></font>
	      </div>
	      </c:forEach>
		  </c:if>
	      </div>
	  </div>
      
    <script>
		
	</script>  

  
  <jsp:include page="../common/footer.jsp"/>

</body>
</html>