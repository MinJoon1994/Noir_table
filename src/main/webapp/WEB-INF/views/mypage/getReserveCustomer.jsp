<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>내 예약 조회</title>
    <!-- Bootstrap CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2 class="mb-4">내 예약 현황</h2>
    
    <table class="table table-bordered">
        <thead class="table-light">
            <tr>
                <th>예약번호</th>
                <th>회원명</th>
                <th>좌석번호</th>
                <th>위치</th>
                <th>인원수</th>
                <th>예약일</th>
                <th>시간대</th>
                <th>상태</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${not empty customerReservationList}">
                    <c:forEach var="res" items="${customerReservationList}">
                        <tr>
                            <td>${res.customerId}</td>
                            <td>${res.memberName}</td>
                            <td>${res.seatId}</td>
                            <td>${res.location}</td>
                            <td>${res.headCount}</td>
                            <td>${res.reserveDate}</td>
                            <td>${res.timeSlot}</td>
                            <td>${res.status}</td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td colspan="8" class="text-center">예약 내역이 없습니다.</td>
                    </tr>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>
</div>

<!-- Bootstrap JS CDN (필요시) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
