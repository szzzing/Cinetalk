<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fn" uri = "http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
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
               <span class = "text-dark h4" style="text-align:center;'">정보 수정</span>                 
            </div>
            <form action = "${ contextPath }/update.me" method = "POST">
                <div class="form-group">
               		<label for="id" class="form-label mt-4">아이디</label>
                    <input type="text" class="form-control" id="id" name = "id" value = "${ loginUser.id }" readonly>
                    <font id = "idMsg" size = "2"></font>
                </div>
                <div class="form-group has-success">
					<label for="pwd" class="form-label mt-4">이전 비밀번호</label>
					<input type="password" class="form-control" id="currentPwd" name = "currentPwd">
				</div>
				<div class="form-group has-success">
					<label for="pwd" class="form-label mt-4">새 비밀번호</label>
					<input type="password" class="form-control" id="pwd" name = "newPwd">
					<font id = "pwdMsg" size = "2"></font>
				</div>

				<div class="form-group has-danger">
					<label for="pwdConfirm" class="form-label mt-4">비밀번호 확인</label> 
					<input type="password" class="form-control" id="pwdConfirm">
					<font id = "pwdError" size = "2"></font>
				</div>
                <div class="form-group">
               		<label for="exampleInputEmail1" class="form-label mt-4">이름</label>
                    <input type="text" class="form-control" id="name" aria-describedby="emailHelp" name = "name" value = "${ loginUser.name }">
                </div>
                <div class="form-group">
               		<label for="exampleInputEmail1" class="form-label mt-4">핸드폰 번호</label>
                    <input type="text" class="form-control" id="phone" aria-describedby="emailHelp" name = "phone" value = "${ loginUser.phone }">
                </div>
                <div class="form-group">
               		<label for="exampleInputEmail1" class="form-label mt-4">닉네임</label>
                    <input type="text" class="form-control" id="nickName" aria-describedby="emailHelp" name = "nickName" value = "${ loginUser.nickName }">
                </div>
                <div class ="bir_wrap">
                	<label class="form-label mt-4">생년월일</label>
                	<c:set var = "year" value = "${ fn:split(loginUser.birthDay, '-')[0] }"/>
                	<c:set var = "month" value = "${ fn:split(loginUser.birthDay, '-')[1] }"/>
                	<c:set var = "day" value = "${ fn:split(loginUser.birthDay, '-')[2] }"/>
                	<div class="bir_yy">
                		<span class="ps_box">
                			<input type="text" class="form-control" id="year" placeholder="년(4자)" maxlength="4" name = "year" value = "${ year }">
                		</span>
                	</div>
                	<div class="bir_mm">
                		<span class="ps_box focus">
			                <select class="form-select" id="month" id="exampleSelect1" name = "month">
						        <option>월</option>
						        <option <c:if test = "${ month eq 1 }">selected</c:if>>1</option>
						        <option <c:if test = "${ month eq 2 }">selected</c:if>>2</option>
						        <option <c:if test = "${ month eq 3 }">selected</c:if>>3</option>
						        <option <c:if test = "${ month eq 4 }">selected</c:if>>4</option>
						        <option <c:if test = "${ month eq 5 }">selected</c:if>>5</option>
						        <option <c:if test = "${ month eq 6 }">selected</c:if>>6</option>
						        <option <c:if test = "${ month eq 7 }">selected</c:if>>7</option>
						        <option <c:if test = "${ month eq 8 }">selected</c:if>>8</option>
						        <option <c:if test = "${ month eq 9 }">selected</c:if>>9</option>
						        <option <c:if test = "${ month eq 10 }">selected</c:if>>10</option>
						        <option <c:if test = "${ month eq 11 }">selected</c:if>>11</option>
						        <option <c:if test = "${ month eq 12 }">selected</c:if>>12</option>
						     </select>
                		</span>
                	</div>
                	<div class="bir_dd">
                		<span class="ps_box">
                			<input type ="text" class="form-control" id ="day" placeholder="일" maxlength="2" name = "day" value = "${ day }">
                		</span>
                	</div>
                </div>
			    <div class="form-group">
			      <label for="exampleSelect1" class="form-label mt-4">성별</label>
			      <select class="form-select" id="gender" name = "gender">
			        <option value = "M" <c:if test = "${ loginUser.gender == 'M' }">selected</c:if>>남자</option>
			        <option value = "F" <c:if test = "${ loginUser.gender == 'F' }">selected</c:if>>여자</option>
			      </select>
			    </div>                
                <div class="form-group">
               		<label for="exampleInputEmail1" class="form-label mt-4">본인 확인 이메일</label>
                    <input type="email" class="form-control" id="email" aria-describedby="emailHelp" placeholder="선택입력" name = "email" value = "${ loginUser.email }">
                </div>
				<div class="d-grid gap-2">
                    <button class="btn btn-primary btn-lg" type="submit">수정하기</button>
                </div>

            </form>
        </div>
    </section>
    <script>
    	$(function() {
    		$('#pwd').keyup(function() {
    			$('#pwdError').html('');
    		});
    		$('#pwdConfirm').keyup(function() {
    			if($('#pwd').val() != $('#pwdConfirm').val()) {
    				$('#pwdError').html('비밀번호 불일치<br>');
    				$('#pwdError').attr('color', '#f82a2aa3');
    				$('pwdConfirm').css('outline', 'red');
    			} else {
    				$('#pwdError').html('비밀번호 일치<br>');
    				$('#pwdError').attr('color', '#199894b3');
    			}
    		});
    		
    		
    	});
    	
    	$(function() {
    		$('#pwd').on('focus', function() {
    			$('#pwdMsg').html('최소 8 자 이상, 하나 이상의 문자와 숫자를 포함해 주세요.<br>');
    		});
    		
    		$('#pwd').focusout(function() {
    			var pwd = $('#pwd').val();
        		var reg = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/;
        		if(!reg.test(pwd)) {
    				$('#pwdMsg').attr('color', 'f82a2aa3');
        			return false;
        		} else {
        			$('#pwdMsg').html('');
        		}
    		});
    	});
    	
    		
    </script>
    <script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
		crossorigin="anonymous">
   </script>
</body>
</html>