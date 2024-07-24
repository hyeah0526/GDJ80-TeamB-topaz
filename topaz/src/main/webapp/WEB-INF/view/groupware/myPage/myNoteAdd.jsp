<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 
     * 분류 번호 :  #2 - 쪽지 쓰기 페이지
     * 시작 날짜 : 2024-07-14
     * 담당자 : 김인수
 -->
 
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- ======= header <Head> 부분 ======= -->
    <jsp:include page="/WEB-INF/view/groupware/inc/headerHead.jsp"></jsp:include>
    <link rel="stylesheet" href="/topaz/css/insuMyNote.css"> <!-- CSS -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> <!-- Jquery -->
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
            <h1>쪽지 쓰기</h1>
            <nav>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="/topaz/groupware/empMain">Home</a></li>
                    <li class="breadcrumb-item active">Note Add</li>
                </ol>
            </nav>
        </div><!-- Title 종료 -->

        <!-- section 시작 -->
        <section class="section">
            <div class="card">
                <div class="card-body">
                    <!-- 메인 -->
                    <div class="mainContent">
                        <form id="searchForm">
                            <div style="margin-bottom: 20px;">
                                <button type="button" onclick="window.location.href='${pageContext.request.contextPath}/groupware/myPage/myNoteAdd'">쪽지쓰기</button>
                                <button type="button" onclick="window.location.href='${pageContext.request.contextPath}/groupware/myPage/myNoteList'">발신 쪽지함</button>
                                <button type="button" onclick="window.location.href='${pageContext.request.contextPath}/groupware/myPage/myNoteReceived'">수신 쪽지함</button>
                                <button type="button" onclick="window.location.href='${pageContext.request.contextPath}/groupware/myPage/myNoteTrash'">휴지통 쪽지함</button>
                            </div>
                            
                            <div style="margin-bottom: 20px; display: flex; justify-content: flex-end;">
                                <button type="button" id="sendButton">전송</button>
                                <input type="hidden" id="senderId" value="${senderId}">
                            </div>
                            
                            <div class="form-group">
                                <label for="recipients">받는 사람</label>
                                <textarea id="recipients" name="recipients" class="form-control" placeholder="받는 사람을 입력하세요" required readonly rows="3" style="resize: none;"></textarea>
                            	 <span id="recipientsMsg" class="validMsg" style="color:red;"></span>
                            </div>
                            
                            <div class="form-group" style="margin-top: 20px">
                                <label for="noteContent">내용</label>
                                <textarea id="noteContent" name="noteContent" class="form-control" rows="5" required></textarea>
                            	<span id="noteContentMsg" class="validMsg" style="color:red;"></span>
                            </div>
                            
                            <div class="form-group" style="margin-top: 40px">
                                <label for="searchDept">직원 검색</label>
                                <input type="text" id="searchDept" name="searchDept" class="form-control" placeholder="직원명을 입력하세요" style="width: 30%;">
                                <button type="button" id="searchButton" class="btn btn-primary">검색</button>
                                <button type="button" id="resetButton" class="btn btn-secondary">리셋</button>
                            </div>
                            
                            <div class="form-group">
                                <label>직원 목록</label>
                                <div id="deptList"></div>
                            </div>
                        </form>

                    </div>          
                </div>
            </div>
        </section><!-- section 종료 -->
    </main><!-- End #main -->
    <!-- =============================== Main 메인 끝 부분 ================================ -->
    
    <!-- ======= footer 부분 ======= -->
    <jsp:include page="/WEB-INF/view/groupware/inc/footer.jsp"></jsp:include>
    <script src="/topaz/js/insuMyNoteAdd.js"></script>    
</body>
</html>
