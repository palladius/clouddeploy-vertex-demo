

source .envrc

set -euo pipefail

wget https://storage.googleapis.com/download.tensorflow.org/example_images/flower_photos.tgz
tar xvzf flower_photos.tgz

gsutil -m cp -r flower_photos "$GS_BUCKET"
