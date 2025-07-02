function setcuda --description "Set CUDA_VISIBLE_DEVICES"
    if test (count $argv) -ne 1
        echo "Usage: setcuda <GPU_ID>"
        echo "Example: setcuda 0,1"
        return 1
    end
    set -x CUDA_VISIBLE_DEVICES "$argv[1]"
    echo "CUDA_VISIBLE_DEVICES set to $CUDA_VISIBLE_DEVICES"
end
