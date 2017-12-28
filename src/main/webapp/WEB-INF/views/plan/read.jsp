<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
  	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Plan Detail</title>
   <script type="text/javascript" src="/resources/js/upload.js"></script>
   	<script src="https://code.jquery.com/jquery-2.0.3.js"></script>
<script>
 $(document).ready(function() {
	var formObj = $("form[role='form']")
	$("#modify").click(function(){
		alert('클릭했당 ');
		formObj.attr("action","/plan/update");
		formObj.attr("method","GET");
		formObj.submit();
	});

	 
 	$("#remove").click(function(){
 		formObj.attr("action","/plan/delete");
 		formObj.submit();
 	})
		 
  });
</script>
<style>
#modDiv {
	width: 300px;
	height: 100px;
	background-color: gray;
	position: absolute;
	top: 50%;
	left: 50%;
	margin-top: -50px;
	margin-left: -150px;
	padding: 10px;
	z-index: 1000;
}

.pagination li {
	list-style: none;
	float: left;
	padding: 3px;
	border: 1px solid blue;
	margin: 3px;
}

.pagination li a {
	margin: 3px;
	text-decoration: none;
}

.aboutarrow {
    display: block;
    float: left;
    position: relative;
   /*  left: 50%; */
    bottom: -40px;
    width: 25px;
    height: 13px;
    background: url(/resources/images/about-arrow.png) no-repeat;
}
</style>
	
</head>
	<%@include file="/WEB-INF/views/include/header2.jsp"%>

	<!-- CONTENT -->
	<div class="container">

		
		<div class="container mt25 offset-0">
			
			
			<!-- CONTENT -->
			<div class="col-md-12 pagecontainer2 offset-0">
				<div class="hpadding50c">
					<p class="lato size30 slim">${plan.planTitle}</p>
					
					<span class="lato size15 grey bold">전체일정 : ${plan.planStartDate } ~ ${plan.planEndDate }</span>
					<p class="aboutarrow"></p>
				</div>
				<div class="line3"></div>
				
				<div class="hpadding50c">
					
			

					<!-- LEFT IMG -->
					<div class="col-md-12 cpdd01 grey2">
						
						<script>
						//------------------------------
						//CaroufredSell
						//------------------------------
						jQuery(document).ready(function(jQuery){

							jQuery("#foo5").carouFredSel({
								width: "100%",
								height: 407,
								items: {
									visible: 5,
									minimum: 1,
									start: 2
								},
								scroll: {
									items: 1,
									easing: "easeInOutQuad",
									duration: 400,
									pauseOnHover: true
								},
								auto: true,
								prev: {
									button: "#prev_btn",
									key: "left"
								},
								next: {
									button: "#next_btn",
									key: "right"
								},				
								swipe: true
							});
						});
							
						</script>
						<!-- Carousel -->
						<br/>
						<form role="form"  method="post">
							<input type="hidden" name="planID" value="${plan.planID }">

							<c:set var = "date" value=""/>
							<c:forEach items="${plan.planDetailVO }" var="planDetailVO">
								<c:if test="${planDetailVO.planDetailDate ne date}">
									<span class="lato size22 dark bold">${planDetailVO.planDetailDate }</span><br/>
									<c:set var = "date" value="${planDetailVO.planDetailDate }"/>
									<div class="line4"></div>
								</c:if>
								<span class="lato size18 dark bold">-${planDetailVO.planDetailStartTime}:</span>
								<span class="lato size18 blue bold"> ${planDetailVO.title }</span><br/>
						
								<c:if test="${planDetailVO.memoVO.memoContents ne null }">
									Memo Contents: ${planDetailVO.memoVO.memoContents }
								</c:if>
						
								<c:if test="${planDetailVO.memoVO.memoPictureVO ne null}">
									<div class="wrapper2">
										<div class="list_carousel2">
											<ul id="foo5">
												<c:forEach items="${planDetailVO.memoVO.memoPictureVO }" var="pictureVO">
													<c:choose>
						       							<c:when test="${pictureVO.memoPictureName ne null}">
						           					 		<li>
																<a href="/displayFile?fileName=${pictureVO.memoPictureName }"><img src="/displayFile?fileName=${pictureVO.memoPictureName }" style="width: 100%; max-width: 760px; vertical-align: middle"/></a>
															</li>
						       							</c:when>
						       							<c:otherwise>
						          							<li>
																<a href="/resources/planImg/noimg.png"><img src="/resources/planImg/noimg.png" style="width: 100%; vertical-align: middle"/></a>
															</li>
						       							</c:otherwise>
						  							</c:choose> 	
											</c:forEach>
										</ul>
										<div class="clearfix"></div>
										<a id="prev_btn" class="xprev" href="#"><img src="/resources/images/spacer.png" alt=""/></a>
										<a id="next_btn" class="xnext" href="#"><img src="/resources/images/spacer.png" alt=""/></a>
									</div>
								</div>
								<div class="line4"></div>
							</c:if>
							<br/><br/>
						</c:forEach> 
					
						<button class="btn-search4 margtop20" id="remove">REMOVE</button>
						<button class="bluebtn margtop20" id="modify">MODIFY</button>

					</form>
					<div class="line4"></div>
				
				<!-- 댓글 -->
					<div>
						<span class="size14 dark bold">Comments</span>
						<div class="line4"></div>
						<!-- <input type="hidden" name="memberID" value=1 id="newReplyWriter"> -->
						<textarea class="form-control" rows="3" name="planReplyContents" id="newReplyText" ></textarea><br/>

						<button onclick="errorMessage()" type="submit" class="btn-search5" id="replyAddBtn">Post <span class="glyphicon glyphicon-arrow-down"></span></button>
						<br/><br/><br/>
					</div>
						
						<div id="count">

						</div>
						<div id="replies">

						</div>
						<div class="clearfix"></div>
						<div class="line4"></div>
						<span></span>
						<ul class="pagination">
						</ul>
						<br/>
						<br/>
			
					<!-- END OF LEFT IMG -->

					<!-- END OF IMG RIGHT TEXT -->
					<div class="clearfix"></div>
					<br/><br/>

				</div>
				
			</div>
				
			<div class="clearfix"></div><br/><br/>
			</div>
			<!-- END CONTENT -->			
		</div>
	</div>
	<!-- END OF CONTENT -->
	
	<!-- 댓글 수졍 및 삭제 모달  -->
	<div id='modDiv' style="display: none;">
		<div class='modal-title'></div>
		<div>
			<input type='text' id='replytext'>
		</div>
		<div>
			<button type="button" id="replyModBtn">Modify</button>
			<button type="button" id="replyDelBtn">DELETE</button>
			<button type="button" id='closeBtn'>Close</button>
		</div>
	</div>
	
	<%@include file="/WEB-INF/views/include/footer.jsp"%>
