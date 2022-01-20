<%@page import="account.AllTransationListJSON"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>

<%
	if (mMgr.getMember(id).getAuth() == false) {
%>
<!-- Header -->
<header class="masthead d-flex">
	<div class="container text-center my-auto">
		<h1 class="mb-1 text-right">아껴써라 거지된다</h1>
		<h3 class="mb-5 text-right">
			<em>Adam Smith (1723.06~1790.07)</em>
		</h3>
		<!-- Button trigger modal -->
		<button type="button"
			class="btn btn-primary btn-xl js-scroll-trigger float-right"
			data-toggle="modal" data-target="#exampleModal">시작하기</button>
		<!-- Modal -->
		<div class="modal fade" id="exampleModal" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<br />
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header" style="color: black;">
						<h5 class="modal-title" id="exampleModalLabel">로그인</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<form name="loginFrm" method="post"
							action="<%=path%>/member/loginProc.jsp">
							<table class="table table-striped" width="70%">
								<tbody>
									<tr>
										<td class="pl-4 align-middle"><label for="id"><b>아이디</b></label></td>
										<td><input type="text"
											class="form-control form-control-lg col-md-8" id="id"
											name="id" autofocus></td>
									</tr>
									<tr>
										<td class="pl-4 align-middle"><label for="inputPassword1"><b>비밀번호</b></label></td>
										<td><input type="password"
											class="form-control form-control-lg col-md-8"
											id="inputPassword1" name="pwd"></td>
									</tr>
								</tbody>
							</table>
							<div class="modal-footer">
								<button type="button" class="btn btn-primary btn-lg active"
									onclick="loginCheck()">로그인</button>
								<button type="button" class="btn btn-light btn-lg active"
									onclick="javascript:location.href='<%=path%>/member/member.jsp'">회원가입</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="overlay"></div>
</header>
<%
	} else {
		Calendar cal = Calendar.getInstance();
		String strYear = request.getParameter("year");
		String strMonth = request.getParameter("month");
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH);
		int date = cal.get(Calendar.DATE);
		if (strYear != null) {
			year = Integer.parseInt(strYear);
			month = Integer.parseInt(strMonth);
		} else {
		}
		//년도/월 셋팅
		cal.set(year, month, 1);
		int startDay = cal.getMinimum(java.util.Calendar.DATE);
		int endDay = cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH);
		int start = cal.get(java.util.Calendar.DAY_OF_WEEK);
		int newLine = 0;

		//오늘 날짜 저장.
		Calendar todayCal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyMMdd");
		int intToday = Integer.parseInt(sdf.format(todayCal.getTime()));

		// json 파싱
		String jsonArray = AllTransationListJSON.getInstance().getJson();
		if(jsonArray!="null"){
			jsonArray = jsonArray.replaceAll("\'", "\"");
		}
		System.out.println("jsonArray : " + jsonArray);
