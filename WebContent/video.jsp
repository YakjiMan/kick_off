<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>���� �Խ���</title>
		<link href="css/header.css" rel="stylesheet" type="text/css">
		<link href="css/footer.css" rel="stylesheet" type="text/css">
		<link href="css/video.css" rel="stylesheet" type="text/css">
		<script src="js/jquery-3.6.3.js"></script>
	</head>
<% 
String mcate = request.getParameter("mcate");
if(mcate == null || mcate == "") mcate = "a";

String scate = request.getParameter("scate");
if(scate == null || scate == "") scate = "a";

String keyword = request.getParameter("keyword");
if(keyword == null) keyword = "";

String sort = request.getParameter("sort");
if(sort == null || sort == "") sort = "r";

String search_type = request.getParameter("search_type");
if(search_type == null) search_type = "";

int pageno = 1;
try
{
	pageno = Integer.parseInt(request.getParameter("page"));
}
catch(Exception e){};


ListDTO dto = new ListDTO();
//�������� ������ �Խù��� ������ ���Ѵ�
int list_count = 12;
//��ü�ڷ��� ������ ��ȸ�Ѵ�.
int total = dto.GetVideoTotal(mcate,scate, keyword, search_type);
int max_page = total / list_count; //��ü ������ ����
if(total % list_count != 0) max_page += 1;
//�����ȸ
ArrayList<PostVO> list = dto.GetVideoList(list_count,pageno,mcate,scate,sort,keyword,search_type);
%>
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
	
	function SortR()
	{
		document.location = "video.jsp?mcate=<%= mcate %>&scate=<%= scate %>&search_type=<%= search_type %>&keyword=<%= keyword %>&sort=r";
	}
	function SortP()
	{
		document.location = "video.jsp?mcate=<%= mcate %>&scate=<%= scate %>&search_type=<%= search_type %>&keyword=<%= keyword %>&sort=p";
	}
	function SortV()
	{
		document.location = "video.jsp?mcate=<%= mcate %>&scate=<%= scate %>&search_type=<%= search_type %>&keyword=<%= keyword %>&sort=v";
	}
	function Scate()
	{
		$("#video_list").submit();
	}
	function VideoSearch()
	{
		$("#video_list").submit();
	}
