<%
	request.setCharacterEncoding("UTF-8");
%>
<%@ page contentType="text/html; charset=UTF-8"%>
<head>
<script type="text/javascript">
function idCheck(id) {
	var idcheck = document.getElementById("idCheck");
	if (id.length < 8) {
		idcheck.innerHTML = "8자리로 만들어라";
	} else {
		idcheckOfServer(id);
	}
	url = "idCheck.jsp?id=" + id;
}

function idcheckOfServer(id) {
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function(){
		var idcheck = document.getElementById("idCheck");
		if(this.readyState == 4 && this.status == 200){
			var str = this.responseText;
			idcheck.innerHTML=str;
			return str;
		}
	};
	var params = "?id="+encodeURIComponent(id);
		xhttp.open("GET", "<%=path%>/nohead/idCheck.jsp" + params, true);
		xhttp.send();
	}
</script>
</head>
<header class="masthead d-flex pt-4">
	<div class="container text-center my-auto">
		<div class="col-md-8 m-auto">
			<br />
			<table class = "table table-light table-borderless rounded-lg">
				<tr>
					<td>
						<form name="regFrm" method="post" action="<%=path%>/member/memberProc.jsp">
							<input type="hidden" name="auth" value="0" />
							<table class="table table-striped table-light" width="70%">
								<thead>
									<tr>
										<th class="pl-4 align-middle pt-4" scope="col" colspan="2"><h3>회원가입</h3></th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td class="pl-4 align-middle"><label for="id"><b>아이디</b></label></td>
										<td><input type="text"
											class="form-control form-control-lg col-md-8" id="id"
											name="id" onkeyup="idCheck(this.form.id.value)"> <span
											id="idCheck"></span></td>
									</tr>
									<tr>
										<td class="pl-4 align-middle"><label for="inputName"><b>이름</b></label></td>
										<td><input type="text"
											class="form-control form-control-lg col-md-8" id="inputName"
											name="name"></td>
									</tr>
									<tr>
										<td class="pl-4 align-middle"><label for="inputPassword1"><b>비밀번호</b></label></td>
										<td><input type="password"
											class="form-control form-control-lg col-md-8"
											id="inputPassword1" name="pwd"></td>
									</tr>
									<tr>
										<td class="pl-4 align-middle"><label for="inputPassword2"><b>비밀번호
													확인</b></label></td>
										<td><input type="password"
											class="form-control form-control-lg col-md-8"
											id="inputPassword2" name="repwd"></td>
									</tr>
									<tr>
										<td class="pl-4 align-middle"><label for="inputEmail"><b>이메일</b></label></td>
										<td><input type="email"
											class="form-control form-control-lg col-md-8" id="inputEmail"
											placeholder="name@example.com" name="email"></td>
									</tr>
									<tr>
										<td colspan="3" align="center">
											<button type="button" class="btn btn-primary btn-lg active"
												onclick="inputCheck()">회원가입</button>
											<button type="reset" class="btn btn-light btn-lg active">다시쓰기</button>
										</td>
									</tr>
								</tbody>
							</table>
						</form>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<div class="overlay"></div>
</header>