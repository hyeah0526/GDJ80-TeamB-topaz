<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fm" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <title>내 봉사신청 리스트</title>
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
          <li><a href="gstMain">Home</a></li>
          <li><a href="infoCompany">회사소개</a></li>
          <li><a href="infoPrograms">프로그램</a></li>
          <li class="dropdown"><a href="infoRegident"><span>세대 안내</span> <i class="bi bi-chevron-down toggle-dropdown"></i></a>
            <ul>
              <li><a href="infoRegidentA">A동</a></li>
              <li><a href="#">B동</a></li>
              <li><a href="#">C동</a></li>
              <li><a href="#">Dropdown 4</a></li>
            </ul>
          </li>
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
          <div class="col-10">
          <!-- 봉사 신청 정보 리스트 -->
          <table class="table table-hover">
              <thead>
                <tr>
                  <th scope="col">봉사 일시</th>
                  <th scope="col">봉사 내용</th>
                  <th scope="col">신청 인원</th>
                  <th scope="col">신청 내용</th>
                  <th scope="col">신청 상태</th>
                  <th scope="col"></th>
                </tr>
              </thead>
              <tbody id="tableBody">
                 <!-- Ajax 데이터 조회 추가 -->
              </tbody>
           </table>
          
            
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

  <script type="text/javascript">
  
  
  // Ajax 리스트 호출 
  $.ajax({
      url: '/topaz/customer/myVolAppList',
      type: 'GET',
      success: function(response) {
          console.log("response : ", response);

          // 리스트 불러올 tbody
          let tbody = $('#tableBody');
          tbody.empty();

       	// response 데이터만큼 리스트 생성
          if (Array.isArray(response)) {
        	  response.forEach(function(item) {
                  let row = '<tr data-vol-app-no="' + item.volAppNo + '" data-vol-no="'+ item.volNo + '">';
                  row += '<td scope="row">' + item.volStartTime + ' - ' + item.volEndTime + '</td>';
                  row += '<td>' + item.volContent + '</td>';
                  row += '<td>' + item.volAppPeople + '</td>';
                  row += '<td>' + item.volAppComment + '</td>';
                  row += '<td>' + item.volAppState + '</td>';
                  
               	  // 신청 상태가 '대기'일 때에만 취소버튼 활성화
                  let buttonClass = 'btn-secondary';
                  let buttonDisabled = 'disabled';
                  console.log("volAppState : ", item.volAppState);
                  
                  if (item.volAppState == '대기') {
                      buttonClass = 'btn-danger';
                      buttonDisabled = '';
                  }
                  
                  row += 
                		'<td>' +
			                 '<form method="POST" action="/topaz/modifyVolAppState" class="modifyVolAppStateForm">' +
				                 '<input type="hidden" name="volAppNo" value="' + item.volAppNo + '">' +
				                 '<input type="hidden" name="volAppState" value="4">' +
				                 '<input type="hidden" name="volNo" value="' + item.volNo + '">' +
				                 '<input type="hidden" name="gstId" value="' + item.gstId + '">' +
				                 '<input type="hidden" name="volAppPeople" value="' + item.volAppPeople + '">' +
				                 '<button type="submit" class="btn ' + buttonClass + '" ' + buttonDisabled + '>취소</button>' +
			                 '</form>' +
		                '</td>';
                  row += '</tr>';

                  // tbody에 행 추가
                  tbody.append(row);
              });
          }
       	
       	// 취소 성공일 경우 알림
       	$('.modifyVolAppStateForm').on('submit', function(event){
       		event.preventDefault();
       		
       		let form = $(this);
       		$.ajax({
       			type: form.attr('method'),
                url: form.attr('action'),
                data: form.serialize(),
                success: function(response) {
                    // 취소 성공 메시지 표시
                    alert('성공적으로 취소되었습니다.');
                    location.reload(); // 페이지 새로고침
                }
       		});
       		
       	});
       	
      }
  });
  
              
  
  </script>
  <!-- Main JS File -->
  <script src="/topaz/assets/js/mainGST.js"></script>
  

</body>

</html>