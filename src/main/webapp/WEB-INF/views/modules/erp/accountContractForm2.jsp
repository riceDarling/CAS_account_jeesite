<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>合同管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
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
			//获取采购订货单标题
			$.ajax({
				url:"../accountPurchase/getAccountPurchaseTitle",
				type:"post",
				success:function(data){
					var html='<option value=""></option>';
					for(i in data){
						html+='<option value="'+data[i].title+'">'+data[i].title+'</option>';
					
					}
					$("#purchasenumtitle").html(html);
				   
				}
			});
			//获取采购订货单列表供应商列表
			$.ajax({
				url:"../accountPurchase/getAccountSupplierByPurchasenumtitle",
				type:"post",
				data:{"purchasenumtitle":$("#purchasenumtitle").val()}, 
				async:false,
				success:function(data){
					$("#contentTable2>tbody").empty();
					for(i in data){
						var html="<tr>"
						+'<td><input onepluschecked type="radio" checkd="" name="idxk" value="'+data[i].packway+'" ';
						if(data[i].suppliercode==$("#caigouname").val()){
							html+='checked';
						}
						html+='></td>'
						 +'<td>'
							+data[i].suppliercode
							+'</td>'
							+'<td>'
							+data[i].totlemoney
							+'</td>'
							+'<td hidden>'
							+data[i].transport
							+'</td>'
							+'<td hidden>'
							+data[i].materialcode
							+'</td>'
						+'</tr>';
						$("#contentTable2>tbody").append(html);
						
				}
				}
			}) 
			var dataline = {};
			 dataline["suppliercode"]=$('[name="idxk"]:checked').parent("td").siblings("td:eq(2)").text();
			 dataline["materialcode"]=$('[name="idxk"]:checked').parent("td").siblings("td:eq(3)").text();
			
			//获取采购具体原料列表
	 		 $.ajax({
				url:"../accountPurchase/getAccountSupplierByPurchasenum",
				type:"post",
				data:dataline, 
				async:false,
				success:function(data){
					$("#contentTable>tbody").empty();
					for(i in data){
					var	 html="<tr>"
						 +'<td>'
							+data[i].materialcode
							+'</td>'
							 +'<td>'
								+data[i].suppliercode
								+'</td>'
							+'<td>'
							+data[i].quantity
							+'</td>'
							 +'<td>'
								+data[i].unitprice
								+'</td>'
								+'<td>'
								+data[i].totlemoney
								+'</td>'
						+'</tr>';
						$("#contentTable>tbody").append(html);
					} 
					
				}
			})  
		});
		//根据采购标题查询采购数据
		 $(document).on("click","#btnSubmit",function(){
		var purchasenumtitle=$("#purchasenumtitle").val();
		$("#title").html(purchasenumtitle);
		 if(purchasenumtitle!=null&&purchasenumtitle!=""){
			//获取采购订货单列表供应商数据列表
				$.ajax({
					url:"../accountPurchase/getAccountSupplierByPurchasenumtitle",
					type:"post",
					data:{"purchasenumtitle":purchasenumtitle}, 
					async:false,
					success:function(data){
						$("#contentTable2>tbody").empty();
						for(i in data){
							var html="<tr>"
							+'<td><input onepluschecked type="radio" name="idxk" value="'+data[i].packway+'"></td>'
								 +'<td>'
									+data[i].suppliercode
									+'</td>'
									+'<td>'
									+data[i].totlemoney
									+'</td>'
									+'<td hidden>'
									+data[i].transport
									+'</td>'
									+'<td hidden>'
									+data[i].materialcode
									+'</td>'
							+'</tr>';
							$("#contentTable2>tbody").append(html);
						}
						
					}
				}) 
		 }
		 else{
			 alert("请选择采购标题!");
		 }
			});
		 //选择供应商获取详细数据
		$(document).on("click","[name='idxk']",function(){
			$("#caigouname").val($(this).parent("td").siblings("td:eq(0)").text());
			$("#supplierNum").val($(this).parent("td").siblings("td:eq(2)").text())
			$("#purchasenum").val($('#contentTable2 input[name="idxk"]:checked ').val());
			var dataline = {};
			 dataline["suppliercode"]=$(this).parent("td").siblings("td:eq(2)").text();
			 dataline["materialcode"]=$(this).parent("td").siblings("td:eq(3)").text();
			//获取采购具体原料列表
	 		$.ajax({
				url:"../accountPurchase/getAccountSupplierByPurchasenum",
				type:"post",
				data:dataline, 
				async:false,
				success:function(data){
					$("#contentTable>tbody").empty();
					for(i in data){
					var	 html="<tr>"
							 +'<td>'
								+data[i].materialcode
								+'</td>'
								 +'<td>'
									+data[i].suppliercode
									+'</td>'
								+'<td>'
								+data[i].quantity
								+'</td>'
								 +'<td>'
									+data[i].unitprice
									+'</td>'
									+'<td>'
									+data[i].totlemoney
									+'</td>'
						+'</tr>';
						$("#contentTable>tbody").append(html);
					} 
					
				}
			}) 
		})
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/erp/accountContract/">合同列表</a></li>
		<shiro:hasPermission name="erp:accountContract:edit"><li><a href="${ctx}/erp/accountContract/form">合同添加</a></li></shiro:hasPermission>
		<li class="active"><a href="${ctx}/erp/accountContract/form2?id=${accountContract.id}">合同修改</a></li>
	</ul><br/>
	
	<form:form  modelAttribute="accountContract"   class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/> 
		<ul class="ul-form">
			<li><label>采购标题：</label>
				<select  class="input-xlarge required" id="purchasenumtitle">
			 <option value="${accountContract.title}">${accountContract.title}</option>
				 </select></li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="button" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<h4 style="text-align:center;background:#f1f1f1;"><span id="title">${accountContract.contracttitle}</span>采购单列表</h4>
	
	<table id="contentTable2" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
			    <th></th>
				<th>供应商</th>
				<th>采购总金额</th>
				<th hidden="true">供应商编码</th> 
				<th hidden="true">采购标题</th> 
			</tr>
		</thead>
		<tbody>
		</tbody>
		</table>
		<ul class="nav nav-tabs">
		<li class="active"><a href="">合同编辑</a></li>
	</ul>
	<form:form id="inputForm" modelAttribute="accountContract"  action="${ctx}/erp/accountContract/save" method="post" class="form-horizontal">
			<form:hidden path="id"/>
		<sys:message content="${message}"/>		
	<div class="control-group"  hidden="true">
			<label class="control-label" >合同编号：</label>
			<div class="controls">
				<form:input path="contractnum" htmlEscape="false" maxlength="32" class="input-xlarge required"/>
			</div>
		</div> 
		<div class="control-group"  hidden="true">
			<label class="control-label" >采购单号：</label>
			<div class="controls">
				<form:input path="purchasenum"  htmlEscape="false" maxlength="32" class="input-xlarge required"/>
			</div>
		</div> 
		<div class="control-group" hidden="true">
			<label class="control-label" >供应商编号：</label>
			<div class="controls">
				<form:input path="supplierNum"  htmlEscape="false" maxlength="32" class="input-xlarge required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">合同名称：</label>
			<div class="controls">
				<form:input path="contracttitle" htmlEscape="false" maxlength="255" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		 <div class="control-group">
			<label class="control-label">乙方：</label>
			<div class="controls">
				<form:input path="caigouname" htmlEscape="false" maxlength="255" class="input-xlarge required" readonly="true"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">采购原料：</label>
			<table id="contentTable" class="table table-striped table-bordered table-condensed" style="width:70%;">
		<thead>
			<tr>
			<th>物资名称</th> 
			<th>规格型号</th> 
			<th>采购数量</th>
			<th>采购单价</th>
			<th>采购金额</th>
			</tr>
		</thead>
		<tbody>
		</tbody>
	</table>
		</div>
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge required"/>
			</div>
		</div>
	
	<div class="form-actions">
			<shiro:hasPermission name="erp:accountContract:edit"><input  class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>