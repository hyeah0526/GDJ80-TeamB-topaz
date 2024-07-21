<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
	<!-- ======= header <Head> 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/headerHead.jsp"></jsp:include>
	<!-- 다음 주소 API -->
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<head>
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
      <h1>신규 업체 등록</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="/topaz/groupware/empMain">Home</a></li>
          <li class="breadcrumb-item active">Outsourcing Registration</li>
        </ol>
      </nav>
	</div><!-- Title 종료 -->

	<!-- section 시작 -->
    <section class="section">
		<div class="row justify-content-center"><div class="col-lg-8">
			<div class="card"><div class="card-body">
				<h5 class="card-title">Outsourcing Registration Form</h5>
	
				<!-- 외주업체 등록폼 -->
				<form method="post" action="${pageContext.request.contextPath}/groupware/bpo/bpoAddPost" enctype="multipart/form-data">
					<div class="row mb-3">
						<label for="inputText" class="col-sm-4 col-form-label">업체이름</label>
						<div class="col-sm-8">
							<input type="text" name="outsourcingName" class="form-control" value="${empty param.outsourcingName ? '' : param.outsourcingName}">
							<div class="validMsg">${outsourcingNameMsg}</div>
						</div>
					</div>
					
					<div class="row mb-3">
						<label for="inputText" class="col-sm-4 col-form-label">업체 소개</label>
						<div class="col-sm-8">
							<textarea name="outsourcingAbout" class="form-control">${empty param.outsourcingAbout ? '' : param.outsourcingAbout}</textarea>
							<div class="validMsg">${outsourcingAboutMsg}</div>
						</div>
					</div>
					
					<div class="row mb-3">
						<label for="inputText" class="col-sm-4 col-form-label">업체종류</label>
						<div class="col-sm-8">
							<label for="typeAll">
								<input class="form-check-input" type="radio" name="outsourcingType" value="1" id="typeAll" ${param.outsourcingType == '1' ? 'checked' : ''}> 상시
							</label>
							&nbsp;&nbsp;&nbsp;
							<label for="typeRsvn">
								<input class="form-check-input" type="radio" name="outsourcingType" value="2" id="typeRsvn" ${param.outsourcingType == '2' ? 'checked' : ''}> 예약
							</label>
							<div class="validMsg">${outsourcingTypeMsg}</div>
						</div>
	                </div>
	                
					<div class="row mb-3">
						<label for="inputNumber" class="col-sm-4 col-form-label">업체 사진</label>
						<div class="col-sm-8">
	                    	<input class="form-control" type="file" id="formFile" name="uploadFile" accept="image/png, image/jpeg">
	                    	<div class="validMsg">${uploadFileMsg}</div>
						</div>
					</div>
	                
					<div class="row mb-3">
						<label for="inputEmail" class="col-sm-4 col-form-label">아이디</label>
						<div class="col-sm-4">
	                    	<input type="text" id="outsourcingNo" name="outsourcingNo" class="form-control" value="${empty param.outsourcingNo ? '' : param.outsourcingNo}">
							<div class="validMsg">${outsourcingNoMsg}</div>
						</div>
						<div class="col-sm-4">
							<button type="button" id="chkId" class="btn btn-primary">중복검사</button>
						</div>
					</div>
	                
	                <div class="row mb-3">
						<label for="inputPassword" class="col-sm-4 col-form-label">비밀번호</label>
						<div class="col-sm-8">
							<input type="password" name="outsourcingPw" class="form-control" value="${empty param.outsourcingPw ? '' : param.outsourcingPw}">
							<div class="validMsg">${outsourcingPwMsg}</div>
						</div>
	                </div>
	                
	                <div class="row mb-3">
						<label for="inputNumber" class="col-sm-4 col-form-label">외주업체 담당자</label>
						<div class="col-sm-8">
	                    	<input type="text" name="inchargeName" class="form-control" value="${empty param.inchargeName ? '' : param.inchargeName}">
	                    	<div class="validMsg">${inchargeNameMsg}</div>
						</div>
	                </div>
	                
	                <div class="row mb-3">
						<label for="inputDate" class="col-sm-4 col-form-label">사내 담당자</label>
						<div class="col-sm-4">
	                    	<input type="text" id="empNameInput" class="form-control" name="empNameInput" value="${empty param.empNameInput ? '' : param.empNameInput}">
	                    	<input type="hidden" id="empNoInput" name="empNo" class="form-control" value="${empty param.empNo ? '' : param.empNo}">
	                    	<div class="validMsg">${empNoMsg}</div>
						</div>
						<div class="col-sm-4">
	                    	<button type="button" id="chkEmp" class="btn btn-primary">직원검색</button>
						</div>
	                </div>
	                
	                <div class="row mb-3">
						<label for="inputDate" class="col-sm-4 col-form-label">계약시작</label>
						<div class="col-sm-8">
	                    	<input type="date" id="contractStart" name="contractStart" class="form-control" value="${empty param.contractStart ? '' : param.contractStart}">
	                    	<div class="validMsg">${contractStartMsg}</div>
						</div>
	                </div>
	                
	                <div class="row mb-3">
						<label for="inputDate" class="col-sm-4 col-form-label">계약종료</label>
						<div class="col-sm-8">
	                    	<input type="date" id="contractEnd" name="contractEnd" class="form-control" value="${empty param.contractEnd ? '' : param.contractEnd}">
	                    	<div class="validMsg">${contractEndMsg}</div>
						</div>
	                </div>
	                
	                <div class="row mb-3">
						<label for="inputNumber" class="col-sm-4 col-form-label">주소</label>
						<div class="col-sm-5">
	                    	<input name="postNo" class="form-control" data-step="11" placeholder="우편번호" maxlength="5" value="${empty param.postNo ? '' : param.postNo}" readonly>
							<input name="firstAddress" id="firstAddress" class="step form-control" data-step="12" placeholder="주소" value="${empty param.address ? '' : param.address}">
							<div class="validMsg">${addressMsg}</div>
						</div>
						<div class="col-sm-3">
							<button class="step btn btn-primary" type="button" data-step="10" onclick="openPostcode('postNo','firstAddress')">우편번호찾기</button><br>
							
							<input type="hidden" name="address" id="address" value="${empty param.address ? '' : param.address}">
						</div>
	                </div>
	                
	                <div class="row mb-3">
						<label for="inputDate" class="col-sm-4 col-form-label">전화번호</label>
						<div class="col-sm-8">
	                    	<input type="text" name="contactNo" class="form-control" value="${empty param.contactNo ? '' : param.contactNo}">
	                    	<div class="validMsg">${contactNoMsg}</div>
						</div>
	                </div>
	
	
	                <div class="text-center">
						<!-- 등록하기 버튼 -->
						<button type="submit" id="addBpoBtn" class="btn btn-primary">Registration</button>
						<!-- 전페이지로 이동 버튼 -->
						<button type="button" onclick="history.back()" class="btn btn-secondary">Close</button>
	                </div>
	              </form>
			</div></div>
		</div></div>
		
		
		
		<!-- 직원검색 모달 -->
		<div class="modal fade" id="empModal" tabindex="-1">
			<div class="modal-dialog modal-dialog-centered"><div class="modal-content">
				<!-- 모달 제목 -->
				<div class="modal-header">
					<h5 class="modal-title">담당 직원 선택</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				
					<div class="modal-body">
						<div class="row mb-5">
							<label for="inputEmail" class="col-sm-4 col-form-label"></label>
							<div class="col-sm-8 scheduleModalDiv" id="empNameSelectDiv">
								<!-- 직원 출력되는 곳 -->
							</div>
						</div>
					</div>
					
					<!-- 모달 일정 취소/등록버튼 -->
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
						<button id="empChkSaveBtn" type="submit" class="btn btn-primary">Save</button>
					</div>
			</div></div>
		</div><!-- End 직원검색 Modal-->
		
		
		<!-- 아이디 중복검사 모달 -->
		
		
    </section><!-- section 종료 -->

	</main><!-- End #main -->
	<!-- =============================== Main 메인 끝 부분 ================================ -->
	
	<!-- ======= footer 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/footer.jsp"></jsp:include>
	
	<!-- 카카오 우편번호API -->
	<script src="<c:url value='/js/post.js'/>"></script>
	
	<!-- 외주업체등록 JS -->
	<script src="<c:url value='/js/hyeahBpoAdd.js'/>"></script>	
</body>

</html>