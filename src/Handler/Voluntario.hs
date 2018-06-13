{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}

module Handler.Voluntario where

import Import
import Database.Persist.Postgresql

getVoluntarioR :: Handler Value
getVoluntarioR = do
    todosVoluntarios <- runDB $ selectList [] [Asc VoluntarioNome]
    sendStatusJSON ok200 (object ["resp" .= todosVoluntarios])

