<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 
     * 분류 번호 :  #2 - 쪽지 답장 쓰기 페이지
     * 시작 날짜 : 2024-07-15
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
            <h1>쪽지 답장 쓰기</h1>
            <nav>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="/topaz/groupware/empMain">Home</a></li>
                    <li class="breadcrumb-item active">Note Reply  Add</li>
                </ol>
            </nav>
        </div><!-- Title 종료 -->

        <!-- section 시작 -->
        <section class="section">
            <div class="card">
                <div class="card-body">
                    <!-- 메인 -->
                    <div class="mainContent">
                      <form id="replyForm">
                            <div class="form-group">
                                <label for="recipient">받는 사람</label>
                                  <textarea id="recipient" name="recipient" class="form-control" readonly rows="3" style="resize: none;"><c:choose><c:when test="${not empty param.recipients}">${param.recipients}</c:when><c:otherwise>[${param.empDept} - ${param.empName}]</c:otherwise></c:choose>
                                </textarea>
                            </div>
                            
                            <div class="form-group" style="margin-top: 20px">
                                <label for="noteContent">내용</label>
                                <textarea id="noteContent" name="noteContent" class="form-control" rows="5" required></textarea>
                            </div>
                            
                            <div class="form-group" style="margin-top: 40px">
                                <button type="button" id="sendButton" class="btn btn-success">보내기</button>
                                <button type="button" id="sendButton" class="btn btn-success" onclick="window.location.href='${pageContext.request.contextPath}/groupware/myPage/myNoteReceived'">뒤로가기</button>
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
    <script src="/topaz/js/insuMyNoteRepAdd.js"></script>    
</body>
</html>
