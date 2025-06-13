<%@ page contentType="text/html; charset=UTF-8" session="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>좌석 선택</title>
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
    display: flex;
    flex-direction: column;
    margin: 40px auto 0;
    border: 1px solid black;
  }
  .info-space {
    width: 887px;
    height: 70px;
    background-color: #f4f8fc;
    border: 1px solid #ccc;
    padding: 15px 20px;
    box-sizing: border-box;
    display: flex;
    justify-content: space-between;
    align-items: center;
    font-family: Arial;
    color: #333;
    font-size: 15px;
  }
  .info-box {
    font-weight: bold;
    padding: 10px 15px;
    display: flex;
    flex-direction: column;
    gap: 5px;
  }

  .seat-space {
    position: relative;
    width: 887px;
    height: 552px;
    background-image: url("${contextPath}/resources/image/floor2.PNG");
    background-size: cover;
    background-repeat: no-repeat;
    border: 1px solid #ccc;
  }

  .seat {
    display: flex;
    justify-content: center;
    align-items: center;
    position: absolute;
    background-color: rgba(0, 128, 0, 0.4);
    cursor: pointer;
    font-size: 14px;
    text-align: center;
    border: 2px solid #fff;
    transition: background-color 0.2s;
    border-radius: 0;
  }
  .seat:hover {
    background-color: rgba(0, 200, 0, 0.8);
  }
  .seat.disabled {
    background-color: rgba(80, 80, 80, 0.5);
    cursor: not-allowed;
    pointer-events: none;
  }

  .next-btn {
    position: absolute;
    bottom: 10px;
    right: 10px;
    padding: 10px 20px;
    background-color: #00509e;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
  }
</style>
</head>
<body>
<div class="main-container">
	<div class="side-container">
	    <div class="step-menu">
	      <div>01 에약하기</div>
	      <div class="active">02 인원/좌석</div>
	      <div>03 결제</div>
	      <div>04 결제완료</div>
	    </div>
    </div>
	<div class="container">
	  <div style="width: 827px; padding: 30px; font-size: 30px; 
	     color: #1a4f7a; text-align: left; border-bottom: 2px solid #3180c3;">
	    좌석 선택
	  </div>
	  <div class="info-space">
	    <div class="info-box">층 : ${floor}</div>
	    <div class="info-box">위치 : ${location}</div>
	    <div class="info-box">인원수 : ${headCount}</div>
	    <div class="info-box">날짜 : ${date}</div>
	    <div class="info-box">시간 : ${time}</div>
	  </div>
	
	  <div class="seat-space">
	    <div class="seat disabled" data-seat-id="9" style="top: 48px; left: 95px; width: 40px; height: 68px;" onclick="selectSeat(9)">예약가능</div>
	    <div class="seat disabled" data-seat-id="10" style="top: 205px; left: 109px; width: 77px; height: 93px;" onclick="selectSeat(10)">예약가능</div>
	    <div class="seat disabled" data-seat-id="11" style="top: 392px; left: 125px; width: 105px; height: 60px;" onclick="selectSeat(11)">예약가능</div>
	    <div class="seat disabled" data-seat-id="12" style="top: 155px; left: 270px; width: 92px; height: 139px;" onclick="selectSeat(12)">예약가능</div>
	    <div class="seat disabled" data-seat-id="13" style="top: 417px; left: 338px; width: 72px; height: 99px;" onclick="selectSeat(13)">예약가능</div>
	    <div class="seat disabled" data-seat-id="14" style="top: 170px; left: 480px; width: 120px; height: 60px;" onclick="selectSeat(14)">예약가능</div>
	    <div class="seat disabled" data-seat-id="15" style="top: 328px; left: 496px; width: 75px; height: 88px;" onclick="selectSeat(15)">예약가능</div>
	    <div class="seat disabled" data-seat-id="16" style="top: 90px; left: 683px; width: 92px; height: 55px;" onclick="selectSeat(16)">예약가능</div>
	    <div class="seat disabled" data-seat-id="17" style="top: 266px; left: 703px; width: 62px; height: 96px;" onclick="selectSeat(17)">예약가능</div>
	  </div>
	</div>
