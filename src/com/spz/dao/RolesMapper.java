package com.spz.dao;

import java.util.List;

import com.spz.entity.Roles;

public interface RolesMapper {
	
	/**
	 * ��ҳ��ѯ
	 * @param roles 
	 * @return
	 */
	List<Roles> selectRoles(Roles roles);
	
	/**
	 * ��ҳ��ѯ����
	 * @param roles 
	 * @return
	 */
	Integer selectRolesCount(Roles roles);
	
	
	/**
	 * ��ѯȫ����ɫ
	 * @return
	 */
	List<Roles> selectRolesAll();
	
	/**
	 * ��ӽ�ɫ
	 * @param roles
	 * @return
	 */
	Integer insertRoles(Roles roles);
	
	/**
	 * �޸ý�ɫ
	 * @param roles
	 * @return
	 */
	Integer updateRoles(Roles roles);
	
	/**
	 * ɾ����ɫ
	 * @param r_id
	 * @return
	 */
	Integer deleteRoles(Integer r_id);
}
