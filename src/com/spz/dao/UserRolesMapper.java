package com.spz.dao;

import java.util.List;

import com.spz.entity.UserRoles;

public interface UserRolesMapper {
	
	/**
	 * �������Ա���Ľ�ɫ
	 * @param r_id��ɫid
	 * @return
	 */
	Integer insertUserRoles(List<UserRoles> usersRoles);
	
	/**
	 * ɾ��Ա���µ����н�ɫ
	 * @param u_id
	 * @return
	 */
	Integer deleteUserRoles(Integer u_id);
}
