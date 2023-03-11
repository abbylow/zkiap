pragma circom 2.1.4;

include "circomlib/poseidon.circom";

// Simple Group Signature

// KeyGen
template SecretToPublic() {
    signal input sk;
    signal output pk;
    
    component poseidon = Poseidon(1);
    poseidon.inputs[0] <== sk;
    pk <== poseidon.out;
}

template GroupSign(n) {
    signal input sk;
    signal input pk[n];
    
    // even though m is not involved in the circuit, 
    // it is still constrained and cannot be 
    // changed after it is set.
    signal input m; 

    // get the public key
    component computePk = SecretToPublic();
    computePk.sk <== sk;

    // make sure computedPk is in the inputted group
    signal zeroChecker[n+1];
    zeroChecker[0] <== 1;
    for (var i = 0; i < n; i++) {
        zeroChecker[i+1] <== zeroChecker[i] * (pk[i] - computePk.pk);
    }
    zeroChecker[n] === 0;
}

// You need to verify the proof along with the public inputs of pk and m to verify this zkSNARK signature.
component main = GroupSign(3);

/* INPUT = {
    "sk": "1",
    "pk": ["19065150524771031435284970883882288895168425523179566388456001105768498065277", "17064854037562012747959882209803135369966977028940686905541119837393082414095", "18586133768512220936620570745912940619677854269274689475585506675881198879027"],
    "m": "98765432"
} */