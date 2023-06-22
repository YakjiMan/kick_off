<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="kickoff.dto.*" %>
<%@ page import="kickoff.vo.*" %>
<%@ page import="java.util.*" %>
<%
UserinfoVO login_vo = (UserinfoVO)session.getAttribute("login");
if(login_vo == null) login_vo = null;
%>
<script>
	function DoLogout()
	{
		if(confirm("로그아웃 하시겠습니까?") != true) return;
		document.location = "logout.jsp";
	}
</script>
<style>	
	  @import url('https://fonts.googleapis.com/css2?family=Hahmlet&display=swap');
</style>
	<body>
		<div class="header">
			<div class="logo">
				<a href="index.jsp"><img class="logoimg" src="img/ball.png"></a>
			</div>
			<div class="logo2">
				<a href="index.jsp" class="logotext">kick off</a>
			</div>
			<form method="get" action="searchpage.jsp" id="top_search" name="top_search">
				<input type="hidden" name="search_type" value="s_all">
				<div class="search">
					<input type="text" class="searcher" name="tsearch_note" placeholder="검색어를 입력해주세요.">
					<img class="searchicon" src="img/search.png" onclick="DoSearch();">
				</div>
			</form>
			<%
			if(login_vo == null)
			{
				%>
				<div class="mymenu">
					<a href="login.jsp"><p>로그인</p></a>	
				</div>
				<div class="infoimg">
					<a href="join.jsp"><p>회원가입</p></a>
				</div>
				<% 
			}
			else if(login_vo.getUser_grade().equals("3"))
			{
				%>
				<div class="mymenu">
					<p><%= login_vo.getUser_nick() %></p>	
				</div>
				<div class="infoimg">
					<a href="javascript:DoLogout();"><p>로그아웃</p></a>
				</div>
				<div class="infoimg">
					<a href="admin.jsp"><p>회원관리</p></a>
				</div>
			<%
			}
			else
			{
				%>
				<div class="mymenu">
					<p><%= login_vo.getUser_nick() %></p>	
				</div>
				<div class="infoimg">
					<a href="javascript:DoLogout();"><p>로그아웃</p></a>
				</div>
				<div class="infoimg">
					<a href="member_check.jsp"><p>마이페이지</p></a>
				</div>
			<%
			}
			%>
		</div>
		<div class="menutop">
			<nav class="menu">
				<a href="news.jsp">뉴스</a>
				<a href="video.jsp">영상</a>
				<a href="rank1.jsp">순위</a>
				<a href="result_schedule.jsp">결과/일정</a>
				<a href="board_list.jsp">게시판</a>
			</nav>
		</div>