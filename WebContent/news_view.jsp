<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>���� �ۺ���</title>
		<link href="css/header.css" rel="stylesheet" type="text/css">
		<link href="css/footer.css" rel="stylesheet" type="text/css">
		<link href="css/news_view.css" rel="stylesheet" type="text/css">
		<script src="js/jquery-3.6.3.js"></script>
	</head>
	
	<%@ include file="include/header.jsp" %>
<%
	String mcate  = request.getParameter("mcate");
	String sort   = request.getParameter("sort");
	String pageno = request.getParameter("page");
	String no = request.getParameter("no");
	String keyword = request.getParameter("keyword");
	String search_type = request.getParameter("search_type");
	
	if(mcate == null || mcate == "") mcate = "p";
	if(keyword == null) keyword = "";
	if(sort == null || sort == "") sort = "r";
	if(search_type == null) search_type = "";
	if(pageno == null) pageno = "1";
	
	if(no == null || no.equals(""))
	{
		response.sendRedirect("news.jsp");
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
	function DoDelete()
	{
		if(confirm("�Խù��� �����Ͻðڽ��ϱ�?") == false)
		{
			return;
		}
		document.location = "news_delete.jsp?no=<%= no %>&mcate=<%= mcate %>&pageno=<%= pageno %>&sort=<%= sort %>&keyword=<%= keyword %>&search_type=<%= search_type %>";
	}
	function DoBack()
	{
		document.location = "news.jsp?no=<%= no %>&mcate=<%= mcate %>&pageno=<%= pageno %>&sort=<%= sort %>&keyword=<%= keyword %>&search_type=<%= search_type %>"
	}
	function DoModify()
	{
		document.location = "news_modify.jsp?no=<%= no %>&mcate=<%= mcate %>&pageno=<%= pageno %>&sort=<%= sort %>&keyword=<%= keyword %>&search_type=<%= search_type %>"
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
	</script>
<!-- main ���� -->
		<div class="main">
			<div class="news_frame">
				<div class="news_tabtitle"><a href="news.jsp" class="tabtitle_text">����</a></div>
				<div class="news_tab">
					<p class="<%= vo.getPost_mcate().equals("p") ? "tab_on" : "tab" %>" id="mcate_p">�����̾��</p>&nbsp;&nbsp; | &nbsp; 
					<p class="<%= vo.getPost_mcate().equals("l") ? "tab_on" : "tab" %>" id="mcate_l">�󸮰�</p>&nbsp;&nbsp; | &nbsp; 
					<p class="<%= vo.getPost_mcate().equals("c") ? "tab_on" : "tab" %>" id="mcate_c">è�Ǿ𽺸���</p>&nbsp;&nbsp; | &nbsp;
					<p class="<%= vo.getPost_mcate().equals("b") ? "tab_on" : "tab" %>" id="mcate_b">�е�������</p>&nbsp;&nbsp; | &nbsp;
					<p class="<%= vo.getPost_mcate().equals("s") ? "tab_on" : "tab" %>" id="mcate_s">������A</p> 
				</div>
				<div class="title"><%= vo.getPost_title() %></div>
				<div class="date">�ۼ��� : <%= vo.getPost_date() %></div>
				<div class="date">��ó : <%= vo.getPost_source() %></div>
				<div class="view">��ȸ�� : <%= vo.getPost_view() %></div>
				<div class="img_frame">
					<%
					if(vo.getPost_oname().equals("") || vo.getPost_oname() == null)
					{
						%>
						<img src="img/news2.jpg" class="img">
						<%
					}
					else
					{
						%>
						<img src="file/<%= vo.getPost_oname() %>" class="img">
						<%
					}
					%>
				</div>
				<div>
					<%= vo.getPost_note() %>
				</div>
				<div class="writer">�ۼ��� : <%= vo.getUser_name() %></div>
				<div class="emo_frame">
					<div id="like_hate"></div>
				</div>
				<%
				if(login_vo != null)
				{
					if(login_vo.getUser_grade().equals("3") || login_vo.getUser_no().equals(vo.getUser_no()))
					{
						%>
						<div><a href="javascript:DoDelete();" class="delete_button">�ۻ���</a></div>
						<%
					}
					if(login_vo.getUser_no().equals(vo.getUser_no()))
					{
						%>
						<div><a href="javascript:DoModify();" class="modify_button">�ۼ���</a></div>
						<%
					}
				}
				%>
				<div class="nav_list"><a href="javascript:DoBack();" class="nav_list">���</a></div>
				<div></div>
				<div class="reply_count">��� (<%= vo.getReply_count() %>)</div>
				<div id="reply_list"></div>
			</div>
		</div>
		<!-- main �� -->
<%@ include file="include/footer.jsp" %>