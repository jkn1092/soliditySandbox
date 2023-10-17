1. from this contract into memory
2. EXTCODECOPY
3. {
   // Define storage slots for the two values
   let a := 0x07
   let b := 0x08

   // Add the values
   let result := add(a, b)

   // Store the result in the next free memory slot
   mstore(0x40, result)
   }
4. 