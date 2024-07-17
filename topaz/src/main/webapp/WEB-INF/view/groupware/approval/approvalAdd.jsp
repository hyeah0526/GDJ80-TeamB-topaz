<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
	<!-- ======= header <Head> 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/headerHead.jsp"></jsp:include>
	<head>
		<!-- 서명패드JS -->
		<script src="/topaz/javascriptSignature/js/signature_pad.min.js" type="text/javascript"></script>
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
      <h1>기안서 작성</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="/topaz/groupware/empMain">Home</a></li>
          <li class="breadcrumb-item active">Approval Document</li>
        </ol>
      </nav>
	</div><!-- Title 종료 -->

	<!-- section 시작 -->
    <section class="section">
	    <div class="col-lg-12">
	    	<div class="card"><div class="card-body">
				<!-- 서명 등록 -->
				<h6 class="card-title">
					<button type="button" id="approvalSignAddBtn" class="btn btn-primary">서명등록</button>
				</h6>
				
	
				<!-- 탭 -->
				<ul class="nav nav-tabs d-flex" id="myTabjustified" role="tablist">
					<li class="nav-item flex-fill" role="presentation">
						<button class="nav-link w-100 active" id="home-tab" data-bs-toggle="tab" data-bs-target="#home-justified" type="button" role="tab" aria-controls="home" aria-selected="true">
							휴가 신청서
						</button>
					</li>
					<li class="nav-item flex-fill" role="presentation">
						<button class="nav-link w-100" id="profile-tab" data-bs-toggle="tab" data-bs-target="#profile-justified" type="button" role="tab" aria-controls="profile" aria-selected="false">
							기획 제안서
						</button>
					</li>
					<li class="nav-item flex-fill" role="presentation">
						<button class="nav-link w-100" id="contact-tab" data-bs-toggle="tab" data-bs-target="#contact-justified" type="button" role="tab" aria-controls="contact" aria-selected="false">
							경비 청구서
						</button>
					</li>
				</ul>
	              
	              
				<!-- Tab에 따른 내용 출력되는 부분 -->
				<div class="tab-content pt-2" id="myTabjustifiedContent">
					<!-- 휴가 신청서 -->
					<div class="tab-pane fade show active" id="home-justified" role="tabpanel" aria-labelledby="home-tab">
						<div class="pagetitle text-center"><h1>휴가 신청서</h1></div>
						
					</div>
					
					<!-- 기획 제안서 -->
					<div class="tab-pane fade" id="profile-justified" role="tabpanel" aria-labelledby="profile-tab">
						<div class="pagetitle text-center"><h1>기획 제안서</h1></div>
					</div>
					
					<!-- 경비 청구서 -->
					<div class="tab-pane fade" id="contact-justified" role="tabpanel" aria-labelledby="contact-tab">
						<div class="pagetitle text-center"><h1>경비 청구서</h1></div>
					</div>
				</div><!-- End Default Tabs -->
	
			</div></div>
	    </div>
	    
	    
	    <!-- 예약고객이름 가져오는 모달 -->
		<div class="modal fade" id="signAddModal" tabindex="-1">
			<div class="modal-dialog modal-dialog-centered"><div class="modal-content">
				<!-- 모달 제목 -->
				<div class="modal-header">
					<h5 class="modal-title">서명 등록</h5>
				</div>
				
				<div class="modal-body text-center" style="margin: auto;">
					<!-- 서명패드 표시 -->
					<div id="signature-pad" class="m-signature-pad">
					
	                    <div class="m-signature-pad--body" style="border: 1px solid black; width: 300px; height: 150px;">
	                        <canvas></canvas>
	                    </div>
	                    <div class="m-signature-pad--footer" style="margin-top: 30px">
	                        <button type="button" class="btn btn-primary clear" data-action="signClear">작성 초기화</button>
	                    </div>
					</div>
				</div>
					
				<!-- 모달 서명 등록 취소 -->
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary save" data-action="signSave">서명 저장</button>
				</div>
				
			</div></div>
		</div><!-- End addRsvn Modal-->
		
		
    </section><!-- section 종료 -->
	</main><!-- End #main -->
	<!-- =============================== Main 메인 끝 부분 ================================ -->
	
	<!-- ======= footer 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/footer.jsp"></jsp:include>
	
	<!-- 결재 신규 등록 JS -->
	<script src="<c:url value='/js/hyeahApprovalSign.js'/>"></script>	
</body>

</html>