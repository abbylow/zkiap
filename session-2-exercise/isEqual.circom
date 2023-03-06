pragma circom 2.1.2;

include "circomlib/poseidon.circom";
// include "https://github.com/0xPARC/circom-secp256k1/blob/master/circuits/bigint.circom";

template IsZero () {
    signal input in;
    signal output out;

    // if the input is not zero, there must be an inverse and (in * inv = 1)
    signal inv;

    inv <-- in != 0 ? 1/in : 0;

    out <-- -(in*inv) + 1;
    
    0 === in * out;

}

template IsEqual () {
    signal input in[2];
    signal output out;

    component isZ = IsZero();

    isZ.in <== in[0] - in[1];

    out <== isZ.out;
    
}

component main = IsEqual();

/* INPUT = {
    "in": ["1", "-3"]
} */