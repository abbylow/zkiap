pragma circom 2.1.2;

template Num2Bits(n) {
    signal input in;
    signal output out[n];
    var lc1=0;

    var e2=1;
    for (var i = 0; i<n; i++) {
        out[i] <-- (in >> i) & 1;
        out[i] * (out[i] -1 ) === 0;
        lc1 += out[i] * e2;
        e2 = e2+e2;
    }

    lc1 === in;
}

template LessThan(n) {
    //  the input signals are at most 2^k - 1 (k ≤ 252)
    assert(n <= 252);
    signal input in[2];
    signal output out;

    component n2b = Num2Bits(n+1);

    // change in[0]'s most significant bit to 1 
    n2b.in <== in[0] + (1<<n) - in[1];

    out <== 1-n2b.out[n];    
}

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

template CalculateTotal(n) {
    signal input in[n];
    signal output out;

    signal sums[n];

    sums[0] <== in[0];

    for (var i = 1; i < n; i++) {
        sums[i] <== sums[i-1] + in[i];
    }

    out <== sums[n-1];
}


template Selector(nChoices) {
    signal input in[nChoices];
    signal input index;
    signal output out;

    // Ensure that index < choices
    component lt = LessThan(4); // assume the nChoices is at most 2^4-1
    lt.in[0] <== index;
    lt.in[1] <== nChoices;
    lt.out === 1;

    component calcTotal = CalculateTotal(nChoices);
    component eqs[nChoices];
    // For each item, check whether its index equals the input index.
    for(var i = 0; i < nChoices; i++) {
        eqs[i] = IsEqual();
        eqs[i].in[0] <== i;
        eqs[i].in[1] <== index;

        // eqs[i].out is 1 if the index matches
        // if not match then the item will be zero
        calcTotal.in[i] <== eqs[i].out * in[i];
    }

    out <== calcTotal.out;
}

component main = Selector(4);

/* INPUT = {
    "in": ["1","2", "3", "4"],
    "index": "1"
} */