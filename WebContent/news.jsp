<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>�����Խ���</title>				
		<link href="css/header.css" rel="stylesheet" type="text/css">
		<link href="css/footer.css" rel="stylesheet" type="text/css">
		<link href="css/news.css" rel="stylesheet" type="text/css">
		<script src="js/jquery-3.6.3.js"></script>
	</head>
<%@ include file="include/header.jsp" %>
<% 
String mcate = request.getParameter("mcate");
if(mcate == null || mcate == "") mcate = "a";

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
int list_count = 10;
//��ü�ڷ��� ������ ��ȸ�Ѵ�.
int total = dto.GetTotal("n",mcate, keyword, search_type);
int max_page = total / list_count; //��ü ������ ����
if(total % list_count != 0) max_page += 1;
//�����ȸ
ArrayList<PostVO> list = dto.GetNewsList(list_count,pageno,mcate,sort,keyword,search_type);
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
		document.location = "news.jsp?mcate=<%= mcate %>&search_type=<%= search_type %>&keyword=<%= keyword %>&sort=r";
	}
	function SortP()
	{
		document.location = "news.jsp?mcate=<%= mcate %>&search_type=<%= search_type %>&keyword=<%= keyword %>&sort=p";
	}
	function SortV()
	{
		document.location = "news.jsp?mcate=<%= mcate %>&search_type=<%= search_type %>&keyword=<%= keyword %>&sort=v";
	}
	
	function NewsSearch()
	{
		$("#news_list").submit();
	}
