<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<!-- ======= header <Head> 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/headerHead.jsp"></jsp:include>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> <!-- Jquery -->
    <script src="/topaz/javascriptSignature/js/signature_pad.min.js" type="text/javascript"></script>
	<link rel="stylesheet" href="/topaz/javascriptSignature/css/css.css">
	<style>
</style>
</head>
	
<body>
	<!-- ======= header <Body> 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/hearderBody.jsp"></jsp:include>
	
	<!-- ======= sideBar 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/sideBar.jsp"></jsp:include>

	<!-- =============================== Main 메인 시작 부분 ================================ -->
	<main id="main" class="main">
	
	<!-- Title 시작 -->
	<div class="pagetitle">
      <h1>서명</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="index.html">중제목</a></li>
          <li class="breadcrumb-item active">소제목</li>
        </ol>
      </nav>
	</div><!-- Title 종료 -->
	<!-- http://localhost/topaz/groupware/approvalSign -->
	
	
	<!-- section 시작 -->
		<section class="section">
            <div class="row">
                <div class="col-lg-12">
                    <div class="card">
                        <div class="card-body">
                            <button type="button" id="show-signature-pad">서명하기</button>
                            <div id="signature-pad" class="m-signature-pad">
                                <div class="m-signature-pad--body">
                                    <canvas></canvas>
                                </div>
                                <div class="m-signature-pad--footer">
                                	<input type="text" id="signText" placeholder="텍스트를 입력하세요.">
                                    <div class="description">서명해 주세요</div>
                                    <button type="button" class="button clear" data-action="clear">초기화</button>
                                    <button type="button" class="button save" data-action="save">저장</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

	</main><!-- End #main -->
	<!-- =============================== Main 메인 끝 부분 ================================ -->
	
	<!-- ======= footer 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/footer.jsp"></jsp:include>
	   
    <script>
    let canvas = $("#signature-pad canvas")[0];
    let sign = new SignaturePad(canvas, {
        minWidth: 1, // 초기값 5
        maxWidth: 3, // 초기값 10
        penColor: "rgb(0, 0, 0)" // 서명 색상
    });
    
    $("[data-action]").on("click", function(){
        if ( $(this).data("action")=="clear" ){
            sign.clear();
        }
        else if ( $(this).data("action")=="save" ){
            if (sign.isEmpty()) {
                alert("서명을 작성해 주세요.");
            } else {
                $.ajax({
                    url : "signSave.jsp",
                    method : "post",
                    dataType : "json",
                    data : {
                        sign : sign.toDataURL()
                    },
                    success : function(r){
                        alert("저장 완료 : " + r.filename);
                        sign.clear();
                    },
                    error : function(res){
                        console.log(res);
                    }
                });
            }
        }
    });

       function resizeCanvas() {
           let canvas = $("#signature-pad canvas")[0];
           let ratio = Math.max(window.devicePixelRatio || 1, 1);
           canvas.width = canvas.offsetWidth * ratio;
           canvas.height = canvas.offsetHeight * ratio;
           canvas.getContext("2d").scale(ratio, ratio);
       }

       $(window).on("resize", function() {
           resizeCanvas();
       });

       resizeCanvas();
       
       
       /* 사인을 텍스트 입력으로 대체하는 기능 테스트 */
       $("#signText").on("input", function() {
       	const text = $(this).val();
       	const ctx = canvas.getContext("2d");
       	
       	 // 기존 서명을 지우지 않도록 텍스트만 지우기
           ctx.clearRect(0, canvas.height - 50, canvas.width, 50); 
           
           ctx.font = "20px Arial";
           ctx.fillStyle = "black";
           ctx.fillText(text, 10, canvas.height - 10); // 텍스트를 캔버스에 출력
       });
    </script>
</body>
</html>