package epaw.lab4.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Part;

import java.io.IOException;

import epaw.lab4.model.User;
import epaw.lab4.service.UserService;

@MultipartConfig
@WebServlet("/UpdateProfile")
public class UpdateProfile extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private UserService userService;

    @Override
    public void init() throws ServletException {
        userService = UserService.getInstance();
    }

    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    HttpSession session = request.getSession(false);
    if (session == null || session.getAttribute("user") == null) {
        response.sendRedirect("Login");
        return;
    }

    User user = (User) session.getAttribute("user");

    user.setBio(request.getParameter("bio"));
    user.setPhone(request.getParameter("phone"));
    user.setAllergies(request.getParameter("allergies"));
    user.setTitle(request.getParameter("title"));
   String[] prefs = request.getParameterValues("foodPreferences");
    user.setFoodPreferences(prefs != null ? String.join(",", prefs) : "");

    // Handle picture upload
    try {
        Part picturePart = request.getPart("picture");
        String newPicture = userService.saveProfilePicture(picturePart, user.getUsername());
        if (newPicture != null) {
            user.setPicture(newPicture);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    userService.updateProfile(user);
    session.setAttribute("user", user); // update session too!

    request.setAttribute("updateSuccess", true);
    response.sendRedirect("Profile");
}

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("Profile");
    }
}
