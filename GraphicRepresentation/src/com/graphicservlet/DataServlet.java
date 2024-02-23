package com.graphicservlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.beanclass.CoiceByYear;
import com.beanclass.GraphByCenterYear;
import com.beanclass.GraphMonthWise;
import com.daoclass.*;

@SuppressWarnings("serial")
@WebServlet("/graphdata")
public class DataServlet extends HttpServlet{
	protected void doPost(HttpServletRequest req,HttpServletResponse res)throws ServletException,IOException{
		HttpSession hs=req.getSession();
		String options=req.getParameter("option");
		System.out.println(options);
		
		if(options.equals("center"))
		{
			String code=req.getParameter("center");
			String choose=req.getParameter("option1");
			System.out.println(code);
			System.out.println(choose);
			if(choose.equals("month"))
			{
				String yearfromchoose=req.getParameter("yearfromchoose");
				
				GraphMonthWise graph=new GraphMonthWise();
				graph.setCenercode(code);
				graph.setCenteryear(yearfromchoose);
				ArrayList<GraphMonthWise>MonthArray=new GraphByMonthDao().showGraphByMonth(graph);
				String CenterName=new CentetrNameByCode().Cname(code);
				System.out.println(CenterName);
				if(MonthArray.size()>0)
				{
					hs.setAttribute("monthdata", MonthArray);
					req.setAttribute("data", yearfromchoose); 
					req.setAttribute("data1", code); 
					req.setAttribute("data4", CenterName);
					req.getRequestDispatcher("MonthGraph.jsp").forward(req, res);
					
				}
				else
				{
					req.setAttribute("data7", CenterName);
					req.setAttribute("data6", code); 
					req.getRequestDispatcher("ERROR.jsp").forward(req,res);
				}
			}
			else
			{
				GraphByCenterYear graphbycenter=new GraphByCenterYear();
				graphbycenter.setCencode(code);
				ArrayList<GraphByCenterYear> graphcenter=new GraphByCenterYearDao().graphdata(graphbycenter);
				String CenterName=new CentetrNameByCode().Cname(code);
				if(graphcenter.size()>0)
				{
					hs.setAttribute("newdata", graphcenter);
					req.setAttribute("data2", code); 
					req.setAttribute("data5", CenterName);
					req.getRequestDispatcher("ByCenterAndYearGraph.jsp").forward(req, res);
					
				}
				else
				{
					req.setAttribute("data7", CenterName);
					req.setAttribute("data6", code); 
					req.getRequestDispatcher("ERROR.jsp").forward(req,res);
					
				}
			}
			
		}else
		{
			String yearr=req.getParameter("yearfromoption");
			System.out.println(yearr+" initial data");
			CoiceByYear cby=new CoiceByYear();
			cby.setYear(yearr);
			ArrayList<CoiceByYear> cb=new CooseByYearDao().graphdata(cby);
			if(cb.size()>0)
			{
				hs.setAttribute("yeardata", cb);
				req.setAttribute("data3",yearr ); 
				req.getRequestDispatcher("ByYearGraph.jsp").forward(req,res);
				
				
				
			}
			else
			{
				req.getRequestDispatcher("ERROR.jsp").forward(req,res);
				
			}
			
			
		}
	
	
		
	
		
	}
	

}
