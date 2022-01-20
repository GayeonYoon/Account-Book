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
<%@page import="org.json.simple.JSONObject"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
	String jsonString = request.getParameter("json");
	jsonString = jsonString.replaceAll("\'", "\"");
	System.out.println(jsonString);
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

<style>
h1, h2, h3, h4, h5 {
	font-family: -webkit-pictograph;
}

div {
	float: center;
	background-size: 100% 100%;
}

h2 {
	font-color: gray;
}

.btn {
	box-shadow: 0 0 0 0 rgba(0, 0, 0, .1);
}

.btn-outline-secondary {
	color: #6c757d;
	border-color: #9e9e9e00;
	font-size: small;
}

.btn-outline-dark {
	color: #6d6f71;
	border-color: #757b7d;
}
</style>

<div class="container mb-5">
	<%
		for (int i = 0; i < list.size(); i++) {
	%>
	<div class="card text-center mx-auto mt-3" style="max-width: 500px;">
		<div class="card-body" style="background-image: URL(<%=path %>/img/bg-account.png);">
			<!-- 삭제  버튼 -->
			<div class="float-right ">
				<button id="cancel<%=i%>" type="button" class="close" aria-label="Close" onclick="sendFintechUseNum(this, '<%=list.get(i).getFintech_use_num()%>')"
					class="btn btn-outline-secondary" data-toggle="modal"
					data-target="#cancelModal">
				  <span aria-hidden="true">&times;</span>
				</button>
			</div>
			<h2 align="left" font-color="gray"><%=list.get(i).getBank_name()%></h2>
			<p class="card-text" align="left"><%=list.get(i).getAccount_num_masked()%></p>
			<button id="list<%=i%>" type="button" class="btn btn-outline-secondary"
				onclick="submitFrm('<%=list.get(i).getFintech_use_num()%>','<%=list.get(i).getAccount_alias()%>','<%=list.get(i).getBank_name()%>','<%=list.get(i).getAccount_num_masked()%>')">내역
				보기</button>
		</div>
	</div>
	<%
		}
	%>
	<!-- 계좌 삭제 Modal -->
	<div class="modal fade text-center" id="cancelModal" tabindex="-1"
		aria-labelledby="deleteModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="deleteModalLabel">알림</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">등록된 계좌를 삭제 하시겠습니까?</div>
				<form name="cancelFrm" method="post"
					action="<%=path%>/bankingProc/accountCancelProc.jsp">
					<input type="hidden" id="fintechUseNum_cancel" name="fintechUseNum"
						value="" />
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">취소</button>
						<button class="btn btn-primary"
							onclick="document.deleteFrm.submit();">삭제</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- 내역보기로 보내질 form -->
	<form id="frm" method="post" action="">
		<input type="hidden" id="fintech_use_num" name="fintech_use_num" value="">
		<input type="hidden" id="account_alias" name="account_alias" value="">
		<input type="hidden" id="bank_name" name="bank_name" value="">
		<input type="hidden" id="account_num" name="account_num" value="">
	</form>
</div>

<script>
	// 버튼에 따라 form 제출 주소가 달라진다.
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

	// 삭제 시 fintechUseNum을 받아보려한 함수
	function sendFintechUseNum(e, num) {
		var id = e.getAttribute('id');
		document.getElementById('fintechUseNum_cancel').value = num;
	}
</script>