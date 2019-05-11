<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<script src="../js/global.js"></script>
<script type="text/javascript">
	function searchUserInfo() {
		$("#dg").datagrid({
			url:globalData.server+"GetUsers",
			queryParams: { //要发送的参数列表
				/*userName: $("#userName").textbox("getValue"),*/
				token: globalData.token,
				userName: $("#adduserName").val()
			}
		})
	}
	$(function (){
		searchUserInfo();
	})
	function addInfo() {
		$("#adduser_window").window("open");
	}

	function submitUserForms() {
		var data = $("#adduserForm").serialize();
		if($("#adduserForm").form("validate")) {
			$.ajax({
				url: globalData.server+'CreateUser',
				method: 'post',
				data: data + '&token='+globalData.token,
				dataType: 'json',
				success: function(res) {
					if(res.success) {
						$.messager.alert("提示信息", "新增成功", "info");
						$("#adduser_window").panel("close");
						$("#dg").datagrid("reload");
					} else 
						$.messager.alert("错误信息", "新增失败", "info");
				}
			})
		} else {
			$.messager.alert("提示信息", "请完成所有验证", "info");
		}
	}

	function clearUserForm() {
		$("#adduser_window").window("close");
	}
	//锁定和解锁用户
	function formatterLockUser(value, row, index) {
		return "<a style='cursor: pointer;' onclick='lockUser(" + index + ")'>锁定用户</a> <a style='cursor: pointer;' onclick='unlockUser(" + index + ")'>解锁用户</a>";
	}
	//设置角色权限
	function formatterSetRole(value, row, index) {
		return "<a style='cursor: pointer;' onclick='showRoles(" + index + ")'>设置</a>";
	}
	//重置密码
	function formatterResetPassword(value, row, index) {
		return "<a style='cursor: pointer;' onclick='resetPassword(" + index + ")'>重置密码</a>";
	}
	//操作用户
	function formatterOPUser(value, row, index) {
		return "<a style='cursor: pointer;' onclick='updateInfo(" + index + ")'>编辑</a> <a style='cursor: pointer;' onclick='deleteInfo(" + index + ")'>删除</a>";
	}

	function updateInfo(index) {
		//将当前数据填入表单
		var data = $("#dg").datagrid("getData");
		var row = data.rows[index];
		$("#updateuserForm").form("load", row);
		$("#updateuser_window").window("open");
	}

	function updatesubmitUserForms() {
		var email = $("#ProtectEMail").val();
		var mtel = $("#ProtectMTel").val();
		var loginName = $("#LoginName").val();
		$.post(globalData.server+"UpdateUser", {
			email: email,
			mtel: mtel,
			loginName: loginName,
			token: globalData.token
		}, function(res) {
			if(res.success) {
				$.messager.alert("提示信息", "修改成功", "info");
				$("#updateuser_window").panel("close");
				$("#dg").datagrid("reload");
			} else
				$.messager.alert("提示信息", "修改失败", "info");

		}, "json");
	}

	function updateUserForms() {
		$("#updateuser_window").window("close");
	}

	function deleteInfo(index) {
		var data = $("#dg").datagrid("getData");
		var row = data.rows[index];
		$.messager.confirm('确认', '您确认想要删除记录吗？', function(r) {
			if(r) { // 用户点击了确认按钮
				$.ajax({
					method: 'post',
					url: globalData.server+'DeleteUser',
					data: {
						"uid": row.Id,
						"token": globalData.token
					},
					success: function(data) {
						var d = eval("(" + data + ")");
						if(d.success) {
							$("#dg").datagrid("reload");
							$.messager.alert("提示信息", "成功删除", "info");
						} else
							$.messager.alert("错误信息", "删除失败", "info");
					}
				})
			}
		});
	}
	var yhid;
	var yhna;
	function showRoles(index) {
		var data = $("#dg").datagrid("getData");
		var row = data.rows[index];
		yhna=row.LoginName;
		yhid=row.Id;  
		$("#allRoles").datagrid({
			url:globalData.server+"GetRolesAll",
			queryParams: { //要发送的参数列表
				token: globalData.token
			}
		})
		$("#allUserRoles").datagrid({
			url:globalData.server+"GetRoleByUserId",
			queryParams: { //要发送的参数列表
				uId:row.Id,
				token: globalData.token
			}
		})
		$("#diaUserRoles").dialog({
			title:'您正在设置--'+yhna+'--的权限'
		})
		$("#diaUserRoles").window("open");
	}

	function lockUser(index) {
		var data = $("#dg").datagrid("getData");
		var row = data.rows[index];
		$.messager.confirm('确认', '您确认想要锁定--' + row.LoginName + '--用户？', function(r) {
			if(r) {
				$.ajax({
					type: "post",
					url: globalData.server+"LockUser",
					dataType: 'json',
					data: {
						"un": row.LoginName,
						"token": globalData.token
					},
					success: function(res) {
						if(res.success) {
							$.messager.alert("提示信息", "锁定成功");
						} else
							$.messager.alert("错误信息", "锁定失败");
					}
				});
			}
		});
	}

	function unlockUser(index) {
		var data = $("#dg").datagrid("getData");
		var row = data.rows[index];
		$.messager.confirm('确认', '您确认要为--' + row.LoginName + '--解锁？', function(r) {
			if(r) {
				$.ajax({
					type: "post",
					url: globalData.server+"UnLockUser",
					dataType: 'json',
					data: {
						"un": row.LoginName,
						"token": globalData.token
					},
					success: function(res) {
						if(res.success) {
							$.messager.alert("提示信息", "解锁成功");
						} else
							$.messager.alert("错误信息", "解锁失败");
					}
				});
			}
		});
	}
	function adddiaUserRoles(){
		var nodes = $("#allRoles").datagrid("getSelected");
		$.ajax({
			method:'post',
			url:globalData.server+'AddUserToRole',
			data:{"uId":yhid,"rId":nodes.Id,"token":globalData.token}, 
			dataType:'json',
			success:function(res){
				if(res.success){
					$("#allUserRoles").datagrid("reload");
				}
			}
		})
	}
	function removediaUserRoles(){
		var nodes = $("#allUserRoles").datagrid("getSelected");
		$.ajax({
			method:'post',
			url:globalData.server+'RemoveUserFromRole',
			data:{"uId":yhid,"rId":nodes.Id,"token":globalData.token}, 
			dataType:'json',
			success:function(res){
				if(res.success){
					$("#allUserRoles").datagrid("reload");
				}
			}
		})
	}
