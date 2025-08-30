package in.sp.backend;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.DriverManager;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import in.sp.bean.Customer;
import in.sp.dao.custDao;

/**
 * Servlet implementation class Register
 */
@WebServlet("/regForm")
public class Register extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Register() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
	    String Firstname=req.getParameter("Firstname1");
	    String Lastname=req.getParameter("Lastname1");
	    String ContactDetails=req.getParameter("Contactdetails1");
	    String Residence=req.getParameter("Residence1");
	    String UserName=req.getParameter("Username1");
	    String Password=req.getParameter("pass1");
	    PrintWriter out = resp.getWriter();
	    Customer s = new Customer();
		s.setFirstname(Firstname);
		s.setLastName(Lastname);
		s.setContactDetails(ContactDetails);
		s.setResidence(Residence);
		s.setUserName(UserName);
	    s.setPassword(Password);
	    
	    int status = custDao.save(s);
	    
	    if (status > 0 ) {
			// Success - redirect to login page
			resp.setContentType("text/html");
			out.println("<html>");
			out.println("<head><title>Registration Success</title></head>");
			out.println("<body>");
			out.println("<script type='text/javascript'>");
			out.println("alert('Registration successful! Please login with your credentials.');");
			out.println("window.location.href = 'login.jsp';");
			out.println("</script>");
			out.println("</body>");
			out.println("</html>");
		}
	    	    
		else {
			// Error - redirect back to register page
			resp.setContentType("text/html");
	    	out.println("<html>");
	        out.println("<head><title>Registration Error</title></head>");
	        out.println("<body>");
	        out.println("<script type='text/javascript'>");
	        out.println("alert('An error occurred while registering. Please try again.');");
	        out.println("window.location.href = 'register.jsp';");
	        out.println("</script>");
	        out.println("</body>");
	        out.println("</html>");
		}
	    
	}

}
