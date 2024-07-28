<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fm" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <title>회원가입</title>
  <link href="/topaz/assets/img/TOPAZ_logo.png" rel="icon">
  <link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet">
  <link href="/topaz/assets/vendorGST/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="/topaz/assets/vendorGST/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="/topaz/assets/vendorGST/aos/aos.css" rel="stylesheet">
  <link href="/topaz/assets/vendorGST/swiper/swiper-bundle.min.css" rel="stylesheet">
  <link href="/topaz/assets/vendorGST/glightbox/css/glightbox.min.css" rel="stylesheet">
  
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> <!-- Jquery -->
  <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script><!-- 다음 주소 API -->
  <link href="/topaz/assets/css/main.css" rel="stylesheet">

  <style>
      .disabled-button {
          background-color: #BDBDBD !important;
          cursor: not-allowed;
          color: white;
      }
  </style>
</head>

<body class="team-page">
  <jsp:include page="inc/header.jsp"></jsp:include>

  <main class="main">
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
    </div>

    <section id="contact" class="contact section">
      <div class="container" data-aos="fade">
        <div class="row justify-content-center gy-5 gx-lg-5">
          <div class="col-lg-6">
            <form id="passwordForm" action="${pageContext.request.contextPath}/customer/findGstPw" method="post" role="form" class="php-email-form">
              <div class="row">
                <div class="col-8 form-group">
                  <input type="text" name="gstId" id="gstId" class="form-control" placeholder="ID 4자 이상 입력">
                  <div class="id-message hide"></div>
                </div>
                <div class="col text-center">
                  <button type="button" id="idCheck_btn">ID 확인</button>
                </div>
              </div>
              
              <div class="row">
                <div class="col-8 form-group">
                  <input type="text" name="gstName" id="gstName" class="form-control" placeholder="가입한 이름 입력">
                  <div class="name-message hide"></div>
                </div>
                <div class="col text-center">
                  <button type="button" id="nameCheck_btn">이름 확인</button>
                </div>
              </div>
              
              <div class="row justify-content-center">
                <div class="col-md-6 mt-3 text-center">
                  <button type="submit" id="getPw_btn" class="disabled-button" disabled>임시 비밀번호 받기</button>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
    </section>   
    
    <div class="modal fade" id="pwModal" tabindex="-1" role="dialog" aria-labelledby="pwModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="pwModalLabel">임시 비밀번호</h5>
        </div>
        <div class="modal-body">
          <p id="tempPw"></p>
        </div>
        <div class="modal-footer justify-content-center">
          <button type="button" id="closeModalBtn" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        </div>
      </div>
    </div>
  </div>
  </main>

  <jsp:include page="inc/footer.jsp"></jsp:include>
  <a href="#" id="scroll-top" class="scroll-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>
  <div id="preloader"></div>
  <script src="/topaz/assets/vendorGST/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="/topaz/assets/vendorGST/aos/aos.js"></script>
  <script src="/topaz/assets/vendorGST/swiper/swiper-bundle.min.js"></script>
  <script src="/topaz/assets/vendorGST/purecounter/purecounter_vanilla.js"></script>
  <script src="/topaz/assets/vendorGST/glightbox/js/glightbox.min.js"></script>
  <script src="/topaz/assets/vendorGST/imagesloaded/imagesloaded.pkgd.min.js"></script>
  <script src="/topaz/assets/vendorGST/isotope-layout/isotope.pkgd.min.js"></script>
  <script src="/topaz/assets/js/mainGST.js"></script>

  <script type="text/javascript">
    $(document).ready(function(){
        var isIdValid = false;
        var isNameValid = false;

        $('#idCheck_btn').click(function(){
            const gstId = $('#gstId').val().trim();
            const idPattern = /^[a-zA-Z0-9]{4,20}$/;

            if(gstId === ""){
                alert("ID를 입력해주세요.");
                $('#gstId').focus();
                isIdValid = false;
                updateSubmitButtonState();
                return;
            } else if(!idPattern.test(gstId)){
                alert("ID는 영어와 숫자를 사용하여 4-20자 입력해야합니다.");
                isIdValid = false;
                updateSubmitButtonState();
                return;
            }

            $.ajax({
                url:'/topaz/customer/idCheck',
                method:'post',
                data: { gstId: gstId },
                success:function(data){
                    if(data == 0){
                        $('.id-message').removeClass('hide').text(' 존재하지 않는 ID입니다.').css('color', 'red');
                        $('#gstId').focus();
                        isIdValid = false;
                    } else {
                        $('.id-message').removeClass('hide').text(' 존재하는 ID입니다.').css('color', 'green');
                        isIdValid = true;
                    }
                    updateSubmitButtonState();
                }
            });
        });

        $('#nameCheck_btn').click(function(){
            const gstName = $('#gstName').val().trim();
            const gstId = $('#gstId').val().trim();
            const namePattern = /^[a-zA-Z가-힣]{1,20}$/;

            if(gstName === ""){
                alert("이름을 입력해주세요.");
                $('#gstName').focus();
                isNameValid = false;
                updateSubmitButtonState();
                return;
            } else if(!namePattern.test(gstName)){
                alert("이름은 한글로 2자 이상 입력해야합니다.");
                isNameValid = false;
                updateSubmitButtonState();
                return;
            }

            $.ajax({
                url:'/topaz/customer/nameCheck',
                method:'post',
                data: { gstName: gstName, gstId: gstId },
                success:function(data){
                    if(data == 0){
                        $('.name-message').removeClass('hide').text(' 이름을 다시 확인해주세요.').css('color', 'red');
                        $('#gstName').focus();
                        isNameValid = false;
                    } else {
                        $('.name-message').removeClass('hide').text(' ID에 해당하는 이름입니다.').css('color', 'green');
                        isNameValid = true;
                    }
                    updateSubmitButtonState();
                }
            });
        });

        $('#passwordForm').submit(function(e){
            e.preventDefault(); // 기본 폼 제출 방지

            if (isIdValid && isNameValid) {
                // AJAX 요청 보내기
                const gstId = $('#gstId').val().trim();
                const gstName = $('#gstName').val().trim();

                $.ajax({
                    url: '/topaz/customer/findGstPw',
                    method: 'post',
                    data: { gstId: gstId, gstName: gstName },
                    success: function(response){
                        if(response.status === "success"){
                            // 모달에 임시 비밀번호 표시
                            $('#tempPw').html("발급된 임시 비밀번호는 [ " + response.newPw + " ] 입니다. <br>보안을 위해 로그인 후 변경해주세요.");
                            $('#pwModal').modal('show'); // 모달 표시
                        } else {
                            alert("임시 비밀번호 발급에 실패했습니다.");
                        }
                    }
                });
            } else {
                alert("ID와 이름을 확인하세요.");
            }
        });

        function updateSubmitButtonState() {
            if (isIdValid && isNameValid) {
                $('#getPw_btn').removeClass('disabled-button').prop('disabled', false);
            } else {
                $('#getPw_btn').addClass('disabled-button').prop('disabled', true);
            }
        }
     	// 닫기 버튼을 누르면 로그인 페이지로 보내기 
        $('#closeModalBtn').click(function() {
            window.location.href = "/topaz/customer/gstLogin"; 
        });
    });
  </script>

</body>
</html>
