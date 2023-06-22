<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>비밀번호 찾기</title>
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
				alert("검색어를 입력해주세요.")
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
				alert("이름을 입력해주세요.")
				$("#user_name").focus()
				return;
			}
			if($("#user_id").val() == "")
			{
				alert("아이디를 입력해주세요.")
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
<!-- main 시작 -->
		<div class="main">
			<h1 class="sitename"><a href="index.jsp">Kick off</a></h1>
			<div class="loginbackground">
				<form class="login" name="pw_modify" method="post" id="pw_modify" action="pw_modify.jsp" >
				<table class="logintbl">
					<tr>
						<td>&nbsp;&nbsp;ID
						<br><br>
						<input type="text" class="userid" name="user_id" id="user_id" placeholder="아이디를 입력하세요">
						<br><br>
						</td>
					</tr>
					<tr>
						<td>&nbsp;&nbsp;이름
						<br><br>
						<input type="text" class="userpw" name="user_name" id="user_name" placeholder="이름을 입력하세요">
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<br>
							<input type="button" class="button" value="비밀번호 찾기"  onclick="FindPW();" >
							<br><br>
							<input type="button" class="button" value="취소" onclick="DoBack();">
						</td>
					</tr>					
				</table>
				</form>		
				<table class="tap">
					<tr>
						<td><a href="find_id.jsp">아이디 찾기</a></td>
						<td>&nbsp;|&nbsp;</td>
						<td><a href="join.jsp">회원가입</a></td>
					</tr>
				</table>
			</div>
		</div>
		<br>
		<!-- main 끝 -->
<%@ include file="include/footer.jsp" %>