{-# LINE 1 "HsFoo.hsc" #-}
{-# LANGUAGE ForeignFunctionInterface #-}
{-# LANGUAGE CPP                      #-}

module HsFoo where

import Foreign
import Foreign.C

import Control.Applicative
import Control.Monad



data Foo = Foo { 
    a :: CString
  , b :: CString
  , c :: Int
} deriving Show

instance Storable Foo where
    sizeOf    _ = (24)
{-# LINE 22 "HsFoo.hsc" #-}
    alignment _ = alignment (undefined :: CString)

    poke p foo = do
        (\hsc_ptr -> pokeByteOff hsc_ptr 0) p $ a foo
{-# LINE 26 "HsFoo.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 8) p $ b foo
{-# LINE 27 "HsFoo.hsc" #-}
        (\hsc_ptr -> pokeByteOff hsc_ptr 16) p $ c foo
{-# LINE 28 "HsFoo.hsc" #-}

    peek p = return Foo
              `ap` ((\hsc_ptr -> peekByteOff hsc_ptr 0) p)
{-# LINE 31 "HsFoo.hsc" #-}
              `ap` ((\hsc_ptr -> peekByteOff hsc_ptr 8) p)
{-# LINE 32 "HsFoo.hsc" #-}
              `ap` ((\hsc_ptr -> peekByteOff hsc_ptr 16) p)
{-# LINE 33 "HsFoo.hsc" #-}

foreign export ccall "free_HaskellPtr" free :: Ptr a -> IO ()
foreign export ccall "setFoo" setFoo :: Ptr Foo -> IO ()
setFoo :: Ptr Foo -> IO ()
setFoo f = do
  newA <- newCString "abc"
  newB <- newCString "def"
  poke f $ Foo newA newB 3
  return ()

