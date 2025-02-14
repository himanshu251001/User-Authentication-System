# README

The authentication system allows users to sign up, log in, and log out while managing their profiles securely. I created a User model that includes essential fields such as first name, last name, date of birth, and gender, and customized the Devise views for a user-friendly interface. Validation checks ensure that all required fields are filled out correctly, with appropriate error messages displayed for any issues during signups or logins.

For database management, I implemented migrations to handle user-related fields and populated the database with default admin and test users using the Rails seed file. The system restricts users from accessing or modifying profiles other than their own, while admin users have access to a dedicated dashboard for user management.

Additionally, I enabled profile picture uploads and configured email confirmation for new accounts. Password recovery options are also integrated through Devise’s built-in features. Overall, this project not only meets all specified requirements but also provides a seamless and secure user experience in my Ruby on Rails application.
