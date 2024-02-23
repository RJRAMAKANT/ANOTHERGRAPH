package com.daoclass;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.beanclass.GraphMonthWise;
import com.connection.DBConnection;

public class GraphByMonthDao {
	public ArrayList<GraphMonthWise>gmw=new ArrayList<>();
	public ArrayList<GraphMonthWise> showGraphByMonth(GraphMonthWise graph){
		String Grpahcenter=graph.getCenercode();
		String Graphyear=graph.getCenteryear();
		
		try{
			Connection con=DBConnection.getcon();
			PreparedStatement ps=con.prepareStatement("select mid(diagOfStroke,5,2),count(*) from hbsr_coreform where cencode=? and left(diagOfStroke,4)=? group by mid(diagOfStroke,5,2)");
			ps.setString(1, Grpahcenter);
			ps.setString(2, Graphyear);
			
			ResultSet rs=ps.executeQuery();
			while(rs.next())
			{
				GraphMonthWise graphmoth=new GraphMonthWise();
				graphmoth.setMonth(rs.getString(1));
				graphmoth.setTotalCases(rs.getString(2));
				gmw.add(graphmoth);
				
				
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return gmw;
	}

}
