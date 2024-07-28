<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fm" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <title>회원가입</title>
  <!-- Favicons -->
  <link href="/topaz//topaz/assets/img/TOPAZ_logo.png" rel="icon">

  <!-- Fonts -->
  <link href="https://fonts.googleapis.com" rel="preconnect">
  <link href="https://fonts.gstatic.com" rel="preconnect" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&family=Lato:ital,wght@0,100;0,300;0,400;0,700;0,900;1,100;1,300;1,400;1,700;1,900&display=swap" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="/topaz/assets/vendorGST/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="/topaz/assets/vendorGST/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="/topaz/assets/vendorGST/aos/aos.css" rel="stylesheet">
  <link href="/topaz/assets/vendorGST/swiper/swiper-bundle.min.css" rel="stylesheet">
  <link href="/topaz/assets/vendorGST/glightbox/css/glightbox.min.css" rel="stylesheet">
  
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> <!-- Jquery -->
  <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script><!-- 다음 주소 API -->

  <!-- Main CSS File -->
  <link href="/topaz/assets/css/main.css" rel="stylesheet">
</head>

<body class="team-page">
  <!-- Header -->
  <jsp:include page="inc/header.jsp"></jsp:include>

  <main class="main">

    <!-- Page Title -->
    <div class="page-title light-background">
      <div class="container">
        <h1>내 정보</h1>
        <nav class="breadcrumbs">
          <ol>
            <li><a href="gstMain">Home</a></li>
            <li class="current">내 정보</li>
          </ol>
        </nav>
      </div>
    </div><!-- Page Title 끝 -->

    <!-- 입력 폼 -->
    <section id="contact" class="contact section">
      <div class="container" data-aos="fade">
        <div class="row justify-content-center gy-5 gx-lg-5">
          <div class="col-lg-6">
          <!-- 폼 이름 입력 -->
            <form action="${pageContext.request.contextPath}/customer/modifyGstPw" method="post" role="form" class="php-email-form">
              <div class="row">
                <div class="col form-group">
                	<% String gstId = (String) session.getAttribute("gstId"); %>
                  <input type="text" name="gstId" id="gstId" value="<%= gstId %>" class="form-control" placeholder="ID 4자 이상 입력">
				  <div class="id-message hide"></div>
                </div>
              </div>
              
              <div class="col form-group">
              	<input type="password" name="oldPw" id="oldPw" class="form-control" placeholder="현재 비밀번호">
				<div class="oldPw-message hide"></div>
              </div>
              
              <div class="col form-group">
                <input type="password" name="newPw" id="newPw" class="form-control" placeholder="새 비밀번호">
		  		<div class="newPw-message hide"></div>
              </div>
            
              <div class="col form-group">
                <input type="password" name="newPwCk" id="newPwCk" class="form-control" placeholder="새 비밀번호 확인 ">
		  		<div class="newPwCk-message hide"></div>
              </div>
              
              <div class="row justify-content-center">
              	<div class="col-md-6 mt-3 text-center"><button type="submit" id="pwMod_btn">수정하기</button></div>
              </div>
            </form>
            
          </div><!-- End Contact Form -->
        </div>
      </div>
    </section><!-- 입력 폼 끝 -->   
  </main>

  <!-- footer -->
  <jsp:include page="inc/footer.jsp"></jsp:include>

  <!-- Scroll Top -->
  <a href="#" id="scroll-top" class="scroll-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

  <!-- Preloader -->
  <div id="preloader"></div>

  <!-- Vendor JS Files -->
  <script src="/topaz/assets/vendorGST/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="/topaz/assets/vendorGST/aos/aos.js"></script>
  <script src="/topaz/assets/vendorGST/swiper/swiper-bundle.min.js"></script>
  <script src="/topaz/assets/vendorGST/purecounter/purecounter_vanilla.js"></script>
  <script src="/topaz/assets/vendorGST/glightbox/js/glightbox.min.js"></script>
  <script src="/topaz/assets/vendorGST/imagesloaded/imagesloaded.pkgd.min.js"></script>
  <script src="/topaz/assets/vendorGST/isotope-layout/isotope.pkgd.min.js"></script>

  <!-- Main JS File -->
  <script src="/topaz/assets/js/mainGST.js"></script>
  <script type="text/javascript">
  
  	$(document).ready(function(){
	    
	    $('#pwMod_btn').click(function(e){
	        e.preventDefault(); // 기본 폼 제출 방지
	        console.log('pwMod_btn 클릭');
	        
	        let validation = true;
	        const oldPw = $("input[name='oldPw']").val().trim();
	        const newPw = $("input[name='newPw']").val().trim();
	        const newPwCk = $("input[name='newPwCk']").val().trim();
	        
	        const pwPattern = /^[a-zA-Z0-9]{4,20}$/;
	        const idPattern = /^[a-zA-Z0-9]{4,20}$/;

	        if(oldPw === ""){
	            alert("이전 비밀번호를 입력해주세요.");
	            $('#oldPw').focus();
	            validation = false;
	        } else if(newPw === ""){
	            alert("새 비밀번호를 입력해주세요.");
	            $('#newPw').focus();
	            validation = false;
	        } else if(newPwCk === ""){
	            alert("비밀번호 확인란을 입력해주세요.");
	            $('#newPwCk').focus();
	            validation = false;
	        } else if (!pwPattern.test(oldPw) || !pwPattern.test(newPw) || !pwPattern.test(newPwCk)) {
	            alert("비밀번호는 영어와 숫자를 사용하여 4-20자 입력해야합니다.");
	            validation = false;
	        } else if(newPwCk !== newPw){
	            alert("비밀번호가 일치하지 않습니다.");
	            validation = false;
	        }

	     	// 유효성 검사를 통과한 경우 폼을 제출
	        if (validation) {
	            $("form").submit();
	        }
	    });
	});
  
  </script>

</body>

</html>