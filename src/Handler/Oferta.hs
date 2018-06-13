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

postOfertaR :: Handler Value
postOfertaR = do
    oferta <- requireJsonBody :: Handler Oferta
    oid <- runDB $ insert oferta
    sendStatusJSON created201 (object ["resp" .= fromSqlKey oid])

