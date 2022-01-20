<%@page import="openBanking.apiClient"%>
<%@page import="account.*"%>
<%@page import="java.time.Month"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.*"%>
<%@page import="org.json.simple.*"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="member.MemberDTO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="apiClient" class="openBanking.apiClient" />
<jsp:useBean id="account" class="account.Account" />
<%
	request.setCharacterEncoding("UTF-8");

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

	jsonString = jsonString.replaceAll("\"", "\'");
	rd.close();
	conn.disconnect();

	jsonString = jsonString.replaceAll("\'", "\"");
	JSONParser parser = new JSONParser(); //json형식을 띄고있는 모든 형식들을 파싱해주는 클래스
	Object obj = parser.parse(jsonString); //jsonString(String type) to Object
	JSONObject jsonObj = (JSONObject) obj; // Object to JsonObject
	JSONArray jsonArray = (JSONArray) jsonObj.get("res_list"); //JSONObjet to jsonArray("res_list")

	ArrayList<Account> list = new ArrayList<>();

	for (int i = 0; i < jsonArray.size(); i++) {
		JSONObject res_listObject = (JSONObject) jsonArray.get(i); //JSONArray to JSONObject

		Account resList = new Account(); // 저장시켜줄 resList객체

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

		list.add(resList);
	}
%>
<style TYPE="text/css">
table {
	font-size: 15pt;
}

#chartdiv {
	width: 100%;
	height: 500px;
}

#chartdiv1 {
	width: 100%;
	height: 500px;
}

.jumbotron a {
	color: white;
}
</style>
<!-- MY PAGE 상단 -->
<div
	class="jumbotron jumbotron-fluid mb-5 border-bottom-0 rounded-bottom bg-info text-white pb-1">
	<div class="container">
		<h2 class="display-6"><%=mMgr.getMember(id).getName()%>
			님 <a href=""></a>
		</h2>
		<h2>안녕하세요 : ) </h2>
		<hr class="my-4">
		<div class="row text-center d-flex justify-content-center">
			<a class="col col-lg-2"
				href="<%=request.getContextPath()%>/bankingProc/accountListProc.jsp"><i
				class="fas fa-credit-card fa-2x"></i>
				<p>계좌 등록</p></a> <a class="col col-md-auto"
				href="<%=request.getContextPath()%>/board/setting.jsp"><i
				class="fas fa-cog fa-2x"></i>
				<p>설정</p></a> <a class="col col-lg-2" href="<%=path%>/member/logout.jsp"><i
				class="fas fa-sign-out-alt fa-2x"></i>
				<p>로그아웃</p></a>
		</div>
	</div>
</div>

<!-- MY PAGE 컨텐츠 -->
<div class="container pt-5" style="margin-top: 50px;">
	<table class="table table-hover">
		<tbody align="center">
			<tr>
				<th scope="row">아이디</th>
				<td colspan="3"><%=id%></td>
			</tr>
			<tr>
				<th scope="row">이름</th>
				<td colspan="3"><%=mMgr.getMember(id).getName()%></td>
			</tr>
			<tr>
				<th scope="row">이메일 주소</th>
				<td colspan="3"><%=mMgr.getMember(id).getEmail()%></td>
			</tr>
			<tr>
				<th scope="row">이번달 목표 지출액</th>
				<td colspan="3"><%=mMgr.getMember(id).getGoalExpense()%>원</td>
			</tr>
			<tr>
				<th scope="row">연동 계좌</th>
				<td colspan="3">
					<div class="btn-group">
						<button type="button" class="btn btn-primary dropdown-toggle"
							data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
							계좌 목록</button>

						<div class="dropdown-menu">
							<%
								for (int i = 0; i < list.size(); i++) {
							%>
							<a class="dropdown-item"
								href="javascript:submitFrm('<%=list.get(i).getFintech_use_num()%>','<%=list.get(i).getAccount_alias()%>','<%=list.get(i).getBank_name()%>','<%=list.get(i).getAccount_num_masked()%>')">
								<%=list.get(i).getBank_name()%> (<%=list.get(i).getAccount_num_masked()%>)
							</a>
							<%
								}
							%>
						</div>
					</div>
				</td>
			</tr>
		</tbody>
	</table>
	<hr>
</div>
<!-- 내역보기로 보내질 form -->
<form id="frm" method="post" action="">
	<input type="hidden" id="fintech_use_num" name="fintech_use_num"
		value=""> <input type="hidden" id="account_alias"
		name="account_alias" value=""> <input type="hidden"
		id="bank_name" name="bank_name" value=""> <input type="hidden"
		id="account_num" name="account_num" value="">
</form>
<script>
//버튼에 따라 form 제출 주소가 달라진다.
function submitFrm(finNum, alias, bank, num) {
	var fintechUseNum = finNum;
	var accountAlias = alias;
	var bankName = bank;
	var accountNum = num;
	// 내역보기를 눌렀을 경우
	document.getElementById('frm').action = '<%=path%>/bankingProc/accountTransactionListProc.jsp';
	document.getElementById('fintech_use_num').value = fintechUseNum;
	document.getElementById('account_alias').value = accountAlias;
	document.getElementById('bank_name').value = bankName;
	document.getElementById('account_num').value = accountNum;
	document.getElementById('frm').submit();
}
</script>