package com.spz.dao;

import java.util.List;

import com.spz.entity.UserRoles;

public interface UserRolesMapper {
	
	/**
	 * 批量添加员工的角色
	 * @param r_id角色id
	 * @return
	 */
	Integer insertUserRoles(List<UserRoles> usersRoles);
	
	/**
	 * 删除员工下的所有角色
	 * @param u_id
	 * @return
	 */
	Integer deleteUserRoles(Integer u_id);
}
