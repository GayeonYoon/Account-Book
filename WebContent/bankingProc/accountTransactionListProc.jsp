<%@page import="account.Account"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="openBanking.apiClient"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mMgr" class="member.MemberDAO" />
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String) session.getAttribute("idKey");
	String path = request.getRequestURL().substring(0, request.getRequestURL().indexOf("/", 7))
			+ request.getContextPath();
	// API 주소
	String addr = "https://testapi.openbanking.or.kr/v2.0/account/transaction_list/fin_num?";

	// request parameter
	String fintech_use_num = request.getParameter("fintech_use_num");
	String account_alias = request.getParameter("account_alias");
	String bank_name = request.getParameter("bank_name");
	String account_num = request.getParameter("account_num");

	// bank_tran_id / 은행거래고유번호 -> 이용기관코드 + U + 9자리난수
	long num = 0;
	while (("" + num).length() != 9) {
		num = (long) (Math.random() * 1000000000);
	}
	String bankTranId = apiClient.getCode() + "U" + num;

	// tran_dtime / 요청일시->현재시간
	Date today = new Date();
	SimpleDateFormat dtimeDate = new SimpleDateFormat("yyyyMMdd");
	SimpleDateFormat dtimeTime = new SimpleDateFormat("hhmmss");
	String parameter = "";
	parameter = parameter + "bank_tran_id=" + bankTranId;
	parameter = parameter + "&" + "fintech_use_num=" + fintech_use_num;
	parameter = parameter + "&" + "inquiry_type=A"; // A:All, I:입금, O:출금
	parameter = parameter + "&" + "inquiry_base=D"; // D:일자 , T:시간
	parameter = parameter + "&" + "from_date=" + dtimeDate.format(today);
	parameter = parameter + "&" + "to_date=" + dtimeDate.format(today);
	parameter = parameter + "&" + "sort_order=A"; // D:내림차순, A:오름차순
	parameter = parameter + "&" + "tran_dtime=" + dtimeDate.format(today) + dtimeTime.format(today);
	System.out.println("parameter : " + parameter);
	addr = addr + parameter;
	URL url = new URL(addr);
	HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	conn.setRequestMethod("GET");
	conn.setRequestProperty("Authorization", "Bearer " + mMgr.getMember(id).getAccess_token());

	BufferedReader rd;
	if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
		rd = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));
	} else {
		rd = new BufferedReader(new InputStreamReader(conn.getErrorStream(), "utf-8"));
	}
	String jsonString = rd.readLine();
	System.out.println("거내내역 처음 json : " + jsonString);
	jsonString = jsonString.replaceAll("\"", "\'");
	rd.close();
	conn.disconnect();
%>
<!-- CSS only -->
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

<form name="frm" method="post" action="<%=path%>/board/accountTransactionList.jsp">
	<input type="hidden" name="json" value="<%=jsonString%>">
	<input type="hidden" name="fintech_use_num" value="<%=fintech_use_num%>">
	<input type="hidden" name="account_alias" value="<%=account_alias%>">
	<input type="hidden" name="bank_name" value="<%=bank_name%>">
	<input type="hidden" name="account_num" value="<%=account_num%>">
</form>
<script>
	document.frm.submit();
</script>