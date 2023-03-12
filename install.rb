#!/usr/bin/env ruby

require "fileutils"

def mkdir(dir)
  if ! Dir.exists?(dir)
    print "Creating directory '%s'...\n" % dir
    Dir.mkdir(dir)
  else
    print "Directory '%s' already exists, skipping...\n" % dir
  end
end

def link(source, dest)
  if ! File.exists?(dest)
    print "Linked '%s' to '%s'...\n" % [ source, dest ]

    system("ln", "-s", source, dest)
  else
    print "Link '%s' already exists, skipping...\n" % dest
  end
end

def update_plugins()
  system("curl", "-LSso", "git-layer", "https://raw.githubusercontent.com/frison/git-layer/main/git-layer")

  system("sh git-layer --apply")
end

def infect(targets)
  pg = "pathogen.vim"

  system("curl", "-LSso", pg, "https://tpo.pe/%s" % pg)

  targets.each do |target|
    al = File.join(target, "autoload")

    mkdir(al)

    link(File.join(Dir.pwd, pg), File.join(al, pg))
  end
end

update_plugins()

vimdir = File.join(Dir.home, ".vim")
nvimdir = File.join(Dir.home, ".config", "nvim")

mkdir(vimdir)
mkdir(nvimdir)

infect([ vimdir, nvimdir ])

paths = {
  "init.vim" => [ File.join(Dir.home, ".vimrc"), File.join(nvimdir, "init.vim") ],
  "ginit.vim" => [ File.join(nvimdir, "ginit.vim") ],
  "tmux.conf" => [ File.join(Dir.home, ".tmux.conf") ],
  "bundle" => [ File.join(vimdir, "bundle"), File.join(nvimdir, "bundle") ],
  "colors" => [ File.join(vimdir, "colors"), File.join(nvimdir, "colors") ]
}

paths.keys.each do |source|
  paths[source].each do |dest|
    link(File.join(Dir.pwd, source), dest)
  end
end
