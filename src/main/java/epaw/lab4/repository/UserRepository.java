package epaw.lab4.repository;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.mindrot.jbcrypt.BCrypt;
import epaw.lab4.model.User;

public class UserRepository extends BaseRepository {

    private static UserRepository instance;

    private UserRepository() {
        super();
    }

    public static synchronized UserRepository getInstance() {
        if (instance == null) {
            instance = new UserRepository();
        }
        return instance;
    }

    public boolean existsByUsername(String username) {
        String query = "SELECT COUNT(*) FROM users WHERE username = ?";
        try (PreparedStatement statement = db.prepareStatement(query)) {
            statement.setString(1, username);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean checkLogin(User user) {
        // Fetch hash by username only; verify with BCrypt to avoid timing attacks
        String query = "SELECT id, password, picture, email, phone, firstName, lastName, dateOfBirth, gender, title, allergies, foodPreferences, bio, role, verified, banned FROM users WHERE username = ?";
        try (PreparedStatement statement = db.prepareStatement(query)) {
            statement.setString(1, user.getUsername());
            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    String storedHash = rs.getString("password");
                    if (user.getPassword() == null || storedHash == null || !storedHash.startsWith("$2")) {
                        return false;
                    }
                    try {
                        if (!BCrypt.checkpw(user.getPassword(), storedHash)) {
                            return false;
                        }
                    } catch (IllegalArgumentException e) {
                        return false;
                    }
                    user.setId(rs.getInt("id"));
                    user.setPicture(rs.getString("picture"));
                    user.setEmail(rs.getString("email"));
                    user.setPhone(rs.getString("phone"));
                    user.setFirstName(rs.getString("firstName"));
                    user.setLastName(rs.getString("lastName"));
                    user.setDateOfBirth(rs.getString("dateOfBirth"));
                    user.setGender(rs.getString("gender"));
                    user.setTitle(rs.getString("title"));
                    user.setAllergies(rs.getString("allergies"));
                    user.setFoodPreferences(rs.getString("foodPreferences"));
                    user.setBio(rs.getString("bio"));
                    user.setRole(rs.getString("role"));
                    user.setVerified(rs.getBoolean("verified"));
                    user.setBanned(rs.getBoolean("banned"));
                    return true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public void save(User user) {
        String query = "INSERT INTO users (username, password, picture, email, phone, firstName, lastName, dateOfBirth, gender, title, allergies, foodPreferences, bio, role, verified) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement statement = db.prepareStatement(query)) {
            statement.setString(1, user.getUsername());
            // Hash password with BCrypt before storing
            String hashedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
            statement.setString(2, hashedPassword);
            statement.setString(3, user.getPicture());
            statement.setString(4, user.getEmail());
            statement.setString(5, user.getPhone());
            statement.setString(6, user.getFirstName());
            statement.setString(7, user.getLastName());
            statement.setString(8, user.getDateOfBirth());
            statement.setString(9, user.getGender());
            statement.setString(10, user.getTitle());
            statement.setString(11, user.getAllergies());
            statement.setString(12, user.getFoodPreferences());
            statement.setString(13, user.getBio());
            statement.setString(14, user.getRole());
            statement.setBoolean(15, user.isVerified());
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void update(User user) {
        String query = "UPDATE users SET picture=?, email=?, phone=?, firstName=?, lastName=?, dateOfBirth=?, gender=?, title=?, allergies=?, foodPreferences=?, bio=?, verified=? WHERE id=?";
        try (PreparedStatement st = db.prepareStatement(query)) {
            st.setString(1, user.getPicture());
            st.setString(2, user.getEmail());
            st.setString(3, user.getPhone());
            st.setString(4, user.getFirstName());
            st.setString(5, user.getLastName());
            st.setString(6, user.getDateOfBirth());
            st.setString(7, user.getGender());
            st.setString(8, user.getTitle());
            st.setString(9, user.getAllergies());
            st.setString(10, user.getFoodPreferences());
            st.setString(11, user.getBio());
            st.setBoolean(12, user.isVerified());
            st.setInt(13, user.getId());
            st.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    public void banUser(Integer id) {
        String query = "UPDATE users SET banned = 1 WHERE id = ?";
        try (PreparedStatement st = db.prepareStatement(query)) {
            st.setInt(1, id);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void unbanUser(Integer id) {
        String query = "UPDATE users SET banned = 0 WHERE id = ?";
        try (PreparedStatement st = db.prepareStatement(query)) {
            st.setInt(1, id);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteUser(Integer id) {
        String query = "DELETE FROM users WHERE id = ?";
        try (PreparedStatement st = db.prepareStatement(query)) {
            st.setInt(1, id);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }



    public Optional<User> findByName(String username) {
        String query = "SELECT id, username, password, picture, email, phone, firstName, lastName, dateOfBirth, gender, title, allergies, foodPreferences, bio, role, verified, banned FROM users WHERE username = ?";
        try (PreparedStatement statement = db.prepareStatement(query)) {
            statement.setString(1, username);
            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setUsername(rs.getString("username"));
                    user.setPassword(rs.getString("password"));
                    user.setPicture(rs.getString("picture"));
                    user.setEmail(rs.getString("email"));
                    user.setPhone(rs.getString("phone"));
                    user.setFirstName(rs.getString("firstName"));
                    user.setLastName(rs.getString("lastName"));
                    user.setDateOfBirth(rs.getString("dateOfBirth"));
                    user.setGender(rs.getString("gender"));
                    user.setTitle(rs.getString("title"));
                    user.setAllergies(rs.getString("allergies"));
                    user.setFoodPreferences(rs.getString("foodPreferences"));
                    user.setBio(rs.getString("bio"));
                    user.setRole(rs.getString("role"));
                    user.setVerified(rs.getBoolean("verified"));
                    user.setBanned(rs.getBoolean("banned"));
                    return Optional.of(user);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Optional.empty();
    }

    public Optional<User> findById(Integer id) {
        String query = "SELECT id, username, picture, email, phone, firstName, lastName, dateOfBirth, gender, title, allergies, foodPreferences, bio, role, verified, banned FROM users WHERE id = ?";
        try (PreparedStatement statement = db.prepareStatement(query)) {
            statement.setInt(1, id);
            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setUsername(rs.getString("username"));
                    user.setPicture(rs.getString("picture"));
                    user.setEmail(rs.getString("email"));
                    user.setPhone(rs.getString("phone"));
                    user.setFirstName(rs.getString("firstName"));
                    user.setLastName(rs.getString("lastName"));
                    user.setDateOfBirth(rs.getString("dateOfBirth"));
                    user.setGender(rs.getString("gender"));
                    user.setTitle(rs.getString("title"));
                    user.setAllergies(rs.getString("allergies"));
                    user.setFoodPreferences(rs.getString("foodPreferences"));
                    user.setBio(rs.getString("bio"));
                    user.setRole(rs.getString("role"));
                    user.setVerified(rs.getBoolean("verified"));
                    user.setBanned(rs.getBoolean("banned"));
                    return Optional.of(user);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Optional.empty();
    }

    public Optional<List<User>> findAll() {
        List<User> users = new ArrayList<>();
        String query = "SELECT id, username, picture, email, phone, firstName, lastName, dateOfBirth, gender, title, allergies, foodPreferences, bio, role, verified, banned FROM users";
        try (PreparedStatement statement = db.prepareStatement(query)) {
            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setUsername(rs.getString("username"));
                    user.setPicture(rs.getString("picture"));
                    user.setEmail(rs.getString("email"));
                    user.setPhone(rs.getString("phone"));
                    user.setFirstName(rs.getString("firstName"));
                    user.setLastName(rs.getString("lastName"));
                    user.setDateOfBirth(rs.getString("dateOfBirth"));
                    user.setGender(rs.getString("gender"));
                    user.setTitle(rs.getString("title"));
                    user.setAllergies(rs.getString("allergies"));
                    user.setFoodPreferences(rs.getString("foodPreferences"));
                    user.setBio(rs.getString("bio"));
                    user.setRole(rs.getString("role"));
                    user.setVerified(rs.getBoolean("verified"));
                    user.setBanned(rs.getBoolean("banned"));
                    users.add(user);
                }
                return Optional.of(users);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Optional.empty();
    }

    public void followUser(Integer uid, Integer fid) {
        String query = "INSERT INTO follows (uid,fid) VALUES (?,?)";
        try (PreparedStatement statement = db.prepareStatement(query)) {
            statement.setInt(1, uid);
            statement.setInt(2, fid);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void unfollowUser(Integer uid, Integer fid) {
        String query = "DELETE FROM follows WHERE uid = ? AND fid = ?";
        try (PreparedStatement statement = db.prepareStatement(query)) {
            statement.setInt(1, uid);
            statement.setInt(2, fid);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Optional<List<User>> findNotFollowed(Integer id, Integer start, Integer end) {
        String query;
        if (id == null) {
            query = "SELECT id, username, picture, firstName, lastName, title, verified, banned FROM users ORDER BY username LIMIT ?,?;";
        } else {
            query = "SELECT id, username, picture, firstName, lastName, title, verified, banned FROM users WHERE id NOT IN (SELECT fid FROM follows WHERE uid = ?) AND id <> ? ORDER BY username LIMIT ?,?;";
        }
        try (PreparedStatement statement = db.prepareStatement(query)) {
            if (id == null) {
                statement.setInt(1, start);
                statement.setInt(2, end);
            } else {
                statement.setInt(1, id);
                statement.setInt(2, id);
                statement.setInt(3, start);
                statement.setInt(4, end);
            }
            try (ResultSet rs = statement.executeQuery()) {
                List<User> users = new ArrayList<>();
                while (rs.next()) {
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setUsername(rs.getString("username"));
                    user.setPicture(rs.getString("picture"));
                    user.setFirstName(rs.getString("firstName"));
                    user.setLastName(rs.getString("lastName"));
                    user.setTitle(rs.getString("title"));
                    user.setVerified(rs.getBoolean("verified"));
                    user.setBanned(rs.getBoolean("banned"));
                    users.add(user);
                }
                return Optional.of(users);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Optional.empty();
    }

    public Optional<List<User>> findFollowers(Integer id, Integer start, Integer end) {
        String query = "SELECT id, username, picture, firstName, lastName, title, verified, banned " +
                    "FROM users, follows WHERE id = uid AND fid = ? ORDER BY username LIMIT ?,?;";
        try (PreparedStatement statement = db.prepareStatement(query)) {
            statement.setInt(1, id);
            statement.setInt(2, start);
            statement.setInt(3, end);
            try (ResultSet rs = statement.executeQuery()) {
                List<User> users = new ArrayList<>();
                while (rs.next()) {
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setUsername(rs.getString("username"));
                    user.setPicture(rs.getString("picture"));
                    user.setFirstName(rs.getString("firstName"));
                    user.setLastName(rs.getString("lastName"));
                    user.setTitle(rs.getString("title"));
                    user.setVerified(rs.getBoolean("verified"));
                    user.setBanned(rs.getBoolean("banned"));
                    users.add(user);
                }
                return Optional.of(users);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Optional.empty();
    }

    public Optional<List<User>> findFollowed(Integer id, Integer start, Integer end) {
        String query = "SELECT id, username, picture, firstName, lastName, title, verified, banned FROM users, follows WHERE id = fid AND uid = ? ORDER BY username LIMIT ?,?;";
        try (PreparedStatement statement = db.prepareStatement(query)) {
            statement.setInt(1, id);
            statement.setInt(2, start);
            statement.setInt(3, end);
            try (ResultSet rs = statement.executeQuery()) {
                List<User> users = new ArrayList<>();
                while (rs.next()) {
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setUsername(rs.getString("username"));
                    user.setPicture(rs.getString("picture"));
                    user.setFirstName(rs.getString("firstName"));
                    user.setLastName(rs.getString("lastName"));
                    user.setTitle(rs.getString("title"));
                    user.setVerified(rs.getBoolean("verified"));
                    user.setBanned(rs.getBoolean("banned"));
                    users.add(user);
                }
                return Optional.of(users);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Optional.empty();
    }
}
