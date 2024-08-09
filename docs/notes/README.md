<<<<<<< HEAD
## Git - template repo pull into new repo

https://stackoverflow.com/questions/37632568/git-template-repo-pull-into-new-repo

## Creating a repository from a template

https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-repository-from-a-template

https://github.com/docker-library/docs/tree/388783024e937bd87ee2f786fa308dc2ff123099/wordpress#how-to-use-this-image

# GitHub Markdown stuff

## Basic writing and formatting syntax

https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax#links

https://gist.github.com/rachelhyman/b1f109155c9dafffe618

https://gist.github.com/asabaylus/3071099#anchors-in-markdown

### GitHub Flavored Markdown Spec

https://github.github.com/gfm/

## How do I handle branches that are commits ahead and behind?

Branches that are "commits ahead" and "commits behind" indicate that they have diverged from the branch you're comparing them to, typically the `main` branch. Here's how to handle such branches and why it matters:

### Understanding "Commits Ahead" and "Commits Behind"

- **Commits Ahead:** This means the branch in question has commits that are not present in the branch you're comparing it to (e.g., `main`). These are new changes that haven't been merged yet.

- **Commits Behind:** This indicates that the branch you're working on does not have commits that are present in the branch you're comparing it to (e.g., `main`). This happens when new changes have been merged into `main` after your branch was created.

### Why It Matters

1. **Merge Conflicts:**

   - If your branch is both ahead and behind the `main` branch, there is a potential for merge conflicts when you eventually try to merge the branches. This is because the changes in both branches might conflict with each other.
   - Regularly syncing your branch with `main` helps reduce the likelihood of conflicts.

2. **Out-of-Date Features:**

   - If your branch is behind, you might be working with outdated code. This can lead to bugs or issues when merging, especially if critical updates have been made to the `main` branch.

3. **Clarity in Pull Requests:**
   - A branch that is significantly ahead or behind may make the PR more difficult to review because it will contain changes that are either already merged or irrelevant.

### How to Handle These Situations

1. **Rebasing Your Branch:**

   - **When:** If your branch is behind `main`, and you want to incorporate the latest changes from `main` into your branch.
   - **How:**
     ```bash
     git checkout your-branch
     git fetch origin
     git rebase origin/main
     ```
     - This re-applies your commits on top of the latest `main` branch commits, effectively bringing your branch up to date without creating a merge commit.
   - **Pros:** Keeps your history clean and linear, making it easier to follow.
   - **Cons:** If there are conflicts, you will need to resolve them during the rebase process.

2. **Merging `main` into Your Branch:**

   - **When:** If your branch is behind, but you prefer not to rebase, especially in a shared branch where history rewriting is undesirable.
   - **How:**
     ```bash
     git checkout your-branch
     git fetch origin
     git merge origin/main
     ```
   - **Pros:** Merges the latest changes into your branch and resolves conflicts at the time of merging.
   - **Cons:** Creates a merge commit, which can clutter your history.

3. **Syncing Regularly:**

   - **How:** Periodically merge or rebase your branch with `main` to minimize the divergence. This is particularly important in long-lived branches.
   - **Why:** It keeps your branch up to date and reduces the risk of conflicts later on.

4. **Creating a New Branch:**

   - **When:** If your branch is far behind and has diverged significantly, or if rebasing/merging becomes too complex.
   - **How:**
     - Create a new branch off `main`, then cherry-pick relevant commits from your old branch.
     - Alternatively, start fresh and manually port over your changes if they're not too extensive.
   - **Why:** This can simplify things if your branch history has become too tangled.

5. **Making Pull Requests:**
   - Before creating a PR, ensure your branch is not too far behind. Syncing with `main` ensures that your PR only contains the changes you've made, making it easier to review and integrate.

### Conclusion

Handling branches that are ahead and behind is crucial for maintaining a clean and conflict-free workflow. Regularly syncing your branches with `main`—either by merging or rebasing—helps keep your branch up-to-date and reduces the risk of conflicts. It's important to choose the method that fits your workflow, whether it's rebasing for a clean history or merging to preserve the commit history.
=======
## Git - template repo pull into new repo

