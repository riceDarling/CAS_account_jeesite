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
		
		
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/erp/accountPurchase/">订货单列表</a></li>
		<li class="active"><a href="">订货单详情</a></li>
	</ul><br/>

	<form:form id="inputForm" modelAttribute="accountPurchase"  class="form-horizontal">
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
		<div class="control-group">
			<label class="control-label">采购订货编号：</label>
			<div class="controls">
				<form:input path="purchasenum" readonly="true" htmlEscape="false" maxlength="37" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">单据编号：</label>
			<div class="controls">
				<form:input path="ordernum" readonly="true" htmlEscape="false" maxlength="17" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">预计到货日期：</label>
			<div class="controls">
				<input name="receivedate" readonly="true" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
					value="<fmt:formatDate value="${accountPurchase.receivedate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">付款期限：</label>
			<div class="controls">
				<input name="deadline" readonly="true" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
					value="<fmt:formatDate value="${accountPurchase.deadline}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">付款方式：</label>
			<div class="controls">
				<form:input path="payway" readonly="true" htmlEscape="false" maxlength="11" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">运费金额：</label>
			<div class="controls">
				<form:input path="freightfee" readonly="true" htmlEscape="false" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">包装方式：</label>
			<div class="controls">
				<form:input path="packway" readonly="true" htmlEscape="false" maxlength="10" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">总批次：</label>
			<div class="controls">
				<form:input path="totalbatch" readonly="true" htmlEscape="false" maxlength="11" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">合同：</label>
			<div class="controls">
				<form:input path="contract" readonly="true" htmlEscape="false" maxlength="255" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">质保书：</label>
			<div class="controls">
				<form:input path="warranty" readonly="true" htmlEscape="false" maxlength="255" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">总金额（含税）：</label>
			<div class="controls">
				<form:input path="totalmoney" readonly="true" htmlEscape="false" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">运输方式：</label>
			<div class="controls">
				<form:input path="transport" readonly="true" htmlEscape="false" maxlength="11" class="input-xlarge required"/>
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
				<form:input path="inquirynum" readonly="true" htmlEscape="false" maxlength="37" class="input-xlarge required"/>
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
				<form:textarea path="remarks" readonly="true" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
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
								<input id="accountPurchaseDetailList{{idx}}_delFlag" readonly name="accountPurchaseDetailList[{{idx}}].delFlag" type="hidden" value="0"/>
							</td>
							<td>
								<input id="accountPurchaseDetailList{{idx}}_ordernum" readonly name="accountPurchaseDetailList[{{idx}}].ordernum" type="text" value="{{row.ordernum}}" maxlength="17" class="input-small required"/>
							</td>
							<td>
								<input id="accountPurchaseDetailList{{idx}}_suppliercode" readonly name="accountPurchaseDetailList[{{idx}}].suppliercode" type="text" value="{{row.suppliercode}}" maxlength="35" class="input-small required"/>
							</td>
							<td>
								<input id="accountPurchaseDetailList{{idx}}_supplier" readonly name="accountPurchaseDetailList[{{idx}}].supplier" type="text" value="{{row.supplier}}" maxlength="35" class="input-small required"/>
							</td>
							<td>
								<input id="accountPurchaseDetailList{{idx}}_materialcode" readonly name="accountPurchaseDetailList[{{idx}}].materialcode" type="text" value="{{row.materialcode}}" maxlength="35" class="input-small required"/>
							</td>
							<td>
								<input id="accountPurchaseDetailList{{idx}}_materialname" readonly name="accountPurchaseDetailList[{{idx}}].materialname" type="text" value="{{row.materialname}}" maxlength="35" class="input-small required"/>
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
								<textarea id="accountPurchaseDetailList{{idx}}_remarks" readonly name="accountPurchaseDetailList[{{idx}}].remarks" rows="4" maxlength="255" class="input-small ">{{row.remarks}}</textarea>
							</td>
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
		
		<act:histoicFlow procInsId="${accountPurchase.act.procInsId}" />
		<div class="form-actions">
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
		
	</form:form>
</body>
</html>