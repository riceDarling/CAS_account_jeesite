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
function randomOrdernum(){
	var ordernum = "01-";
	var date = new Date();
	var year = date.getFullYear();
	var month =date.getMonth() + 1;
	var day = date.getDate();
	if (month < 10) {
		month = "0" + month;
	}
	if (day < 10) {
		day = "0" + day;
	}
	ordernum = ordernum + year + month + day + "-";
	var ordernumRandom = "";
	for (var i = 0; i < 5; ++i) {
		var num = Math.random();
		num = parseInt(num*10);
		ordernumRandom += num;
	}
	ordernum += ordernumRandom;
	return ordernum;
}
$(document).ready(function() {


$("#contentTable [ordernum]").text(randomOrdernum());
$(document).on("click","#submitbtn",function(){
	$("#contentTable>tbody>tr").each(function(){
		if($(this).children("td:first").children(":checkbox").is(":checked")){
			var dataline = {};
			dataline["ordernum"]=$(this).find("[ordernum]").text();
			dataline["purchasenum"]=$(this).find("[name='purchasenum']").val();
			dataline["arrivalnum"]=$(this).find("[name='ordernum']").val();
			
			
			dataline["warehouse"]=$("[name='warehouse']").val();
			dataline["supplier"]=$("[name='supplier']").val();
			
			
			
			dataline["size"]=$(this).find("[name='size']").val();
			dataline["materialname"]=$(this).find("[name='materialname']").val();
			dataline["ingredient"]=$(this).find("[name='ingredient']").val();
			dataline["quantity"]=$(this).find("[name='quantity']").val();
			
			
			
			dataline["locationcode"]=$(this).find("[name='locationcode']").val();
			dataline["batch"]=$(this).find("[name='batch']").val();
			dataline["remarks"]=$(this).find("[name='remarks']").val();
			
			$.ajax({
				url:"../accountReject/save",
				type:"post",
				data:dataline, 
				async:false,
				success:function(){
						 	var html="<tr>"
							+'<td>'+dataline["ordernum"]+'</td>'
 							 +'<td>'+dataline["warehouse"]+'</td>'
 							+'<td>'+dataline["materialname"]+'</td>'
							+'<td>'+dataline["size"]+'</td>'
							/*+'<td>'+dataline["ingredient"]+'</td>'
							+'<td>'+dataline["quantity"]+'</td>'
							+'<td>'+dataline["inputmoney"]+'</td>'
							 +'<td>'+dataline["inspectionmode"]+'</td>' */
							+'<td>'+dataline["purchasenum"]+'</td>'
							+'<td>'+dataline["arrivalnum"]+'</td>'
							/*+'<td>'+dataline["inspectionman"]+'</td>' 
							+'<td>'+dataline["checker"]+'</td>'
							+'<td>'+dataline["inspectiondate"]+'</td>'*/
							+"</tr>";
						 $("#contentTable3>tbody",window.parent.document).append(html);
						
					 }
			})
		}
	})
	 alert("成功！");
	$(".layui-layer-shade",window.parent.document).remove();
	$(".layui-layer-iframe",window.parent.document).remove();
})
}); 

$(document).on('click','.add_wd',function(){
	function getData(a){
		switch (a){
		case "purchasenum":
			return $("#contentTable tbody tr:eq(0) td:eq(2) :text").val();
			break;
		case "ordernum":
			return $("#contentTable tbody tr:eq(0) td:eq(3) :text").val();
			break;
		default:
			break;
		} 
	}
	$("#contentTable tbody").append('<tr>'
			+'<td><input type="checkbox" checked name="delContent"></td>'
			+'<td ordernum name="sumordernum" style="white-space:nowrap;">'
			+randomOrdernum()
			+'</td>'
			+'<td><div class="controls"><input path="purchasenum" name="purchasenum" htmlEscape="false" value="'+getData("purchasenum")+'" class="input-xlarge required" style="width:100px;"/></div></td>'
			+'<td><div class="controls"><input path="arrivalnum" name="ordernum" htmlEscape="false" value="'+getData("ordernum")+'" class="input-xlarge required" style="width:100px;"/></div></td>'
			+'<td><div class="controls"><input path="size" name="size" htmlEscape="false" maxlength="120" class="input-xlarge required" style="width:100px;"/ ></div></td>'
			+'<td><div class="controls"><input path="materialname" name="materialname" htmlEscape="false" maxlength="120" class="input-xlarge required" style="width:100px;"/ ></div></td>'
			+'<td><div class="controls"><input path="ingredient" name="ingredient" htmlEscape="false" maxlength="120" class="input-xlarge required" style="width:100px;" /></div></td>'
			+'<td><div class="controls"><input path="quantity" name="quantity" htmlEscape="false" maxlength="120" class="input-xlarge required" style="width:100px;" /></div></td>'
			+'<td><div class="controls"><input path="locationcode" name="locationcode" htmlEscape="false" maxlength="120" class="input-xlarge required" style="width:100px;" /></div></td>'
			+'<td><div class="controls"><input path="batch" name="batch" htmlEscape="false" maxlength="120" class="input-xlarge required" style="width:100px;" /></div></td>'
			 +'<td><div class="controls"><input path="remarks" name="remarks" htmlEscape="false" maxlength="120" class="input-xlarge required" style="width:100px;" /></div></td>' 
			 +'</tr>');
	

}) ;
//获取供应商列表
$.ajax({
	url:"../accountSupplier/getAccountSuppliersList",
	type:"post",
	success:function(data){
		var html='<option value="">请选择</option>';
		for(i in data){
			if($("#h_supplier").val()==data[i].supplier){
				html+='<option value="'+data[i].supplier+'" selected="true">'+data[i].supplier+'</option>';
			} else {
				html+='<option value="'+data[i].supplier+'">'+data[i].supplier+'</option>';
			}
		}
		$("#supplier").html(html);
	   
	}
});

