# Sword as a Service

This is a REST API for compiling Sword contracts.

It has one endpoint:

```
POST /compile
Body: { "contract": "transfer(USD, 'pos0')", "blockchain": "EVM" }
Return value: { "bytecode": <bytecode with placeholders>, "partyCount": 1 }
```

The REST service accepts Sword contracts and returns a hex-encoded bytecode of
a contract containing `#1#`, `#2#`, etc. as placeholder values for party token
addresses, as well as the number of parties in the compiled contract.

Performing substitution of each placeholder should yield a correct contract.
