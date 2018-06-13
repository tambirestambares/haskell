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

getOfertaIdR :: OfertaId -> Handler Value
getOfertaIdR oid = do 
    oferta <- runDB $ get404 oid
    sendStatusJSON ok200 (object ["resp" .= oferta])
    
putOfertaIdR :: OfertaId -> Handler Value
putOfertaIdR oid = do
    _ <- runDB $ get404 oid
    novaOferta <- requireJsonBody :: Handler Oferta
    runDB $ replace oid novaOferta
    sendStatusJSON noContent204 (object [])

