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
      <h1>휴가 신청서</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="/topaz/groupware/empMain">Home</a></li>
          <li class="breadcrumb-item">Approval Document</li>
          <li class="breadcrumb-item active">Day Off</li>
        </ol>
      </nav>
	</div><!-- Title 종료 -->

	<!-- section 시작 -->
    <section class="section">
    	<!-- 기안자 정보 -->
    	<div class="row justify-content-center"><div class="col-lg-10">
	    	<div class="card"><div class="card-body">
	    		<h6 class="card-title">기안자</h6>
	    		<c:set var="s" value="${empSign}"></c:set>
	    		<!-- 등록된 서명 표시 및 서명수정버튼 -->
				<c:if test="${s.signFile ne null}">
					<div class="">
						<button type="button" id="approvalSignModBtn" class="btn btn-primary">서명수정</button>
						<input type="hidden" name="oldSignFile" id="oldSignFile" value="${s.signFile}">
						<img src="/topaz/upload/approvalSign/${s.signFile}" width="200px" height="100px;">
					</div>
				</c:if>
				
				<!-- 서명 등록 버튼 활성화 -->
				<c:if test="${s.signFile eq null}">
					<div class="">
						<button type="button" id="approvalSignAddBtn" class="btn btn-primary mb-3">서명등록</button>
					</div>
				</c:if>

				<!-- 작성자 정보 -->
				<div class="row approvalEmpInfo" style="clear: left;">
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
				</div>
	    	</div></div>
	    </div></div>
    	
    	
    	<!-- 결재선 선택 -->
    	<div class="row justify-content-center"><div class="col-lg-10">
	    	<div class="card"><div class="card-body">
	    		<h6 class="card-title">결재라인</h6>
	    		<!-- 결재선 추가 -->
	    		<div class="row mb-3 align-items-center">
		    		<div class="col-md-2 form-group">
			    		<select class="form-select" id="departmentsSelect">
			    			<option value="">부서 선택</option>
			    			<c:forEach var="d" items="${departments}">
			    				<option value="${d.deptCode}">${d.deptName}</option>
			    			</c:forEach>
			    		</select>
		    		</div>
		    		
		    		<div class="col-md-2 form-group">
			    		<select class="form-select" id="nameSelect">
			    			<option>이름 선택</option>
			    		</select>
		    		</div>
		    		
		    		<div class="col-md-2 form-group">
		    			<button class="btn btn-primary">추가</button>
		    		</div>
	    		</div>
	    		
	    		<!-- 선택된 내용 출력 -->
	    		<div><strong>[1]</strong> 부서, 직위, 이름 <a href="#"><span class="text-danger small pt-1 fw-bold">X</span></a></div>
	    	</div></div>
	    </div></div>
	    
	    
	    <!-- 양식 표출 -->
	    <div class="row justify-content-center"><div class="col-lg-10">
	    	<div class="card"><div class="card-body">
	    		<h6 class="card-title">휴가 신청서</h6>
	    		
	    		<!-- 휴가종류 선택 -->
	    		<div class="row mb-4">
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
				
				<!-- 기간설정 -->
				<div class="row mb-4" id="dayOffDate">
							<!-- 휴가 종류에 따라 다른 내용보여주기 -->
				</div>
				
				<!-- 비상연락망 -->
				<div class="row mb-4">
					<label for="profileImage" class="col-lg-2 col-form-label">비 상 연 락 망</label>
					<div class="col-lg-4" id="">
						<input class="form-control" type="text" id="dayOFfSecond" name="docSecondContent">
					</div>
				</div>
				
				<!-- 제목 -->
				<div class="row mb-4">
					<label for="profileImage" class="col-lg-2 col-form-label">제 목</label>
					<div class="col-lg-4" id="">
						<input class="form-control" type="text" id="dayOffTitle" name="docTitle">
					</div>
				</div>
				
				<!-- 사유 -->
				<div class="row mb-4">
					<label for="profileImage" class="col-lg-2 col-form-label">사 유</label>
					<div class="col-lg-4" id="">
						<textarea class="form-control" id="dayOffThird" name="docThirdContent" style="height: 150px;" placeholder="신청사유를 작성해주세요"></textarea>
					</div>
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
    
    </section><!-- section 종료 -->

	</main><!-- End #main -->
	<!-- =============================== Main 메인 끝 부분 ================================ -->
	
	<!-- ======= footer 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/footer.jsp"></jsp:include>
	
	<script>
	$(document).ready(function(){
		/* ====================페이지 로드 초기 설정==================== */
		// 휴가신청서 디폴트 기간설정
		$('#dayOffDate').append('<label for="profileImage" class="col-lg-2 col-form-label">기 간</label>' +
								           '<div class="col-lg-2">' +
								           '    <input class="form-control" type="date" id="dayOffStartDate" name="startDate">' +
								           '</div>' +
								           '~' +
								           '<div class="col-lg-2">' +
								           '    <input class="form-control" type="date" id="dayOffEndDate" name="endDate">' +
								           '</div>');
		
		$('#myTabjustified a[data-bs-toggle="tab"]').on('shown.bs.tab', function (e) {
	                var target = $(e.target).attr("data-bs-target");
	                $(target + ' input').val(''); // 해당 탭 내의 모든 input 값을 초기화
		});
	});
	
	/* ====================휴가 신청서==================== */
	$('#dayOffType').change(function() {
		// 선택된 휴가 종류 값 가져오기
		var selectedOption = $(this).val();
	        
		// 필드 초기화
		$('#dayOffDate').empty();
		
		// 선택된 휴가 종류에 따라 해당하는 기간 입력 필드 보이기
		if (selectedOption === 'Y' || selectedOption === 'M') {
			// 연차 , 월차 선택시
			$('#dayOffDate').append('<label for="profileImage" class="col-lg-2 col-form-label">기 간</label>' +
							           '<div class="col-lg-2">' +
							           '    <input class="form-control" type="date" id="dayOffStartDate" name="startDate">' +
							           '</div>' +
							           '~' +
							           '<div class="col-lg-2">' +
							           '    <input class="form-control" type="date" id="dayOffEndDate" name="endDate">' +
							           '</div>')
							           
	    } else if (selectedOption === 'AH' || selectedOption === 'PH') {
			// 오전반차, 오후반차 선택시
	        $('#dayOffDate').append('<label for="profileImage" class="col-lg-2 col-form-label">기 간</label>' +
							           '<div class="col-lg-4">' +
							           '    <input class="form-control" type="date" id="dayOffStartDate" name="startDate">' +
							           '</div>')
	        
	    } 
	});
		
		
	/* ====================서명 등록==================== */
	// 서명패드 신규 버튼 클릭시 모달 창 띄우기
	$('#approvalSignAddBtn').click(function() {
		console.log('서명 등록 버튼 클릭');
		$("#signAddModal").modal("show");
	});
	
	// 모달창에 신규 등록 서명패드 출력
	let canvas = $("#signature-pad canvas")[0];
	let sign = new SignaturePad(canvas, {
	    minWidth: 1, // 초기값 5
	    maxWidth: 3, // 초기값 10
	    penColor: "rgb(0, 0, 0)" // 서명 색상
	});
	
	
	/* 서명 수정 */
	// 서명패드 수정 버튼 클릭시 모달 창 띄우기
	$('#approvalSignModBtn').click(function() {
		console.log('서명 수정 버튼 클릭');
		$("#signModModal").modal("show");
	});
	
	// 모달창에 수명 서명패드 출력
	let canvasMod = $("#signature-pad-Mod canvas")[0];
	let signMod = new SignaturePad(canvasMod, {
	    minWidth: 1, // 초기값 5
	    maxWidth: 3, // 초기값 10
	    penColor: "rgb(0, 0, 0)" // 서명 색상
	});
	
	
	// 신규 등록 및 수정 데이터 전송
	$("[data-action]").on("click", function(){
		
		// 초기화 버튼 클릭시 작성한 내용 지우기
	    if ( $(this).data("action")=="signClear" ){
			console.log('서명 초기화 버튼 클릭');
	        sign.clear();
	        signMod.clear();
	    }
	    
	    // 신규 서명 등록 저장 버튼 클릭시
	    if ( $(this).data("action")=="signSave" ){
			console.log('서명 저장버튼 클릭');
			
			// 서명이 없으면 alert 띄워주기 
	        if (sign.isEmpty()) {
	            alert("서명을 작성해 주세요.");
	            
	        } else {
				// 서명이 있을 경우 데이터 전송
				let signImg = sign.toDataURL();
				console.log('signImg --> ', signImg);
				
				// 서명등록 데이터 전송
	            $.ajax({
	                url : "/topaz/approval/signAdd",
	                method : "POST",
	                data : {signImg : signImg},
	                success : function(result){
						console.log('result--> ', result);
						
						alert('서명 등록에 성공하였습니다!');
						window.location.href="/topaz/groupware/approval/approvalAdd";
						sign.clear();
	                },
	                error : function(res){
	                    console.log(res);
	                    alert('서명 등록에 실패하였습니다. 다시 시도해주세요.');
						window.location.href="/topaz/groupware/approval/approvalAdd";
	                }
	            });
	            
	        }
	    }
	    
	    // 서명 수정 버튼 저장 클릭시 
		if ( $(this).data("action")=="signModSave" ){
			console.log('서명수정 저장버튼 클릭');
			
			// 서명이 없으면 alert 띄워주기 
	        if (signMod.isEmpty()) {
	            alert("서명을 작성해 주세요.");
	            
	        } else {
				// 서명이 있을 경우 데이터 전송
				let signModImg = signMod.toDataURL();
				console.log('signModImg --> ', signModImg);
				
				// 기존 파일 이름 가져오기
				let oldSignFile = $('#oldSignFile').val();
				console.log('oldSignFile --> ', oldSignFile);
				
				// 서명등록 데이터 전송
	            $.ajax({
	                url : "/topaz/approval/signMod",
	                method : "POST",
	                data : {
							signModImg : signModImg,
	                		oldSignFile : oldSignFile
	                		},
	                success : function(result){
						console.log('result--> ', result);
						
						alert('서명 수정에 성공하였습니다!');
						window.location.href="/topaz/groupware/approval/approvalAdd";
						signMod.clear();
	                },
	                error : function(res){
	                    console.log(res);
	                    alert('서명 수정에 실패하였습니다. 다시 시도해주세요.');
						window.location.href="/topaz/groupware/approval/approvalAdd";
	                }
	            });
	        }
		}
	    
	    
	});
	
	
	/* 결재선 선택 */
	$('#departmentsSelect').change(function() {
		console.log('departmentsSelect change event : ', $('#departmentsSelect').val());
		
		$.ajax({
			async : true, // 기본값은 true(비동기요청), false(동기요청)
			url : '/topaz/approval/approvalNameSelect',
			type : 'get',
			data : {department : $('#departmentsSelect').val()}, // 부서 선택
			success : function(result) {
				console.log(result, " <--result");
				
				$('#nameSelect').html('<option value="">이름 선택</option>');
				
				// 부서에 따른 이름출력
				$(result).each(function(index, item){ 
					$('#nameSelect').append('<option value="'+item.empNo+'">'+item.empName+' '+item.empGrade+'</option>');
				});
			}
		});
	});
		
	</script>
</body>

</html>