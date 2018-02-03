<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>


<c:set var = "userSession" value = '<%= session.getAttribute("login") %>'/>
<%-- <%@include file="/WEB-INF/views/plan/registerModal.jsp"%> --%>
 <body id="top" class="thebg" >
	<div class="navbar-wrapper2 navbar-fixed-top">
      <div class="container">
		<div class="navbar mtnav">

			<div class="container offset-3">
			  <!-- Navigation-->
			  <div class="navbar-header">
				<button data-target=".navbar-collapse" data-toggle="collapse" class="navbar-toggle" type="button">
				  <span class="icon-bar"></span>
				  <span class="icon-bar"></span>
				  <span class="icon-bar"></span>
				</button>
				<a href="/" class="navbar-brand"><img src="/resources/images/logo.png" alt="Travel Agency Logo" class="logo"/></a>
			  </div>
			
			<div class="navbar-collapse collapse" >	
  				<ul  class="nav nav2 navlight navbar-nav navbar-right" >
	  				<c:choose>
						<c:when test = "${empty userSession}">
							<li><a href="/member/register">회원가입</a></li>
							<li><a href="/member/login">&nbsp;&nbsp;로그인&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
						</c:when>
						<c:otherwise>		
							<li>
								<c:choose>
									<c:when test="${userSession.memberPicture==null}">
										<a class="header-profile-box" style="background-image:url('/resources/images/user.png')"></a>
									</c:when>
									<c:otherwise>
										<a class="header-profile-box" style="background-image:url('/displayFile?fileName=${userSession.memberPicture}&directory=profile')"></a>
									</c:otherwise>
								</c:choose>	
							</li>
							<li class="dropdown">
				
								<a data-toggle="dropdown" class="dropdown-toggle" href="dashboard/index">	
									<span>${userSession.memberName}&nbsp;<b class="lightcaret mt-2"></b></span>
								</a>
								<ul class="dropdown-menu">
									<li><a href="/member/mypage">마이페이지</a></li>
									<li><a href="/member/logout">로그아웃</a></li>
								</ul>
							</li>
							<li>
								<a href="/plan/register">&nbsp;&nbsp;일정등록&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
							</li>
						</c:otherwise>
					</c:choose>
					<li>
						<form action="/search/result" >
							<div class="input-group" style="padding:8px 0; width:200px">
								<input  id="keywordInput" name='keyword' type="text" class="form-control" placeholder="${cri.keyword }" value="${cri.keyword }" ></input>
								<span class="input-group-btn">
									<button class="btn btn-default searchbtn" type="submit">Go!</button>
								</span>
							</div>
						</form>
					</li>
				</ul>
  				
			  </div>
			  <!-- /Navigation-->			  
			</div>
        </div>
      </div>
    </div>
	