https://stackoverflow.com/questions/37632568/git-template-repo-pull-into-new-repo

## Creating a repository from a template

https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-repository-from-a-template

https://github.com/docker-library/docs/tree/388783024e937bd87ee2f786fa308dc2ff123099/wordpress#how-to-use-this-image

# GitHub Markdown stuff

## Basic writing and formatting syntax

https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax#links

https://gist.github.com/rachelhyman/b1f109155c9dafffe618

https://gist.github.com/asabaylus/3071099#anchors-in-markdown

### GitHub Flavored Markdown Spec

https://github.github.com/gfm/

## How do I handle branches that are commits ahead and behind?

Branches that are "commits ahead" and "commits behind" indicate that they have diverged from the branch you're comparing them to, typically the `main` branch. Here's how to handle such branches and why it matters:

### Understanding "Commits Ahead" and "Commits Behind"

- **Commits Ahead:** This means the branch in question has commits that are not present in the branch you're comparing it to (e.g., `main`). These are new changes that haven't been merged yet.

- **Commits Behind:** This indicates that the branch you're working on does not have commits that are present in the branch you're comparing it to (e.g., `main`). This happens when new changes have been merged into `main` after your branch was created.

### Why It Matters

1. **Merge Conflicts:**

   - If your branch is both ahead and behind the `main` branch, there is a potential for merge conflicts when you eventually try to merge the branches. This is because the changes in both branches might conflict with each other.
   - Regularly syncing your branch with `main` helps reduce the likelihood of conflicts.

2. **Out-of-Date Features:**

   - If your branch is behind, you might be working with outdated code. This can lead to bugs or issues when merging, especially if critical updates have been made to the `main` branch.

3. **Clarity in Pull Requests:**
   - A branch that is significantly ahead or behind may make the PR more difficult to review because it will contain changes that are either already merged or irrelevant.

### How to Handle These Situations

1. **Rebasing Your Branch:**

   - **When:** If your branch is behind `main`, and you want to incorporate the latest changes from `main` into your branch.
   - **How:**
     ```bash
     git checkout your-branch
     git fetch origin
     git rebase origin/main
     ```
     - This re-applies your commits on top of the latest `main` branch commits, effectively bringing your branch up to date without creating a merge commit.
   - **Pros:** Keeps your history clean and linear, making it easier to follow.
   - **Cons:** If there are conflicts, you will need to resolve them during the rebase process.

2. **Merging `main` into Your Branch:**

   - **When:** If your branch is behind, but you prefer not to rebase, especially in a shared branch where history rewriting is undesirable.
   - **How:**
     ```bash
     git checkout your-branch
     git fetch origin
     git merge origin/main
     ```
   - **Pros:** Merges the latest changes into your branch and resolves conflicts at the time of merging.
   - **Cons:** Creates a merge commit, which can clutter your history.

3. **Syncing Regularly:**

   - **How:** Periodically merge or rebase your branch with `main` to minimize the divergence. This is particularly important in long-lived branches.
   - **Why:** It keeps your branch up to date and reduces the risk of conflicts later on.

4. **Creating a New Branch:**

   - **When:** If your branch is far behind and has diverged significantly, or if rebasing/merging becomes too complex.
   - **How:**
     - Create a new branch off `main`, then cherry-pick relevant commits from your old branch.
     - Alternatively, start fresh and manually port over your changes if they're not too extensive.
   - **Why:** This can simplify things if your branch history has become too tangled.

5. **Making Pull Requests:**
   - Before creating a PR, ensure your branch is not too far behind. Syncing with `main` ensures that your PR only contains the changes you've made, making it easier to review and integrate.

### Conclusion

Handling branches that are ahead and behind is crucial for maintaining a clean and conflict-free workflow. Regularly syncing your branches with `main`—either by merging or rebasing—helps keep your branch up-to-date and reduces the risk of conflicts. It's important to choose the method that fits your workflow, whether it's rebasing for a clean history or merging to preserve the commit history.
>>>>>>> main
