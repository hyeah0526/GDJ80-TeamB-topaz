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
	<jsp:include page="/WEB-INF/view/groupware/inc/sideBarOut.jsp"></jsp:include>

	<!-- =============================== Main 메인 시작 부분 ================================ -->
	<main id="main" class="main">
	
	<!-- Title 시작 -->
	<div class="pagetitle">
      <h1>외주업체 고객 예약 상세 및 수정</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="/topaz/groupware/empMain">Home</a></li>
          <li class="breadcrumb-item"><a href="/topaz/groupware/bpo/bpoMainIn">Reservation</a></li>
          <li class="breadcrumb-item active">Reservation Detail & Edit</li>
        </ol>
      </nav>
	</div><!-- Title 종료 -->

	<!-- section 시작 -->
    <section class="section">
    	<div class="row justify-content-center"><div class="col-lg-6">
    	 	<div class="card"><div class="card-body">
              <h5 class="card-title">Reservation Detail & Edit</h5>
			  
			  <c:set var="r" value="${bpoRsvnOne}"></c:set>
              <!-- 예약 상세 및 수정폼  -->
              <form id="modRsvnForm" method="post" action="${pageContext.request.contextPath}/groupware/bpo/bpoRsvnModify">
                <input type="hidden" name="rsvnNo" value="${r.rsvnNo}">
              
                <div class="row mb-3">
				  <label for="inputEmail3" class="col-sm-2 col-form-label">시작 날짜</label>
				  <div class="col-sm-10">
				    <input type="datetime-local" class="form-control" value="${r.rsvnStart}" readonly style="background-color: #d9dce1;">
				  </div>
                </div>
                
                <div class="row mb-3">
				  <label for="inputEmail3" class="col-sm-2 col-form-label">종료 날짜</label>
				  <div class="col-sm-10">
				    <input type="datetime-local" class="form-control" value="${r.rsvnEnd}" readonly style="background-color: #d9dce1;">
				  </div>
                </div>
                
                <div class="row mb-3">
				  <label for="inputEmail3" class="col-sm-2 col-form-label">예약 상태</label>
				  <div class="col-sm-3">
				  	<div class="form-control text-center" id="rsvnStateShk">${r.rsvnState}</div>
				  </div>
				  <div class="col-sm-3 col-form-label text-center">상태 변경</div>
				  <div class="col-sm-4">
				  	<select class="form-select" id="rsvnState" name="rsvnState">
				  		<option value="" id="rsvnWait">변경 선택</option>
				  		<option value="1" id="rsvnWait">대기</option>
				  		<option value="3" id="rsvnCxl">취소</option>
				  	</select>
				  </div>
                </div>
                
                <div class="row mb-3">
				  <label for="inputEmail3" class="col-sm-2 col-form-label">예약 업체</label>
				  <div class="col-sm-10">
				    <input type="text" class="form-control" value="${r.outsourcingName}" readonly style="background-color: #d9dce1;">
				  </div>
                </div>
                
                <div class="row mb-3">
				  <label for="inputEmail3" class="col-sm-2 col-form-label">고객 이름</label>
				  <div class="col-sm-5">
				    <input type="text" class="form-control" id="" name="" value="${r.gstName}" readonly style="background-color: #d9dce1;">
				  </div>
				  <div class="col-sm-5">
					<input class="form-check-input" type="radio" name="gstGender" id="gstGenderM" onclick="return(false);" readonly> 남자
					&nbsp;&nbsp;&nbsp;
					<input class="form-check-input" type="radio" name="gstGender" id="gstGenderF" onclick="return(false);" readonly> 여자
				  </div>
                </div>
                
                <div class="row mb-3">
				  <label for="inputEmail3" class="col-sm-2 col-form-label">예약 제목</label>
				  <div class="col-sm-10">
				    <input type="text" class="form-control" id="rsvnTitle" name="rsvnTitle" value="${r.rsvnTitle}">
				  </div>
                </div>
                
                <div class="row mb-3">
				  <label for="inputEmail3" class="col-sm-2 col-form-label">예약 내용</label>
				  <div class="col-sm-10">
					<textarea rows="3" maxlength="100" class="col-sm-12 form-control" id="rsvnContent" name="rsvnContent" style="height: 150px">${r.rsvnContent}</textarea>
					(<span id="chatHelper">0</span>/100)
				  </div>
                </div>
                
                <div class="row mb-3">
				  <label for="inputEmail3" class="col-sm-2 col-form-label">작성자</label>
				  <div class="col-sm-10">
				    <input type="text" class="form-control" id="" name="" value="${r.regName}" readonly style="background-color: #d9dce1;">
				  </div>
                </div>
                
                <div class="row mb-3">
				  <label for="inputEmail3" class="col-sm-2 col-form-label">최종 수정자</label>
				  <div class="col-sm-10">
				    <input type="text" class="form-control" id="" name="" value="${r.modName}" readonly style="background-color: #d9dce1;">
				  </div>
                </div>
                
                
                <div class="text-center">
                  <c:if test="${r.rsvnState ne '취소'}">
                  	<button type="submit" id="bpoRsvnEditBtn" class="btn btn-primary">Edit</button>
                  </c:if>
	              <!-- 전페이지로 이동 버튼 -->
	              <button type="button" onclick="history.back()" class="btn btn-secondary">Close</button>
                </div>
              </form><!-- Vertical Form -->

            </div>
		</div></div></div>
    
    </section><!-- section 종료 -->

	</main><!-- End #main -->
	<!-- =============================== Main 메인 끝 부분 ================================ -->
	
	<!-- ======= footer 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/footer.jsp"></jsp:include>
	
</body>

</html>