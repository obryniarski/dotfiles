
# swap two files
swap () {
    local TMPFILE=tmp.$$
    mv "$1" $TMPFILE && mv "$2" "$1" && mv $TMPFILE "$2"
}


function context_copy() {
    local target_dir="${1:-.}"
    if [ -d "$target_dir" ]; then
        fd . -e py -e md "$target_dir" -x cat {} | xclip -selection clipboard
        local abs_path=$(realpath "$target_dir")
        echo "Contents of files in '$abs_path' have been copied to the clipboard."
    else
        echo "Error: '$target_dir' is not a valid directory."
    fi
}

slicer_load() {
  local volume_path=$(realpath "$1")          # Convert volume path to absolute path
  shift  # Shift the first argument so that $@ now contains only the segmentation paths

  # Convert all segmentation paths to absolute paths
  local segmentation_paths=()
  for seg in "$@"; do
    segmentation_paths+=("$(realpath "$seg")")
  done

  # Build the Python code for loading the volume and segmentations
  local python_code="slicer.util.loadVolume('$volume_path');"

  # Add each segmentation to the Python code
  for seg_path in "${segmentation_paths[@]}"; do
    python_code+="slicer.util.loadSegmentation('$seg_path');"
  done

  python_code+="mainWindow = slicer.util.mainWindow(); mainWindow.show() if mainWindow else None"

  # Launch Slicer with the constructed Python code
  Slicer --no-splash --python-code "$python_code"
}
