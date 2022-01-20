<%@page import="member.MemberDTO"%>
<%
   request.setCharacterEncoding("UTF-8");
%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="account.*"%>
<%@page import="org.codehaus.jackson.map.ObjectMapper"%>
<%@page import="json.jsonParsing"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%

	String jsonString = request.getParameter("json");

   	jsonString = jsonString.replaceAll("\'", "\""); 
   	JSONParser parser = new JSONParser(); //json형식을 띄고있는 모든 형식들을 파싱해주는 클래스
   	Object obj = parser.parse(jsonString); //jsonString(String type) to Object
   	JSONObject jsonObj = (JSONObject) obj; // Object to JsonObject
   	JSONArray jsonArray = (JSONArray) jsonObj.get("res_list"); //JSONObjet to jsonArray("res_list") 
/* --------------------------------------------------------------------------------------- */
   	String fintech_use_num = request.getParameter("fintech_use_num");
   	String account_alias = request.getParameter("account_alias");
   	String bank_name = request.getParameter("bank_name");
   	String account_num = request.getParameter("account_num");
%>



<header>
	<div
		class="jumbotron jumbotron-fluid mb-5 border-bottom-0 rounded-bottom text-white bg-dark" style="padding: 2rem" align="center">
		<div class="container">
			<div class="row justify-content-md-center mb-2">
				<h2 class="m-0"><%=account_alias%></h2>
				<button class="text-right ml-2" type="button" style="background-color: rgba(0, 0, 0, 0); border: 0; outline: 0;"
					data-toggle="modal" data-target="#updateModal">
					<i class="far fa-edit" style="font-size: 20px; color: white;"></i>
				</button>
			</div>
			<hr>
			<div class="row justify-content-md-center">
				<div class="h5 mr-2"><%=bank_name%></div>
				<div class="h5 ml-2"><%=account_num %></div>
			</div>
			<div class="row justify-content-md-center">
				<div id="tran_amount"></div>
			</div>
		</div>
	</div>
</header>


<div id="democlass" class="container mb-5" style="max-width: 540px">
	<%
      // 초기 설정은 현재 년도, 월을 기준으로 한다.
      SimpleDateFormat yearFormat = new SimpleDateFormat("yyyy");
      SimpleDateFormat monthFormat = new SimpleDateFormat("MM");
      Date d = new Date();
      int currentYear = Integer.parseInt(yearFormat.format(d));
      int currentMonth = Integer.parseInt(monthFormat.format(d));
   %>
	<!-- 월 선택 -->
	<div class="input-group">
		<select class="custom-select" id="inputGroupChoiceMonth"
			aria-label="Example select with button addon">
			<%
            for (int i = currentMonth; i >= 1; i--) {
         %>
			<option value="<%=i%>"><%=currentYear%>년
				<%=i%>월
			</option>
			<%
            }
         %>
		</select>
		<div class="input-group-append">
			<button class="btn btn-outline-secondary" type="button"
				id="controlMonth">조회하기</button>
		</div>
	</div>
	<div id="canvas"></div>
</div>
<!-- 계좌 정보 수정 Modal -->
<div class="modal fade mt-5" id="updateModal" tabindex="-1"
	aria-labelledby="updateModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-body">
				<div class="mt-3 mb-3" style="text-align: center;">
					<h5>계좌 이름 변경</h5>
				</div>
				<form name="updateFrm" method="post"
					action="<%=path%>/bankingProc/accountUpdateInfoProc.jsp">
					<input type="hidden" id="fintechUseNum_update" name="fintechUseNum"
						value="<%=fintech_use_num %>" /> <input type="text"
						class="form-control form-control-lg col-md-8 m-auto"
						name="accountAlias" autofocus>
					<div class="modal-footer mt-3">
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">취소</button>
						<button type="button" class="btn btn-primary"
							onclick="document.updateFrm.submit();">변경</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<script>
	function checkedMonth() {
		var options = document.getElementById('inputGroupChoiceMonth').getElementsByTagName('option');
		for (var i = 0; i < options.length; i++) {
			if (options[i].value == <%=currentMonth%>) {
				options[i].selected = true;
			}
		}
	}
	checkedMonth();
