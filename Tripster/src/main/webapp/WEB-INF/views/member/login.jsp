<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�α���</title>
</head>
<body>
	
	<form action="/member/loginPost" method="post">
		<div>
			<input type="text" name="memberEmail" placeholder="Email�� �Է��ϼ���"/>
		</div>
		<div>
			<input type="password" name="memberPassword" placeholder="��й�ȣ�� �Է��ϼ���"/>
		</div>
		<div class="row">
			<div>
				<div>
					<label>
						<input type="checkbox" name="useCookie">Remember Me
					</label>
				</div>
			</div>
			<div>
				<button type="submit">�α���</button>
			</div>
		</div>
	</form>
	
</body>
</html>