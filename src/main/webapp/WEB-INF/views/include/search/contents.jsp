<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="offset-2" >
<div class="col-md-4 offset-0 listitem2" >
	<a href="/contents/${esContentsVO.category_id }/${esContentsVO.contents_id}">
		<img src="${esContentsVO.contents_thumbnail}"/>
	</a>
</div>
<div class="col-md-8 offset-0" style="border:1px solid #e6e6e6" >
	<div class="itemlabel4" style="height:208px;">
		<div class="labelright">
			<span class=" green size18"><b>${esContentsVO.contents_review_cnt}</b></span><span class="green size14"> Review</span><br>
					
				<div class="progress-custom" style="position:relative;">	
					<div style="width:100%; height:100%; background-color:silver"></div>						
							<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" style="width: ${esContentsVO.contents_rating*20}%; position:absolute; top:0;"></div>
					<img src="/resources/images/star.png" style="position:absolute; top:0; width:100%"/>
				</div>
			
			<span class="size11 grey ">${esContentsVO.contents_rating} Stars</span><br><br>
			<span class="margtop20 green size18"><b>0</b></span><span class="green size14"> Plan</span><br>
			<span class="size11 grey">${esContentsVO.contents_scrap_cnt} Scrap</span><br><br>
		 	
	 		<button class="bookbtn mt1" value="${esContentsVO.contents_id}" check="1" session="${empty userSession }" >스크랩</button>		
 		
		</div>
		<div class="labelleft">			
			
			<c:choose>
				<c:when test="${esContentsVO.category_id == 1 }" > <span class="size14 label label-warning">${esContentsVO.category_value_kor}</span></c:when>
				<c:when test="${esContentsVO.category_id == 2 }" > <span class="size14 label label-primary">${esContentsVO.category_value_kor}</span></c:when>
				<c:otherwise> <span class="size14 label label-default"> ${esContentsVO.category_value_kor}</span></c:otherwise>
			</c:choose>
			<span class="size18">	
				<a href="/contents/${esContentsVO.category_id}/${esContentsVO.contents_id}">
					&nbsp;<b>${esContentsVO.contents_title} </b>
				</a>
			</span><br>
			<span class="margtop10 size12 grey glyphicon glyphicon-map-marker"></span><span class="grey size12"> ${esContentsVO.contents_location} </span> 
			<div class="line4 wh80percent"></div>
			<span class="opensans size14 grey">
				
			<c:forEach var="keyword" items="${esContentsVO.contents_keyword}">
			
			     	<span style="display:inline-block; border-radius:15px; border:1px solid #ddd; padding:5px 10px; margin:5px 2px">
			     		<b># </b> ${keyword}
			     		</span>
				     
				</c:forEach>

					
				</span> 
			</div>
			<div class="clearfix"></div>
		</div>
	</div>
</div>
<div class="clearfix"></div>
<div class="offset-2" style="padding-top:30px"></div>