circom multiplier2.circom --r1cs --wasm --sym --c
echo "Generating witness..."
node multiplier2_js/generate_witness.js multiplier2_js/multiplier2.wasm input.json witness.wtns
echo "Start new power of tau ceremony.."
snarkjs powersoftau new bn128 12 pot12_0000.ptau -v
echo "contribute to the ceremony.."
snarkjs powersoftau contribute pot12_0000.ptau pot12_0001.ptau --name="First contribution" -v
echo "phase 2 started..."
snarkjs powersoftau prepare phase2 pot12_0001.ptau pot12_final.ptau -v
echo "Generating proving key and verification key...."
snarkjs groth16 setup multiplier2.r1cs pot12_final.ptau multiplier2_0000.zkey
echo "Contribute to the phase 2 of the ceremony"
snarkjs zkey contribute multiplier2_0000.zkey multiplier2_0001.zkey --name="1st Contributor Name" -v
echo "Export the verification key"
snarkjs zkey export verificationkey multiplier2_0001.zkey verification_key.json
echo "Generating a Proof"
snarkjs groth16 prove multiplier2_0001.zkey witness.wtns proof.json public.json
echo "Verify..."
snarkjs groth16 verify verification_key.json public.json proof.json
