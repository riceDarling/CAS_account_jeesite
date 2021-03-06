<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>申请单管理</title>
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
		<li><a href="${ctx}/erp/accountRequisition/">申请单列表</a></li>
		<li class="active"><a href="${ctx}/erp/accountRequisition/form?id=${accountRequisition.id}">申请单<shiro:hasPermission name="erp:accountRequisition:edit">${not empty accountRequisition.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="erp:accountRequisition:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="accountRequisition" action="${ctx}/erp/accountRequisition/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">单据编号：</label>
			<div class="controls">
				<form:input path="ordernum" htmlEscape="false" maxlength="17" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">标题：</label>
			<div class="controls">
				<form:input path="title" htmlEscape="false" maxlength="60" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">申请原因：</label>
			<div class="controls">
				<form:input path="reason" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">期望到货日期：</label>
			<div class="controls">
				<input name="receivedate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
					value="<fmt:formatDate value="${accountRequisition.receivedate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">申请部门：</label>
			<div class="controls">
				<sys:treeselect id="office" name="office.id" value="${accountRequisition.office.id}" labelName="office.name" labelValue="${accountRequisition.office.name}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="" allowClear="true" notAllowSelectParent="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">流程节点状态：</label>
			<div class="controls">
				<form:input path="procInsId" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">制单人：</label>
			<div class="controls">
				<form:input path="maker" htmlEscape="false" maxlength="35" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">审核人：</label>
			<div class="controls">
				<form:input path="checker" htmlEscape="false" maxlength="35" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">lead_text：</label>
			<div class="controls">
				<form:input path="leadText" htmlEscape="false" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">hr_text：</label>
			<div class="controls">
				<form:input path="hrText" htmlEscape="false" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">is_inquiry：</label>
			<div class="controls">
				<form:input path="isInquiry" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
			<div class="control-group">
				<label class="control-label">申请单子表：</label>
				<div class="controls">
					<table id="contentTable" class="table table-striped table-bordered table-condensed">
						<thead>
							<tr>
								<th class="hide"></th>
								<th>单据编号</th>
								<th>物资编码</th>
								<th>物资名称</th>
								<th>申请数量</th>
								<th>规格型号</th>
								<th>申请原因</th>
								<th>申请部门</th>
								<th>成分含量</th>
								<th>计量单位</th>
								<th>备注信息</th>
								<shiro:hasPermission name="erp:accountRequisition:edit"><th width="10">&nbsp;</th></shiro:hasPermission>
							</tr>
						</thead>
						<tbody id="accountRequisitionDetailList">
						</tbody>
						<shiro:hasPermission name="erp:accountRequisition:edit"><tfoot>
							<tr><td colspan="12"><a href="javascript:" onclick="addRow('#accountRequisitionDetailList', accountRequisitionDetailRowIdx, accountRequisitionDetailTpl);accountRequisitionDetailRowIdx = accountRequisitionDetailRowIdx + 1;" class="btn">新增</a></td></tr>
						</tfoot></shiro:hasPermission>
					</table>
					<script type="text/template" id="accountRequisitionDetailTpl">//<!--
						<tr id="accountRequisitionDetailList{{idx}}">
							<td class="hide">
								<input id="accountRequisitionDetailList{{idx}}_id" name="accountRequisitionDetailList[{{idx}}].id" type="hidden" value="{{row.id}}"/>
								<input id="accountRequisitionDetailList{{idx}}_delFlag" name="accountRequisitionDetailList[{{idx}}].delFlag" type="hidden" value="0"/>
							</td>
							<td>
								<input id="accountRequisitionDetailList{{idx}}_ordernum" name="accountRequisitionDetailList[{{idx}}].ordernum" type="text" value="{{row.ordernum}}" maxlength="17" class="input-small "/>
							</td>
							<td>
								<input id="accountRequisitionDetailList{{idx}}_materialcode" name="accountRequisitionDetailList[{{idx}}].materialcode" type="text" value="{{row.materialcode}}" maxlength="35" class="input-small required"/>
							</td>
							<td>
								<input id="accountRequisitionDetailList{{idx}}_materialname" name="accountRequisitionDetailList[{{idx}}].materialname" type="text" value="{{row.materialname}}" maxlength="35" class="input-small required"/>
							</td>
							<td>
								<input id="accountRequisitionDetailList{{idx}}_quantitiy" name="accountRequisitionDetailList[{{idx}}].quantitiy" type="text" value="{{row.quantitiy}}" maxlength="11" class="input-small required"/>
							</td>
							<td>
								<input id="accountRequisitionDetailList{{idx}}_size" name="accountRequisitionDetailList[{{idx}}].size" type="text" value="{{row.size}}" maxlength="35" class="input-small required"/>
							</td>
							<td>
								<input id="accountRequisitionDetailList{{idx}}_reason" name="accountRequisitionDetailList[{{idx}}].reason" type="text" value="{{row.reason}}" class="input-small required"/>
							</td>
							<td>
								<sys:treeselect id="accountRequisitionDetailList{{idx}}_office" name="accountRequisitionDetailList[{{idx}}].office.id" value="{{row.office.id}}" labelName="accountRequisitionDetailList{{idx}}.office.name" labelValue="{{row.office.name}}"
									title="部门" url="/sys/office/treeData?type=2" cssClass="" allowClear="true" notAllowSelectParent="true"/>
							</td>
							<td>
								<input id="accountRequisitionDetailList{{idx}}_ingredient" name="accountRequisitionDetailList[{{idx}}].ingredient" type="text" value="{{row.ingredient}}" maxlength="120" class="input-small required"/>
							</td>
							<td>
								<input id="accountRequisitionDetailList{{idx}}_unit" name="accountRequisitionDetailList[{{idx}}].unit" type="text" value="{{row.unit}}" maxlength="35" class="input-small required"/>
							</td>
							<td>
								<textarea id="accountRequisitionDetailList{{idx}}_remarks" name="accountRequisitionDetailList[{{idx}}].remarks" rows="4" maxlength="255" class="input-small ">{{row.remarks}}</textarea>
							</td>
							<shiro:hasPermission name="erp:accountRequisition:edit"><td class="text-center" width="10">
								{{#delBtn}}<span class="close" onclick="delRow(this, '#accountRequisitionDetailList{{idx}}')" title="删除">&times;</span>{{/delBtn}}
							</td></shiro:hasPermission>
						</tr>//-->
					</script>
					<script type="text/javascript">
						var accountRequisitionDetailRowIdx = 0, accountRequisitionDetailTpl = $("#accountRequisitionDetailTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
						$(document).ready(function() {
							var data = ${fns:toJson(accountRequisition.accountRequisitionDetailList)};
							for (var i=0; i<data.length; i++){
								addRow('#accountRequisitionDetailList', accountRequisitionDetailRowIdx, accountRequisitionDetailTpl, data[i]);
								accountRequisitionDetailRowIdx = accountRequisitionDetailRowIdx + 1;
							}
						});
					</script>
				</div>
			</div>
		<div class="form-actions">
			<shiro:hasPermission name="erp:accountRequisition:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>