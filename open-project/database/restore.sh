#!/bin/bash

# https://www.openproject.org/docs/installation-and-operations/operation/restoring/

BACKUP_FILES=()
BACKUP_SELECTED=
MSG_BACKUP_LIST_EMPTY="There no backups to recover from."
MSG_BACKUP_LISTINGS="List of available backups to restore:"
MSG_SELECTION_PROMT_DONT_EXIST="The selected option does not exist, please select one of the available options..."
MSG_SELECTION_PROMT_SELECTION="You selected:"
MSG_SELECTION_PROMT="Please insert the number of the backup you want to recover: "


# --------------------------------------------------------------------------------
backup_get() {
  lastvalue=
  for file in backups/*
  do
    basename=$(basename "$file")
    filename=$basename
    filename=${filename%-opdata*}
    filename=${filename%-pgdata*}

    if ! [ "$filename" = "$lastvalue" ]
    then
      lastvalue=$filename
      BACKUP_FILES+=($filename)
    fi
  done
}

backup_list() {
  if [ ${#BACKUP_FILES[@]} -eq 0 ]
  then
    echo $MSG_BACKUP_LIST_EMPTY
  else
    echo $MSG_BACKUP_LISTINGS
    for index in "${!BACKUP_FILES[@]}"
    do
      echo "$(($index + 1)). ${BACKUP_FILES[$index]}"
    done
    echo ""
  fi
}

backup_selection() {
  mainloop=true
  while [ $mainloop = true ]
  do
    read -p "$MSG_SELECTION_PROMT" selection
    if [[ ${BACKUP_FILES[$selection - 1]} ]] && \
       [ $selection -gt 0 ] && ! [ -z "$selection" ]
    then
      BACKUP_SELECTED=$((selection - 1))
      mainloop=false
      echo "$MSG_SELECTION_PROMT_SELECTION ${BACKUP_FILES[$BACKUP_SELECTED]}"
    else
      printf "${MSG_SELECTION_PROMT_DONT_EXIST}\n\n"
    fi
  done
}

backup_restore() {
  # docker stop openproject-web
  echo "backups/${BACKUP_FILES[$BACKUP_SELECTED]}-pgdata.tar.gz"
  echo "backups/${BACKUP_FILES[$BACKUP_SELECTED]}-opdata.tar.gz"
  docker exec -i openproject-backup /control/script-restore.sh ${BACKUP_FILES[$BACKUP_SELECTED]}
}


# --------------------------------------------------------------------------------
backup_get
backup_list
backup_selection
backup_restore
