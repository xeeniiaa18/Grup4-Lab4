package epaw.lab4.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import epaw.lab4.model.User;
import epaw.lab4.service.UserService;

@WebServlet("/UpdateProfile")
public class UpdateProfile extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private UserService userService;

    @Override
    public void init() throws ServletException {
        userService = UserService.getInstance();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("Login");
            return;
        }

        User user = (User) session.getAttribute("user");

        String bio = request.getParameter("bio");
        String phone = request.getParameter("phone");
        String allergies = request.getParameter("allergies");
        String picture = request.getParameter("picture");
        String title = request.getParameter("title");
        String[] foodPrefs = request.getParameterValues("foodPreferences");

        String foodPrefsJoined = "";
        if (foodPrefs != null && foodPrefs.length > 0) {
            foodPrefsJoined = String.join(",", foodPrefs);
        }

        user.setBio(bio);
        user.setPhone(phone);
        user.setAllergies(allergies);
        user.setPicture(picture);
        user.setTitle(title);
        user.setFoodPreferences(foodPrefsJoined);

        userService.updateProfile(user);

        request.setAttribute("updateSuccess", true);
        request.getRequestDispatcher("Profile.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("Profile");
    }
}
