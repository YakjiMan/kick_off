<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>����</title>
		<link href="css/header.css" rel="stylesheet" type="text/css">
		<link href="css/footer.css" rel="stylesheet" type="text/css">
		<link href="css/schedule.css" rel="stylesheet" type="text/css">
		<script src="js/jquery-3.6.3.js"></script>
	</head>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<%
	String mcate = request.getParameter("mcate");
	%>
	<script>
	var prevMode = "";
	function SCseason(obj,mode)	//�������� ��ȸ 
	{
		if(mode == "")
		{
			mode = prevMode;	
		}
		prevMode = mode;
		
		// API�ּҿ� ��ū�� �ִ� schedule_CL.jsp�� ȣ����
		let date_url = "schedule_"+mode+".jsp";
		
		// ���� ��� ���ð��� ������
		if( $(obj).val() != "" )
		{
			// ȣ�� �ּҿ� �Ķ��Ÿ�� �߰���
			date_url += "?month=" + $(obj).val();
		}
			switch(mode) {
			 case "PLSC":  $(".leaguemenu a:nth-child(1)").css({"font-weight":"bold","color":"#ffffff"});
						 $(".leaguemenu a:nth-child(2)").css({"color":"#616161"});
				       	 $(".leaguemenu a:nth-child(3)").css({"color":"#616161"});
				       	 $(".leaguemenu a:nth-child(4)").css({"color":"#616161"});
				       	 $(".leaguemenu a:nth-child(5)").css({"color":"#616161"});
				       	 $(".leaguename").html("<span>�����̾��</span>");
					break;
	   	    case "PDSC":   $(".leaguemenu a:nth-child(1)").css({"color":"#616161"});
	   					 $(".leaguemenu a:nth-child(2)").css({"font-weight":"bold","color":"#ffffff"});
	   			       	 $(".leaguemenu a:nth-child(3)").css({"color":"#616161"});
	   			       	 $(".leaguemenu a:nth-child(4)").css({"color":"#616161"});
	   			       	 $(".leaguemenu a:nth-child(5)").css({"color":"#616161"});
	   			      	 $(".leaguename").html("<span>�󸮰�</span>");
	    			break;
	   	    case "SASC":   $(".leaguemenu a:nth-child(1)").css({"color":"#616161"});
	   					 $(".leaguemenu a:nth-child(2)").css({"color":"#616161"});
	   			       	 $(".leaguemenu a:nth-child(3)").css({"font-weight":"bold","color":"#ffffff"});
	   			       	 $(".leaguemenu a:nth-child(4)").css({"color":"#616161"});
	   			       	 $(".leaguemenu a:nth-child(5)").css({"color":"#616161"});
	   			      	 $(".leaguename").html("<span>������ A</span>");
	    			break;
	   	    case "BL1SC":  $(".leaguemenu a:nth-child(1)").css({"color":"#616161"});
	   					 $(".leaguemenu a:nth-child(2)").css({"color":"#616161"});
	   			         $(".leaguemenu a:nth-child(3)").css({"color":"#616161"});
	   			         $(".leaguemenu a:nth-child(4)").css({"font-weight":"bold","color":"#ffffff"});
	   			         $(".leaguemenu a:nth-child(5)").css({"color":"#616161"});
	   			      	 $(".leaguename").html("<span>�е�������</span>");
	    			break;
	   	    case "CLSC":   $(".leaguemenu a:nth-child(1)").css({"color":"#616161"});
	   					 $(".leaguemenu a:nth-child(2)").css({"color":"#616161"});
	   			       	 $(".leaguemenu a:nth-child(3)").css({"color":"#616161"});
	   			       	 $(".leaguemenu a:nth-child(4)").css({"color":"#616161"});
	   			       	 $(".leaguemenu a:nth-child(5)").css({"font-weight":"bold","color":"#ffffff"});
	   			      	 $(".leaguename").html("<span>è�Ǿ𽺸���</span>");
	    			break;
	   		}
		$.ajax
		({
			type: "get",
			url: date_url,
			dataType:"json",
			success: function(data)
			{	
				var strHTML  = "";
				for(const value of data.matches)
				{
//					console.log(value.utcDate.replaceAll("-",".").substr(5,5));
					if(mode != 'CL')
					{
						/*�����̾�*/
		           		value.awayTeam.tla= value.awayTeam.tla.replaceAll("ARS","�ƽ��� FC")
													  .replace("MCI","��ü���� ��Ƽ FC")
													  .replace("NEW","��ĳ�� ������Ƽ�� FC")
													  .replace("TOT","��Ʈ�� Ȫ���� FC")
													  .replace("MUN","��ü���� ������Ƽ�� FC")
													  .replace("BHA","�����ư �� ȣ�� �˺�� FC")
													  .replace("AVL","�ƽ��� ���� FC")
													  .replace("LIV","����Ǯ FC")
													  .replace("BRE","�귻Ʈ���� FC")
													  .replace("FUL","Ǯ�� FC")
													  .replace("CHE","ÿ�� FC")
													  .replace("CRY","ũ����Ż �Ӹ��� FC")
													  .replace("LEE","���� ������Ƽ�� FC")
													  .replace("WOL","�����ư �������� FC")
													  .replace("WHU","����Ʈ�� ������Ƽ�� FC")
													  .replace("EVE","������ FC")
													  .replace("NOT","���þ� ������Ʈ FC")
													  .replace("BOU","AFC ���ӽ�")
													  .replace("LEI","������ ��Ƽ FC")
													  .replace("SOU","�������� FC")
						/*�󸮰�	*/					  .replace("FCB","FC �ٸ����γ�")
													  .replace("RMA","���� ���帮��")
													  .replace("ATL","Ŭ��� ��Ʋ��Ƽ�� �� ���帮��")
													  .replace("RSO","���� �ҽÿ��ٵ�")
													  .replace("BET","���� ��Ƽ�� �߷��ǿ�")
													  .replace("VIL","��߷��� CF")
													  .replace("ATH","��Ʋ��ƽ Ŭ���")
													  .replace("RAY","��� �ٿ�ī��")
													  .replace("CEL","CA �������")
													  .replace("OSA","RC ��Ÿ �� ���")
													  .replace("GIR","���γ� FC")
													  .replace("MAL","RCD ���丣ī")
													  .replace("SEV","����� FC")
													  .replace("GET","��Ÿ�� CF")
													  .replace("CAD","ī�� CF")
													  .replace("VDD","���� �پߵ�����")
													  .replace("VAL","�߷��þ� CF")
													  .replace("ESP","RCD �����Ĵ�")
													  .replace("ALM","UD �˸޸���")
													  .replace("ELC","��ü CF")
						/*������A*/					  .replace("NAP","SSC ������")
													  .replace("LAZ","SS ��ġ��")
													  .replace("MIL","AC �ж�")
													  .replace("INT","AS �θ�")
													  .replace("ROM","FC ���͹ж�")
													  .replace("ATA","��Ż��Ÿ BC")
													  .replace("JUV","�������� FC")
													  .replace("BOL","���γ� FC 1909")
													  .replace("FIO","ACF �ǿ���Ƽ��")
													  .replace("TOR","�丮�� FC")
													  .replace("UDI","���׼� Į��")
													  .replace("SAS","US ����÷� Į��")
													  .replace("MON","����")
													  .replace("EMP","������ FC")
													  .replace("SAL","����Ƽ�� �췹����Ÿ��")
													  .replace("USL","US ��ü")
													  .replace("SPE","��������")
													  .replace("HVE","���� ���γ� FC")
													  .replace("SAM","UC ����������")
													  .replace("CRE","US ũ����׼�")
						/*�е���*/					  .replace("FCB","FC ���̿��� ����")
													  .replace("BVB","����þ� ����Ʈ��Ʈ")
													  .replace("UNB","FC ��Ͽ� ������")
													  .replace("SCF","SC �����̺θ�ũ")
													  .replace("RBL","RB ������ġ��")
													  .replace("SGE","����Ʈ����Ʈ ����ũǪ��Ʈ")
													  .replace("B04","TSV ���̾� 04 ��������")
													  .replace("M05","FSV ������ 05")
													  .replace("WOB","VfL �������θ�ũ")
													  .replace("BMG","����þ� ����۶�Ʈ����")
													  .replace("SVW","SV ������ �극��")
													  .replace("FCA","FC �ƿ�ũ���θ�ũ")
													  .replace("KOE","FC �븥")
													  .replace("BOC","VfL ����")
													  .replace("TSG","TSG 1899 ȣ������")
													  .replace("BSC","�츣Ÿ BSC")
													  .replace("S04","FC ���� 04")
													  .replace("VFB","VfB ����Ʈ����Ʈ");
						/*�����̾�*/
		           		value.homeTeam.tla= value.homeTeam.tla.replaceAll("ARS","�ƽ��� FC")
													  .replace("MCI","��ü���� ��Ƽ FC")
													  .replace("NEW","��ĳ�� ������Ƽ�� FC")
													  .replace("TOT","��Ʈ�� Ȫ���� FC")
													  .replace("MUN","��ü���� ������Ƽ�� FC")
													  .replace("BHA","�����ư �� ȣ�� �˺�� FC")
													  .replace("AVL","�ƽ��� ���� FC")
													  .replace("LIV","����Ǯ FC")
													  .replace("BRE","�귻Ʈ���� FC")
													  .replace("FUL","Ǯ�� FC")
													  .replace("CHE","ÿ�� FC")
													  .replace("CRY","ũ����Ż �Ӹ��� FC")
													  .replace("LEE","���� ������Ƽ�� FC")
													  .replace("WOL","�����ư �������� FC")
													  .replace("WHU","����Ʈ�� ������Ƽ�� FC")
													  .replace("EVE","������ FC")
													  .replace("NOT","���þ� ������Ʈ FC")
													  .replace("BOU","AFC ���ӽ�")
													  .replace("LEI","������ ��Ƽ FC")
													  .replace("SOU","�������� FC")
						/*�󸮰�	*/					  .replace("FCB","FC �ٸ����γ�")
													  .replace("RMA","���� ���帮��")
													  .replace("ATL","Ŭ��� ��Ʋ��Ƽ�� �� ���帮��")
													  .replace("RSO","���� �ҽÿ��ٵ�")
													  .replace("BET","���� ��Ƽ�� �߷��ǿ�")
													  .replace("VIL","��߷��� CF")
													  .replace("ATH","��Ʋ��ƽ Ŭ���")
													  .replace("RAY","��� �ٿ�ī��")
													  .replace("CEL","CA �������")
													  .replace("OSA","RC ��Ÿ �� ���")
													  .replace("GIR","���γ� FC")
													  .replace("MAL","RCD ���丣ī")
													  .replace("SEV","����� FC")
													  .replace("GET","��Ÿ�� CF")
													  .replace("CAD","ī�� CF")
													  .replace("VDD","���� �پߵ�����")
													  .replace("VAL","�߷��þ� CF")
													  .replace("ESP","RCD �����Ĵ�")
													  .replace("ALM","UD �˸޸���")
													  .replace("ELC","��ü CF")
						/*������A*/					  .replace("NAP","SSC ������")
													  .replace("LAZ","SS ��ġ��")
													  .replace("MIL","AC �ж�")
													  .replace("INT","AS �θ�")
													  .replace("ROM","FC ���͹ж�")
													  .replace("ATA","��Ż��Ÿ BC")
													  .replace("JUV","�������� FC")
													  .replace("BOL","���γ� FC 1909")
													  .replace("FIO","ACF �ǿ���Ƽ��")
													  .replace("TOR","�丮�� FC")
													  .replace("UDI","���׼� Į��")
													  .replace("SAS","US ����÷� Į��")
													  .replace("MON","����")
													  .replace("EMP","������ FC")
													  .replace("SAL","����Ƽ�� �췹����Ÿ��")
													  .replace("USL","US ��ü")
													  .replace("SPE","��������")
													  .replace("HVE","���� ���γ� FC")
													  .replace("SAM","UC ����������")
													  .replace("CRE","US ũ����׼�")
						/*�е���*/					  .replace("FCB","FC ���̿��� ����")
													  .replace("BVB","����þ� ����Ʈ��Ʈ")
													  .replace("UNB","FC ��Ͽ� ������")
													  .replace("SCF","SC �����̺θ�ũ")
													  .replace("RBL","RB ������ġ��")
													  .replace("SGE","����Ʈ����Ʈ ����ũǪ��Ʈ")
													  .replace("B04","TSV ���̾� 04 ��������")
													  .replace("M05","FSV ������ 05")
													  .replace("WOB","VfL �������θ�ũ")
													  .replace("BMG","����þ� ����۶�Ʈ����")
													  .replace("SVW","SV ������ �극��")
													  .replace("FCA","FC �ƿ�ũ���θ�ũ")
													  .replace("KOE","FC �븥")
													  .replace("BOC","VfL ����")
													  .replace("TSG","TSG 1899 ȣ������")
													  .replace("BSC","�츣Ÿ BSC")
													  .replace("S04","FC ���� 04")
													  .replace("VFB","VfB ����Ʈ����Ʈ");	
					}
					
					if(value.homeTeam.tla == null) { console.log("find null"); continue; };
					
					strHTML += "<tr><td class='date'id='date'>"+value.utcDate.replaceAll("-",".").substr(5,5)+"</td>"
					strHTML += "<td id='date'>"+value.utcDate.replaceAll("-",".").substr(11,5)+"</td>"
					strHTML += "<td class='home'>"+value.homeTeam.tla+"&nbsp;&nbsp;"
					strHTML += "<img src="+value.homeTeam.crest+"></td>"
					strHTML += "<td class='middle'>"+((value.score.fullTime.home == null) ? "" : value.score.fullTime.home) +"&nbsp;"+((value.score.fullTime.home == null) ? "vs" : ":")+"&nbsp;"+((value.score.fullTime.away == null) ? "" : value.score.fullTime.away )+"</td>"
					strHTML += "<td class='away'><img src="+value.awayTeam.crest+">"
					strHTML += "&nbsp;&nbsp;"+value.awayTeam.tla+"</td></tr>"
					
				}
				const html_for_null = "<tr><td colspan='100'>������ �����ϴ�</td></tr>";
				
				$(".leaguedata").html("<table class='leaguetable' border='1'>"
						+"<tr>"
						+"<th>��¥</th>"
						+"<th>�ð�</th>"
						+"<th colspan='3'>���</th>"
						+"</tr>"
						+ ((strHTML == "")? html_for_null : strHTML ) +"</table>"
				);
				$(".date").each(function(){
					var tempString = $(this).text();
					var date_rows = $(".date").filter(function(){
						return $(this).text() == tempString; });

					if(date_rows.length > 1){
						date_rows.eq(0).attr("rowspan", date_rows.length);
						date_rows.not(":eq(0)").remove();
					}
					
				});
			}
		});
		
	}
	
	 //���۽� ����
	$(document).ready(function(){
			SCseason(this,'<%=mcate%>');
	}); 
	
	//�˻�
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
	//null ��ġȯ
	function isEmpty(value){
	    if(value == null || value.length === 0) {
	           return "";
	     } else{
	            return value;
	     }
	}
	
	function DateReset()
	{
		$("#selectBox").val("none");
	}
	</script>
