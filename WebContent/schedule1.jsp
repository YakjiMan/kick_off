<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>순위</title>
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
	function SCseason(obj,mode)	//시즌일정 조회 
	{
		if(mode == "")
		{
			mode = prevMode;	
		}
		prevMode = mode;
		
		// API주소와 토큰이 있는 schedule_CL.jsp를 호출함
		let date_url = "schedule_"+mode+".jsp";
		
		// 시즌 년월 선택값이 있으면
		if( $(obj).val() != "" )
		{
			// 호출 주소에 파라메타를 추가함
			date_url += "?month=" + $(obj).val();
		}
			switch(mode) {
			 case "PLSC":  $(".leaguemenu a:nth-child(1)").css({"font-weight":"bold","color":"#ffffff"});
						 $(".leaguemenu a:nth-child(2)").css({"color":"#616161"});
				       	 $(".leaguemenu a:nth-child(3)").css({"color":"#616161"});
				       	 $(".leaguemenu a:nth-child(4)").css({"color":"#616161"});
				       	 $(".leaguemenu a:nth-child(5)").css({"color":"#616161"});
				       	 $(".leaguename").html("<span>프리미어리그</span>");
					break;
	   	    case "PDSC":   $(".leaguemenu a:nth-child(1)").css({"color":"#616161"});
	   					 $(".leaguemenu a:nth-child(2)").css({"font-weight":"bold","color":"#ffffff"});
	   			       	 $(".leaguemenu a:nth-child(3)").css({"color":"#616161"});
	   			       	 $(".leaguemenu a:nth-child(4)").css({"color":"#616161"});
	   			       	 $(".leaguemenu a:nth-child(5)").css({"color":"#616161"});
	   			      	 $(".leaguename").html("<span>라리가</span>");
	    			break;
	   	    case "SASC":   $(".leaguemenu a:nth-child(1)").css({"color":"#616161"});
	   					 $(".leaguemenu a:nth-child(2)").css({"color":"#616161"});
	   			       	 $(".leaguemenu a:nth-child(3)").css({"font-weight":"bold","color":"#ffffff"});
	   			       	 $(".leaguemenu a:nth-child(4)").css({"color":"#616161"});
	   			       	 $(".leaguemenu a:nth-child(5)").css({"color":"#616161"});
	   			      	 $(".leaguename").html("<span>세리에 A</span>");
	    			break;
	   	    case "BL1SC":  $(".leaguemenu a:nth-child(1)").css({"color":"#616161"});
	   					 $(".leaguemenu a:nth-child(2)").css({"color":"#616161"});
	   			         $(".leaguemenu a:nth-child(3)").css({"color":"#616161"});
	   			         $(".leaguemenu a:nth-child(4)").css({"font-weight":"bold","color":"#ffffff"});
	   			         $(".leaguemenu a:nth-child(5)").css({"color":"#616161"});
	   			      	 $(".leaguename").html("<span>분데스리가</span>");
	    			break;
	   	    case "CLSC":   $(".leaguemenu a:nth-child(1)").css({"color":"#616161"});
	   					 $(".leaguemenu a:nth-child(2)").css({"color":"#616161"});
	   			       	 $(".leaguemenu a:nth-child(3)").css({"color":"#616161"});
	   			       	 $(".leaguemenu a:nth-child(4)").css({"color":"#616161"});
	   			       	 $(".leaguemenu a:nth-child(5)").css({"font-weight":"bold","color":"#ffffff"});
	   			      	 $(".leaguename").html("<span>챔피언스리그</span>");
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
						/*프리미어*/
		           		value.awayTeam.tla= value.awayTeam.tla.replaceAll("ARS","아스날 FC")
													  .replace("MCI","맨체스터 시티 FC")
													  .replace("NEW","뉴캐슬 유나이티드 FC")
													  .replace("TOT","토트넘 홋스퍼 FC")
													  .replace("MUN","맨체스터 유나이티드 FC")
													  .replace("BHA","브라이튼 앤 호브 알비온 FC")
													  .replace("AVL","아스톤 빌라 FC")
													  .replace("LIV","리버풀 FC")
													  .replace("BRE","브렌트포드 FC")
													  .replace("FUL","풀럼 FC")
													  .replace("CHE","첼시 FC")
													  .replace("CRY","크리스탈 팰리스 FC")
													  .replace("LEE","리즈 유나이티드 FC")
													  .replace("WOL","울버햄튼 원더러스 FC")
													  .replace("WHU","웨스트햄 유나이티드 FC")
													  .replace("EVE","에버턴 FC")
													  .replace("NOT","노팅엄 포레스트 FC")
													  .replace("BOU","AFC 본머스")
													  .replace("LEI","레스터 시티 FC")
													  .replace("SOU","사우샘프턴 FC")
						/*라리가	*/					  .replace("FCB","FC 바르셀로나")
													  .replace("RMA","레알 마드리드")
													  .replace("ATL","클루브 아틀레티코 데 마드리드")
													  .replace("RSO","레알 소시에다드")
													  .replace("BET","레알 베티스 발롬피에")
													  .replace("VIL","비야레알 CF")
													  .replace("ATH","아틀레틱 클루브")
													  .replace("RAY","라요 바예카노")
													  .replace("CEL","CA 오사수나")
													  .replace("OSA","RC 셀타 데 비고")
													  .replace("GIR","지로나 FC")
													  .replace("MAL","RCD 마요르카")
													  .replace("SEV","세비야 FC")
													  .replace("GET","헤타페 CF")
													  .replace("CAD","카디스 CF")
													  .replace("VDD","레알 바야돌리드")
													  .replace("VAL","발렌시아 CF")
													  .replace("ESP","RCD 에스파뇰")
													  .replace("ALM","UD 알메리아")
													  .replace("ELC","엘체 CF")
						/*세리에A*/					  .replace("NAP","SSC 나폴리")
													  .replace("LAZ","SS 라치오")
													  .replace("MIL","AC 밀란")
													  .replace("INT","AS 로마")
													  .replace("ROM","FC 인터밀란")
													  .replace("ATA","아탈란타 BC")
													  .replace("JUV","유벤투스 FC")
													  .replace("BOL","볼로냐 FC 1909")
													  .replace("FIO","ACF 피오렌티나")
													  .replace("TOR","토리노 FC")
													  .replace("UDI","우디네세 칼초")
													  .replace("SAS","US 사수올로 칼초")
													  .replace("MON","몬자")
													  .replace("EMP","엠폴리 FC")
													  .replace("SAL","스포티바 살레르니타나")
													  .replace("USL","US 레체")
													  .replace("SPE","스페지아")
													  .replace("HVE","엘라스 베로나 FC")
													  .replace("SAM","UC 삼프도리아")
													  .replace("CRE","US 크레모네세")
						/*분데스*/					  .replace("FCB","FC 바이에른 뮌헨")
													  .replace("BVB","보루시아 도르트문트")
													  .replace("UNB","FC 우니온 베를린")
													  .replace("SCF","SC 프라이부르크")
													  .replace("RBL","RB 라이프치히")
													  .replace("SGE","아인트라흐트 프랑크푸르트")
													  .replace("B04","TSV 바이어 04 레버쿠젠")
													  .replace("M05","FSV 마인츠 05")
													  .replace("WOB","VfL 볼프스부르크")
													  .replace("BMG","보루시아 묀헨글라트바흐")
													  .replace("SVW","SV 베르더 브레멘")
													  .replace("FCA","FC 아우크스부르크")
													  .replace("KOE","FC 쾰른")
													  .replace("BOC","VfL 보훔")
													  .replace("TSG","TSG 1899 호펜하임")
													  .replace("BSC","헤르타 BSC")
													  .replace("S04","FC 샬케 04")
													  .replace("VFB","VfB 슈투트가르트");
						/*프리미어*/
		           		value.homeTeam.tla= value.homeTeam.tla.replaceAll("ARS","아스날 FC")
													  .replace("MCI","맨체스터 시티 FC")
													  .replace("NEW","뉴캐슬 유나이티드 FC")
													  .replace("TOT","토트넘 홋스퍼 FC")
													  .replace("MUN","맨체스터 유나이티드 FC")
													  .replace("BHA","브라이튼 앤 호브 알비온 FC")
													  .replace("AVL","아스톤 빌라 FC")
													  .replace("LIV","리버풀 FC")
													  .replace("BRE","브렌트포드 FC")
													  .replace("FUL","풀럼 FC")
													  .replace("CHE","첼시 FC")
													  .replace("CRY","크리스탈 팰리스 FC")
													  .replace("LEE","리즈 유나이티드 FC")
													  .replace("WOL","울버햄튼 원더러스 FC")
													  .replace("WHU","웨스트햄 유나이티드 FC")
													  .replace("EVE","에버턴 FC")
													  .replace("NOT","노팅엄 포레스트 FC")
													  .replace("BOU","AFC 본머스")
													  .replace("LEI","레스터 시티 FC")
													  .replace("SOU","사우샘프턴 FC")
						/*라리가	*/					  .replace("FCB","FC 바르셀로나")
													  .replace("RMA","레알 마드리드")
													  .replace("ATL","클루브 아틀레티코 데 마드리드")
													  .replace("RSO","레알 소시에다드")
													  .replace("BET","레알 베티스 발롬피에")
													  .replace("VIL","비야레알 CF")
													  .replace("ATH","아틀레틱 클루브")
													  .replace("RAY","라요 바예카노")
													  .replace("CEL","CA 오사수나")
													  .replace("OSA","RC 셀타 데 비고")
													  .replace("GIR","지로나 FC")
													  .replace("MAL","RCD 마요르카")
													  .replace("SEV","세비야 FC")
													  .replace("GET","헤타페 CF")
													  .replace("CAD","카디스 CF")
													  .replace("VDD","레알 바야돌리드")
													  .replace("VAL","발렌시아 CF")
													  .replace("ESP","RCD 에스파뇰")
													  .replace("ALM","UD 알메리아")
													  .replace("ELC","엘체 CF")
						/*세리에A*/					  .replace("NAP","SSC 나폴리")
													  .replace("LAZ","SS 라치오")
													  .replace("MIL","AC 밀란")
													  .replace("INT","AS 로마")
													  .replace("ROM","FC 인터밀란")
													  .replace("ATA","아탈란타 BC")
													  .replace("JUV","유벤투스 FC")
													  .replace("BOL","볼로냐 FC 1909")
													  .replace("FIO","ACF 피오렌티나")
													  .replace("TOR","토리노 FC")
													  .replace("UDI","우디네세 칼초")
													  .replace("SAS","US 사수올로 칼초")
													  .replace("MON","몬자")
													  .replace("EMP","엠폴리 FC")
													  .replace("SAL","스포티바 살레르니타나")
													  .replace("USL","US 레체")
													  .replace("SPE","스페지아")
													  .replace("HVE","엘라스 베로나 FC")
													  .replace("SAM","UC 삼프도리아")
													  .replace("CRE","US 크레모네세")
						/*분데스*/					  .replace("FCB","FC 바이에른 뮌헨")
													  .replace("BVB","보루시아 도르트문트")
													  .replace("UNB","FC 우니온 베를린")
													  .replace("SCF","SC 프라이부르크")
													  .replace("RBL","RB 라이프치히")
													  .replace("SGE","아인트라흐트 프랑크푸르트")
													  .replace("B04","TSV 바이어 04 레버쿠젠")
													  .replace("M05","FSV 마인츠 05")
													  .replace("WOB","VfL 볼프스부르크")
													  .replace("BMG","보루시아 묀헨글라트바흐")
													  .replace("SVW","SV 베르더 브레멘")
													  .replace("FCA","FC 아우크스부르크")
													  .replace("KOE","FC 쾰른")
													  .replace("BOC","VfL 보훔")
													  .replace("TSG","TSG 1899 호펜하임")
													  .replace("BSC","헤르타 BSC")
													  .replace("S04","FC 샬케 04")
													  .replace("VFB","VfB 슈투트가르트");	
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
				const html_for_null = "<tr><td colspan='100'>일정이 없습니다</td></tr>";
				
				$(".leaguedata").html("<table class='leaguetable' border='1'>"
						+"<tr>"
						+"<th>날짜</th>"
						+"<th>시간</th>"
						+"<th colspan='3'>경기</th>"
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
	
	 //시작시 실행
	$(document).ready(function(){
			SCseason(this,'<%=mcate%>');
	}); 
	
	//검색
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
	//null 값치환
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
<!-- main 시작 -->
		<div class="main">
			<div class="leaguemenu">
				<a class="PLButton" onclick="SCseason(this,'PL'); DateReset();">프리미어리그</a>&nbsp;|&nbsp;
				<a class="laButton" onclick="SCseason(this,'PD'); DateReset();">라리가</a>&nbsp;|&nbsp;
				<a class="SAButton" onclick="SCseason(this,'SA'); DateReset();">세리에 A</a>&nbsp;|&nbsp;
				<a class="buButton" onclick="SCseason(this,'BL1'); DateReset();">분데스리가</a>&nbsp;|&nbsp;
				<a class="UEFAButton" onclick="SCseason(this,'CL'); DateReset();">챔피언스리그</a>
				<a class="PLButton" onclick="SCseason(this,'PL')">프리미어리그</a>&nbsp;|&nbsp;
				<a class="laButton" onclick="SCseason(this,'PD')">라리가</a>&nbsp;|&nbsp;
				<a class="SAButton" onclick="SCseason(this,'SA')">세리에 A</a>&nbsp;|&nbsp;
				<a class="buButton" onclick="SCseason(this,'BL1')">분데스리가</a>&nbsp;|&nbsp;
				<a class="UEFAButton" onclick="SCseason(this,'CL')">챔피언스리그</a>
				<a class="PLButton" onclick="SCseason(this,'PLSC')">프리미어리그</a>&nbsp;|&nbsp;
				<a class="laButton" onclick="SCseason(this,'PDSC')">라리가</a>&nbsp;|&nbsp;
				<a class="SAButton" onclick="SCseason(this,'SASC')">세리에 A</a>&nbsp;|&nbsp;
				<a class="buButton" onclick="SCseason(this,'BL1SC')">분데스리가</a>&nbsp;|&nbsp;
				<a class="UEFAButton" onclick="SCseason(this,'CLSC')">챔피언스리그</a>
			</div>
			<hr>
			<div class="selectFrame">
				 <b>2022-23시즌</b><br>
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
				<b>월</b>
			</div>
			<div class="leaguename">
			</div>
			<div class="leaguedata">
			</div>
		</div>
	<!-- main 끝 -->
<%@ include file="include/footer.jsp" %>