# Minipelit-godot

## Commit, Pull & Push Guide From Godot

1. Make sure you have Godot Git Plugin installed.
2. Make sure you have Git installed.
3. Open a terminal or a command prompt and input the following: `ssh-keygen -t rsa -m pem -C "your-email-goes-here"` where the quoted part is the email address associated with your GitHub account.
4. In the same terminal `cat` the file with the .pub filetype like this: `cat ~/.ssh/id_rsa.pub` and copy the output.
5. In GitHub inside your account settings, go to the SSH and GPG key pages and create a new SSH key with the copied output.
6. Inside Godot go to "Project > Version control > Version control settings" and add in the username of your GitHub account, the path to both of the SSH keys generated.
7. Toggle "Connect to VCS" on.
8. In the top-right tab where the inspector is, should be a commit tab. Click it.
9. In the commit tab click the three dots on the bottom and add a remote if it doesn't exist already.
10. You can now use the Godot Editor to manage the project :).
