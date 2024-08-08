<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
	<!-- ======= header <Head> 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/headerHead.jsp"></jsp:include>
	
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
    	<!-- 결재선 선택 -->
    	<div class="row justify-content-center"><div class="col-lg-10">
	    	<div class="card"><div class="card-body">
	    		<h6 class="card-title">결재라인</h6>
	    		<!-- 결재선 추가 -->
	    		<div class="row mb-3 align-items-center">
		    		<div class="col-md-2 form-group">
			    		<select class="form-select">
			    			<option>부서</option>
			    		</select>
		    		</div>
		    		
		    		<div class="col-md-2 form-group">
			    		<select class="form-select">
			    			<option>이름</option>
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
		
		
	});
	</script>
</body>

</html>