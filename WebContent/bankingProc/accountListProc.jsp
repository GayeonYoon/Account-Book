<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mMgr" class="member.MemberDAO" />
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String) session.getAttribute("idKey");
	String path = request.getRequestURL().substring(0, request.getRequestURL().indexOf("/", 7))
			+ request.getContextPath();

	String addr = "https://testapi.openbanking.or.kr/v2.0/account/list?";
	
	String parameter = "";
	parameter = parameter + "user_seq_no=" + mMgr.getMember(id).getUser_seq_no();
	parameter = parameter + "&include_cancel_yn=N";
	parameter = parameter + "&sort_order=A";
	System.out.println("계좌 목록 조회 파라미터 : " + parameter);
	
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

	System.out.println("처음 accountList Json이 날라왔을때 형태 : " + jsonString);
	jsonString = jsonString.replaceAll("\"", "\'");
	rd.close();
	conn.disconnect();
%>
<!-- CSS only -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">

<!-- JS, Popper.js, and jQuery -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>

<!-- 로딩화면 -->
<div class="d-flex justify-content-center">
  <div class="spinner-border" role="status">
    <span class="sr-only">Loading...</span>
  </div>
</div>

<form name="frm" method="post" action="<%=path%>/board/accountList.jsp">
	<input type="hidden" name="json" value="<%=jsonString%>">
</form>
<script>
	document.frm.submit();
</script>