</script>
<table name="center" class="easyui-datagrid" id="dg" title="用户列表" data-options="rownumbers:true,singleSelect:true,pagination:true,method:'post',toolbar:'#usertb',pageSize:10">
	<thead>
		<tr>
			<th data-options="field:'Id',width:80,hidden:true">用户ID</th>
			<th data-options="field:'LoginName',width:100">用户名</th>
			<th data-options="field:'ProtectEMail',width:100">邮箱</th>
			<th data-options="field:'ProtectMTel',width:100,">手机号</th>
			<th data-options="field:'IsLockout',width:100,">是否锁定</th>
			<th data-options="field:'CreateTime',width:160,">创建时间</th>
			<th data-options="field:'LastLoginTime',width:160,">最后登录的时间</th>
			<th data-options="field:'setRoleAction',width:60,align:'center',formatter:formatterSetRole">角色</th>
			<th data-options="field:'setUserAction',width:120,align:'center',formatter:formatterOPUser">操作</th>
			<th data-options="field:'setPassword',width:80,align:'center',formatter:formatterResetPassword">操作</th>
			<th data-options="field:'setLock',width:140,align:'center',formatter:formatterLockUser">用户操作</th>
		</tr>
	</thead>
</table>

<div id="usertb" style="padding:5px; height:auto">
	<div style="margin-bottom:5px">
		&nbsp;&nbsp;&nbsp;&nbsp; 用户名: <input class="easyui-textbox" id="adduserName" style="width:80px"> &nbsp;&nbsp;&nbsp;&nbsp;起止时间:
		<input class="easyui-datebox" id="userName" style="width:80px">-<input class="easyui-datebox" id="userName" style="width:80px"> &nbsp;&nbsp;&nbsp;&nbsp; 是否锁定:
		<select id="cc" class="easyui-combobox" name="dept" style="width:auto;">
			<option value="">--请选择---</option>
			<option value="是">是</option>
			<option value="否">否</option>
	    </select>
	    排序方式：
		<select id="ord" class="easyui-combobox" name="orderBy" style="height:auto;">
			<option value="">---请选择---</option>
			<option value="CreateTime">创建时间</option>
			<option value="LastLoginTime">最后登录时间</option>
		</select>
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" onclick="searchUserInfo()">检索</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" onclick="addInfo()">新增</a>&nbsp;&nbsp;&nbsp;&nbsp;
	</div>