%>
<div class="mt-3 mb-5">
	<div class="col-md-12 col-lg-12 col-xl-12 p-0" id="content"
		style="width: 100%;">
		<table class="table mb-0 mt-10 table-dark" border="0" cellspacing="0"
			cellpadding="0">
			<tr class="bg-primary">
				<td class="display-3" align="center" style="font-size: 20px;">
					<div class="h3 row justify-content-center">
						<span class="align-bottom pt-2"><%=year%>년</span>
						<select class="form-control bg-primary border-0" id="monthSelect"
							style="font-size: 25px; color: white; width: 100px;">
							<%
								for (int i = month+1; i >= 1; i--) {
							%>
							<option class="bg-light h6" style="color:black;"><%=i %> 월</option>
							<%
								}
							%>
						</select>
					</div>
				</td>
			</tr>
		</table>
		<table class="table table-striped mt-0" border="0" cellspacing="1" cellpadding="1">
			<thead class="thead-dark">
				<tr>
					<th width='100px'>
						<div align="center">
							<font color="red">일</font>
						</div>
					</th>
					<th width='100px'>
						<div align="center">월</div>
					</th>
					<th width='100px'>
						<div align="center">화</div>
					</th>
					<th width='100px'>
						<div align="center">수</div>
					</th>
					<th width='100px'>
						<div align="center">목</div>
					</th>
					<th width='100px'>
						<div align="center">금</div>
					</th>
					<th width='100px'>
						<div align="center">
							<font color="#529dbc">토</font>
						</div>
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<%
						// 처음 빈공란 표시
							for (int index = 1; index < start; index++) {
								out.println("<td class='table-light'>&nbsp;</td>");
								newLine++;
							}
							// 달력 출력
							for (int index = 1; index <= endDay; index++) {
								String color = "black";
								if (newLine == 0) {
									color = "RED";
								} else if (newLine == 6) {
									color = "#529dbc";
								}
								String sUseDate = Integer.toString(year);
								sUseDate += Integer.toString(month + 1).length() == 1
										? "0" + Integer.toString(month + 1)
										: Integer.toString(month + 1);
								sUseDate += Integer.toString(index).length() == 1
										? "0" + Integer.toString(index)
										: Integer.toString(index);
								int iUseDate = Integer.parseInt(sUseDate);
								String backColor = "table-Active";
								if (iUseDate == intToday) {
									backColor = "table-warning";
								}
								out.println("<td class='" + backColor
										+ " nav-tabs' valign='top' align='left' height='92px' data-toggle='tab-hover'>");
					%>
					<font color="<%=color%>"><%=index%></font>
					<%
						out.println("<div id='date" + index + "'></div></td>");
								newLine++;
								if (newLine == 7) {
									out.println("</tr>");
									if (index <= endDay) {
										out.println("<tr>");
									}
									newLine = 0;
								}
							}
							//마지막 공란 LOOP
							while (newLine > 0 && newLine < 7) {
								out.println("<td class='table-light'>&nbsp;</td>");
								newLine++;
							}
					%>
				</tr>
			</tbody>
		</table>
	</div>
</div>

<script type="text/javascript">   //LazyHolder : 스레드가 가능한 싱글톤
	// AllTransationListJSON 싱글톤에 저장된 json을 변수에 받는다.  -> 내 계좌에 있는 정보를 전부 가져와. 멀티스레드 싱글톤으로 저장시켜. 로딩이 너무 기니까. 한번에 다 받아놓고. 
	var list = '<%=jsonArray%>';
	var data = JSON.parse(list);  //바로 배열로 받아.
	
	function foo(month){   //지출과 수입을 찍기위한 함수
		// key : date , value : 금액
		var myDepositMap = new Map();
		var myWithdrawalMap = new Map();
		
		// 처음 함수 실행 시 기존 적혀있던 내용들 삭제  // 처음엔 일단 삭제
		$('.withdrawal').remove();
		$('.deposit').remove();
		
		// 오늘 날짜, 오늘 일자
		var today = new Date();
		var date = today.getDate();
		
		// 입금, 출금 글자 크기->화면 크기에 따라 달라짐
		var textSize = $(window).width() >= 700 ? '25px' : $(window).width() < 700 && $(window).width() >= 600 ? '18px' : '12px';
		
		for (var i = 0; i < data.length; i++) {
			// 월을 10월 이상은 두자리, 이하는 한자리로 잘라 변수에 담는다.
			var dataMonth = data[i].tran_date.substring(4, 5) == "0" ? data[i].tran_date.substring(5, 6) : data[i].tran_date.substring(4, 6);
			if (dataMonth == month) {
				var dataDate = Number(data[i].tran_date.substring(6));
				if($('#date' + dataDate).parent('a').length==0){
					$('#date' + dataDate).wrap('<a id="atag" href="javascript:detailDateList(' + dataDate + ')"></a>');
				}
				if (data[i].inout_type.includes('입금')) {
					// 일자에 해당하는 입금내역을 맵에 담는다. -> 기존에 입금내역이 있다면 더해준다.
					if(typeof myDepositMap.get(dataDate) != 'undefined'){
						var preDeposit = myDepositMap.get(dataDate);
						myDepositMap.set(dataDate, Number(data[i].tran_amt) + preDeposit);
					}else{
						myDepositMap.set(dataDate, Number(data[i].tran_amt));
					}			
					// 일자에 출력해준다.
					if ($('#date' + dataDate).children('#deposit').length > 0) { // 입금(수입) 표시가 있다면 내용만 바꿔라
						$('#date' + dataDate).children('#deposit').empty();
						$('#date' + dataDate).children('#deposit').html( '+' + myDepositMap.get(dataDate));   //비우고 기존의 값과 더해서 다시 뿌려주기
						
					} else if ($('#date' + dataDate).children('#withdrawal').length > 0) { // 출금 표시가 있다면 입금을 출금표시 위에 올려야한다.
						$('#date' + dataDate).children('#withdrawal').before('<p class="deposit m-0" id="deposit" style="color:blue; font-size:' + textSize + ';">+' 
						+ myDepositMap.get(dataDate) + '</p>');
					
					} else {
						$('#date' + dataDate).append('<p class="deposit m-0" id="deposit" style="color:blue; font-size:' + textSize + ';"> +' + myDepositMap.get(dataDate) + '</p>');
					}
					
					
				} else{
					// 일자에 해당하는 출금내역을 맵에 담는다. -> 기존에 출금내역이 있다면 더해준다.
					if(typeof myWithdrawalMap.get(dataDate) != 'undefined'){
						var preWithdrawal = myWithdrawalMap.get(dataDate);
						myWithdrawalMap.set(dataDate, Number(data[i].tran_amt) + preWithdrawal);
					}else{
						myWithdrawalMap.set(dataDate, Number(data[i].tran_amt));
					}			
					// 일자에 출력해준다.
					if ($('#date' + dataDate).children('#withdrawal').length > 0) {
						$('#date' + dataDate).children('#withdrawal').empty();
						$('#date' + dataDate).children('#withdrawal').html('-' + myWithdrawalMap.get(dataDate));
					} else {
						$('#date' + dataDate).append('<p class="withdrawal m-0" id="withdrawal" style="color:red; font-size:' + textSize + ';"> -' + myWithdrawalMap.get(dataDate) + '</p>');
					}
				}
			}
		}
	}
	// 처음 로딩될 때, 현재 달로 달력 내역 출력
	$('document').ready( function() {
		foo(<%=month+1%>);
	}).keyup();
	// selectBox를 선택시 해당 달로 달력 내역 출력
	$('#monthSelect').change(function(){
		foo(this.value.substring(0,1));
	});

