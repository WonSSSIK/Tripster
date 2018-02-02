<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
  	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Tripster</title>

    <!-- Bootstrap -->
    <link href="/resources/dist/css/bootstrap.css" rel="stylesheet" media="screen">
    <link href="/resources/assets/css/custom.css" rel="stylesheet" media="screen">
	<link href="/resources/examples/carousel/carousel.css" rel="stylesheet">
	<link href="/resources/updates/update1/css/search.css" rel="stylesheet" media="screen">

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="assets/js/html5shiv.js"></script>
      <script src="assets/js/respond.min.js"></script>
    <![endif]-->

    <!-- Fonts -->
	<link href='http://fonts.googleapis.com/css?family=Lato:400,100,100italic,300,300italic,400italic,700,700italic,900,900italic' rel='stylesheet' type='text/css'>
	<link href='http://fonts.googleapis.com/css?family=Open+Sans:700,400,300,300italic' rel='stylesheet' type='text/css'>
	<!-- Font-Awesome -->
    <link rel="stylesheet" type="text/css" href="/resources/assets/css/font-awesome.css" media="screen" />
    <!--[if lt IE 7]><link rel="stylesheet" type="text/css" href="assets/css/font-awesome-ie7.css" media="screen" /><![endif]-->
    <!-- REVOLUTION BANNER CSS SETTINGS -->
    <link rel="stylesheet" type="text/css" href="/resources/css/fullscreen.css" media="screen" />
	<link rel="stylesheet" type="text/css" href="/resources/rs-plugin/css/settings.css" media="screen" />
    <!-- Picker -->
	<link rel="stylesheet" href="/resources/assets/css/jquery-ui.css" />
	<!-- bin/jquery.slider.min.css -->
	<link rel="stylesheet" href="/resources/plugins/jslider/css/jslider.css" type="text/css">
	<link rel="stylesheet" href="/resources/plugins/jslider/css/jslider.round.css" type="text/css">
    <!-- jQuery -->
    <script src="/resources/assets/js/jquery.v2.0.3.js"></script>
    <!-- scrapbtn css -->
	<link href="/resources/assets/css/scrapBtn.css" rel="stylesheet" media="screen">
	<!-- followbtn css -->
	<link href="/resources/assets/css/followBtn.css" rel="stylesheet" media="screen">
	<!-- likebtn css -->
	<link href="/resources/assets/css/searchLikeBtn.css" rel="stylesheet" media="screen">
	<!-- bin/jquery.slider.min.js -->
	<script type="text/javascript" src="/resources/plugins/jslider/js/jshashtable-2.1_src.js"></script>
	<script type="text/javascript" src="/resources/plugins/jslider/js/jquery.numberformatter-1.2.3.js"></script>
	<script type="text/javascript" src="/resources/plugins/jslider/js/tmpl.js"></script>
	<script type="text/javascript" src="/resources/plugins/jslider/js/jquery.dependClass-0.1.js"></script>
	<script type="text/javascript" src="/resources/plugins/jslider/js/draggable-0.1.js"></script>
	<script type="text/javascript" src="/resources/plugins/jslider/js/jquery.slider.js"></script>
  </head>
  <body id="top" class="thebg" >
	<!-- 로그인 세션  -->
	<c:set var = "userSession" value = '<%= session.getAttribute("login") %>'/>
	<!-- HEADER -->
	<%@include file="../include/header2.jsp" %>
	<!-- BREADCRUMBS -->
	<div class="container breadcrub"><div class="brlines"></div></div>

	<div class="container">
		<div class="container pagecontainer offset-0" style="background:#f2f2f2">	
			
			<!-- LEFT: SIDE FILTERS -->
			<%@include file="../include/search/sidefilter.jsp" %>

			<!-- RIGHT: CONTENT BOX -->
			<div class="rightcontent col-md-9 offset-2" style="background:#fff">
			
				<c:if test="${totalList.totalCnt == 0 }" >
					<!-- 검색결과가 없을경우 -->
					<span class="searchStatus "><b>'${cri.keyword }'</b> 에 대한 검색결과가 없습니다.</span>
				</c:if>
				
				<c:if test="${totalList.totalCnt > 0 }" >				
					<!-- 검색결과가 있을경우 -->
					<span class="searchStatus"><b>'${cri.keyword }'</b> 검색결과</span>	
									
					<!--  컨텐츠 결과가 있을경우 -->
					<c:if test="${totalList.contentsCnt > 0 }" >
						<div class="totalResult" >
							<!-- 컨텐츠 검색결과 타이틀 -->	
							<div class="offset-2" style="padding:20px ">	
								<div class=" left"><b>컨텐츠</b></div>	
								<!-- 컨텐츠 검색결과 갯수가 3개 이상일 경우 더보기 버튼 노출 -->	
								<c:if test="${totalList.contentsCnt > 3 }" >
									<div class=" grey right">
										<form:form commandName="cri" action="contents" method="GET">
											<input type="hidden" name="keyword" value="${cri.keyword}"/>
											<input type="hidden" name="cnt" value="${cri.cnt}"/>
											<button class="more" name="tab" value ="contents" type="submit"> 더보기 〉 </button>
										</form:form>
									</div>
								</c:if>
								<div class="clearfix"></div>
							</div>
							<!-- 컨텐츠 검색결과 리스트 -->
							<c:forEach items="${totalList.contentsList}" var = "esContentsVO" begin="0" end="2">	
								<%@include file="../include/search/contents.jsp" %>	
							</c:forEach>
							<div class="offset-2"><hr></div>
						</div>
					</c:if>		
					
					<!-- 일정 결과가 있을경우 -->					
					<c:if test="${totalList.planCnt > 0 }" >	
						<div class="totalResult">	
							<!-- 일정 검색결과 타이틀 -->
							<div class="offset-2" style="padding:20px ">	
								<div class=" left"><b>일정</b></div>
								<!-- 일정 검색결과 갯수가 3개 이상일 경우 더보기 버튼 노출 -->
								<c:if test="${totalList.planCnt > 3 }" >
									<div class=" grey right">
										<form:form commandName="cri" action="contents" method="GET">
											<input type="hidden" name="keyword" value="${cri.keyword}"/>
											<input type="hidden" name="cnt" value="${cri.cnt}"/>
											<button class="more" name="tab" value ="contents" type="submit"> 더보기 〉 </button>
										</form:form>
									</div>
								</c:if>
								<div class="clearfix"></div>
							</div>
							<!-- 일정 검색결과 리스트 -->	
							<c:forEach items="${totalList.planList}" var = "esPlanVO" begin="0" end="2">
								<%@include file="../include/search/plan.jsp" %>	
							</c:forEach>
							<div class="clearfix"></div>
							<div class="offset-2"><hr></div>
						</div>
					</c:if>
	
					<!-- 회원 결과가 있을경우 -->
					<c:if test="${totalList.memberCnt > 0 }" >
						<div class="members">
							<!-- 회원 검색결과 타이틀 -->
							<div class="offset-2" style="padding:20px ">	
								<div class=" left"><b>회원</b></div>
								<!-- 회원 검색결과 갯수가 3개 이상일 경우 더보기 버튼 노출 -->
								<c:if test="${totalList.memberCnt > 3 }" >
									<div class=" grey right">
										<form:form commandName="cri" action="contents" method="GET">
											<input type="hidden" name="keyword" value="${cri.keyword}"/>
											<input type="hidden" name="cnt" value="${cri.cnt}"/>
											<button class="more" name="tab" value ="contents" type="submit"> 더보기 〉 </button>
										</form:form>
									</div>
								</c:if>
								<div class="clearfix"></div>
							</div>
							<!-- 회원 검색결과 리스트 -->
							<c:forEach items="${totalList.memberList}" var = "esMemberVO" begin="0" end="2">
								<%@include file="../include/search/member.jsp" %>
							</c:forEach>
							<div class="clearfix"></div>
							<div class="offset-2"><hr></div>
						</div>	
					</c:if>
					
				</c:if>
			</div> <!-- END OF RIGHT CONTENT -->
		</div> <!-- END OF CONTENTS CONTAINER -->
	</div> <!-- END OF Container -->
	
	<!-- FOOTER -->
	<%@include file="../include/footer.jsp" %>

    <!-- Javascript -->	
    <script src="/resources/assets/js/js-list4.js"></script>	
    <!-- Custom Select -->
	<script type='text/javascript' src='/resources/assets/js/jquery.customSelect.js'></script>
    <!-- Custom Select -->
	<script type='text/javascript' src='/resources/js/lightbox.js'></script>	
    <!-- JS Ease -->	
    <script src="/resources/assets/js/jquery.easing.js"></script>
    <!-- Custom functions -->
    <script src="/resources/assets/js/functions.js"></script>
    <!-- jQuery KenBurn Slider  -->
    <script type="text/javascript" src="/resources/rs-plugin/js/jquery.themepunch.revolution.min.js"></script>
    <!-- Counter -->	
    <script src="/resources/assets/js/counter.js"></script>	
    <!-- Nicescroll  -->	
	<script src="/resources/assets/js/jquery.nicescroll.min.js"></script>
    <!-- Picker -->	
	<script src="/resources/assets/js/jquery-ui.js"></script>
    <!-- Bootstrap -->	
    <script src="/resources/dist/js/bootstrap.min.js"></script>
	<!-- scrapBtn -->
	<script src="/resources/js/searchScrap.js"></script>
    <!-- likeBtn -->
    <script src="/resources/js/searchLike.js"></script>
    <!-- followBtn -->
    <script src="/resources/js/searchFollow.js"></script>

  </body>

</html>