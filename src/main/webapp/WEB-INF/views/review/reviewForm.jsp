<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- JSTL 중에서 core 태그를 사용하기 위해 주소를 import --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%-- 한글 인코딩 --%>
<% request.setCharacterEncoding("UTF-8"); %>

<%-- 현재 웹 애플리케이션(프로젝트)의 기본 경로를 가져옵니다. --%>
<%-- 예를 들어, 프로젝트 주소가 http://localhost:8090/noir/review/write.do --%>
<%-- 예를 들어, 프로젝트 주소가 http://localhost:8090/noir/review/edit.do --%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
<link rel="stylesheet" href="${contextPath}/resources/css/review/star.css">
<link rel="stylesheet" href="${contextPath}/resources/css/review/paging.css">

<h2>${formTitle}</h2>
<form action="${formAction}" method="post" enctype="multipart/form-data">
    <c:if test="${not empty review.reviewId}">
        <input type="hidden" name="reviewId" value="${review.reviewId}" />
    </c:if>
    <label>제목: <input type="text" name="title" value="${review.title}" required /></label><br>
    <label>내용: <textarea name="content" required rows="5" cols="50">${review.content}</textarea></label><br>
    <label>별점:
        <select name="rating" required>
            <option value="">선택</option>
            <c:forEach var="i" begin="1" end="5">
                <option value="${i}" <c:if test="${review.rating == i}">selected</c:if>>${i}점</option>
            </c:forEach>
        </select>
    </label><br>
    <label>예약 ID:
        <input type="number" name="reservationId_view" value="${review.reservationId}" required readonly disabled />
        <input type="hidden" name="reservationId" value="${review.reservationId}" />
    </label><br>
    <label>이미지 첨부:
        <input type="file" name="images" multiple accept="image/*"/>
    </label>
    <c:if test="${not empty review.photoUrls}">
        <div>
            <c:forEach var="img" items="${review.photoUrls}">
                <img src="${img}" width="80"/>
            </c:forEach>
        </div>
    </c:if>
    <button type="submit">${submitBtnText}</button>
    <a href="${contextPath}/review.do">취소</a>
</form>