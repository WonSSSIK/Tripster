<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table>
		<c:forEach items="${list}" var="restaurantVO">
			<tr>
				<td>${restaurantVO.restaurantID}</td>
				<td>${restaurantVO.title}</td>
				<td>${restaurantVO.location}</td>
				<td>${restaurantVO.rating}</td>
				<td>${restaurantVO.time}</td>
				<td>${restaurantVO.contents}</td>
				<td>${restaurantVO.tel}</td>
				<td>${restaurantVO.codeID}</td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>