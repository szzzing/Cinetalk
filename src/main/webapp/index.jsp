<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick.min.css" integrity="sha512-yHknP1/AwR+yx26cB1y0cjvQUMvEa2PFzt1c9LlS4pRQ5NOTZFWbhBig+X9G9eYW/8m0/4OXNx8pxJ6z57x0dw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick-theme.min.css" integrity="sha512-17EgCFERpgZKcm0j0fEq1YCJuyAWdz9KUtv1EjVuaOz8pDnh/0nZxmU6BBXwaaxqoi9PQXnRWqlcDB027hgv9A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel = "stylesheet" href = "assets/css/app.css">
    <title>CINETALK</title>
<style>
    .cinetalk {
        color: brown;
        font-weight: bolder;
    }

    .introduce {
        color: white;
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
	
	a {
		text-decoration: none;
		color: gray;
	}
</style>
</head>
<body>
  	<jsp:include page="WEB-INF/views/common/top.jsp"/>
 	<section id="top">
        <div class = "section-content overlay d-flex justify-content-center align-items-center">
            <div class="container-xxl">
                <div class="row align-items-center">
                    <div class="col-md-9 welcome">
                        <h1 class="welcome-title fw-light"><span class="introduce">우리들의 자유로운 영화 이야기,</span> <span class = "cinetalk">CINETALK</span></h1>
                        <div class="divider"></div>
                        <div class = "row welcome-desc">
                            <p class="col-sm-10 col-md-12 lead"><span class = "introduce">온오프라인에서 의견을 나누어 보세요. 영화를 검색하여 리뷰를 작성하고, 모임에서 함께 영화를 시청합니다.</span></p>
                        </div>
                    </div>
                    <c:if test = "${ empty loginUser }">
                    <div class="col-md-3 letsgo">
                        <div class="card card-body letsgo-card">
                            <div class="letsgo my-3">
                                <h4 class="letsgo-title card-title text-dark mb-3">Login!</h4>
                                <p class="card-text text-secondary">지금 로그인하여 만나보세요.</p>
                            </div>
                            <div class="letsgo-card-form">
                                <form action = "${ contextPath }/login.me" method = "post">
                                    <div class="mb-3">
                                        <input type = "text" class = "form-control" name = "id" placeholder = "ID">
                                    </div>
                                    <div class = "mb-3">
                                        <input type = "password" class = "form-control" name = "pwd" placeholder = "Password">
                                    </div>
                                    <p class="mb-3 d-flex">
                                        <button class="btn btn-outline-danger w-50 align-items-start m-1" type = "submit">로그인</button>
                                        <button class="btn btn-outline-danger w-50 align-items-end m-1" type = "button" onclick = "location.href='${contextPath}/enroll.me'">회원가입</button>
                                    </p>
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <span style = "font-size: 15px;"><a href = "${ contextPath }/findId.me">아이디 찾기</a></span>&nbsp;&nbsp;
                                    <span style = "font-size: 15px;"><a href = "${ contextPath }/findPwd.me">비밀번호 찾기</a></span>
                                    
                                </form>
                            </div>
                        </div>
                    </div>
                    </c:if>
                    <c:if test = "${ !empty loginUser }">
                    <div class="col-md-3 letsgo">
                        <div class="card card-body letsgo-card">
                            <div class="letsgo my-3">
                                <h4 class="letsgo-title card-title text-dark mb-3"><br>${ loginUser.nickName }님, 환영합니다!</h4>
                                <p class="card-text text-secondary">오늘은 어떤 영화를 보셨나요?</p>
                            </div>
                            <div class="letsgo-card-form">
                                    <p class="mb-3 d-flex">
                                        <button class="btn btn-outline-danger w-100 m-1 mx-auto d-block" type = "button" onclick = "location.href='${contextPath}/logout.me'">LOGOUT</button>
                                    </p>
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    
                            </div>
                        </div>
                    </div>
                    </c:if>
                </div>
            </div>
        </div><br><br>
	</section>
	<br><br>
  	
	<h2 align = "center">총 리뷰 ${ allReviewCount }개가 등록되었습니다.</h2>
  	<jsp:include page="WEB-INF/views/common/footer.jsp"/>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick.min.js" integrity="sha512-XtmMtDEcNz2j7ekrtHvOVR4iwwaD6o/FUJe6+Zq+HgcCsk3kj4uSQQR8weQ2QVj1o0Pk6PwYLohm206ZzNfubg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script src = "assets/js/app.js"></script>
</body>
</html>