<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>예약 등록</title>
  <style>
    body {
      font-family: Arial;
      margin: 30px;
    }
    .form-group {
      margin-bottom: 15px;
    }
    label {
      display: inline-block;
      width: 100px;
      font-weight: bold;
    }
    select, input[type="date"] {
      padding: 5px;
      width: 180px;
    }
    .radio-group label {
      width: auto;
      margin-right: 10px;
    }
  </style>
</head>
<body>

  <h2>예약 등록</h2>

  <form id="reserveForm" action="/restaurant/admin/addReserve.do" method="POST">
    <!-- 식사 타임 -->
    <div class="form-group radio-group">
      <label>식사 타임:</label>
      <label><input type="radio" name="mealTime" value="lunch" checked> 런치</label>
      <label><input type="radio" name="mealTime" value="dinner"> 디너</label>
    </div>

    <!-- 예약 날짜 -->
    <div class="form-group">
      <label>예약 날짜:</label>
      <input type="date" id="reserveDate" name="reserveDate">
    </div>

    <!-- 시간대 -->
    <div class="form-group">
      <label>시간 선택:</label>
      <select id="timeSlot" name="timeSlot">
        <!-- JavaScript로 채워짐 -->
      </select>
    </div>


    <!-- 제출 버튼 -->
    <div class="form-group">
      <button type="submit">예약</button>
    </div>
  </form>

  <script>
    const timeSlot = document.getElementById('timeSlot');
    const mealRadios = document.querySelectorAll('input[name="mealTime"]');

    function updateTimeSlots(meal) {
      let options = "";
      if (meal === 'lunch') {
        for (let hour = 12; hour < 16; hour++) {
	        hour = parseInt(hour);
	        options += "<option>"+hour+":00 ~ "+(hour+1)+":00</option>";
        }
      } else if (meal === 'dinner') {
        for (let hour = 16; hour < 20; hour++) {
        	hour = parseInt(hour); 
        	options += "<option>"+hour+":00 ~ "+(hour + 1)+":00</option>";
        }
      }
      timeSlot.innerHTML = options;
    }

    // 초기 로딩 시
    updateTimeSlots('lunch');

    // 라디오 버튼 변경 감지
    mealRadios.forEach(radio => {
      radio.addEventListener('change', () => {
        updateTimeSlots(radio.value);
      });
    });
  </script>

</body>
</html>
