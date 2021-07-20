#The code version upgrade and correction based on stackoverflow

1. As per the Solidity v0.5.0 breaking changes
Explicit function visibility is now mandatory. Add public to every function and constructor, and external to every fallback or interface function that does not specify its visibility already.
The function are missign visible specifier. Regarding the data location, it says: Explicit data location for all variables of struct, array or mapping types is now mandatory. This also applied to function parameters and return variables. When they mention array, it also applies on bytes and string. Make the related changes and erros will be gone.

2. Before version 0.5.0 by default sets format parameters to Memory. Now in 0.5.0, you need to mention if its memory or storage variable.