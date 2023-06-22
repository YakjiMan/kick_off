<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="kickoff.vo.*" %>
<%@ page import="kickoff.dto.*" %>
<%@ page import="java.util.*" %> 
<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	<title>�Խñ� ����</title>
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
		if(confirm("������ �ٿ�ε� �Ͻðڽ��ϱ�?") == true)
		{
			alert("������ �ٿ�޽��ϴ�");
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
			alert("�˻�� �Է����ּ���.")
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
				// ����� ���������� �̷�������� �� �Լ��� Ÿ�Եȴ�.
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
				// ����� ���������� �̷�������� �� �Լ��� Ÿ�Եȴ�.
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
			alert("����� �Է��ϼ���");
			$("#reply_note").focus();
			return;
		}
		if(confirm("����� ����Ͻðڽ��ϱ�?") == true)
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
					// ����� ���������� �̷�������� �� �Լ��� Ÿ�Եȴ�.
					data = data.trim();
					alert(data)
					ReplyList();
				}
			});
		}
	}
	function DeleteReply(reply_no)
	{
		if(confirm("�ش� ����� �����Ͻðڽ��ϱ�?") == false)
		{
			return;
		}
		$.ajax({
			type    : "get",
			url     : "reply_delete.jsp?reply_no=" + reply_no,
			dataType: "html",
			success : function(data) 
			{	
				// ����� ���������� �̷�������� �� �Լ��� Ÿ�Եȴ�.
				ReplyList();
			}
		});
	}
	function DoBlind()
	{
		if("<%= vo.getPost_blind() %>" == "n")
		{
			if(confirm("�ش� �Խù��� �����ε��Ͻðڽ��ϱ�?") == false)
			{
				return;
			}
		}
		else
		{
			if(confirm("�ش� �Խù��� �����ε� ���� �Ͻðڽ��ϱ�?") == false)
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
				// ����� ���������� �̷�������� �� �Լ��� Ÿ�Եȴ�.
				data = data.trim()
				alert(data)
				location.reload();
			}
		});
	}
	
	</script>
<!-- main ���� -->
		<div class="main">
		<br>
		<table class="top_level_table">
			<tr>
				<td>
					<table class="main_title_table">
						<tr>
							<td class="board_title" width="80%"><a href="board_list.jsp?no=1">�����Խ���</a></td>
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
							<td align="left">�ۼ��� : <%= vo.getUser_nick() %></td>
							<td align="right">��ȸ�� : <%= vo.getPost_view() %></td>
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
					÷������ : <a href="board_down.jsp?no=<%= no %>" onclick="return AttachDown();"><%= vo.getPost_oname() %></a>   
					<table class="reply_table">
						<tr>
							<td class="table_data_reply">&nbsp;���(<%= vo.getReply_count() %>)</td>
							<td class="table_data_tree_button">
							<%
							if(login_vo != null)
							{
								if(login_vo.getUser_no().equals(vo.getUser_no()) || login_vo.getUser_grade().equals("3"))
								{
								%>
								<input type="button" class="middle_modify_button" value="����" onclick="location.href='board_modify.jsp?no=<%= no %>&type=<%= type %>&page=<%= pageno %>&mcate=<%= mcate %>&oname=<%= vo.getPost_oname() %>'">
								<input type="button" class="middle_delete_button" value="����" onclick="alert('�����Ͻðڽ��ϱ�?');location.href='board_delete.jsp?no=<%= no %>&page=<%= pageno %>&mcate=<%= mcate %>&type=<%= type %>'">
								<input type="button" class="middle_list_button" value="���" onclick="location.href='board_list.jsp?page=<%= pageno %>&mcate=<%= mcate %>'">
								<%
								}
							}else
							{
								%>
								<input type="button" class="middle_list_button1" value="���" onclick="location.href='board_list.jsp?page=<%= pageno %>&mcate=<%= mcate %>'">
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
<!-- main �� -->
<%@ include file="include/footer.jsp" %>