<%@ include file="include/header.jsp" %>
<!-- main ���� -->
		<div class="main">
			<div class="leaguemenu">
				<a class="PLButton" onclick="SCseason(this,'PL'); DateReset();">�����̾��</a>&nbsp;|&nbsp;
				<a class="laButton" onclick="SCseason(this,'PD'); DateReset();">�󸮰�</a>&nbsp;|&nbsp;
				<a class="SAButton" onclick="SCseason(this,'SA'); DateReset();">������ A</a>&nbsp;|&nbsp;
				<a class="buButton" onclick="SCseason(this,'BL1'); DateReset();">�е�������</a>&nbsp;|&nbsp;
				<a class="UEFAButton" onclick="SCseason(this,'CL'); DateReset();">è�Ǿ𽺸���</a>
				<a class="PLButton" onclick="SCseason(this,'PL')">�����̾��</a>&nbsp;|&nbsp;
				<a class="laButton" onclick="SCseason(this,'PD')">�󸮰�</a>&nbsp;|&nbsp;
				<a class="SAButton" onclick="SCseason(this,'SA')">������ A</a>&nbsp;|&nbsp;
				<a class="buButton" onclick="SCseason(this,'BL1')">�е�������</a>&nbsp;|&nbsp;
				<a class="UEFAButton" onclick="SCseason(this,'CL')">è�Ǿ𽺸���</a>
				<a class="PLButton" onclick="SCseason(this,'PLSC')">�����̾��</a>&nbsp;|&nbsp;
				<a class="laButton" onclick="SCseason(this,'PDSC')">�󸮰�</a>&nbsp;|&nbsp;
				<a class="SAButton" onclick="SCseason(this,'SASC')">������ A</a>&nbsp;|&nbsp;
				<a class="buButton" onclick="SCseason(this,'BL1SC')">�е�������</a>&nbsp;|&nbsp;
				<a class="UEFAButton" onclick="SCseason(this,'CLSC')">è�Ǿ𽺸���</a>
			</div>
			<hr>
			<div class="selectFrame">
				 <b>2022-23����</b><br>
					<select name="selectBox" id="selectBox" onchange="SCseason(this,'');">
						<option value="none">===</option>
						<option value="2023-06">23-6</option>
						<option value="2023-05">23-5</option>
						<option value="2023-04">23-4</option>
						<option value="2023-03">23-3</option>
						<option value="2023-02">23-2</option>
						<option value="2023-01">23-1</option>
						<option value="2022-12">22-12</option>
						<option value="2022-11">22-11</option>
						<option value="2022-10">22-10</option>
						<option value="2022-09">22-9</option>
						<option value="2022-08">22-8</option>
						<option value="2022-07">22-7</option>
						<option value="2022-06">22-6</option>
					</select>
				<b>��</b>
			</div>
			<div class="leaguename">
			</div>
			<div class="leaguedata">
			</div>
		</div>
	<!-- main �� -->
<%@ include file="include/footer.jsp" %>