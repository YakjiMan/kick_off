<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>�α���</title>
		<link href="css/login.css" rel="stylesheet" type="text/css">
		<link href="css/header.css" rel="stylesheet" type="text/css">
		<link href="css/footer.css" rel="stylesheet" type="text/css">
		<script src="js/jquery-3.6.3.js"></script>
	</head>
	<script>
	
		function Dologin()
		{
			if($(".userid").val() == ""){
				alert("���̵� �Է����ּ���.")
				$(".userid").focus();
				return false;
			}
			if($(".userpw").val() == ""){
				alert("��й�ȣ�� �Է����ּ���.")
				$(".userpw").focus();
				return false;
			}
			return true;
		}
		function DoSearch()
		{
			if($(".searcher").val() == "")
			{
				alert("�˻�� �Է����ּ���.")
				return;
			}
			else
			{
				$("#top_search").submit();
			}
		}
		function DoBack()
		{
			document.location = "index.jsp";
		}
	</script>
	
<%@ include file="include/header.jsp" %>
<!-- main ���� -->
		<div class="main">
			<h1 class="sitename"><a href="index.jsp">Kick off</a></h1>
			<div class="loginbackground">
				<form class="login" name="login" method="post" action="loginok.jsp" >
				<table class="logintbl">
					<tr>
						<td>&nbsp;&nbsp;ID
						<br><br>
						<input type="text" class="userid" name="user_id" placeholder="���̵� �Է��ϼ���">
						<br><br>
						</td>
					</tr>
					<tr>
						<td>&nbsp;&nbsp;PASSWORD
						<br><br>
						<input type="password" class="userpw" name="user_pw" placeholder="��й�ȣ�� �Է��ϼ���">
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<br>
							<input type="submit" class="button" value="�α����ϱ�"  onclick="return Dologin();" >
							<br><br>
							<input type="button" class="button" value="���" onclick="DoBack();">
						</td>
					</tr>					
				</table>
				</form>		
				<table class="tap">
					<tr>
						<td><a href="find_id.jsp">���̵� ã��</a></td>
						<td>&nbsp;|&nbsp;</td>
						<td><a href="find_pw.jsp">��й�ȣ ã��</a></td>
						<td>&nbsp;|&nbsp;</td>
						<td><a href="join.jsp">ȸ������</a></td>
					</tr>
				</table>
			</div>
		</div>
		<br>
		<!-- main �� -->
<%@ include file="include/footer.jsp" %>