<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!--
   분류 번호: #10 - 공지 사항 상세 페이지
   시작 날짜: 2024-07-05
   담당자: 김지훈
-->    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:forEach var="n" items="${noticeDetail}">
			<div>${n.newsNo}</div>
			<div>
				${n.title}
			</div>
			<div>${n.regTime}</div>
			<div>${n.modTime}</div>
	</c:forEach>
</body>
</html>