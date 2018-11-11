rsync -a ~ \
      --exclude=Android \
      --exclude=Applications \
      remote-machine:backup/
