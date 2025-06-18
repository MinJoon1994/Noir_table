<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style>
.fade-up {
  opacity: 0;
  transform: translateY(50px);
  transition: opacity 1.2s ease-out, transform 1.2s ease-out;
}

.fade-up.show {
  opacity: 1;
  transform: translateY(0);
}

.icon_box {
  display: flex;
  justify-content: center;
}

.icon_box img {
  width: 50px;
  height: 50px;
}

</style>

<div class="icon_box fade-up" style="margin-top:30px; margin-bottom:20px;">
  <img src="${contextPath}/resources/image/noir_icon.png"/>
</div>
<div class="icon_box fade-up">
 	<h2>고객 관리</h2>
</div>

<div class="fade-up" style="margin: 30px auto; max-width: 75%;">
  <table style="width: 100%; border-collapse: collapse; text-align: center;">
    <thead>
      <tr style="background-color: #f0f0f0;">
        <th style="padding: 12px; border-bottom: 1px solid #ccc;">ID</th>
        <th style="padding: 12px; border-bottom: 1px solid #ccc;">로그인아이디</th>
        <th style="padding: 12px; border-bottom: 1px solid #ccc;">비밀번호</th>
        <th style="padding: 12px; border-bottom: 1px solid #ccc;">전화번호</th>
        <th style="padding: 12px; border-bottom: 1px solid #ccc;">이름</th>
        <th style="padding: 12px; border-bottom: 1px solid #ccc;">소셜</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach var="member" items="${memberList}">
        <tr>
          <td style="padding: 10px; border-bottom: 1px solid #eee;">${member.id}</td>
          <td style="padding: 10px; border-bottom: 1px solid #eee;">${member.login_id}</td>
          <td style="padding: 10px; border-bottom: 1px solid #eee;">${member.password}</td>
          <td style="padding: 10px; border-bottom: 1px solid #eee;">${member.phone}</td>
          <td style="padding: 10px; border-bottom: 1px solid #eee;">${member.name}</td>
          <td style="padding: 10px; border-bottom: 1px solid #eee;">
            <c:choose>
              <c:when test="${not empty member.social_type}">
                ${member.social_type}
              </c:when>
              <c:otherwise>
                일반
              </c:otherwise>
            </c:choose>
          </td>
        </tr>
      </c:forEach>
    </tbody>
  </table>
</div>


<script>


// 페이드 인 효과
const observer = new IntersectionObserver(entries => {
  entries.forEach(entry => {
    if (entry.isIntersecting) {
      entry.target.classList.add('show');
      observer.unobserve(entry.target);
    }
  });
}, { threshold: 0.2 });

document.querySelectorAll('.fade-up').forEach(section => {
  observer.observe(section);
});
</script>
