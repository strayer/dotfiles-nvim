update:
    git pull
    nvim --headless "+Lazy! restore" +qa

upgrade:
    nvim --headless "+Lazy! update" +qa
    git add lazy-lock.json
    git commit -m "chore: update plugins"
    git push
