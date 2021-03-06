wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh  --no-check-certificate --quiet -O miniconda.sh
bash miniconda.sh -b -p /opt/conda
rm miniconda.sh

export PATH="/opt/conda/bin:$PATH"
conda config --set always_yes yes --set changeps1 no
conda create -q -n docker-environment python=3.5
source activate docker-environment

conda config --add channels conda-forge  # rtree, shapely, pyembree
conda config --add channels menpo        # cyassimp

# some trimesh ops are 2-3x slower with MKL
conda install nomkl

# cyassimp is a much faster binding for the assimp importers
# they use non- standard labels, master vs main
conda install -c menpo/label/master cyassimp

# scikit-image is used for marching cubes
conda install -c conda-forge scikit-image

# pyembree is used for fast ray tests
conda install -c conda-forge pyembree

# install most trimesh requirements with built components 
conda install -c conda-forge shapely rtree numpy scipy

# remove archives
conda clean --all -y
