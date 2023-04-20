<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
        /* 섹션 크기 */
        .bg-light{
            height: 1053px;
            padding-top:55px;
            padding-bottom:75px;
        }
        .flex-fill.mx-xl-5.mb-2{
            margin: 0 auto;
            width : 700px;
            padding-right: 7rem;
            padding-left: 7rem;
        }
        /* 입력창 */
        .container.py-4{
            margin: 0 auto;
            width : 503px;
        }
        /* 가입하기 */
        .d-grid.gap-2{
            padding-top: 30px;
        }
        
        /* 생년월일 */
        .bir_yy,.bir_mm,.bir_dd{
            width:160px;
            display:table-cell;
        }
        .bir_mm+.bir_dd, .bir_yy+.bir_mm{
            padding-left:10px;
        }
        #homehref {
        	text-decoration: none;
        	display: inline;
        }
    </style>
    <link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
	crossorigin="anonymous">
<script src = "https://code.jquery.com/jquery-3.6.1.min.js"></script>
</head>
<body>
    <section class="bg-light">
        <div class="container py-4">
            <div class="row align-items-center justify-content-between">
               <a href="${ contextPath }"><img class="d-block mx-auto mb-4" src="${ contextPath }/resources/image/logo.png" alt="" width="130"></a>
               <span class = "text-dark h4" style="text-align:center;'">비밀번호 찾기</span>                 
            </div>
            <form action = "${contextPath}/updateTempPwd.me" method="POST">
            <div class="form-group">
   	    		<label for="exampleInputEmail1" class="form-label mt-4">이름</label>
                <input type="text" class="form-control" id="name" aria-describedby="emailHelp" name = "name">
            </div>
            <div class="form-group">
         		<label for="exampleInputEmail1" class="form-label mt-4">본인 확인 이메일</label>
                <input type="email" class="form-control" id="email" aria-describedby="emailHelp" placeholder="이메일 입력" name = "email">
            </div>
            <div class="d-grid gap-2">
                <button class="btn btn-primary btn-lg" id = "sendBtn" type="submit">인증번호 전송</button>
            </div>
            <div class="form-group">
         		<label for="exampleInputEmail1" class="form-label mt-4">인증번호</label>
                <input type="text" class="form-control" id="inputNumber" aria-describedby="emailHelp" placeholder="인증번호 입력" name = "inputNumber">
            </div>
            <div class="d-grid gap-2">
                <button class="btn btn-primary btn-lg" id = "checkBtn" type="button" onclick = "checkNum()">인증번호 확인</button>
            </div>
            <font id = "informPwd"></font>
            </form>
        </div>
    </section>
     
    <script>
    	function checkNum() {
    		var authCode = "<c:out value='${authCode}'/>";
    		console.log(authCode);
    		
    		if($('#inputNumber').val() == authCode) {
    			$('#informPwd').html('회원님의 임시 비밀번호는 ${tempPwd}입니다.<br>임시 비밀번호로 로그인 후 비밀번호를 수정해 주세요.');
    			$('#informPwd').attr('color', 'skyblue');
    		} else {
    			$('#informPwd').html('인증번호가 일치하지 않습니다.');
    			$('#informPwd').attr('color', 'red');
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