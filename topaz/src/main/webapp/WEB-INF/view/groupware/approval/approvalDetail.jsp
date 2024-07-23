<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
	<!-- ======= header <Head> 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/headerHead.jsp"></jsp:include>
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
    <c:set var="a" value="${approvalOne}"></c:set>
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
	    	<div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="bi bi-exclamation-octagon me-1"></i>
                반려사유가 출력되는곳
			</div>
			
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
	    		</table>
	    	</div>
	    	
	    	<!-- 결재서명 정보 -->
	    	<div class="approvalSignShow">
		    	 <table class="">
			        <tr>
			        	<th rowspan="3">신<br>청</th>
			        	<td>${a.empName}<br>(${a.empDept})</td>
			        	<th rowspan="3">승<br>인</th>
			        	<td>${a.firstApprovalName}&nbsp;${a.firstApprovalGradeName}<br>(${a.firstApprovalDeptName})</td>
			        	<td>${a.finalApprovalName}&nbsp;${a.finalApprovalGradeName}<br>(${a.finalApprovalDeptName})</td>
			        </tr>
			        <tr>
			        	<td style="height:130px;">
			        		<img src="/topaz/assets/img/approvalSign/${a.signFile}" height="100px;" width="100px;">
			        	</td>
			        	<td style="height:130px;">
			        		<c:if test="${a.firstApprovalDate eq null && a.firstApproval eq loginUser}">
			        			<button type="button" class="btn btn-success mb-3">승인</button>
			        			<button type="button" class="btn btn-danger">반려</button>
			        		</c:if>
			        		<c:if test="${a.firstApprovalDate ne null}">
			        			<img src="/topaz/assets/img/approvalSign/${a.firstApprovalSign}" height="100px;" width="100px;">
			        		</c:if>
			        	</td>
			        	<td style="height:130px;">
			        		<c:if test="${a.finalApprovalDate eq null && a.finalApproval eq loginUser}">
			        			<button type="button" class="btn btn-success mb-3">승인</button>
			        			<button type="button" class="btn btn-danger">반려</button>
			        		</c:if>
			        		<c:if test="${a.finalApprovalDate ne null}">
			        			<img src="/topaz/assets/img/approvalSign/${a.finalApprovalSign}" height="100px;" width="100px;">
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
	    						<c:if test="${a.docFirstContent eq 'annual'}">
	    							연차
	    						</c:if>
	    						<c:if test="${a.docFirstContent eq 'monthly'}">
	    							월차
	    						</c:if>
	    						<c:if test="${a.docFirstContent eq 'halfMorning'}">
	    							오전 반차
	    						</c:if>
	    						<c:if test="${a.docFirstContent eq 'halfAfternoon'}">
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
	    						<textarea style="width: 90%; height: 500px; border: none; pointer-events: none;" readonly>${a.docThirdContent}</textarea>
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
	    						<img width="250px" src="/topaz/assets/img/approvalDoc/${a.fileName}">
	    					</td>
	    				</tr>
	    			</table>
    			</c:if>
    			
    			
    			
    		</div>
	    	
	    </div></div>
    </div></div>
    </section><!-- section 종료 -->

	</main><!-- End #main -->
	<!-- =============================== Main 메인 끝 부분 ================================ -->
	
	<!-- ======= footer 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/footer.jsp"></jsp:include>
</body>

</html>