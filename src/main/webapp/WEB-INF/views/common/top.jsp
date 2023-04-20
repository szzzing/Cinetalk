<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#loginBar {
		text-align: right;
	}
	
	#loginBar>a {
		color: black;
		text-decoration: none;
	}
	
	#loginBar>a:hover {
		font-weight: bold;
		text-decoration: underline;
	}
			/* Global */
	.section-content {
	    padding: 4rem 0;
	}
	
	/* Global */
	.section-content {
	    padding: 4rem 0;
	}
	
	/* Top Section */
	#top {
	    background-image: url('resources/image/poster.jpg');
	    background-position: center;
	    background-repeat: no-repeat;
	    background-size: cover;
	    height: 80vh;
	    position: relative;
	}
	
	#top .overlay {
	    position: absolute;
	    height: 100%;
	    width: 100%;
	    left: 0;
	    top: 0;
	    background-color: rgba(0, 0, 0, 0.65);
	}
	
	#top .divider {
	    width: 10%;
	    margin-top: 2rem;
	    margin-bottom: 2rem;
	    border-top: 2px solid #fff;
	}
	
	#top .welcome {
	    padding-right: 8rem;
	    color: #fff;
	}
	
	#signup {
	    text-align: center;
	    padding: 50px;
	}
</style>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
	crossorigin="anonymous">
<script src = "/static/js/bootstrap.bundle.js"></script>
</head>
<body>
	<c:set value="${ pageContext.servletContext.contextPath }" var="contextPath" scope="application"/>
 	<nav class = "navbar navbar-expand-lg navbar-light bg-light py-3 shadow-lg sticky-top">
        <div class="container">
            <a href="${contextPath }" class="navbar-brand align-middle">
                <h3 class = "m-0">
                    <img src = "resources/image/logo.png" alt = "Logo" height = "36px">
                    <span class = "text-danger">CINETALK</span>
                </h3>
            </a>
            <!--크기 줄어들면 햄버거 버튼으로 변경-->
            <button class="navbar-toggler" type = "button" data-bs-toggle = "collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded = "false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <!-- 햄버거 버튼 여기 div로 연결-->
            <div class="collapse navbar-collapse" id = "navbarSupportedContent">
                <ul class="navbar-nav ms-auto mb-2 mb-lg-0 dropdwon">
              	  <li>&nbsp;&nbsp;</li>
        	       <li class="nav-item">
        	       	<!-- 검색 -->
 	                 <form action = "${ contextPath }/search.me" method = "GET" class="d-flex" role="search" id="searchForm">
  	                   <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search" name = "keyword">
   		               <button class="btn btn-outline-danger" type="submit" style="margin-right: 1em;" id = "searchBtn" onclick = "search()">Search</button>
                  </form>
                
                    <li class="nav-item">
                        <a href="#top" class="nav-link">
                            Home
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="${contextPath }/reviewList.re" class="nav-link">
                            Review
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="${ contextPath }/hangoutList.ha" class="nav-link">
                            Hangout
                        </a>
                    </li>
                    <c:if test = "${ !empty loginUser && loginUser.isAdmin=='N'}">
                    <li class="nav-item dropdown">
                    	<a class = "nav-link dropdown-toggle" href = "#" role = "button" data-bs-toggle = "dropdown" aria-expanded="false">
                    		My Info
                    	</a>
                    	<ul class = "dropdown-menu dropdown-menu-dark" aria-labelledby="navbarDarkDropdownMenuLink">
                    		<li><a class = "dropdown-item" href = "${contextPath }/myInfo.my">My Page</a></li>
                    		<li><a class = "dropdown-item" href = "${ contextPath }/updateMyInfo.me">Edit My Info</a></li>
                    	</ul>
                    </li>
                    </c:if>
                    <c:if test = "${ loginUser.isAdmin=='Y' }">
                  <li class="nav-item">
                     <a href="${contextPath }/admin.ad" class="nav-link">
                            Admin
                        </a>
                  </li>
               </c:if>
                </ul>
            </div>
        </div>
    </nav>

	<script>
	
		
	</script> 

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
		crossorigin="anonymous">
	</script>

</body>
</html>