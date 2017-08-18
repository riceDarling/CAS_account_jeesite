<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
	<meta name="decorator" content="default"/>
	<style>
	th{
		height:25px;
		width:100px;
	}
	</style>
	<style>
img{
		max-width: 100%;
		max-height:100%;
	}
.popuptitle{
		height: 25px;
		background: url(/jeesite/img/titlebg.png) repeat-x top;
		border-radius: 4px 4px 0px 0px;
		border: 1px solid #aedef4;
		line-height: 25px;
		font-size: 14px;
		color: #1f6d8e;
		text-align: left;
		position:relative;
		background:#ffffff;
	}
.popupcontent{
		background:#efeffa;
		line-height: 28px;
		padding:3px;
		-moz-box-sizing: border-box;
		-webkit-box-sizing: border-box;
		-o-box-sizing: border-box;
		-ms-box-sizing: border-box;
		box-sizing: border-box;
		border:1px solid #aedef4;
		border-top:none;
	}
	.popupcontent>div>input[type="text"]{
		margin:0 6px;
	}
	
	.popuptitle>span{
		margin-left:10px;
	}
	.popuptitle>i{
		position:absolute;
		right:28px;
		top:0;
		width:20px;
		height:100%;
		background:url(/jeesite/img/zoom.png) no-repeat center;
		cursor: pointer;
	}
	.popuptitle>b{
		position:absolute;
		right:6px;
		top:0;
		width:20px;
		height:100%;
		background:url(/jeesite/img/closebtn.png) no-repeat center;
		cursor: pointer;
	}
	.popupbodyttl{
		background:#CBF3FF;
	}
	.edittable,.edittable2{
		border-collapse: collapse;
		-moz-box-sizing: border-box;
		-webkit-box-sizing: border-box;
		-o-box-sizing: border-box;
		-ms-box-sizing: border-box;
		box-sizing: border-box;
	}
	.edittable{
		width:100%;
	}
	.edittable>*>tr>td,.edittable>*>tr>th{
		border:1px solid #8db2e3;
	}
	.edittable2>*>tr>td,.edittable2>*>tr>th{
		border:1px solid #595959;
	}
	.edittable2{
		table-layout: fixed;
	}
	.edittable>thead>tr>th{
		background:#e0ecff;
		text-align: left;
		height:36px;
		vertical-align: bottom;
	}
	.edittable>thead>tr>th>span{
		background:#fff;
		display: inline-block;
		margin-bottom:-1px;
		vertical-align: bottom;
		border:1px solid #8db2e3;
		margin-left:10px;
		border-bottom:none;
		padding:0 6px;
		color:#3260a0;
	}
	.edittable>tbody{
		background:#fff;
	}
	.tablebox{
		-moz-box-sizing: border-box;
		-webkit-box-sizing: border-box;
		-o-box-sizing: border-box;
		-ms-box-sizing: border-box;
		box-sizing: border-box;
		padding:6px;
	}
	.edittable2>thead>tr>th{
		white-space: nowrap;
		font-weight: normal;
	}
	.edittable2>tbody>tr>td{
	white-space: nowrap;
	
	}
	.edittable2>tbody>tr>td{
		-moz-box-sizing: border-box;
		-webkit-box-sizing: border-box;
		-o-box-sizing: border-box;
		-ms-box-sizing: border-box;
		box-sizing: border-box;
		height:20px;
		text-align: left;
		padding:2px 5px;
	}
	.edittable2>tbody>tr>td:nth-child(1){
		text-align: center;
		padding:0;
	}
	.edittable2>tbody>tr>td>input[type="text"]{
		width:100%;
		height:100%;
		border:1px solid #888;
		-moz-box-sizing: border-box;
		-webkit-box-sizing: border-box;
		-o-box-sizing: border-box;
		-ms-box-sizing: border-box;
		box-sizing: border-box;
	}
</style>


