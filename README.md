docker-jekyll
=============

Run [jekyll](http://jekyllrb.com) in a [Docker](http://docker.io) container without installing [jekyll](http://jekyllrb.com) on your host system.

This is mainly intended for trying out [GitHub Pages](https://pages.github.com) locally before committing them.

How To Serve Existing GitHub Pages
----------------------------------

If you already have your [GitHub Pages](https://pages.github.com) checked out in a local directory `~/my-proj`, do the following:

```bash
    docker run -v $(pwd):/home/jekyll/doc-root -P --expose 4000 -t -i jekyll:latest bash -c 'cd /home/jekyll/doc-root; sudo bundle update; jekyll serve --host=0.0.0.0'
```

If you are using the `bash` shell, you can create an alias for that line like this:

```bash
alias jekyll="docker run -v $(pwd):/home/jekyll/doc-root -P --expose 4000 -t -i jekyll:latest bash -c 'cd /home/jekyll/doc-root; sudo bundle update; jekyll serve --host=0.0.0.0'"
```

Now, the whole thing can be run as

```bash
jekyll
```

How To Create New GitHub Pages
------------------------------

1. Start the Docker container and go to `/home/jekyll/doc-root` as described above.
    
2. Generate a new jekyll site
    
    ```bash
    jekyll new ~/doc-root
    ```
    
3. Create a file called `Gemfile` with the following content:
    
    ```
    source 'https://rubygems.org'
    gem 'github-pages'
    ```
    
4. Update
    
    ```
    sudo bundle update
    ```
5. Add the following line to the end of the generated `_config.yml` to stop Jekyll including the `Gemfile` in it’s site.
    
    ```
    exclude: ['Gemfile','Gemfile.lock']
    ```
    
5. Serve your project, as described above

Building the Docker Image from Source
-------------------------------------

1. Make sure [Docker](https://www.docker.com) is installed.
    
2. Clone [webdev-docker-env](https://github.com/oicr-webdev/webdev-docker-env.git) from GitHub.
    
    ```bash
    git clone https://github.com/oicr-webdev/webdev-docker-env.git
    ```
    
3. Build the docker image
    
    ```bash
    cd webdev-docker-env/docker-jekyll
    docker build -t jekyll:docker .
    ```
