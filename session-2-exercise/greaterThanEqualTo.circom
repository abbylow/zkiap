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

template GreaterEqThan(n) {
    signal input in[2];
    signal output out;

    component lt = LessThan(n);

    lt.in[0] <== in[1];
    lt.in[1] <== in[0]+1;
    lt.out ==> out;
}

component main = GreaterEqThan(2);

/* INPUT = {
    "in": ["2","3"]
} */