<script type="text/javascript">
$(document).ready(function() {
	var packway='';//包装方式
	var transport='';//运输方式
	var payway='';//支付方式
	
	$.ajax({
		url:"../accountParaInfo/getParaInfoList",
		type:"post",
		data:{
			'pId':4
		},
		async:false,
		success:function(data){
			for(i in data){
				packway+='<option value="'+data[i].id+'">'+data[i].name+'</option>'
			}
		}
	}); 
	
	$.ajax({
		url:"../accountParaInfo/getParaInfoList",
		type:"post",
		data:{
			'pId':6
		},
		async:false,
		success:function(data){
			for(i in data){
				transport+='<option value="'+data[i].id+'">'+data[i].name+'</option>'
			}
		}
	}); 
	
	$.ajax({
		url:"../accountParaInfo/getParaInfoList",
		type:"post",
		data:{
			'pId':5
		},
		async:false,
		success:function(data){
			for(i in data){
				payway+='<option value="'+data[i].id+'">'+data[i].name+'</option>'
			}
		}
	}); 
	
	$(document).on("click","#submitbtn",function(){
		var supplierList=new Array()
		
		$("#accountPurchaseDetailList",window.parent.document).html("");
		$("#supplierList",window.parent.document).html("");
		var html="";
		var supplierListhtml="";
		var i=0;
		var y=0;
		$("#contentTable>tbody>tr").each(function(){
			
			if($(this).children("td:first").children(":checkbox").is(":checked")){
				var supplier=$(this).children("td:eq(1)").text().trim();
				var materialname=$(this).children("td:eq(2)").text().trim();
				var unitprice=$(this).children("td:eq(5)").text().trim();
				var suppliercode=$(this).children("td:eq(6)").text().trim();
				var materialcode=$(this).children("td:eq(7)").text().trim();	
				//alert(supplier);
				//alert(materialname+unitprice);
				html+='<tr id="accountPurchaseDetailList'+i+'">'
							+'<td class="hide">'
							+'<input id="accountPurchaseDetailList'+i+'_id" name="accountPurchaseDetailList['+i+'].id" type="hidden" value="">'
							+'<input id="accountPurchaseDetailList'+i+'_delFlag" name="accountPurchaseDetailList['+i+'].delFlag" type="hidden" value="0">'
							+'</td>'
							+'<td class="hide">'
							+'	<input id="accountPurchaseDetailList'+i+'_suppliercode" name="accountPurchaseDetailList['+i+'].suppliercode" type="text" value="'+suppliercode+'" maxlength="35" class="input-small required">'
							+'</td>'
							+'<td class="hide">'
							+'	<input id="accountPurchaseDetailList'+i+'_materialcode" name="accountPurchaseDetailList['+i+'].materialcode" type="text" value="'+materialcode+'" maxlength="35" class="input-small required">'
							+'</td>'
							+'<td>'
							+'	<input id="accountPurchaseDetailList'+i+'_supplier" readonly type="text" maxlength="35" value="'+supplier+'" class="input-small required">'
							+'</td>'
							+'<td>'
							+'	<input id="accountPurchaseDetailList'+i+'_materialname" readonly type="text" maxlength="35" value="'+materialname+'" class="input-small required">'			
							+'</td>'
							+'<td>'
							+'	<select id="accountPurchaseDetailList'+i+'_packway" name="accountPurchaseDetailList['+i+'].packway" data-value="" class="input-small required">'
							+'		<option value=""></option>'
							+packway
							+'	</select>'
							+'</td>'
							+'<td>'
							+'	<select id="accountPurchaseDetailList'+i+'_transport" name="accountPurchaseDetailList['+i+'].transport" data-value="" class="input-small required">'
							+'		<option value=""></option>'
							+transport
							+'	</select>'
							+'</td>'
							+'<td>'
							+'	<input id="accountPurchaseDetailList'+i+'_freightfee" name="accountPurchaseDetailList['+i+'].freightfee" type="text" value="" class="input-small number required">'
							+'</td>'
							+'<td>'
							+'	<input id="accountPurchaseDetailList'+i+'_unitprice" readonly name="accountPurchaseDetailList['+i+'].unitprice" value="'+unitprice+'" type="text" value="" class="input-small number">'
							+'</td>'
							+'<td>'
							+'	<input id="accountPurchaseDetailList'+i+'_quantity" name="accountPurchaseDetailList['+i+'].quantity" type="text" value="" maxlength="11" class="input-small required number">'
							+'</td>'
							+'<td>'
							+'	<input id="accountPurchaseDetailList'+i+'_receivedates" name="accountPurchaseDetailList['+i+'].receivedates" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required" value="" onclick="WdatePicker({dateFmt:\'yyyy-MM-dd \',isShowClear:false});">'
							+'</td>'
							+'<td>'
							+'	<input id="accountPurchaseDetailList'+i+'_totlemoney" name="accountPurchaseDetailList['+i+'].totlemoney" maxlength="10" type="text" value="" class="input-small number required">'
							+'</td>'
							+'<td>'
							+'	<textarea id="accountPurchaseDetailList'+i+'_remarks" name="accountPurchaseDetailList['+i+'].remarks" rows="4" maxlength="255" class="input-small "></textarea>'
							+'</td>'
							+'</tr>';
				
							if( $.inArray(supplier,supplierList)<0){
								supplierListhtml+='<tr id="supplierList'+y+'">'
								+'<td>'
								+'<input id="supplierList'+y+'_supplier" name="supplierList['+y+'].supplier"  readonly type="text" value="'+supplier+'" maxlength="35" class="input-small required"/>'
								+'</td>'
								+'<td>'
								+'	<input id="supplierList'+y+'_deadlines" name="supplierList['+y+'].deadlines" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required" value="" onclick="WdatePicker({dateFmt:\'yyyy-MM-dd \',isShowClear:false});">'
								+'</td>'
								+'<td>'
								+'	<select id="supplierList'+y+'_payway" name="supplierList['+y+'].payway" data-value="" class="input-small required">'
								+'		<option value=""></option>'
								+payway	
								+'	</select>'
								+'</td>'
								+'	</tr>';
							supplierList.push(supplier);
							y++;
							}
							i++;			
			}
			
		});
		//console.log(html);
		 $("#accountPurchaseDetailList",window.parent.document).append(html);
		 $("#supplierList",window.parent.document).append(supplierListhtml);
		//关闭页面
		$(".layui-layer-shade",window.parent.document).remove();
		$(".layui-layer-iframe",window.parent.document).remove();
	})
}); 
</script>

	<table id="contentTable" class="table table-striped table-bordered table-condensed" style="width: 75%;" >
		<thead>
			<tr>
				<th></th>
				<th>供应商名称</th>
				<th>物资名称</th>
				<th>规格型号</th>
				<th>计量单位</th>
				<th>单价</th>
			</tr>
		</thead>
		<tbody id="abcd_xk">
			<c:forEach items="${accountInquiryDetailList }" var="accountInquiryDetail" varStatus="status">
			<tr>
				<td>
				<input type="checkbox"  name="idxk"
						value="${accountInquiryDetail.id}">
				</td>
				<td>
					${accountInquiryDetail.supplier}
				</td>
				<td>
					${accountInquiryDetail.materialname }
				</td>
				<td>
					${accountInquiryDetail.size }
				</td>
				<td>
					${accountInquiryDetail.unit }
				</td>
				<td>
					${accountInquiryDetail.unitprice }
				</td>
				
				<td class="hide">
					${accountInquiryDetail.suppliercode }
				</td>
				<td class="hide">
					${accountInquiryDetail.materialcode }
				</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<div class="form-actions">
		<shiro:hasPermission name="erp:accountInspection:edit"><input  class="btn btn-primary" type="button" id="submitbtn" value="添加到订货单"/>&nbsp;</shiro:hasPermission>
	</div>
	