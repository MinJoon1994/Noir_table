<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="startHour" value="${fn:substring(time, 0, 2)}" />
<c:set var="pricePerPerson" value="0" />

<c:choose>
  <c:when test="${startHour >= 12 and startHour <= 15}">
    <c:set var="pricePerPerson" value="100000" />
    <c:set var="mealType" value="런치" />
  </c:when>
  <c:when test="${startHour >= 16 and startHour <= 19}">
    <c:set var="pricePerPerson" value="150000" />
    <c:set var="mealType" value="디너" />
  </c:when>
</c:choose>
<c:set var="headCountReplace" value="${fn:replace(headCount, '명', '')}" />
<c:set var="totalPrice" value="${headCountReplace * pricePerPerson}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
    .main-container {
      width: 1017px;
      display: flex;
      margin: 40px auto 0;
    }
    .side-container {
  	  margin-top: 40px;
  	  width: 130px;
    }
    .step-menu { background-color: #e60113; color: white; flex: 1; display: flex; flex-direction: column; }
    .step-menu div { padding: 79.4px 17px; cursor: pointer; border-bottom: 1px solid rgba(255,255,255,0.2); }
    .step-menu div.active { background-color: #a00010; }
    .container {
      width: 887px;
      height: 728px;
      display: flex;
      flex-direction: column;
      margin: 40px auto 0;
      border: 1px solid black;
    }
    .main-reservation {
    	margin-top: 40px;
    	display: flex;
    }
    .left-main{
    	flex: 1;
    }
    .right-main{
    	flex: 1;
    }
    /* 예약 박스  */
	.reservation-box {
	    width: 300px;
	    border: 3px solid #ccc;
	    border-radius: 12px;
	    padding: 16px 20px;
	    margin: 30px;
	    box-shadow: 2px 2px 8px rgba(0, 0, 0, 0.1);
	    font-family: 'Arial', sans-serif;
	}
	
	.reservation-box table {
	    border-collapse: collapse;
	}
	
	.reservation-box td {
	    padding: 6px 10px;
	    vertical-align: top;
	    font-size: 17px;
	    color: #333;
	}
	
	.reservation-box .title {
	    font-weight: bold;
	    font-size: 24px;
	    padding-bottom: 10px;
	}
	.label {
	    color: #999;
	    width: 50px;
	}
	/* right-main */
	
	/* 상단 제목 */
	.order-title {
		font-weight: normal;
		margin-left: 40px;
	    color: #d60000;
	    font-size: 28px;
	    margin-bottom: 23px;
	}
	.table-outbox {
		width: 400px;
		height: 250px;
		border: 1px solid #d3d3d3;
	}
	/* 테이블 전체 */
	.order-table {
	    width: 400px;
	    margin: 0;
	    border-collapse: collapse;
	    font-size: 13px;
	    background-color: white;
	}
	.order-table td,
	.order-table th {
	    text-align: center;
	    vertical-align: middle;
	}
	/* 테이블 헤더 */
	.table-header {
	    background-color: #f0f0f0;
	    border: 1px solid #ccc;
	    padding: 12px;
	}
	
	/* 테이블 셀 */
	.product-name,
	.product-quantity,
	.product-price {
	    border: 1px solid #ccc;
	    padding: 12px;
	}
	
	/* 요약 영역 */
	.order-summary {
		width: 380px;
		height: 30px;
	    display: flex;
	    padding: 10px;
	    justify-content: center;
	    margin-top: 30px;
	    font-size: 16px;
	    background-color: #ffeef2;
	}
	
	.total-quantity,
	.total-price {
	    margin: 0 30px;
	}
	
	/* 강조 색상 */
	.highlight {
	    color: red;
	}
	.pay-btn {
		margin-top: 35px;
		width: 250px;
		padding : 20px;
	    background-color: #ff4d4d; 
	    color: white;              
	}
</style>
<body>
<div class="main-container">
	<div class="side-container">
	    <div class="step-menu">
	      <div>01 에약하기</div>
	      <div>02 인원/좌석</div>
	      <div class="active">03 결제</div>
	      <div>04 결제완료</div>
	    </div>
    </div>
	<div class="container">
	    <div style="width: 827px; padding: 30px; font-size: 30px; 
		    color: #1a4f7a; text-align: left;
		    border-bottom: 2px solid #3180c3;">
	  		결제하기
		</div>		
		<div class="main-reservation">
		    <div class="left-main">
			    <div class="reservation-box">
			        <table>
			            <tr>
			                <td class="title" colspan="2">Noir식당 점심예약</td>
			            </tr>
			            <tr>
			                <td class="label">일정</td>
			                <td class="value">${date}&nbsp${time}</td>
			            </tr>
			            <tr>
			                <td class="label">선택</td>
			                <td class="value">${headCount}</td>
			            </tr>
			        </table>
			    </div>
			    <div class="reservation-box">
			        <table>
			            <tr>
			                <td class="title" colspan="2">좌석정보</td>
			            </tr>
			            <tr>
			                <td class="label">좌석</td>
			                <td class="value">${seatId}</td>
			            </tr>
			            <tr>
			                <td class="label">층</td>
			                <td class="value">${floor}</td>
			            </tr>
			            <tr>
			                <td class="label">장소</td>
			                <td class="value">${location}</td>
			            </tr>
			        </table>
			    </div>
			</div> <!-- left-main  -->
			<div class="right-main">
				<h2 class="order-title">주문정보를 확인해 주세요</h2>
				<div class="table-outbox">
					<table class="order-table">
					    <thead>
					        <tr>
					            <th class="table-header product">상품명</th>
					            <th class="table-header quantity">수량</th>
					            <th class="table-header price">가격</th>
					        </tr>
					    </thead>
					    <tbody>
					    	<tr>
				                <td class="product-name">${mealType}</td>
				                <td class="product-quantity">${headCount}</td>
				                <td class="product-price">
				                	<fmt:formatNumber value="${totalPrice}" type="number" groupingUsed="true"/>원
				                </td>
			                </tr>
					    </tbody>
					</table>
				</div>
				<div class="order-summary">
				    <div class="total-quantity">총 수량 :&nbsp<span class="highlight">${headCountReplace}개</span></div>
				    <div class="total-price">총 결제금액 :&nbsp<span class="highlight">
            			<fmt:formatNumber value="${totalPrice}" type="number" groupingUsed="true"/>원
          			</span></div>
				</div>
			</div><!-- right-main  -->
		</div><!-- main-reservation  -->
		<form id="paymentForm" action="${contextPath}/reservationUser/customerReservePay.do" method="post">
		  <input type="hidden" name="seatId" value="${seatId}">
		  <input type="hidden" name="reserveId" value="${reserveId}">
		  <input type="hidden" name="totalPrice" value="${totalPrice}">
		  <div style="text-align: center;">
		  	<button class="pay-btn" >결제하기</button>
		  </div>
		</form>
	</div>
</div>
</body>
</html>