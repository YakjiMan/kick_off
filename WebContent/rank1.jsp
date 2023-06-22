<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>�����̾�</title>
		<link href="css/header.css" rel="stylesheet" type="text/css">
		<link href="css/footer.css" rel="stylesheet" type="text/css">
		<link href="css/rank.css" rel="stylesheet" type="text/css">
		<script src="js/jquery-3.6.3.js"></script>
	</head>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
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
	//���۽� ����
	$(document).ready(function(){
		rank2('2_PL');
	});
	//è�Ǿ𽺸��� ajax ȣ��
	function rank1(){
		$.ajax
		({
			type:"get",
			url:"rank1_CL.jsp",
			dataType:"json",
			success: function(data)
			{	
				$(".leaguemenu a:nth-child(1)").css({"color":"#616161"});
				$(".leaguemenu a:nth-child(2)").css({"color":"#616161"});
               	$(".leaguemenu a:nth-child(3)").css({"color":"#616161"});
               	$(".leaguemenu a:nth-child(4)").css({"color":"#616161"});
               	$(".leaguemenu a:nth-child(5)").css({"font-weight":"bold","color":"#ffffff"});
				console.log("��ż���");
				var v  = "";
//				$.each(data.standings, function(index, value){
				for(const value of data.standings) //���� for��
				{
					//data.standings�迭 ���Ұ� 8��
					//data.standings -> value (�� �׷�) value.table -> �迭 ���Ұ� 4��
					//GROUP_A
						for(const item of value.table)
						{
							   value.group = value.group.replace("GROUP_A","A")
														.replace("GROUP_B","B")
														.replace("GROUP_C","C")
														.replace("GROUP_D","D")
														.replace("GROUP_E","E")
														.replace("GROUP_F","F")
														.replace("GROUP_G","G")
														.replace("GROUP_H","H");
							item.team.name = item.team.name.replace("SSC Napoli","������")   
														   .replace("Liverpool FC","����Ǯ FC")
														   .replace("AFC Ajax","�ƾེ") 
														   .replace("Rangers FC","�������� FC")
														   .replace("FC Porto","������")   
														   .replace("Club Brugge KV","Ŭ�� ����� KV")
														   .replace("Bayer 04 Leverkusen","���̾� 04 ��������") 
														   .replace("Club Atl?tico de Madrid","��Ʋ��Ƽ�� ���帮��")
														   .replace("FC Bayern M?nchen","FC ���̿��� ����")   
														   .replace("FC Internazionale Milano","FC ���͹ж�")
														   .replace("FC Barcelona","FC �ٸ����γ�") 
														   .replace("FC Viktoria Plze?","FC ���丮�� ����")
														   .replace("Tottenham Hotspur FC","��Ʈ�� �ֽ��� FC")   
														   .replace("Eintracht Frankfurt","����Ʈ����Ʈ ����ũǪ��Ʈ")
														   .replace("Sporting Clube de Portugal","�������� CP") 
														   .replace("Olympique de Marseille","�÷���ũ �� ��������")
														   .replace("Chelsea FC","ÿ�� FC")   
														   .replace("AC Milan","AC �ж�")
														   .replace("FC Red Bull Salzburg","FC ����� �����θ�ũ") 
														   .replace("GNK Dinamo Zagreb","GNK �𳪸� �ڱ׷���")
														   .replace("Real Madrid CF","���� ���帮�� CF")   
														   .replace("RB Leipzig","RB ������ġ��")
														   .replace("FK Shakhtar Donetsk","FC ����Ÿ�� ������ũ") 
														   .replace("Celtic FC","��ƽ FC")
														   .replace("Manchester City FC","��ü���� ��Ƽ FC")   
														   .replace("Borussia Dortmund","����þ� ����Ʈ��Ʈ")
														   .replace("Sevilla FC","����� FC") 
														   .replace("FC K��benhavn","FC �����ϰ�")
														   .replace("Sport Lisboa e Benfica","SL ����ī")   
														   .replace("Paris Saint-Germain FC","�ĸ� �������� FC")
														   .replace("Juventus FC","�������� FC") 
														   .replace("Maccabi Haifa FC","��ī�� ������ FC");
							
							v1  = "<tr><td class='cell'>"+value.group+"</td>"
							v1 += "<td>"+item.position+"</td>"
			           		v1 += "<td class='name'>"+"<img src="+item.team.crest+">"+"&nbsp;&nbsp;&nbsp;"+item.team.name+"</td>"
			           		v1 += "<td>"+item.playedGames+"</td>"
			           		v1 += "<td>"+item.points+"</td>"
			           		v1 += "<td>"+item.won+"</td>"
			           		v1 += "<td>"+item.draw+"</td>"
			           		v1 += "<td>"+item.lost+"</td>"
			           		v1 += "<td>"+item.goalsFor+"</td>"
			           		v1 += "<td>"+item.goalsAgainst+"</td>"
			           		v1 += "<td>"+item.goalDifference+"</td>"
			           		v += v1 ;
			           		
			           		$(".leaguename").html("<span>è�Ǿ𽺸���</span>"
			           				+"<p>2023 ���� �� ����</p>");
			           		
			           		$(".leaguedata").html(
			           				"<table class='leaguetable' border='1'>"
			               			+"<tr>"
			               			+"<th>��</th>"
			    			  		+"<th>����</th>"
			    			  		+"<th>��</th>"
			    			  		+"<th>����</th>"
			    			  		+"<th>����</th>"
			    			  		+"<th>��</th>"
			    			  		+"<th>��</th>"
			    			  		+"<th>��</th>"
			    			  		+"<th>����</th>"
			    			  		+"<th>����</th>"
			    			  		+"<th>������</th>"
			    			  		+"</tr>"
			    			  		+v+"</table>");
			           		
			           		$(".cell").each(function(){
								var tempString = $(this).text();
								var cell_rows = $(".cell").filter(function(){
									return $(this).text() == tempString;
								});
								if(cell_rows.length > 1){
									cell_rows.eq(0).attr("rowspan", cell_rows.length);
									cell_rows.not(":eq(0)").remove();
								}
							});
						}
					
				}
				
			}
		});
	}	
	//�����̾�� ajax ȣ��
	function rank2(mome){
		$.ajax
		({
               type:"get",
               url:"rank"+mome+".jsp",
               dataType:"json",
               success: function(data)
               {
            	switch(mome) {
           	    case "2_PL": $(".leaguemenu a:nth-child(1)").css({"font-weight":"bold","color":"#ffffff"});
           					 $(".leaguemenu a:nth-child(2)").css({"color":"#616161"});
           			       	 $(".leaguemenu a:nth-child(3)").css({"color":"#616161"});
           			       	 $(".leaguemenu a:nth-child(4)").css({"color":"#616161"});
           			       	 $(".leaguemenu a:nth-child(5)").css({"color":"#616161"});
           			     	 $(".leaguename").html("<span>�����̾��</span>"
      	           				+"<p>2023 ���� �� ����</p>");
            			break;
           	    case "3_PD": $(".leaguemenu a:nth-child(1)").css({"color":"#616161"});
           					 $(".leaguemenu a:nth-child(2)").css({"font-weight":"bold","color":"#ffffff"});
           			       	 $(".leaguemenu a:nth-child(3)").css({"color":"#616161"});
           			       	 $(".leaguemenu a:nth-child(4)").css({"color":"#616161"});
           			       	 $(".leaguemenu a:nth-child(5)").css({"color":"#616161"});
           			      	 $(".leaguename").html("<span>�󸮰�</span>"
        	           				+"<p>2023 ���� �� ����</p>");
            			break;
           	    case "4_SA": $(".leaguemenu a:nth-child(1)").css({"color":"#616161"});
           					 $(".leaguemenu a:nth-child(2)").css({"color":"#616161"});
           			         $(".leaguemenu a:nth-child(3)").css({"font-weight":"bold","color":"#ffffff"});
           			         $(".leaguemenu a:nth-child(4)").css({"color":"#616161"});
           			         $(".leaguemenu a:nth-child(5)").css({"color":"#616161"});
           			         $(".leaguename").html("<span>������ A</span>"
        	           				+"<p>2023 ���� �� ����</p>");
            			break;
           	    case "5_BL1":$(".leaguemenu a:nth-child(1)").css({"color":"#616161"});
           					 $(".leaguemenu a:nth-child(2)").css({"color":"#616161"});
           			       	 $(".leaguemenu a:nth-child(3)").css({"color":"#616161"});
           			       	 $(".leaguemenu a:nth-child(4)").css({"font-weight":"bold","color":"#ffffff"});
           			       	 $(".leaguemenu a:nth-child(5)").css({"color":"#616161"});
           			         $(".leaguename").html("<span>�е�������</span>"
        	           				+"<p>2023 ���� �� ����</p>");
            			break;
           		}
               	console.log("��ż���");
               	var v  = "";
	           	$.each(data.standings[0].table, function(index, value){
	           		
	           		/*�����̾�*/
	           		value.team.tla= value.team.tla.replace("ARS","�ƽ��� FC")
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
	           		
	           		v1  = "<tr><td>"+value.position+"</td>"
	           		v1 += "<td class='name'>"+"<img src="+value.team.crest+">"+"&nbsp;&nbsp;&nbsp;"+value.team.tla+"</td>"
	           		v1 += "<td>"+value.playedGames+"</td>"
	           		v1 += "<td>"+value.points+"</td>"
	           		v1 += "<td>"+value.won+"</td>"
	           		v1 += "<td>"+value.draw+"</td>"
	           		v1 += "<td>"+value.lost+"</td>"
	           		v1 += "<td>"+value.goalsFor+"</td>"
	           		v1 += "<td>"+value.goalsAgainst+"</td>"
	           		v1 += "<td>"+value.goalDifference+"</td>"
	           		v += v1 ;
	           		             		
	           		
	           		
	           		$(".leaguedata").html(
	           				"<table class='leaguetable' border='1'>"
	               			+"<tr>"
	    			  		+"<th>����</th>"
	    			  		+"<th>��</th>"
	    			  		+"<th>����</th>"
	    			  		+"<th>����</th>"
	    			  		+"<th>��</th>"
	    			  		+"<th>��</th>"
	    			  		+"<th>��</th>"
	    			  		+"<th>����</th>"
	    			  		+"<th>����</th>"
	    			  		+"<th>������</th>"
	    			  		+"</tr>"
	    			  		+v+"</table>"); 
	           	 })
               }
       	});
    }
	</script>
	<%@ include file="include/header.jsp" %>
<!-- main ���� -->
		<div class="main">
			<div class="leaguemenu">
				<a class="PLButton" onclick="rank2('2_PL');">�����̾��</a>&nbsp;|&nbsp;
				<a class="laButton" onclick="rank2('3_PD');">�󸮰�</a>&nbsp;|&nbsp;
				<a class="SAButton" onclick="rank2('4_SA');">������ A</a>&nbsp;|&nbsp;
				<a class="buButton" onclick="rank2('5_BL1');">�е�������</a>&nbsp;|&nbsp;
				<a class="UEFAButton" onclick="rank1();">è�Ǿ𽺸���</a>
			</div>
			<hr>
			<div class="leaguename">
			</div>
			<div class="leaguedata">
			</div>
		</div>
		
<!-- main �� -->
<%@ include file="include/footer.jsp" %>
	