</script>
<!-- main ���� -->
		<div class="main">
			<div class="news_frame">
				<form id="news_list" name="news_list" method="get" action="news.jsp">
				<input type="hidden" name="mcate" value="<%= mcate %>">
				<input type="hidden" name="sort" value="<%= sort %>">
				<div class="news_tabtitle"><a href="news.jsp" class="tabtitle_text">����</a></div>
				<%
				if(keyword != null && !keyword.equals(""))
				{
					%>
					<div class="keyword">"<%= keyword %>" �� ���� �˻����</div>
					<br><br>
					<%
				}
				%>
				<div class="news_tab">
					<a href="news.jsp?mcate=p" class="<%= mcate.equals("p") ? "tab_on" : "tab" %>" id="mcate_p">�����̾��</a>&nbsp;&nbsp; | &nbsp; 
					<a href="news.jsp?mcate=l" class="<%= mcate.equals("l") ? "tab_on" : "tab" %>" id="mcate_l">�󸮰�</a>&nbsp;&nbsp; | &nbsp; 
					<a href="news.jsp?mcate=s" class="<%= mcate.equals("s") ? "tab_on" : "tab" %>" id="mcate_s">������A</a> &nbsp;&nbsp; | &nbsp;
					<a href="news.jsp?mcate=b" class="<%= mcate.equals("b") ? "tab_on" : "tab" %>" id="mcate_b">�е�������</a>&nbsp;&nbsp; | &nbsp;
					<a href="news.jsp?mcate=c" class="<%= mcate.equals("c") ? "tab_on" : "tab" %>" id="mcate_c">è�Ǿ𽺸���</a>
				</div>
				<%
				try
				{
					if(Integer.parseInt(login_vo.getUser_grade()) > 1)
					{
						%>
						<div class="write_button">
							<span onclick="javascript:document.location='news_write.jsp?mcate=<%= mcate %>&sort=<%= sort %>&page=<%= pageno %>'" class="write">�۾���</span>
						</div>
						<%
					}
				}
				catch(Exception e){}
				%>
				<div><hr class="line"></div>
				<div>
					<div class="<%= sort.equals("r") ? "sort_on" : "sort" %>" id="sort_r" onclick="SortR();">�ֽż�</div>
					<div class="<%= sort.equals("p") ? "sort_on" : "sort" %>" id="sort_p" onclick="SortP();">�α��</div>
					<div class="<%= sort.equals("v") ? "sort_on" : "sort" %>" id="sort_v" onclick="SortV();">���̺���</div>
				</div>
				<div><hr class="line"></div>
				<div class="news_main">
					<table>
					<%
					for(PostVO vo : list)
					{
						String title = vo.getPost_title();
						if(title.length() > 30)
						{
							title  = title.substring(0,30);
							title += "...";
						}
						
						String note = vo.getPost_note();
						if(note.contains(keyword) && !keyword.equals(""))
						{
							int size = note.indexOf(keyword);
							if(size > 50) 
							{
								if(note.length() > 50 && size + 35 < note.length())
								{
									note  = note.substring(size-15,size+35);
									note += "...";
								}
								else if(note.length() > 50 && size + 35 > note.length())
								{
									note  = note.substring(size-15);
								}
							}
							else
							{
								if(note.length() > 50)
								{
									note  = note.substring(0,50);
									note += "...";
								}
							}
						}
						else
						{
							if(note.length() > 50)
							{
								note  = note.substring(0,50);
								note += "...";
							}
						}
						
						//��ó �ڸ���
						String source  = vo.getPost_source();
						if(source.length() > 14)
						{
							source  = source.substring(0,14);
							source += "";
						}
						
						//�˻� Ű���� ���̶���Ʈ 
						if(keyword != null && !keyword.equals(""))
						{
							if(search_type.equals("s_all"))
							{
								title = title.replaceFirst(keyword,"<font color=red>" + keyword + "</font>");
								note  = note.replaceFirst(keyword,"<font color=red>" + keyword + "</font>");
							}
							else if(search_type.equals("s_post_title"))
							{
								title = title.replaceFirst(keyword,"<font color=red>" + keyword + "</font>");
							}
							else
							{
								note  = note.replaceFirst(keyword,"<font color=red>" + keyword + "</font>");
							}
						}
						
						%>
						<tr>
							<td rowspan="5" class="thumframe">
								<a href="news_view.jsp?no=<%= vo.getPost_no() %>&mcate=<%= mcate %>&sort=<%= sort %>&search_type=<%= search_type %>&keyword=<%= keyword %>&page=<%= pageno %>">
								<%
								if(vo.getPost_oname().equals("") || vo.getPost_oname() == null)
								{
									%>
									<img src="img/news2.jpg" class="thumbnail">
									<%
								}
								else
								{
									%>
									<img src="file/<%= vo.getPost_oname() %>" class="thumbnail">
									<%
								}
								%>
								</a>
							</td>
						</tr>								
						<tr>
							<td class="title_td">
								<b>
									<a href="news_view.jsp?no=<%= vo.getPost_no() %>&mcate=<%= mcate %>&sort=<%= sort %>&search_type=<%= search_type %>&keyword=<%= keyword %>&page=<%= pageno %>" class="news_title">
										<%= title %>
									</a>
								</b>
							</td>
							<td class="view_td">��ȸ�� : <%= vo.getPost_view() %> &nbsp;&nbsp;&nbsp;���ƿ� : <%= vo.getLike_count() %></td>
						</tr>
						<tr>
							<td class="text_td"><%= note %></td>
						</tr>
						<tr>
							<td class="date_td"><%= vo.getPost_date() %></td>
						</tr>
						<tr>
							<td class="date_td">��ó : <%= source %></td>
						</tr>
						<%
					}
					%>
					</table>
				</div>
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
								<a href="news.jsp?mcate=<%= mcate %>&sort=<%= sort %>&search_type=<%= search_type %>&keyword=<%= keyword %>&page=<%= StartBlock - 1 %>">����</a>
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
									<a class="page_off" href="news.jsp?mcate=<%= mcate %>&sort=<%= sort %>&search_type=<%= search_type %>&keyword=<%= keyword %>&page=<%= page_no %>">
									<%= page_no %>
									</a>&nbsp;
									<%
								}
							}
							//���� ���� ǥ���ϱ�
							if(EndBlock < max_page)
							{
								%>
								<a href="news.jsp?mcate=<%= mcate %>&sort=<%= sort %>&search_type=<%= search_type %>&keyword=<%= keyword %>&page=<%= EndBlock + 1 %>">����</a>
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
					<span class="search_button" onclick="NewsSearch();">�˻�</span>
				</div>
				</form>
			</div>
		</div>
		<br><br>	
		<!-- main �� -->
<%@ include file="include/footer.jsp" %>