docker-jekyll
=============

Run [jekyll](http://jekyllrb.com) in a [Docker](http://docker.io) container without installing [jekyll](http://jekyllrb.com) on your host system.

This is mainly intended for trying out [GitHub Pages](https://pages.github.com) locally before committing them.

How To Serve Existing GitHub Pages
----------------------------------

If you already have your [GitHub Pages](https://pages.github.com) checked out in a local directory `~/my-proj`, do the following:

1. Run the docker image with your [GitHub Pages](https://pages.github.com)
mapped to `/home/jekyll/doc-root`
    
    ```bash
    docker run -v ~/my-proj:/home/jekyll/doc-root -t -i fstab/jekyll
    ```
    
    or, if you are using `boot2docker`
    
    ```bash
    docker run -v ~/my-proj:/home/jekyll/doc-root -p4000:4000 -t -i fstab/jekyll
    ```
    
2. Go to the `doc-root` directory
    
    ```bash
    cd /home/jekyll/doc-root
    ```
    
3. Update jekyll.
    
    If you have a `Gemfile` in your [GitHub Pages](https://pages.github.com), run
    
    ```bash
    sudo bundle update
    ```
    
    If you don't use `Gemfile`, run
    
    ```bash
    sudo gem update github-pages
    ```
    
4. Serve your project
    
    ```bash
    jekyll serve --host=0.0.0.0 --watch
    ```

You can access the jekyll pages on the docker container's IP address, port 4000, or on boot2docker's IP address, port 4000.

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
    
5. Serve with `jekyll serve` as described above.

Build from Source
-----------------

1. Make sure [Docker](https://www.docker.com) is installed.
2. Clone [fstab/docker-mutt](https://github.com/fstab/docker-mutt) from GitHub.
   
   ```bash
   git clone https://github.com/fstab/docker-mutt.git
   ```
3. Build the docker image
   
   ```bash
   cd docker-mutt
   docker build -t="fstab/mutt" .
   ```
   
4. Once the configuration is is created _on the host system_, the docker container can be run as follows:
   
   ```bash
   docker run -v ~/.mutt:/home/mutt -t -i fstab/mutt
   ```
