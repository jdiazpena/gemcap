# Gemini simulation configuration scripts


## Quick start (from scratch)

windows users: use WSL

1. install python3 (e.g. via miniconda)
2. `git clone https://github.com/gemini3d/gemini`
3. `python gemini/install_prereqs.py`
4. `pip install meson`
5. `cd gemini`
6. `python setup.py develop`
7. `meson build`  # puts stuff in ./build/
8. `meson test -C build`   # builds and runs several self-tests

now, setup your grid by running the `model_setup_*.m` script (from WSL if using Windows)