//获取仓库列表
$.ajax({
	url:"../accountWarehouse/getWarehouselList",
	type:"post",
	success:function(data){
		var html='<option value="">请选择</option>';
		for(i in data){
			if($("#h_warehouse").val()==data[i].housename){
				html+='<option value="'+data[i].housename+'" selected="true">'+data[i].housename+'</option>';
			} else {
				html+='<option value="'+data[i].housename+'">'+data[i].housename+'</option>';
			}
		}
		$("#warehouse").html(html);
	   
	}
});
$(document).on('click','.del_wd',function(){
	if($("input[name='delContent']:checked").length == 0){
		alert("请选中要删除的行！");
	} else {
		$("input[name='delContent']").each(function(){
			if($(this).attr('checked') == 'checked'){
				$(this).parent().parent().remove();
			}
		})
	}
}) ;
</script>
<form:form id="inputForm" modelAttribute="accountReject" action="${ctx}/erp/accountReject/save" method="post" class="form-horizontal">
		<table style="text-align: left;">
			<tbody>
				<tr>
					
					<td style="text-align: left; white-space: nowrap;"><label class="control-label">供应商名称：</label>
					<form:select path="supplier" class="input-xlarge required" id="supplier">
					<form:option value="${accountReject.supplier }" label="${accountReject.supplier }"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span></td>
					<td style="text-align: left; white-space: nowrap;"><label class="control-label">仓库：</label> <form:select path="warehouse" class="input-xlarge required" id="warehouse">
					<form:option value="${accountReject.warehouse }" label="${accountReject.warehouse }"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span></td>
				</tr>
			</tbody>
		</table>

</form:form>
<ul class="nav nav-tabs">
		<li><a href="${ctx}/erp/accountInspection/">退货明细表</a></li>
		<div class="form-actions" style="margin:0px;padding:0px;" >
			<input id="btnSubmit" style="height:25px;" class="btn btn-primary add_wd" type="submit" value="添加"/>
			<input id="btnCancel" style="height:25px;" class="btn del_wd" type="button" value="删除" />
		</div>
		<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th></th>
				<th>退货单号</th>
				<th>采购订货单号</th>
				<th>到货单号</th>
				<th>规格型号</th>
				<th>物资名称</th>
				<th>成分含量</th>
				<th>退货数量</th>
				<th>货位编码</th>
				<th>批次</th>
				<th>备注信息</th>
			</tr>
		</thead>
		<tbody>

			<c:forEach items="${accountArrival }" var="accountArrival">

				<tr>
					<td><input onepluschecked checked="checked" type="checkbox" checked name="idxk"
						value="${accountArrival.id}"></td>
					<td ordernum name="sumordernum" style="white-space:nowrap;" ></td>
					<td><input name="purchasenum" style="width: 100px;"
						value="${accountArrival.purchasenum}"></td>
					<td><input style="width: 100px;" name="ordernum"
						value="${accountArrival.ordernum}"></td>
				    <td><input name="size" style="width: 100px;"
						value="${accountArrival.size}"></td>
					<td><input name="materialname" style="width: 100px;"
						value="${accountArrival.materialname}"></td>
					<td><input name="ingredient" style="width: 100px;"
						value="${accountArrival.ingredient}"></td>
					<td><input name="quantity" style="width: 100px;"></td>
					<td><input name="locationcode" style="width: 100px;"></td>
					<td><input name="batch" style="width: 100px;"></td>
					<td><input name="remarks" style="width: 100px;"></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	</ul><br/>
	<div class="form-actions">
			<shiro:hasPermission name="erp:accountInspection:edit"><input  class="btn btn-primary" type="button" id="submitbtn" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>