<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<aside id="sidebar" class="sidebar">

	<ul class="sidebar-nav" id="sidebar-nav">
		
		
		<!-- ======= 카테고리 - 입주자 관리 ======= -->
		<li class="nav-item">
	        <a class="nav-link sideResident collapsed" id="sideResident" href="/topaz/outsourcing/bpoMainOut">
	          <i class="bi bi-grid"></i>
	          <span>메인</span>
	        </a>
	      </li><!-- End F.A.Q Page Nav -->
		
		
		<!-- ======= 카테고리 - 일정상세 ======= 
		<li class="nav-item" id="">
	        <a class="nav-link sideNotice collapsed" id="sideNotice" href="/topaz/groupware/bpo/bpoRsvnListOut">
	          <i class="bi bi-calendar-check"></i>
	          <span>예약 목록</span>
	        </a>
		</li>
		-->
		
		
	</ul>

</aside><!-- End Sidebar-->
 
<script type="text/javascript">
	/*
	 * 박혜아 2024.07.15
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
					 
				}else if(chkId == 'sideResident'){
					// 입주자 관리 클릭시 collapsed 클래스 제거
					 $('.sideResident').removeClass('collapsed');
					 
				}
	        }
	        
	    });
	    
	    sideResident
	});
</script>
