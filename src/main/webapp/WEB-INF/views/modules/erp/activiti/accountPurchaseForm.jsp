<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>订货单管理</title>
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
		
			
		});
		function addRow(list, idx, tpl, row){
			$(list).append(Mustache.render(tpl, {
				idx: idx, delBtn: true, row: row
			}));
			$(list+idx).find("select").each(function(){
				$(this).val($(this).attr("data-value"));
			});
			$(list+idx).find("input[type='checkbox'], input[type='radio']").each(function(){
				var ss = $(this).attr("data-value").split(',');
				for (var i=0; i<ss.length; i++){
					if($(this).val() == ss[i]){
						$(this).attr("checked","checked");
					}
				}
			});
		}
		function delRow(obj, prefix){
			var id = $(prefix+"_id");
			var delFlag = $(prefix+"_delFlag");
			if (id.val() == ""){
				$(obj).parent().parent().remove();
			}else if(delFlag.val() == "0"){
				delFlag.val("1");
				$(obj).html("&divide;").attr("title", "撤销删除");
				$(obj).parent().parent().addClass("error");
			}else if(delFlag.val() == "1"){
				delFlag.val("0");
				$(obj).html("&times;").attr("title", "删除");
				$(obj).parent().parent().removeClass("error");
			}
		}
	</script>
	<script>
	$(document).ready(function() {
		//自动生成订单编号
		$("#ordernumBtn").on("click", function() {
			var ordernum = "05-";
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
			$("#requisitionnum").val(ordernum);
		})
	});

	
	$(document).on("click","#btn_add_input",function() {
		accountPurchaseDetailRowIdx=0;
		$("#accountPurchaseDetailList").html("");
		// 判断申请单列表的CheckBox选框是否选中
		if($("[onepluschecked]:checked").length<=0){
			alert("请选中与询价单相关的申请单数据!");
		}else{
			// 根据选中单据编号，异步查询对应的申请单仔细表
			var id = $("[onepluschecked]:checked").val();
			//向后台发送子表数据
			$.ajax({
				url:"../accountRequisition/getByid",
				type:"post",
				data: {"id":id},
				success:function(data){
					$("#inquirynum").val(data.requisitionnum);
					for(var i=0;i<data.accountRequisitionDetailList.length;i++){
						addRow('#accountPurchaseDetailList', accountPurchaseDetailRowIdx, accountPurchaseDetailTpl);accountPurchaseDetailRowIdx = accountPurchaseDetailRowIdx + 1;
						$("#accountPurchaseDetailList"+i+"_ordernum").val(data.accountRequisitionDetailList[i].ordernum);//单据编号
						//供应商编号
						
							//根据物资编码获取供应商列表
							var html='<option value="">请选择</option>';
							$.ajax({
								url:"../accountSupplier/getAccountSuppliersListByMaterialnum",
								type:"post",
								async:false,
								data: {"materialnum":data.accountRequisitionDetailList[i].materialcode},
								success:function(data){
									for(var y=0;y<data.length;y++){
										html+='<option value="'+data[y].supplier+'" suppliercode="'+data[y].suppliernum+'">'+data[y].supplier+'</option>';
									}	
								}
							}); 
							
						$("#accountPurchaseDetailList"+i+"_supplier").html(html);//供应商名称
						$("#accountPurchaseDetailList"+i+"_materialcode").val(data.accountRequisitionDetailList[i].materialcode);	//物资编号
						$("#accountPurchaseDetailList"+i+"_materialname").val(data.accountRequisitionDetailList[i].materialname);//物资名称
						$("#accountPurchaseDetailList"+i+"_size").val(data.accountRequisitionDetailList[i].size);//规格型号
						$("#accountPurchaseDetailList"+i+"_unit").val(data.accountRequisitionDetailList[i].unit);//计量单位
						$("#accountPurchaseDetailList"+i+"_ingredient").val(data.accountRequisitionDetailList[i].ingredient);//成分含量
						$("#accountPurchaseDetailList"+i+"_quantity").val(data.accountRequisitionDetailList[i].quantitiy);//数量
						//单价(自动计算（保留两位）
						//备注信息
					}
	
				}
			});
		}
	});
			
	//根据供应商名称和物资编号获取价格	
	$(document).on("change",".supplier_select",function(){
		var thisselect =$(this);
		//alert($(this).children("option:selected").attr("suppliercode"));
		var suppliercode=$(this).children("option:selected").attr("suppliercode");
		$(thisselect).parent("td").siblings("td").eq(2).children(":text").val(suppliercode);
		$.ajax({
			url:"../accountMaterial/getAccountSupplierMaterial",
			type:"post",
			data:{
				'supplier':$(this).val(),
				'materialcode':$(thisselect).parent("td").siblings("td").eq(3).children(":text").val(),
			},	
			success:function(data){
				$(thisselect).parent("td").siblings("td").eq(9).children(":text").val(data.pricefee);
				//$(thisselect).parent("td").siblings("td").eq(3).children(":text").val(data.size);
				//$(thisselect).parent("td").siblings("td").eq(5).children(":text").val(data.ingredient);
			}
		});
	});
	</script>
		
		
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/erp/accountPurchase/">订货单列表</a></li>
		<li class="active"><a href="${ctx}/erp/accountPurchase/form?id=${accountPurchase.id}">订货单<shiro:hasPermission name="erp:accountPurchase:edit">${not empty accountPurchase.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="erp:accountPurchase:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th></th>
				<th>单据编号</th>
				<th>仓库</th>
				<th>需要到货日期</th>
				<th>备注信息</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="accountRequisition" varStatus="status">
			<tr>
				<td style="width:10px;"><input onepluschecked type="radio" name="oneradio"  value="${accountRequisition.id}"/>
				</td>
				<td>
					${accountRequisition.ordernum}
				</td>
				<td>
					${accountRequisition.warehouse}
				</td>
				<td>
					<fmt:formatDate value="${accountRequisition.receivedate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${accountRequisition.remarks}
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
	<sys:message content="${message}"/>
	<div class="form-actions">
		<input  class="btn btn-primary" type="button" id="btn_add_input" value="添加申请单到订货单"/>
	</div>
	<ul class="nav nav-tabs">
		<li class="active"><a href="">订货单</a></li>
	</ul><br/>
	
	
	
	<form:form id="inputForm" modelAttribute="accountPurchase" action="${ctx}/erp/accountPurchase/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="act.taskId"/>
		<form:hidden path="act.taskName"/>
		<form:hidden path="act.taskDefKey"/>
		<form:hidden path="act.procInsId"/>
		<form:hidden path="act.procDefId"/>
		<form:hidden id="flag" path="act.flag"/>
		<sys:message content="${message}"/>	
	<%-- 	<div class="control-group">
			<label class="control-label">流程实例编号：</label>
			<div class="controls">
				<form:input path="processInstanceId" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div> --%>
		<%-- <div class="control-group">
			<label class="control-label">采购订货编号：</label>
			<div class="controls">
				<form:input path="purchasenum" htmlEscape="false"  readonly="true" maxlength="37" class="input-xlarge required"/>	
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div> --%>
		<div class="control-group">
			<label class="control-label">单据编号：</label>
			<div class="controls">
				<form:input path="ordernum" htmlEscape="false" readonly="true" maxlength="17" class="input-xlarge required"/>
				<input id="ordernumBtn" readonly class="btn" type="button" value="自动生成"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">预计到货日期：</label>
			<div class="controls">
				<input name="receivedate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
					value="<fmt:formatDate value="${accountPurchase.receivedate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">付款期限：</label>
			<div class="controls">
				<input name="deadline" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
					value="<fmt:formatDate value="${accountPurchase.deadline}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">付款方式：</label>
			<div class="controls">
				<form:input path="payway" htmlEscape="false" maxlength="11" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">运费金额：</label>
			<div class="controls">
				<form:input path="freightfee" htmlEscape="false" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">包装方式：</label>
			<div class="controls">
				<form:input path="packway" htmlEscape="false" maxlength="10" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">总批次：</label>
			<div class="controls">
				<form:input path="totalbatch" htmlEscape="false" maxlength="11" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label">合同：</label>
			<div class="controls">
				<form:hidden id="contract" path="contract" htmlEscape="false" maxlength="255" class="input-xlarge"/>
				<sys:ckfinder input="contract" type="files" uploadPath="/erp/accountPurchase" selectMultiple="true"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">质保书：</label>
			<div class="controls">
				<form:hidden id="warranty" path="warranty" htmlEscape="false" maxlength="255" class="input-xlarge"/>
				<sys:ckfinder input="warranty" type="files" uploadPath="/erp/accountPurchase" selectMultiple="true"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		
	<%-- 	<div class="control-group">
			<label class="control-label">合同：</label>
			<div class="controls">
				<form:input path="contract" htmlEscape="false" maxlength="255" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">质保书：</label>
			<div class="controls">
				<form:input path="warranty" htmlEscape="false" maxlength="255" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		 --%>
		<div class="control-group">
			<label class="control-label">总金额（含税）：</label>
			<div class="controls">
				<form:input path="totalmoney" htmlEscape="false" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">运输方式：</label>
			<div class="controls">
				<form:input path="transport" htmlEscape="false" maxlength="11" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<%-- <div class="control-group">
			<label class="control-label">制单人：</label>
			<div class="controls">
				<form:input path="maker" htmlEscape="false" maxlength="35" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">审核人：</label>
			<div class="controls">
				<form:input path="checker" htmlEscape="false" maxlength="35" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div> --%>
		<div class="control-group">
			<label class="control-label">申请单号：</label>
			<div class="controls">
				<form:input path="inquirynum" htmlEscape="false" readonly="true" maxlength="37" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
	<%-- 	<div class="control-group">
			<label class="control-label">流程节点状态：</label>
			<div class="controls">
				<form:input path="procInsId" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div> --%>
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		
			<div class="control-group">
				<label class="control-label">订货单字表：</label>
				<div class="controls">
					<table id="contentTable" class="table table-striped table-bordered table-condensed">
						<thead>
							<tr>
								<th class="hide"></th>
								<th>单据编号</th>
								<th>供应商编号</th>
								<th>供应商名称</th>
								<th>物资编号</th>
								<th>物资名称</th>
								<th>规格型号</th>
								<th>计量单位</th>
								<th>成分含量</th>
								<th>数量</th>
								<th>单价(自动计算（保留两位）</th>
								<th>备注信息</th>
								<shiro:hasPermission name="erp:accountPurchase:edit"><th width="10">&nbsp;</th></shiro:hasPermission>
							</tr>
						</thead>
						<tbody id="accountPurchaseDetailList">
						</tbody>
						<%-- <shiro:hasPermission name="erp:accountPurchase:edit"><tfoot>
							<tr><td colspan="13"><a href="javascript:" onclick="addRow('#accountPurchaseDetailList', accountPurchaseDetailRowIdx, accountPurchaseDetailTpl);accountPurchaseDetailRowIdx = accountPurchaseDetailRowIdx + 1;" class="btn">新增</a></td></tr>
						</tfoot></shiro:hasPermission> --%>
					</table>
					<script type="text/template" id="accountPurchaseDetailTpl">//<!--
						<tr id="accountPurchaseDetailList{{idx}}">
							<td class="hide">
								<input id="accountPurchaseDetailList{{idx}}_id" name="accountPurchaseDetailList[{{idx}}].id" type="hidden" value="{{row.id}}"/>
								<input id="accountPurchaseDetailList{{idx}}_delFlag" name="accountPurchaseDetailList[{{idx}}].delFlag" type="hidden" value="0"/>
							</td>
							<td>
								<input id="accountPurchaseDetailList{{idx}}_ordernum"  readonly name="accountPurchaseDetailList[{{idx}}].ordernum" type="text" value="{{row.ordernum}}" maxlength="17" class="input-small required"/>
							</td>
							<td>
								<input id="accountPurchaseDetailList{{idx}}_suppliercode" readonly name="accountPurchaseDetailList[{{idx}}].suppliercode" type="text" value="{{row.suppliercode}}" maxlength="35" class="input-small required"/>
							</td>
							<td>
								<select id="accountPurchaseDetailList{{idx}}_supplier" name="accountPurchaseDetailList[{{idx}}].supplier" type="text" value="{{row.supplier}}" maxlength="35" class="input-small required supplier_select" >
								</select>
							</td>
							<td>
								<input id="accountPurchaseDetailList{{idx}}_materialcode" readonly name="accountPurchaseDetailList[{{idx}}].materialcode" type="text" value="{{row.materialcode}}" maxlength="35" class="input-small required"/>
							</td>
							<td>
								<input id="accountPurchaseDetailList{{idx}}_materialname"  readonly name="accountPurchaseDetailList[{{idx}}].materialname" type="text" value="{{row.materialname}}" maxlength="35" class="input-small required"/>
							</td>
							<td>
								<input id="accountPurchaseDetailList{{idx}}_size" readonly name="accountPurchaseDetailList[{{idx}}].size" type="text" value="{{row.size}}" maxlength="35" class="input-small required"/>
							</td>
							<td>
								<input id="accountPurchaseDetailList{{idx}}_unit" readonly name="accountPurchaseDetailList[{{idx}}].unit" type="text" value="{{row.unit}}" maxlength="35" class="input-small required"/>
							</td>
							<td>
								<input id="accountPurchaseDetailList{{idx}}_ingredient" readonly name="accountPurchaseDetailList[{{idx}}].ingredient" type="text" value="{{row.ingredient}}" maxlength="35" class="input-small required"/>
							</td>
							<td>
								<input id="accountPurchaseDetailList{{idx}}_quantity" readonly name="accountPurchaseDetailList[{{idx}}].quantity" type="text" value="{{row.quantity}}" maxlength="11" class="input-small required"/>
							</td>
							<td>
								<input id="accountPurchaseDetailList{{idx}}_unitprice" readonly name="accountPurchaseDetailList[{{idx}}].unitprice" type="text" value="{{row.unitprice}}" class="input-small required"/>
							</td>
							<td>
								<textarea id="accountPurchaseDetailList{{idx}}_remarks" name="accountPurchaseDetailList[{{idx}}].remarks" rows="4" maxlength="255" class="input-small ">{{row.remarks}}</textarea>
							</td>
							<shiro:hasPermission name="erp:accountPurchase:edit"><td class="text-center" width="10">
								{{#delBtn}}<span class="close" onclick="delRow(this, '#accountPurchaseDetailList{{idx}}')" title="删除">&times;</span>{{/delBtn}}
							</td></shiro:hasPermission>
						</tr>//-->
					</script>
					<script type="text/javascript">
						var accountPurchaseDetailRowIdx = 0, accountPurchaseDetailTpl = $("#accountPurchaseDetailTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
						$(document).ready(function() {
							var data = ${fns:toJson(accountPurchase.accountPurchaseDetailList)};
							for (var i=0; i<data.length; i++){
								addRow('#accountPurchaseDetailList', accountPurchaseDetailRowIdx, accountPurchaseDetailTpl, data[i]);
								accountPurchaseDetailRowIdx = accountPurchaseDetailRowIdx + 1;
							}
						});
					</script>
				</div>
			</div>
		<div class="form-actions">
			<shiro:hasPermission name="erp:accountRequisition:edit">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="提交申请" onclick="$('#flag').val('yes')"/>&nbsp;
				<c:if test="${not empty testAudit.id}">
					<input id="btnSubmit2" class="btn btn-inverse" type="submit" value="销毁申请" onclick="$('#flag').val('no')"/>&nbsp;
				</c:if>
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
		
		<act:histoicFlow procInsId="${accountRequisition.act.procInsId}" />
	</form:form>
</body>
</html>