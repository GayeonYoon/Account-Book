<%@page import="openBanking.apiClient"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mMgr" class="member.MemberDAO"/>
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String) session.getAttribute("idKey");
	String path = request.getRequestURL().substring(0, request.getRequestURL().indexOf("/", 7))
			+ request.getContextPath();
	// token
	String token = mMgr.getMember(id).getAccess_token();
	// fin_tech_num
	String fintechUseNum = request.getParameter("fintechUseNum");
	// bank_tran_id 9자리 난수 : 은행거래고유번호 = 이용기관코드 + U + 9자리난수
	long num = 0;
	while (("" + num).length() != 9) {
		num = (long) (Math.random() * 1000000000);
	}
	String bankTranId = apiClient.getCode() + "U" + num;
%>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z"
	crossorigin="anonymous">

<!-- JS, Popper.js, and jQuery -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
	integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"
	integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN"
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"
	integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV"
	crossorigin="anonymous"></script>

<!-- 로딩화면 -->
<div class="d-flex justify-content-center">
	<div class="spinner-border" role="status">
		<span class="sr-only">Loading...</span>
	</div>
</div>

<script>
	// 계좌해지 API 보내기
	var num = <%=num%>;
	//scope = inquiry || transfer
	function accountCancel(scope , num){
		var msg = false;
		var bankTranId = '<%=apiClient.getCode()%>U'+num;
		var json = {bank_tran_id : bankTranId , fintech_use_num : '<%=fintechUseNum%>' , scope: scope};
		var useJson = JSON.stringify(json);
		
		var xhr = new XMLHttpRequest();
		xhr.open('POST', 'https://testapi.openbanking.or.kr/v2.0/account/cancel',true);
		// Header는 open 다음 send 전에 설정해준다.
		xhr.setRequestHeader('Accept', 'application/json');
		xhr.setRequestHeader('Access-Control-Allow-Origin', '*');
		xhr.setRequestHeader('Content-type', 'application/json; charset=UTF-8');
		xhr.setRequestHeader('Authorization', 'Bearer <%=token%>');
		xhr.send(useJson);
		
		xhr.onreadystatechange = function (e) {
			// readyState = 1, 2, 3
			if (xhr.readyState != XMLHttpRequest.DONE){
				msg = false;
			}
			// readyState = 4
			alert(xhr.responseText);
			if(xhr.status == 200) {
				if(xhr.responseText.includes('A0000')){
					msg = true;
				}
			}
		}
		if(msg == true){
			alert("삭제되었습니다.");
		}else{
			alert("삭제가 불가합니다.\n 관리자에게 문의해주세요.");
		}
		
	};
	
	// accountCancel('inquiry', num);
	accountCancel('transfer', num);

	location.href='<%=path%>/bankingProc/accountListProc.jsp';
</script>