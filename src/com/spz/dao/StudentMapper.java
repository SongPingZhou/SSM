package com.spz.dao;

import java.util.List;

import com.spz.entity.Student;

public interface StudentMapper {
	
	List<Student> selectStudent(Student student);
	
	Integer CountStudent(Student Student);
	
	Integer insertStudent(Student Student);
	

	
	
}
