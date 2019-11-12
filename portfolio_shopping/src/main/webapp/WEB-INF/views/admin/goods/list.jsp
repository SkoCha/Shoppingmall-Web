<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="../../commons/header.jsp" %>

<div class="panel panel-default">
  <div class="panel-heading">
    <b><h3 class="panel-title">관리자 상품 목록 페이지</h3></b>
  </div>
  <div class="panel-body">
    <div class="row">
        <div class="col-md-12">
        <h4>상품 목록 리스트</h4>
        <div class="table-responsive">                
        	<table id="mytable" class="table table-bordred table-striped">
	            <thead>                   
	                   <th>번호</th>
	                   <th>상품명</th>
	                   <th>카테고리</th>
	                   <th>가격</th>
	                   <th>수량</th>
	                   <th>등록 날짜</th>                      
	                   <th>삭제</th>
               	</thead>
    			<tbody>
    				<c:forEach items="${list}" var="list">    
					    <tr>
						    <td>${list.gdsNum}</td>
						    <td>
						    	<a href="/admin/goods/view?num=${list.gdsNum}">${list.gdsName}</a>
						    </td>
						    <td>${list.cateName}</td>
						    <td><fmt:formatNumber value="${list.gdsPrice}" pattern="###,###,###"/></td>
						    <td>${list.gdsStock}</td>
						    <td><fmt:formatDate value="${list.gdsDate}" pattern="yyyy-MM-dd"/></td>
						    <td><p data-placement="top" data-title="Delete"><button class="btn btn-danger btn-xs" data-title="Delete" data-toggle="modal" data-target="${list.gdsNum}" ><span class="glyphicon glyphicon-trash" aria-hidden="true"></span></button></p></td>
					    </tr>
				    </c:forEach>
					    <script>
					    	$("button[data-title='Delete']").click(function(){
					    		var target = $(this).attr("data-target");
					    		// console.log(target);
					    		var conf = confirm("상품번호 : " + target + "을 삭제하시겠습니까?");
					    		if(conf) {
					    			$.ajax({
					    				url : "/admin/goods/list/" + target,
					    				type : "delete",
					    				success : function(result){
	                    					if(result) {
	                     					location.href = "/admin/goods/list";
	                    					} else {
	                    						alert("상품 삭제에 실패하였습니다.");
	                    					}
	                    				}
					    			});
					    		}
					    		
					    	});
					    </script>
  				</tbody>
			</table>
			</div>
		</div>
	</div>
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
</script>
	
<%@ include file="../../commons/footer.jsp" %>