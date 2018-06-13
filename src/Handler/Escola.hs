{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Escola where

import Import
import Database.Persist.Postgresql

getEscolaR :: Handler Value
getEscolaR = do
    todasEscolas <- runDB $ selectList [] [Asc EscolaNome]
    sendStatusJSON ok200 (object ["escola" .= todasEscolas])