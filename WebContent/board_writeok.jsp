<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="kickoff.vo.*" %>
<%@ page import="kickoff.dto.*" %>
<%@ page import="java.util.*" %> 
<%@ page import="java.net.URLEncoder" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>��ϿϷ�</title>
		<link href="css/header.css" rel="stylesheet" type="text/css">
		<link href="css/footer.css" rel="stylesheet" type="text/css">
		<link href="css/board_writeok.css" rel="stylesheet" type="text/css">
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
	</script>
	<%@ include file="include/header.jsp" %>
<!-- main ���� -->

		<%@ page import="java.io.*" %>    
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<!-- ������ ��� �Ǵ°� -------------------------- -->
<%
String dir = application.getRealPath("");
int cutter = dir.indexOf(".metadata");
dir  = dir.substring(0,cutter);
dir  = dir.replace("\\","\\\\");
dir += "kick_off\\\\WebContent\\\\download";
String uploadPath = dir;
//���ε尡 ������ �ִ� ���� ũ�⸦ �����Ѵ�.
int size = 10 * 1024 * 1024;

MultipartRequest multi = new MultipartRequest(request,uploadPath,size,"EUC-KR",new DefaultFileRenamePolicy());

request.setCharacterEncoding("EUC-KR");

String title      = multi.getParameter("title");
String no         = multi.getParameter("no");
String note       = multi.getParameter("note");
String mcate      = multi.getParameter("mcate");
String type       = multi.getParameter("type");
String pname      = "";
String oname      = "";

//÷�������� ������ �߰��Ѵ�.
//���ε�� ���ϸ��� ��´�.
Enumeration files = multi.getFileNames();
if(files != null)
{
	String fileid = (String) files.nextElement();
	String filename = (String) multi.getFilesystemName("attach");
	if(filename != null)
	{
		oname = filename;
		pname = UUID.randomUUID().toString();

		//���� �̸� ����
		String orgName = uploadPath + "\\" + oname;
		String newName = uploadPath + "\\" + pname;		

		File srcFile    = new File(orgName);
		File targetFile = new File(newName);
		srcFile.renameTo(targetFile);
		
		out.println("���� ���ϸ� : " + orgName + "<br>");
		out.println("�ٲ� ���ϸ� : " + newName + "<br>");
	}
}

PostVO vo = new PostVO();
vo.setUser_no(login_vo.getUser_no());
vo.setPost_title(title);
vo.setPost_note(note);
vo.setPost_type("b");
vo.setPost_mcate(mcate);
vo.setPost_pname(pname);
vo.setPost_oname(oname);

PostDTO dto = new PostDTO();
dto.Insert(vo);

response.sendRedirect("board_view.jsp?no=" + vo.getPost_no());
%>
		<!-- main �� -->
<%@ include file="include/footer.jsp" %>