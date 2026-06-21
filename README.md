# 🍴 Forkful — Teacher Setup & Navigation Guide

Forkful is a food-focused social network (recipes, reviews, comments, likes, follows). This guide explains how to install it, create the required accounts, and navigate every feature of the application as each type of user.

---

## Part 1 — Installation

### Requirements

| Tool | Version | Check |
|---|---|---|
| Java JDK | 17 or higher | `java -version` |
| Maven | 3.8 or higher | `mvn -version` |
| SQLite3 CLI | any | `sqlite3 --version` |

### Steps

**1. Unzip and enter the project folder**
```bash
unzip epaw_lab4.zip
cd epaw_lab4
```

**2. Start the server**
```bash
mvn jetty:run
```

On first run this will download dependencies, create the `lab4.db` database automatically from the schema in `DB.txt`, and start the server. Wait until the terminal shows:
```
[INFO] Started ServerConnector...
[INFO] Started @...ms
```

**3. Open the app**
```
http://localhost:8080
```

---

## Part 2 — Creating the three types of accounts

The application has three user roles: **Anonymous** (not logged in), **Registered User**, and **Admin**. You will want at least two registered accounts (to test follow, like, comment between users) plus one admin account.

### Create regular accounts via the UI

Go to `http://localhost:8080`, click **Register** in the left menu and fill in the form. Do this twice to get two regular users. Suggested test accounts:

| Field | User A | User B |
|---|---|---|
| Username | `alice` | `bobby` |
| First name | Alice | Bob |
| Last name | Smith | Jones |
| Email | alice@test.com | bobby@test.com |
| Password | `Test1234!` | `Test1234!` |
| Date of birth | any | any |

### Promote one account to Admin (manual SQL step)

Admin accounts **cannot be created through the UI** — the role must be set directly in the database. This is intentional: there is no way for a regular user to grant themselves admin privileges through the web interface.

Open a second terminal (keep Jetty running), go to the project root, and run:

```bash
sqlite3 lab4.db
```

Inside the SQLite shell:
```sql
UPDATE users SET role = 'admin' WHERE username = 'alice';
```

Confirm it worked:
```sql
SELECT id, username, role FROM users;
```

Exit:
```sql
.quit
```

Now log out of Alice's account in the browser and log back in. The **Admin Panel** link will appear in the left sidebar.

> **Why log out and back in?** The session stores a snapshot of the User object at login time. Changing the role in the database does not update an already-running session — a fresh login is required for the change to take effect.

---

## Part 3 — What each user type can do

---

### 👤 Anonymous user (not logged in)

An anonymous user is anyone who visits the site without logging in. No account needed.

**What they can see:**

#### Global feed (home page)
- The home page loads automatically at `http://localhost:8080`
- Shows all public posts from all users, ordered by most recent
- Each post card shows the author's avatar, username, post content, number of likes and comments
- Recipe posts show: title, servings, cooking time, ingredients, instructions
- Review posts show: place name, location, star rating, review text
- Scroll down to the bottom and click **Load more** to load older posts

#### Individual user profiles
- Click any username or avatar anywhere on the site to open their public profile
- The profile page shows: avatar, name, username, title/role, bio, food preferences, number of followers and following
- Anonymous users **cannot** follow, like, comment, or interact in any way — all action buttons are hidden

**What they cannot do:**
- Like or save posts
- Comment on posts
- Follow users
- Publish posts
- Edit any profile
- Access the Admin Panel

**Navigation available:**
- Left sidebar: Home, Explore (search), Log In, Register

---

### 🧑 Registered user (logged in)

Register at `http://localhost:8080` → click **Register** in the left menu.

After logging in, the left sidebar changes to show: Home, Explore, Notifications, Followed, Saved, More, Log Out.

#### The home feed — For You and Following tabs

After logging in, the home feed shows two tabs at the top:

- **For You** — global feed, all posts from all users, most recent first (same as anonymous view)
- **Following** — personalized feed showing **only posts from users you follow**. If you follow nobody yet, this tab will be empty.

Switch between tabs by clicking them. The active tab is highlighted in orange.

#### Publishing a post

Click the orange **Share** button at the top of the feed. A form slides down with two post types selectable from a dropdown:

**Recipe post fields:**
- Recipe title
- Number of servings
- Cooking time (minutes)
- Ingredients (free text)
- Instructions (free text)
- Optional image upload
- Optional text description

**Review post fields:**
- Review title
- Restaurant / dish name
- Location
- Star rating (0.5 to 5.0)
- Optional image upload
- Optional text description

Click **Post** to publish. The feed refreshes and the new post appears at the top.

#### Editing a post

