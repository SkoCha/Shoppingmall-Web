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
$(document).on(
		"change",
		"select.category1",
		function() {

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

			$("option:selected", this).each(
					function() {

						var selectVal = $(this).val();
						cate2Select.append("<option value=''>전체</option>");

						for (var i = 0; i < cate2Arr.length; i++) {
							if (selectVal == cate2Arr[i].cateCodeRef) {
								cate2Select.append("<option value='"
										+ cate2Arr[i].cateCode + "'>"
										+ cate2Arr[i].cateName + "</option>");
							}
						}
					});

		});