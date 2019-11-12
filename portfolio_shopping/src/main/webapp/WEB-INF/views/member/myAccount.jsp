<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../commons/header.jsp" %>
<style>
	.header { display: block; text-align: center;  }
	.header > h1 { float: none; padding: 0 20px 30px 20px; border-bottom: 1px solid #eee; }
</style>
<div class="panel panel-default">
  <div class="panel-body">
  	<div class="row header">
  		<h1>회원 정보 페이지</h1>
  	</div>
  	<div class="col-md-4">
  	</div>	
  	<div class="col-md-4">
	<form class="form-horizontal" role="form" action="/member/myAccount" method="post" autocomplete="off">
		<div class="form-group">
			<label>이메일</label>
			<input class="form-control" type="email" name="userId" value="${myInfo.userId}" readonly="readonly" placeholder="이메일을 입력하세요." required="required">
		</div>
		<div class="form-group">
			<label>이름</label>
			<input class="form-control" type="text" name="userName" value="${myInfo.userName}" placeholder="이름을 입력하세요." required="required">
		</div>
		<div class="form-group">
			<label>휴대폰번호</label>
			<input class="form-control" type="text" name="userPhone" value="${myInfo.userPhone}" placeholder="휴대폰 번호 11자리를 입력하세요." required="required">
		</div>
		<div class="form-group">
			<label>현재 비밀번호</label>
			<input class="form-control" type="password" name="oldPass" placeholder="기존 비밀번호를 입력하세요." required="required">
		</div>
		<div class="form-group">
			<label>새 비밀번호</label>
			<input class="form-control" type="password" name="userPass" placeholder="8~12자리 새 비밀번호를 입력하세요." required="required">
		</div>
		<div class="form-group">
			<label>새 비밀번호 확인</label>
			<input class="form-control" type="password" name="rePass" placeholder="새 비밀번호를 다시 입력하세요." required="required">
		</div>
		<div class="form-group">
			<label>생년 월일</label>
			<input class="form-control" type="text" name="userBirth" value="${myInfo.userBirth}"  placeholder="생년월일을 8자로 입력하세요. ex. 19920505" required="required">
		</div>
		<div class="form-group">
			<label>우편 번호<input type="button" id="post_btn" class="btn btn-default pull-right btn-xs" onclick="sample2_execDaumPostcode()" value="주소 찾기"></label>
			<input type="text" id="sample2_postcode" required="required" class="form-control" placeholder="우편번호">
		</div>	
		<div class="form-group">	
			<label>주소</label><input type="text" name="userAddr1" value="${myInfo.userAddr1}" id="sample2_address" required="required" class="form-control" placeholder="주소">
		</div>	
		<div class="form-group">	
			<label>상세 주소</label><input type="text" name="userAddr2" value="${myInfo.userAddr2}" id="sample2_detailAddress" required="required" class="form-control" placeholder="상세 주소">
		</div>	
		<div class="form-group">	
			<label>참고 항목</label><input type="text" name="userAddr3" value="${myInfo.userAddr3}" id="sample2_extraAddress" required="required" class="form-control" placeholder="참고 항목">
		</div>
		<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
			<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
		</div>
									
		<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
		<script>
		    var element_layer = document.getElementById('layer');
		
		    function closeDaumPostcode() {
		        element_layer.style.display = 'none';
		    }
		
		    function sample2_execDaumPostcode() {
		        new daum.Postcode({
		            oncomplete: function(data) {
		                var addr = ''; // 주소 변수
		                var extraAddr = ''; // 참고항목 변수
		
		                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
		                    addr = data.roadAddress;
		                } else { // 사용자가 지번 주소를 선택했을 경우(J)
		                    addr = data.jibunAddress;
		                }
		
		                if(data.userSelectedType === 'R'){
		                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
		                        extraAddr += data.bname;
		                    }
		                    if(data.buildingName !== '' && data.apartment === 'Y'){
		                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
		                    }
		                    if(extraAddr !== ''){
		                        extraAddr = ' (' + extraAddr + ')';
		                    }
		                    document.getElementById("sample2_extraAddress").value = extraAddr;
		                
		                } else {
		                    document.getElementById("sample2_extraAddress").value = '';
		                }
		
		                document.getElementById('sample2_postcode').value = data.zonecode;
		                document.getElementById("sample2_address").value = addr;
		                document.getElementById("sample2_detailAddress").focus();
		
		                element_layer.style.display = 'none';
		            },
		            width : '100%',
		            height : '100%',
		            maxSuggestItems : 5
		        }).embed(element_layer);
		
		        element_layer.style.display = 'block';
		
		        initLayerPosition();
		    }
		
		    function initLayerPosition(){
		        var width = 300; //우편번호서비스가 들어갈 element의 width
		        var height = 400; //우편번호서비스가 들어갈 element의 height
		        var borderWidth = 5; //샘플에서 사용하는 border의 두께
		
		        element_layer.style.width = width + 'px';
		        element_layer.style.height = height + 'px';
		        element_layer.style.border = borderWidth + 'px solid';
		        element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
		        element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
		    }
		</script>
		<div class="form-group">
			<button type="submit" id="updateMyAccount_btn" class="btn btn-primary pull-right">정보 수정</button>
			<script>
				$("#updateMyAccount_btn").click(function(e){
					e.preventDefault();
					var oldPass = $("input[name=oldPass]").val();
					var formObj = $("form[role='form']");
					var userPass = $("input[name=userPass]").val();
					var rePass = $("input[name=rePass]").val();					
					if(userPass != rePass) {
						alert("변경할 비밀번호가 일치하지 않습니다.");
						return false;
					} else {
						// console.log(userPass);
						formObj.submit();
						alert("회원 정보 수정이 완료 되었습니다. 다시 로그인 해주세요.");
					}
				});
			</script>
		</div>	
	</form>
</div>
<div class="col-md-4">
</div>
  	</div>
  </div>
	


<%@ include file="../commons/footer.jsp" %>
