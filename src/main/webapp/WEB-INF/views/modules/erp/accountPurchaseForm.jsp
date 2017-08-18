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
					if('no'!=$('#conclusion').val()){
						/* 此处验证表单字段 */
						var _checker = $( '#checkerName' ),	//审核人
								  wokenstr = '<label for="receivedate" class="error">必填信息</label>',
								  _flag = 0;		//验证标识 0标识没有错误
							if ( _checker.val().replace( ' ' , '' ) == '' ) {
								_checker.parent().after( wokenstr );
								_flag = 1;
							}
							
							var totlemoney_el = 'accountPurchaseDetailList';	//总价前缀、包装方式 运输方式 运费金额
							var supplierList_el = 'supplierList';	//付款期限、付款方式前缀
							for ( var c = 0 ; c < 150 ; c++ ) {
								
								if ( $( '#' + totlemoney_el + c +  '_totlemoney' ).length > 0 ) {
									if ( $( '#' + totlemoney_el + c +  '_totlemoney' ).val().replace( ' ' , '' ) == ''  ) {
										$( '#' + totlemoney_el + c +  '_totlemoney' ).after( wokenstr );
										_flag = 1;
									}
								}
								if ( $( '#' + supplierList_el + c +  '_deadlines' ).length > 0  ) {
									if ( $( '#' + supplierList_el + c +  '_deadlines' ).val().replace( ' ' , '' ) == ''  ) {
										$( '#' + supplierList_el + c +  '_deadlines' ).after( wokenstr );
										_flag = 1;
									}
								}
								
								if ( $( '#' + supplierList_el + c +  '_payway' ).length > 0  ) {
									if ( $( '#' + supplierList_el + c +  '_payway' ).val().replace( ' ' , '' ) == ''  ) {
										$( '#' + supplierList_el + c +  '_payway' ).after( wokenstr );
										_flag = 1;
									}
								}
								//包装方式
								if ( $( '#' + supplierList_el + c +  '_packway' ).length > 0  ) {
									if ( $( '#' + supplierList_el + c +  '_packway' ).val().replace( ' ' , '' ) == ''  ) {
										$( '#' + supplierList_el + c +  '_packway' ).after( wokenstr );
										_flag = 1;
									}
								}
								//运输方式
								if ( $( '#' + supplierList_el + c +  '_transport' ).length > 0  ) {
									if ( $( '#' + supplierList_el + c +  '_transport' ).val().replace( ' ' , '' ) == ''  ) {
										$( '#' + supplierList_el + c +  '_transport' ).after( wokenstr );
										_flag = 1;
									}
								}
								//运费金额
								if ( $( '#' + supplierList_el + c +  '_freightfee' ).length > 0  ) {
									if ( $( '#' + supplierList_el + c +  '_freightfee' ).val().replace( ' ' , '' ) == ''  ) {
										$( '#' + supplierList_el + c +  '_freightfee' ).after( wokenstr );
										_flag = 1;
									}
								}
								
								
							}
							
							if ( _flag != 0  ) {
								return;
							}
							
					}
					
						
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
			
			$("#btn_accountInquiry_select").click(function(){
				
				$("#contentTable2>tbody>tr").each(function(){
					 if($(this).children("td:first").children(":radio").is(":checked")){ 
						 var ordernum=$('#contentTable2 input[name="idxk"]:checked ').val();
						 $("#inquirynum").val(ordernum);
						var title= $('#contentTable2 input[name="idxk"]:checked ').parent().parent("tr").find("td").eq(1).text().trim();
						//alert(title);
						$("#title").val(title+"-订货单");
						 layer.open({
							  type: 2,
							  title: '选择询价物品到订货单',
							  closeBtn: 1, //显示关闭按钮
						      maxmin: true, //开启最大化最小化按钮
							  shade: [0],
							  area: ['1040px', '450px'],
							  offset: '50px', //只定义top坐标，水平保持居中
							  anim: 2,
							  content: ['accountPurchaseFormWindow?ordernum='+ordernum, 'yes'], //iframe的url，no代表不显示滚动条
							  end: function(){ //此处用于演示
							  }
							});
						 
					 }
				});
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
		<li class="active"><a href="${ctx}/erp/accountPurchase/form?id=${accountPurchase.id}">订货单<shiro:hasPermission name="erp:accountPurchase:edit">${not empty accountPurchase.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="erp:accountPurchase:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	
		
	<sys:message content="${message}"/>
	<table id="contentTable2" class="table table-striped table-bordered table-condensed" style="width: 75%;" >
		<thead>
			<tr>
				<th></th>
				<th>标题</th>
				<th>申请人</th>
				<th>部门</th>
				<th>发起时间</th>
			</tr>
		</thead>
		<tbody id="abcd_xk">
			<c:forEach items="${accountInquiryPage.list }" var="accountInquiry" varStatus="status">
			<tr>
				<td><input  type="radio" name="idxk" value="${accountInquiry.ordernum}"></td>
				<td>
					${accountInquiry.title}
				</td>
				<td>
					${accountInquiry.maker }
				</td>
				<td>
					${accountInquiry.department }
				</td>
				<td>
					<fmt:formatDate value="${accountInquiry.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				
			</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${accountInquiryPage}</div>
	
	<sys:message content="${message}"/>
	<input id="btn_accountInquiry_select" class="btn btn-primary" type="button" value="查看"/>
	
	
	<form:form id="inputForm" modelAttribute="accountPurchase" action="${ctx}/erp/accountPurchase/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden id="conclusion" path="conclusion"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">标题：</label>
			<div class="controls">
				<form:input path="title" readonly="true" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group hide">
			<label class="control-label">询价单号：</label>
			<div class="controls">
				<form:input path="inquirynum"  readonly="true" htmlEscape="false" maxlength="37" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">审核人：</label>
			<div class="controls">
				<sys:treeselect id="checker" name="checker" value="" labelName="" labelValue=""
					title="用户" url="/sys/office/treeData?type=3" cssClass="" allowClear="true" notAllowSelectParent="true"/>
			<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
	
			<div class="control-group">
				<label class="control-label">订货单详细：</label>
				<div class="controls">
					<table id="contentTable" class="table table-striped table-bordered table-condensed">
						<thead>
							<tr>
								<th class="hide"></th>
								<th  class="hide">供应商编号</th>
								<th  class="hide">物资编号</th>
								<th>供应商名称</th>
								<th>物资名称</th>
								<th>包装方式</th>
								<th>运输方式</th>
								<th>运费金额</th>
								<th>单价</th>
								<th>数量</th>
								<th>预计到货日期</th>
								<th>总价</th>
								<th>备注信息</th>
							</tr>
						</thead>
						<tbody id="accountPurchaseDetailList">
						</tbody>
						<%-- <shiro:hasPermission name="erp:accountPurchase:edit"><tfoot>
							<tr><td colspan="12"><a href="javascript:" onclick="addRow('#accountPurchaseDetailList', accountPurchaseDetailRowIdx, accountPurchaseDetailTpl);accountPurchaseDetailRowIdx = accountPurchaseDetailRowIdx + 1;" class="btn">新增</a></td></tr>
						</tfoot></shiro:hasPermission> --%>
					</table>
					<script type="text/template" id="accountPurchaseDetailTpl">//<!--
						<tr id="accountPurchaseDetailList{{idx}}">
							<td class="hide">
								<input id="accountPurchaseDetailList{{idx}}_id" name="accountPurchaseDetailList[{{idx}}].id" type="hidden" value="{{row.id}}"/>
								<input id="accountPurchaseDetailList{{idx}}_delFlag" name="accountPurchaseDetailList[{{idx}}].delFlag" type="hidden" value="0"/>
							</td>
							<td  class="hide">
								<input id="accountPurchaseDetailList{{idx}}_suppliercode" name="accountPurchaseDetailList[{{idx}}].suppliercode" type="text" value="{{row.suppliercode}}" maxlength="35" class="input-small required"/>
							</td>
							<td  class="hide">
								<input id="accountPurchaseDetailList{{idx}}_materialcode" name="accountPurchaseDetailList[{{idx}}].materialcode" type="text" value="{{row.materialcode}}" maxlength="35" class="input-small required"/>
							</td>
							<td>
								<input id="accountPurchaseDetailList{{idx}}_supplier" type="text"  maxlength="35" class="input-small required"/>
							</td>
							<td>
								<input id="accountPurchaseDetailList{{idx}}_materialname" type="text"  maxlength="35" class="input-small required"/>				
							</td>
							<td>
								<select id="accountPurchaseDetailList{{idx}}_packway" name="accountPurchaseDetailList[{{idx}}].packway" data-value="{{row.packway}}" class="input-small required">
									<option value=""></option>
										<c:forEach items="${packway}" var="packway">
											<option value="${packway.id}">${packway.name}</option>
										</c:forEach>
								</select>
							</td>
							<td>
								<select id="accountPurchaseDetailList{{idx}}_transport" name="accountPurchaseDetailList[{{idx}}].transport" data-value="{{row.transport}}" class="input-small required">
									<option value=""></option>
										<c:forEach items="${transport}" var="transport">
											<option value="${transport.id}">${transport.name}</option>
										</c:forEach>	
								</select>
							</td>
							<td>
								<input id="accountPurchaseDetailList{{idx}}_freightfee" name="accountPurchaseDetailList[{{idx}}].freightfee" type="text" value="{{row.freightfee}}" class="input-small number required"/>
							</td>
							<td>
								<input id="accountPurchaseDetailList{{idx}}_unitprice" name="accountPurchaseDetailList[{{idx}}].unitprice" type="text" value="{{row.unitprice}}" class="input-small number required"/>
							</td>
							<td>
								<input id="accountPurchaseDetailList{{idx}}_quantity" name="accountPurchaseDetailList[{{idx}}].quantity" type="text" value="{{row.quantity}}" maxlength="11" class="input-small required number required"/>
							</td>
							<td>
								<input id="accountPurchaseDetailList{{idx}}_receivedate" name="accountPurchaseDetailList[{{idx}}].receivedate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
									value="{{row.receivedate}}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
							</td>
							<td>
								<input id="accountPurchaseDetailList{{idx}}_totlemoney"  maxlength="10" name="accountPurchaseDetailList[{{idx}}].totlemoney" type="text" value="{{row.totlemoney}}" class="input-small number required"/>
							</td>
							<td>
								<textarea id="accountPurchaseDetailList{{idx}}_remarks" name="accountPurchaseDetailList[{{idx}}].remarks" rows="4" maxlength="255" class="input-small ">{{row.remarks}}</textarea>
							</td>
						</tr>//-->
					</script>
					<script type="text/javascript">
						var accountPurchaseDetailRowIdx = 0, accountPurchaseDetailTpl = $("#accountPurchaseDetailTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
						$(document).ready(function() {
							var data = ${fns:toJson(accountPurchase.accountPurchaseDetailList)};
							for (var i=0; i<data.length; i++){
								addRow('#accountPurchaseDetailList', accountPurchaseDetailRowIdx, accountPurchaseDetailTpl, data[i]);
								$.ajax({
									url:"../accountMaterial/getMaterialBymaterialcode",
									type:"post",
									data:{
										'materialcode':data[i].materialcode
									},
									async:false,
									success:function(data_material){
										$("#accountPurchaseDetailList"+i+"_materialname").val(data_material.materialname);
									}
								}); 
								$.ajax({
									url:"../accountSupplier/getAccountSupplierBysupplierNum",
									type:"post",
									data:{
										'supplierNum':data[i].suppliercode
									},
									async:false,
									success:function(data_supplier){
										$("#accountPurchaseDetailList"+i+"_supplier").val(data_supplier.supplier);
									}
								}); 
								accountPurchaseDetailRowIdx = accountPurchaseDetailRowIdx + 1;
							}
						});
					</script>
				</div>
			</div>
			
			<div class="control-group">
				<label class="control-label">供应商详细：</label>
				<div class="controls">
					<table id="contentTable" class="table table-striped table-bordered table-condensed">
						<thead>
							<tr>
								<th class="hide"></th>
								<th class="hide">供应商编号</th>
								<th>供应商名称</th>
								<th>付款期限</th>
								<th>付款方式</th>
							</tr>
						</thead>
						<tbody id="supplierList">
							<c:forEach items="${accountPurchaseSuppliers}" var="accountPurchaseSupplier" varStatus="status">
								<tr>			
									<td>
									<input id="supplierList${status.index}_supplier" name="supplierList[${status.index}].supplier"  readonly type="text" value="${accountPurchaseSupplier.supplier}" maxlength="35" class="input-small required"/>
								
										
									</td>
									<td>	
									<input id="supplierList${status.index}_deadlines" name="supplierList[${status.index}].deadlines" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required" value="<fmt:formatDate value="${accountPurchaseSupplier.deadline }" pattern="yyyy-MM-dd"/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd ',isShowClear:false});">
									</td>
									<td>
										<select id="supplierList${status.index}_payway" name="supplierList[${status.index}].payway" data-value="" class="input-small required">
												<c:forEach items="${payway}" var="payway">
												
												<c:choose>
													<c:when test="${accountPurchaseSupplier.payway==payway.id}">
														<option value="${payway.id}" selected='true'>${payway.name}</option>
													</c:when>
													<c:otherwise>
														 <option value="${payway.id}">${payway.name}</option>
													</c:otherwise>
												</c:choose>
												
												</c:forEach>
										</select>	
										
									</td>
								</tr>
							</c:forEach>
						</tbody>
						</table>
					<script type="text/template" id="">
					</script>
					
				</div>
			</div>	
		<div class="form-actions">
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="提交"/>&nbsp;
			<input id="btnSubmit" class="btn btn-inverse" type="submit" value="销毁" onclick="$('#conclusion').val('no')"/>&nbsp;	
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>