// hw5/circuits/deposit_circuit/src/main.nr

use std::hash::pedersen_hash;
use std::merkle::compute_merkle_root;


fn main(
    id: Field,
    r: Field,
    oldPath: [Field; 8],
    oldRoot: Field,
    newRoot: Field,
    commitment: Field,
    index: Field
) {
    // 1) commitment == pedersen(id, r)
    assert(commitment == pedersen_hash([id, r]));

    // 2) computedRoot = merkle_update(...)
    let computedRoot: Field = compute_merkle_root(commitment, index, oldPath);
    assert(computedRoot == newRoot);

    // 3) merkle_root(oldPath) == oldRoot
    assert(compute_merkle_root(0x18d85f3de6dcd78b6ffbf5d8374433a5528d8e3bf2100df0b7bb43a4c59ebd63, index, oldPath) == oldRoot);
}