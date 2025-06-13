<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"
    isELIgnored="false"
    %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}" />

<script type="text/javascript">

</script>

<style>
    header {
        background-color: white;
        color: black;
        padding: 30px 50px 10px 50px;
        text-align: center;
        position: relative;
    }

    .header-container {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .header-left,
    .header-right {
        width: 20%;
        display: flex;
        align-items: center;
        justify-content: flex-start;
        gap: 20px;
    }

    .header-right {
        justify-content: flex-end;
    }

    .header-center {
        width: 60%;
        text-align: center;
    }

    .brand a{
    	text-decoration:none;
        font-size: 2rem;
        font-weight: bold;
        letter-spacing: 2px;
        color:black;
    }

    .brand-sub {
        font-size: 1rem;
        margin-top: 5px;
        color: #aaa;
    }

    nav {
        margin-top: 20px;
    }

    nav a {
        margin: 0 15px;
        color: black;
        text-decoration: none;
        font-size: 0.95rem;
        letter-spacing: 1px;
    }

    nav a:hover {
        color: #5A2A7C; /* 퍼플 강조 */
    }

    .divider {
        height: 2px;
        background: #5A2A7C; /* 강조용 퍼플 라인 */
        margin-top: 20px;
    }

    .header-link {
        color: black;
        text-decoration: none;
        font-size: 0.9rem;
    }

    .header-link:hover {
        color: #5A2A7C;
    }
    
    .brand-icon{
    	width:30px;
    	height:30px;
    	margin-right:5px;
    	padding:5px;
    }
    
	.profile-wrapper {
	    width: 30px;
	    height: 30px;
	    border: 3px solid #444;
	    border-radius: 50%;
	    overflow: hidden;
	    display: flex;
	    justify-content: center;
	    align-items: center;
	    background-color: white; /* 이미지 없는 경우 대비 */
	}
	
	.profile-wrapper img {
		padding-top:5px;
	    width: 100%;
	    height: 100%;
	    object-fit: cover;
	    display: block;
	}
</style>
<body>


<header>
    <div class="header-container">
        <!-- 왼쪽: SNS (아이콘은 추후 이미지나 font-awesome으로 대체 가능) -->
        <div class="header-left">
			<a href="https://www.instagram.com/noir_table/" class="header-link">Instagram</a>
        </div>

        <!-- 가운데: 브랜드 -->
        <div class="header-center">
        	<img class="brand-icon" src="${contextPath}/resources/image/noir_icon.png">
            <div class="brand"><a href="${contextPath}/main.do">NOIR</a></div>
            <div class="brand-sub">누아르</div>
        </div>

        <!-- 오른쪽: 로그인/회원가입 로그인시엔 회원 이름 -->
        <div class="header-right">
        	<c:choose>
			  <c:when test="${not empty sessionScope.member}">
			    <div style="display: flex; align-items: center; gap: 10px;">
				  <div class="profile-wrapper">
				  	<c:if test="${not empty sessionScope.member.social_type}">
				      <img src="${sessionScope.member.profileImage}"
				           alt="프로필 이미지">
				     </c:if>
				     <c:if test="${empty sessionScope.member.social_type}">
				     	<img src="${contextPath}${sessionScope.member.profileImage}"
				           alt="프로필 이미지">
				     </c:if>
			      </div>
			      <span style="font-weight: bold;">${sessionScope.member.name} 님</span>
			      <a href="<c:url value='/member/logout.do'/>" class="header-link">로그아웃</a>
			    </div>
			  </c:when>
			  <c:otherwise>
			    <a href="<c:url value='/member/loginForm.do'/>" class="header-link">로그인</a>
			    <a href="<c:url value='/member/registerForm.do'/>" class="header-link">회원가입</a>
			  </c:otherwise>
			</c:choose>
        </div>
        
        
    </div>

    <!-- 메뉴 네비게이션 -->
    <nav>
        <a href="<c:url value='/about.do'/>">ABOUT</a>
        <a href="<c:url value='/menu/list.do?menuType='/>">MENU</a>
        
        <c:choose>
		  <c:when test="${sessionScope.member.role eq 'ADMIN'}">
		    <a href="<c:url value='/reservationAdmin.do'/>">RESERVATION</a>
		  </c:when>
		  <c:when test="${sessionScope.member.role eq 'USER'}">
		    <a href="<c:url value='/reservationUser.do'/>">RESERVATION</a>
		  </c:when>
		</c:choose>
		
        <a href="<c:url value='/gallery.do'/>">GALLERY</a>
        <c:if test="${not empty sessionScope.member}">
		    <a href="<c:url value='/mypage.do'/>">MYPAGE</a>
		</c:if>
        <a href="<c:url value='/review.do'/>">REVIEW</a>
    </nav>

    <!-- 강조용 퍼플 라인 -->
    <div class="divider"></div>
</header>
</body>
</html>






