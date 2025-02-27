
# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba init' !!
set -gx MAMBA_EXE "/nix/store/s1j61dvwsid2n8rz5c4h69zpl6cqy24g-micromamba-1.5.8/bin/micromamba"
set -gx MAMBA_ROOT_PREFIX "/data/liuhuijie/.micromamba/"
$MAMBA_EXE shell hook --shell fish --root-prefix $MAMBA_ROOT_PREFIX | source
# <<< mamba initialize <<<
