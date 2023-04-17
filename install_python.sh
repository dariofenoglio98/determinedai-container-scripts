#!/usr/bin/env bash

set -x
set -e

PYTHON_VERSION=${1}

CONDA_DIR="/opt/conda"
CONDA_INSTALLER="Miniconda3-py39_4.12.0-Linux-x86_64.sh"
CONDA_MD5="7843dd7d0a2c53b0df37ca8189672992"
CONDA_URL="https://mirrors.bfsu.edu.cn/anaconda/miniconda/"

mkdir -p /etc/determined/conda.d
mkdir -p "${CONDA_DIR}"

cd /tmp
curl --retry 3 -fsSL -O "${CONDA_URL}/${CONDA_INSTALLER}"
echo "${CONDA_MD5}  ${CONDA_INSTALLER}" | md5sum -c -
bash "./${CONDA_INSTALLER}" -u -b -p "${CONDA_DIR}"
rm -f "./${CONDA_INSTALLER}"

conda install python=${PYTHON_VERSION}
conda update --prefix ${CONDA_DIR} --all -y
conda clean --all -f -y