</script>
<%@ include file="include/header.jsp" %>
<!-- main ���� -->
		<div class="main">
			<div class="video_frame">
			<form id="video_list" name="video_list" method="get" action="video.jsp">
				<input type="hidden" name="mcate" value="<%= mcate %>">
				<input type="hidden" name="sort" value="<%= sort %>">
				<div class="video_tabtitle"><a href="video.jsp" class="tabtitle_text">����</a></div>
				<%
				if(keyword != null && !keyword.equals(""))
				{
					%>
					<div class="sort_on">"<%= keyword %>" �� ���� �˻����</div>
					<br><br>
					<%
				}
				%>
				<div class="video_tab">
					<a href="video.jsp?mcate=p" class="<%= mcate.equals("p") ? "tab_on" : "tab" %>" id="mcate_p">�����̾��</a>&nbsp;&nbsp; | &nbsp; 
					<a href="video.jsp?mcate=l" class="<%= mcate.equals("l") ? "tab_on" : "tab" %>" id="mcate_l">�󸮰�</a>&nbsp;&nbsp; | &nbsp; 
					<a href="video.jsp?mcate=s" class="<%= mcate.equals("s") ? "tab_on" : "tab" %>" id="mcate_s">������A</a> &nbsp;&nbsp; | &nbsp;
					<a href="video.jsp?mcate=b" class="<%= mcate.equals("b") ? "tab_on" : "tab" %>" id="mcate_b">�е�������</a>&nbsp;&nbsp; | &nbsp;
					<a href="video.jsp?mcate=c" class="<%= mcate.equals("c") ? "tab_on" : "tab" %>" id="mcate_c">è�Ǿ𽺸���</a>
				</div>
				<%
				try
				{
					if(Integer.parseInt(login_vo.getUser_grade()) > 1)
					{
						%>
						<div class="write_button">
							<span onclick="javascript:document.location='video_write.jsp?mcate=<%= mcate %>&scate=<%= scate %>&sort=<%= sort %>&page=<%= pageno %>'" class="write">�۾���</span>
						</div>
						<%
					}
				}
				catch(Exception e){}
				%>
				<div class="category_frame">
					<select class="category" onchange="Scate();" name="scate" id="scate">
						<option value="a" <%= scate.equals("a") ? "selected" : "" %>>��ü</option>
						<option value="h" <%= scate.equals("h") ? "selected" : "" %>>H/L</option>
						<option value="g" <%= scate.equals("g") ? "selected" : "" %>>�����</option>
						<option value="i" <%= scate.equals("i") ? "selected" : "" %>>���ͺ�</option>
					</select>
				</div>
				<div><hr class="line"></div>
				<div>
					<div class="<%= sort.equals("r") ? "sort_on" : "sort" %>" id="sort_r" onclick="SortR();">�ֽż�</div>
					<div class="<%= sort.equals("p") ? "sort_on" : "sort" %>" id="sort_p" onclick="SortP();">�α��</div>
					<div class="<%= sort.equals("v") ? "sort_on" : "sort" %>" id="sort_v" onclick="SortV();">���̺���</div>
				</div>
				<div><hr class="line"></div>
				<%
				for(PostVO vo : list)
				{
					String title = vo.getPost_title();
					if(title.length() > 17)
					{
						title  = title.substring(0,17);
						title += "...";
					}
					//�˻� Ű���� ���̶���Ʈ 
					if(keyword != null && !keyword.equals(""))
					{
						title = title.replaceFirst(keyword,"<font color=red>" + keyword + "</font>");
					}	
					%>
					<div class="post_frame">
						<a href="video_view.jsp?no=<%= vo.getPost_no() %>&mcate=<%= mcate %>&sort=<%= sort %>&search_type=<%= search_type %>&keyword=<%= keyword %>&page=<%= pageno %>">
							<%
							if(vo.getPost_video().equals("") || vo.getPost_video() == null)
							{
								%>
								<img src="img/news2.jpg" class="img">
								<%
							}
							else
							{
								%>
								<img src="https://img.youtube.com/vi/<%= vo.getPost_video() %>/maxresdefault.jpg" class="img">
								<%
							}
							%>
						</a><br>
						<a href="video_view.jsp" class="post_title"><%= title %></a><br>
						<span class="post_date">����� : <%= vo.getPost_date() %></span><br>
						<span class="post_date">��ȸ�� : <%= vo.getPost_view() %></span><br>
						<span class="post_date">���ƿ� : <%= vo.getLike_count() %></span>
					</div>
					<%
				}
				%>
				<div class="page">
					<table>
						<tr>
							<td style="text-align:center;" colspan="2">
							<% 
							int StartBlock = ((pageno - 1) / 5)*5;
							StartBlock += 1;
							int EndBlock = StartBlock + 5 - 1;
							if(EndBlock > max_page)
							{
								EndBlock = max_page;
							}
							//���� ���� ǥ���ϱ�
							if(StartBlock > 5)
							{
								%>
								<a href="video.jsp?mcate=<%= mcate %>&sort=<%= sort %>&search_type=<%= search_type %>&keyword=<%= keyword %>&page=<%= StartBlock - 1 %>">����</a>
								<%					
							}
							for(int page_no = StartBlock; page_no <= EndBlock; page_no += 1)
							{
								if(page_no == pageno)
								{
									%>
									<span class="page_on"><b><%= page_no %></b></span>&nbsp;
									<%
								}
								else
								{
									%>
									<a class="page_off" href="video.jsp?mcate=<%= mcate %>&sort=<%= sort %>&search_type=<%= search_type %>&keyword=<%= keyword %>&page=<%= page_no %>">
									<%= page_no %>
									</a>&nbsp;
									<%
								}
							}
							//���� ���� ǥ���ϱ�
							if(EndBlock < max_page)
							{
								%>
								<a href="video.jsp?mcate=<%= mcate %>&sort=<%= sort %>&search_type=<%= search_type %>&keyword=<%= keyword %>&page=<%= EndBlock + 1 %>">����</a>
								<%				
							}
							%>
							</td>
						</tr>
					</table>
				</div>
				<div class="post_search">
					<select class="select" name="search_type">
						<option <%= search_type.equals("s_post_title") ? "selected" : "" %> value="s_post_title">����</option>
						<option <%= search_type.equals("s_post_note") ? "selected" : "" %> value="s_post_note">����</option>
						<option <%= search_type.equals("s_all") ? "selected" : "" %> value="s_all">����+����</option>
					</select>
					<input type="text" size="30" placeholder="������ �Է����ּ���." class="search_text" name="keyword" value="<%= keyword %>">
					<span class="search_button" onclick="VideoSearch();">�˻�</span>
				</div>
				</form>
			</div>
		</div>
		<!-- main �� -->
<%@ include file="include/footer.jsp" %>
	