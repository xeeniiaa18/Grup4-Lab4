package epaw.lab4.service;

import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import epaw.lab4.model.Post;
import epaw.lab4.model.Notification;
import epaw.lab4.repository.PostRepository;
import jakarta.servlet.http.Part;

public class PostService {

    private static PostService instance;
    private PostRepository postRepository;

    private PostService() {
        this.postRepository = PostRepository.getInstance();
    }

    public static synchronized PostService instance() {
        if (instance == null) {
            instance = new PostService();
        }
        return instance;
    }

    // Deprecated static method wrapper for compatibility if needed elsewhere
    public static PostService getInstance() {
        return instance();
    }


    public List<Post> getFollowingFeed(Integer currentUserId, Integer start, Integer end) {
        return postRepository.findFollowingFeed(currentUserId, start, end).orElse(null);
    }

    public Post getPostById(Integer id, Integer currentUserId) {
        return postRepository.findById(id, currentUserId).orElse(null);
    }

    public void update(Post post) {
        postRepository.updatePost(post);
    }

    public void add(Post post, String authorUsername) {
        postRepository.save(post);

        // If this post is a comment, notify the parent post author
        if (post.getPid() != null) {
            Integer parentAuthorId = postRepository.getPostAuthorId(post.getPid());
            if (parentAuthorId != null && parentAuthorId != post.getUid()) {
                String message = "@" + authorUsername + " commented on your post: \"" + truncate(post.getContent(), 30) + "\"";
                postRepository.addNotification(parentAuthorId, "comment", message);
            }
        }
    }

    public void delete(Integer id, Integer uid) {
        postRepository.delete(id, uid);
    }

    public List<Post> getPostsByUser(Integer uid, Integer currentUserId, Integer start, Integer end) {
        Optional<List<Post>> posts = postRepository.findByUser(uid, currentUserId, start, end);
        return posts.orElse(null);
    }

    public List<Post> getAllPosts(Integer currentUserId, Integer start, Integer end) {
        Optional<List<Post>> posts = postRepository.findAllPosts(currentUserId, start, end);
        return posts.orElse(null);
    }

    public List<Post> getSavedPosts(Integer uid, Integer start, Integer end) {
        Optional<List<Post>> posts = postRepository.findSavedByUser(uid, start, end);
        return posts.orElse(null);
    }

    public List<Post> getCommentsByPost(Integer pid, Integer currentUserId, Integer start, Integer end) {
        Optional<List<Post>> posts = postRepository.findCommentsByPost(pid, currentUserId, start, end);
        return posts.orElse(null);
    }

    public void like(Integer uid, Integer pid, String likerUsername) {
        postRepository.likePost(uid, pid);

        // Notify post author
        Integer postAuthorId = postRepository.getPostAuthorId(pid);
        if (postAuthorId != null && postAuthorId != uid) {
            String message = "@" + likerUsername + " liked your post!";
            postRepository.addNotification(postAuthorId, "like", message);
        }
    }

    public void unlike(Integer uid, Integer pid) {
        postRepository.unlikePost(uid, pid);
    }

    public void save(Integer uid, Integer pid, String saverUsername) {
        postRepository.savePost(uid, pid);

        // Notify post author when someone saves their post
        Integer postAuthorId = postRepository.getPostAuthorId(pid);
        if (postAuthorId != null && postAuthorId != uid) {
            String message = "@" + saverUsername + " saved your post!";
            postRepository.addNotification(postAuthorId, "save", message);
        }
    }

    public void unsave(Integer uid, Integer pid) {
        postRepository.unsavePost(uid, pid);
    }

    public void addCustomNotification(Integer uid, String type, String message) {
        postRepository.addNotification(uid, type, message);
    }

    public List<Notification> getNotifications(Integer uid) {
        return postRepository.getNotifications(uid);
    }

    public void markNotificationsAsRead(Integer uid) {
        postRepository.markNotificationsAsRead(uid);
    }

    private String truncate(String text, int length) {
        if (text == null) return "";
        if (text.length() <= length) return text;
        return text.substring(0, length) + "...";
    }
    
public String savePostImage(Part filePart) {
    if (filePart == null || filePart.getSize() <= 0) {
        return null;
    }
    try {
        String fileName = filePart.getSubmittedFileName();
        if (fileName == null || fileName.trim().isEmpty() || !fileName.contains(".")) {
            return null;
        }
        String extension = fileName.substring(fileName.lastIndexOf("."));
        String newFileName = "post_" + UUID.randomUUID() + extension;

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