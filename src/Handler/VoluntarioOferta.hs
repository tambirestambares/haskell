{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.VoluntarioOferta where

import Import
import Database.Persist.Postgresql
import Data.Map.Strict (elems)

getVoluntarioOfertaR :: Handler Value
getVoluntarioOfertaR = do
    todasOfertasV <- runDB $ selectList [] [Asc VoluntarioOfertaInicio]
    sendStatusJSON ok200 (object ["resp" .= todasOfertasV])
