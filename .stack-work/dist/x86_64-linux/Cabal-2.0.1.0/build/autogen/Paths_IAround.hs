{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -fno-warn-implicit-prelude #-}
module Paths_IAround (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/ubuntu/workspace/IAround/.stack-work/install/x86_64-linux/lts-11.10/8.2.2/bin"
libdir     = "/home/ubuntu/workspace/IAround/.stack-work/install/x86_64-linux/lts-11.10/8.2.2/lib/x86_64-linux-ghc-8.2.2/IAround-0.0.0-AElcV79WSJ1Etv0ISvDaRH"
dynlibdir  = "/home/ubuntu/workspace/IAround/.stack-work/install/x86_64-linux/lts-11.10/8.2.2/lib/x86_64-linux-ghc-8.2.2"
datadir    = "/home/ubuntu/workspace/IAround/.stack-work/install/x86_64-linux/lts-11.10/8.2.2/share/x86_64-linux-ghc-8.2.2/IAround-0.0.0"
libexecdir = "/home/ubuntu/workspace/IAround/.stack-work/install/x86_64-linux/lts-11.10/8.2.2/libexec/x86_64-linux-ghc-8.2.2/IAround-0.0.0"
sysconfdir = "/home/ubuntu/workspace/IAround/.stack-work/install/x86_64-linux/lts-11.10/8.2.2/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "IAround_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "IAround_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "IAround_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "IAround_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "IAround_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "IAround_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
