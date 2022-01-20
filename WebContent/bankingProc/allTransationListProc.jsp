<%@page import="openBanking.apiClient"%>
<%@page import="account.*"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="org.json.simple.*"%>
<%@page import="java.text.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@page import="java.net.*"%>
<%@page import="member.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mMgr" class="member.MemberDAO" />
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String) session.getAttribute("idKey");
	String path = request.getRequestURL().substring(0, request.getRequestURL().indexOf("/", 7))
			+ request.getContextPath();

	MemberDTO mem = mMgr.getMember(id);
	String addr = "https://testapi.openbanking.or.kr/v2.0/account/list?";
	String user_seq_no = mem.getUser_seq_no();
	String access_token = mem.getAccess_token();

	int outerMap_size = 0;
	int innerMap_size = 0;

	//파라미터 생성해서 보내기
	String parameter = "";
	parameter = parameter + "user_seq_no=" + user_seq_no;
	parameter = parameter + "&" + "include_cancel_yn=" + "Y";
	parameter = parameter + "&" + "sort_order=" + "D";

	addr = addr + parameter;

	URL url = new URL(addr);
	HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	conn.setRequestMethod("GET");
	conn.setRequestProperty("Authorization", "Bearer " + access_token);

	BufferedReader rd;
	if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
		rd = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));
	} else {
		rd = new BufferedReader(new InputStreamReader(conn.getErrorStream(), "utf-8"));
	}

	String jsonString = rd.readLine();
	
	rd.close();
	conn.disconnect();
	if(jsonString.contains("A0000")){
	
	JSONParser parser = new JSONParser(); //json형식을 띄고있는 모든 형식들을 파싱해주는 클래스
	Object obj = parser.parse(jsonString); //jsonString(String type) to Object
	
	JSONObject jsonObj = (JSONObject) obj; // Object to JsonObject
	JSONArray jsonArray = (JSONArray) jsonObj.get("res_list"); //JSONObjet to jsonArray("res_list")

	ArrayList<String> fintechUseNumList = new ArrayList<String>();
	System.out.println(jsonArray);

	for (int i = 0; i < jsonArray.size(); i++) {
		JSONObject fintechObject = (JSONObject) jsonArray.get(i); //JSONArray to JSONObject 
		fintechUseNumList.add(fintechObject.get("fintech_use_num").toString());
	}
	System.out.println("핀테크 목록 : " + fintechUseNumList.size() + ", " + fintechUseNumList);

	//2. 전체 계좌 내역 받아오기
	
	// 전체 계좌 내역목록 객체로 받을 리스트
	// ArrayList<AccountTransactionList> AllTranscationList = new ArrayList<AccountTransactionList>();
	// 전체 계좌 내역목록 스트링으로 받을 변수
	String result = "";

	// bank_tran_id / 은행거래고유번호 -> 이용기관코드 + U + 9자리난수
	long num = 0;
	while (("" + num).length() != 9) {
		num = (long) (Math.random() * 1000000000);
	}
	
	for (int i = 0; i < fintechUseNumList.size(); i++) {
		// 요청 보낼 URL
		addr = "https://testapi.openbanking.or.kr/v2.0/account/transaction_list/fin_num?";
		
		// 파라미터에 필요한 요소들
		// fintech_use_num
		String fintech_use_num = fintechUseNumList.get(i);
		// back_tran_id
		String bank_tran_id = apiClient.getCode() + "U" + (num++);
		// tran_dtime / 요청일시->현재시간
		Date today = new Date();
		SimpleDateFormat dtimeDate = new SimpleDateFormat("yyyyMMdd");
		SimpleDateFormat dtimeTime = new SimpleDateFormat("hhmmss");
		
		parameter = "";
		parameter = parameter + "bank_tran_id=" + bank_tran_id;
		parameter = parameter + "&" + "fintech_use_num=" + fintech_use_num;
		parameter = parameter + "&" + "inquiry_type=A"; // A:All, I:입금, O:출금
		parameter = parameter + "&" + "inquiry_base=D"; // D:일자 , T:시간
		parameter = parameter + "&" + "from_date=" + dtimeDate.format(today);
		parameter = parameter + "&" + "to_date=" + dtimeDate.format(today);
		parameter = parameter + "&" + "sort_order=A"; // D:내림차순, A:오름차순
		parameter = parameter + "&" + "tran_dtime=" + dtimeDate.format(today) + dtimeTime.format(today);
		System.out.println("parameter" + (i + 1) + " : " + parameter);

		addr = addr + parameter;
		url = new URL(addr);
		conn = (HttpURLConnection) url.openConnection();
		// method 방식
		conn.setRequestMethod("GET");
		// http header 설정
		conn.setRequestProperty("Authorization", "Bearer " + access_token);

		rd = null;
		if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
			rd = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));
		} else {
			rd = new BufferedReader(new InputStreamReader(conn.getErrorStream(), "utf-8"));
		}

		String transactionListJson = rd.readLine();

		rd.close();
		conn.disconnect();

		// A0000 : 성공메시지
		if (transactionListJson.contains("A0000")) {
			System.out.println("상세내역목록" + (i + 1) + " : " + transactionListJson);
			
			// Json 라이브러리
			parser = new JSONParser();
			obj = parser.parse(transactionListJson);
			jsonObj = (JSONObject) obj;
			JSONArray transaciontListJsonArray = (JSONArray) jsonObj.get("res_list");

			result += transaciontListJsonArray;
		}
	}
	result = result.replaceAll("\\]\\[", ",").replaceAll("\"","\'");
	System.out.println("나의 모든 계좌 거래내역 Str : " + result);
	
	// Multi Threading 가능한 싱글톤에 json을 저장한다.
	AllTransationListJSON.getInstance().setJson(result);
	
	}
%>
<script>
	location.href = '<%=path%>/board/index.jsp';
</script>