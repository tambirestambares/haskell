{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}

module Handler.Oferta where

import Import
import Database.Persist.Postgresql

getOfertaR :: Handler Value
getOfertaR = do
    todasOfertas <- runDB $ selectList [] [Asc OfertaPais]
    sendStatusJSON ok200 (object ["resp" .= todasOfertas])