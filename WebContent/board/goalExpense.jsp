<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<style>
* {
	box-sizing: border-box;
}

img {
	max-width: 100%;
	display: block;
	margin: 0px 0px 500px 0px;
}

/* basic stylings ------------------------------------------ */
.container {
	font-family: 'Roboto';
	width: 700px;
	margin: 30px auto 0;
	display: block;
	background: #FFF;
	padding: 10px 50px 50px;
}

h2 {
	margin-bottom: 50px;
}

/* form starting stylings ------------------------------- */
.group {
	position: relative;
	margin-bottom: 45px;
}

input {
	font-size: 18px;
	padding: 10px 10px 10px 5px;
	display: block;
	width: 300px;
	border: none;
	border-bottom: 1px solid #757575;
}

input:focus {
	outline: none;
}

/* LABEL ======================================= */
label {
	color: #999;
	font-size: 18px;
	font-weight: normal;
	position: absolute;
	pointer-events: none;
	left: 5px;
	top: 10px;
	transition: 0.2s ease all;
	-moz-transition: 0.2s ease all;
	-webkit-transition: 0.2s ease all;
}

/* active state */
input:focus ~ label, input:valid ~ label {
	top: -20px;
	font-size: 14px;
	color: #5264AE;
}

/* BOTTOM BARS ================================= */
.bar {
	position: relative;
	display: block;
	width: 300px;
}

.bar:before, .bar:after {
	content: '';
	height: 2px;
	width: 0;
	bottom: 1px;
	position: absolute;
	background: #5264AE;
	transition: 0.2s ease all;
	-moz-transition: 0.2s ease all;
	-webkit-transition: 0.2s ease all;
}

.bar:before {
	left: 50%;
}

.bar:after {
	right: 50%;
}

/* active state */
input:focus ~ .bar:before, input:focus ~ .bar:after {
	width: 50%;
}

/* HIGHLIGHTER ================================== */
.highlight {
	position: absolute;
	height: 60%;
	width: 100px;
	top: 20%;
	left: 0;
	pointer-events: none;
	opacity: 0.5;
}

/* active state */
input:focus ~ .highlight {
	-webkit-animation: inputHighlighter 0.3s ease;
	-moz-animation: inputHighlighter 0.3s ease;
	animation: inputHighlighter 0.3s ease;
}

/* ANIMATIONS ================ */
@
-webkit-keyframes inputHighlighter {from { background:#5264AE;
	
}

to {
	width: 0;
	background: transparent;
}

}
@
-moz-keyframes inputHighlighter {from { background:#5264AE;
	
}

to {
	width: 0;
	background: transparent;
}

}
@
keyframes inputHighlighter {from { background:#5264AE;
	
}

to {
	width: 0;
	background: transparent;
}
}
</style>



<div class="container">
	<br>

	<h2>목표 지출금액 설정</h2>

	<div style="margin: 10%; width: 60%;">
		<form method="post" action="goalExpenseProc.jsp">

			<div class="group">
				<input type="text" name="cost" required> <span
					class="highlight"></span> <span class="bar"></span> <label>목표 지출금액</label> <br />
			</div>
			<div class="float-right mt-5">
				<button class="btn btn-outline-info btn-sm" type="submit">설정</button>
				<button class="btn btn-outline-secondary btn-sm" type="reset">다시쓰기</button>
			</div>
		</form>

		<img src="<%=path %>/img/bg-pig.png" alt="" loading="lazy">
	</div>
</div>