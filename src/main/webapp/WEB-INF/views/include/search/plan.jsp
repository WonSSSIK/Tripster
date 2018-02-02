<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>


<div class="col-md-4 planList">
	<div class="listitem ">
		<div class="profile">
			<a  class="member-profile" href="/member/viewMember?memberID=${esPlanVO.member_id }" style="background-image: url('${esPlanVO.member_picture}');"></a>				
			<span class="profile-name">${esPlanVO.member_name}</span>
			<div class="clearfix"></div>
		</div>
		<a href="/plan/read?planID=${esPlanVO.plan_id}"><img src="${esPlanVO.memo_picture_name}" ></a>
	</div>

	<div class="itemlabel2 ">
	
		<a class="plan-title"><b>${esPlanVO.plan_title}</b></a>
		<div>
			<span class="plan-status">댓글 0 / 좋아요 ${esPlanVO.plan_like_cnt} </span>			
			<button class="btn likeButton" onmouseenter="likemouseover('${userSession.memberID }',$(this))" value="${esPlanVO.plan_id}">좋아요</button>
			<div class="clearfix"></div>
		</div>
	
		<script>
			var likebtn = $("button[value="+${esPlanVO.plan_id}+"]");
			var session = ${empty userSession };
			if(session != true){
				let likeIdList = ${likeIdList };
				for(let i=0;i<likeIdList.length;i++){
					if(likebtn.val() == likeIdList[i]){
						likebtn.addClass("like");
					};
				};
			};
		</script>
	</div>
	<div class="clearfix"></div>
</div>