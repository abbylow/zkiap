pragma circom 2.1.4;

include "circomlib/poseidon.circom";

// Simple zkSNARK signature scheme

// KeyGen
template SecretToPublic() {
    signal input sk;
    signal output pk;
    
    component poseidon = Poseidon(1);
    poseidon.inputs[0] <== sk;
    pk <== poseidon.out;
}

template Sign() {
    // the message is never constrained; this does not break soundness! You can see more details at https://geometry.xyz/notebook/groth16-malleability
    signal input m;
    signal input sk;
    signal input pk;

    // verify prover knows correct sk
    component checker = SecretToPublic();
    checker.sk <== sk;
    pk === checker.pk;
}

// You need to verify the proof along with the public inputs of pk and m to verify this zkSNARK signature.
component main { public [ pk, m ] } = Sign();

/* INPUT = {
    "sk": "5",
    "pk": "19065150524771031435284970883882288895168425523179566388456001105768498065277",
    "m": "8765432"
} */