<script>
	var planID = ${plan.planID};
	getPageList(1);
	
	function getPageList(page){
		$.getJSON("/plan/reply/read/"+planID+"/"+page, function(data){
			var count = data.reply.length;
			
			var str ='';
			var countstr ='';
			$(data.reply).each(function(){
				str+= "<br><div class='wh20percent left textleft'><div class='circlewrap2'><img alt='' class='circleimg' src='/resources/images/user-avatar.jpg'></div></div>"
				+'<div class="wh80percent right "><span class="lblue bold">'+this.memberName+'</span><br/>'+
				'<span class="replyspan" data-rno="'+this.planReplyID+'">'+this.planReplyContents+'</br><span class="grey size12"><a href="#" class="grey">Modify</a></span></span></div><div class="clearfix"></div><div class="line4">'
			
			});
			
			countstr='<span class="size14 dark bold">'+count+' comments</span><div class="line4"></div>';
			
			$("#count").html(countstr);
			$("#replies").html(str);
			printPaging(data.pageMaker);
		});
	}
	
	
	function printPaging(pageMaker) {
		var str = "";
		if (pageMaker.prev) {
			str += "<li><a href='" + (pageMaker.startPage - 1)
					+ "'> << </a></li>";
		}
		for (var i = pageMaker.startPage, len = pageMaker.endPage; i <= len; i++) {
			var strClass = pageMaker.cri.curPage == i ? 'class=active' : '';
			str += "<li "+strClass+"><a href='"+i+"'>" + i + "</a></li>";
		}
		if (pageMaker.next) {
			str += "<li><a href='" + (pageMaker.endPage + 1)
					+ "'> >> </a></li>";
		}
		$('.pagination').html(str);
	}

	var replyPage = 1;
	

	$(".pagination").on("click", "li a", function(event) {
		event.preventDefault();
		replyPage = $(this).attr("href");
		getPageList(replyPage);
	});
	
	//댓글 추가
	$("#replyAddBtn").on("click", function(){
		/* var replyer = $("#newReplyWriter").attr("value"); */
		var replytext = $("#newReplyText").val();
		
		$.ajax({
			type:'post',
			url:'/plan/reply/register',
			contentType : "application/json",
			dataType : 'text',
			data : JSON.stringify({
				planID : planID,
				planReplyContents : replytext
			}),
			success : function(result) {
				if (result == 'SUCCESS') {
					$("#newReplyText").val('');
					alert("등록 되었습니다.");
					getPageList(replyPage);
				}
			}
		});
	});
	
	
	//mod버튼 클릭 시,
	$("#replies").on("click", ".replyspan a", function(){
		var reply = $(this).parent().parent();
		console.log(reply.get(0));
		var rno = reply.attr("data-rno");
		var replytext = reply.text();

		
 		$(".modal-title").html(rno);
		$("#replytext").val(replytext);
		$("#modDiv").show("slow"); 	
	});
	
	//삭제 호출		
	$("#replyDelBtn").on("click",function(){
		var rno = $(".modal-title").html();
		var replytext = $("#replytext").val();
		
		$.ajax({
			type:'post',
			url:'/plan/reply/delete/'+rno,
			contentType : "application/json",
			dataType : 'text',
			success : function(result) {
				if (result == 'SUCCESS') {
					alert("삭제 되었습니다.");
					$("#modDiv").hide("slow");
					getPageList(replyPage);
				}
			}
		});
	});
	
	//수정 버튼 클릭.
	$("#replyModBtn").on("click", function() {
		var rno = $(".modal-title").html();
		var replytext = $("#replytext").val();
		alert(rno);
		$.ajax({
			type : 'post',
			url : '/plan/reply/update',
			contentType : "application/json",
			dataType : 'text',
			data : JSON.stringify({
				planReplyID: rno,
				planReplyContents : replytext
			}),
			success : function(result) {
				console.log("result: " + result);
				if (result == 'SUCCESS') {
					alert("수정 되었습니다.");
					$("#modDiv").hide("slow");
					getPageList(replyPage);
				}
			}
		}); 
	});
	
	//닫기 버튼 클릭 시,
	$("#closeBtn").on("click", function() {
		$("#modDiv").attr("style", "display: none;");
	});
</script>
</html>