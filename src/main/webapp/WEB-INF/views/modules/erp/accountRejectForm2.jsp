<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>退货单管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			
			//自动生成订单编号
			$("#ordernumBtn").on("click", function() {
				var ordernum = "22-";
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
				$("#ordernum").val(ordernum);
			})
			
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
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
		});
		//根据供应商名称获取采购订单列表
		$(document).on("change","#supplier",function(){
			//alert($(this).val());
			$.ajax({
				url:"../accountPurchase/getAccountSupplierListBysupplier",
				type:"post",
				data:{
					'supplier':$(this).val()
				},
				
				success:function(data){
					var html='<option value="">请选择</option>';
					for(i in data){
						html+='<option value="'+data[i].purchasenum+'">'+data[i].purchasenum+'</option>';
					}
					$("#purchasenum").html(html);	  
				}
			});
		});
		
		//根据采购订单编号获取到货单号列表
		$(document).on("change","#purchasenum",function(){
			//alert($(this).val());
			$.ajax({
				url:"../accountArrival/getAccountArrivalListBypurchasenum",
				type:"post",
				data:{
					'purchasenum':$(this).val()
				},
				
				success:function(data){
					var html='<option value="">请选择</option>';
					for(i in data){
						html+='<option value="'+data[i].arrivalnum+'">'+data[i].arrivalnum+'</option>';
					}
					$("#arrivalnum").html(html);	   
				}
			});
		});
		
		//根据到货单号获取到货单号信息
		$(document).on("change","#arrivalnum",function(){
			//alert($(this).val());
			$.ajax({
				url:"../accountArrival/getAccountArrivalByarrivalnum",
				type:"post",
				data:{
					'arrivalnum':$(this).val()
				},
				
				success:function(data){
					 $("#materialname").val(data.materialname);
					 $("#size").val(data.size);
					 $("#ingredient").val(data.ingredient);
					
				}
			});
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/erp/accountReject/">退货单列表</a></li>
		<shiro:hasPermission name="erp:accountReject:edit"><li><a href="${ctx}/erp/accountReject/form">退货单添加</a></li></shiro:hasPermission>
		<li class="active"><a href="${ctx}/erp/accountReject/form?id=${accountReject.id}">退货单修改</a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="accountReject" action="${ctx}/erp/accountReject/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<input id="h_supplier" type="hidden" value="${accountReject.supplier}"/>
		<input id="h_warehouse" type="hidden" value="${accountReject.warehouse}"/>
		<sys:message content="${message}"/>		
		<%-- <div class="control-group">
			<label class="control-label">单据编号：</label>
			<div class="controls">
				<form:input path="ordernum" htmlEscape="false" maxlength="17" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div> --%>
		
		<div class="control-group">
			<label class="control-label">单据编号：</label>
			<div class="controls">
				<form:input path="ordernum" htmlEscape="false" maxlength="32" class="input-xlarge required"/>
				<input id="ordernumBtn" class="btn" type="button" value="自动生成"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label">供应商名称：</label>
			<div class="controls">
				<form:select path="supplier" class="input-xlarge required" id="supplier">
					<form:option value="${accountReject.supplier }" label="${accountReject.supplier }"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">采购订货编号：</label>
			<div class="controls">
				<form:select path="purchasenum" class="input-xlarge required" id="purchasenum">
					<form:option value="${accountReject.purchasenum }" label="${accountReject.purchasenum }"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">到货单号：</label>
			<div class="controls">
				<form:select path="arrivalnum" class="input-xlarge required" id="arrivalnum">
					<form:option value="${accountReject.arrivalnum }" label="${accountReject.arrivalnum }"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">仓库：</label>
			<div class="controls">
				<form:select path="warehouse" class="input-xlarge required" id="warehouse">
					<form:option value="${accountReject.warehouse }" label="${accountReject.warehouse }"/>
					
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">物资名称：</label>
			<div class="controls">
				<form:input path="materialname" htmlEscape="false" maxlength="35" class="input-xlarge required" id="materialname"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">规格型号：</label>
			<div class="controls">
				<form:input path="size" htmlEscape="false" maxlength="35" class="input-xlarge required" id="size"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">成分含量：</label>
			<div class="controls">
				<form:input path="ingredient" htmlEscape="false" maxlength="35" class="input-xlarge required" id="ingredient"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">退货数量：</label>
			<div class="controls">
				<form:input path="quantity" htmlEscape="false" maxlength="11" class="input-xlarge required digits"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">货位编码：</label>
			<div class="controls">
				<form:input path="locationcode" htmlEscape="false" maxlength="17" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">批次：</label>
			<div class="controls">
				<form:input path="batch" htmlEscape="false" maxlength="255" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		
		<%-- <div class="control-group">
			<label class="control-label">制单人：</label>
			<div class="controls">
				<form:input path="maker" htmlEscape="false" maxlength="35" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div> --%>
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="erp:accountReject:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>