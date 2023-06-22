<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="kickoff.vo.*" %>
<%@ page import="kickoff.dto.*" %>
<%@ page import="java.util.*" %> 
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>�Խ���</title>
		<link href="css/header.css" rel="stylesheet" type="text/css">
		<link href="css/footer.css" rel="stylesheet" type="text/css">
		<link href="css/board_list.css" rel="stylesheet" type="text/css">
		<script src="js/jquery-3.6.3.js"></script>
	</head>
	<%@ include file="include/header.jsp" %>
	<%
	String mcate = request.getParameter("mcate");
	
	String type = request.getParameter("type");
	if(mcate == null || mcate == "") type = "b";

	String keyword = request.getParameter("keyword");
	if(keyword == null) keyword = "";
	
	String search_type = request.getParameter("search_type");
	if(search_type == null) search_type = "";
	
	String sort = request.getParameter("sort");
	if(sort == null || sort == "") sort = "r";
	
	int pageno = 1;
	try
	{
		pageno = Integer.parseInt(request.getParameter("page"));
	}
	catch(Exception e){};

	ListDTO dto = new ListDTO();
	
	int common_count = 10; //�ϹݰԽñ� ����
	int notice_count = 3;  //�����Խñ� ����
	
	//��ü�ڷ��� ������ ��ȸ�Ѵ�.
	int total = dto.GetTotal("b","f", keyword, search_type);
	//System.out.println("total = " + total);   == 6
	int max_page = total / common_count; //��ü ������ ����
	//System.out.println("common_count = " + common_count);   == 10
	if(total % common_count != 0) max_page += 1;
	//System.out.println("max_page = " + max_page);   == 1
	
	//�����ȸ
	ArrayList<PostVO> clist = dto.GetBoardList(common_count,pageno,"f",sort,keyword,search_type);
	ArrayList<PostVO> nlist = dto.GetBoardList(notice_count,1,"n","r","","");
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
			document.location = "board_list.jsp?mcate=<%= mcate %>&search_type=<%= search_type %>&keyword=<%= keyword %>&sort=r";
		}
		function SortP()
		{
			document.location = "board_list.jsp?mcate=<%= mcate %>&search_type=<%= search_type %>&keyword=<%= keyword %>&sort=p";
		}
		function SortV()
		{
			document.location = "board_list.jsp?mcate=<%= mcate %>&search_type=<%= search_type %>&keyword=<%= keyword %>&sort=v";
		}
		
		function BoardSearch()
		{
			$("#board_list").submit();
		}
		
