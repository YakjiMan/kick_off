<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>��й�ȣ ã��</title>
		<link href="css/login.css" rel="stylesheet" type="text/css">
		<link href="css/header.css" rel="stylesheet" type="text/css">
		<link href="css/footer.css" rel="stylesheet" type="text/css">
		<script src="js/jquery-3.6.3.js"></script>
	</head>
	<script>
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
		function FindPW()
		{
			if($("#user_name").val() == "")
			{
				alert("�̸��� �Է����ּ���.")
				$("#user_name").focus()
				return;
			}
			if($("#user_id").val() == "")
			{
				alert("���̵� �Է����ּ���.")
				$("#user_id").focus()
				return;
			}
			$.ajax({
				type : "post",
				url: "findpw_check.jsp",
				data    : 
				{
					user_name : $("#user_name").val(),
					user_id   : $("#user_id").val()
				},
				dataType: "html",
				success : function(data) 
				{
					data = data.trim()
					if(data != "ok")
					{
						alert(data)
						return;
					}
					else
					{
						$("#pw_modify").submit();
					}
				}			
			});
		}
	</script>
	
<%@ include file="include/header.jsp" %>
<!-- main ���� -->
		<div class="main">
			<h1 class="sitename"><a href="index.jsp">Kick off</a></h1>
			<div class="loginbackground">
				<form class="login" name="pw_modify" method="post" id="pw_modify" action="pw_modify.jsp" >
				<table class="logintbl">
					<tr>
						<td>&nbsp;&nbsp;ID
						<br><br>
						<input type="text" class="userid" name="user_id" id="user_id" placeholder="���̵� �Է��ϼ���">
						<br><br>
						</td>
					</tr>
					<tr>
						<td>&nbsp;&nbsp;�̸�
						<br><br>
						<input type="text" class="userpw" name="user_name" id="user_name" placeholder="�̸��� �Է��ϼ���">
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<br>
							<input type="button" class="button" value="��й�ȣ ã��"  onclick="FindPW();" >
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
						<td><a href="join.jsp">ȸ������</a></td>
					</tr>
				</table>
			</div>
		</div>
		<br>
		<!-- main �� -->
<%@ include file="include/footer.jsp" %>