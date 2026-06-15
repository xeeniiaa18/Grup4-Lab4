package epaw.lab4.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import epaw.lab4.model.User;
import epaw.lab4.service.UserService;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/SearchUsers")
public class SearchUsers extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        jakarta.servlet.http.HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("user") : null;

        if (currentUser == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "You must be logged in to search users.");
            return;
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        List<User> users = UserService.getInstance().getAllUsers();
        
        StringBuilder json = new StringBuilder("[");
        for (int i = 0; i < users.size(); i++) {
            User u = users.get(i);
            json.append(String.format("{\"uid\":%d, \"username\":\"%s\", \"firstName\":\"%s\", \"lastName\":\"%s\", \"picture\":\"%s\"}", 
                u.getId(), 
                escape(u.getUsername()), 
                escape(u.getFirstName()), 
                escape(u.getLastName()), 
                escape(u.getPicture())));
            if (i < users.size() - 1) {
                json.append(",");
            }
        }
        json.append("]");

        PrintWriter out = response.getWriter();
        out.print(json.toString());
        out.flush();
    }

    private String escape(String str) {
        if (str == null) return "";
        return str.replace("\"", "\\\"");
    }
}
