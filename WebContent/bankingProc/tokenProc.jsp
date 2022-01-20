<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="apiClient" class="openBanking.apiClient" />
<jsp:useBean id="mMgr" class="member.MemberDAO" />
<%
	request.setCharacterEncoding("utf-8");
	//response.setContentType("application/json; charset=utf-8");

	String addr = "https://testapi.openbanking.or.kr" + request.getParameter("path");
	System.out.println("tokenProd.jsp : " + addr);
	String clientId = apiClient.getId();
	String clientSecret = apiClient.getSecret();
	String parameter = "";

	parameter = parameter + "code=" + request.getParameter("code");
	parameter = parameter + "&" + "client_id=" + clientId;
	parameter = parameter + "&" + "client_secret=" + clientSecret;
	parameter = parameter + "&" + "redirect_uri=" + request.getParameter("redirect_uri");
	parameter = parameter + "&" + "grant_type=authorization_code";
	System.out.println("tokenProd.jsp : " + parameter);

	addr = addr + parameter;
	URL url = new URL(addr);
	HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	conn.setRequestMethod("POST");
	conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");

	BufferedReader rd;
	if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
		rd = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));
	} else {
		rd = new BufferedReader(new InputStreamReader(conn.getErrorStream(), "utf-8"));
	}
	String line;
	String jsonString = "";
	while ((line = rd.readLine()) != null) {
		jsonString += line;
	}
	rd.close();
	conn.disconnect();
	// Response된 json에서 access_token, user_seq_no 값을 추출
	String json = jsonString.replaceAll("\"", "");
	String access_token = json.substring(1, json.length() - 1).split(",")[0].split(":")[1];
	String user_seq_no = json.substring(1, json.length() - 1).split(",")[5].split(":")[1];
	// 추출한  access_token, user_seq_no을 DB에 입력해준다.
	String path = request.getRequestURL().substring(0, request.getRequestURL().indexOf("/", 7))
			+ request.getContextPath();
	String id = (String) session.getAttribute("idKey");
	String location = "";
	boolean result = mMgr.updateToken(access_token, user_seq_no, id);
	if (result) {
		location = request.getContextPath() + "/board/goalExpense.jsp";
	}
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

<script>
	location.href="<%=location%>";
</script>