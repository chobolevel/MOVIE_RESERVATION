<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "member.MemberDAO" %>
<%@ page import = "member.Member" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>창원 시네마</title>
<script src="https://kit.fontawesome.com/4f485c5b0b.js" crossorigin="anonymous"></script>
<link rel = "stylesheet" href = "css/update_member.css">
</head>
<body>
	<div class = "reserve">
		<a href = "insert_movie.jsp"><i class="fa-solid fa-ticket"><span>&nbsp;예매하기</span></i></a>
	</div>
	<div class = "container">
		<%@ include file = "header.jsp" %>
		
		<%@ include file = "nav.jsp" %>
		
		<section>
		<%
		MemberDAO memberDAO = new MemberDAO();
		Member member = memberDAO.selectMember(id);
		String m_password = member.getPassword();
		String m_birth = member.getBirth();
		String[] phone = member.getPhone().split("-");
		String address = member.getAddress();
		%>
			<article>
				<form name = "form" method = "post" action = "update_memberProcess.jsp">
					<h1>회원 정보 수정</h1>
					<div class = "id">
						<input type = "text" name = "id" value = "<%=id %>" readOnly>
						<label>아이디</label>
					</div>
					<div class = "password">
						<input type = "password" name = "password" value = "<%=m_password %>">
						<label>비밀번호</label>
					</div>
					<div class = "passcheck">
						<input type = "password" name = "passcheck">
						<label>비밀번호 재확인</label>
					</div>
					<div class = "name">
						<input style = "width : 30%;"type = "text" name = "name" value = "<%=name %>">
						<label>이름</label>
					</div>
					<div class = "nickname">
						<input style = "width : 30%;"type = "text" name = "nickname" value = "<%=nickname %>">
						<label>닉네임</label>
					</div>
					<div class = "birth">
						 <input style = "width : 20%;"type = "text" name = "birth" placeholder = "8자리 ex)20000218" value = "<%=m_birth %>">
						 <label>생년월일</label>
					</div>
					<div class = "phone">
						<select style = "width : 10%; height : 30px;margin-left : 10px;" name = "phone1">
							<option value = "010" <%=phone[0].equals("010") ? "selected" : "" %>>010</option>
							<option value = "011" <%=phone[0].equals("011") ? "selected" : "" %>>011</option>
							<option value = "012" <%=phone[0].equals("012") ? "selected" : "" %>>012</option>
							<option value = "019" <%=phone[0].equals("019") ? "selected" : "" %>>019</option>
						</select> - 
						<input style = "width : 15%;" type = "text" name = "phone2" value = "<%=phone[1] %>"> - 
						<input style = "width : 15%;" type = "text" name = "phone3" value = "<%=phone[2] %>">
						<label>전화번호</label>
					</div>
					<div class = "address">
						<input style = "width : 100%;"type = "text" name = "address" value = "<%=address %>">
						<label>주소</label>
					</div>
					<div class = "button">
						<button id = "check">수정하기</button>
						<button id = "move">수정취소</button>
					</div>
				</form>
			</article>
		</section>
		
		<%@ include file = "footer.jsp" %>
		
	</div>
<script>
	const check = document.querySelector("#check");
	const move = document.querySelector("#move");
	const pass = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/
	const name = /^[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]+$/
	const birth = /^[0-9]{8,}$/	
	const phone = /^[0-9]{4,}$/
		
	check.addEventListener("click", e => {
		e.preventDefault();
		if(document.form.id.value == "") {
			alert("아이디가 입력되지 않았습니다.");
			document.form.id.focus();
		}
		else if(document.form.password.value == "") {
			alert("비밀번호가 입력되지 않았습니다.");
			document.form.password.focus();
		}
		else if(pass.test(document.form.password.value) == false) {
			alert("비밀번호는 최소 8자이상, \n최소 하나의 문자와 숫자를 포함해야합니다.");
			document.form.password.focus();
		}
		else if(document.form.passcheck.value == "") {
			alert("확인 비밀번호가 입력되지 않았습니다.");
			document.form.passcheck.focus();
		}
		else if(document.form.password.value != document.form.passcheck.value) {
			alert("비밀번호와 확인 비밀번호가 일치하지 않습니다.");
		}
		else if(document.form.name.value == "") {
			alert("이름이 입력되지 않았습니다.");
			document.form.name.focus();
		}
		else if(name.test(document.form.name.value) == false) {
			alert("이름은 한글로만 입력할 수 있습니다.");
			document.form.name.focus();
		}
		else if(document.form.nickname.value == "") {
			alert("닉네임이 입력되지 않았습니다");
			document.form.nickname.focus();
		}
		else if(document.form.birth.value == "") {
			alert("생년월일이 입력되지 않았습니다.");
			document.form.birth.focus();
		}
		else if(birth.test(document.form.birth.value) == false) {
			alert("생년월일은 숫자8자리로 입력해주시기 바랍니다.\n예)20000218");
			document.form.birth.focus();
		}
		else if(document.form.phone2.value == "" || document.form.phone3.value == "") {
			alert("전화번호가 입력되지 않았습니다");
		}
		else if(phone.test(document.form.phone2.value) == false || phone.test(document.form.phone3.value) == false) {
			alert("전화번호는 숫자4자리로 입력해주시기 바랍니다.");
		}
		else if(document.form.address.value == "") {
			alert("주소가 입력되지 않았습니다.");
			document.form.address.focus();
		}
		else {
			document.form.submit();
		}
	})
	
	move.addEventListener("click", e => {
		e.preventDefault();
		location.href = "login.jsp";
	})
</script>
</body>
</html>