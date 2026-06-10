package epaw.lab4.repository;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import epaw.lab4.model.Post;
import epaw.lab4.model.Notification;

public class PostRepository extends BaseRepository {

    private static PostRepository instance;

    private PostRepository() {
        super();
    }

    public static synchronized PostRepository getInstance() {
        if (instance == null) {
            instance = new PostRepository();
        }
        return instance;
    }

    public void save(Post post) {
        String insertPostQuery = "INSERT INTO posts (uid, pid, type, text, image) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement statement = db.prepareStatement(insertPostQuery, Statement.RETURN_GENERATED_KEYS)) {
            statement.setInt(1, post.getUid());
            if (post.getPid() != null) {
                statement.setInt(2, post.getPid());
            } else {
                statement.setNull(2, java.sql.Types.INTEGER);
            }
            statement.setString(3, post.getType());
            statement.setString(4, post.getContent());
            statement.setString(5, post.getImage());
            statement.executeUpdate();

            try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    int postId = generatedKeys.getInt(1);
                    post.setId(postId);

                    if ("recipe".equalsIgnoreCase(post.getType())) {
                        String insertRecipeQuery = "INSERT INTO recipes (pid, title, servings, cooking_time, ingredients, instructions) VALUES (?, ?, ?, ?, ?, ?)";
                        try (PreparedStatement rStmt = db.prepareStatement(insertRecipeQuery)) {
                            rStmt.setInt(1, postId);
                            rStmt.setString(2, post.getTitle());
                            if (post.getServings() != null) {
                                rStmt.setInt(3, post.getServings());
                            } else {
                                rStmt.setNull(3, java.sql.Types.INTEGER);
                            }
                            if (post.getCookingTime() != null) {
                                rStmt.setInt(4, post.getCookingTime());
                            } else {
                                rStmt.setNull(4, java.sql.Types.INTEGER);
                            }
                            rStmt.setString(5, post.getIngredients());
                            rStmt.setString(6, post.getInstructions());
                            rStmt.executeUpdate();
                        }
                    } else if ("review".equalsIgnoreCase(post.getType())) {
                        String insertReviewQuery = "INSERT INTO reviews (pid, title, name, location, rating) VALUES (?, ?, ?, ?, ?)";
                        try (PreparedStatement revStmt = db.prepareStatement(insertReviewQuery)) {
                            revStmt.setInt(1, postId);
                            revStmt.setString(2, post.getReviewTitle());
                            revStmt.setString(3, post.getReviewName());
                            revStmt.setString(4, post.getLocation());
                            if (post.getRating() != null) {
                                revStmt.setDouble(5, post.getRating());
                            } else {
                                revStmt.setNull(5, java.sql.Types.DOUBLE);
                            }
                            revStmt.executeUpdate();
                        }
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void delete(Integer id, Integer uid) {
        String query = "DELETE FROM posts WHERE id = ? AND uid = ?";
        try (PreparedStatement statement = db.prepareStatement(query)) {
            statement.setInt(1, id);
            statement.setInt(2, uid);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void adminDelete(Integer id){
        String query = "DELETE FROM posts WHERE id = ?";
        try (PreparedStatement statement = db.prepareStatement(query)) {
            statement.setInt(1, id);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Optional<List<Post>> findByUser(Integer uid, Integer currentUserId, Integer start, Integer end) {
        List<Post> posts = new ArrayList<>();
        String query = "SELECT p.id, p.uid, p.pid, p.type, p.text, p.image, p.created_at, " +
                "u.username, u.firstName, u.lastName, u.picture AS upicture, " +
                "r.title AS recipe_title, r.servings, r.cooking_time, r.ingredients, r.instructions, " +
                "rev.title AS review_title, rev.name AS review_name, rev.location, rev.rating, " +
                "(SELECT COUNT(*) FROM likes WHERE likes.pid = p.id) AS likes_count, " +
                "(SELECT COUNT(*) FROM likes l WHERE l.pid = p.id AND l.uid = ?) AS liked_by_me, " +
                "(SELECT COUNT(*) FROM saved_posts s WHERE s.pid = p.id AND s.uid = ?) AS saved_by_me, " +
                "(SELECT COUNT(*) FROM posts c WHERE c.pid = p.id AND c.type = 'comment') AS comments_count " +
                "FROM posts p " +
                "INNER JOIN users u ON p.uid = u.id " +
                "LEFT JOIN recipes r ON p.id = r.pid " +
                "LEFT JOIN reviews rev ON p.id = rev.pid " +
                "WHERE p.uid = ? AND p.type != 'comment' " +
                "ORDER BY p.created_at DESC LIMIT ?, ?;";
        try (PreparedStatement statement = db.prepareStatement(query)) {
            statement.setInt(1, currentUserId != null ? currentUserId : 0);
            statement.setInt(2, currentUserId != null ? currentUserId : 0);
            statement.setInt(3, uid);
            statement.setInt(4, start);
            statement.setInt(5, end);
            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    posts.add(mapResultSetToPost(rs));
                }
                return Optional.of(posts);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Optional.empty();
    }

    public Optional<List<Post>> findAllPosts(Integer currentUserId, Integer start, Integer end) {
        List<Post> posts = new ArrayList<>();
        String query = "SELECT p.id, p.uid, p.pid, p.type, p.text, p.image, p.created_at, " +
                "u.username, u.firstName, u.lastName, u.picture AS upicture, " +
                "r.title AS recipe_title, r.servings, r.cooking_time, r.ingredients, r.instructions, " +
                "rev.title AS review_title, rev.name AS review_name, rev.location, rev.rating, " +
                "(SELECT COUNT(*) FROM likes WHERE likes.pid = p.id) AS likes_count, " +
                "(SELECT COUNT(*) FROM likes l WHERE l.pid = p.id AND l.uid = ?) AS liked_by_me, " +
                "(SELECT COUNT(*) FROM saved_posts s WHERE s.pid = p.id AND s.uid = ?) AS saved_by_me, " +
                "(SELECT COUNT(*) FROM posts c WHERE c.pid = p.id AND c.type = 'comment') AS comments_count " +
                "FROM posts p " +
                "INNER JOIN users u ON p.uid = u.id " +
                "LEFT JOIN recipes r ON p.id = r.pid " +
                "LEFT JOIN reviews rev ON p.id = rev.pid " +
                "WHERE p.type != 'comment' " +
                "ORDER BY p.created_at DESC LIMIT ?, ?;";
        try (PreparedStatement statement = db.prepareStatement(query)) {
            statement.setInt(1, currentUserId != null ? currentUserId : 0);
            statement.setInt(2, currentUserId != null ? currentUserId : 0);
            statement.setInt(3, start);
            statement.setInt(4, end);
            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    posts.add(mapResultSetToPost(rs));
                }
                return Optional.of(posts);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Optional.empty();
    }

    public Optional<List<Post>> findSavedByUser(Integer uid, Integer start, Integer end) {
        List<Post> posts = new ArrayList<>();
        String query = "SELECT p.id, p.uid, p.pid, p.type, p.text, p.image, p.created_at, " +
                "u.username, u.firstName, u.lastName, u.picture AS upicture, " +
                "r.title AS recipe_title, r.servings, r.cooking_time, r.ingredients, r.instructions, " +
                "rev.title AS review_title, rev.name AS review_name, rev.location, rev.rating, " +
                "(SELECT COUNT(*) FROM likes WHERE likes.pid = p.id) AS likes_count, " +
                "(SELECT COUNT(*) FROM likes l WHERE l.pid = p.id AND l.uid = ?) AS liked_by_me, " +
                "1 AS saved_by_me, " +
                "(SELECT COUNT(*) FROM posts c WHERE c.pid = p.id AND c.type = 'comment') AS comments_count " +
                "FROM saved_posts sp " +
                "INNER JOIN posts p ON sp.pid = p.id " +
                "INNER JOIN users u ON p.uid = u.id " +
                "LEFT JOIN recipes r ON p.id = r.pid " +
                "LEFT JOIN reviews rev ON p.id = rev.pid " +
                "WHERE sp.uid = ? " +
                "ORDER BY sp.created_at DESC LIMIT ?, ?;";
        try (PreparedStatement statement = db.prepareStatement(query)) {
            statement.setInt(1, uid);
            statement.setInt(2, uid);
            statement.setInt(3, start);
            statement.setInt(4, end);
            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    posts.add(mapResultSetToPost(rs));
                }
                return Optional.of(posts);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Optional.empty();
    }

    private Post mapResultSetToPost(ResultSet rs) throws SQLException {
        Post post = new Post();
        post.setId(rs.getInt("id"));
        post.setUid(rs.getInt("uid"));
        
        int pidVal = rs.getInt("pid");
        if (rs.wasNull()) {
            post.setPid(null);
        } else {
            post.setPid(pidVal);
        }

        post.setType(rs.getString("type"));
        post.setContent(rs.getString("text"));
        post.setImage(rs.getString("image"));
        post.setPostDateTime(rs.getTimestamp("created_at"));
        post.setUname(rs.getString("username"));
        post.setUfirstName(rs.getString("firstName"));
        post.setUlastName(rs.getString("lastName"));
        post.setUpicture(rs.getString("upicture"));

        post.setLikesCount(rs.getInt("likes_count"));
        post.setLikedByCurrentUser(rs.getInt("liked_by_me") > 0);
        post.setSavedByCurrentUser(rs.getInt("saved_by_me") > 0);
        post.setCommentsCount(rs.getInt("comments_count"));

        if ("recipe".equalsIgnoreCase(post.getType())) {
            post.setTitle(rs.getString("recipe_title"));
            post.setServings(rs.getInt("servings"));
            if (rs.wasNull()) post.setServings(null);
            post.setCookingTime(rs.getInt("cooking_time"));
            if (rs.wasNull()) post.setCookingTime(null);
            post.setIngredients(rs.getString("ingredients"));
            post.setInstructions(rs.getString("instructions"));
        } else if ("review".equalsIgnoreCase(post.getType())) {
            post.setReviewTitle(rs.getString("review_title"));
            post.setReviewName(rs.getString("review_name"));
            post.setLocation(rs.getString("location"));
            post.setRating(rs.getDouble("rating"));
            if (rs.wasNull()) post.setRating(null);
        }

        return post;
    }

    public Optional<List<Post>> findCommentsByPost(Integer pid, Integer currentUserId, Integer start, Integer end) {
        List<Post> posts = new ArrayList<>();
        String query = "SELECT p.id, p.uid, p.pid, p.type, p.text, p.image, p.created_at, " +
                "u.username, u.firstName, u.lastName, u.picture AS upicture, " +
                "NULL AS recipe_title, NULL AS servings, NULL AS cooking_time, NULL AS ingredients, NULL AS instructions, " +
                "NULL AS review_title, NULL AS review_name, NULL AS location, NULL AS rating, " +
                "(SELECT COUNT(*) FROM likes WHERE likes.pid = p.id) AS likes_count, " +
                "(SELECT COUNT(*) FROM likes l WHERE l.pid = p.id AND l.uid = ?) AS liked_by_me, " +
                "(SELECT COUNT(*) FROM saved_posts s WHERE s.pid = p.id AND s.uid = ?) AS saved_by_me, " +
                "0 AS comments_count " +
                "FROM posts p " +
                "INNER JOIN users u ON p.uid = u.id " +
                "WHERE p.pid = ? AND p.type = 'comment' " +
                "ORDER BY p.created_at ASC LIMIT ?, ?;";
        try (PreparedStatement statement = db.prepareStatement(query)) {
            statement.setInt(1, currentUserId != null ? currentUserId : 0);
            statement.setInt(2, currentUserId != null ? currentUserId : 0);
            statement.setInt(3, pid);
            statement.setInt(4, start);
            statement.setInt(5, end);
            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    posts.add(mapResultSetToPost(rs));
                }
                return Optional.of(posts);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Optional.empty();
    }

    // Likes management
    public void likePost(Integer uid, Integer pid) {
        String query = "INSERT OR IGNORE INTO likes (uid, pid) VALUES (?, ?)";
        try (PreparedStatement statement = db.prepareStatement(query)) {
            statement.setInt(1, uid);
            statement.setInt(2, pid);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void unlikePost(Integer uid, Integer pid) {
        String query = "DELETE FROM likes WHERE uid = ? AND pid = ?";
        try (PreparedStatement statement = db.prepareStatement(query)) {
            statement.setInt(1, uid);
            statement.setInt(2, pid);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Saved posts management
    public void savePost(Integer uid, Integer pid) {
        String query = "INSERT OR IGNORE INTO saved_posts (uid, pid) VALUES (?, ?)";
        try (PreparedStatement statement = db.prepareStatement(query)) {
            statement.setInt(1, uid);
            statement.setInt(2, pid);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void unsavePost(Integer uid, Integer pid) {
        String query = "DELETE FROM saved_posts WHERE uid = ? AND pid = ?";
        try (PreparedStatement statement = db.prepareStatement(query)) {
            statement.setInt(1, uid);
            statement.setInt(2, pid);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Integer getPostAuthorId(Integer pid) {
        String query = "SELECT uid FROM posts WHERE id = ?";
        try (PreparedStatement statement = db.prepareStatement(query)) {
            statement.setInt(1, pid);
            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("uid");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Notifications management
    public void addNotification(Integer uid, String type, String message) {
        String query = "INSERT INTO notifications (uid, type, message) VALUES (?, ?, ?)";
        try (PreparedStatement statement = db.prepareStatement(query)) {
            statement.setInt(1, uid);
            statement.setString(2, type);
            statement.setString(3, message);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Notification> getNotifications(Integer uid) {
        List<Notification> notifications = new ArrayList<>();
        String query = "SELECT id, uid, type, message, is_read, created_at FROM notifications WHERE uid = ? ORDER BY created_at DESC";
        try (PreparedStatement statement = db.prepareStatement(query)) {
            statement.setInt(1, uid);
            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    Notification notification = new Notification();
                    notification.setId(rs.getInt("id"));
                    notification.setUid(rs.getInt("uid"));
                    notification.setType(rs.getString("type"));
                    notification.setMessage(rs.getString("message"));
                    notification.setRead(rs.getBoolean("is_read"));
                    notification.setCreatedAt(rs.getTimestamp("created_at"));
                    notifications.add(notification);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return notifications;
    }

    public void markNotificationsAsRead(Integer uid) {
        String query = "UPDATE notifications SET is_read = 1 WHERE uid = ?";
        try (PreparedStatement statement = db.prepareStatement(query)) {
            statement.setInt(1, uid);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }}