</script>
	<div class="main">
	<br>
	<form method="get" id="board_list" name="board_list" action="board_list.jsp">
		<input type="hidden" name="mcate" value="<%= mcate %>">
		<input type="hidden" name="sort" value="<%= sort %>">
	<table class="top_level_table">
		<tr>
			<td>
				<table class="small_table">
					<tr>
						<td class="board_title"><a href="board_list.jsp">�����Խ���</a></td>
					</tr>
				</table>
				<%
				if(keyword != null && !keyword.equals(""))
				{
					%>
					<br>
					<div class="keyword">"<%= keyword %>" �� ���� �˻����</div>
					<br>
					<%
				}
				%>
				<hr class="horizon">
				<table class="select_table">
					<tr>
						<td>
							<div>
								<div class="<%= sort.equals("r") ? "sort_on" : "sort" %>" id="sort_r" onclick="SortR();">�ֽż�</div>
								<div class="<%= sort.equals("p") ? "sort_on" : "sort" %>" id="sort_p" onclick="SortP();">�α��</div>
								<div class="<%= sort.equals("v") ? "sort_on" : "sort" %>" id="sort_v" onclick="SortV();">���̺���</div>
							</div>
		                </td>
		                <%
						if(login_vo != null)
						{
							if(Integer.parseInt(login_vo.getUser_grade()) >= 1)
							{
								%>
								<td>
									<input type="button" class="write_button" value="�۾���" onclick="location.href='board_write.jsp?sort=<%= sort %>&page=<%= pageno %>&mcate=<%= mcate %>'">
								</td>
								<%
							}
						}
						%>
					</tr>
				</table>
				<hr class="horizon">
				<table class="column_table">
					<tr class="column">
						<th>��ȣ</th>
						<th>����</th>
						<th>�ۼ���</th>
						<th>��¥</th>
						<th>���ƿ�</th>
						<th>��ȸ��</th>
					</tr>
					<%
					for(PostVO vo : nlist)
					{
						String title = vo.getPost_title();
						if( title.length() > 22)
						{
							title = title.substring(0,22);
							title += "...";
						}
						%>
						<tr>
							<td class="manager_column"><%= vo.getPost_no() %></td>
							<td>&nbsp;<a href="board_view.jsp?no=<%= vo.getPost_no() %>&mcate=n&type=<%= type %>&page=<%= pageno %>&search_type=<%= search_type %>&keyword=<%= keyword %>"><%= vo.getPost_title() %></a><a class="board_list">(<%= vo.getReply_count() %>)</a></td>
							<td class="manager_column"><%= vo.getUser_nick() %></td>
							<td class="manager_column"><%= vo.getPost_date() %></td>
							<td align="center">&nbsp;</td>
							<td align="center">&nbsp;</td>
						</tr>
						<%
					}
					%>
					<tr><td colspan="100"><hr class="horizon"></td></tr>
					<%
					PostVO vo = new PostVO();
					
						for(PostVO cvo : clist)
						{
							String title = cvo.getPost_title();
							if( title.length() > 22)
							{
								title = title.substring(0,22);
								title += "...";
							}
							
							String note = cvo.getPost_note();
							if(note.length() > 20)
							{
								note  = note.substring(0,20);
								note += "...";
							}
							//�˻� Ű���� ���̶���Ʈ 
							if(keyword != null && !keyword.equals(""))
							{
								title = title.replaceFirst(keyword,"<font color=red>" + keyword + "</font>");
							}
							
							if(cvo.getPost_blind().equals("y"))
							{
								%>
								<tr>
									<td class="board_text"><%= cvo.getPost_no() %></td>
									<%
									String mLink = "board_view.jsp";
									mLink += "?no=" + cvo.getPost_no();
									mLink += "&mcate=f";
									mLink += "&type=" + type;
									mLink += "&page=" + pageno;
									mLink += "&search_type=" + search_type;
									mLink += "&keyword=" + keyword;
									if(login_vo != null && login_vo.getUser_grade().equals("3"))
									{
										%>
										<td>&nbsp;<a href="<%= mLink %>"><%= title %>(�����ε��)</a><a class="board_list">(<%= cvo.getReply_count() %>)</a></td>
										<%
									}
									else
									{
										title = "�����ε� ó���� �Խù��Դϴ�.";
										%>
										<td>&nbsp;<a href="javascript:alert('�Խù��� ��ȸ �� �� �����ϴ�.')"><%= title %></a><a class="board_list"></a></td>
										<%
									}
									%>
									<td class="board_text"><%= cvo.getUser_nick() %></td>
									<td class="board_text"><%= cvo.getPost_date() %></td>
									<td class="board_text"><%= cvo.getLike_count() %></td>
									<td class="board_text"><%= cvo.getPost_view() %></td>
								</tr>
								<%								
							}
							else
							{
								String mLink = "board_view.jsp";
								mLink += "?no=" + cvo.getPost_no();
								mLink += "&mcate=f";
								mLink += "&type=" + type;
								mLink += "&page=" + pageno;
								mLink += "&search_type=" + search_type;
								mLink += "&keyword=" + keyword;
								%>
								<tr>
									<td class="board_text"><%= cvo.getPost_no() %></td>
									<td>&nbsp;<a href="<%= mLink %>"><%= title %></a><a class="board_list">(<%= cvo.getReply_count() %>)</a></td>
									<td class="board_text"><%= cvo.getUser_nick() %></td>
									<td class="board_text"><%= cvo.getPost_date() %></td>
									<td class="board_text"><%= cvo.getLike_count() %></td>
									<td class="board_text"><%= cvo.getPost_view() %></td>
								</tr>
								<%
							}
						}
					
					%>
				</table>
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
								<a href="board_list.jsp?mcate=<%= mcate %>&sort=<%= sort %>&search_type=<%= search_type %>&keyword=<%= keyword %>&page=<%= StartBlock - 1 %>">����</a>
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
									<a class="page_off" href="board_list.jsp?mcate=<%= mcate %>&sort=<%= sort %>&search_type=<%= search_type %>&keyword=<%= keyword %>&page=<%= page_no %>">
									<%= page_no %>
									</a>&nbsp;
									<%
								}
							}
							//���� ���� ǥ���ϱ�
							if(EndBlock < max_page)
							{
								%>
								<a href="board_list.jsp?mcate=<%= mcate %>&sort=<%= sort %>&search_type=<%= search_type %>&keyword=<%= keyword %>&page=<%= EndBlock + 1 %>">����</a>
								<%				
							}
							%>
							</td>
						</tr>
					</table>
				</div>
				<table class="post_search">
					<tr>
						<td>
							<select class="select" name="search_type">                                                                                                             
				                <option <%= search_type.equals("s_post_title") ? "selected" : "" %> value="s_post_title">����</option>
								<option <%= search_type.equals("s_post_note") ? "selected" : "" %> value="s_post_note">����</option>
								<option <%= search_type.equals("s_all") ? "selected" : "" %> value="s_all">����+����</option>        
							</select>
							<input class="search_text" type="text" id="search1" name="keyword" value="<%= keyword %>">                                                     
							<input class="search_button" type="submit" value="�˻�" onclick="BoardSearch();">  
						</td>
					</tr>
				</table> 	
			</td>
		</tr>
	</table>
	</form>   
	<br>	
	</div>
<%@ include file="include/footer.jsp" %>
	