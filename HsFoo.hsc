{-# LANGUAGE ForeignFunctionInterface #-}
{-# LANGUAGE CPP                      #-}

module HsFoo where

import Foreign
import Foreign.C

import Control.Applicative
import Control.Monad

#include "foo.h"

data Foo = Foo { 
    a :: CString
  , b :: CString
  , c :: Int
} deriving Show

instance Storable Foo where
    sizeOf    _ = #{size foo}
    alignment _ = alignment (undefined :: CString)

    poke p foo = do
        #{poke foo, a} p $ a foo
        #{poke foo, b} p $ b foo
        #{poke foo, c} p $ c foo

    peek p = return Foo
              `ap` (#{peek foo, a} p)
              `ap` (#{peek foo, b} p)
              `ap` (#{peek foo, c} p)

foreign export ccall "free_HaskellPtr" free :: Ptr a -> IO ()
foreign export ccall "setFoo" setFoo :: Ptr Foo -> IO ()
setFoo :: Ptr Foo -> IO ()
setFoo f = do
  newA <- newCString "abc"
  newB <- newCString "def"
  poke f $ Foo newA newB 3
  return ()

