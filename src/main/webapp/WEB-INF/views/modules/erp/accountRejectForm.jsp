<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>退货单新增</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
<style>
	th{
		height:25px;
		width:100px;
	}
	</style>
	<style>
	.popupwindow {
		font-size: 12px;
		position: fixed;
		width: 100%;
		height: 100%;
		left: 0;
		right: 0;
		top: 0;
		bottom: 0;
		z-index: 10;
		display: table;
		vertical-align: middle;
		text-align: center;
	}
	
	.popupbody {
		display: table-cell;
		vertical-align: middle;
		position: relative;
		z-index: 2;
		text-align: center;
	}
	.bgcover {
		position: fixed;
		left:0;
		right:0;
		top:0;
		bottom:0;
		z-index: 1;
		background:#000;
		opacity: 0;
		FILTER:alpha(opacity=0);
	}
	.popupbody>ul {
		display: inline-block;
	}
	.popupbody img{
		max-width: 100%;
		max-height:100%;
	}
	
	.popupmain {
		display:inline-block;
		-moz-box-sizing: border-box;
		-webkit-box-sizing: border-box;
		-o-box-sizing: border-box;
		-ms-box-sizing: border-box;
		box-sizing: border-box;
	}
	
	.popupmain .popuptitle{
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
	.popupmain .popupcontent{
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
	.edittable2>*>tr>:nth-child(1){
		width:30px;
	}
	.edittable2>*>tr>:nth-child(2){
		width:160px;
	}
	.edittable2>*>tr>:nth-child(3){
		width:60px;
	}
	.edittable2>*>tr>:nth-child(4){
		width:100px;
	}
	.edittable2>*>tr>:nth-child(5){
		width:40px;
	}
	.edittable2>*>tr>:nth-child(6){
		width:80px;
	}
	.edittable2>*>tr>:nth-child(7){
		width:80px;
	}
	.edittable2>*>tr>:nth-child(8){
		width:56px;
	}
	.edittable2>*>tr>:nth-child(9){
		width:56px;
	}
	.edittable2>*>tr>:nth-child(10){
		width:100px;
	}
	.edittable2>*>tr>:nth-child(11){
		width:100px;
	}
	.edittable2>*>tr>:nth-child(12){
		width:100px;
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
	// 添加退货单
	$(document).on("click","#btnSubmit",function() {
		$("#contentTable [ordernum]").text(ordernum);
		// 判断到货列表的CheckBox选框是否选中
		if($("[onepluschecked]:checked").length<=0){
			alert("请选中与退货单相关的到货单数据!");
		}else{
			// 根据选中单据编号，异步查询对应的到货单表
			var ordernum = $("[onepluschecked]:checked").val();
				
				layer.open({
					  type: 2,
					  title: '新建退货单',
					  closeBtn: 1, //显示关闭按钮
				      maxmin: true, //开启最大化最小化按钮
					  shade: [0],
					  area: ['1040px', '450px'],
					  offset: '50px', //只定义top坐标，水平保持居中
					  anim: 2,
					  content: ['getAccountArrivalById?id='+ordernum, 'yes'], //iframe的url，no代表不显示滚动条
					  end: function(){ //此处用于演示
					  }
					});
		}
	});
	
	$(document).on("click","#closethispopup",function(){
		$(this).parents(".popupwindow").remove();
	});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/erp/accountReject/">退货单列表</a></li>
		<li class="active"><a href="${ctx}/erp/accountReject/form?id=${accountReject.id}">退货单添加</a></li>
	</ul>
	<h4 style="text-align:center;background:#f1f1f1;">到货单列表</h4>
	<form:form id="searchForm" modelAttribute="accountArrival" action="${ctx}/erp/accountReject/form" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>到货单号：</label>
				<form:input path="arrivalnum" htmlEscape="false" maxlength="17" class="input-medium"/>
			</li>
			<li><label>单据编号：</label>
				<form:input path="ordernum" htmlEscape="false" maxlength="17" class="input-medium"/>
			</li>
			<li><label>物资名称：</label>
				<form:input path="materialname" htmlEscape="false" maxlength="35" class="input-medium"/>
			</li>
			<li><label>到货批次：</label>
				<form:input path="arrivalbatch" htmlEscape="false" maxlength="35" class="input-medium"/>
			</li>
			<li class="btns"><input class="btn btn-primary" type="submit" value="过滤"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<table id="contentTable2" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
			<th></th>
				<th>到货单号</th>
				<th>采购订货单号</th>
				<th>供应商名称</th>
				<th>物资名称</th>
				<th>规格型号</th>
				<th>成分含量</th>
				<th>到货批次</th>
				<th>订货数量</th>
				<th>到货数量</th>
				<th>损耗</th>
				<th>总批次</th>
				<th>总金额（含税）</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page2.list}" var="accountArrival">
			<tr>
			<td><input onepluschecked type="radio" name="idxk" value="${accountArrival.id}"></td>
				<td>
					${accountArrival.ordernum}
				</td>
				<td>
					${accountArrival.purchasenum}
				</td>
				<td>
					${accountArrival.supplier}
				</td>
				<td>
					${accountArrival.materialname}
				</td>
				<td>
					${accountArrival.size}
				</td>
				<td>
					${accountArrival.ingredient}
				</td>
				<td>
					${accountArrival.arrivalbatch}
				</td>
				<td>
					${accountArrival.orderquantity}
				</td>
				<td>
					${accountArrival.receivedquantity}
				</td>
				<td>
					${accountArrival.loss}
				</td>
				<td>
					${accountArrival.totalbatch}
				</td>
				<td>
					${accountArrival.totalmoney}
				</td>
				
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page2}</div> 
	<sys:message content="${message}"/>
	<ul class="nav nav-tabs">
	
		<li><a href="${ctx}/erp/accountReject/">退货单明细表</a></li>
		<div class="form-actions" style="margin:0px;padding:0px;" >
			<input id="btnSubmit" style="height:25px;" class="btn btn-primary add_wd" type="submit" value="添加退货单"/>
			<!-- <input id="btnCancel" style="height:25px;" class="btn del_wd" type="button" value="删除" /> -->
		</div>
	<table id="contentTable3" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>退货单号</th>
				<th>仓库</th>
				<th>物资名称</th>
				<th>规格型号</th>
				<th>采购订货单号</th>
				<th>到货单编号</th>
			</tr>
		</thead>
		<tbody>
		</tbody>
	</table>
	</ul><br/>
</body>

</html>