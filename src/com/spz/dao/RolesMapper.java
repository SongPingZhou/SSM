package com.spz.dao;

import java.util.List;

import com.spz.entity.Roles;

public interface RolesMapper {
	
	/**
	 * 分页查询
	 * @param roles 
	 * @return
	 */
	List<Roles> selectRoles(Roles roles);
	
	/**
	 * 分页查询总数
	 * @param roles 
	 * @return
	 */
	Integer selectRolesCount(Roles roles);
	
	
	/**
	 * 查询全部角色
	 * @return
	 */
	List<Roles> selectRolesAll();
	
	/**
	 * 添加角色
	 * @param roles
	 * @return
	 */
	Integer insertRoles(Roles roles);
	
	/**
	 * 修该角色
	 * @param roles
	 * @return
	 */
	Integer updateRoles(Roles roles);
	
	/**
	 * 删除角色
	 * @param r_id
	 * @return
	 */
	Integer deleteRoles(Integer r_id);
}
