<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<div
	class="jumbotron jumbotron-fluid mb-5 border-bottom-0 rounded-bottom bg-info text-white pb-1">
	<div class="container">
		<h2 class="display-6 text-center"><%=mMgr.getMember(id).getName()%>
			님 <a href="<%=path%>/member/update.jsp"><i class="far fa-edit"
				style="font-size: 20px; color: white;"></i></a>
		</h2>
		<hr class="my-4">
	</div>
</div>
<div class="container">
	<table class="table table-striped table-light" width="70%">
		<thead>
			<tr>
				<th class="pl-4 align-middle pt-4" scope="col" colspan="2"><h3><%=id%></h3></th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td class="pl-4 align-middle">
					<blockquote class="blockquote">
						<p class="mb-0">회원 탈퇴</p>
						<footer class="blockquote-footer">
							고객정보와 멤버십 정보가 모두 삭제됩니다.
						</footer>
					</blockquote>
				</td>
				<td class="align-middle"><h2><a href="<%=path%>/bankingProc/userCloseProc.jsp">></a></h2></td>
			</tr>
		</tbody>
	</table>
</div>