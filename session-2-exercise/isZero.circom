pragma circom 2.1.2;

template IsZero () {
    signal input in;
    signal output out;

    // if the input is not zero, there must be an inverse and (in * inv = 1)
    signal inv;

    inv <-- in != 0 ? 1/in : 0;

    out <-- -(in*inv) + 1;
    
    0 === in * out;

}

component main = IsZero();

/* INPUT = {
    "in": "0"
} */