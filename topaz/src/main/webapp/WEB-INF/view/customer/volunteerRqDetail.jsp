<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <title>봉사신청</title>
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

  <!-- Main CSS File -->
  <link href="/topaz/assets/css/main.css" rel="stylesheet">
   
</head>

<body class="team-page">
<%
    // 로그인 상태 확인
    String gstId = (String) session.getAttribute("gstId");
    if (gstId == null) {
%>
    <script type="text/javascript">
        alert("로그인 해주세요.");
        window.location.href = "/topaz/customer/gstLogin";
    </script>
<%       
        return;
    }
%>
  <!-- Header -->
  <header id="header" class="header d-flex align-items-center sticky-top">
    <div class="container-fluid container-xl position-relative d-flex align-items-center justify-content-between">

      <a href="gstMain" class="logo d-flex align-items-center">
        <!-- 로고 이미지 -->
        <img src="/topaz/assets/img/TOPAZ_logo.png" alt="">
        <h1 class="sitename">TOPAZ.</h1>
      </a>

      <nav id="navmenu" class="navmenu">
        <ul>
          <li><a href="gstMain" class="active">Home</a></li>
          <li><a href="infoPrograms">서비스 및 프로그램</a></li>&nbsp;&nbsp;&nbsp;
          <li class="dropdown"><span>세대 안내</span> <i class="bi bi-chevron-down toggle-dropdown"></i>
            <ul>
              <li><a href="infoRegidentDiamond">다이아몬드동</a></li>
              <li><a href="infoRegidentSilver">실버동</a></li>
              <li><a href="infoStep">입주 절차</a></li>
            </ul>
          </li>&nbsp;&nbsp;
          <li><a href="volunteerRqAdd">봉사 신청</a></li>
          <li><a href="newsList">알림마당</a></li>
          <!-- JavaScript로 동적으로 변경될 부분 -->
          <li><a href="gstMyInfo" id="myInfoLink" class="active">내 정보</a></li>
          <li><a href="gstLogin" id="loginLink" class="active">로그인</a></li>
          <li><a href="signUp" id="signUpLink" class="active">회원가입</a></li>
          <li><a href="${pageContext.request.contextPath}/gstLogout">로그아웃</a></li>

        </ul>
        <i class="mobile-nav-toggle d-xl-none bi bi-list"></i>
      </nav>
    </div>
  </header><!-- Header 끝 -->

  <main class="main">

    <!-- Page Title -->
    <div class="page-title light-background">
      <div class="container">
        <h1>봉사 신청</h1>
        <nav class="breadcrumbs">
          <ol>
            <li><a href="gstMain.html">Home</a></li>
            <li class="current">봉사 신청</li>
          </ol>
        </nav>
      </div>
    </div><!-- Page Title 끝 -->
    
    <c:set var="v" value="${volunteerOne}"></c:set>
    
    <!-- 입력 폼 -->
    <section id="contact" class="contact section">

      <div class="container" data-aos="fade">

        <div class="row justify-content-center gy-5 gx-lg-5">
          <div class="col-6">
          	<div class="mb-5">
          		<h4>봉사 상세보기</h4>
          	</div>
            <form action="" method="post" role="form" class="php-email-form">
             <div class="row">
             	<label for="volStartTime" class="col-3 col-form-label">봉사 날짜 및 시간</label>
                <div class="col-9 form-group">
                 	<input type="text" name="volStartTime" id="volStartTime" class="form-control" value="${v.volStartTime}  -  ${v.volEndTime}" readonly>
                </div>
             </div>
             
              <div class="row">
             	<label for="volPeople" class="col-3 col-form-label">신청 가능 인원 수</label>
                <div class="col-9 form-group">
                 	<input type="text" name="volPeople" id="volPeople" class="form-control" value="${v.volPeople}" readonly>
                </div>
             </div>
             
             <div class="row">
             	<label for="volContent" class="col-3 col-form-label">봉사 내용</label>
                <div class="col-9 form-group">
                 	<input type="text" name="volContent" id="volContent" class="form-control" value="${v.volContent}" readonly>
                </div>
             </div>
             
             <div class="my-3">
               <div class="loading">Loading</div>
               <div class="error-message"></div>
               <div class="sent-message">Your message has been sent. Thank you!</div>
             </div>
             <div class="row justify-content-center">
             	<div class="col-4 mt-3 text-center"><button type="button" onclick="history.back()" style="background-color: #C3C3C3;">뒤로가기</button></div>
             	<div class="col-4 mt-3 text-center"><button type="button" id="volApp_btn">신청하기</button></div>
             </div>
            </form>
            
          </div><!-- End Contact Form -->

        </div>

      </div>

    </section><!-- 입력 폼 끝 -->   
    
    
    <!-- Modal -->
	<!-- addSchedule 모달창 : 봉사 신청 폼 -->
	<div class="modal fade" id="volApp" tabindex="-1">
		<div class="modal-dialog modal-dialog-centered"><div class="modal-content">
			<!-- 모달 제목 -->
			<div class="modal-header">
				<h5 class="modal-title">봉사 신청</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			
			<!-- 모달 봉사 신청 폼 -->
			<form id="addVolunteerApp" action="${pageContext.request.contextPath}/customer/volunteerRqDetail" method="post">
				<div class="modal-body">
					<div class="row mb-5">
						<input type="hidden" value="${v.volNo}" name="volNo">
						
						<label for="volAppPeople" class="col-4 mb-3 col-form-label">신청 인원</label>
						<div class="col-8 mb-3">
							<input type="text" class="form-control" id="volAppPeople" name="volAppPeople">
						</div>
						
						<label for="volAppComment" class="col-4 mb-3 col-form-label">신청 내용</label>
						<div class="col-8 mb-3">
							<textarea rows="3" maxlength="100" class="col-sm-12" id="volAppComment" name="volAppComment" placeholder="하고싶은 말을 100자 이하로 작성해주세요." style="height: 150px"></textarea>
							(<span id="chatHelper">0</span>/100)
						</div>
					</div>
				</div>
				
				<!-- 모달 일정 취소/등록버튼 -->
				<div class="modal-footer justify-content-center">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
					<button id="AddVolApp_btn" type="submit" class="btn btn-primary" style="background-color: #34bf49; border-color: #34bf49;">신청</button>
				</div>
			</form>
		</div></div>
	</div><!-- End addSchedule Modal-->
    
    
    
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
  	$("#volApp_btn").click(function(event){
  		event.preventDefault();
		console.log('volApp_btn 클릭 !!');
		
		if(parseInt($('#volPeople').val()) == 0){
			console.log('volPeople : ', $('#volPeople').val());
			alert('신청 가능한 인원이 없습니다.');
		} else {
  			$("#volApp").modal("show");
		}
  	});
  	
  	 // 폼 제출 이벤트 처리
    $("#addVolunteerApp").on("submit", function(event) {
        event.preventDefault();

        var formData = $(this).serialize(); // 폼 데이터 직렬화

        $.ajax({
            type: "POST",
            url: $(this).attr("action"),
            data: formData,
            success: function(response) {
                // 성공적인 응답 처리
                alert("신청이 완료되었습니다."); // 알림 표시
                window.location.href = "/topaz/customer/volunteerRqAdd";
            },
            error: function() {
                // 에러 처리
                alert("신청 중 오류가 발생했습니다. 다시 시도해주세요.");
            }
        });
    });
  	
	 // 신청 내용 글자 수 세기
    $("#volAppComment").on("input", function() {
        var maxLength = 100;
        var currentLength = $(this).val().length;
        $("#chatHelper").text(currentLength);

        if (currentLength > maxLength) {
            $(this).val($(this).val().substring(0, maxLength));
            $("#chatHelper").text(maxLength);
        }
    });
  
	 
	// 입력값 유효성 검사 
	$('#AddVolApp_btn').click(function(){
		// 신청 인원
		if($('#volAppPeople').val().length < 1){
			alert('신청 인원을 입력해주세요.');
			$('#volAppPeople').focus();
			return false; 
		}
		
		// 신청 내용
		if($('#volAppComment').val().length < 1){
			alert('신청 내용을 입력해주세요.');
			$('#volAppComment').focus();
			return false; 
		}
		
		// 신청 인원이 신청 가능 인원보다 많은 경우
		if(parseInt($('#volAppPeople').val()) > parseInt($('#volPeople').val())){
			alert('신청 가능 인원보다 많습니다. 다시 확인해주세요.');
			$('#volAppPeople').focus();
			return false; 
		}
		
		
		
		
	});
  
	
	
	
  </script>
  
</body>

</html>