{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}

module Handler.Host where

import Import
import Database.Persist.Postgresql

getHostR :: Handler Value
getHostR = do
    todosHost <- runDB $ selectList [] [Asc HostNome]
    sendStatusJSON ok200 (object ["resp" .= todosHost])

postHostR :: Handler Value
postHostR = do
    newHost <- requireJsonBody :: Handler Host
    hid <- runDB $ insert newHost
    sendStatusJSON created201 (object ["resp" .= fromSqlKey hid])

putHostIdR :: HostId -> Handler Value
putHostIdR hid = do
    _ <- runDB $ get404 hid
    novoHost <- requireJsonBody :: Handler Host
    runDB $ replace hid novoHost
    sendStatusJSON noContent204 (object [])