</div>

<!--新增表单-->

<div id="adduser_window" class="easyui-window" title="新增员工信息" data-options="modal:true,closed:true,iconCls:'icon-save'" style="width:380px;height:300px;padding:10px; top: 200px;">
	<form id="adduserForm">
		<center>
			<table cellpadding="5">
				<tr>
					<td>用户名:</td>
					<td><input class="easyui-textbox" type="text" name="loginName" id="loginName" data-options="required:true"></input>
					</td>
				</tr>
				<tr>
					<td>密码:</td>
					<td><input class="easyui-textbox" type="password" id="pwd" name="pwd" data-options="required:true"></input>
					</td>
				</tr>
				<tr>
					<td>Email:</td>
					<td><input class="easyui-textbox" type="text" name="email" id="email" data-options="required:true,validType:'email'"></input>
					</td>
				</tr>
				<tr>
					<td>手机号:</td>
					<td><input type="text" class="easyui-numberbox" id="mtel" name="mtel" data-options="required:true"></td>
				</tr>
			</table>
		</center>
	</form>
	<div style="text-align:center;padding:5px">
		<a href="javascript:void(0)" class="easyui-linkbutton" type="button" onclick="submitUserForms()">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearUserForm()">取消</a>
	</div>
</div>

<!--修改的表单-->
<div id="updateuser_window" class="easyui-window" title="新增员工信息" data-options="modal:true,closed:true,iconCls:'icon-save'" style="width:380px;height:300px;padding:10px; top: 200px;">
	<form id="updateuserForm">
		<center>
			<table cellpadding="5">
				<tr>
					<td>用户名:</td>
					<td><input class="easyui-textbox" type="text" name="LoginName" readonly="readonly" id="LoginName" data-options="required:true"></input>
					</td>
				</tr>
				<tr>
					<td>Email:</td>
					<td><input class="easyui-textbox" type="text" name="ProtectEMail" id="ProtectEMail" data-options="required:true,validType:'email'"></input>
					</td>
				</tr>
				<tr>
					<td>手机号:</td>
					<td><input type="text" class="easyui-numberbox" id="ProtectMTel" name="ProtectMTel" data-options="required:true"></td>
				</tr>
			</table>
		</center>
	</form>
	<div style="text-align:center;padding:5px">
		<a href="javascript:void(0)" class="easyui-linkbutton" type="button" onclick="updatesubmitUserForms()">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="updateUserForms()">取消</a>
	</div>
</div>

<div id="diaUserRoles" class="easyui-window" data-options="modal:true,iconCls:'icon-save',collapsible:false,minimizable:false,maximizable:false,closed:true" style="width: auto;height: auto;top: 30px;">
	<table style="margin-top: 20px; margin-left: 20px; margin-right: 20px;">
		<tr>
			<td>
				<table  id="allRoles" class="easyui-datagrid"  title="系统所有角色" data-options="rownumbers:true,singleSelect:true,method:'post'" style="width: 150px;">
					<thead>
						<tr>
							<th data-options="field:'Id',width:80,hidden:true">ID</th>
							<th data-options="field:'Name',width:100">名称</th>
						</tr>
					</thead>
				</table>
			</td>
			<td>
				<a href="javascript:void(0)" onclick="adddiaUserRoles()" class="easyui-linkbutton" style="width: 40px;">>></a>
				<br />
				<br />
				<a href="javascript:void(0)" onclick="removediaUserRoles()" class="easyui-linkbutton" style="width: 40px;" ><<</a>
			</td>
			<td>
				<table  id="allUserRoles" class="easyui-datagrid"  title="当前用户的角色" data-options="rownumbers:true,singleSelect:true,method:'post'" style="width: 150px;">
					<thead>
						<tr>
							<th data-options="field:'Id',width:80,hidden:true">ID</th>
							<th data-options="field:'Name',width:100">名称</th>
						</tr>
					</thead>
				</table>
			</td>
			<td></td>
		</tr>
	</table>
</div>