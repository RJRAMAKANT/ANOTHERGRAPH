package com.daoclass;

import java.sql.Connection;

import com.connection.DBConnection;
import java.sql.*;

public class CentetrNameByCode {
	
	public String centerName="";
	
	public String Cname(String code)
	{
		try{
			
			Connection con=DBConnection.getcon();
			PreparedStatement ps=con.prepareStatement("select centre_Name from hbsr.hbsr_centredetails where centre_code=?");
			ps.setString(1, code);
			ResultSet rs=ps.executeQuery();
			while(rs.next())
			{
				centerName=rs.getString(1);
			}
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return centerName;
	}

}
