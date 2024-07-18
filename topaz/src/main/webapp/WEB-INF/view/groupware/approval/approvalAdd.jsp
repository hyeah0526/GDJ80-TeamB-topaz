<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
	<!-- ======= header <Head> 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/headerHead.jsp"></jsp:include>
	<head>
		<!-- 서명패드JS -->
		<script src="/topaz/javascriptSignature/js/signature_pad.min.js" type="text/javascript"></script>
		<!-- hyeah CSS / JS -->
		<link rel="stylesheet" href="<c:url value='/css/hyeah.css' />">
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
	    		<!-- 서명 여부 조회(signFile/empGrade/empDept/empName/empNo) -->
	    		<c:set var="s" value="${empSign}"></c:set>
				<!-- 서명이 없을 경우 신규 등록 버튼 -->
				<c:if test="${s.signFile eq null}">
					<h6 class="card-title">
						<button type="button" id="approvalSignAddBtn" class="btn btn-primary">서명등록</button>
					</h6>
				</c:if>
				<!-- 서명이 있을 경우 수정 버튼 -->
				<c:if test="${s.signFile ne null}">
					<h6 class="card-title">
						<button type="button" id="approvalSignModBtn" class="btn btn-primary">서명수정</button>
						<input type="hidden" name="oldSignFile" id="oldSignFile" value="${s.signFile}">
					</h6>
				</c:if>
				
				<div class="row mb-4 approvalEmpInfo justify-content-center">
					<label for="profileImage" class="col-md-1 col-lg-1 col-form-label text-center">이름</label>
					<div class="col-md-2 col-lg-2">
						<input class="form-control" type="tel" value="${s.empName}(${s.empNo})" readonly>
					</div>
					
					<label for="profileImage" class="col-md-1 col-lg-1 col-form-label text-center">소속</label>
					<div class="col-md-2 col-lg-2">
						<input class="form-control" type="tel" value="${s.empDept}" readonly>
					</div>
					
					<label for="profileImage" class="col-md-1 col-lg-1 col-form-label text-center">직위</label>
					<div class="col-md-2 col-lg-2">
						<input class="form-control" type="tel" value="${s.empGrade}" readonly>
					</div>
				</div><br>
	
	
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
				<div class="tab-content pt-2 dayOffDiv" id="myTabjustifiedContent">
					<!-- 휴가 신청서 -->
					<div class="tab-pane fade show active" id="home-justified" role="tabpanel" aria-labelledby="home-tab">
						
						<div class="pagetitle text-center" style="margin: 20px;">
							<h1>휴가 신청서</h1>
						</div>
						
						<div class="row mb-4 justify-content-center">
							<label for="profileImage" class="col-lg-2 col-form-label">중 간 결 재 자</label>
							<div class="col-lg-2" id="">
								<input class="form-control" type="text" name="" id="" value="">
							</div>
							<div class="col-lg-2" id="">
								<button class="btn btn-primary">검색</button>
							</div>
						</div>
						
						<div class="row mb-4 justify-content-center">
							<label for="profileImage" class="col-lg-2 col-form-label">최 종 결 재 자</label>
							<div class="col-lg-2" id="">
								<input class="form-control" type="text" name="" id="" value="">
							</div>
							<div class="col-lg-2" id="">
								<button class="btn btn-primary">검색</button>
							</div>
						</div>
						
						<div class="row mb-4 justify-content-center">
							<label for="profileImage" class="col-lg-2 col-form-label">휴 가 종 류</label>
							<div class="col-lg-4">
								<select class="form-select" id="dayOffType">
									<option value="Y">연차</option>
									<option value="M">월차</option>
									<option value="AH">오전 반차</option>
									<option value="PH">오후 반차</option>
								</select>
							</div>
						</div>
						
						<div class="row mb-4 justify-content-center" id="dayOffYear">
							<label for="profileImage" class="col-lg-2 col-form-label">기 간</label>
							<div class="col-lg-2" id="">
								<input class="form-control" type="date" name="" id="" value="">
							</div>
							~
							<div class="col-lg-2" id="">
								<input class="form-control" type="date" name="" id="" value="">
							</div>
						</div>
						
						<div class="row mb-4 justify-content-center" id="dayOffMonth" style="display: none;">
							<label for="profileImage" class="col-lg-2 col-form-label">기 간</label>
							<div class="col-lg-2" id="">
								<input class="form-control" type="date" name="" id="" value="">
							</div>
							~
							<div class="col-lg-2" id="">
								<input class="form-control" type="date" name="" id="" value="">
							</div>
						</div>
						
						<div class="row mb-4 justify-content-center" id="dayOffHalfAm" style="display: none;">
							<label for="profileImage" class="col-lg-2 col-form-label">기 간</label>
							<div class="col-lg-4" id="">
								<input class="form-control" type="date" name="" id="" value="">
							</div>
						</div>
						
						<div class="row mb-4 justify-content-center" id="dayOffHalfPm" style="display: none;">
							<label for="profileImage" class="col-lg-2 col-form-label">기 간</label>
							<div class="col-lg-4" id="">
								<input class="form-control" type="date" name="" id="" value="">
							</div>
						</div>
						
						
						<div class="row mb-4 justify-content-center">
							<label for="profileImage" class="col-lg-2 col-form-label">비 상 연 락 망</label>
							<div class="col-lg-4" id="">
								<input class="form-control" type="text" name="" id="" value="">
							</div>
						</div>
						
						<div class="row mb-4 justify-content-center">
							<label for="profileImage" class="col-lg-2 col-form-label">사 유</label>
							<div class="col-lg-4" id="">
								<textarea class="form-control" style="height: 150px;" placeholder="신청사유를 작성해주세요"></textarea>
							</div>
						</div>
						
						
						<div class="row mb-4 justify-content-center">
							<div class="col-lg-4 text-center" id="">
								<button type="button" class="btn btn-primary" style="width: 150px;">신청</button>
							</div>
						</div>
						
					</div>
					
					
					
					<!-- 기획 제안서 -->
					<div class="tab-pane fade" id="profile-justified" role="tabpanel" aria-labelledby="profile-tab">
						<div class="pagetitle text-center" style="margin: 20px;"><h1>기획 제안서</h1></div>
						
						
						<div class="row mb-4 justify-content-center">
							<label for="profileImage" class="col-lg-2 col-form-label">중 간 결 재 자</label>
							<div class="col-lg-2" id="">
								<input class="form-control" type="text" name="" id="" value="">
							</div>
							<div class="col-lg-2" id="">
								<button class="btn btn-primary">검색</button>
							</div>
						</div>
						
						<div class="row mb-4 justify-content-center">
							<label for="profileImage" class="col-lg-2 col-form-label">최 종 결 재 자</label>
							<div class="col-lg-2" id="">
								<input class="form-control" type="text" name="" id="" value="">
							</div>
							<div class="col-lg-2" id="">
								<button class="btn btn-primary">검색</button>
							</div>
						</div>
						
						<div class="row mb-4 justify-content-center">
							<label for="profileImage" class="col-lg-2 col-form-label">기 획 종 류</label>
							<div class="col-lg-4">
								<label for="externalEvent">
									<input type="radio" class="form-check-input" id="externalEvent" name="docFirstContent"> 외부 행사
								</label>
								&nbsp;&nbsp;&nbsp;
								<label for="internalEvent">
									<input type="radio" class="form-check-input" id="internalEvent" name="docFirstContent"> 내부 행사
								</label>
								&nbsp;&nbsp;&nbsp;
								<label for="volunteerEvent">
									<input type="radio" class="form-check-input" id="volunteerEvent" name="docFirstContent"> 봉사
								</label>
							</div>
						</div>
						
						<div class="row mb-4 justify-content-center" id="">
							<label for="profileImage" class="col-lg-2 col-form-label">기 간</label>
							<div class="col-lg-2" id="">
								<input class="form-control" type="date" name="" id="" value="">
							</div>
							~
							<div class="col-lg-2" id="">
								<input class="form-control" type="date" name="" id="" value="">
							</div>
						</div>
						
						<div class="row mb-4 justify-content-center">
							<label for="profileImage" class="col-lg-2 col-form-label">첨 부 파 일</label>
							<div class="col-lg-4" id="">
								<input class="form-control" type="file" name="" id="" value="">
							</div>
						</div>
						
						<div class="row mb-4 justify-content-center">
							<label for="profileImage" class="col-lg-2 col-form-label">내 용</label>
							<div class="col-lg-4" id="">
								<textarea class="form-control" style="height: 150px;" placeholder="기획 내용을 상세히 작성해주세요"></textarea>
							</div>
						</div>
						
						
						<div class="row mb-4 justify-content-center">
							<div class="col-lg-4 text-center" id="">
								<button type="button" class="btn btn-primary" style="width: 150px;">신청</button>
							</div>
						</div>
						
					</div>
					
					
					
					<!-- 경비 청구서 -->
					<div class="tab-pane fade" id="contact-justified" role="tabpanel" aria-labelledby="contact-tab">
						<div class="pagetitle text-center" style="margin: 20px;"><h1>경비 청구서</h1></div>
						
						<div class="row mb-4 justify-content-center">
							<label for="profileImage" class="col-lg-2 col-form-label">중 간 결 재 자</label>
							<div class="col-lg-2" id="">
								<input class="form-control" type="text" name="" id="" value="">
							</div>
							<div class="col-lg-2" id="">
								<button class="btn btn-primary">검색</button>
							</div>
						</div>
						
						<div class="row mb-4 justify-content-center">
							<label for="profileImage" class="col-lg-2 col-form-label">최 종 결 재 자</label>
							<div class="col-lg-2" id="">
								<input class="form-control" type="text" name="" id="" value="">
							</div>
							<div class="col-lg-2" id="">
								<button class="btn btn-primary">검색</button>
							</div>
						</div>
						
						<div class="row mb-4 justify-content-center" id="">
							<label for="profileImage" class="col-lg-2 col-form-label">날 짜</label>
							<div class="col-lg-2" id="">
								<input class="form-control" type="date" name="" id="" value="">
							</div>
							<div class="col-lg-2" id=""></div>
						</div>
						
						<div class="row mb-4 justify-content-center">
							<label for="profileImage" class="col-lg-2 col-form-label">청 구 금 액</label>
							<div class="col-lg-2" id="">
								<input class="form-control" type="number" name="" id="" value="">
							</div>
							<div class="col-lg-2" id=""></div>
						</div>
						
						<div class="row mb-4 justify-content-center">
							<label for="profileImage" class="col-lg-2 col-form-label">영 수 증 첨 부</label>
							<div class="col-lg-4" id="">
								<input class="form-control" type="file" name="" id="" value="">
							</div>
						</div>
						
						<div class="row mb-4 justify-content-center">
							<label for="profileImage" class="col-lg-2 col-form-label">내 용</label>
							<div class="col-lg-4" id="">
								<textarea class="form-control" style="height: 150px;" placeholder="경비 사용 사유를 상세히 작성해주세요"></textarea>
							</div>
						</div>
						
						
						<div class="row mb-4 justify-content-center">
							<div class="col-lg-4 text-center" id="">
								<button type="button" class="btn btn-primary" style="width: 150px;">신청</button>
							</div>
						</div>
						
					</div>
				</div><!-- End Default Tabs -->
	
			</div></div>
	    </div>
	    
	    
	    <!-- 신규등록 서명패드 가져오는 모달 -->
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
		
		
		
		<!-- 수정 서명패드 가져오는 모달 -->
		<div class="modal fade" id="signModModal" tabindex="-1">
			<div class="modal-dialog modal-dialog-centered"><div class="modal-content">
				<!-- 모달 제목 -->
				<div class="modal-header">
					<h5 class="modal-title">서명 수정</h5>
				</div>
				
				<div class="modal-body text-center" style="margin: auto;">
					<h5 class="modal-title">기존 서명</h5>
					<div>
						<img src="/topaz/assets/img/approvalSign/${s.signFile}">
					</div>
					<hr>
					<!-- 서명패드 표시 -->
					<div id="signature-pad-Mod" class="m-signature-pad">
						<h5 class="modal-title">수정 서명</h5>
	                    <div class="m-signature-pad--body" style="border: 1px solid black; width: 300px; height: 150px;">
	                        <canvas></canvas>
	                    </div>
	                    <div class="m-signature-pad--footer" style="margin-top: 30px">
	                        <button type="button" class="btn btn-primary clear" data-action="signClear">작성 초기화</button>
	                    </div>
					</div>
				</div>
					
				<!-- 모달 서명 수정버튼 취소 -->
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary save" data-action="signModSave">서명 저장</button>
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