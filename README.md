# Setup Instructions

First, download and install [Git](http://git-scm.com/downloads).

Then, clone the repository to a working directory of your choice.

```
git clone --recursive https://github.com/RichardVSaasbook
```

Finally, build DWT.

```
cd src\dwt
rdmd build base swt
```

# Running the Code

First, build the code by typing `build-win` while in the working directory. If everything builds
correctly, there should be no errors from the output.

You can then run the executable by typing `phase3`.

# Pushing to the Repository

First, while in your working directory, type `git status` to check the status of the repository.

For any files under the heading that says "Untracked files", type `git add *filename*`.

After the files have been added, type `git commit -am "*message*"` where *message* is a descriptive
message of your choice that gives an overview of the changes made.

Finally, push your changes to the repository by typing `git push origin master`.

# Pulling from the Repository

If your local code is not up to date, you may get the latest version by typing `git pull`.

# Helpful Links

[SWT Javadocs](http://www.eclipse.org/swt/javadoc.php)
[GIT Reference Guide](http://git-scm.com/book/en/)
[D Language Reference](http://dlang.org/spec.html)
[D Library Reference](http://dlang.org/phobos/index.html)
