<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>로그인</title>
		<link href="css/login.css" rel="stylesheet" type="text/css">
		<link href="css/header.css" rel="stylesheet" type="text/css">
		<link href="css/footer.css" rel="stylesheet" type="text/css">
		<script src="js/jquery-3.6.3.js"></script>
	</head>
	<script>
	
		function Dologin()
		{
			if($(".userid").val() == ""){
				alert("아이디를 입력해주세요.")
				$(".userid").focus();
				return false;
			}
			if($(".userpw").val() == ""){
				alert("비밀번호를 입력해주세요.")
				$(".userpw").focus();
				return false;
			}
			return true;
		}
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
	</script>
	
<%@ include file="include/header.jsp" %>
<!-- main 시작 -->
		<div class="main">
			<h1 class="sitename"><a href="index.jsp">Kick off</a></h1>
			<div class="loginbackground">
				<form class="login" name="login" method="post" action="loginok.jsp" >
				<table class="logintbl">
					<tr>
						<td>&nbsp;&nbsp;ID
						<br><br>
						<input type="text" class="userid" name="user_id" placeholder="아이디를 입력하세요">
						<br><br>
						</td>
					</tr>
					<tr>
						<td>&nbsp;&nbsp;PASSWORD
						<br><br>
						<input type="password" class="userpw" name="user_pw" placeholder="비밀번호를 입력하세요">
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<br>
							<input type="submit" class="button" value="로그인하기"  onclick="return Dologin();" >
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
						<td><a href="find_pw.jsp">비밀번호 찾기</a></td>
						<td>&nbsp;|&nbsp;</td>
						<td><a href="join.jsp">회원가입</a></td>
					</tr>
				</table>
			</div>
		</div>
		<br>
		<!-- main 끝 -->
<%@ include file="include/footer.jsp" %>