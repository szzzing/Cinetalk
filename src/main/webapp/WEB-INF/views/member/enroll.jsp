<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src = "https://code.jquery.com/jquery-3.6.1.min.js"></script>
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
               <span class = "text-dark h4" style="text-align:center;'">회원가입</span>                 
            </div>
            <form action = "${ contextPath }/insertMember.me" method = "POST">
                <div class="form-group">
               		<label for="id" class="form-label mt-4">아이디</label>
                    <input type="text" class="form-control" id="id" name = "id" required>
                    <font id = "idMsg" size = "2"></font>
                </div>
				<div class="form-group has-success">
					<label for="pwd" class="form-label mt-4">비밀번호</label>
					<input type="password" class="form-control" id="pwd" name = "pwd" required>
					<font id = "pwdMsg" size = "2"></font>
				</div>

				<div class="form-group has-danger">
					<label for="pwdConfirm" class="form-label mt-4">비밀번호 확인</label> 
					<input type="password" class="form-control" id="pwdConfirm" required>
					<font id = "pwdError" size = "2"></font>
				</div>
                <div class="form-group">
               		<label for="exampleInputEmail1" class="form-label mt-4">이름</label>
                    <input type="text" class="form-control" id = "name" name = "name" required>
                </div>
                <div class="form-group">
               		<label for="exampleInputEmail1" class="form-label mt-4">핸드폰 번호</label>
                    <input type="text" class="form-control" id="phone" name = "phone" required>
                </div>
                <div class="form-group">
               		<label for="exampleInputEmail1" class="form-label mt-4">닉네임</label>
                    <input type="text" class="form-control" id="nickName" name = "nickName" required>
                    <font id = "nickNameMsg" size = "2"></font>
                </div>
                <div class ="bir_wrap">
                	<label class="form-label mt-4">생년월일</label>
                	<div class="bir_yy">
                		<span class="ps_box">
                			<input type="text" class="form-control" id="year" placeholder="년(4자)" maxlength="4" name = "year" required>
                		</span>
                	</div>
                	<div class="bir_mm">
                		<span class="ps_box focus">
			                <select class="form-select" id="month" name = "month" required>
						        <option>월</option>
						        <option>1</option>
						        <option>2</option>
						        <option>3</option>
						        <option>4</option>
						        <option>5</option>
						        <option>6</option>
						        <option>7</option>
						        <option>8</option>
						        <option>9</option>
						        <option>10</option>
						        <option>11</option>
						        <option>12</option>
						     </select>
                		</span>
                	</div>
                	<div class="bir_dd">
                		<span class="ps_box">
                			<input type ="text" class="form-control" id ="day" placeholder="일" maxlength="2" name = "day" required>
                		</span>
                	</div>
                </div>
			    <div class="form-group">
			      <label for="exampleSelect1" class="form-label mt-4">성별</label>
			      <select class="form-select" id="gender" name = "gender" required>
			        <option value = "M">남자</option>
			        <option value = "F">여자</option>
			      </select>
			    </div>                
                <div class="form-group">
               		<label for="exampleInputEmail1" class="form-label mt-4">이메일</label>
                    <input type="email" class="form-control" id="email" placeholder="cinetalk@cinetalk.com" name = "email" required>
                </div>
				<div class="d-grid gap-2">
                    <button class="btn btn-primary btn-lg" type="submit" onclick = "joinMember()">가입하기</button>
                </div>

            </form>
        </div>
    </section>
    
    
    <script>
    
    	window.onload = () => {
    		document.getElementById("id").addEventListener('change', function() {
    			const id = $('#id').val();
        		if (id == '') {
        			$('#idMsg').html('아이디를 입력해 주세요');
         			$('#idMsg').attr('color', '#f82a2aa3');
          			return false;
        		} else {
        			$.ajax({
        				url: '${contextPath}/checkId.me',
        				data: {id:id},
        				success: (data) => {
        					console.log(data);
        					if(data.trim()=='yes') {
        						$('#idMsg').html('사용 가능한 아이디입니다.');
        						$('#idMsg').attr('color', 'gray');
        					} else {
    							$('#idMsg').html('중복된 아이디입니다.');
    							$('#idMsg').attr('color', '#f82a2aa3');
    							return false;
        					}
        				},
        				error: (data) => {
        					console.log(data);
        				}
        			});
        		}	
    		});
    	}
    	
    	window.onload = () => {
    		document.getElementById("nickName").addEventListener('change', function() {
    			const nickName = $('#nickName').val();
        		if (nickName == '') {
         			$('#nickNameMsg').html('닉네임을 입력해 주세요.');
         			$('#nickNameMsg').attr('color', '#f82a2aa3');
          			return false;
        		} else {
        			$.ajax({
        				url: '${contextPath}/checkNickName.me',
        				data: {nickName:nickName},
        				success: (data) => {
        					console.log(data);
        					if(data.trim()=='yes') {
        						$('#nickNameMsg').html('사용 가능한 닉네임입니다.');
        						$('#nickNameMsg').attr('color', 'gray');
        					} else {
    							$('#nickNameMsg').html('중복된 닉네임입니다.');
    							$('#nickNameMsg').attr('color', '#f82a2aa3');
    							return false;
        					}
        				},
        				error: (data) => {
        					console.log(data);
        				}
        			});
        		}	
    		});
    	}
    	
    
    	$(function() {
    		$('#pwd').keyup(function() {
    			$('#pwdError').html('');
    		});
    		$('#pwdConfirm').keyup(function() {
    			if($('#pwd').val() != $('#pwdConfirm').val()) {
    				$('#pwdError').html('비밀번호 불일치<br>');
    				$('#pwdError').attr('color', '#f82a2aa3');
    				$('pwdConfirm').css('outline', 'red');
    				return false;
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