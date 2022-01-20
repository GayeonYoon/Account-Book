<%@page import="account.ResListMap"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="json.jsonParsing"%>
<%@page import="org.codehaus.jackson.map.ObjectMapper"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="account.Account"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="account.Account"%>
<%@page import="member.MemberDTO"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="apiClient" class="openBanking.apiClient" />
<jsp:useBean id="account" class="account.Account"></jsp:useBean>
<%
	request.setCharacterEncoding("utf-8");
	//response.setContentType("application/json; charset=utf-8");

	String addr = "https://testapi.openbanking.or.kr/v2.0/account/list?";
	System.out.println(addr);

	MemberDTO mem = mMgr.getMember(id);
	System.out.println("name : " + mem.getId());

	String user_seq_no = mem.getUser_seq_no();
	String access_token = mem.getAccess_token();
	System.out.println("user_seq_no : " + user_seq_no);
	System.out.println("access_token : " + access_token);

	//파라미터 생성해서 보내기
	String parameter = "";
	parameter = parameter + "user_seq_no=" + user_seq_no;
	parameter = parameter + "&" + "include_cancel_yn=" + "Y";
	parameter = parameter + "&" + "sort_order=" + "D";

	System.out.println(parameter);

	addr = addr + parameter;
	URL url = new URL(addr);
	HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	conn.setRequestMethod("GET");
	conn.setRequestProperty("Authorization", "Bearer " + access_token);
	System.out.println("Response code: " + conn.getResponseCode());

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

	JSONParser parser = new JSONParser(); 													//json형식을 띄고있는 모든 형식들을 파싱해주는 클래스
	Object obj = parser.parse(jsonString);														 //jsonString(String type) to Object

	JSONObject jsonObj = (JSONObject) obj;												 // Object to JsonObject
	JSONArray jsonArray = (JSONArray) jsonObj.get("res_list"); 				//JSONObjet to jsonArray("res_list")

	for (int i = 0; i < jsonArray.size(); i++) {  
		JSONObject res_listObject = (JSONObject) jsonArray.get(i); 				//JSONArray to JSONObject
																														//res_listObject.get을 써서 각 키값을 가져오면 리턴은 object임을 잊지말자.
		Account resList = new Account(); 

		resList.setFintech_use_num(res_listObject.get("fintech_use_num").toString());
		resList.setAccount_alias(res_listObject.get("account_alias").toString());
		resList.setBank_code_std(res_listObject.get("bank_code_std").toString());
		resList.setBank_code_sub(res_listObject.get("bank_code_sub").toString());
		resList.setBank_name(res_listObject.get("bank_name").toString());
		resList.setAccount_num_masked(res_listObject.get("account_num_masked").toString());
		resList.setAccount_holder_name(res_listObject.get("account_holder_name").toString());
		resList.setAccount_type(res_listObject.get("account_type").toString());
		resList.setInquiry_agree_yn(res_listObject.get("inquiry_agree_yn").toString());
		resList.setInquiry_agree_dtime(res_listObject.get("inquiry_agree_dtime").toString());
		resList.setTransfer_agree_yn(res_listObject.get("transfer_agree_yn").toString());
		resList.setTransfer_agree_dtime(res_listObject.get("transfer_agree_dtime").toString());
		resList.setAccount_state(res_listObject.get("account_state").toString());

		ResListMap.getInstance().put(i, resList); 							// 키는 i값, 밸류는 각 i에 해당하는 계좌리스트들이 저장된 객체
 
%>


<html>

<head>
</head>
<body>

	<h2 align="center">계좌 List</h2>
	<%
		for (int i = 0; i < ResListMap.getInstance().size(); i++) {
	%>
	<div class="w3-container" style="float: left; width: 50%;">
		<a href="/TeamProject_v3/board/transactionProc.jsp?num<%=i%>=<%=i%>">
			<div class="w3-card-4"">
				<header class="w3-container w3-blue">
					<h1 align="center">
						<b><%=ResListMap.getInstance().get(i).getBank_name()%> <b />
					</h1>
				</header>
				<div class="w3-container">
					<p><%=ResListMap.getInstance().get(i).getAccount_alias()%><b />
					</p>
					<hr>
					<%=ResListMap.getInstance().get(i).getAccount_num_masked()%>
					</p>

				</div>
				<footer class="w3-container  w3-blue">
					<br />
					<h5></h5>
				</footer>
		</a>
	</div>
	</div>
	<%
		}
	%>

</body>
</html>