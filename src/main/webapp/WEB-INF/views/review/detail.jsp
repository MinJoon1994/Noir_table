<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- JSTL 중에서 core 태그를 사용하기 위해 주소를 import --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%-- 한글 인코딩 --%>
<% request.setCharacterEncoding("UTF-8"); %>

<%-- 현재 웹 애플리케이션(프로젝트)의 기본 경로를 가져옵니다. --%>
<%-- 예를 들어, 프로젝트 주소가 http://localhost:8090/noir/review.do --%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
<link rel="stylesheet" href="${contextPath}/resources/css/review/star.css">

<div class="review-detail">
    <h2>${review.title}</h2>
    <b>번호:</b> ${review.reviewId}<br>
    <b>예약ID:</b> ${review.reservationId}<br>
    <b>예약일자:</b> ${review.reservationDate}<br>
    <b>식사타입:</b> ${review.mealType}<br>
    <b>내용:</b> <pre style="white-space: pre-line;">${review.content}</pre><br>
    <b>별점:</b>
    <span>
      <c:forEach var="i" begin="1" end="5">
        <i class="${i <= review.rating ? 'fas' : 'far'} fa-star" style="color: #FFD700;"></i>
      </c:forEach>
    </span>
    <br>
    <b>사진:</b>
    <br>
    <c:choose>
        <c:when test="${not empty review.photoUrls}">
            <c:forEach var="img" items="${review.photoUrls}">
                <a href="${img}" target="_blank"><img src="${img}" width="120"/></a>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <span>첨부 이미지가 없습니다.</span>
        </c:otherwise>
    </c:choose>
</div>
<div style="margin-top:20px;">
    <a href="${contextPath}/review/write.do" class="btn">리뷰 작성</a>
    <a href="${contextPath}/review/edit.do?reviewId=${review.reviewId}" class="btn">수정</a>
    <form action="${contextPath}/review/delete.do" method="post" style="display:inline;">
        <input type="hidden" name="reviewId" value="${review.reviewId}" />
        <button type="submit" class="btn" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</button>
    </form>
    <a href="${contextPath}/review.do" class="btn">목록으로</a>
</div>

<!-- 이전글 및 다음글 처리 -->
<hr>
<div style="margin-top:30px;">
    <c:if test="${not empty prevReview}">
        <div>
            ◀ 이전글: <a href="${contextPath}/review/detail.do?reviewId=${prevReview.reviewId}">${prevReview.title}</a>
        </div>
    </c:if>
    <c:if test="${not empty nextReview}">
        <div>
            ▶ 다음글: <a href="${contextPath}/review/detail.do?reviewId=${nextReview.reviewId}">${nextReview.title}</a>
        </div>
    </c:if>
</div>