On any post you own, an **Edit** button (green, pencil icon) appears in the action row below the post. Click it to slide open an inline edit form pre-filled with all the current values. Edit any fields and click **Save**. Click **Cancel** to discard changes. The feed refreshes after saving.

#### Deleting a post

On any post you own, a **Delete** button (red, trash icon) appears next to Edit. Click it and the post is removed immediately.

#### Liking a post

Click the **heart icon** below any post. The like count increases immediately. Click again to unlike. You can like both top-level posts and comments. Liking someone else's post sends them a notification.

#### Saving a post

Click the **bookmark icon** below any post to save it to your personal saved list. Click again to unsave. Saved posts are accessible from **Saved** in the left sidebar.

#### Commenting on a post

Click the **comment bubble icon** below any post to expand the comments panel. Existing comments load (they are only fetched once — toggling closed and open again does not re-fetch). Type in the text box at the bottom and press **Enter** or click **Comment**. The comment appears immediately. Comments can also be liked.

#### Finding and following users

**From the right column (Who to follow):** The right sidebar shows a list of users you don't follow yet, sorted by how many food preferences you have in common. Click **Follow** next to any of them.

**From the search box:** The top bar has a search field. Start typing a username — a live autocomplete dropdown appears. Click any result to go to their profile.

**From the global feed:** Click any username or avatar on any post to visit their profile.

#### Viewing who you follow

Click **Followed** in the left sidebar. This page lists every user you currently follow, with their avatar, username and a link to their profile. Each entry has an **Unfollow** button.

#### Viewing who follows you

Go to your own profile (click **Profile** or your avatar in the header), then click the **Followers** count. This shows everyone who follows you, with a **Follow back** button for those you don't follow yet.

#### Viewing and editing your own profile

Click **Profile** in the left sidebar or your avatar in the top bar. Your profile page shows your public information and all your posts.

Click **Edit profile** to open the edit form. Editable fields:
- First name and last name
- Email address
- Title / role (e.g. "Chef", "Food Blogger")
- Phone number
- Gender
- Date of birth
- Bio (up to 500 characters)
- Allergies
- Food preferences (checkboxes: Italian, Mexican, Japanese, Vegan, etc.)
- Profile picture (file upload — replaces current picture)

Click **Save changes** to apply. You are redirected back to your profile page.

#### Notifications

Click **Notifications** in the left sidebar. This shows a list of recent activity: new followers, likes on your posts, comments on your posts, saves of your posts. All notifications are marked as read when you open this page.

#### Requesting account verification

On your own profile page, there is a **Request Verification** form. Enter a short message explaining why you should be verified (e.g. professional chef, food critic). The request goes to the admin panel for review. Once accepted, a verified badge (✓) appears on your profile.

#### Saved posts

Click **Saved** in the left sidebar to see all posts you have bookmarked, in a feed identical to the home feed but filtered to only your saved posts.

#### Deleting your account

Go to **Profile → Edit profile**, scroll to the bottom and click **Delete account**. This permanently deletes your account and all your posts, likes, comments and follows. You are logged out immediately.

---

### 🛡️ Admin user

The admin account has all the abilities of a regular registered user, plus access to the **Admin Panel**.

Click **Admin Panel** in the left sidebar (only visible to admins).

The admin panel has three sections:

#### Users table

Shows all registered users with their id, username, full name, email, role, verified status and banned status.

Actions available per user:

- **Ban** — prevents the user from logging in. Their account and posts remain visible but they cannot authenticate. (If they try to log in they see "Your account has been suspended".)
- **Unban** — restores login access.
- **Edit** — opens an inline form to update the user's first name, last name and email directly from the admin panel without needing access to their account.
- **Delete** — permanently deletes the user and all their content (posts, comments, likes, follows, notifications) via database cascade.

#### Posts table

Shows all posts in the system with their id, author, type and content preview.

Actions available per post:

- **Delete** — removes the post and all its comments (cascade). Admins can delete any post regardless of who owns it.

#### Verification requests table

Shows all pending verification badge requests with the username and the message the user submitted.

Actions available per request:

- **Accept** — marks the user as verified (`verified = 1` in the database) and sends them a notification. A verified badge appears on their profile.
- **Reject** — marks the request as rejected and sends the user a notification.

---

## Part 4 — Resetting for a fresh demo

To wipe all data and start over:

```bash
# Stop Jetty first (Ctrl+C in the terminal running mvn jetty:run)
rm lab4.db
rm -rf EXTERNAL_RESOURCES/*
mvn jetty:run
```

The database is recreated automatically on next start. Remember to re-register accounts and re-promote the admin via `sqlite3` as described in Part 2.