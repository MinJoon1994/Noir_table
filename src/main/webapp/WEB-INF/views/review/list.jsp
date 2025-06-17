<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- JSTL 중에서 core 태그를 사용하기 위해 주소를 import --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%-- 한글 인코딩 --%>
<% request.setCharacterEncoding("UTF-8"); %>

<%-- 현재 웹 애플리케이션(프로젝트)의 기본 경로를 가져옵니다. --%>
<%-- 예를 들어, 프로젝트 주소가 http://localhost:8090/noir/review.do --%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<c:out value="${contextPath}"/>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
<link rel="stylesheet" href="${contextPath}/resources/css/review/star.css">
<link rel="stylesheet" href="${contextPath}/resources/css/review/paging.css">
<link rel="stylesheet" href="${contextPath}/resources/css/review/list.css">


<h2>리뷰 목록</h2>
<table border="1" style="width:100%; border-collapse:collapse; text-align:center;">
	<thead>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>내용</th>
			<th>별점</th>
			<th>사진</th>
			<th>예약일자</th>
			<th>식사타입</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="review" items="${reviewList}">
			<tr>
				<td>${review.reviewId}</td>
				<td><a href="${contextPath}/review/detail.do?reviewId=${review.reviewId}">${review.title}</a></td>
				<td style="max-width:200px; white-space:pre-line;">${review.content}</td>
				<td>
					<c:forEach var="i" begin="1" end="5">
						<i class="${i <= review.rating ? 'fas' : 'far'} fa-star" style="color:#FFD700"></i>
					</c:forEach>
				</td>
				<td>
					<c:choose>
						<c:when test="${not empty review.photoUrls}">
							<c:forEach var="img" items="${review.photoUrls}">
								<img src="${img}" width="80" style="border-radius:8px;"/>
							</c:forEach>
						</c:when>
						<c:otherwise>
							이미지 없음
						</c:otherwise>
					</c:choose>
				</td>
				<td>${review.reservationDate}</td>
				<td>${review.mealType}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>

<a href="${contextPath}/review/write.do">리뷰 작성</a><br>

<!-- 페이징 및 블록페이징 처리 -->
<center>
	<div class="pagination" style="text-align:center; clear:both;">
		<c:if test="${startBlock > 1}">
			<a href="${contextPath}/review.do?page=${startBlock - 1}">이전</a>
		</c:if>
	
		<c:forEach var="i" begin="${startBlock}" end="${endBlock}">
			<c:choose>
				<c:when test="${i == currentPage}">
					<strong>${i}</strong>
				</c:when>
				<c:otherwise>
					<a href="${contextPath}/review.do?page=${i}">${i}</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	
		<c:if test="${endBlock < totalPage}">
	    	<a href="${contextPath}/review.do?page=${endBlock + 1}">다음</a>
		</c:if>
	</div>
</center>            


