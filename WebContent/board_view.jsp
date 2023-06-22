<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="kickoff.vo.*" %>
<%@ page import="kickoff.dto.*" %>
<%@ page import="java.util.*" %> 
<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	<title>게시글 보기</title>
	<link href="css/header.css" rel="stylesheet" type="text/css">
	<link href="css/footer.css" rel="stylesheet" type="text/css">
	<link href="css/board_view.css" rel="stylesheet" type="text/css">
	<script src="js/jquery-3.6.3.js"></script>
</head>
<%@ include file="include/header.jsp" %>
<%
	String no     = request.getParameter("no");
	String mcate  = request.getParameter("mcate");
	if(mcate == null || mcate == "") mcate = "f";
	String sort   = request.getParameter("sort");
	String pageno = request.getParameter("page");
	String type    = request.getParameter("type");
	String keyword = request.getParameter("keyword");
	String search_type = request.getParameter("search_type");
	String oname = request.getParameter("oname");
	
	if(no == null || no.equals(""))
	{
		response.sendRedirect("board_list.jsp");
		return;
	}
	
	PostDTO dto = new PostDTO();
	PostVO  vo  = dto.Read(no, true);
%>
<script>
	window.onload = function()
	{
		Like_Hate();
		ReplyList();
	}
	
	function AttachDown()
	{
		if(confirm("파일을 다운로드 하시겠습니까?") == true)
		{
			alert("파일을 다운받습니다");
		}
		else
		{
			return false;
		}
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
		
	function Like_Hate()
	{
		$.ajax({
			type : "get",
			url: "post_like_hate.jsp?no=<%= no %>",
			dataType: "html",
			success : function(data) 
			{
				$("#like_hate").html(data);
			}			
		});
	}
	function DoLike()
	{
		$.ajax({
			type    : "post",
			url     : "like_hateOnOff.jsp",
			data    : 
			{
				post_no : "<%= no %>",
				like_hate : "l"
			},
			dataType: "html",
			success : function(data) 
			{	
				// 통신이 성공적으로 이루어졌을때 이 함수를 타게된다.
				data = data.trim();
				if(data != "")
				{
					alert(data);
				}
				Like_Hate();
			}
		});
	}
	function DoHate()
	{
		$.ajax({
			type    : "post",
			url     : "like_hateOnOff.jsp",
			data    : 
			{
				post_no : "<%= no %>",
				like_hate : "h"
			},
			dataType: "html",
			success : function(data) 
			{	
				// 통신이 성공적으로 이루어졌을때 이 함수를 타게된다.
				data = data.trim();
				if(data != "")
				{
					alert(data);
				}
				Like_Hate();
			}
		});
	}
	
	function ReplyList()
	{
		$.ajax({
			type : "get",
			url: "reply.jsp?no=<%= no %>",
			dataType: "html",
			success : function(data) 
			{
				$("#reply_list").html(data);
			}			
		});
	}
	function AddReply()
	{
		if($("#reply_note").val() == "")
		{
			alert("댓글을 입력하세요");
			$("#reply_note").focus();
			return;
		}
		if(confirm("댓글을 등록하시겠습니까?") == true)
		{
			$.ajax({
				type    : "post",
				url     : "reply_write.jsp",
				data    : 
				{
					no : "<%= no %>",
					reply_note : $("#reply_note").val()
				},
				dataType: "html",
				success : function(data) 
				{	
					// 통신이 성공적으로 이루어졌을때 이 함수를 타게된다.
					data = data.trim();
					alert(data)
					ReplyList();
				}
			});
		}
	}
	function DeleteReply(reply_no)
	{
		if(confirm("해당 댓글을 삭제하시겠습니까?") == false)
		{
			return;
		}
		$.ajax({
			type    : "get",
			url     : "reply_delete.jsp?reply_no=" + reply_no,
			dataType: "html",
			success : function(data) 
			{	
				// 통신이 성공적으로 이루어졌을때 이 함수를 타게된다.
				ReplyList();
			}
		});
	}
	function DoBlind()
	{
		if("<%= vo.getPost_blind() %>" == "n")
		{
			if(confirm("해당 게시물을 블라인드하시겠습니까?") == false)
			{
				return;
			}
		}
		else
		{
			if(confirm("해당 게시물을 블라인드 해제 하시겠습니까?") == false)
			{
				return;
			}
		}
		$.ajax({
			type    : "get",
			url     : "blindok.jsp?no=" + <%= no %>,
			dataType: "html",
			success : function(data) 
			{	
				// 통신이 성공적으로 이루어졌을때 이 함수를 타게된다.
				data = data.trim()
				alert(data)
				location.reload();
			}
		});
	}
	
	</script>
<!-- main 시작 -->
		<div class="main">
		<br>
		<table class="top_level_table">
			<tr>
				<td>
					<table class="main_title_table">
						<tr>
							<td class="board_title" width="80%"><a href="board_list.jsp?no=1">자유게시판</a></td>
							<td>
								<%
								if(login_vo != null)
								{
									if(Integer.parseInt(login_vo.getUser_grade()) == 3)
									{
										%>
										<table>
											<tr>
												<%
												if(vo.getPost_blind().equals("n"))
												{
													%>
													<td>
														<img src="img/manager1.png" class="blind_icon" onclick="DoBlind();">
													</td>
													<%
												}
												else
												{
													%>
													<td>
														<img src="img/manager2.png" class="blind_icon" onclick="DoBlind();">
													</td>
													<%
												}
												%>
											</tr>
										</table>
										<%
									}
								}
								%>
							</td>
						</tr>
					</table>
					<table class="post_title_table">
						<tr class="board_list_title">
							<td class="title"><%= vo.getPost_title() %></td>
							<td align="right"><%= vo.getPost_date() %></td>
						</tr>
					</table>
					<table class="privacy_table">
						<tr class="id_line">
							<td align="left">작성자 : <%= vo.getUser_nick() %></td>
							<td align="right">조회수 : <%= vo.getPost_view() %></td>
						</tr>
					</table>
					<br><br><br>
					<table>
						<tr>
							<td height="250px">
								<%
								String note = vo.getPost_note();
								note = note.replace("<p>","");
								note = note.replace("</p>","");
								note = note.replace("\n","\n<br>");	
								out.println(note);
								%>
							</td>
						</tr>
					</table>
					<div class="emo_frame">
						<div id="like_hate"></div>
					</div>	
					첨부파일 : <a href="board_down.jsp?no=<%= no %>" onclick="return AttachDown();"><%= vo.getPost_oname() %></a>   
					<table class="reply_table">
						<tr>
							<td class="table_data_reply">&nbsp;댓글(<%= vo.getReply_count() %>)</td>
							<td class="table_data_tree_button">
							<%
							if(login_vo != null)
							{
								if(login_vo.getUser_no().equals(vo.getUser_no()) || login_vo.getUser_grade().equals("3"))
								{
								%>
								<input type="button" class="middle_modify_button" value="수정" onclick="location.href='board_modify.jsp?no=<%= no %>&type=<%= type %>&page=<%= pageno %>&mcate=<%= mcate %>&oname=<%= vo.getPost_oname() %>'">
								<input type="button" class="middle_delete_button" value="삭제" onclick="alert('삭제하시겠습니까?');location.href='board_delete.jsp?no=<%= no %>&page=<%= pageno %>&mcate=<%= mcate %>&type=<%= type %>'">
								<input type="button" class="middle_list_button" value="목록" onclick="location.href='board_list.jsp?page=<%= pageno %>&mcate=<%= mcate %>'">
								<%
								}
							}else
							{
								%>
								<input type="button" class="middle_list_button1" value="목록" onclick="location.href='board_list.jsp?page=<%= pageno %>&mcate=<%= mcate %>'">
								<%
							}
							%>
								
							</td>
						</tr>
					</table>
					<div id="reply_list"></div>
					<br>
				</td>
			</tr>
		</table>
		<br>
		</div>
<!-- main 끝 -->
<%@ include file="include/footer.jsp" %>