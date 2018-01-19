<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
				<!-- SEARCH BOX -->
				
				
				
				<c:choose>
					<c:when test = "${empty userSession}">
						<ul id="nonmember" class="nav nav2 navlight navbar-nav navbar-right" >
							<li>
								<div  class="searchbox">
									<form action="search/result">
										<input id="keywordInput" name='keyword' type="text" class="form-control" placeholder="Search for...">
										<span class="input-group-btn">
											<button id='searchBtn' class="btn btn-default" type="submit">Go!</button>
										</span>
									</form>
								</div>
						    </li>
						    
							<li><a href="/member/register">회원가입</a></li>
							<li><a href="/member/login">로그인</a></li>
						</ul>
					</c:when>
					<c:otherwise>		
						<ul id="member" class="nav nav2 navlight navbar-nav navbar-right">
							<li class="input-group">
								<form action="search/result">
									<input id="keywordInput" name='keyword' type="text" class="form-control" placeholder="Search for...">
									<span class="input-group-btn">
										<button id='searchBtn' class="btn btn-default" type="submit">Go!</button>
									</span>
								</form>
						    </li>
							<li class="dropdown">
								<a data-toggle="dropdown" class="dropdown-toggle" href="/dashboard/index">
									<img src="/resources/images/user2.png" alt=""/>&nbsp;${userSession.memberName}<b class="lightcaret mt-2"></b>
								</a>
							</li>
							<ul class="dropdown-menu">
								<li><a href="/member/mypage">내정보 관리</a></li>
								<li><a href="/member/logout">로그아웃</a></li>
							</ul>
							<li><a href="/plan/register">일정등록버튼</a></li>
						</ul>
					</c:otherwise>
				</c:choose>	
			
			</div>
			  <!-- /Navigation-->			  
			</div>
        </div>
      </div>
    </div>
	
