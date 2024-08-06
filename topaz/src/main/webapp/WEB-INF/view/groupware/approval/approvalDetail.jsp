<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
      <h1>결재 문서 상세보기</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="/topaz/groupware/empMain">Home</a></li>
          <li class="breadcrumb-item"><a href="/topaz/groupware/approval/approvalList">Approval Document List</a></li>
          <li class="breadcrumb-item active">Approval Document Details</li>
        </ol>
      </nav>
	</div><!-- Title 종료 -->

	<!-- section 시작 -->
    <section class="section">
    <!-- 상세보기 변수 -->
    <c:set var="a" value="${approvalOne}"></c:set>
    
    <!-- 상태변경에서 사용할 변수 -->
    <input type="hidden" value="${a.empNo}" id="empNo">					<!-- 신청자 아이디 -->
    <input type="hidden" value="${a.docFirstContent}" id="leaveType">	<!-- 휴가타입 가져오기 -->
    <input type="hidden" value="${a.dayOffDays}" id="leaveCount">		<!-- 휴가타입 일수 -->
    <input type="hidden" value="${a.startDate}" id="startTime">			<!-- 휴가 시작날짜 -->
    <input type="hidden" value="${a.endDate}" id="endTime">				<!-- 휴가 종료날짜 -->
    
    <input type="hidden" value="${a.approvalDocNo}" id="approvalDocNo">	<!-- 문서번호 -->
    <input type="hidden" value="${a.approvalType}" id="approvalType">	<!-- 문서타입 -->
    <input type="hidden" value="${a.firstApproval}" id="firstApproval">	<!-- 중간결재자 -->
    <input type="hidden" value="${a.firstApprovalSign}" id="firstApprovalSign">	<!-- 중간결재자 서명여부 -->
    <input type="hidden" value="${a.finalApproval}" id="finalApproval">	<!-- 최종결재자 -->
    <input type="hidden" value="${a.finalApprovalSign}" id="finalApprovalSign">	<!-- 최종결재자 서명여부 -->
    <input type="hidden" value="${a.approvalState}" id=approvalState>	<!-- 문서상태 -->
    
    <div class="row justify-content-center"><div class="col-9">
	    <div class="card"><div class="card-body">
	    	<div class="pagetitle text-center" style="margin: 20px;">
		    	<h1>
		    		<c:if test="${a.approvalType eq '휴가'}">휴가 신청서</c:if>
		    		<c:if test="${a.approvalType eq '기획'}">기획 제안서</c:if>
		    		<c:if test="${a.approvalType eq '경비'}">경비 청구서</c:if>
		    	</h1>
	    	</div>
	    	
	    	<!-- 상태가 반려일경우, 반려사유 출력 -->
	    	<c:if test="${a.approvalStateName eq '반려'}">
		    	<div class="alert alert-danger alert-dismissible fade show" role="alert">
	                <i class="bi bi-exclamation-octagon me-1"></i>
	                반려사유 :: ${a.approvalReason}
				</div>
			</c:if>
			
			<!-- 상태가 반려일경우, 반려사유 출력 -->
	    	<c:if test="${a.approvalStateName eq '취소'}">
		    	<div class="alert alert-danger alert-dismissible fade show" role="alert">
	                <i class="bi bi-exclamation-octagon me-1"></i>
	                기안자 요청으로 결재가 취소 된 문서입니다.
				</div>
			</c:if>
			
			<!-- 상태가 승인일경우, 결재완료된 문서임을 출력 -->
	    	<c:if test="${a.approvalStateName eq '승인'}">
		    	<div class="alert alert-success alert-dismissible fade show" role="alert">
					<i class="bi bi-check-circle me-1"></i>
					최종적으로 결재가 승인 된 문서입니다.
				</div>
			</c:if>
			
			<!-- 상태가 대기 혹은 진행일경우, 기안자에게만 진행중 안내문구 출력 -->
	    	<c:if test="${a.approvalStateName eq '대기' || a.approvalStateName eq '진행' && a.empNo eq loginUser}">
				<div class="alert alert-warning alert-dismissible fade show" role="alert">
					<i class="bi bi-info-circle me-1"></i>
					현재 승인 대기중인 결재문서입니다.
				</div>
			</c:if>
			
			<!-- 기안자 정보 -->
	    	<div class="approvalSignShowLeft">
	    		<table>
	    			<tr>
	    				<th>기안자</th>
	    				<td>${a.empName}</td>
	    			</tr>
	    			<tr>
	    				<th>소속</th>
	    				<td>${a.empDept}</td>
	    			</tr>
	    			<tr>
	    				<th>기안일</th>
	    				<td>${a.regTime}</td>
	    			</tr>
	    			<!-- 로그인 유저가 기안자이면서 상태가 대기일경우, 취소 가능 -->
	    			<c:if test="${a.empNo eq loginUser && a.approvalStateName eq '대기'}">
	    				<tr>
	    					<td colspan="2" class="text-center">
	    						<button type="button" id="approvalCxl" class="btn btn-danger">결재 취소</button>
	    					</td>
	    				</tr>
	    			</c:if>
	    		</table>
	    	</div>
	    	
	    	<!-- 결재서명 정보 -->
	    	<div class="approvalSignShow">
		    	 <table class="">
			        <tr>
			        	<th rowspan="3">신<br>청</th>
			        	<td>${a.empName}&nbsp;${a.empGrade}<br>(${a.empDept})</td>
			        	<th rowspan="3">승<br>인</th>
			        	<td>${a.firstApprovalName}&nbsp;${a.firstApprovalGradeName}<br>(${a.firstApprovalDeptName})</td>
			        	<td>${a.finalApprovalName}&nbsp;${a.finalApprovalGradeName}<br>(${a.finalApprovalDeptName})</td>
			        </tr>
			        <tr>
			        	<td style="height:130px;">
			        		<c:if test="${a.approvalStateName ne '취소'}">
			        		<img src="/topaz/upload/approvalSign/${a.signFile}" height="100px;" width="100px;">
			        		</c:if>
			        	</td>
			        	<td style="height:130px;">
			        		<c:if test="${a.firstApprovalDate eq null && a.firstApproval eq loginUser && a.approvalStateName eq '대기'}">
			        			<button type="button" class="btn btn-success mb-3" id="firstConfirm">승인</button>
			        			<button type="button" class="btn btn-danger" id="firstReject">반려</button>
			        		</c:if>
			        		<c:if test="${a.firstApprovalDate ne null && a.approvalStateName ne '반려' && a.approvalStateName ne '취소'}">
			        			<img src="/topaz/upload/approvalSign/${a.firstApprovalSign}" height="100px;" width="100px;">
			        		</c:if>
			        	</td>
			        	<td style="height:130px;">
			        		<c:if test="${a.finalApprovalDate eq null && a.finalApproval eq loginUser && a.approvalStateName eq '진행'}">
			        			<button type="button" class="btn btn-success mb-3" id="finalConfirm">승인</button>
			        			<button type="button" class="btn btn-danger" id="finalReject">반려</button>
			        		</c:if>
			        		<c:if test="${a.finalApprovalDate ne null && a.approvalStateName ne '반려' && a.approvalStateName ne '취소'}">
			        			<img src="/topaz/upload/approvalSign/${a.finalApprovalSign}" height="100px;" width="100px;">
			        		</c:if>
			        	</td>
			        </tr>
			        <tr>
			        	<td>${a.regTime}</td>
			        	<td>${a.firstApprovalDate}</td>
			        	<td>${a.finalApprovalDate}</td>
			        </tr>
	    		</table>
    		</div>
    		
    		
    		<!-- 기안 상세 내용 보여지는 곳 -->
    		<div style="clear: both; padding-top: 30px;" class="approvalDetailDiv">
    		
    			<!-- 휴가 신청서 -->
    			<c:if test="${a.approvalType eq '휴가'}">
	    			<table style="width: 100%;">
	    				<tr>
	    					<th>휴가종류</th>
	    					<td>
	    						<c:if test="${a.docFirstContent eq 'Y'}">
	    							연차
	    						</c:if>
	    						<c:if test="${a.docFirstContent eq 'M'}">
	    							월차
	    						</c:if>
	    						<c:if test="${a.docFirstContent eq 'AH'}">
	    							오전 반차
	    						</c:if>
	    						<c:if test="${a.docFirstContent eq 'PH'}">
	    							오후 반차
	    						</c:if>
	    					</td>
	    					<th>휴가기간</th>
	    					<td>
	    						${a.startDate} ~ ${a.endDate}&nbsp;&nbsp;
	    						<c:if test="${a.dayOffDays eq '0'}">
	    							(0.5일)
	    						</c:if>
	    						<c:if test="${a.dayOffDays ne '0'}">
	    							(${a.dayOffDays}일)
	    						</c:if>
	    					</td>
	    				</tr>
	    				<tr>
	    					<th>비상연락망</th>
	    					<td colspan="3">${a.docSecondContent}</td>
	    				</tr>
	    				<tr>
	    					<th>제목</th>
	    					<td colspan="3">${a.docTitle }</td>
	    				</tr>
	    				<tr>
	    					<td colspan="4" style="height: 500px; align-content: start;">
	    						${a.docThirdContent}
	    					</td>
	    				</tr>
	    			</table>
    			</c:if>
    			
    			
    			<!-- 기획 제안서 -->
    			<c:if test="${a.approvalType eq '기획'}">
	    			<table style="width: 100%;">
	    				<tr>
	    					<th>기획종류</th>
	    					<td>
	    						${a.docFirstContent}
	    					</td>
	    					<th>기획기간</th>
	    					<td>
	    						${a.startDate} ~ ${a.endDate}&nbsp;&nbsp;
	    						<c:if test="${a.dayOffDays eq '0'}">
	    							(1일)
	    						</c:if>
	    						<c:if test="${a.dayOffDays ne '0'}">
	    							(${a.dayOffDays}일)
	    						</c:if>
	    					</td>
	    				</tr>
	    				<tr>
	    					<th>첨부파일</th>
	    					<td colspan="3">
	    						<a href="/topaz/assets/img/approvalDoc/${a.fileName}" download="${a.originalFileName}">
	    							${a.docSecondContent}
	    						</a>
	    					</td>
	    				</tr>
	    				<tr>
	    					<th>제목</th>
	    					<td colspan="3">${a.docTitle }</td>
	    				</tr>
	    				<tr>
	    					<td colspan="4" style="height: 500px; align-content: start;">
	    						<textarea style="width: 100%; height: 500px; border: none; pointer-events: none;" readonly>${a.docThirdContent}</textarea>
	    					</td>
	    				</tr>
	    			</table>
    			</c:if>
    			
    			
    			<!-- 경비 청구서 -->
    			<c:if test="${a.approvalType eq '경비'}">
	    			<table style="width: 100%;">
	    				<tr>
	    					<th>청구금액</th>
	    					<td>
	    						<fmt:formatNumber value="${a.docFirstContent}" pattern="#,###" />원
	    					</td>
	    					<th>사용날짜</th>
	    					<td>${a.startDate}</td>
	    				</tr>
	    				<tr>
	    					<th>첨부파일</th>
	    					<td colspan="3">
	    						<a href="/topaz/assets/img/approvalDoc/${a.fileName}" download="${a.originalFileName}">
	    							${a.docSecondContent}
	    						</a>
	    					</td>
	    				</tr>
	    				<tr>
	    					<th>제목</th>
	    					<td colspan="3">${a.docTitle }</td>
	    				</tr>
	    				<tr>
	    					<td colspan="3" style="height: 500px; align-content: start;">
	    						<textarea style="width: 100%; height: 500px; border: none;pointer-events: none;" readonly>${a.docThirdContent}</textarea>
	    					</td>
	    					<td colspan="1" class="text-center">
	    						<img width="250px" src="/topaz/upload/approvalDoc/${a.fileName}">
	    					</td>
	    				</tr>
	    			</table>
    			</c:if>
    			
    		</div>
	    	
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
    
    </section><!-- section 종료 -->

	</main><!-- End #main -->
	<!-- =============================== Main 메인 끝 부분 ================================ -->
	
	<!-- ======= footer 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/footer.jsp"></jsp:include>
	
	<!-- 결재 상세보기 JS -->
	<script src="<c:url value='/js/hyeahApprovalDetails.js'/>"></script>	
	
</body>

</html>