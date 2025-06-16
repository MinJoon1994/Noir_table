<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원정보 수정</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        .readonly-field {
            background-color: #f0f0f0;  
            color: #6c757d;             
            pointer-events: none;       
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <h2 class="mb-4">회원정보 수정</h2>
    <form action="${contextPath}/mypage/updateMember.do" method="post">
        <input type="hidden" name="memberId" value="${noirMemberVO.memberId}" />

        <div class="mb-3">
            <label class="form-label">이름</label>
            <input type="text" class="form-control readonly-field" value="${noirMemberVO.name}" readonly>
        </div>

        <div class="mb-3">
            <label class="form-label">로그인 아이디</label>
            <input type="text" class="form-control readonly-field" value="${noirMemberVO.loginId}" readonly>
        </div>

        <div class="mb-3">
            <label for="password" class="form-label">비밀번호</label>
            <input type="password" class="form-control" id="password" name="password" placeholder="변경할 비밀번호 입력">
        </div>

        <div class="mb-3">
            <label for="phone" class="form-label">전화번호</label>
            <input type="text" class="form-control" id="phone" name="phone" placeholder="변경할 전화번호 입력">
        </div>

        <button type="submit" class="btn btn-primary">정보 수정</button>
        <a href="${contextPath}/main.do" class="btn btn-secondary">취소</a>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
