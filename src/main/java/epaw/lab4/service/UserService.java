package epaw.lab4.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import epaw.lab4.model.User;
import epaw.lab4.repository.UserRepository;
import jakarta.servlet.http.Part;

import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

public class UserService {

    private static UserService instance;
    private UserRepository userRepository;

    private UserService() {
        this.userRepository = UserRepository.getInstance();
    }

    public static synchronized UserService getInstance() {
        if (instance == null) {
            instance = new UserService();
        }
        return instance;
    }

    private static final String PASSWORD_REGEX = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[!@#$%^&*]).{8,}$";

    public Map<String, String> validate(User user) {
        Map<String, String> errors = new HashMap<>();

        String username = user.getUsername();
        if (username == null || username.trim().isEmpty()) {
            errors.put("name", "Username cannot be empty.");
        } else if (username.length() < 5 || username.length() > 20) {
            errors.put("name", "Username must be between 5 and 20 characters.");
        } else if (userRepository.existsByUsername(username)) {
            errors.put("name", "Username already exists.");
        }

        String password = user.getPassword();
        if (password == null || !password.matches(PASSWORD_REGEX)) {
            errors.put("password",
                    "Minimum 8 characters, including uppercase, numbers, and a special character (@#$%^&*).");
        }

        String email = user.getEmail();
        if (email == null || email.trim().isEmpty()) {
            errors.put("email", "Email cannot be empty.");
        }

        String firstName = user.getFirstName();
        if (firstName == null || firstName.trim().isEmpty()) {
            errors.put("firstName", "First name cannot be empty.");
        }

        String lastName = user.getLastName();
        if (lastName == null || lastName.trim().isEmpty()) {
            errors.put("lastName", "Last name cannot be empty.");
        }

        String dob = user.getDateOfBirth();
        if (dob == null || dob.trim().isEmpty()) {
            errors.put("dateOfBirth", "Date of birth cannot be empty.");
        }
        
        

        return errors;
    }

    public Map<String, String> register(User user) {
        Map<String, String> errors = validate(user);
        if (errors.isEmpty()) {
            userRepository.save(user);
        }
        return errors;
    }

    public Map<String, String> login(User user) {
        Map<String, String> errors = new HashMap<>();
        if (!userRepository.checkLogin(user)) {
            errors.put("password", "The combination of username and password does not match in our database.");
        }else if (user.isBanned()) {
        errors.put("password", "Your account has been suspended.");
        }
        return errors;
    }

    public void updateProfile(User user) {
        userRepository.update(user);
    }

    // Get all users
    public List<User> getAllUsers() {
        Optional<List<User>> users = userRepository.findAll();
        if (users.isPresent())
            return users.get();
        return null;
    }
    
    // Get followed users
    public List<User> getFollowedUsers(Integer id, Integer start, Integer end) {
        Optional<List<User>> users = userRepository.findFollowed(id,start,end);
        if (users.isPresent())
            return users.get();
        return null;
    }
    
    // Get unfollowed users
    public List<User> getNotFollowedUsers(Integer id, Integer start, Integer end) {
        Optional<List<User>> users = userRepository.findNotFollowed(id,start,end);
        if (users.isPresent())
            return users.get();
        return null;
    }
    
    // Follow User
    public void follow(Integer uid,Integer fid) {
        userRepository.followUser(uid, fid);
    }
    
    // Unfollow User
    public void unfollow(Integer uid,Integer fid) {
        userRepository.unfollowUser(uid, fid);
    }

    public String saveProfilePicture(Part filePart, String username) {
        if (filePart == null || filePart.getSize() <= 0) {
            return null;
        }

        try {
            String fileName = filePart.getSubmittedFileName();
            String extension = fileName.substring(fileName.lastIndexOf("."));
            String newFileName = username + extension;

            String resourcesDir = "EXTERNAL_RESOURCES";
            Files.createDirectories(Paths.get(resourcesDir));

            try (InputStream input = filePart.getInputStream()) {
                Files.copy(input, Paths.get(resourcesDir, newFileName), StandardCopyOption.REPLACE_EXISTING);
            }
            return newFileName;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}