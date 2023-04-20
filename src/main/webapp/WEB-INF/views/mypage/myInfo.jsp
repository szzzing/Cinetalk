<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.css" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">

<style>
.body-action-button {
  background-color: #383838;
  border-radius: 50%;
  box-shadow: 1px 2px 12px rgba(0,0,0,.4);
  cursor: pointer;
  height: 40px;
  position: absolute;
  right: 15px;
  top: -265px;
  width: 40px;
}

.ffont {
    color: gray;
}

.ffont:hover{
   color: #F56262;
}
</style>
<title>Insert title here</title>
</head>
<body>
   <jsp:include page="../common/top.jsp" />
   <div class="container">
     <div class="header-container">
                      
    <div class="header">
      <svg fill="#ffffff" height="18" viewBox="0 0 24 24" width="30" xmlns="http://www.w3.org/2000/svg" class="header-icon">
        <path d="M0 0h24v24H0z" fill="none"/>
        <path d="M3 18h18v-2H3v2zm0-5h18v-2H3v2zm0-7v2h18V6H3z"/>
      </svg>

      <svg fill="#ffffff" height="20" viewBox="0 0 24 24" width="20" xmlns="http://www.w3.org/2000/svg" class="u-float-right header-icon" style="color: lightgray;">
        <path d="M15.5 14h-.79l-.28-.27C15.41 12.59 16 11.11 16 9.5 16 5.91 13.09 3 9.5 3S3 5.91 3 9.5 5.91 16 9.5 16c1.61 0 3.09-.59 4.23-1.57l.27.28v.79l5 4.99L20.49 19l-4.99-5zm-6 0C7.01 14 5 11.99 5 9.5S7.01 5 9.5 5 14 7.01 14 9.5 11.99 14 9.5 14z"/>
        <path d="M0 0h24v24H0z" fill="none"/>
      </svg>
  </div>
  <h1>&nbsp;&nbsp;&nbsp;<br><br><br><i class="bi bi-person-fill" style=" font-size: 50px;"></i> &nbsp;${ loginUser.nickName }<br><br><i class="bi bi-chat-right-heart-fill"></i></h1>
 
 
  <div class="body">
  
         <div id="hangoutList" class="row row-cols-1 row-cols-sm-1 row-cols-md-1 row-cols-lg-3 justify-content-start" >
               <div class="hangoutDiv col mb-4">
                    <div class="card card-cover h-100 overflow-hidden rounded-5">
                     <a href="${ contextPath }/likeReview.my" style="text-decoration-line: none;">
                     <div class="d-flex flex-column p-5">
                        <table class="mt-4 md-auto">
                        
                           <h4 class=" ffont">내가 좋아하는 리뷰&nbsp;<svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-chat-right-heart" viewBox="0 0 16 16">
  <path d="M2 1a1 1 0 0 0-1 1v8a1 1 0 0 0 1 1h9.586a2 2 0 0 1 1.414.586l2 2V2a1 1 0 0 0-1-1H2Zm12-1a2 2 0 0 1 2 2v12.793a.5.5 0 0 1-.854.353l-2.853-2.853a1 1 0 0 0-.707-.293H2a2 2 0 0 1-2-2V2a2 2 0 0 1 2-2h12Z"/>
  <path d="M8 3.993c1.664-1.711 5.825 1.283 0 5.132-5.825-3.85-1.664-6.843 0-5.132Z"/>
</svg></h4>
                             
                        
                        </table>
                     </div>
                     </a>
                    </div>
               </div>
                <div class="hangoutDiv col mb-4">
                
                    <div class="card card-cover h-100 overflow-hidden rounded-5">
                     <a href="${ contextPath }/likeCommunity.my" style="text-decoration-line: none;">
                     <div class="d-flex flex-column p-5">
                        <table class="mt-4 md-auto">
                        
                           <h4 class=" ffont">내가 관심있는 커뮤니티&nbsp;<svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-clipboard-heart" viewBox="0 0 16 16">
  <path fill-rule="evenodd" d="M5 1.5A1.5 1.5 0 0 1 6.5 0h3A1.5 1.5 0 0 1 11 1.5v1A1.5 1.5 0 0 1 9.5 4h-3A1.5 1.5 0 0 1 5 2.5v-1Zm5 0a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h3a.5.5 0 0 0 .5-.5v-1Z"/>
  <path d="M3 1.5h1v1H3a1 1 0 0 0-1 1V14a1 1 0 0 0 1 1h10a1 1 0 0 0 1-1V3.5a1 1 0 0 0-1-1h-1v-1h1a2 2 0 0 1 2 2V14a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2V3.5a2 2 0 0 1 2-2Z"/>
  <path d="M8 6.982C9.664 5.309 13.825 8.236 8 12 2.175 8.236 6.336 5.31 8 6.982Z"/>
