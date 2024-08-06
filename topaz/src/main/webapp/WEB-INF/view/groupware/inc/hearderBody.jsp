<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1.5.0/dist/sockjs.min.js"></script> <!-- SockJS  라이브러리 -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> <!-- Jquery -->
    
    <style>
		
		/* 아이콘 애니메이션 효과 */
		@keyframes glow {
		    0%, 100% {
		        box-shadow: 0 0 5px rgba(255, 0, 0, 0.5), 0 0 10px rgba(255, 0, 0, 0.5), 0 0 15px rgba(255, 0, 0, 0.5);
		    }
		    50% {
		        box-shadow: 0 0 10px rgba(255, 0, 0, 1), 0 0 20px rgba(255, 0, 0, 1), 0 0 30px rgba(255, 0, 0, 1);
		    }
		}
		
		.glow {
		    animation: glow 1s ease-in-out;
		}
    </style>
</head>

<body>
    <!-- ======= Header ======= -->
    <header id="header" class="header fixed-top d-flex align-items-center">
        <div class="d-flex align-items-center justify-content-between">
            <a href="/topaz/groupware/empMain" class="logo d-flex align-items-center">
                <img src="/topaz/assets/img/topaz-logo.jpg" alt="">
                <span class="d-none d-lg-block">Topaz Group</span>
            </a>
            <i class="bi bi-list toggle-sidebar-btn"></i>
        </div><!-- End Logo -->

        <nav class="header-nav ms-auto">
            <ul class="d-flex align-items-center">
                <li class="nav-item d-block d-lg-none">
                    <a class="nav-link nav-icon search-bar-toggle " href="#">
                        <i class="bi bi-search"></i>
                    </a>
                </li><!-- End Search Icon-->

                <!-- 쪽지 알림 -->
                <li class="nav-item dropdown">
                    <a class="nav-link nav-icon" href="#" data-bs-toggle="dropdown">
                        <i class="bi bi-bell"></i>
                       
                        <!-- 쪽지 알림 개수 -->
                        <span id="notification-count" class="badge bg-primary badge-number">0</span>
                    
                    </a><!-- End Notification Icon -->

                    <!-- 알림 메세지 시작 -->
                    <ul id="notification-list" class="dropdown-menu dropdown-menu-end dropdown-menu-arrow notifications">
                        <!-- 알람온 메세지 수 표시  -->
                        <li class="dropdown-header">
                            새로운 알림이 <span id="notification-count-text">0</span>개 도착했습니다.
                        </li>
                        <!-- 구분선 -->
                        <li>
                            <hr class="dropdown-divider">
                        </li>
                        <!-- 알림 항목들이 이곳에 추가될 예정 -->
                        
                        
                    </ul><!-- End Notification Dropdown Items -->
                    <!-- 알림 메세지 종료 -->
                </li><!-- End Notification Nav -->



                <li class="nav-item dropdown pe-3">
                    <a class="nav-link nav-profile d-flex align-items-center pe-0" href="#" data-bs-toggle="dropdown">
                        <img src="/topaz/upload/emp/${loginEmpDetail.fileName}" alt="Profile" class="rounded-circle">
                        <span class="d-none d-md-block dropdown-toggle ps-2">${loginEmpDetail.empName }</span>
                    </a><!-- End Profile Iamge Icon -->

                    <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow profile">
                        <li class="dropdown-header">
                            <h6>${loginEmpDetail.empName }</h6>
                            <span>${loginEmpDetail.empDept }</span>
                        </li>
                        <li>
                            <hr class="dropdown-divider">
                        </li>
                        <!-- 내정보 보기 -->
                        <li>
                            <a class="dropdown-item d-flex align-items-center" href="${pageContext.request.contextPath}/groupware/myPage/myInfo">
                                <i class="bi bi-person"></i>
                                <span>My Profile</span>
                            </a>
                        </li>
                        <li>
                            <hr class="dropdown-divider">
                        </li>
                        <!-- 로그아웃 -->
                        <li>
                            <a class="dropdown-item d-flex align-items-center" href="${pageContext.request.contextPath}/logout">
                                <i class="bi bi-box-arrow-right"></i>
                                <span>Sign Out</span>
                            </a>
                        </li>
                    </ul><!-- End Profile Dropdown Items -->
                </li><!-- End Profile Nav -->
            </ul>
        </nav><!-- End Icons Navigation -->
    </header><!-- End Header -->

    <!-- 사용자 정의 스크립트 로드 -->
    <script src="/topaz/js/insuHeaderBody.js"></script>
</body>
</html>
