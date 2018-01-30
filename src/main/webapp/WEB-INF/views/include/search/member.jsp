<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<div class="col-md-4" style="margin-bottom:40px">
	<!-- CONTAINER-->
	<div class="carscontainer" style="border:1px solid #e6e6e6">
		<div class="center">
			<a href=""><img src="/resources/updates/update1/img/cars/car04.jpg"/></a>
		</div>
								
		<div class="purchasecontainer"  >
			<div class="offset-2 left bold" style="margin-left: 10px;padding-top:5px;">${esMemberVO.member_name}</div>		
			
			<button class="btn followButton" value="${esMemberVO.member_id}" check="1" rel="6" style="width:80px;float:right; margin-right:20px;">Follow</button>	
			
			<script>
				var followBtn = $("button[value="+${esMemberVO.member_id}+"]");
				var session = ${empty userSession };
				if(session != true){
					let followIdList = ${followIdList };
					console.log(followIdList);
					for(let i=0;i<followIdList.length;i++){
						if(followBtn.val() == followIdList[i]){
							followBtn.addClass("following");
						};
					};
				};
			</script>

			<div class="clearfix"></div>
		</div>
		<div style="padding-top:20px"></div>
		<div class="clearfix"></div>
	</div>
	<!-- END OF CONTAINER-->
</div>