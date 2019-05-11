package com.spz.entity;

public class Roles {
		private Integer r_id;
		private String r_name;
		private Integer r_int0;
		private String r_string0;
		public Integer getR_id() {
			return r_id;
		}
		public void setR_id(Integer r_id) {
			this.r_id = r_id;
		}
		public String getR_name() {
			return r_name;
		}
		public void setR_name(String r_name) {
			this.r_name = r_name;
		}
		public Integer getR_int0() {
			return r_int0;
		}
		public void setR_int0(Integer r_int0) {
			this.r_int0 = r_int0;
		}
		public String getR_string0() {
			return r_string0;
		}
		public void setR_string0(String r_string0) {
			this.r_string0 = r_string0;
		}
		public Roles(Integer r_id, String r_name, Integer r_int0, String r_string0) {
			super();
			this.r_id = r_id;
			this.r_name = r_name;
			this.r_int0 = r_int0;
			this.r_string0 = r_string0;
		}
		public Roles() {
			super();
			// TODO Auto-generated constructor stub
		}
		@Override	
		public String toString() {
			return "Roles [r_id=" + r_id + ", r_name=" + r_name + ", r_int0=" + r_int0 + ", r_string0=" + r_string0
					+ "]";
		}
		
}
