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
	    <div class="row justify-content-center"><div class="col-lg-10">
	    	<div class="card"><div class="card-body">
	    		<!-- 서명 여부 조회(signFile/empGrade/empDeptName/empName/empNo) -->
	    		<c:set var="s" value="${empSign}"></c:set>
	    		<input type="hidden" name="empGrade" id="empGrade" value="${s.empGrade}">
	    		<input type="hidden" id="signFile" value="${s.signFile}">
				
				<h6 class="card-title"></h6>
				
				<!-- 총 기안 개수 -->
				<div class="text-center mb-4">
				    <div class="text-center alert alert-secondary" style="width:150px; display: inline-block; margin-right: 20px;">
				        <i class="bi bi-collection me-1"></i>
				        총 기안 <strong class="fs-4">${s.cntTotal}</strong>건
				    </div>
				
				    <div class="text-center alert alert-secondary" style="width:150px; display: inline-block; margin-right: 20px;">
				        <i class="bi bi-collection me-1"></i>
				        휴가 <strong class="fs-4">${s.cntDayoff}</strong>건
				    </div>
				
				    <div class="text-center alert alert-secondary" style="width:150px; display: inline-block; margin-right: 20px;">
				        <i class="bi bi-collection me-1"></i>
				        기획 <strong class="fs-4">${s.cntEvent}</strong>건
				    </div>
				
				    <div class="text-center alert alert-secondary" style="width:150px; display: inline-block;">
				        <i class="bi bi-collection me-1"></i>
				        경비 <strong class="fs-4">${s.cntExpense}</strong>건
				    </div>
				</div>
				
				<!-- 등록된 서명 표시 및 서명수정버튼 -->
				<c:if test="${s.signFile ne null}">
					<div class="text-center">
						<button type="button" id="approvalSignModBtn" class="btn btn-primary">서명수정</button>
						<input type="hidden" name="oldSignFile" id="oldSignFile" value="${s.signFile}">
						<img src="/topaz/upload/approvalSign/${s.signFile}" width="200px" height="100px;">
					</div>
				</c:if>
				
				<!-- 서명 등록 버튼 활성화 -->
				<c:if test="${s.signFile eq null}">
					<div class="text-center">
						<button type="button" id="approvalSignAddBtn" class="btn btn-primary mb-3">서명등록</button>
					</div>
				</c:if>

				<!-- 작성자 정보 -->
				<div class="row mb-5 approvalEmpInfo justify-content-center" style="clear: left;">
					<label for="profileImage" class="col-md-1 col-lg-1 col-form-label text-center">이름</label>
					<div class="col-md-2 col-lg-2">
						<input class="form-control" type="tel" value="${s.empName}(${s.empNo})" readonly>
					</div>
					
					<label for="profileImage" class="col-md-1 col-lg-1 col-form-label text-center">소속</label>
					<div class="col-md-2 col-lg-2">
						<input class="form-control" type="tel" value="${s.empDeptName}" readonly>
					</div>
					
					<label for="profileImage" class="col-md-1 col-lg-1 col-form-label text-center">직위</label>
					<div class="col-md-2 col-lg-2">
						<input class="form-control" type="tel" value="${s.empGradeName}" readonly>
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
						
						<form method="post" action="${pageContext.request.contextPath}/groupware/approval/approvalAdd" id="dayOffForm">
						<input type="hidden" name="approvalType" value="1">
						<div class="row mb-4 justify-content-center">
							<label for="profileImage" class="col-lg-2 col-form-label">중 간 결 재 자</label>
							<div class="col-lg-2" id="">
								<select class="form-select" id="dayOffFirstApproval">
									<c:forEach var="d" items="${deptList}">
										<option value="${d.departmentCode}">${d.departmentName}</option>
									</c:forEach>
								</select>
								<div id="firstApprovalSetDayOffDiv">
									<!-- 선택된 중간결재자 정보 나오는 창 -->
									<input class="form-control" type="text" name="firstApprovalName" id="dayOffFirstApprovalName" placeholder="검색시 자동입력" readonly>
									<input class="form-control" type="text" name="firstApproval" id="dayOffFirstApprovalId" readonly>
								</div>
							</div>
							<div class="col-lg-2" id="">
								<button type="button" class="btn btn-primary" id="dayOffFirstApprovalBtn">검색</button>
							</div>
						</div>
						
						<div class="row mb-4 justify-content-center">
							<label for="profileImage" class="col-lg-2 col-form-label">최 종 결 재 자</label>
							<div class="col-lg-2" id="">
								<select class="form-select" id="dayOffFinalApproval">
									<c:forEach var="d" items="${deptList}">
										<option value="${d.departmentCode}">${d.departmentName}</option>
									</c:forEach>
								</select>
								<div id="finalApprovalSetDayOffDiv">
									<!-- 선택된 최종결재자 정보 나오는 창 -->
									<input class="form-control" type="text" name="finalApprovalName" id="dayOffFinalApprovalName" placeholder="검색시 자동입력" readonly>
									<input class="form-control" type="text" name="finalApproval" id="dayOffFinalApprovalId" readonly>
								</div>
							</div>
							<div class="col-lg-2" id="">
								<button type="button" class="btn btn-primary" id="dayoffFinalApprovalBtn">검색</button>
							</div>
						</div>
						
						<div class="row mb-4 justify-content-center">
							<label for="profileImage" class="col-lg-2 col-form-label">휴 가 종 류</label>
							<div class="col-lg-4">
								<select class="form-select" id="dayOffType" name="docFirstContent">
									<option value="Y">연차</option>
									<option value="M">월차</option>
									<option value="AH">오전 반차</option>
									<option value="PH">오후 반차</option>
								</select>
							</div>
						</div>
						
						<div class="row mb-4 justify-content-center" id="dayOffDate">
							<!-- 휴가 종류에 따라 다른 내용보여주기 -->
						</div>
						
						<div class="row mb-4 justify-content-center">
							<label for="profileImage" class="col-lg-2 col-form-label">비 상 연 락 망</label>
							<div class="col-lg-4" id="">
								<input class="form-control" type="text" id="dayOFfSecond" name="docSecondContent">
							</div>
						</div>
						
						<div class="row mb-4 justify-content-center">
							<label for="profileImage" class="col-lg-2 col-form-label">제 목</label>
							<div class="col-lg-4" id="">
								<input class="form-control" type="text" id="dayOffTitle" name="docTitle">
							</div>
						</div>
						
						<div class="row mb-4 justify-content-center">
							<label for="profileImage" class="col-lg-2 col-form-label">사 유</label>
							<div class="col-lg-4" id="">
								<textarea class="form-control" id="dayOffThird" name="docThirdContent" style="height: 150px;" placeholder="신청사유를 작성해주세요"></textarea>
							</div>
						</div>
						
						
						<div class="row mb-4 justify-content-center">
							<div class="col-lg-4 text-center" id="">
								<button type="button" class="btn btn-primary" style="width: 150px;" id="dayOffSubmitBtn">신청</button>
							</div>
						</div>
					</form>
					</div>
					
					
					
					<!-- 기획 제안서 -->
					<div class="tab-pane fade" id="profile-justified" role="tabpanel" aria-labelledby="profile-tab">
						<div class="pagetitle text-center" style="margin: 20px;"><h1>기획 제안서</h1></div>
						
						<form method="post" action="${pageContext.request.contextPath}/groupware/approval/approvalAdd" id="eventForm" enctype="multipart/form-data">
						<input type="hidden" name="approvalType" value="2">
						<div class="row mb-4 justify-content-center">
							<label for="profileImage" class="col-lg-2 col-form-label">중 간 결 재 자</label>
							<div class="col-lg-2" id="">
								<select class="form-select" id="eventFirstApproval">
									<c:forEach var="d" items="${deptList}">
										<option value="${d.departmentCode}">${d.departmentName}</option>
									</c:forEach>
								</select>
								<div id="firstApprovalSetEventDiv">
									<!-- 선택된 중간결재자 정보 나오는 창 -->
									<input class="form-control" type="text" name="firstApprovalName" id="eventFirstApprovalName" placeholder="검색시 자동입력" readonly>
									<input class="form-control" type="text" name="firstApproval" id="eventFirstApprovalId" readonly>
								</div>
							</div>
							<div class="col-lg-2" id="">
								<button type="button" class="btn btn-primary" id="eventFirstApprovalBtn">검색</button>
							</div>
						</div>
						
						<div class="row mb-4 justify-content-center">
							<label for="profileImage" class="col-lg-2 col-form-label">최 종 결 재 자</label>
							<div class="col-lg-2" id="">
								<select class="form-select" id="eventFinalApproval">
									<c:forEach var="d" items="${deptList}">
										<option value="${d.departmentCode}">${d.departmentName}</option>
									</c:forEach>
								</select>
								<div id="finalApprovalSetEventDiv">
									<!-- 선택된 최종결재자 정보 나오는 창 -->
									<input class="form-control" type="text" name="finalApprovalName" id="eventFinalApprovalName" placeholder="검색시 자동입력" readonly>
									<input class="form-control" type="text" name="finalApproval" id="eventFinalApprovalId" readonly>
								</div>
							</div>
							<div class="col-lg-2" id="">
								<button type="button" class="btn btn-primary" id="eventFinalApprovalBtn">검색</button>
							</div>
						</div>
						
						<div class="row mb-4 justify-content-center">
							<label for="profileImage" class="col-lg-2 col-form-label">기 획 종 류</label>
							<div class="col-lg-4">
								<label for="externalEvent">
									<input type="radio" class="form-check-input" id="externalEvent" name="docFirstContent" value="외부 행사" checked> 외부 행사
								</label>
								&nbsp;&nbsp;&nbsp;
								<label for="internalEvent">
									<input type="radio" class="form-check-input" id="internalEvent" name="docFirstContent" value="내부 행사"> 내부 행사
								</label>
								&nbsp;&nbsp;&nbsp;
								<label for="volunteerEvent">
									<input type="radio" class="form-check-input" id="volunteerEvent" name="docFirstContent" value="봉사"> 봉사
								</label>
							</div>
						</div>
						
						<div class="row mb-4 justify-content-center" id="">
							<label for="profileImage" class="col-lg-2 col-form-label">기 간</label>
							<div class="col-lg-2" id="">
								<input class="form-control" type="date" id="eventStartDate" name="startDate">
							</div>
							~
							<div class="col-lg-2" id="">
								<input class="form-control" type="date" id="eventEndDate" name="endDate">
							</div>
						</div>
						
						<div class="row mb-4 justify-content-center">
							<label for="profileImage" class="col-lg-2 col-form-label">첨 부 파 일</label>
							<div class="col-lg-4" id="">
								<input class="form-control" type="file" id="eventUploadFile" name="uploadFile">
							</div>
						</div>
						
						<div class="row mb-4 justify-content-center">
							<label for="profileImage" class="col-lg-2 col-form-label">제 목</label>
							<div class="col-lg-4" id="">
								<input class="form-control" type="text" id="eventTitle" name="docTitle">
							</div>
						</div>
						
						<div class="row mb-4 justify-content-center">
							<label for="profileImage" class="col-lg-2 col-form-label">내 용</label>
						</div>
						
						<div class="row mb-4 justify-content-center">
							<div class="col-lg-10">
								<textarea class="form-control" id="eventThird" name="docThirdContent" style="height: 500px;" placeholder="기획 내용을 상세히 작성해주세요"></textarea>
							</div>
						</div>
						
						
						<div class="row mb-4 justify-content-center">
							<div class="col-lg-4 text-center" id="">
								<button type="button" id="eventSubmitBtn" class="btn btn-primary" style="width: 150px;">신청</button>
							</div>
						</div>
						
					</form>
					</div>
					
					
					<!-- 경비 청구서 -->
					<div class="tab-pane fade" id="contact-justified" role="tabpanel" aria-labelledby="contact-tab">
						<div class="pagetitle text-center" style="margin: 20px;">
							<h1>경비 청구서</h1>
						</div>
						
						<form method="post" action="${pageContext.request.contextPath}/groupware/approval/approvalAdd" id="expenseForm" enctype="multipart/form-data">
						<input type="hidden" name="approvalType" value="3">
						<div class="row mb-4 justify-content-center">
							<label for="profileImage" class="col-lg-2 col-form-label">중 간 결 재 자</label>
							<div class="col-lg-2" id="">
								<select class="form-select" id="expenseFirstApproval">
									<c:forEach var="d" items="${deptList}">
										<option value="${d.departmentCode}">${d.departmentName}</option>
									</c:forEach>
								</select>
								<div id="firstApprovalSetExpenseDiv">
									<!-- 선택된 중간결재자 정보 나오는 창 -->
									<input class="form-control" type="text" name="firstApprovalName" id="expenseFirstApprovalName" placeholder="검색시 자동입력" readonly>
									<input class="form-control" type="text" name="firstApproval" id="expenseFirstApprovalId" readonly>
								</div>
							</div>
							<div class="col-lg-2" id="">
								<button type="button" class="btn btn-primary" id="expenseFirstApprovalBtn">검색</button>
							</div>
						</div>
						
						<div class="row mb-4 justify-content-center">
							<label for="profileImage" class="col-lg-2 col-form-label">최 종 결 재 자</label>
							<div class="col-lg-2" id="">
							<select class="form-select" id="expenseFinalApproval">
									<c:forEach var="d" items="${deptList}">
										<option value="${d.departmentCode}">${d.departmentName}</option>
									</c:forEach>
								</select>
								<div id="finalApprovalSetExpenseDiv">
									<!-- 선택된 중간결재자 정보 나오는 창 -->
									<input class="form-control" type="text" name="finalApprovalName" id="expenseFinalApprovalName" placeholder="검색시 자동입력" readonly>
									<input class="form-control" type="text" name="finalApproval" id="expenseFinalApprovalId" readonly>
								</div>
							</div>
							<div class="col-lg-2">
								<button type="button" class="btn btn-primary" id="expenseFinalApprovalBtn">검색</button>
							</div>
						</div>
						
						<div class="row mb-4 justify-content-center" id="">
							<label for="profileImage" class="col-lg-2 col-form-label">날 짜</label>
							<div class="col-lg-2" id="">
								<input class="form-control" type="date" id="expenseStartDate" name="startDate">
							</div>
							<div class="col-lg-2"></div>
						</div>
						
						<div class="row mb-4 justify-content-center">
							<label for="profileImage" class="col-lg-2 col-form-label">청 구 금 액</label>
							<div class="col-lg-2">
								<input class="form-control" type="number" id="expenseFirst" name="docFirstContent">
							</div>
							<div class="col-lg-2"></div>
						</div>
						
						<div class="row mb-4 justify-content-center">
							<label for="profileImage" class="col-lg-2 col-form-label">영 수 증 첨 부</label>
							<div class="col-lg-4">
								<input class="form-control" type="file" id="expenseUploadFile" name="uploadFile" accept="image/png, image/jpeg, .pdf">
							</div>
						</div>
						
						<div class="row mb-4 justify-content-center">
							<label for="profileImage" class="col-lg-2 col-form-label">제 목</label>
							<div class="col-lg-4" id="">
								<input class="form-control" type="text" id="expenseTitle" name="docTitle">
							</div>
						</div>
						
						<div class="row mb-4 justify-content-center">
							<label for="profileImage" class="col-lg-2 col-form-label">내 용</label>
							<div class="col-lg-4">
								<textarea class="form-control" id="expenseThird" name="docThirdContent" style="height: 150px;" placeholder="경비 사용 사유를 상세히 작성해주세요"></textarea>
							</div>
						</div>
						
						
						<div class="row mb-4 justify-content-center">
							<div class="col-lg-4 text-center">
								<button type="button" id="expenseSubmitBtn" class="btn btn-primary" style="width: 150px;">신청</button>
							</div>
						</div>
						
				</form>
					</div>
				</div><!-- End Default Tabs -->
	
			</div></div>
	    </div></div>
	    
	    
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
						<img src="/topaz/upload/approvalSign/${s.signFile}">
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
		
		
		<!-- 결재자 확인하는 모달 -->
		<div class="modal fade" id="approvalSelectModal" tabindex="-1">
			<div class="modal-dialog modal-dialog-centered"><div class="modal-content">
				<!-- 모달 제목 -->
				<div class="modal-header">
					<h5 class="modal-title">결재자 선택</h5>
				</div>
				
				<div class="modal-body" id="firstApprovalModal" style="margin: auto;">
					<!-- 리스트 적용 -->
				</div>
					
				<!-- 모달 서명 수정버튼 취소 -->
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary save" id="saveFirstApprovalBtn">선택</button>
				</div>
				
			</div></div>
		</div><!-- End addRsvn Modal-->
		
		
    </section><!-- section 종료 -->
	</main><!-- End #main -->
	<!-- =============================== Main 메인 끝 부분 ================================ -->
	
	<!-- ======= footer 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/footer.jsp"></jsp:include>
	
	<!-- 결재 신규 등록 JS -->
	<script src="<c:url value='/js/hyeahApprovalAdd.js'/>"></script>	
</body>

</html>