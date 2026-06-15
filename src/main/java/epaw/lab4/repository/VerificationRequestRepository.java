package epaw.lab4.repository;

import epaw.lab4.model.VerificationRequest;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class VerificationRequestRepository extends BaseRepository {

    private static VerificationRequestRepository instance;

    private VerificationRequestRepository() {
        super();
    }

    public static synchronized VerificationRequestRepository getInstance() {
        if (instance == null) {
            instance = new VerificationRequestRepository();
        }
        return instance;
    }

    public void submit(int uid, String message) {
        String query = "INSERT INTO verification_requests (uid, message, status) VALUES (?, ?, 'pending') " +
                       "ON CONFLICT(uid) DO UPDATE SET message=excluded.message, status=excluded.status";
        try (PreparedStatement statement = db.prepareStatement(query)) {
            statement.setInt(1, uid);
            statement.setString(2, message);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<VerificationRequest> findAllPending() {
        List<VerificationRequest> list = new ArrayList<>();
        String query = "SELECT vr.*, u.username, u.firstName, u.lastName, u.picture " +
                       "FROM verification_requests vr JOIN users u ON u.id = vr.uid " +
                       "WHERE vr.status = 'pending' ORDER BY vr.created_at DESC";
        try (PreparedStatement statement = db.prepareStatement(query);
             ResultSet rs = statement.executeQuery()) {
            while (rs.next()) {
                VerificationRequest req = new VerificationRequest();
                req.setId(rs.getInt("id"));
                req.setUid(rs.getInt("uid"));
                req.setMessage(rs.getString("message"));
                req.setStatus(rs.getString("status"));
                req.setCreatedAt(rs.getString("created_at"));
                req.setUsername(rs.getString("username"));
                req.setFirstName(rs.getString("firstName"));
                req.setLastName(rs.getString("lastName"));
                req.setPicture(rs.getString("picture"));
                list.add(req);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public void accept(int id) {
        String updateRequest = "UPDATE verification_requests SET status = 'accepted' WHERE id = ?";
        String updateUser = "UPDATE users SET verified = 1 WHERE id = (SELECT uid FROM verification_requests WHERE id = ?)";
        String notifyUser = "INSERT INTO notifications (uid, type, message) VALUES ((SELECT uid FROM verification_requests WHERE id = ?), 'verification', 'Your verification request has been approved! You are now a verified user.')";
        try {
            try (PreparedStatement st1 = db.prepareStatement(updateUser)) {
                st1.setInt(1, id);
                st1.executeUpdate();
            }
            try (PreparedStatement st2 = db.prepareStatement(updateRequest)) {
                st2.setInt(1, id);
                st2.executeUpdate();
            }
            try (PreparedStatement st3 = db.prepareStatement(notifyUser)) {
                st3.setInt(1, id);
                st3.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void reject(int id) {
        String query = "UPDATE verification_requests SET status = 'rejected' WHERE id = ?";
        String notifyUser = "INSERT INTO notifications (uid, type, message) VALUES ((SELECT uid FROM verification_requests WHERE id = ?), 'verification', 'Your verification request has been rejected.')";
        try {
             try (PreparedStatement st2 = db.prepareStatement(notifyUser)) {
                 st2.setInt(1, id);
                 st2.executeUpdate();
             }
             try (PreparedStatement statement = db.prepareStatement(query)) {
                statement.setInt(1, id);
                statement.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Optional<VerificationRequest> findByUid(int uid) {
        String query = "SELECT * FROM verification_requests WHERE uid = ?";
        try (PreparedStatement statement = db.prepareStatement(query)) {
            statement.setInt(1, uid);
            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    VerificationRequest req = new VerificationRequest();
                    req.setId(rs.getInt("id"));
                    req.setUid(rs.getInt("uid"));
                    req.setMessage(rs.getString("message"));
                    req.setStatus(rs.getString("status"));
                    req.setCreatedAt(rs.getString("created_at"));
                    return Optional.of(req);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Optional.empty();
    }
}
