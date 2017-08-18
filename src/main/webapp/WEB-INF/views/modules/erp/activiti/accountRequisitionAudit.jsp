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
		<li class="active"><a href="${ctx}/erp/accountRequisition/form?id=${accountRequisition.id}">申请单</a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="accountRequisition" action="${ctx}/erp/accountRequisition/saveAudit" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="act.taskId"/>
		<form:hidden path="act.taskName"/>
		<form:hidden path="act.taskDefKey"/>
		<form:hidden path="act.procInsId"/>
		<form:hidden path="act.procDefId"/>
		<form:hidden id="flag" path="act.flag"/>
		<sys:message content="${message}"/>
	<div class="control-group">
			<label class="control-label">申请单号：</label>
			<div class="controls">
				<form:input path="requisitionnum" readonly="true" htmlEscape="false" maxlength="37" class="input-xlarge required" />
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">单据编号：</label>
			<div class="controls">
				<form:input path="ordernum" readonly="true" htmlEscape="false" maxlength="17" class="input-xlarge required" />
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">仓库：</label>
			<div class="controls">
				<form:input path="warehouse" readonly="true" htmlEscape="false" maxlength="35" class="input-xlarge required" />
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">需要到货日期：</label>
			<div class="controls">
				<input name="receivedate" readonly="true" type="text"  maxlength="20" class="input-medium Wdate required"
					value="<fmt:formatDate value="${accountRequisition.receivedate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});" />
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<%-- <div class="control-group">
			<label class="control-label">流程节点状态：</label>
			<div class="controls">
				<form:input path="procInsId" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div> --%>
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea path="remarks" readonly="true" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge " />
			</div>
		</div>
			<div class="control-group">
				<label class="control-label">申请单子表：</label>
				<div class="controls">
					<table id="contentTable" class="table table-striped table-bordered table-condensed">
						<thead>
							<tr>
								<th class="hide"></th>
								<th>子单据编号</th>
								<th>物资编码</th>
								<th>物资名称</th>
								<th>申请数量</th>
								<th>规格型号</th>
								<th>申请原因</th>
								<th>申请部门</th>
								<th>成分含量</th>
								<th>计量单位</th>
								<th>备注信息</th>
							</tr>
						</thead>
						<tbody id="accountRequisitionDetailList">
						</tbody>
						<%-- <shiro:hasPermission name="erp:accountRequisition:edit"><tfoot>
							<tr><td colspan="12"><a href="javascript:" onclick="addRow('#accountRequisitionDetailList', accountRequisitionDetailRowIdx, accountRequisitionDetailTpl);accountRequisitionDetailRowIdx = accountRequisitionDetailRowIdx + 1;" class="btn">新增</a></td></tr>
						</tfoot></shiro:hasPermission> --%>
					</table>
					<script type="text/template" id="accountRequisitionDetailTpl">//<!--
						<tr id="accountRequisitionDetailList{{idx}}">
							<td class="hide">
								<input id="accountRequisitionDetailList{{idx}}_id" name="accountRequisitionDetailList[{{idx}}].id" type="hidden" value="{{row.id}}"/>
								<input id="accountRequisitionDetailList{{idx}}_delFlag" readonly name="accountRequisitionDetailList[{{idx}}].delFlag" type="hidden" value="0"/>
							</td>
							<td>
								<input id="accountRequisitionDetailList{{idx}}_ordernum" readonly name="accountRequisitionDetailList[{{idx}}].ordernum" type="text" value="{{row.ordernum}}" maxlength="17" class="input-small required"/>
							</td>
							<td>
								<input id="accountRequisitionDetailList{{idx}}_materialcode" readonly name="accountRequisitionDetailList[{{idx}}].materialcode" type="text" value="{{row.materialcode}}" maxlength="35" class="input-small required"/>
							</td>
							<td>
								<input id="accountRequisitionDetailList{{idx}}_materialname" readonly name="accountRequisitionDetailList[{{idx}}].materialname" type="text" value="{{row.materialname}}" maxlength="35" class="input-small required"/>
							</td>
							<td>
								<input id="accountRequisitionDetailList{{idx}}_quantitiy" readonly name="accountRequisitionDetailList[{{idx}}].quantitiy" type="text" value="{{row.quantitiy}}" maxlength="11" class="input-small required"/>
							</td>
							<td>
								<input id="accountRequisitionDetailList{{idx}}_size" readonly name="accountRequisitionDetailList[{{idx}}].size" type="text" value="{{row.size}}" maxlength="35" class="input-small required"/>
							</td>
							<td>
								<input id="accountRequisitionDetailList{{idx}}_reason" readonly name="accountRequisitionDetailList[{{idx}}].reason" type="text" value="{{row.reason}}" class="input-small required"/>
							</td>
							<td>
								<input id="accountRequisitionDetailList{{idx}}_office"  readonly name="accountRequisitionDetailList[{{idx}}].office" type="text" value="{{row.office.name}}" maxlength="120" class="input-small required"/>
							</td>
							<td>
								<input id="accountRequisitionDetailList{{idx}}_ingredient"  readonly name="accountRequisitionDetailList[{{idx}}].ingredient" type="text" value="{{row.ingredient}}" maxlength="120" class="input-small required"/>
							</td>
							<td>
								<input id="accountRequisitionDetailList{{idx}}_unit" readonly name="accountRequisitionDetailList[{{idx}}].unit" type="text" value="{{row.unit}}" maxlength="35" class="input-small required"/>
							</td>
							<td>
								<textarea id="accountRequisitionDetailList{{idx}}_remarks" readonly name="accountRequisitionDetailList[{{idx}}].remarks" rows="4" maxlength="255" class="input-small ">{{row.remarks}}</textarea>
							</td>
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
			
				<tr>
					<td class="tit">您的意见</td>
					<td colspan="5">
						<form:textarea path="act.comment" class="required" rows="5" maxlength="20" cssStyle="width:500px"/>
					</td>
				</tr>
			
		<div class="form-actions">
			<shiro:hasPermission name="erp:accountRequisition:edit">
				<c:if test="${accountRequisition.act.taskDefKey eq 'apply_end'}">
					<input id="btnSubmit" class="btn btn-primary" type="submit" value="兑 现" onclick="$('#flag').val('yes')"/>&nbsp;
				</c:if>
				<c:if test="${accountRequisition.act.taskDefKey ne 'apply_end'}">
					<input id="btnSubmit" class="btn btn-primary" type="submit" value="同 意" onclick="$('#flag').val('yes')"/>&nbsp;
					<input id="btnSubmit" class="btn btn-inverse" type="submit" value="驳 回" onclick="$('#flag').val('no')"/>&nbsp;
				</c:if>
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
		<act:histoicFlow procInsId="${accountRequisition.act.procInsId}"/>
		
	</form:form>
</body>
</html>