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
            <form action="" method="post" role="form" class="php-email-form">
              <div class="form-group mt-3">
               	ID
                <input type="text" name="gstId" value="${gstDetail.gstId}" readonly style="background-color: #F6F6F6;" class="form-control">
              </div>
              <div class="row justify-content-center">
                <div class="col-8 form-group">
                  PW
				<input type="password" readonly style="background-color: #F6F6F6;" class="form-control" name="gstPw">				  
                </div>
                <div class="col text-center mt-4">
                	<button type="button" id="passwordModify_btn" onclick="window.location.href='${pageContext.request.contextPath}/customer/gstPWModify'">비밀번호 수정</button>
                </div>
              </div>
              <div class="form-group mt-3">
              	이름
                <input type="text" value="${gstDetail.gstName}" readonly style="background-color: #F6F6F6;" class="form-control" name="gstName">
              </div>
              <div class="form-group mt-3">
              	Email
                <input type="text" value="${gstDetail.gstEmail}" readonly style="background-color: #F6F6F6;" class="form-control" name="gstEmail">
              </div>
              <div class="form-group mt-3">
              	성별
                <input type="text" value="${gstDetail.gstGender}" readonly style="background-color: #F6F6F6;" class="form-control" name="gstGender">
              </div>
              <div class="form-group mt-3">
              	생년월일
                <input type="text" value="${gstDetail.gstBirth}" readonly style="background-color: #F6F6F6;" class="form-control" name="gstBirth">
              </div>
              <div class="form-group mt-3">
             	연락처
                <input type="text" value="${gstDetail.gstPhone}" readonly style="background-color: #F6F6F6;" class="form-control" name="gstPhone">
              </div>
              <div class="form-group mt-3">
              	고객 타입
                <input type="text" value="${gstDetail.gstType}" readonly style="background-color: #F6F6F6;" class="form-control" name="gstType">
              </div>
              <div class="form-group mt-3">
              	주소
                <input type="text" value="${gstDetail.postNo}" readonly style="background-color: #F6F6F6; margin-bottom: 10px;" class="form-control" name="postNo">
                <input type="text" value="${gstDetail.address}" readonly style="background-color: #F6F6F6;" class="form-control" name="address">
              </div>
              
            <!-- Null 일 경우 안보이도록 처리 예정 -->
            <c:if test="${not empty gstDetail.roomNo}">
			  <div class="form-group mt-3">
			  	룸 번호
			    <input type="text" value="${gstDetail.roomNo}" readonly style="background-color: #F6F6F6;" class="form-control" name="roomNo">
			  </div>
			</c:if>
			
			<c:if test="${not empty gstDetail.roomType}">
			  <div class="form-group mt-3">
			  	룸 타입
			    <input type="text" value="${gstDetail.roomType}" readonly style="background-color: #F6F6F6;" class="form-control" name="roomType">
			  </div>
			</c:if>
			
			<c:if test="${not empty gstDetail.roomDong}">
			  <div class="form-group mt-3">
			  	룸 주소
			    <input type="text" value="${gstDetail.roomDong}" readonly style="background-color: #F6F6F6; margin-bottom: 10px;" class="form-control" name="roomDong">
			    <input type="text" value="${gstDetail.roomHo}" readonly style="background-color: #F6F6F6;" class="form-control" name="roomDong">
			  </div>
			</c:if>
			
			<c:if test="${not empty gstDetail.roomAmenity}">
			  <div class="form-group mt-3">
			  	어메니티 신청
			    <input type="text" value="${gstDetail.roomAmenity}" readonly style="background-color: #F6F6F6;" class="form-control" id="roomAmenity" name="roomAmenity">
			  </div>
			</c:if>
			
			<c:if test="${not empty gstDetail.residentNote}">
			  <div class="form-group mt-3">
			  	입주자 전달사항
			    <input type="text" value="${gstDetail.residentNote}" readonly style="background-color: #F6F6F6;" class="form-control" name="residentNote">
			  </div>
			</c:if>
			
			<c:if test="${not empty gstDetail.protectorName}">
			  <div class="form-group mt-3">
			  	보호자 이름
			    <input type="text" value="${gstDetail.protectorName}" readonly style="background-color: #F6F6F6;" class="form-control" name="protectorName">
			  </div>
			</c:if>
			
			<c:if test="${not empty gstDetail.protectorPhone}">
			  <div class="form-group mt-3">
			  	보호자 연락처
			    <input type="text" value="${gstDetail.protectorPhone}" readonly style="background-color: #F6F6F6;" class="form-control" name="protectorPhone">
			  </div>
			</c:if>
			
			<c:if test="${not empty gstDetail.protectorRelation}">
			  <div class="form-group mt-3">
			  	보호자와의 관계
			    <input type="text" value="${gstDetail.protectorRelation}" readonly style="background-color: #F6F6F6;" class="form-control" name="protectorRelation">
			  </div>
			</c:if>
              
              <div class="row justify-content-center">
              	<div class="col-md-6 mt-3 text-center"><button type="button" id="deleteGst_btn">탈퇴하기</button></div>
              	<div class="col-md-6 mt-3 text-center"><button type="button" onclick="window.location.href='${pageContext.request.contextPath}/customer/gstMyInfoModify'">수정하기</button></div>
              </div>
            </form>
            
          </div><!-- End Contact Form -->

        </div>

      </div>

    </section><!-- 입력 폼 끝 -->   
    
    <!-- Modal : 탈퇴 확인 메세지 -->
    <div class="modal fade" id="deleteCheck" tabindex="-1">
		<div class="modal-dialog modal-dialog-centered"><div class="modal-content">
			<!-- 모달 탈퇴 확인 폼 -->
			<form id="deleteCheck_form" action="${pageContext.request.contextPath}/customer/deleteGst" method="post">
				<div class="modal-body">
					<div class="row mb-5">
						<div class="col mt-5 text-center">
							<span>TOPAZ 회원을 탈퇴하시겠습니까? </span>
						</div>
					</div>
				</div>
				
				<!-- 모달 탈퇴 취소/탈퇴버튼 -->
				<div class="modal-footer justify-content-center">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
					<a><button id="deleteCheck_btn" type="submit" style="background-color: #34bf49; border-color: #34bf49;" class="btn btn-primary">탈퇴</button></a>
				</div>
			</form>
		</div></div>
	</div><!-- End Modal-->
    
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

  <script src="<c:url value='/js/eunhyeGstMyInfo.js'/>"></script>

  <!-- Main JS File -->
  <script src="/topaz/assets/js/mainGST.js"></script>

</body>

</html>