</script>

<script>
var list = '<%=jsonArray%>';
var data = JSON.parse(list);
if(list.includes('after_balance_amt')){
	$('#tran_amount').html('<h3>' + data[data.length-1].after_balance_amt.replace(/\B(?=(\d{3})+(?!\d))/g, ",")+'원</h3>');	
}else{
	$('#tran_amount').html('<h3>잔액이 없습니다.</h3>');
}

function foo(){
	$('#canvas').html('');
    var month = $('#inputGroupChoiceMonth').val();
    var date;
    var index = 0;
    for(var i = 0; i < data.length;i++){
    	var dataMonth = data[i].tran_date.substring(4, 5)=="0" ? data[i].tran_date.substring(5, 6) : data[i].tran_date.substring(4, 6);
    	var dataDay = data[i].tran_date.substring(6);
    	if(dataMonth==month){
    		$('#canvas').append('<div class="mx-auto mt-3" style="max-width: 700px;"><h4>'+month+'월 '+ dataDay +'일</h4></div>');
    		var cardBody = $('#canvas').append('<div id="card'+index+'" class="card mx-auto border-dark bg-white" style="max-width: 700px;"><div class="card-body row"></div></div>');
    		var cardBodyUl = cardBody.children('#card'+index+++'').children('div').append('<ul class="list-inline mt-2 col"></ul>');
    		// 거래 종류에 따른 이미지 출력
    		var imgPath;
    		if(data[i].inout_type.includes('입금')){
    			imgPath = 'in.jpg';
    		}else{
    			if(data[i].tran_type.includes('식비')){
	    			imgPath = 'food.jpg';
	    		}else if(data[i].tran_type.includes('교통비')){
	    			imgPath = 'transportation.jpg';
	    		}else if(data[i].tran_type.includes('여가') || data[i].tran_type.includes('문화') ){
	    			imgPath = 'culture.jpg';
	    		}else if(data[i].tran_type.includes('쇼핑')){
	    			imgPath = 'shopping.jpg';
	    		}else{
	    			imgPath = 'etc.jpg';
	    		}
    		}
  			var cardBodyUl_li1 = cardBodyUl.children('ul').append('<li class="list-inline-item"><img src="<%=path%>/img/tranType/'
																	+ imgPath
																	+ '" alt="img" class="rounded-circle ml-3" width="75px"></li>');
			var cardBodyUl_li2 = cardBodyUl.children('ul').append('<li class="list-inline-item ml-3"><div style="color: black; vertical-align: middle; font-size: 1em;">'
									+ data[i].branch_name + '</div></li>');

			// 입금, 출력에 따라 글자 색상 결정
			var fontColor;
			var tranAmt;
			if (data[i].inout_type.includes('입금')) {
				fontColor = 'text-primary';
				// 정규식을 활용한 천 단위 , 생성
				tranAmt = '+' + data[i].tran_amt.toString().replace(
								/\B(?=(\d{3})+(?!\d))/g, ",");
			} else {
				fontColor = 'text-danger';
				// 정규식을 활용한 천 단위 , 생성
				tranAmt = '-' + data[i].tran_amt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			}
			var balanceAmt = data[i].after_balance_amt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			var cardBodyUl_li3 = cardBodyUl.children('ul').append('<li class="list-inline-item ml-3 text-right float-right"><h3 class="'+fontColor+'">'
																	+ tranAmt
																	+ '원</h3><h5 style="color: grey;">'
																	+ balanceAmt + '원</h5></li>');
		}
	}
	if (index == 0) {
		$('#canvas').append('<div class="shadow-sm p-3 mt-5 mb-5 bg-white rounded text-center"><h4>거래 내역이 없습니다!</h4></div>');
	}
};
$('document').ready(foo).keyup();
$('#controlMonth').click(foo).keyup();
</script>