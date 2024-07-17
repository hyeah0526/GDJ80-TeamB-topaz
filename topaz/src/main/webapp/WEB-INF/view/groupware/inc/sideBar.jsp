<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<aside id="sidebar" class="sidebar">

	<ul class="sidebar-nav" id="sidebar-nav">
		<!-- ======= 카테고리 - 메인 ======= -->
		<li class="nav-item">
			<a class="nav-link sideMain" id="sideMain" href="/topaz/groupware/empMain">
	          <i class="bi bi-grid"></i>
	          <span>메인</span>
	        </a>
		</li><!-- End Dashboard Nav -->
		
		
		<!-- ======= 카테고리 - 공지사항 ======= -->
		<li class="nav-item" id="">
	        <a class="nav-link sideNotice collapsed" id="sideNotice" href="/topaz/groupware/notice/noticeList">
	          <i class="bi bi-megaphone"></i>
	          <span>공지사항</span>
	        </a>
		</li><!-- End Profile Page Nav -->
		
		
		<!-- ======= 카테고리 - 사내일정 ======= -->
		<li class="nav-item">
	        <a class="nav-link sideSchedule collapsed" id="sideSchedule" href="/topaz/groupware/schedule/scheduleList">
	          <i class="bi bi-calendar-check"></i>
	          <span>사내일정</span>
	        </a>
		</li><!-- End Contact Page Nav -->
	      
	
		<!-- ======= 카테고리 - 내 정보 ======= -->
		<li class="nav-item">
	        <a class="nav-link collapsed sideMyInfoBig" data-bs-target="#components-nav" data-bs-toggle="collapse" href="#">
	          <i class="bi bi-person-circle"></i><span>내 정보</span><i class="bi bi-chevron-down ms-auto"></i>
	        </a>
	        <ul id="components-nav" class="nav-content collapse" data-bs-parent="#sidebar-nav">
	          <li>
	            <a href="/topaz/groupware/myPage/myInfo" class="nav-click sideMyInfo">
	              <i class="bi bi-circle"></i><span>내정보</span>
	            </a>
	          </li>
	          <li>
	            <a href="/topaz/groupware/myPage/myNoteReceived" class="nav-click sideMyNote">
	              <i class="bi bi-circle"></i><span>나의 쪽지 목록</span>
	            </a>
	          </li>
	          <li>
	            <a href="/topaz/groupware/myPage/myNoteStatistics" class="nav-click sideMyNoteStat">
	              <i class="bi bi-circle"></i><span>나의 쪽지 통계</span>
	            </a>
	          </li>
	        </ul>
		</li><!-- End Components Nav -->
		
		
		<!-- ======= 카테고리 - 결재함 ======= -->
		<li class="nav-item">
	        <a class="nav-link collapsed sideApprBig" data-bs-target="#icons-nav" data-bs-toggle="collapse" href="#">
	          <i class="bi bi-inboxes"></i><span>결재함</span><i class="bi bi-chevron-down ms-auto"></i>
	        </a>
	        <ul id="icons-nav" class="nav-content collapse" data-bs-parent="#sidebar-nav">
	          <li>
	            <a href="/topaz/groupware/approval/approvalAdd" class="nav-click sideAppr">
	              <i class="bi bi-circle"></i><span>신규 결재</span>
	            </a>
	          </li>
	          <li>
	            <a href="/topaz/groupware/approval/approvalList" class="nav-click sideApprAdd">
	              <i class="bi bi-circle"></i><span>내 결재함</span>
	            </a>
	          </li>
	        </ul>
		</li><!-- End Icons Nav -->
		
		
		<!-- ======= 카테고리 - 직원 관리 ======= -->
		<li class="nav-item">
	        <a class="nav-link collapsed sideEmpBig" data-bs-target="#forms-nav" data-bs-toggle="collapse" href="#">
	          <i class="bi bi-people"></i><span>직원 관리</span><i class="bi bi-chevron-down ms-auto"></i>
	        </a>
	        <ul id="forms-nav" class="nav-content collapse" data-bs-parent="#sidebar-nav">
	          <li>
	            <a href="/topaz/groupware/emp/empList" class="nav-click sideEmp">
	              <i class="bi bi-circle"></i><span>직원 목록</span>
	            </a>
	          </li>
	          <li>
	            <a href="/topaz/groupware/emp/empOrganizationChart" class="nav-click sideOraniz">
	              <i class="bi bi-circle"></i><span>조직도</span>
	            </a>
	          </li>
	          <li>
	            <a href="/topaz/groupware/emp/empNoteStatistics" class="nav-click sideNoteStat">
	              <i class="bi bi-circle"></i><span>팀 쪽지 통계</span>
	            </a>
	          </li>
	          <li>
	            <a href="/topaz/groupware/emp/empLeave" class="nav-click sideLeave">
	              <i class="bi bi-circle"></i><span>연월차 조회</span>
	            </a>
	          </li>
	          <li>
	            <a href="/topaz/groupware/emp/empAttendance" class="nav-click sideAttend">
	              <i class="bi bi-circle"></i><span>근태 조회</span>
	            </a>
	          </li>
	        </ul>
		</li><!-- End Forms Nav -->
		
		
		<!-- ======= 카테고리 - 외주업체 관리 ======= -->
		<li class="nav-item">
	        <a class="nav-link collapsed sideBpoBig" data-bs-target="#tables-nav" data-bs-toggle="collapse" href="#">
	          <i class="bi bi-shop"></i><span>외주업체 관리</span><i class="bi bi-chevron-down ms-auto"></i>
	        </a>
	        <ul id="tables-nav" class="nav-content collapse" data-bs-parent="#sidebar-nav">
	          <li>
	            <a href="/topaz/groupware/bpo/bpoMainIn" class="nav-click sideBpoRsvn">
	              <i class="bi bi-circle"></i><span>예약 일정</span>
	            </a>
	          </li>
	          <li>
	            <a href="/topaz/groupware/bpo/bpoList" class="nav-click sideBpo">
	              <i class="bi bi-circle"></i><span>업체 목록</span>
	            </a>
	          </li>
	          <li>
	            <a href="/topaz/groupware/bpo/bpoAdd" class="nav-click sideBpoAdd">
	              <i class="bi bi-circle"></i><span>신규 업체 등록</span>
	            </a>
	          </li>
	        </ul>
		</li><!-- End Tables Nav -->
		
		
		<!-- ======= 카테고리 - 입주자 관리 ======= -->
		<li class="nav-item">
	        <a class="nav-link sideResident collapsed" id="sideResident" href="/topaz/groupware/resident/residentList">
	          <i class="bi bi-gem"></i>
	          <span>입주자 관리</span>
	        </a>
	      </li><!-- End F.A.Q Page Nav -->
	      
	      
	      <!-- ======= 카테고리 - 객실 관리 ======= -->
	      <li class="nav-item">
	        <a class="nav-link collapsed sideRoomVig" data-bs-target="#charts-nav" data-bs-toggle="collapse" href="#">
	          <i class="bi bi-house-heart"></i><span>객실 관리</span><i class="bi bi-chevron-down ms-auto"></i>
	        </a>
	        <ul id="charts-nav" class="nav-content collapse" data-bs-parent="#sidebar-nav">
	          <li>
	            <a href="/topaz/groupware/room/roomList" class="nav-click sideRoom">
	              <i class="bi bi-circle"></i><span>객실</span>
	            </a>
	          </li>
	          <li>
	            <a href="/topaz/groupware/room/roomAmenityList" class="nav-click sideAmenity">
	              <i class="bi bi-circle"></i><span>어메니티</span>
	            </a>
	          </li>
	        </ul>
		</li><!-- End Charts Nav -->
		
		
		<!-- ======= 카테고리 - 봉사 일정 관리 ======= -->
		<li class="nav-item">
	        <a class="nav-link sideVolunteer collapsed" id="sideVolunteerMain" href="/topaz/groupware/volunteer/volunteerMain">
	          <i class="bi bi-calendar-heart"></i>
	          <span>봉사 일정 관리</span>
	        </a>
		</li><!-- End Register Page Nav -->
		
		
		<!-- ======= 카테고리 - 봉사 신청 관리 ======= -->
		<li class="nav-item">
	        <a class="nav-link sideVolunteer collapsed" id="sideVolunteerList" href="/topaz/groupware/volunteer/volunteerList">
	          <i class="bi bi-balloon-heart"></i>
	          <span>봉사 신청 관리</span>
	        </a>
		</li><!-- End Register Page Nav -->
      

	</ul>