</script>
<script type="text/javascript">
	// 화면 사이즈가 바뀌면(700이하) 글자 크기를 줄인다.
	$(window).resize(function() {
		if ($(window).width() >= 600 && $(window).width() < 700) {
			$('p#deposit').css('font-size','18px');
			$('p#withdrawal').css('font-size','18px');
		} else if($(window).width() < 600) {
			$('p#deposit').css('font-size','12px');
			$('p#withdrawal').css('font-size','12px');
		}else{
			$('p#deposit').css('font-size','25px');
			$('p#withdrawal').css('font-size','25px');
		}
	})
</script>
<script type="text/javascript">
	// 화면 사이즈가 바뀌면(700이하) 글자 크기를 줄인다.
	function detailDateList(date){
		// 현재 달력에서 보여지고 있는 달
		var month = $('#monthSelect').val().substring(0,1);
		
		// 새로운 창으로 띄움  --> 지출내역
		var detailDateList = window.open("about:blank", "PopupWin", "top=100,left=500,width=500,height=600");
		for(var i = 0; i < data.length; i++){
			var dataMonth = data[i].tran_date.substring(4, 5) == "0" ? data[i].tran_date.substring(5, 6) : data[i].tran_date.substring(4, 6);
			if (dataMonth == month) {
				var dataDate = Number(data[i].tran_date.substring(6));
				if(date == dataDate){
					detailDateList.document.write("<p>" + data[i].tran_date + "</p>");
					detailDateList.document.write("<p>" + data[i].inout_type + "</p>");
					detailDateList.document.write("<p>" + data[i].tran_amt + "</p>");
					detailDateList.document.write("<p>" + data[i].tran_type + "</p>");
					detailDateList.document.write("<p>" + data[i].branch_name + "</p>");
					detailDateList.document.write("<hr>");
				}
			}
		}
	}
</script>
<%
	}
%>