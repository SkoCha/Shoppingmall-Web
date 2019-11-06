<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../../commons/header.jsp" %>

<style>
	#select_image { margin-top: 20px;}
</style>

<div class="panel panel-default">
  <div class="panel-heading">
    <h1 class="panel-title"><b>상품 등록</b></h1>
  </div>
  <div class="panel-body">
	<form role="form" class="form-horizontal" method="post" autocomplete="off" enctype="multipart/form-data">
 			<div class="form-group">	
 				<div class="col-xs-3">
	  			<label>1차 분류</label>
	  			<select class="form-control category1">
	  				<option value="">전체</option>
	  			</select>
  			</div>
  			<div class="col-xs-3">
	  			<label>2차 분류</label>
	  			<select class="form-control category2" name="cateCode">
	  				<option value="">전체</option>
	  			</select>
	  		</div>
  		</div>
		<div class="form-group">
			<div class="col-xs-3">
				<label>상품명</label>
				<input class="form-control" type="text" name="gdsName">
			</div>
		</div>
		<div class="form-group">
			<div class="col-xs-3">
				<label>상품 가격</label>
				<input class="form-control" type="text" name="gdsPrice">
			</div>
		</div>
		<div class="form-group">
			<div class="col-xs-3">
				<label>상품 수량</label>
				<input class="form-control" type="text" name="gdsStock">
			</div>
		</div>
		<div class="form-group">
			<div class="col-xs-9">
				<label>상품 설명</label>
				<textarea class="form-control" rows="5" cols="10" name="gdsDesc"></textarea>
				<script>
					 var ckeditor_config = {
					   resize_enaleb : false,
					   enterMode : CKEDITOR.ENTER_BR,
					   shiftEnterMode : CKEDITOR.ENTER_P,
					   filebrowserUploadUrl : "/admin/goods/ckUpload"
					 };
					 
					 CKEDITOR.replace("gdsDesc", ckeditor_config);
				</script>
			</div>
		</div>
		<div class="form-group">
			<div class="col-xs-6">
	  			<label>상품 이미지</label>
	  			<input type="file" id="gdsImg" name="file">
	  			<img id="select_image" src=""/>
	  			<script>
	  				$("#gdsImg").change(function(){
	  					if(this.files && this.files[0]) {
	  						var reader = new FileReader;
	  						reader.onload = function(data) {
	  							$("#select_image").attr("src", data.target.result).width(500);
	  						}
	  						reader.readAsDataURL(this.files[0]);
	  					}
	  				});
	  			</script>
	  			<%=request.getRealPath("/")%>	  			
	  		</div>
	  	</div>	
		<div class="form-group">
			<div class="col-xs-3">
				<button class="btn btn-primary" type="submit">상품 등록</button>
			</div>
		</div>
	</form>
	</div>
  </div>

<script type="text/javascript">
/** * 컨트롤러에서 데이터 받기 ** */
var jsonData = JSON.parse('${category}');
console.log(jsonData);

/** * 1차 분류 ** */
var cate1Arr = new Array();
var cate1Obj = new Object();

for (var i = 0; i < jsonData.length; i++) {

	if (jsonData[i].level == "1") {
		cate1Obj = new Object(); // 초기화
		cate1Obj.cateCode = jsonData[i].cateCode;
		cate1Obj.cateName = jsonData[i].cateName;
		cate1Arr.push(cate1Obj);
	}

}

var cate1Select = $("select.category1")

for (var i = 0; i < cate1Arr.length; i++) {
	cate1Select.append("<option value='" + cate1Arr[i].cateCode + "'>"
			+ cate1Arr[i].cateName + "</option>");
}

/** * 2차 분류 ** */
$(document).on("change", "select.category1", function() {

		var cate2Arr = new Array();
		var cate2Obj = new Object();

		for (var i = 0; i < jsonData.length; i++) {

			if (jsonData[i].level == "2") {
				cate2Obj = new Object(); // 초기화
				cate2Obj.cateCode = jsonData[i].cateCode;
				cate2Obj.cateName = jsonData[i].cateName;
				cate2Obj.cateCodeRef = jsonData[i].cateCodeRef;

				cate2Arr.push(cate2Obj);
			}
		}

		var cate2Select = $("select.category2")

		cate2Select.children().remove();

		$("option:selected", this).each(function() {

			var selectVal = $(this).val();
			cate2Select.append("<option value='" + selectVal + "'>전체</option>");

			for (var i = 0; i < cate2Arr.length; i++) {
				if (selectVal == cate2Arr[i].cateCodeRef) {
					cate2Select.append("<option value='"
							+ cate2Arr[i].cateCode + "'>"
							+ cate2Arr[i].cateName + "</option>");
				}
			}
		});

});

//상품 가격, 수량 숫자 이외 입력 금지
var regExp = /[^0-9]/gi;

$("#gdsPrice").keyup(function() { numCheck($(this)); });
$("#gdsStock").keyup(function() { numCheck($(this)); });

function numCheck(selector) {
	var tempVal = selector.val();
	selector.val(tempVal.replace(regExp, ""));
}

</script>
	
<%@ include file="../../commons/footer.jsp" %>