</svg></h4>
                             
                        
                        </table>
                     </div>
                     </a>
                    </div>
               </div>
                <div class="hangoutDiv col mb-4">
                    <div class="card card-cover h-100 overflow-hidden rounded-5">
                     <a href="${ contextPath }/joinCommunity.my" style="text-decoration-line: none;">
                     <div class="d-flex flex-column p-5">
                        <table class="mt-4 md-auto">
                         
                           <h4 class=" ffont">내가 참여한 커뮤니티 &nbsp;<svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-clipboard2-check" viewBox="0 0 16 16">
  <path d="M9.5 0a.5.5 0 0 1 .5.5.5.5 0 0 0 .5.5.5.5 0 0 1 .5.5V2a.5.5 0 0 1-.5.5h-5A.5.5 0 0 1 5 2v-.5a.5.5 0 0 1 .5-.5.5.5 0 0 0 .5-.5.5.5 0 0 1 .5-.5h3Z"/>
  <path d="M3 2.5a.5.5 0 0 1 .5-.5H4a.5.5 0 0 0 0-1h-.5A1.5 1.5 0 0 0 2 2.5v12A1.5 1.5 0 0 0 3.5 16h9a1.5 1.5 0 0 0 1.5-1.5v-12A1.5 1.5 0 0 0 12.5 1H12a.5.5 0 0 0 0 1h.5a.5.5 0 0 1 .5.5v12a.5.5 0 0 1-.5.5h-9a.5.5 0 0 1-.5-.5v-12Z"/>
  <path d="M10.854 7.854a.5.5 0 0 0-.708-.708L7.5 9.793 6.354 8.646a.5.5 0 1 0-.708.708l1.5 1.5a.5.5 0 0 0 .708 0l3-3Z"/>
</svg></h4>
                             
                        
                        </table>
                     </div>
                     </a>
                    </div>
               </div>
         
         </div>
      
         <div id="hangoutList" class="row row-cols-1 row-cols-sm-1 row-cols-md-1 row-cols-lg-3 justify-content-start" >
               <div class="hangoutDiv col mb-4">
                    <div class="card card-cover h-100 overflow-hidden rounded-5">
                      <a href="${ contextPath }/myComments.my" style="text-decoration-line: none;" >
                     <div class="d-flex flex-column p-5">
                        <table class="mt-4 md-auto">
                       
                           <h4 class=" ffont">내가 쓴 댓글&nbsp; <i class="bi bi-receipt"></i></h4>
                          
                          
                        </table>
                     </div>
                     </a>
                    </div>
               </div>
               <div class="hangoutDiv col mb-4">
                    <div class="card card-cover h-100 overflow-hidden rounded-5">
                     <a href="${ contextPath }/selectMyReview.my" style="text-decoration-line: none;">
                     <div class="d-flex flex-column p-5">
                        <table class="mt-4 md-auto">
                        
                           <h4 class=" ffont">내가 쓴 리뷰&nbsp; <i class="bi bi-chat-right-text"></i></h4>
                          
                          
                        </table>
                     </div>
                     </a>
                    </div>
               </div>
               <div class="hangoutDiv col mb-4">
                    <div class="card card-cover h-100 overflow-hidden rounded-5">
                     <a href="${ contextPath }/myMakeCommunity.my" style="text-decoration-line: none;">
                     <div class="d-flex flex-column p-5">
                        <table class="mt-4 md-auto">
                        
                           <h4 class=" ffont">내가 만든 커뮤니티&nbsp; <i class="bi bi-clipboard-data"></i></h4>
                          
                         
                        </table>
                     </div>
                     </a>
                    </div>
               </div>
         </div>         
         </div>
       </div>
</div>
<br><br><br><br><br><br><br><br>
   <jsp:include page="../common/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.min.js" integrity="sha384-IDwe1+LCz02ROU9k972gdyvl+AESN10+x7tBKgc9I5HFtuNz0wWnPclzo6p9vxnk" crossorigin="anonymous"></script>
</body>
</html>