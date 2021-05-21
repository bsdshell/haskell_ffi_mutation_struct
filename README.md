### Fri 21 May 15:14:08 2021 
### Use hsc2hs to simplify FFI
### Read Struct from C file, and mutation the struct inside Haskell
<https://stackoverflow.com/questions/30474224/hsc2hs-mutate-a-c-struct-with-haskell SO>

```shell
$ hsc2hs HsFoo.hsc
$ ghc -c HsFoo.hs foo.c
$ ghc -no-hs-main foo.c HsFoo.o main.c -o main
$ ./main
```
