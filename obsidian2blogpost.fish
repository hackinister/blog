#!/usr/bin/env fish

set SCRIPT_DIR (realpath (status filename | string collect)):h
echo "$SCRIPT_DIR"

set sourcePath "/home/ctimm/Documents/⚛️ Areas/Blog/posts"
set destinationPath "/home/ctimm/Development/Blog/content/posts"

set myrepo "blog"

for cmd in git rsync python3 hugo
  if not type -q $cmd
    echo "$cmd ist nicht installiert oder nicht im PATH."
    exit 1
  end
end

if not test -d ".git"
  echo "Initialisiere Git Repository..."
  git init
  git remote add origin $myrepo
else
  echo "Git Repository bereits initialisert."
  if not git remote | grep -q 'origin'
    echo "Füge Remote origin hinzu..."
    git remote add origin $myrepo
  end
end

echo "Synchronisiere Posts von Obsidian..."

if not test -d "$sourcePath"
  echo "Quellpfad existiert nicht: $sourcePath"
  exit 1
end

if not test -d "$destinationPath"
  echo "Zielpfad existiert nicht: $destinationPath"
  exit 1
end

if not rsync -av --delete "$sourcePath/" "$destinationPath/"
  echo "Rsync fehlgeschlagen."
  exit 1
end

echo "Verarbeite Bild-Links in Markdown Dateine..."

if not test -f "images.py"
  echo "Python script images.py nicht gefunden."
  exit 1
end

if not python3 images.py
  echo "Verabeitung der Bild-Links fehlgeschlagen."
  exit 1
end

echo "Erstelle WebPage mit Hugo..."

if not hugo
  echo "Hugo Build fehlgeschlagen."
  exit 1
end

echo "Stage Änderungen für Git..."

if not git diff --quiet; or not git diff --cached --quiet
  git add .
else
  echo "Keine Änderungen zum Stagen."
end

set current_date (date +'%Y-%m-%d %H:%M:%S')
set commit_message "New Blog Post on $current_date"

if not git diff --cached --quiet
  echo "Committe Änderungen..."
  git commit -m "$commit_message"
else
  echo "Keine Änderungen zum Committen."
end

echo "Deploying to Github Main..."
if not git push origin main
  echo "Push zum Main Branch fehlgeschlagen."
  exit 1
end

echo "Alles erledigt!"