</div>
<form id="seatSubmitForm" action="${contextPath}/reservationUser/customerReserveThird.do" method="post">
  <input type="hidden" name="seatId" id="seatIdInput">
  <input type="hidden" name="floor" value="${floor}">
  <input type="hidden" name="location" value="${location}">
  <input type="hidden" name="headCount" value="${headCount}">
  <input type="hidden" name="date" value="${date}">
  <input type="hidden" name="time" value="${time}">
  <input type="hidden" name="reserveId" value="${reserveId}">
</form>

<script>
  /* 이전 단계에서 선택한 값  */
  const selectedLocation = '${location}';
  console.log("이전 단계에서 선택한 장소 : " + selectedLocation);
  const selectedHeadCount = '${headCount}';
  console.log("이전 단계에서 선택한 장소 : " + selectedHeadCount);
  
  const reservedSeatsId = [
    <c:forEach var="id" items="${reservedSeatsId}" varStatus="status">
      ${id}<c:if test="${!status.last}">,</c:if>
    </c:forEach>
  ];
  
  const seatList = [
    <c:forEach var="seat" items="${seatList}" varStatus="status">
      {
        seatId: ${seat.seat_Id},
        location: '${seat.location}',
        headCount: ${seat.head_Count},
        floor: ${seat.floor}
      }<c:if test="${!status.last}">,</c:if>
    </c:forEach>
  ];
  console.log("✅ 서버에서 받아온 seatList:", seatList);
  
  window.onload = function () {
    seatList.forEach(seat => {
      const seatDiv = document.querySelector(".seat[data-seat-id='"+seat.seatId+"']");
      if (seatDiv) {
        const isReserved = reservedSeatsId.includes(seat.seatId);
        const selectedIntHeadCount = parseInt(selectedHeadCount);

        if (isReserved) {
          seatDiv.classList.add('disabled');
          seatDiv.textContent = '예약됨';
          
          seatDiv.style.backgroundColor = 'rgba(200, 0, 0, 0.6)';
          seatDiv.style.color = 'white';
          seatDiv.style.fontWeight = 'bold';
          
        } else if ((seat.location === selectedLocation) && (seat.headCount === selectedIntHeadCount)) {
          seatDiv.classList.remove('disabled');
          seatDiv.textContent = '예약가능';
        }
      }
    });
  }

  function selectSeat(seatId) {
    const selectedSeat = seatList.find(seat => Number(seat.seatId) === Number(seatId));
    if (selectedSeat) {
      Swal.fire({
        title: '예약하기',
        html: `
          <div style="margin: 0 auto; width: fit-content; text-align: left;">
            <p><strong>선택된 좌석 정보</strong></p>
            <table>
              <tr><td style="padding-right: 20px;">ID:</td><td>\${selectedSeat.seatId}</td></tr>
              <tr><td style="padding-right: 20px;">위치:</td><td>\${selectedSeat.location}</td></tr>
              <tr><td style="padding-right: 20px;">인원수:</td><td>\${selectedSeat.headCount}</td></tr>
              <tr><td style="padding-right: 20px;">층수:</td><td>\${selectedSeat.floor}</td></tr>
            </table><br><strong>이 좌석으로 예약하시겠습니까?</strong>
          </div>
        `,
        icon: 'question',
        showCancelButton: true,
        confirmButtonText: '확인',
        cancelButtonText: '취소'
      }).then((result) => {
        if (result.isConfirmed) {
          document.getElementById("seatIdInput").value = selectedSeat.seatId;
          document.getElementById("seatSubmitForm").submit();
        }
      });
    } else {
      Swal.fire("오류", "좌석 정보를 찾을 수 없습니다.", "error");
    }
  }
</script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</body>
</html>
