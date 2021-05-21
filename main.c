#include <stdio.h>
#include <stdlib.h>
#include "HsFoo_stub.h"
#include "foo.h"

int main(int argc, char *argv[]) {  
  hs_init(&argc, &argv);

  foo *f;
  f = malloc(sizeof(foo));
  f->a = "Hello";
  f->b = "World";
  f->c = 55555; 

  printf("foo has been set in C:\n  a: %s\n  b: %s\n  c: %d\n",f->a,f->b,f->c);

  setFoo(f);

  printf("foo has been set in Haskell:\n  a: %s\n  b: %s\n  c: %d\n",f->a,f->b,f->c);

  free_HaskellPtr(f->a);
  free_HaskellPtr(f->b);
  free(f);
  hs_exit();
}

