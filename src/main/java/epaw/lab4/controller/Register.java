package epaw.lab4.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import epaw.lab4.model.User;
import epaw.lab4.service.UserService;

import java.io.IOException;
import java.util.Map;

import org.apache.commons.beanutils.BeanUtils;

@MultipartConfig
@WebServlet("/Register")
public class Register extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private UserService userService;

	@Override
	public void init() throws ServletException {
		userService = UserService.getInstance();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.getRequestDispatcher("/WEB-INF/Register.jsp").forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		User user = new User();

		String gdprConsent = request.getParameter("gdprConsent");
		Map<String, String> errors;
		try {
			BeanUtils.populate(user, request.getParameterMap());
			errors = userService.validate(user);
			if (!"on".equals(gdprConsent)) {
				errors.put("gdprConsent", "You must accept the Privacy Policy to register.");
			}
			if (errors.isEmpty()) {
				String picturePath = userService.saveProfilePicture(request.getPart("picture"), user.getName());
				user.setPicture(picturePath);
				errors = userService.register(user, gdprConsent);
			}
		} catch (Exception e) {
			e.printStackTrace();
			errors = new java.util.HashMap<>();
			errors.put("form", "Registration could not be processed.");
		}
		if (errors.isEmpty()) {
			request.setAttribute("user", user);
			request.getRequestDispatcher("/WEB-INF/Login.jsp").forward(request, response);
		} else {
			request.setAttribute("user", user);
			request.setAttribute("errors", errors);
			request.getRequestDispatcher("/WEB-INF/Register.jsp").forward(request, response);
		}

	}

}
