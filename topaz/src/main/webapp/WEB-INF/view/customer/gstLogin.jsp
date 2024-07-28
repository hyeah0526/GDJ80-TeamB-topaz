<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!--
   분류번호: #15 - 로그인
   시작 날짜: 2024-07-07
   담당자: 한은혜
-->
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>로그인</title>
  <!-- Favicons -->
  <link href="/topaz/assets/img/TOPAZ_logo.png" rel="icon">

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

  <!-- Main CSS File -->
  <link href="/topaz/assets/css/main.css" rel="stylesheet">
</head>

<body class="contact-page">
  <!-- Header -->
  <jsp:include page="inc/header.jsp"></jsp:include>

  <main class="main">
    <!-- 입력 폼 -->
    <section id="contact" class="contact section">

      <div class="container" data-aos="fade">

        <div class="row justify-content-center">
	          <div class="col-lg-4 ">
	            <form action="${pageContext.request.contextPath}/loginPost" method="post" class="php-email-form">
		            <div class="row mb-3 mt-5">
		              	<div class="text-center justify-content-center" style="color: red;">
							<span>${errMsg }</span>
						</div>
		              	  <div class="form-group mt-3">
		                	<label for="id" class="form-label">ID</label>
		                 	<input type="text" name="id" class="form-control" id="id" value="G002">
		                  </div>
		              
			              <div class="form-group mt-3 mb-3">
			              	<label for="pw" class="form-label">PW</label>
			                <input type="password" class="form-control" name="pw" id="pw" value="1234">
			              </div>
		              </div>
		              <div>
		              	<input type="hidden" name="userType" value="guest">
		              </div>
		              <div class="text-center mb-3 mt-3"><button type="submit">Login</button></div>
		              <div class="row mb-5">
			              <div class="col">
			              	<a href="gstFindPW" style="color: white;"><button type="button">비밀번호 찾기</button></a>
			              </div>
			              <div class="col">
			              	<a href="signUp" style="color: white; "><button type="button">회원가입</button></a>
			              </div>
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

</body>

</html>