</aside><!-- End Sidebar-->
 
<script type="text/javascript">
	/*
	 * 박혜아 2024.07.04
	 * 부트스트랩 사이드바를 따로 분리 -> CSS효과 주기 위한 JS
	 *
	 */
	$(document).ready(function() {
	 
		// 페이지 로드 시 현재 url경로에 해당하는 링크에 active 클래스 추가
		let currentPath = window.location.pathname;
	    
	    $('#sidebar-nav a').each(function() {
	    	
			let linkPath = $(this).attr('href');
			
	        if (currentPath === linkPath) {
				
				let chkId = $(this).attr('id');
				
				if(chkId == 'sideNotice'){
					// 공지사항 클릭시 collapsed 클래스 제거
					 $('.sideNotice').removeClass('collapsed');
					 
				}else if(chkId == 'sideSchedule'){
					// 사내일정 클릭시 collapsed 클래스 제거
					 $('.sideSchedule').removeClass('collapsed');
					 
				}else if(chkId == 'sideResident'){
					// 입주자 관리 클릭시 collapsed 클래스 제거
					 $('.sideResident').removeClass('collapsed');
					 
				}else if(chkId == 'sideVolunteerMain'){
					// 봉사 일정 관리 클릭시 collapsed 클래스 제거
					 $('.sideVolunteerMain').removeClass('collapsed');
					 
				}else if(chkId == 'sideVolunteerList'){
					// 봉사 신청 관리 클릭시 collapsed 클래스 제거
					 $('.sideVolunteerList').removeClass('collapsed');
					 
				}else{
					// 그 외 카테고리 클릭 시 show, active 클래스 추가
					$(this).closest('ul').addClass('show');
	            	$(this).addClass('active');
				}
	        }
	        
	    });
	    
	    sideResident
	});
</script>
